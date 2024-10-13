#include "kukagamecontrol.h"


KUKAGameControl::KUKAGameControl() {
    // ESP TCP socket connects
    connect(&_socketESPCAM, SIGNAL(readyRead()), this, SLOT(onReadyReadESPCAM()));
    connect(&_socketESP32DCMotor, SIGNAL(readyRead()), this, SLOT(onReadyReadESP32DCMotor()));

    // KUKA robot configs
    tcp_robot = new kukavarproxy_msg_format("192.168.10.254", 7000, 3000);

    connect(tcp_robot, &kukavarproxy_msg_format::msgReceived, this, &KUKAGameControl::robotMessageReceived);

    // ESP's IP
    ESPCAM_IP = "192.168.10.154";
    ESP32_IP = "192.168.10.54";

    releaseBallOrGrabCup = "grab";

    m_timer = new QTimer(this);
    connect(m_timer, &QTimer::timeout, this, &KUKAGameControl::restartGetImg);

    m_uImage = new QTimer(this);
    connect(m_uImage, &QTimer::timeout, this, &KUKAGameControl::gameRestart);
//    connect(m_uImage, &QTimer::timeout, this, &KUKAGameControl::updateImageQML);

}

void KUKAGameControl::startGame() {
    reasonToFailGame = "";
    didGameFailed = "no";

    tcp_robot->writeValueToRobot("ALBERTO_INFO", "{COMMAND 1, CUP_NUM 0, DELIVER_NUM 0, X_OFFSET 0, Y_OFFSET 0, ANGLE_OFFSET 0}", 43981);

    waitForRobotToFinish(1);

    QThread::msleep(1000);

    getImageAndSendToPython("calibration");

}

void KUKAGameControl::updateImageQML()
{

}


void KUKAGameControl::waitForRobotToFinish(int step) {
    QThread::msleep(1000);

    checkRobotCurrentStep = true;

    QElapsedTimer timer;
    timer.start();

    while(robotCurrentStep != step) {
        tcp_robot->readValueToRobot("ALBERTO_STEP", 43981);
        QThread::msleep(1000);

    }
    checkRobotCurrentStep = false;
}


void KUKAGameControl::getImageAndSendToPython(QString whatToAnalyze) {
    dataFromESPCAM.clear();

    _socketESPCAM.connectToHost(QHostAddress(ESPCAM_IP), 80);

    _socketESPCAM.write(QByteArray("get_img"));
    qDebug() << "get_img";

    imgToGet = whatToAnalyze;

    // activate timer
    m_timer->start(12000);
}


void KUKAGameControl::restartGetImg() {
    m_timer->stop();
    getImageAndSendToPython(imgToGet);
}


void KUKAGameControl::onReadyReadESPCAM() {
    QByteArray datas = _socketESPCAM.readAll();
    dataFromESPCAM.append(datas);

    if(datas.contains("tx_complete")) {
        //qDebug() << "tx_complete found";
        dataFromESPCAM.replace("tx_complete", "");

        m_timer->stop();
        finishedReceivingImg();
    }
    else {
        //qDebug() << " espcam response error in retriving img, retrying...";
        //getImageAndSendToPython(imgToGet);
    }
}


void KUKAGameControl::finishedReceivingImg() {
    // fill array with image
    if(ESPCAM_IMG.loadFromData(dataFromESPCAM,"JPEG")) {

        emit sendImgToMain();
        QImage image = ESPCAM_IMG.toImage();
        emit newImage(image);
        int pixmapHight = ESPCAM_IMG.height();
        int pixmapWidth = ESPCAM_IMG.width();

        qDebug() << "displaying img of shape: " << pixmapWidth << "x" << pixmapHight;
        hasImg = true;

        if(imgToGet == "calibration") {
            qDebug() << "GET BASE CALIBRATION PYTHON";
            Python_getCalibration();
        }
        else if(imgToGet == "roulette") {
            qDebug() << "GET ROULETTE NUMBER AND BALL OFFSET PYTHON";
            Python_GetRouletteNumberAndBall();
        }
        else if(imgToGet == "cup_delivery") {
            qDebug() << "GET CUP DELIVERY PYTHON";
            Python_GetCupDelivery();
        }

    }
    else {
        qDebug() << "couldnt get img, retrying...";
        hasImg = false;
        getImageAndSendToPython(imgToGet);
    }
}


void KUKAGameControl::Python_getCalibration() {
    QByteArray res;
    QBuffer buffer(&res);
    buffer.open( QIODevice::WriteOnly);
    ESPCAM_IMG.save( &buffer, "PNG" );

    // send img to flask
    QNetworkAccessManager *mgr = new QNetworkAccessManager(this);
    const QUrl url(QStringLiteral("http://127.0.0.1:9000/post_calibrate_img"));
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject obj;
    obj["img"] = QString(res.toBase64());
    obj["type"] = QString(robotZToPython);

    QJsonDocument doc(obj);
    QByteArray data = doc.toJson();

    reply = mgr->post(request, data);

    QObject::connect(reply, &QNetworkReply::finished, this, &KUKAGameControl::onReadyReadCalibrateImg);
}


void KUKAGameControl::onReadyReadCalibrateImg() {
    if(reply->error() == QNetworkReply::NoError) {

        pythonFailCount = 0;

        QString strReply = (QString)reply->readAll();

        QJsonDocument jsonResponse = QJsonDocument::fromJson(strReply.toUtf8());
        QJsonObject jsonObj = jsonResponse.object();

        QString IMG = jsonObj["IMG"].toString();
        QByteArray IMG_ARR = IMG.toUtf8();

        QPixmap imageFromPython;
        imageFromPython.loadFromData(QByteArray::fromBase64(IMG_ARR));

        ESPCAM_IMG = imageFromPython;

        emit sendImgToMain();
        QImage image = ESPCAM_IMG.toImage();
        emit newImage(image);
        X_OFFSET = jsonObj["X_OFFSET"].toString();
        Y_OFFSET = jsonObj["Y_OFFSET"].toString();
        ANGLE_OFFSET = jsonObj["ANGLE_OFFSET"].toString();

        angleOffsetCups = ANGLE_OFFSET.toFloat();

        errorY = Y_OFFSET.toFloat();
        errorX = X_OFFSET.toFloat();

        qDebug() << "X_OFFSET:" << X_OFFSET << ", Y_OFFSET:" << Y_OFFSET << ", ANGLE_OFFSET:" << ANGLE_OFFSET;

        if(robotZToPython == "Z_400") {
            Robot_FirstCalibrateBase();
            robotZToPython = "Z_100";
        } else if (robotZToPython == "Z_100") {
            Robot_LoopCalibrateBase();
        }
    }
    else {
        qDebug() << reply->errorString();

        if(pythonFailCount > 3) {
            didGameFailed = "yes";
            reasonToFailGame = "python_calibration_error";
            gameRestart();
        } else {
            QThread::msleep(3000);
            getImageAndSendToPython(imgToGet);
        }

        pythonFailCount++;

    }

    reply->deleteLater();
}


void KUKAGameControl::gameRestart() {
    qDebug() << "GAME STATUS :: " <<  didGameFailed;

    emit gameFinished();

    qDebug() << "RESETING Z TO 400!";
    robotZToPython = "Z_400";

    qDebug() << "RESETING OCR VAR!";
    doOCR = "no_ocr";

    qDebug() << "RESETING DELIVERY PHOTO HEIGHT!";
    deliveryPhotoHeight = "high";

    if(didGameFailed == "no") {
        qDebug() << "game finished alright";
    }
    else if(didGameFailed == "yes") {
        qDebug() << "game DIDNT finished!!";
    }
}


void KUKAGameControl::Robot_FirstCalibrateBase() {
    if(X_OFFSET != "" && Y_OFFSET != "" && ANGLE_OFFSET != "") {
        QString COMMAND = "100";

        QString calibrateMsg = "{COMMAND " + COMMAND + ", CUP_NUM 0, DELIVER_NUM 0, X_OFFSET " + X_OFFSET + ", Y_OFFSET " + Y_OFFSET +
                ", ANGLE_OFFSET 0}";

        QByteArray sendCalibrateToRobot = calibrateMsg.toUtf8();

        tcp_robot->writeValueToRobot("ALBERTO_INFO", sendCalibrateToRobot, 43981);

        X_OFFSET = ""; Y_OFFSET = ""; ANGLE_OFFSET = "";

        waitForRobotToFinish(100);

        QThread::msleep(1500);
        // get second calibration
        getImageAndSendToPython("calibration");

    } else {
        qDebug() << "No correct calibration detected.";
        didGameFailed = "yes";
        reasonToFailGame = "calibration_first_values_error";
        gameRestart();
    }
}


void KUKAGameControl::Robot_LoopCalibrateBase() {
    if(X_OFFSET != "" && Y_OFFSET != "" && ANGLE_OFFSET != "") {
        QString COMMAND = "101";

        QString calibrateMsg = "{COMMAND " + COMMAND + ", CUP_NUM 0, DELIVER_NUM 0, X_OFFSET " + X_OFFSET + ", Y_OFFSET " + Y_OFFSET +
                ", ANGLE_OFFSET 0}";

        QByteArray sendCalibrateToRobot = calibrateMsg.toUtf8();

        tcp_robot->writeValueToRobot("ALBERTO_INFO", sendCalibrateToRobot, 43981);


        if(X_OFFSET.toFloat() > 1 || Y_OFFSET.toFloat() > 1) {
            qDebug() << "!!! NOT PRECISE ENOUGH! GOING AGAIN !!!";
            QThread::msleep(2000);
            getImageAndSendToPython("calibration");
        }
        else {
            Robot_SendCalibrationBase();
        }

        X_OFFSET = ""; Y_OFFSET = ""; ANGLE_OFFSET = "";

    }
    else {
        qDebug() << "No calibration detected. Please click CALIBRATE BUTTON first!!";
        didGameFailed = "yes";
        reasonToFailGame = "calibration_loop_values_error";
        gameRestart();
    }
}


void KUKAGameControl::Robot_SendCalibrationBase() {
    QThread::msleep(1500);

    QString COMMAND = "102";

    QString calibrateMsg = "{COMMAND " + COMMAND +
            ", CUP_NUM 0, DELIVER_NUM 0, X_OFFSET 0, Y_OFFSET 0, ANGLE_OFFSET 0}";

    QByteArray sendCalibrateToRobot = calibrateMsg.toUtf8();

    qDebug() << "sendFINALCalibrateToRobot :: " + sendCalibrateToRobot;

    tcp_robot->writeValueToRobot("ALBERTO_INFO", sendCalibrateToRobot, 43981);

    waitForRobotToFinish(102);

    Robot_DetectRouletteNumberAndBall();
}


void KUKAGameControl::robotMessageReceived() {
    qDebug() << "robot message :: " << tcp_robot->value_received << " !!!";

    if(checkRobotCurrentStep) {
        robotCurrentStep = tcp_robot->value_received.toInt();
        qDebug() << "robotCurrentStep : " << robotCurrentStep;
    }
}


void KUKAGameControl::ESP32_startDCMotor() {
    _socketESP32DCMotor.connectToHost(QHostAddress(ESP32_IP), 80);

    _socketESP32DCMotor.write(QByteArray("M,1000"));
    qDebug() << "run_dc_motor donee";
}


void KUKAGameControl::onReadyReadESP32DCMotor() {
    QByteArray datas = _socketESP32DCMotor.readAll();

    if(datas.contains("done_dc_motor")) {
        qDebug() << "OK :: done_dc_motor, disconnecting...";
        _socketESP32DCMotor.disconnectFromHost();
        Robot_ReleaseBall();
    } else {
        qDebug() << "ESP32 Motor response error, retrying...";
        QThread::msleep(2000);
        ESP32_startDCMotor();
        emit playSound("roulette");
    }
}


void KUKAGameControl::Robot_ReleaseBall() {
    tcp_robot->writeValueToRobot("ALBERTO_INFO", "{COMMAND 103, CUP_NUM 0, DELIVER_NUM 0, X_OFFSET 0, Y_OFFSET 0, ANGLE_OFFSET 0}", 43981);

    waitForRobotToFinish(103);

    Robot_DetectRouletteNumberAndBall();
}


void KUKAGameControl::Robot_DetectRouletteNumberAndBall() {
    tcp_robot->writeValueToRobot("ALBERTO_INFO", "{COMMAND 104, CUP_NUM 0, DELIVER_NUM 0, X_OFFSET 0, Y_OFFSET 0, ANGLE_OFFSET 0}", 43981);

    waitForRobotToFinish(104);

    getImageAndSendToPython("roulette");
}


void KUKAGameControl::Python_GetRouletteNumberAndBall() {

    emit playSound("ocr");

    QByteArray res;
    QBuffer buffer(&res);
    buffer.open( QIODevice::WriteOnly);
    ESPCAM_IMG.save( &buffer, "PNG" );

    // send img to flask
    QNetworkAccessManager *mgr = new QNetworkAccessManager(this);
    const QUrl url(QStringLiteral("http://127.0.0.1:9000/post_roulette_img"));
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject obj;
    obj["img"] = QString(res.toBase64());
    obj["do_ocr"] = doOCR;

    QJsonDocument doc(obj);
    QByteArray data = doc.toJson();

    reply = mgr->post(request, data);

    QObject::connect(reply, &QNetworkReply::finished, this, &KUKAGameControl::onReadyReadRouletteImg);
}


void KUKAGameControl::onReadyReadRouletteImg() {
    if(reply->error() == QNetworkReply::NoError) {

        pythonFailCount = 0;

        QString strReply = (QString)reply->readAll();

        QJsonDocument jsonResponse = QJsonDocument::fromJson(strReply.toUtf8());
        QJsonObject jsonObj = jsonResponse.object();

        QString IMG = jsonObj["IMG"].toString();
        QByteArray IMG_ARR = IMG.toUtf8();

        QPixmap imageFromPython;
        imageFromPython.loadFromData(QByteArray::fromBase64(IMG_ARR));

        ESPCAM_IMG = imageFromPython;

        emit sendImgToMain();

        QImage image = ESPCAM_IMG.toImage();
        emit newImage(image);

        X_OFFSET_MAGNETBALL = jsonObj["X_OFFSET_MAGNETBALL"].toString();
        Y_OFFSET_MAGNETBALL = jsonObj["Y_OFFSET_MAGNETBALL"].toString();
        PRED_NUMBER = jsonObj["PRED_NUMBER"].toString();

        qDebug() << "X_OFFSET_MAGNETBALL:" << X_OFFSET_MAGNETBALL;
        qDebug() << "Y_OFFSET_MAGNETBALL:" << Y_OFFSET_MAGNETBALL;
        qDebug() << "PRED_NUMBER:" << PRED_NUMBER;

        ROULETTE_NUMBER = PRED_NUMBER;

        if(doOCR == "yes_ocr"){
            emit sendNumberToMain(ROULETTE_NUMBER);
        }

        int number = ROULETTE_NUMBER.toInt();

        //        CUP_NUMBER = 1;

        m_uImage->start(5000);
        while(doOCR == "yes_ocr" && CUP_NUMBER == 999){
            qDebug() << "....................................";

        }

        m_uImage->stop();

        qDebug() << "CUP_NUM: " + QString::number(CUP_NUMBER);

        if(doOCR == "no_ocr") doOCR = "yes_ocr";

        if(releaseBallOrGrabCup == "grab") {
            Robot_GrabBall();
            releaseBallOrGrabCup = "release";
        }
        else Robot_GrabCup(CUP_NUMBER);

    }
    else {
        QString err = reply->errorString();
        qDebug() << err;

        if(pythonFailCount > 100) {
            didGameFailed = "yes";
            reasonToFailGame = "python_roulette_img_error";
            gameRestart();
        } else {
            getImageAndSendToPython(imgToGet);
        }

        pythonFailCount++;
    }

    reply->deleteLater();
}


void KUKAGameControl::Robot_GrabBall() {
    if(X_OFFSET_MAGNETBALL != "" && Y_OFFSET_MAGNETBALL != "") {
        QString COMMAND = "107";

        QString calibrateMsg = "{COMMAND " + COMMAND + ", CUP_NUM 0, DELIVER_NUM 0, X_OFFSET " + X_OFFSET_MAGNETBALL +
                ", Y_OFFSET " + Y_OFFSET_MAGNETBALL + ", ANGLE_OFFSET 0.0}";

        QByteArray sendCalibrateToRobot = calibrateMsg.toUtf8();

        tcp_robot->writeValueToRobot("ALBERTO_INFO", sendCalibrateToRobot, 43981);

        X_OFFSET_MAGNETBALL = ""; Y_OFFSET_MAGNETBALL = "";

        // WAIT ROBOT
        waitForRobotToFinish(107);

        emit playSound("roulette");

        ESP32_startDCMotor();


    } else {
        qDebug() << "No offset detected. Please click GET ROULETTE NUMBER  first!!";
        didGameFailed = "yes";
        reasonToFailGame = "grab_ball_values_error";
        gameRestart();
    }
}


void KUKAGameControl::Robot_GrabCup(int cup) {

    emit playSound("drink");

    QString COMMAND = "105";

    float d = 129; // mm
    float X = d * cos(qDegreesToRadians(angleOffsetCups + (22.5*cup)));
    float Y = d * sin(qDegreesToRadians(angleOffsetCups + (22.5*cup)));
    qDebug() << "numberCup : " << cup << ", total theta : " << angleOffsetCups + (22.5*cup);

    X += errorX;
    Y += (65 + errorY);

    QString grabCupMsg = "{COMMAND " + COMMAND + ", CUP_NUM 0, DELIVER_NUM 0, X_OFFSET " +
            QString::number(X, 'f', 4) + ", Y_OFFSET " + QString::number(Y, 'f', 4) +
            ", ANGLE_OFFSET " + QString::number(angleOffsetCups + (22.5*cup), 'f', 4) + "}";

    QByteArray sendGrabCupToRobot = grabCupMsg.toUtf8();

    tcp_robot->writeValueToRobot("ALBERTO_INFO", sendGrabCupToRobot, 43981);

    // WAIT ROBOT
    waitForRobotToFinish(105);

    //Robot_DeliverCup();
    Robot_GoToCupDelivery();
}


void KUKAGameControl::Robot_DeliverCup() {
    DELIVER_NUM = "0";

    emit playSound("intro");

    if(DELIVER_NUM != "") {
        QString COMMAND = "106";

        QString deliverMsg = "{COMMAND " + COMMAND + ", CUP_NUM 0, DELIVER_NUM " + DELIVER_NUM +
                ", X_OFFSET 0, Y_OFFSET 0, ANGLE_OFFSET 0}";

        QByteArray sendDeliverToRobot = deliverMsg.toUtf8();

        tcp_robot->writeValueToRobot("ALBERTO_INFO", sendDeliverToRobot, 43981);

        DELIVER_NUM = "";

        // WAIT ROBOT
        waitForRobotToFinish(106);

        _socketESPCAM.disconnectFromHost();
        gameRestart();

    } else {
        qDebug() << "No DELIVER_NUM detected. Please click Get cups deliver position first!!";
        didGameFailed = "yes";
        reasonToFailGame = "cup_delivery_value_error";
        gameRestart();
    }
}


// ------------------------------ //


void KUKAGameControl::Robot_GoToCupDelivery() {

    tcp_robot->writeValueToRobot("ALBERTO_INFO", "{COMMAND 110, CUP_NUM 0, DELIVER_NUM 0, X_OFFSET 0, Y_OFFSET 0, ANGLE_OFFSET 0}", 43981);

    waitForRobotToFinish(110);

    getImageAndSendToPython("cup_delivery");
}


void KUKAGameControl::Python_GetCupDelivery() {

    while(PLAYER_POSITION == 999){
        qDebug() << "....................................";
        //timer e recomeça

    }

    QByteArray res;
    QBuffer buffer(&res);
    buffer.open( QIODevice::WriteOnly);
    ESPCAM_IMG.save( &buffer, "PNG" );

    // send img to flask
    QNetworkAccessManager *mgr = new QNetworkAccessManager(this);
    const QUrl url(QStringLiteral("http://127.0.0.1:9000/post_cups_img"));
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject obj;
    obj["img"] = QString(res.toBase64());

    obj["cup_pos"] = QString::number(PLAYER_POSITION);
    obj["photo_height"] = deliveryPhotoHeight;

    QJsonDocument doc(obj);
    QByteArray data = doc.toJson();

    reply = mgr->post(request, data);

    QObject::connect(reply, &QNetworkReply::finished, this, &KUKAGameControl::onReadyReadCupDeliveryImg);
}


void KUKAGameControl::onReadyReadCupDeliveryImg() {
    if(reply->error() == QNetworkReply::NoError) {

        pythonFailCount = 0;

        QString strReply = (QString)reply->readAll();

        QJsonDocument jsonResponse = QJsonDocument::fromJson(strReply.toUtf8());
        QJsonObject jsonObj = jsonResponse.object();

        QString IMG = jsonObj["IMG"].toString();
        QByteArray IMG_ARR = IMG.toUtf8();

        QPixmap imageFromPython;
        imageFromPython.loadFromData(QByteArray::fromBase64(IMG_ARR));

        ESPCAM_IMG = imageFromPython;

        emit sendImgToMain();
        QImage image = ESPCAM_IMG.toImage();
        emit newImage(image);

        X_OFFSET_DELIVERY = jsonObj["X_OFFSET_DELIVER"].toString();
        Y_OFFSET_DELIVERY = jsonObj["Y_OFFSET_DELIVER"].toString();

        qDebug() << "X_OFFSET_DELIVERY:" << X_OFFSET_DELIVERY;
        qDebug() << "Y_OFFSET_DELIVERY:" << Y_OFFSET_DELIVERY;

        if(deliveryPhotoHeight == "high") {
            Robot_AproxCupDelivery();
            deliveryPhotoHeight = "low";
        }
        else if(deliveryPhotoHeight == "low" && (X_OFFSET_DELIVERY.toFloat() > 1 || Y_OFFSET_DELIVERY.toFloat() > 1)) {
            Robot_AdjustCupDelivery();
        }
        else if(deliveryPhotoHeight == "low" && (X_OFFSET_DELIVERY.toFloat() < 1 && Y_OFFSET_DELIVERY.toFloat() < 1)) {
            Robot_FinalCupDelivery();
        }

    }
    else {
        QString err = reply->errorString();
        qDebug() << err;

        if(pythonFailCount > 3) {
            didGameFailed = "yes";
            reasonToFailGame = "cup_delivery_img_error";
            gameRestart();
        } else {
            getImageAndSendToPython(imgToGet);
        }

        pythonFailCount++;

    }

    reply->deleteLater();
}


void KUKAGameControl::Robot_AproxCupDelivery() {
    if(X_OFFSET_DELIVERY != "" && Y_OFFSET_DELIVERY != "") {
        QString COMMAND = "111";

        QString calibrateMsg = "{COMMAND " + COMMAND + ", CUP_NUM 0, DELIVER_NUM 0, X_OFFSET " + X_OFFSET_DELIVERY +
                ", Y_OFFSET " + Y_OFFSET_DELIVERY + ", ANGLE_OFFSET 0.0}";

        QByteArray sendCalibrateToRobot = calibrateMsg.toUtf8();

        tcp_robot->writeValueToRobot("ALBERTO_INFO", sendCalibrateToRobot, 43981);

        waitForRobotToFinish(111);

        getImageAndSendToPython("cup_delivery");

        X_OFFSET_DELIVERY = ""; Y_OFFSET_DELIVERY = "";

    } else {
        qDebug() << "No offset detected on Robot_AproxCupDelivery!!";
        didGameFailed = "yes";
        reasonToFailGame = "cup_delivery_aprox_values_error";
        gameRestart();
    }

}


void KUKAGameControl::Robot_AdjustCupDelivery() {
    if(X_OFFSET_DELIVERY != "" && Y_OFFSET_DELIVERY != "") {
        QString COMMAND = "112";

        QString calibrateMsg = "{COMMAND " + COMMAND + ", CUP_NUM 0, DELIVER_NUM 0, X_OFFSET " + X_OFFSET_DELIVERY +
                ", Y_OFFSET " + Y_OFFSET_DELIVERY + ", ANGLE_OFFSET 0.0}";

        QByteArray sendCalibrateToRobot = calibrateMsg.toUtf8();

        tcp_robot->writeValueToRobot("ALBERTO_INFO", sendCalibrateToRobot, 43981);

        waitForRobotToFinish(112);

        //        getImageAndSendToPython("cup_delivery");
        Robot_FinalCupDelivery();

        X_OFFSET_DELIVERY = ""; Y_OFFSET_DELIVERY = "";

    } else {
        qDebug() << "No offset detected on Robot_AdjustCupDelivery!!";
        didGameFailed = "yes";
        reasonToFailGame = "cup_delivery_adjust_values_error";
        gameRestart();
    }
}


void KUKAGameControl::Robot_FinalCupDelivery() {
    int xOffset = 0, yOffset = 0;

    int number = PLAYER_POSITION;

    float d = 40;
    if(number % 4 == 1) {
        xOffset = -d;
        yOffset = -d;
    }
    else if(number % 4 == 2) {
        xOffset = d;
        yOffset = -d;
    }
    else if(number % 4 == 3) {
        xOffset = -d;
        yOffset = d;
    }
    else if(number % 4 == 0) {
        xOffset = d;
        yOffset = d;
    }

    xOffset += 3;
    yOffset = (yOffset * -1) + 72;

    QString COMMAND = "113";

    QString calibrateMsg = "{COMMAND " + COMMAND + ", CUP_NUM 0, DELIVER_NUM 0, X_OFFSET " +
            QString::number(xOffset) + ", Y_OFFSET " + QString::number(yOffset) + ", ANGLE_OFFSET 0.0}";

    QByteArray sendCalibrateToRobot = calibrateMsg.toUtf8();

    tcp_robot->writeValueToRobot("ALBERTO_INFO", sendCalibrateToRobot, 43981);

    waitForRobotToFinish(113);

    _socketESPCAM.disconnectFromHost();
    gameRestart();
}





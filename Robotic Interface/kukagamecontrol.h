#ifndef KUKAGAMECONTROL_H
#define KUKAGAMECONTROL_H

#include <QObject>

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QJsonDocument>
#include <QBuffer>
#include <QTcpSocket>
#include <QPixmap>
#include <QThread>
#include <QtMath>
#include <QElapsedTimer>
#include <QTimer>
#include <QHostAddress>

#include "kukavarproxy_msg_format.h"

class KUKAGameControl : public QObject
{
    Q_OBJECT
public:
    KUKAGameControl();

    //~KUKAGameControl();

    QPixmap ESPCAM_IMG;

    QString didGameFailed = "", ROULETTE_NUMBER = "";

    QString reasonToFailGame = "";

    void startGame();

    int CUP_NUMBER = 999;

    int PLAYER_POSITION = 1;
    QString drink = "2";

public slots:
    void updateImageQML();

signals:
    void sendImgToMain();

    void sendNumberToMain(QString number);

    void gameFinished();

    void newImage(QImage &);

    void playSound(QString sound);

private slots:
    void onReadyReadESPCAM();

    void finishedReceivingImg();

    void onReadyReadESP32DCMotor();

    void onReadyReadRouletteImg();

    void onReadyReadCalibrateImg();

    void onReadyReadCupDeliveryImg();

    void robotMessageReceived();

    void Python_getCalibration();

    void ESP32_startDCMotor();

    void Robot_ReleaseBall();

    void Robot_DetectRouletteNumberAndBall();

    void Python_GetRouletteNumberAndBall();

    void Robot_GrabCup(int cup);

    void Robot_DeliverCup();

    void Robot_GrabBall();

    void getImageAndSendToPython(QString whatToAnalyze);

    void waitForRobotToFinish(int step);

    void Robot_FirstCalibrateBase();

    void gameRestart();

    void Robot_LoopCalibrateBase();

    void Robot_SendCalibrationBase();

    void restartGetImg();

    void Robot_GoToCupDelivery();

    void Python_GetCupDelivery();

    void Robot_AproxCupDelivery();

    void Robot_AdjustCupDelivery();

    void Robot_FinalCupDelivery();

private:
    QTcpSocket  _socketESPCAM;

    QByteArray dataFromESPCAM;

    QString ESPCAM_IP, ESP32_IP;

    bool hasImg = false;

    QTcpSocket  _socketESP32DCMotor;

    QNetworkReply *reply;

    kukavarproxy_msg_format *tcp_robot;

    QString X_OFFSET = "", Y_OFFSET = "", ANGLE_OFFSET = "";

    QString CUP_NUM = "", DELIVER_NUM = "";

    QString X_OFFSET_MAGNETBALL = "", Y_OFFSET_MAGNETBALL = "", PRED_NUMBER = "";

    bool checkRobotIsMoving = false;

    QString imgToGet;

    bool isRobotStopped;

    bool checkRobotCurrentStep = false;

    int robotCurrentStep = -1;

    int cnum = 1;

    float theta = 0;

    int numberCup = 1;

    float saveCalibrationAngle = 0;

    QString robotZToPython = "Z_400";

    float angleOffsetCups = 0;

    float errorY = 0, errorX = 0;

    QTimer *m_timer;

    QString releaseBallOrGrabCup = "grab";

    QString doOCR = "no_ocr";

    int pythonFailCount = 0;

    QString deliveryPhotoHeight = "high";

    QString X_OFFSET_DELIVERY, Y_OFFSET_DELIVERY;

    QTimer *m_uImage;

    int number;

};

#endif // KUKAGAMECONTROL_H

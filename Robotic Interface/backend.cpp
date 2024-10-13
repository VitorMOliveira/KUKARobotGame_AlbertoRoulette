#include "backend.h"

Backend::Backend(QObject *parent, QQmlApplicationEngine *engine) : QObject(parent)
{
    this->m_engine = engine;
    soundPlayer = new QMediaPlayer(this);

    //read numbers in database and glass ID
    readFileTXT(urlDatabase, "database");

    readFileTXT2(urlRandomDatabase);

    readFileTXT(urlGlassID, "glassRobot");

    //play sound
    //    playSound("drink");

    //    gameControl = new KUKAGameControl();
    //    threadRobotGame = new QThread();
    //    gameControl->moveToThread(threadRobotGame);
    //    connect(gameControl, &KUKAGameControl::gameFinished, this, &Backend::restartGame);
    //    // start robot game when thread starts
    //    connect(threadRobotGame, &QThread::started, gameControl, &KUKAGameControl::startGame);
    //    // clear thread
    //    connect( gameControl, &KUKAGameControl::gameFinished, threadRobotGame, &QThread::quit);
    //    connect( gameControl, &KUKAGameControl::gameFinished, gameControl, &KUKAGameControl::deleteLater);
    //    connect( threadRobotGame, &QThread::finished, threadRobotGame, &QThread::deleteLater);
    //    //receive number to choose cup
    //    connect(gameControl, &KUKAGameControl::sendNumberToMain, this, &Backend::crossGlassID);

    // START GAME!
    //    threadRobotGame->start();

    //    restartGame();
    //    liveImageProvider = new OpencvImageProvider(this);

    playSound("intro");
}


/*
    Function to receive and send numbers of players to QML
*/
void Backend::getNumbersPlayers(QString numberPlayers)
{
    //checks players of numbers to send QML
    if (numberPlayers == "2"){
        playersQML = numberPlayers.toDouble();

        //sends to QML
        numberPlayersQML(playersQML);
        numberPlayersChoose = numberPlayers;
        //        qDebug() << "aaaaa" + numberPlayers;
    } else if (numberPlayers == "4"){
        playersQML = numberPlayers.toDouble();

        //sends to QML
        numberPlayersQML(playersQML);
        numberPlayersChoose = numberPlayers;
        //        qDebug() << "bbbb" + numberPlayers;
    }
    getOrderPlayers("");
}

/*
    Function to get numbers of QML
*/
void Backend::chooseTableNumbers(QString numberChoose)
{
    if(numberChoose != NULL){

        //split String to check if numbers were select or not select
        QStringList stringAll = numberChoose.split(".");
        if(stringAll.size()>=2){
            QString visible = stringAll.at(0);

            //if number select consider number choose
            if(visible == "t") {
                numberChooseWriteList = stringAll.at(1);
                qDebug() << "Choose Number: " + numberChooseWriteList;
            } else {
                numberChooseWriteList = "";
                writeListNumberChoose(numberChooseWriteList);
            }
        }
    }
}

/*
    Fucntion for get order players to send QML
*/
void Backend::getOrderPlayers(QString order)
{
    if (numberPlayersChoose == "2"){
        if(orderplayers == "0" || order == "" || order == "0"){
            orderplayers = "1";

            //sends the order the number of player for write in text and alert user
            writeListNumberChoose(numberChooseWriteList);
            //            playerOrder(orderplayers, numberPlayersChoose);
        }else if(orderplayers == "1"){
            backOrderPlayers = "1";
            orderplayers = "2";

            //sends the order the number of player for write in text and alert user
            writeListNumberChoose(numberChooseWriteList);
            //            playerOrder(orderplayers, numberPlayersChoose);
        } else if(orderplayers == "2"){
            backOrderPlayers = "2";
            orderplayers = "1";

            //sends the order the number of player for write in text and alert user
            writeListNumberChoose(numberChooseWriteList);
            //            playerOrder(orderplayers, numberPlayersChoose);
        }
        qDebug() << "order: " + orderplayers;
    } else if(numberPlayersChoose == "4"){
        if(orderplayers == "0" || order == "" || order == "0"){
            orderplayers = "1";

            //sends the order the number of player for write in text and alert user
            writeListNumberChoose(numberChooseWriteList);
            //            playerOrder(orderplayers, numberPlayersChoose);
        } else if(orderplayers == "1"){
            backOrderPlayers = "1";
            orderplayers = "2";

            //sends the order the number of player for write in text and alert user
            writeListNumberChoose(numberChooseWriteList);
            //            playerOrder(orderplayers, numberPlayersChoose);
        } else if(orderplayers == "2"){
            backOrderPlayers = "2";
            orderplayers = "3";

            //sends the order the number of player for write in text and alert user
            writeListNumberChoose(numberChooseWriteList);
            //            playerOrder(orderplayers, numberPlayersChoose);
        } else if(orderplayers == "3"){
            backOrderPlayers = "3";
            orderplayers = "4";

            //sends the order the number of player for write in text and alert user
            writeListNumberChoose(numberChooseWriteList);
            //            playerOrder(orderplayers, numberPlayersChoose);
        } else if(orderplayers == "4"){
            backOrderPlayers = "4";
            orderplayers = "1";

            //sends the order the number of player for write in text and alert user
            writeListNumberChoose(numberChooseWriteList);
            //            playerOrder(orderplayers, numberPlayersChoose);
        }
        qDebug() << "order: " + orderplayers;
    }
}

/*
    Function to write number choose in QMap. The QMap save the glass id and numbers associated
*/
void Backend::writeListNumberChoose(QString glass_id)
{

    if(numberChooseWriteList != NULL){

        QString numbers = writeNumbersOrderly(glass_id);

        if (numberPlayersChoose == "2"){

            if(backOrderPlayers == "1"){
                player1.insert(numbers, glass_id);
                player1Exit.insert(glass_id,"0");
                qDebug() << "player 1: " + glass_id + "     " + numbers;

                if(randomCups == true){
                    round++;
                    generateRandomCups(glass_id, "1", 3);
                }

                writeListNumbersQML(player1);
                //                            writeNumbersQML(glass_id);
            }   else if(backOrderPlayers == "2"){
                player2.insert(numbers, glass_id);
                player2Exit.insert(glass_id,"0");
                qDebug() << "player 2: " + glass_id + "     " + numbers;

                if(randomCups == true){
                    round++;
                    generateRandomCups(glass_id, "2", 3);
                }

                writeListNumbersQML(player2);

                //                            writeNumbersQML(glass_id);
            }
        } else if(numberPlayersChoose == "4"){

            round = 4;

            if(backOrderPlayers == "1"){
                player1.insert(numbers, glass_id);
                player1Exit.insert(glass_id,"0");
                qDebug() << "player 1: " + glass_id + "     " + numbers;

                if(randomCups == true){
                    generateRandomCups(glass_id, "1", 1);
                }

                writeListNumbersQML(player1);
                //                            writeNumbersQML(glass_id);
            }   else if(backOrderPlayers == "2"){
                player2.insert(numbers, glass_id);
                player2Exit.insert(glass_id,"0");
                qDebug() << "player 2: " + glass_id + "     " + numbers;

                if(randomCups == true){
                    generateRandomCups(glass_id, "2", 1);
                }

                writeListNumbersQML(player2);

                //                            writeNumbersQML(glass_id);
            } else if(backOrderPlayers == "3"){
                player3.insert(numbers, glass_id);
                player3Exit.insert(glass_id,"0");
                qDebug() << "player 3: " + glass_id + "     " + numbers;

                if(randomCups == true){
                    generateRandomCups(glass_id, "3", 1);
                }

                writeListNumbersQML(player3);
                //                            writeNumbersQML(glass_id);
            }   else if(backOrderPlayers == "4"){
                player4.insert(numbers, glass_id);
                player4Exit.insert(glass_id,"0");
                qDebug() << "player 4: " + glass_id + "     " + numbers;

                if(randomCups == true){
                    generateRandomCups(glass_id, "4", 1);
                }

                writeListNumbersQML(player4);

                //                            writeNumbersQML(glass_id);
            }
        }
    }
}

/*
    Function to clear numbers the QMap and Texts in QML
*/
void Backend::clearQList(bool clear)
{
    //read value of QML. If true clear data
    if(clear == true){
        player1.clear();
        writeListNumbersQML(player1);
        player2.clear();
        writeListNumbersQML(player2);
        player3.clear();
        writeListNumbersQML(player3);
        player4.clear();
        writeListNumbersQML(player4);

        //clear text number in QML
        clearTextQML(true);

        //clear cross if visible in QML
        crossInvisible(true);
        visibleCrossGlassID("0", false);
        enableCrossNumber("0", false);

        crossInvisible(false);

        round = 0;
        randomDatabase.clear();
        readFileTXT2(urlRandomDatabase);
    }
}

/*
    Function to read numbers of file txt and create database
*/
void Backend::readFileTXT(QString url, QString Qmap)
{
    //open de file
    QFile file(url);
    if(!file.open(QFile::ReadOnly | QFile::Text)){
        qDebug() << "ERROR";
    }

    QTextStream in(&file);
    QString text = in.readAll();
    file.close();

    //checks if the text is not null. If it is null, do not write anything in the list.
    if (text != NULL){
        //split notepad text by "\n"
        QStringList data_split = text.split("\n", QString::SkipEmptyParts);

        foreach( QString data, data_split ) {
            //split notepad text by "-"
            QStringList database_list = data.split("-");

            if(database_list.size() == 2) {
                //obtain the part corresponding to each division made
                QString number = database_list.at(0);
                QString glass_id = database_list.at(1);

                //add number and glass id in database, QMap
                if(Qmap == "database"){
                    database.insert(number,glass_id);
                } else if(Qmap == "glassRobot"){
                    glassRobot.insert(number.toInt(),glass_id);

                }
            }
        }
    }
}

void Backend::readFileTXT2(QString url)
{
    //open de file
    QFile file(url);
    if(!file.open(QFile::ReadOnly | QFile::Text)){
        qDebug() << "ERROR";
    }

    QTextStream in(&file);
    QString text = in.readAll();
    file.close();

    //checks if the text is not null. If it is null, do not write anything in the list.
    if (text != NULL){
        //split notepad text by "\n"
        QStringList data_split = text.split("\n", QString::SkipEmptyParts);

        foreach( QString data, data_split ) {
            //split notepad text by ","
            QStringList database_list = data.split(",");

            if(database_list.size() == 2) {
                //obtain the part corresponding to each division made
                QString glass_id = database_list.at(0);
                QString number = database_list.at(1);

                //add number and glass id in database, QMap
                randomDatabase.insert(glass_id,number);

            }
        }
    }
}

/*
    Function to to write numbers in numerical order
*/
QString Backend::writeNumbersOrderly(QString number)
{
    auto it = database.begin();

    QString number_text =  "";
    int text_order = 0;
    for(it=database.begin(); it!=database.end();it++){
        if(it.value() == number){

            //checks if number_text is NULL to write numbers in numerical order
            if(number_text != ""){
                if(it.key().toInt() > text_order){
                    number_text = number_text + "-" + it.key();
                } else {
                    number_text = it.key() + "-" + number_text ;

                }
                text_order = it.value().toInt();
            } else {
                number_text = it.key();
                text_order = number_text.toInt();
            }
        }
        //            qDebug() << it.key() + "    " + it.value();
    }

    //return number_text orderly
    return number_text;
}

/*
    Function to write numbers in Text QML
*/
void Backend::writeListNumbersQML(QMap<QString, QString> player)
{
    auto it = player.begin();
    int size = (player.size())/2;

    int i = 0;
    for(it=player.begin(); it!=player.end();it++){

        //checks if textNumberPlayersQML is empty to not write "-"
        if (!(it==player.begin())){
            if(newLine == true && size == i){
                textNumberPlayersQML = textNumberPlayersQML + "\n" + it.key();
                newLine = false;
            } else {
                textNumberPlayersQML = textNumberPlayersQML + "-" + it.key();
            }
        } else  {
            textNumberPlayersQML = it.key();
        }
        i++;
    }

    //goes to next page automatic when all numbers has chosen
    nextPageQML(player1, player2, player3, player4);

    //sends player order to players.qml
    orderPlayersQML(orderplayers);

    //sends text to QML
    textNumberChooseQML(textNumberPlayersQML);
    textNumberPlayersQML = "";


    //Disabled cross to does not be chosen again
    enableCrossNumber(numberChooseWriteList, false);

}

void Backend::orderlyTextNumbers()
{
    qDebug() << "cccccccccccccccccccc";

}

/*
    Function to go next page when all numbers has chosen
*/
void Backend::nextPageQML(QMap<QString, QString> player1, QMap<QString, QString> player2, QMap<QString, QString> player3, QMap<QString, QString> player4)
{

    //If QMap has all filled go to next page
    if(player1.size() == 8 && player2.size() == 8){
        delay(1000);
        enableCrossNumber("0", false);
        visibleCrossGlassID("0", false);
        nextPage(true);

        //clear cross if visible in QML
        crossInvisible(false);

        // START GAME!
        restartGame();

    } else if(player1.size() == 4 && player2.size() == 4 && player3.size() == 4 && player4.size() == 4 ){
        delay(1000);
        enableCrossNumber("0", false);
        visibleCrossGlassID("0", false);
        nextPage(true);

        //clear cross if visible in QML
        crossInvisible(false);

        // START GAME!
        restartGame();
    }
}

/*
    Function to get number of combo box
*/
QString Backend::getNumberComboBox(QString comboBox1)
{
    comboBox = comboBox1;

    //invisible cross and disable cross number
    visibleCrossGlassID("0", false);
    enableCrossNumber("0", false);

    //obtain number through the glass id

    crossGlassID(comboBox);
    return comboBox;
}

/*
    Function that allows obtain number trought the glass id
*/
void Backend::crossGlassID(QString outGoingNumber)
{

    QString glass_id;
    int i = 0;
    int player = 0;
    //checks if the number is less than 10 and adds a 0 because of the QMap database
    if(outGoingNumber.toDouble() < 10){
        outGoingNumber = "0" + outGoingNumber;
    }

    auto it = database.begin();
    //searches the QMap database for the glass id to which the number belongs
    for(it=database.begin(); it!=database.end();it++){

        if(it.key() == outGoingNumber){
            glass_id = it.value();
        }
    }

    if(playersQML == 2){

        //check through the glass id who chose that number
        QString checkPlayer1 = getGlassIDQMap(player1Exit, glass_id);
        QString checkPlayer2 = getGlassIDQMap(player2Exit, glass_id);

        //if checkPlayer = 2, player already drank. Otherwise player goes drink
        if(checkPlayer1 == "2") {
            informationPlayerDinks("Player 1 already drank", true);

            delay(1000);

            informationPlayerDinks("Player 1 already drank", false);
        } else if(checkPlayer1 == "1"){
            player1Exit.insert(glass_id,"1");
            //sends the information to robot
            i = drinkPlayer("Player 1", glass_id);
            player = 1;

            //cross visible
            visibleCrossGlassID(glass_id, true);

            //information which player goes drink - visible rectangle
            informationPlayerDinks("Player 1 drink", true);

            //delay to player read message
            delay(1000);

            //information which player goes drink - invisible rectangle
            informationPlayerDinks("Player 1", false);
        } else if(checkPlayer2 == "2") {
            informationPlayerDinks("Player 2 already drank", true);

            delay(1000);

            informationPlayerDinks("Player 2 already drank", false);
        } else if(checkPlayer2 == "1"){
            player2Exit.insert(glass_id,"1");

            i = drinkPlayer("Player 2", glass_id);
            player = 2;

            visibleCrossGlassID(glass_id, true);

            informationPlayerDinks("Player 2 drink", true);

            delay(1000);

            informationPlayerDinks("Player 2 drink", false);
        }
    }

    //------------------------------
    if(playersQML == 4){

        //check through the glass id who chose that number
        QString checkPlayer1 = getGlassIDQMap(player1Exit, glass_id);
        QString checkPlayer2 = getGlassIDQMap(player2Exit, glass_id);
        QString checkPlayer3 = getGlassIDQMap(player3Exit, glass_id);
        QString checkPlayer4 = getGlassIDQMap(player4Exit, glass_id);

        //if checkPlayer = 2, player already drank. Otherwise player goes drink
        if(checkPlayer1 == "2") {
            informationPlayerDinks("Player 1 already drank", true);

            delay(1000);

            informationPlayerDinks("Player 1 already drank", false);
        } else if(checkPlayer1 == "1"){
            player1Exit.insert(glass_id,"1");
            //sends the information to robot
            i = drinkPlayer("Player 1", glass_id);
            player = 1;

            //cross visible
            visibleCrossGlassID(glass_id, true);

            //information which player goes drink - visible rectangle
            informationPlayerDinks("Player 1 drink", true);

            //delay to player read message
            delay(1000);

            //information which player goes drink - invisible rectangle
            informationPlayerDinks("Player 1", false);
        } else if(checkPlayer2 == "2") {
            informationPlayerDinks("Player 2 already drank", true);

            delay(1000);

            informationPlayerDinks("Player 2 already drank", false);
        } else if(checkPlayer2 == "1"){
            player2Exit.insert(glass_id,"1");

            i = drinkPlayer("Player 2", glass_id);
            player = 2;

            visibleCrossGlassID(glass_id, true);

            informationPlayerDinks("Player 2 drink", true);

            delay(1000);

            informationPlayerDinks("Player 2 drink", false);
        } else if(checkPlayer3 == "2") {
            informationPlayerDinks("Player 3 already drank", true);

            delay(1000);

            informationPlayerDinks("Player 3 already drank", false);
        } else if(checkPlayer3 == "1"){
            player3Exit.insert(glass_id,"1");
            //sends the information to robot
            i = drinkPlayer("Player 3", glass_id);
            player = 3;

            //cross visible
            visibleCrossGlassID(glass_id, true);

            //information which player goes drink - visible rectangle
            informationPlayerDinks("Player 3 drink", true);

            //delay to player read message
            delay(1000);

            //information which player goes drink - invisible rectangle
            informationPlayerDinks("Player 3", false);
        } else if(checkPlayer4 == "4") {
            informationPlayerDinks("Player 4 already drank", true);

            delay(1000);

            informationPlayerDinks("Player 4 already drank", false);
        } else if(checkPlayer4 == "1"){
            player4Exit.insert(glass_id,"1");

            i = drinkPlayer("Player 4", glass_id);
            player = 4;

            visibleCrossGlassID(glass_id, true);

            informationPlayerDinks("Player 4 drink", true);

            delay(1000);

            informationPlayerDinks("Player 4 drink", false);
        }
    }
    //------------------------------
    //checks if player winner
    playerWinner(i, player);


}

/*
    Function to get which QMap the glass belongs to
*/
QString Backend::getGlassIDQMap(QMap<QString, QString> player, QString glass_id)
{
    auto it = player.begin();

    //if glass belong the QMap return true
    for(it=player.begin(); it!=player.end();it++){
        if(it.key().toInt() == glass_id.toInt()){
            //if value = 0 means that the number did not come out and the player did not drink
            //otherwise value = 1 player has already drunk
            if(it.value() == "0"){
                return "1";
            } else if(it.value() == "1"){
                return "2";
            }
        }
    }
    return "0";
}

/*
    Function to send information to robot of which player goes drinks
*/
int Backend::drinkPlayer(QString player, QString glass_id)
{
    int i = 1;
    if(numberPlayersChoose == "2"){
        if(player == "Player 1"){
            qDebug() << "111111111111111    " +player + " bebe";
            i = position_1;
        } else if(player == "Player 2"){
            qDebug() << "222222222222222    " + player + " bebe";
            i = position_2;

        }
    } else if (numberPlayersChoose == "4"){
        if(player == "Player 1"){
            qDebug() << "111111111111111    " +player + " bebe";
            i = position_1;
        } else if(player == "Player 2"){
            qDebug() << "222222222222222    " + player + " bebe";
            i = position_2;

        } else if(player == "Player 3"){
            qDebug() << "111111111111111    " +player + " bebe";
            i = position_3;
        } else if(player == "Player 4"){
            qDebug() << "222222222222222    " + player + " bebe";
            i = position_4;

        }
    }

    //see in QMap which is the last position that the robot placed a cup
    auto it = glassRobot.begin();

    for(it=glassRobot.begin(); it!=glassRobot.end();it++){
        //player one has positions from 1 to 9 and player two from 9 to 16
        if(i < 9){
            //if the value is "0" it means that the robot did not put a cup, and it sends this information to the robot and lap 1 to know next time
            if(it.value() == "0"){
                glassRobot.insert(it.key(), "1");
                if(player == "Player 1"){
                    qDebug() << "position:  " + QString::number(position_1) + " glass:     " + glass_id;

                    //send cup and position to robot
                    gameControl->PLAYER_POSITION = position_1;
                    gameControl->CUP_NUMBER = glass_id.toInt();

                    //sendGameControlCup(position_2, glass_id);
                    //save position
                    position_1 = i+1;
                    break;
                } else if(player == "Player 3"){
                    qDebug() << "position:  " + QString::number(position_3) + " glass:     " + glass_id;

                    //send cup and position to robot
                    gameControl->PLAYER_POSITION = position_3;
                    gameControl->CUP_NUMBER = glass_id.toInt();

                    //sendGameControlCup(position_2, glass_id);
                    //save position
                    position_3 = i+1;
                    break;
                }
            }
        } else if (i >= 9) {
            if(it.value() == "0"){
                glassRobot.insert(it.key(), "1");

                if(player == "Player 2"){

                    qDebug() << "position:  " + QString::number(position_2) + " glass:     " + glass_id;

                    //send cup and position to robot
                    gameControl->PLAYER_POSITION = position_2;
                    gameControl->CUP_NUMBER = glass_id.toInt();

                    //sendGameControlCup(position_2, glass_id);
                    position_2 = i+1;
                    break;
                } else if(player == "Player 4"){

                    qDebug() << "position:  " + QString::number(position_4) + " glass:     " + glass_id;

                    //send cup and position to robot
                    gameControl->PLAYER_POSITION = position_4;
                    gameControl->CUP_NUMBER = glass_id.toInt();

                    //sendGameControlCup(position_2, glass_id);
                    position_4 = i+1;
                    break;
                }
            }
        }
    }

    i++;
    return (i-1);

}

/*
    Function delay
*/
void Backend::delay(qreal time)
{
    //delay
    QEventLoop loop;
    QTimer::singleShot(time, &loop, &QEventLoop::quit);
    loop.exec();
}

/*
    Function to inform which player winner
*/
void Backend::playerWinner(int glass, int player)
{
    if(numberPlayersChoose == "2"){
        //If the cup number is 8 or 16 it means the player has lost
        if(player == 1 && glass==8){
            //sends information to QML
            qDebug() << "Player 1 Lost";
            informationPlayerDinks("Player 1 Lost",true);
            delay(1000);
            informationPlayerDinks("Player 1 Lost",false);

            //clear QMap glassRobot
            readFileTXT(urlGlassID, "glassRobot");

            readFileTXT2(urlRandomDatabase);
        }else if(player == 2 && glass==16){
            qDebug() << "Player 2 Lost";
            informationPlayerDinks("Player 2 Lost",true);
            delay(1000);
            informationPlayerDinks("Player 2 Lost",false);

            readFileTXT(urlGlassID, "glassRobot");
            readFileTXT2(urlRandomDatabase);
        }
    } else if(numberPlayersChoose == "4"){
        if(player == 1 && glass==4){
            //sends information to QML
            qDebug() << "Player 1 Lost";
            informationPlayerDinks("Player 1 Lost",true);
            delay(1000);
            informationPlayerDinks("Player 1 Lost",false);

            //clear QMap glassRobot
            readFileTXT(urlGlassID, "glassRobot");

            readFileTXT2(urlRandomDatabase);
        }else if(player == 2 && glass==12){
            qDebug() << "Player 2 Lost";
            informationPlayerDinks("Player 2 Lost",true);
            delay(1000);
            informationPlayerDinks("Player 2 Lost",false);

            readFileTXT(urlGlassID, "glassRobot");
            readFileTXT2(urlRandomDatabase);
        } else if(player == 3 && glass==8){
            //sends information to QML
            qDebug() << "Player 3 Lost";
            informationPlayerDinks("Player 3 Lost",true);
            delay(1000);
            informationPlayerDinks("Player 3 Lost",false);

            //clear QMap glassRobot
            readFileTXT(urlGlassID, "glassRobot");

            readFileTXT2(urlRandomDatabase);
        }else if(player == 4 && glass==16){
            qDebug() << "Player 4 Lost";
            informationPlayerDinks("Player 4 Lost",true);
            delay(1000);
            informationPlayerDinks("Player 4 Lost",false);

            readFileTXT(urlGlassID, "glassRobot");
            readFileTXT2(urlRandomDatabase);
        }
    }
}

/*
    Function to play sound
*/
void Backend::playSound(QString sound)
{
    if(soundAlarm == true){
        qint32 random = 0;

        //checks if type sound
        if( sound == "drink"){
            //        random  = qrand() % (0 - 4);
            random = QRandomGenerator::global()->bounded(0,4);
            qDebug() << "ahsdhsdcdkhd        " + QString::number(random);

            switch (random) {
            case 0:
                soundPlayer->setMedia(QUrl("qrc:/audios/drink/ComoNaoHeiDeSerBebado.mp3"));
                break;
            case 1:
                soundPlayer->setMedia(QUrl("qrc:/audios/drink/JaVisteOCalorQueEsta.mp3"));
                break;
            case 2:
                soundPlayer->setMedia(QUrl("qrc:/audios/drink/PoucaSede.mp3"));
                break;
            case 3:
                soundPlayer->setMedia(QUrl("qrc:/audios/drink/QueSede.mp3"));
                break;
            case 4:
                soundPlayer->setMedia(QUrl("qrc:/audios/drink/ComaSede.mp3"));
                break;
            }
        } else if (sound == "roulette"){
            if(a == 1){
                soundPlayer->setMedia(QUrl("qrc:/audios/roulette/Alpinista.mp3"));
                a = 2;
            } else if(a == 2){
                soundPlayer->setMedia(QUrl("qrc:/audios/roulette/Roda.mp3"));
                a = 1;
            }
            //            random  = qrand() % (0 - 1);
            //            random = QRandomGenerator::global()->bounded(0,2);
            //            qDebug() << "ahsdhsdcdkhd        " + QString::number(random);

            //            switch (random) {
            //            case 0:
            //                soundPlayer->setMedia(QUrl("qrc:/audios/roullete/Roda.mp3"));
            //                break;
            //            case 1:
            //                soundPlayer->setMedia(QUrl("qrc:/audios/roullete/Alpinista.mp3"));
            //                break;
            //            case 2:
            //                soundPlayer->setMedia(QUrl("qrc:/audios/roullete/Alpinista.mp3"));
            //                break;
            //                //        case 2:
            //                //            soundPlayer->setMedia(QUrl("qrc:/audios/roullete/Sirene.mp3"));
            //                //            break;
            //                //        case 3:
            //                //            soundPlayer->setMedia(QUrl("qrc:/audios/roullete/Roda.mp3"));
            //                //            break;
            //                //        case 4:
            //                //            soundPlayer->setMedia(QUrl("qrc:/audios/roullete/PrecoCerto1.mp3"));
            //                //            break;
            //            }
        } else if(sound == "intro"){
            soundPlayer->setMedia(QUrl("qrc:/audios/intro/PrecoCerto.mp3"));

        } else if(sound == "ocr"){
            soundPlayer->setMedia(QUrl("qrc:/audios/ocr/OCR.mp3"));

        } else if(sound == "ok"){
            soundPlayer->setMedia(QUrl("qrc:/audios/ocr/Incrivel.mp3"));
        }

        //play sound
        soundPlayer->setVolume(100);
        soundPlayer->play();
    }
}

void Backend::generateRandomCups(QString cups, QString player, int plays)
{
    auto it = randomDatabase.begin();

    for(it=randomDatabase.begin(); it!=randomDatabase.end();it++){
        if(it.key().toInt() == cups.toInt()){
            randomDatabase.erase(it);
        }
    }

    qint32 random = 0;
    int j = 0;

    while(j < plays){
        if(round < 4){
            random = QRandomGenerator::global()->bounded(1,randomDatabase.size());

            auto it2 = randomDatabase.begin();
            int i = 1;

            for(it2=randomDatabase.begin(); it2!=randomDatabase.end();it2++){

                if((i == random && round <4) || round == 4){
                    QString numbers = it2.value();
                    QString glass_id = it2.key();

                    if(player == "1"){
                        player1.insert(numbers, glass_id);
                        player1Exit.insert(glass_id,"0");

                        visibleCrossGlassID(QString::number(glass_id.toInt()), true);
                        enableCrossNumber(QString::number(glass_id.toInt()), false);

                        randomDatabase.erase(it2);
                        break;
                    } else if(player == "2"){
                        player2.insert(numbers, glass_id);
                        player2Exit.insert(glass_id,"0");

                        visibleCrossGlassID(QString::number(glass_id.toInt()), true);
                        enableCrossNumber(QString::number(glass_id.toInt()), false);

                        randomDatabase.erase(it2);
                        break;
                    }
                }
                i++;
            }
        } else if(round == 4){
            auto it3 = randomDatabase.begin();

            for(it3=randomDatabase.begin(); it3!=randomDatabase.end();it3++){

                QString numbers = it3.value();
                QString glass_id = it3.key();

                if(player == "1"){
                    player1.insert(numbers, glass_id);
                    player1Exit.insert(glass_id,"0");

                    visibleCrossGlassID(QString::number(glass_id.toInt()), true);
                    enableCrossNumber(QString::number(glass_id.toInt()), false);

                    randomDatabase.erase(it3);
                    break;
                } else if(player == "2"){
                    player2.insert(numbers, glass_id);
                    player2Exit.insert(glass_id,"0");

                    visibleCrossGlassID(QString::number(glass_id.toInt()), true);
                    enableCrossNumber(QString::number(glass_id.toInt()), false);

                    randomDatabase.erase(it3);
                    break;
                } else if(player == "3"){
                    player3.insert(numbers, glass_id);
                    player3Exit.insert(glass_id,"0");

                    visibleCrossGlassID(QString::number(glass_id.toInt()), true);
                    enableCrossNumber(QString::number(glass_id.toInt()), false);

                    randomDatabase.erase(it3);
                    break;
                } else if(player == "4"){
                    player4.insert(numbers, glass_id);
                    player4Exit.insert(glass_id,"0");

                    visibleCrossGlassID(QString::number(glass_id.toInt()), true);
                    enableCrossNumber(QString::number(glass_id.toInt()), false);

                    randomDatabase.erase(it3);
                    break;
                }
            }
        }
        j++;
    }

    if(round == 3 || round == 4){
        newLine = true;
    }
}

void Backend::randonGenerateCus(int random)
{
    if(random == 2){
        randomCups = true;
    } else if(random == 0){
        randomCups = false;
    }
}

void Backend::passPointer(KUKAGameControl *g)
{
    gameControl = g;
}

void Backend::restartGame()
{
    qDebug() << "hhhhhhhhhhhhhhhhhhhhh              Game Restart";

    delay(3000);
    gameControl = new KUKAGameControl();
    threadRobotGame = new QThread();
    gameControl->moveToThread(threadRobotGame);
    connect(gameControl, &KUKAGameControl::gameFinished, this, &Backend::restartGame);
    // start robot game when thread starts
    connect(threadRobotGame, &QThread::started, gameControl, &KUKAGameControl::startGame);
    // clear thread
    connect( gameControl, &KUKAGameControl::gameFinished, threadRobotGame, &QThread::quit);
    connect( gameControl, &KUKAGameControl::gameFinished, gameControl, &KUKAGameControl::deleteLater);
    connect( threadRobotGame, &QThread::finished, threadRobotGame, &QThread::deleteLater);
    //receive number to choose cup
    //    connect(gameControl, &KUKAGameControl::sendNumberToMain, this, &Backend::crossGlassID);

    //    connect( gameControl, &KUKAGameControl::gameFinished, [&] (){
    //        threadRobotGame->quit();
    //        threadRobotGame->deleteLater();
    //        gameControl->deleteLater();
    //    });



    connect(gameControl, &KUKAGameControl::sendNumberToMain, [&] (QString number){
        crossGlassID(number);
        qDebug() << "iiiiiiiiiiiiiiiiiiiiiiiiiii";
        playSound("ok");
    });

    //    connect(gameControl, &KUKAGameControl::playSound, this, &Backend::playSound);

    connect(gameControl, &KUKAGameControl::playSound, [&] (QString audio){
        playSound(audio);
    });

    connect(gameControl, &KUKAGameControl::newImage, [&] (QImage image){
        emit newImage(image);
    });
    //    connect(this, &Backend::newImage, liveImageProvider, &OpencvImageProvider::updateImage);

    //    connect(gameControl, &KUKAGameControl::sendImgToMain, this, &Backend::crossGlassID);
    threadRobotGame->start();

}

void Backend::getRound_2(int round)
{
    if(round >= 8){
        newLine = true;
    }  else {
        newLine = false;
    }
}

void Backend::writeSound(QString sound)
{
    if(sound == "0"){
        soundAlarm = false;
        soundPlayer->stop();
    } else if (sound == "1"){
        soundAlarm = true;
        playSound("intro");
    }
}

void Backend::stopThread(bool stop)
{
    if(stop == true){
        gameControl->deleteLater();
        threadRobotGame->quit();
        threadRobotGame->deleteLater();
    }
}

void Backend::toastDrink(QString drink)
{
    if(drink == "1"){
        gameControl->drink = "1";
        qDebug() << "                       bebe";
    } else if(drink == "0"){
        gameControl->drink = "0";
    }
}

const QString &Backend::getComboBox() const
{
    return comboBox;
}


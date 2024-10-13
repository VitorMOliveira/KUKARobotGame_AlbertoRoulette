#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QFile>
#include <QEventLoop>
#include <QTimer>
#include <QMediaPlayer>
#include <QRandomGenerator>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QJsonDocument>
#include <QBuffer>
#include <QTcpSocket>
#include <QThread>
#include <QtConcurrent>
#include <QFuture>

#include "kukavarproxy_msg_format.h"
#include "kukagamecontrol.h"
#include "opencvimageprovider.h"

//#include <opencv2/highgui.hpp>
//#include <opencv2/core.hpp>
//using namespace cv;

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr,
                     QQmlApplicationEngine *engine = nullptr);

    const QString &getComboBox() const;

public slots:
    void getNumbersPlayers(QString numberPlayersQML);
    void chooseTableNumbers(QString numberChoose);
    void getOrderPlayers(QString order);
    void writeListNumberChoose(QString glass_id);
    void clearQList(bool clear);
    void readFileTXT(QString url, QString Qmap);
    void readFileTXT2(QString url);
    QString writeNumbersOrderly(QString number);
    void writeListNumbersQML(QMap<QString, QString> player);
    void orderlyTextNumbers();
    void nextPageQML(QMap<QString, QString> player1, QMap<QString, QString> player2, QMap<QString, QString> player3, QMap<QString, QString>player4);
    QString getNumberComboBox(QString comboBox);
    void crossGlassID(QString glass_id);
    QString getGlassIDQMap(QMap<QString, QString> player, QString number);
    int drinkPlayer(QString player, QString glass_id);
    void delay(qreal time);
    void playerWinner(int glass, int player);
    void playSound(QString sound);
    void generateRandomCups(QString cups, QString player, int plays);

    void randonGenerateCus(int random);
    void passPointer(KUKAGameControl *g);
    void restartGame();
    void getRound_2(int round);
    void writeSound(QString sound);
    void stopThread(bool stop);
    void toastDrink(QString drink);

signals:
    void numberPlayersQML(qreal number);
//    void playerOrder(QString order, QString numbers);
    void textNumberChooseQML(QString textNumberPlayersQML);
    void clearTextQML(bool clear);
    void crossInvisible(bool invisible);
    void enableCrossNumber(QString number, bool enable);
    void nextPage(bool next);
    void orderPlayersQML(QString orderQML);
    void informationPlayerDinks(QString player, bool rectangle);
    void visibleCrossGlassID(QString glass_id, bool visible);

    void sendGameControlCup(int position, int glassID);
    void newImage(QImage &);

private:
    QQmlApplicationEngine *m_engine;

    QString numberText;
    QMap<QString, QString> player1, player2, player3, player4;
    QMap<QString, QString> player1Exit, player2Exit, player3Exit, player4Exit;
    QMap<QString, QString> database;
    QMap<QString, QString> randomDatabase;
    QMap<int, QString> glassRobot;
    qreal playersQML;
    QString numberPlayersChoose;
    QString numberChooseWriteList;
    QString orderplayers = "0";
    QString backOrderPlayers;
    QString textNumberPlayersQML = "";
    QString comboBox;
    int position_1=1, position_2=9, position_3=5, position_4=13;
    QString urlGlassID = ":/glassRobot.txt";
    QString urlDatabase = ":/database.txt";
    QString urlRandomDatabase = ":/randomDatabase.txt";
    QMediaPlayer *soundPlayer;
    QMediaPlaylist *playlist;
    bool randomCups = true;
    int round = 0;
    bool newLine = false;
    QThread* threadRobotGame;
    QPixmap img;
    KUKAGameControl *gameControl;
    KUKAGameControl *h;
    OpencvImageProvider *liveImageProvider;
    bool soundAlarm;
    int a = 1;
    // verificar se scolheu numero e caso não tenha escolhido nao deixa avançar - feito
    // contador para contar o numero de copos selecionados para permitir a passagem de layout - feito
    // ordenar valores apresentados nas text do qml

    //criar random para escolher varios copos
    //player 1 - 2 -2 -1 -> order de seleção
};

#endif // BACKEND_H

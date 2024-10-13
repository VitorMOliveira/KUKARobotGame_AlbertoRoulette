#ifndef KUKAVARPROXY_MSG_FORMAT_H
#define KUKAVARPROXY_MSG_FORMAT_H

#include <QDebug>
#include <QTcpSocket>
#include <QTime>
#include <QElapsedTimer>

class kukavarproxy_msg_format: public QObject {
    Q_OBJECT
public:
    kukavarproxy_msg_format(QString IP, int port, int timeout);

    QByteArray value_received;

private slots:
    QByteArray formatMsg(QByteArray msg, unsigned short idMsg);

    QByteArray formatMsg(QByteArray msg, QByteArray value, unsigned short idMsg);

    unsigned short clearMsg(QByteArray msg, QByteArray &value);

public slots:
    bool readValueToRobot(QByteArray var, int token);

    bool writeValueToRobot(QByteArray var, QByteArray val, int token);

signals:
    void msgReceived();

private:
    QTcpSocket socketClient;
    QTime readtime;

    QString m_IP;
    int m_port, m_timeout;

};

#endif // KUKAVARPROXY_MSG_FORMAT_H
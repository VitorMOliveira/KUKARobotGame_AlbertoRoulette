#include "kukavarproxy_msg_format.h"

kukavarproxy_msg_format::kukavarproxy_msg_format(QString IP, int port, int timeout) {
    m_IP = IP;
    m_port = port;
    m_timeout = timeout;

}

bool kukavarproxy_msg_format::readValueToRobot(QByteArray var, int token) {
    QElapsedTimer readtime;

    socketClient.connectToHost(m_IP, m_port);

    readtime.start();

    if (!socketClient.waitForConnected(m_timeout)) {
        qDebug() << "Timeout connection!";
        return -1;
    }

    //read variable
    socketClient.write(formatMsg(var, token));

    //write varibel
    //socketClient.write(formatMsg("$OV_PRO","55",43981));

    if(!socketClient.waitForBytesWritten(m_timeout)) {
      qDebug() << "Timeout message sent!";
      return -1;
    }

    if (!socketClient.waitForReadyRead(m_timeout)) {
      qDebug() << "Timeout message return!";
      return -1;
    }



    QByteArray returnMsg = socketClient.read(socketClient.bytesAvailable());

    //qDebug()<<"-----------return message-----------";
    unsigned char ok = returnMsg.right(1).at(0);

    QByteArray value;
    unsigned short idMsg = clearMsg(returnMsg,value);

    //qDebug()<<"Value:"<<value;
    //qDebug()<<"Read Time:"<<readtime.elapsed()<<"ms";

    socketClient.disconnectFromHost();

    value_received = value;

    emit msgReceived();

    return 0;
}


bool kukavarproxy_msg_format::writeValueToRobot(QByteArray var, QByteArray val, int token) {
    QElapsedTimer readtime;

    socketClient.connectToHost(m_IP, m_port);

    readtime.start();

    if (!socketClient.waitForConnected(m_timeout)) {
        qDebug() << "Timeout connection!";
        return -1;
    }

    socketClient.write(formatMsg(var, val, token));

    if(!socketClient.waitForBytesWritten(m_timeout)) {
      qDebug() << "Timeout message sent!";
      return -1;
    }

    if (!socketClient.waitForReadyRead(m_timeout)) {
      qDebug() << "Timeout message return!";
      return -1;
    }
    QByteArray returnMsg = socketClient.read(socketClient.bytesAvailable());

    //qDebug()<<"-----------return message-----------";
    unsigned char ok = returnMsg.right(1).at(0);

    QByteArray value;
    unsigned short idMsg = clearMsg(returnMsg,value);

    //qDebug()<<"Value:"<<value;
    //qDebug()<<"Read Time:"<<readtime.elapsed()<<"ms";

    socketClient.disconnectFromHost();

    return 0;

}


QByteArray kukavarproxy_msg_format::formatMsg(QByteArray msg, unsigned short idMsg){

    const char READVARIABLE=0;

    QByteArray header, block;
    int lunghezza,varNameLen;
    unsigned char hByte, lByte;
    unsigned char hByteMsg,lByteMsg;

    varNameLen=msg.size();
    hByte=(varNameLen & 0xff00) >> 8;
    lByte=(varNameLen & 0x00ff);

    block.append(READVARIABLE).append(hByte).append(lByte).append(msg);
    lunghezza=block.size();

    hByte=(lunghezza & 0xff00) >> 8;
    lByte=(lunghezza & 0x00ff);

    // Message ID ( MAX: 0xFFFF )
    hByteMsg=(idMsg & 0xff00) >> 8;
    lByteMsg=(idMsg & 0x00ff);

    header.append(hByteMsg).append(lByteMsg).append(hByte).append(lByte);
    block.prepend(header);

    qDebug()<<"Message send:"<<block.toHex();

    return block;
}

QByteArray kukavarproxy_msg_format::formatMsg(QByteArray msg, QByteArray value, unsigned short idMsg){

    const char WRITEVARIABLE=1;

    QByteArray header, block;
    short lunghezza,varNameLen,varValueLen;
    unsigned char hByte, lByte;
    unsigned char hByteMsg,lByteMsg;

    varNameLen=msg.size();
    hByte=(varNameLen & 0xff00) >> 8;
    lByte=(varNameLen & 0x00ff);

    block.append(WRITEVARIABLE).append(hByte).append(lByte).append(msg);

    varValueLen=value.size();
    hByte=(varValueLen & 0xff00) >> 8;
    lByte=(varValueLen & 0x00ff);

    block.append(hByte).append(lByte).append(value);

    lunghezza=block.size();

    hByte=(lunghezza & 0xff00) >> 8;
    lByte=(lunghezza & 0x00ff);

    hByteMsg=(idMsg & 0xff00) >> 8;
    lByteMsg=(idMsg & 0x00ff);

    header.append(hByteMsg).append(lByteMsg).append(hByte).append(lByte);
    block.prepend(header);

    qDebug()<<"Message send:"<<block.toHex();

    return block;
}

unsigned short kukavarproxy_msg_format::clearMsg(QByteArray msg, QByteArray &value){

    short lenMsg,func,lenValue;
    unsigned short idReadMsg;

    if(msg.size() > 0){
        //Message ID
        idReadMsg=((unsigned char)msg[0])<<8 | ((unsigned char)msg[1]);
        //qDebug() << "Message ID: " << idReadMsg;

        //Message Length
        lenMsg=((unsigned char)msg[2])<<8 | ((unsigned char)msg[3]);
        //qDebug() << "Message Length:" << lenMsg;

        //Function(read:0/Write:1)
        func=((int)msg[4]);
        //qDebug() << "Function(read:0/Write:1) " << func;

        //Value Length
        lenValue=((unsigned char)msg[5])<<8 | ((unsigned char)msg[6]);
        //qDebug() << "Value Length:" << lenValue;

        //qDebug() << "Message return:" << msg.toHex();

        // the byte7 begin the value
        value = msg.mid(7,lenValue);
        return idReadMsg;

    }
    else{
        value = QByteArray("");
        return 0;
    }
}
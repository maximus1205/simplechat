#ifndef CLIENT_H
#define CLIENT_H
#include <QDataStream>
#include <QSqlDatabase>
#include <QSql>
#include <QDir>
#include <QSqlError>
#include <QSqlQuery>
#include <io.h>
#include <winsock.h>
#include <QDebug>
#include <thread>
#include <string>
#include <vector>

using namespace std;

class client : public QObject
{
    Q_OBJECT
public:
    explicit client(QObject *parent = nullptr);
signals:

public slots:
    void send(QString message);
    void conxnect();
    QString readData();
    void dbSend(QString name, QString id);
    QString readName();
    QString readID();
    bool next();
    QString parse();
    QString getparsID();
    void setparsID(QString isd);
    void add(QString name, QString id);
    QString containsname(QString id2);
    void remove(QString name, QString idx);
};

#endif // CLIENT_H

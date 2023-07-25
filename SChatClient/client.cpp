#include "client.h"

SOCKET Connection;
QSqlDatabase db;
QSqlQuery *query;

char msg[256];

QString message;
QString vxccv;

QString toid;
QString fromid;

QString names[100];

std::vector<std::string> splitString(std::string str, char splitter) {
    std::vector<std::string> result;
    std::string current = "";
    for (int i = 0; i < str.size(); i++) {
        if (str[i] == splitter) {
            if (current != "") {
                result.push_back(current);
                current = "";
            }
            continue;
        }
        current += str[i];
    }
    if (current.size() != 0)
        result.push_back(current);
    return result;
}


bool FileExists(const char *fname)
            {
              return access(fname, 0) != -1;
            }


void zxc()
{
    int msg_size = 0;
    int msg_sizes;

    vector<string> strings;
    while (true)
    {
        Sleep(1000);
        message = "";

        recv(Connection, (char*)&msg_sizes, sizeof(int), NULL);
        recv(Connection, (char*)&msg_size, sizeof(int), NULL);
        char* zxx = new char[msg_size + 1];
        zxx[msg_size] = '\0';
        recv(Connection, zxx, msg_size, NULL);
        strings = splitString(QString(zxx).toStdString(), '-');


        message = QString(strings[0].c_str());
        fromid = QString::number(msg_sizes);
        qDebug() << fromid;
        delete[] zxx;
    }
}

client::client(QObject *parent) : QObject(parent)
{
    WSAData wsaData;
        WORD DLLVersion = MAKEWORD(2, 1);
        if (WSAStartup(DLLVersion, &wsaData) != 0)
        {
            exit(1);
        }

    SOCKADDR_IN addr;
        addr.sin_addr.s_addr = inet_addr("192.168.0.189");
        addr.sin_port = htons(25565);
        addr.sin_family = AF_INET;

        Connection = socket(AF_INET, SOCK_STREAM, NULL);
        if (::connect(Connection, (SOCKADDR*)&addr, sizeof(addr)) != 0)
        {
            qDebug() << "pizdaa";
            exit(0);
        }
        qDebug() << "Connected";
        std::thread h(zxc);
        h.detach();

}

QString client::containsname(QString id2)
{
    if (names[id2.toInt()] != "")
    {
        qDebug() << names[id2.toInt()];
        return names[id2.toInt()];
    }

    return id2;
}

void client::remove(QString name, QString idx)
{
    query->prepare("DELETE FROM users WHERE name = ?");
    query->addBindValue(name);
    query->exec();

    query->prepare("DELETE FROM users WHERE id = ?");
    query->addBindValue(idx);
    query->exec();
    names[idx.toInt()] = "";
}

void client::send(QString message)
{
    message.remove("Ваш id: ");
    message.remove("id: ");
    QString h = QString(message + "-" + toid.toStdString().c_str());
    int msg_size = h.toStdString().size();
    ::send(Connection, (char*)&msg_size, sizeof(int), NULL);

    ::send(Connection, std::string(message.toStdString() + "-" + toid.toStdString()).c_str(), msg_size, NULL);
    qDebug() << message.toStdString().c_str();
}

void client::add(QString name, QString id)
{
     id.remove("id: ");
     names[id.toInt()] = name;
}

void client::setparsID(QString isd)
{
    isd.remove("id: ");
    toid = isd;
}

QString client::getparsID()
{
    return fromid;
}

QString client::readData()
{
    return message;
}

QString client::parse()
{
     vector<string> strings = splitString(message.toStdString(), '-');
     return QString(strings[0].c_str());
}

void client::conxnect()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("C:\\Users\\" + QDir::home().dirName() + "\\AppData\\Local\\ChatS\\users.db");
    if(!FileExists(std::string("C:\\Users\\" + QDir::home().dirName().toStdString() + "\\AppData\\Local\\ChatS\\users.db").c_str()))
    {
        db.open();
        query = new QSqlQuery(db);
        QString str = "CREATE TABLE users ("
                    "name VARCHAR(255),"
                      "id integer"
                    ");";
        query->exec(str);
    }
    else
    {
        query = new QSqlQuery(db);
    }


    db.open();
    query->exec("SELECT * FROM users");

}

void client::dbSend(QString name, QString id)
{
    query->prepare("INSERT INTO users(name, id) VALUES (?, ?);");
        query->addBindValue(name);
        query->addBindValue(id);
        query->exec();
}



bool client::next()
{
    return query->next();
}

QString client::readName()
{
    return query->value(0).toString();
}

QString client::readID()
{
    return query->value(1).toString();
}

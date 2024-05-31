#ifndef BACKEND_H
#define BACKEND_H

#include <Calculator.h>
#include <QObject>
#include <QtQml>

class Backend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit Backend(QObject *parent = nullptr);
    Q_INVOKABLE void appendToQuery(QString str);
    Q_INVOKABLE void appendBrackets();
    Q_INVOKABLE void clearQuery();
private:
    QString _query = "";
    QString _result = "";
signals:
    void queryChanged(QString query);
    void resultChanged(QString result);
};

#endif // BACKEND_H

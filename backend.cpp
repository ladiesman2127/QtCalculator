#include "backend.h"

Backend::Backend(QObject *parent)
    : QObject{parent}
{}

void Backend::appendToQuery(QString ch)
{
    _query = Calculator::processExpression(_query + ch);
    emit queryChanged(_query);
    _result = Calculator::calculate(_query);
    if(_result != "INVALID EXPRESSION")
        emit resultChanged(_result);
}

void Backend::appendBrackets()
{
    int openBracketsCount = _query.count('(');
    int closeBracketsCount = _query.count(')');
    _query += openBracketsCount > closeBracketsCount ? ')' : '(';
    _query = Calculator::processExpression(_query);
    emit queryChanged(_query);
    _result = Calculator::calculate(_query);
    if(_result != "INVALID EXPRESSION")
        emit resultChanged(_result);
}

void Backend::clearQuery()
{
    _query.clear();
    _result = "";
    emit resultChanged(_result);
    emit queryChanged(_query);
}

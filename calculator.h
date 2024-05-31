#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QString>
#include <QStack>
#include <QtMath>

class Calculator
{
public:
    Calculator();
    static QString calculate(QString& infix);
    static QString processExpression(QString& expression);
private:
    inline const static QString INVALID_EXPRESSION = "INVALID EXPRESSION";
    static int precedence(QChar ch);
    static double calculateOperation(QChar operation, double& o1, double& o2);
    static bool performOperation(QStack<QChar>& operators, QStack<double>& operands);
};

#endif // CALCULATOR_H

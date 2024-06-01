#include "calculator.h"
#include <QDebug>

Calculator::Calculator() {}

QString Calculator::calculate(QString &infix)
{
    QStack<double> operandsStack;
    QStack<QChar> operatorsStack;
    QString curOperand = "";
    for(int i = 0; i < infix.size(); ++i) {
        const QChar &ch = infix[i];
        if(!ch.isDigit()) {
            if(ch == '.' && curOperand.contains('.')) {
                return INVALID_EXPRESSION;
            } else if(ch == '(') {
                operatorsStack.push(ch);
            } else if(ch == ')') {
                // qDebug() << operatorsStack << '\n';
                // qDebug() << operandsStack << '\n';
                while(!operatorsStack.isEmpty() && operatorsStack.top() != '(') {
                    if(operatorsStack.top() != '(') {
                        if(!performOperation(operatorsStack, operandsStack))
                        return INVALID_EXPRESSION;
                    }
                }
                if(operatorsStack.isEmpty()) return INVALID_EXPRESSION;
                operatorsStack.pop();
            } else if(ch == '-') {
                if(i == 0 || infix[i - 1] == '(') {
                    curOperand = "-";
                } else if(!curOperand.isEmpty()) {
                    operandsStack.push(curOperand.toDouble());
                    curOperand.clear();
                    operatorsStack.push(ch);
                }
            } else {
                if(!curOperand.isEmpty()) {
                    operandsStack.push(curOperand.toDouble());
                    curOperand.clear();
                }
                while(!operatorsStack.isEmpty() && precedence(operatorsStack.top()) >= precedence(ch)) {
                    if(!performOperation(operatorsStack, operandsStack)) return  INVALID_EXPRESSION;
                }
                operatorsStack.push(ch);
            }
        } else {
            curOperand += ch;
        }
    }
    if(!curOperand.isEmpty()) {
        operandsStack.push(curOperand.toDouble());
        curOperand.clear();
    }
    while(!operatorsStack.isEmpty()) {
        if(!performOperation(operatorsStack, operandsStack))
            return INVALID_EXPRESSION;
    }
    return operandsStack.isEmpty() ? INVALID_EXPRESSION : QString::number(operandsStack.pop());
}


int Calculator::precedence(QChar ch)
{
    if (ch == '^')
        return 3;
    else if(ch == '*' || ch == '/')
        return 2;
    else if (ch == '+' || ch == '-')
        return 1;
    else
        return -1;
}

QString Calculator::processExpression(QString expression)
{
    if(expression.isEmpty()) return "";
    if(expression.size() == 1) return (expression[0].isDigit() || expression[0] == '(') ? expression : "";
    QChar lastCh = expression[expression.size() - 1];
    QChar prevLastCh = expression[expression.size() - 2];
    // qDebug() << expression;
    // qDebug() << prevLastCh << ' ' << lastCh;
    if(!lastCh.isDigit() && !prevLastCh.isDigit()) {
        if(((prevLastCh == '^' || prevLastCh == '(') && lastCh == '-') || lastCh == '.' || lastCh == '(') return expression;
        return expression.left(expression.size() - 2).append(lastCh);
    } else {
        return expression;
    }
}

double Calculator::calculateOperation(QChar operation, double &o1, double &o2)
{
    qDebug() << o1 << operation << o2 << '\n';
    double res = 0.0;
    if(operation == '+')
        res =  o1 + o2;
    else if(operation == '-')
        res = o1 - o2;
    else if(operation == '*')
        res = o1 * o2;
    else if(operation == '/')
        res = o1 / o2;
    else if(operation == '^')
        res = qPow(o1, o2);
    qDebug() << "CalculateOperation" << res << '\n';
    return res;
}

bool Calculator::performOperation(QStack<QChar> &operators, QStack<double> &operands)
{
    if(operands.size() == 1) return false;
    auto operation = operators.pop();
    if(operands.isEmpty()) return false;
    auto operand2 = operands.pop();
    if(operands.isEmpty()) return false;
    auto operand1 = operands.pop();
    auto operationRes = calculateOperation(operation, operand1, operand2);
    operands.push(operationRes);
    return true;
}

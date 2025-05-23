/****************************************************************************
** Copyright (c) ALMEX INC. All rights reserved.
****************************************************************************/
#ifndef SF2_2_TERMSANDCONDITIONS_H
#define SF2_2_TERMSANDCONDITIONS_H

#include <QObject>
#include <QQmlEngine>

class SF2_2_TermsAndConditions : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit SF2_2_TermsAndConditions(QObject *parent = nullptr);

signals:
};

#endif // SF2_2_TERMSANDCONDITIONS_H

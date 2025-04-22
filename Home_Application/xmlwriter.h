#ifndef XMLWRITER_H
#define XMLWRITER_H

#include <QObject>
#include <QtXml>
#include <QFile>
#include "applicationmodel.h"
class xmlWriter : public QObject
{
    Q_OBJECT
public:
    explicit xmlWriter(QString filePath, ApplicationModel &savedData, QObject *parent = nullptr);
    Q_INVOKABLE void saveDataAppMenu();

private:

    void writeXML(QDomDocument document);

    QDomDocument convertData(QList<ApplicationItem> listApp);
    QString filePath;
    ApplicationModel * model;
};

#endif // XMLWRITER_H

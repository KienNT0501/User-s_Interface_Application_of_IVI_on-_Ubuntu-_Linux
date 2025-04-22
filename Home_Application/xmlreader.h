#ifndef XMLREADER_H
#define XMLREADER_H


#include <QtXml>
#include <QFile>
#include "applicationmodel.h"

class xmlReader
{

public:
   explicit xmlReader(QString filePath, ApplicationModel &model);
private:
    QDomDocument m_xmlDoc; //The QDomDocument class represents an XML document.
    bool ReadXmlFile(QString filePath);
    void PaserXml(ApplicationModel &model);

};

#endif // XMLREADER_H

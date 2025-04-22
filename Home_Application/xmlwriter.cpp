#include "xmlwriter.h"
#include <QDebug>
xmlWriter::xmlWriter(QString filePath, ApplicationModel &savedData, QObject *parent) : QObject(parent)
{
    QString path = PROJECT_PATH + filePath;
    this->filePath = path;
    model = &savedData;
}

void xmlWriter::saveDataAppMenu()
{
    QDomDocument document = convertData(model->getSavedData());
    writeXML(document);
}

QDomDocument xmlWriter::convertData(QList<ApplicationItem> listApp)
{
    QDomDocument document;
    QDomElement root = document.createElement("APPLICATIONS");
    document.appendChild(root);

    for (int i = 0; i < listApp.count(); i++)
    {
        QDomElement app = document.createElement("APP");
        ApplicationItem item = listApp[i];

       // app.setAttribute("ID", item.ID());
        root.appendChild(app);
        //*********************************************************************************************************

        QDomElement title = document.createElement("TITLE");
        app.appendChild(title);

        QDomNode str_title = document.createTextNode(item.title());
        title.appendChild(str_title);
        //*********************************************************************************************************

        QDomElement url = document.createElement("URL");
        app.appendChild(url);

        QDomNode str_url = document.createTextNode(item.url());
        url.appendChild(str_url);
        //*********************************************************************************************************

        QDomElement icon_path = document.createElement("ICON_PATH");
        app.appendChild(icon_path);

        QDomNode str_icon_path = document.createTextNode(item.iconPath());
        icon_path.appendChild(str_icon_path);

    }
    return document;
}

void xmlWriter::writeXML(QDomDocument document)
{
    QFile f(filePath);
    if (!f.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qDebug() << "Cannot open file---->XmlWriter";
        return;
    }

    QTextStream stream(&f);
    stream << document.toString();
    f.close();
}


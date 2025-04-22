#ifndef APPLICATIONMODEL_H
#define APPLICATIONMODEL_H

#include <QAbstractListModel>

class ApplicationItem {
public:
    ApplicationItem(QString title, QString url, QString iconPath);

    QString title() const;

    QString url() const;

    QString iconPath() const;

private:
    QString m_title;
    QString m_url;
    QString m_iconPath;
};

class ApplicationModel:public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        TitleRole = Qt::UserRole + 1,
        UrlRole,
        IconPathRole
    };
    explicit ApplicationModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
   void addApplication(ApplicationItem &item);
   Q_INVOKABLE void addApplication(int pos, QString title, QString url, QString iconPath);
   QList<ApplicationItem> getSavedData();
   void cloneData();
protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<ApplicationItem> m_data;
    QList<ApplicationItem> m_savedData;
};

#endif // APPLICATIONMODEL_H

#include "applicationmodel.h"

ApplicationItem::ApplicationItem(QString title, QString url, QString iconPath)
{
    m_title = title;
    m_url = url;
    m_iconPath = iconPath;

}

QString ApplicationItem::title() const
{
    return m_title;
}

QString ApplicationItem::url() const
{
    return m_url;
}

QString ApplicationItem::iconPath() const
{
    return m_iconPath;
}

ApplicationModel::ApplicationModel(QObject *parent)
{
    Q_UNUSED(parent)
    //m_savedData = m_data;
}

int ApplicationModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant ApplicationModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    const ApplicationItem &item = m_data[index.row()];
    if (role == TitleRole)
        return item.title();
    else if (role == UrlRole)
        return item.url();
    else if (role == IconPathRole)
        return item.iconPath();
    return QVariant();
}

void ApplicationModel::addApplication(ApplicationItem &item)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << item;
    endInsertRows();
}

void ApplicationModel::addApplication(int pos, QString title, QString url, QString iconPath)
{
    ApplicationItem item(title, url, iconPath);

      // Ensure the list has enough elements
      if (pos >= m_savedData.size()) {
          while (m_savedData.size() <= pos) {
              m_savedData.append(ApplicationItem("", "", ""));  // Fill empty spots
          }
      }

      m_savedData[pos] = item;
}

QList<ApplicationItem> ApplicationModel::getSavedData()
{
    return m_savedData;
}
void ApplicationModel::cloneData()
{
    for (int i = 0; i < m_data.count(); i++) {
       // m_savedData << m_data[i];
    }
}

QHash<int, QByteArray> ApplicationModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[UrlRole] = "url";
    roles[IconPathRole] = "iconPath";
    return roles;
}

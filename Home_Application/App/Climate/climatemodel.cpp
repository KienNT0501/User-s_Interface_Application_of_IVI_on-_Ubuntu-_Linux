#include "climatemodel.h"
#include <QDebug>
#include <QDBusInterface>
#include <QDBusReply>
#include "climate.h"
#include <QTimer>
ClimateModel::ClimateModel(QObject *parent) : QObject(parent) {

     QDBusConnection bus = QDBusConnection::sessionBus();
    bool success = bus.connect("com.DbusService", "/Climate",
                                    "com.DbusService", "temp_driverChanged",
                                     this, SLOT(onTemp_driverChanged(double)));
           bus.connect("com.DbusService", "/Climate",
                                             "com.DbusService", "temp_passengerChanged",
                                             this, SLOT(onTemp_passengerChanged(double)));
           bus.connect("com.DbusService", "/Climate",
                                             "com.DbusService", "fan_speedChanged",
                                             this, SLOT(onFan_speedChanged(int)));
           bus.connect("com.DbusService", "/Climate",
                                             "com.DbusService", "driverWind_modeChanged",
                                             this, SLOT(onDriverWind_modeChanged(int)));
           bus.connect("com.DbusService", "/Climate",
                                             "com.DbusService", "passengerWind_modeChanged",
                                             this, SLOT(onPassengerWind_modeChanged(int)));
           bus.connect("com.DbusService", "/Climate",
                                                    "com.DbusService", "auto_modeChanged",
                                                    this, SLOT(onAuto_modeChanged(int)));
           bus.connect("com.DbusService", "/Climate",
                                                    "com.DbusService", "sync_modeChanged",
                                                    this, SLOT(onSync_modeChanged(int)));
           if (success) {
               qDebug() << " D-Bus connection to temp_driverChanged is successful!";
           } else {
               qWarning() << " Failed to connect to D-Bus signal! Error: " << bus.lastError().message();
           }
           QDBusInterface iface("com.DbusService", "/Climate",
                                "com.DbusService", bus);

               if (iface.isValid()) {
                   QDBusReply<void> reply = iface.call("openAppSignal", 100);  // any startup value
                   if (!reply.isValid()) {
                       qWarning() << "D-Bus call to setValue failed:" << reply.error().message();
                   } else {
                       qDebug() << "Notified DbusService via openAppSignal(100)";
                   }
               } else {
                   qWarning() << "Failed to create D-Bus interface for sending value";
               }
}

double ClimateModel::GetDriverTemperature()
{
    return m_driver_temp;
}

double ClimateModel::GetPassengerTemperature()
{
    return m_passenger_temp;
}

int ClimateModel::GetFanLevel()
{
    return m_fan_level;
}

int ClimateModel::GetDriverWindMode()
{
    return m_driver_wind_mode;
}

int ClimateModel::GetPassengerWindMode()
{
    return m_passenger_wind_mode;
}

int ClimateModel::GetAutoMode()
{
    return m_auto_mode;
}

int ClimateModel::GetSyncMode()
{

    return m_sync_mode;
}

void ClimateModel::onTemp_driverChanged(double newVal)
{
    qDebug() << " Received D-Bus signal temp_driverChanged. New Value:" << newVal;

        if (m_driver_temp != newVal) {
            m_driver_temp = newVal;
            emit temp_driverChanged(newVal);
            qDebug() << " Emitting temp_driverChanged to QML!";
        } else {
            qDebug() << " Signal received but no change in value!";
        }
}

void ClimateModel::onTemp_passengerChanged(double newVal)
{
    qDebug() << " Received D-Bus signal temp_passengerChanged. New Value:" << newVal;

        if (m_passenger_temp != newVal) {
            m_passenger_temp = newVal;
            emit temp_passengerChanged(newVal);
            qDebug() << " Emitting temp_passengerChanged to QML!";
        } else {
            qDebug() << " Signal received but no change in value!";
        }
}

void ClimateModel::onFan_speedChanged(int newVal)
{
    qDebug() << " Received D-Bus signal fan_speedChanged. New Value:" << newVal;

        if (m_fan_level != newVal) {
            m_fan_level = newVal;
            emit fan_speedChanged(newVal);
            qDebug() << " Emitting fan_speedChanged to QML!";
        } else {
            qDebug() << " Signal received but no change in value!";
        }
}

void ClimateModel::onDriverWind_modeChanged(int newVal1)
{
    qDebug() << " Received D-Bus signal driverWind_modeChanged. New Value:" << newVal1;

        if (m_driver_wind_mode != newVal1) {
            m_driver_wind_mode = newVal1;
            emit driverWind_modeChanged(m_driver_wind_mode);
            qDebug() << " Emitting driverWind_modeChanged to QML!";
        } else {
            qDebug() << " Signal received but no change in value!";
        }
}

void ClimateModel::onPassengerWind_modeChanged(int newVal2)
{
    qDebug() << " Received D-Bus signal PassengerWind_modeChanged. New Value:" << newVal2;

        if (m_passenger_wind_mode != newVal2) {
            m_passenger_wind_mode = newVal2;
            emit passengerWind_modeChanged(m_passenger_wind_mode);
            qDebug() << " Emitting driverWind_modeChanged to QML!";
        } else {
            qDebug() << " Signal received but no change in value!";
        }
}

void ClimateModel::onSync_modeChanged(int newVal)
{
    qDebug() << " Received D-Bus signal autoSync_modeChanged. New Value:" << newVal;

        if (m_sync_mode != newVal) {
            m_sync_mode = newVal;
            emit sync_modeChanged(m_sync_mode);
            qDebug() << " Emitting m_sync_mode to QML!";
        } else {
            qDebug() << " Signal received but no change in value!";
        }
}

void ClimateModel::onAuto_modeChanged(int newVal)
{
    qDebug() << " Received D-Bus signal autoMode_modeChanged. New Value:" << newVal;

        if (m_auto_mode != newVal) {
            m_auto_mode = newVal;
            emit auto_modeChanged(m_auto_mode);
            qDebug() << " Emitting m_auto_mode to QML!";
        } else {
            qDebug() << " Signal received but no change in value!";
        }
}

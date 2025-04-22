#include "climate.h"
#include <QDebug>
#include <QDBusMessage>
Climate::Climate(QObject *parent) : QObject(parent)
{
  m_auto_mode =0;
  m_driver_temp = 0 ;
  m_fan_level = 0;
  m_passenger_wind_mode = 0;
  m_sync_mode = 0;
  m_driver_temp = 16.5;
  m_passenger_temp = 16.5;
}
void Climate::openAppSignal(int newVal)
{
    emit auto_modeChanged(m_auto_mode);
    emit driverWind_modeChanged(m_driver_wind_mode);
    emit fan_speedChanged(m_fan_level);
    emit passengerWind_modeChanged(m_passenger_wind_mode);
    emit sync_modeChanged(m_sync_mode);
    emit temp_driverChanged(m_driver_temp);
    emit temp_passengerChanged(m_passenger_temp);
     qDebug() << "UPDATE DATA FROM HOME APPLICATION!. New Value:" << newVal;
}
int Climate::getAuto_mode()
{
    return m_auto_mode;
}

int Climate::getDriverWind_mode()
{
    return m_driver_wind_mode;
}

int Climate::getFan_speed()
{
    return m_fan_level;
}

int Climate::getPassengerWind_mode()
{
    return m_passenger_wind_mode;
}

int Climate::getSync_mode()
{
    return m_sync_mode;
}

double Climate::getTemp_driver()
{
    return m_driver_temp;
}

double Climate::getTemp_passenger()
{
    return m_passenger_temp;
}

void Climate::setAuto_mode(int auto_mode)
{
     m_auto_mode = auto_mode;
      qDebug() << " Emitting  auto_mode Signal! New auto_mode: " <<    m_auto_mode ;
     emit auto_modeChanged(m_auto_mode);
     QDBusMessage message = QDBusMessage::createSignal("/Climate", "com.DbusService", "auto_modeChanged");
     message << m_auto_mode ;
     QDBusConnection::sessionBus().send(message);
     qDebug() << " Manually sent m_auto_mode over D-Bus!";
}

void Climate::setDriverWind_mode(int driver_wind_mode)
{
     m_driver_wind_mode = driver_wind_mode;
      qDebug() << " Emitting  m_driver_wind_mode Signal! New m_driver_wind_mode: " <<   m_driver_wind_mode ;
     emit driverWind_modeChanged(m_driver_wind_mode);
     QDBusMessage message = QDBusMessage::createSignal("/Climate", "com.DbusService", "driverWind_modeChanged");
     message << m_driver_wind_mode ;
     QDBusConnection::sessionBus().send(message);
     qDebug() << " Manually sent m_driver_wind_mode over D-Bus!";
}

void Climate::setFan_speed(int fan_speed)
{
     m_fan_level = fan_speed;
     emit fan_speedChanged(m_fan_level);
     QDBusMessage message = QDBusMessage::createSignal("/Climate", "com.DbusService", "fan_speedChanged");
     message << m_fan_level;
     QDBusConnection::sessionBus().send(message);

     qDebug() << " Manually sent fan_speedChanged over D-Bus!";
}

void Climate::setPassengerWind_mode(int passenger_wind_mode)
{
    m_passenger_wind_mode = passenger_wind_mode;
    qDebug() << " Emitting  m_passenger_wind_mode Signal! New m_passenger_wind_mode: " <<   m_passenger_wind_mode ;
    emit passengerWind_modeChanged(m_passenger_wind_mode);
    QDBusMessage message = QDBusMessage::createSignal("/Climate", "com.DbusService", "passengerWind_modeChanged");
    message << m_passenger_wind_mode ;
    QDBusConnection::sessionBus().send(message);
    qDebug() << " Manually sent m_passenger_wind_mode over D-Bus!";
}

void Climate::setSync_mode(int sync_mode)
{
    m_sync_mode = sync_mode;
    qDebug() << " Emitting sync_modeChanged Signal! New sync_modeChanged: " <<  m_sync_mode;
    emit sync_modeChanged(m_sync_mode);
    QDBusMessage message = QDBusMessage::createSignal("/Climate", "com.DbusService", "sync_modeChanged");
    message << m_sync_mode ;
    QDBusConnection::sessionBus().send(message);
    qDebug() << " Manually sent  sync_modeChanged over D-Bus!";
}

void Climate::setTemp_driver(double temp_driver)
{
       m_driver_temp = temp_driver;
       qDebug() << " Emitting temp_driverChanged Signal! New driver temp: " << m_driver_temp;
       emit temp_driverChanged(m_driver_temp);

       // Explicitly send signal over D-Bus
       QDBusMessage message = QDBusMessage::createSignal("/Climate", "com.DbusService", "temp_driverChanged");
       message << m_driver_temp;
       QDBusConnection::sessionBus().send(message);

       qDebug() << " Manually sent temp_driverChanged over D-Bus!";
}

void Climate::setTemp_passenger(double temp_passenger)
{
     m_passenger_temp = temp_passenger;
     qDebug() << " Emitting temp_passengerChanged Signal! New temp_passenger: " << m_passenger_temp;
     emit temp_passengerChanged(m_passenger_temp);
     QDBusMessage message = QDBusMessage::createSignal("/Climate", "com.DbusService", "temp_passengerChanged");
     message << m_passenger_temp;
     QDBusConnection::sessionBus().send(message);
}

void Climate::setData(double temp_driver, double temp_passenger, int fan_speed, int driver_wind_mode, int passenger_wind_mode, int auto_mode, int sync_mode)
{
     setTemp_driver(temp_driver);
     setTemp_passenger(temp_passenger);
     setFan_speed(fan_speed);
     setDriverWind_mode(driver_wind_mode);
     setPassengerWind_mode(passenger_wind_mode);
     setAuto_mode(auto_mode);
     setSync_mode(sync_mode);
}

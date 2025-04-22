#ifndef CLIMATE_H
#define CLIMATE_H

#include <QObject>
#include <QDBusAbstractAdaptor>
#include <QDBusConnection>
class Climate : public QObject
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "com.DbusService")
    //Q_CLASSINFO("D-Bus Interface", "com.update.DbusService")
public:
    explicit Climate(QObject *parent = nullptr);

private:

    double m_driver_temp;
    double m_passenger_temp;
    int m_fan_level;
    int m_driver_wind_mode;
    int m_passenger_wind_mode;
    int m_auto_mode;
    int m_sync_mode;

signals:
    void dataChanged();
    Q_SCRIPTABLE void auto_modeChanged(int newVal);
    Q_SCRIPTABLE void driverWind_modeChanged(int newVal);
    Q_SCRIPTABLE void fan_speedChanged(int newVal);
    Q_SCRIPTABLE void passengerWind_modeChanged(int newVal);
    Q_SCRIPTABLE void sync_modeChanged(int newVal);
    Q_SCRIPTABLE void temp_driverChanged(double newVal);
    Q_SCRIPTABLE void temp_passengerChanged(double newVal);
public slots:
   Q_SCRIPTABLE int getAuto_mode();
   Q_SCRIPTABLE int getDriverWind_mode();
   Q_SCRIPTABLE int getFan_speed();
   Q_SCRIPTABLE int getPassengerWind_mode();
   Q_SCRIPTABLE int getSync_mode();
   Q_SCRIPTABLE double getTemp_driver();
    void openAppSignal(int newVal);
    double getTemp_passenger();
    void setAuto_mode(int auto_mode);
    void setDriverWind_mode(int driver_wind_mode);
    void setFan_speed(int fan_speed);
    void setPassengerWind_mode(int passenger_wind_mode);
    void setSync_mode(int sync_mode);
    void setTemp_driver(double temp_driver);
    void setTemp_passenger(double temp_passenger);
    void setData(double temp_driver, double temp_passenger, int fan_speed, int driver_wind_mode, int passenger_wind_mode, int auto_mode, int sync_mode);

};

#endif // CLIMATE_H

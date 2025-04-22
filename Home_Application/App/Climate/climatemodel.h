#ifndef CLIMATEMODEL_H
#define CLIMATEMODEL_H

#include <QObject>
//#include <climate_interface.h>
#include <QDBusInterface>
#include <QDBusConnection>

class ClimateModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(double driver_temp READ GetDriverTemperature NOTIFY temp_driverChanged)
    Q_PROPERTY(double passenger_temp READ GetPassengerTemperature NOTIFY temp_passengerChanged)
    Q_PROPERTY(int driver_wind_mode READ GetDriverWindMode NOTIFY driverWind_modeChanged)
    Q_PROPERTY(int passenger_wind_mode READ GetPassengerWindMode NOTIFY passengerWind_modeChanged)
    Q_PROPERTY(int fan_level READ GetFanLevel NOTIFY fan_speedChanged)
    Q_PROPERTY(int auto_mode READ GetAutoMode NOTIFY auto_modeChanged)
    Q_PROPERTY(int sync_mode READ GetSyncMode NOTIFY sync_modeChanged)
public:
    explicit ClimateModel(QObject *parent = nullptr);
    //void initFromClimate(Climate *climate);  // New method to set values
public:
    double GetDriverTemperature();
    double GetPassengerTemperature();
    int GetFanLevel();
    int GetDriverWindMode();
    int GetPassengerWindMode();
    int GetAutoMode();
    int GetSyncMode();
    //void connectToDBus();
    //local::Climate* m_climate;
    double m_driver_temp;
    double m_passenger_temp;
    int m_fan_level;
    int m_driver_wind_mode;
    int m_passenger_wind_mode;
    int m_auto_mode;
    int m_sync_mode;

signals:
      void temp_driverChanged(double newVal);
      void temp_passengerChanged(double newVal);
      void fan_speedChanged(int newVal);
     void driverWind_modeChanged(int newVal);
     void passengerWind_modeChanged(int newVal);
      void sync_modeChanged(int newVal);
      void auto_modeChanged(int newVal);
public slots:
    void onTemp_driverChanged(double newVal);
    void onTemp_passengerChanged(double newVal);
    void onFan_speedChanged(int newVal);
    void onDriverWind_modeChanged(int newVal1);
    void onPassengerWind_modeChanged(int newVal2);
    void onSync_modeChanged(int newVal);
    void onAuto_modeChanged(int newVal);

//void onDataChanged();
};

#endif // CLIMATEMODEL_H

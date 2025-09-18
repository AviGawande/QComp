#ifndef MANUALTRACKDATA_H
#define MANUALTRACKDATA_H

#include <QObject>
#include <QStringList>
#include "TrackEnums.h"

class ManualTrackData : public QObject {
    Q_OBJECT

    Q_PROPERTY(QStringList affinityOptions READ affinityOptions NOTIFY affinityOptionsChanged)
    Q_PROPERTY(QStringList categoryOptions READ categoryOptions NOTIFY categoryOptionsChanged)
    Q_PROPERTY(QStringList typeOptions READ typeOptions NOTIFY typeOptionsChanged)

public:
    explicit ManualTrackData(QObject *parent = nullptr);

    // getters
    QStringList affinityOptions() const;
    QStringList categoryOptions() const;
    QStringList typeOptions() const;

public slots:
    void setAffinityIndex(int index);
    void setCategoryIndex(int index);
    void setTypeIndex(int index);

signals:
    void affinityOptionsChanged();
    void categoryOptionsChanged();
    void typeOptionsChanged();

    void affinityIndexChanged(int index, QString value);
    void categoryIndexChanged(int index, QString value);
    void typeIndexChanged(int index, QString value);

private:
    int m_affinityIndex = -1;
    int m_categoryIndex = -1;
    int m_typeIndex = -1;

    QStringList enumToStringList(const char *enumName) const;
};

#endif // MANUALTRACKDATA_H

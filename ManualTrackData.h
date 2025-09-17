// #ifndef MANUALTRACKDATA_H
// #define MANUALTRACKDATA_H

// #include <QObject>
// #include <QStringList>
// #include <QVariantList>

// class ManualTrackData : public QObject
// {
//     Q_OBJECT
//     Q_PROPERTY(QStringList affinityOptions READ affinityOptions WRITE setAffinityOptions NOTIFY affinityOptionsChanged)
//     Q_PROPERTY(QStringList categoryOptions READ categoryOptions WRITE setCategoryOptions NOTIFY categoryOptionsChanged)
//     Q_PROPERTY(QVariantList typeOptions READ typeOptions WRITE setTypeOptions NOTIFY typeOptionsChanged)

// public:
//     explicit ManualTrackData(QObject *parent = nullptr);

//     // getters
//     QStringList affinityOptions() const;
//     QStringList categoryOptions() const;
//     QVariantList typeOptions() const;

//     // setters
//     void setAffinityOptions(const QStringList &affinityOptions);
//     void setCategoryOptions(const QStringList &categoryOptions);
//     void setTypeOptions(const QVariantList &typeOptions);

// signals:
//     void affinityOptionsChanged();
//     void categoryOptionsChanged();
//     void typeOptionsChanged();

// private:
//     QStringList m_affinityOptions;
//     QStringList m_categoryOptions;
//     QVariantList m_typeOptions;
// };

// #endif // MANUALTRACKDATA_H


#ifndef MANUALTRACKDATA_H
#define MANUALTRACKDATA_H

#include <QObject>
#include <QStringList>
#include <QVariantList>
#include <QMap>

class ManualTrackData : public QObject
{
    Q_OBJECT

    // Expose options as Q_PROPERTY for QML
    Q_PROPERTY(QStringList affinityOptions READ affinityOptions NOTIFY affinityOptionsChanged)
    Q_PROPERTY(QStringList categoryOptions READ categoryOptions NOTIFY categoryOptionsChanged)
    Q_PROPERTY(QStringList typeOptions READ typeOptions NOTIFY typeOptionsChanged)

public:
    explicit ManualTrackData(QObject *parent = nullptr);

    // getters for QML
    QStringList affinityOptions() const;
    QStringList categoryOptions() const;
    QStringList typeOptions() const;

public slots:
    // slots to set selected index from QML
    void setAffinityIndex(int index);
    void setCategoryIndex(int index);
    void setTypeIndex(int index);

signals:
    // notify QML when data changes
    void affinityOptionsChanged();
    void categoryOptionsChanged();
    void typeOptionsChanged();

    // notify backend when index changes
    void affinityIndexChanged(int index, QString value);
    void categoryIndexChanged(int index, QString value);
    void typeIndexChanged(int index, QString value);

private:
    // maps: index → string
    QMap<int, QString> m_affinityMap;
    QMap<int, QString> m_categoryMap;
    QMap<int, QStringList> m_typeMap;

    // selected indices
    int m_affinityIndex = -1;
    int m_categoryIndex = -1;
    int m_typeIndex = -1;
};

#endif // MANUALTRACKDATA_H

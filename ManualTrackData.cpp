// #include "ManualTrackData.h"

// ManualTrackData::ManualTrackData(QObject *parent) : QObject(parent)
// {
//     m_affinityOptions = {"Unknown","NotEvaluated","Friend","PresumedFriend","Pending","Suspect","Hostile","Neutral"};
//     m_categoryOptions = {"Unknown","Surface","SubSurface","Air","Land"};
//     m_typeOptions = {
//         QVariantList{"Unknown"},
//         QVariantList{"Unknown","Warship","Merchant","Major"},
//         QVariantList{"Unknown","UW Weapon","SubMarine"},
//         QVariantList{"Unknown","Weapon"},
//         QVariantList{"Unknown"}
//     };
// }

// // getters
// QStringList ManualTrackData::affinityOptions() const { return m_affinityOptions; }
// QStringList ManualTrackData::categoryOptions() const { return m_categoryOptions; }
// QVariantList ManualTrackData::typeOptions() const { return m_typeOptions; }

// // setters
// void ManualTrackData::setAffinityOptions(const QStringList &affinityOptions)
// {
//     if (m_affinityOptions != affinityOptions) {
//         m_affinityOptions = affinityOptions;
//         emit affinityOptionsChanged();
//     }
// }

// void ManualTrackData::setCategoryOptions(const QStringList &categoryOptions)
// {
//     if (m_categoryOptions != categoryOptions) {
//         m_categoryOptions = categoryOptions;
//         emit categoryOptionsChanged();
//     }
// }

// void ManualTrackData::setTypeOptions(const QVariantList &typeOptions)
// {
//     if (m_typeOptions != typeOptions) {
//         m_typeOptions = typeOptions;
//         emit typeOptionsChanged();
//     }
// }


#include "ManualTrackData.h"
#include <QDebug>

ManualTrackData::ManualTrackData(QObject *parent) : QObject(parent)
{
    // initialize affinity map
    m_affinityMap = {
        {0, "Unknown"},
        {1, "NotEvaluated"},
        {2, "Friend"},
        {3, "PresumedFriend"},
        {4, "Pending"},
        {5, "Suspect"},
        {6, "Hostile"},
        {7, "Neutral"}
    };

    // initialize category map
    m_categoryMap = {
        {0, "Unknown"},
        {1, "Surface"},
        {2, "SubSurface"},
        {3, "Air"},
        {4, "Land"}
    };

    // initialize type map (depends on category index)
    m_typeMap = {
        {0, {"Unknown"}},
        {1, {"Unknown","Warship","Merchant","Major"}},
        {2, {"Unknown","UW Weapon","SubMarine"}},
        {3, {"Unknown","Weapon"}},
        {4, {"Unknown"}}
    };
}

// ----------------- Getters -----------------
QStringList ManualTrackData::affinityOptions() const
{
    return m_affinityMap.values();
}

QStringList ManualTrackData::categoryOptions() const
{
    return m_categoryMap.values();
}

QStringList ManualTrackData::typeOptions() const
{
    return m_typeMap.value(m_categoryIndex, {"Unknown"});
}

// ----------------- Slots -----------------
void ManualTrackData::setAffinityIndex(int index)
{
    if (m_affinityIndex != index && m_affinityMap.contains(index)) {
        m_affinityIndex = index;
        QString value = m_affinityMap.value(index);
        qDebug() << "Affinity selected:" << index << value;
        emit affinityIndexChanged(index, value);
    }
}

void ManualTrackData::setCategoryIndex(int index)
{
    if (m_categoryIndex != index && m_categoryMap.contains(index)) {
        m_categoryIndex = index;
        QString value = m_categoryMap.value(index);
        qDebug() << "Category selected:" << index << value;
        emit categoryIndexChanged(index, value);

        // When category changes, type options also change
        emit typeOptionsChanged();
    }
}

void ManualTrackData::setTypeIndex(int index)
{
    if (m_typeIndex != index) {
        QStringList types = m_typeMap.value(m_categoryIndex, {"Unknown"});
        if (index >= 0 && index < types.size()) {
            m_typeIndex = index;
            QString value = types.at(index);
            qDebug() << "Type selected:" << index << value;
            emit typeIndexChanged(index, value);
        }
    }
}

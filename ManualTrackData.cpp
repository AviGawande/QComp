#include "ManualTrackData.h"
#include <QDebug>

ManualTrackData::ManualTrackData(QObject *parent) : QObject(parent) {}

// ----------------- Getters -----------------
QStringList ManualTrackData::affinityOptions() const {
    return {"UnknownAffinity","NotEvaluated","Friend","PresumedFriend",
            "Pending","Suspect","Hostile","Neutral"};
}

QStringList ManualTrackData::categoryOptions() const {
    return {"UnknownCategory","Surface","SubSurface","Air","Land"};
}

QStringList ManualTrackData::typeOptions() const {
    switch (m_categoryIndex) {
    case TrackEnums::Surface:
        return {"UnknownType","Warship","Merchant","Major"};
    case TrackEnums::SubSurface:
        return {"UnknownType","UWWeapon","SubMarine"};
    case TrackEnums::Air:
        return {"UnknownType","Weapon"};
    case TrackEnums::Land:
        return {"UnknownType"};
    default:
        return {"UnknownType"};
    }
}

// ----------------- Slots -----------------
void ManualTrackData::setAffinityIndex(int index) {
    QStringList opts = affinityOptions();
    if (index >= 0 && index < opts.size()) {
        m_affinityIndex = index;
        qDebug() << "Affinity selected:" << index << opts.at(index);
        emit affinityIndexChanged(index, opts.at(index));
    }
}

void ManualTrackData::setCategoryIndex(int index) {
    QStringList opts = categoryOptions();
    if (index >= 0 && index < opts.size()) {
        m_categoryIndex = index;
        qDebug() << "Category selected:" << index << opts.at(index);
        emit categoryIndexChanged(index, opts.at(index));

        emit typeOptionsChanged(); // refresh type combobox
    }
}

void ManualTrackData::setTypeIndex(int index) {
    QStringList opts = typeOptions();
    if (index >= 0 && index < opts.size()) {
        m_typeIndex = index;
        qDebug() << "Type selected:" << index << opts.at(index);
        emit typeIndexChanged(index, opts.at(index));
    }
}

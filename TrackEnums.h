#ifndef TRACKENUMS_H
#define TRACKENUMS_H

#include <QObject>

class TrackEnums : public QObject {
    Q_OBJECT
public:
    enum Affinity {
        UnknownAffinity = 0,
        NotEvaluated,
        Friend,
        PresumedFriend,
        Pending,
        Suspect,
        Hostile,
        Neutral
    };
    Q_ENUM(Affinity)

    enum Category {
        UnknownCategory = 0,
        Surface,
        SubSurface,
        Air,
        Land
    };
    Q_ENUM(Category)

    enum Type {
        UnknownType = 0,
        Warship,
        Merchant,
        Major,
        UWWeapon,
        SubMarine,
        Weapon
    };
    Q_ENUM(Type)
};

#endif // TRACKENUMS_H

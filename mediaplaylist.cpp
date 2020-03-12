#include "mediaplaylist.h"
#include <QDebug>

MediaPlayList::MediaPlayList(QObject *parent) : QObject(parent)
{

}

qint64 MediaPlayList::getCurrentIndex() const
{
    return currentIndex;
}

void MediaPlayList::setCurrentIndex(const qint64 &value)
{
    currentIndex = value;
    emit getCurrentIndexChanged();
}

QVariantList MediaPlayList::getPlayList() const
{
    return playList;
}

void MediaPlayList::setPlayList(const QVariantList &value)
{
    playList = value;
    setCurrentIndex(0);
    emit playListChanged();
}



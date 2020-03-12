#ifndef MEDIAPLAYLIST_H
#define MEDIAPLAYLIST_H

#include <QObject>
#include <QVariant>
#include <QQmlListProperty>

class MediaPlayList : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QVariantList playList READ getPlayList WRITE setPlayList NOTIFY playListChanged)
    Q_PROPERTY(qint64 currentIndex READ getCurrentIndex WRITE setCurrentIndex NOTIFY getCurrentIndexChanged)
public:
    explicit MediaPlayList(QObject *parent = nullptr);

    QVariantList playList;
    qint64 currentIndex;

public slots:

    Q_INVOKABLE QVariantList getPlayList() const;
    Q_INVOKABLE void setPlayList(const QVariantList &);

    Q_INVOKABLE qint64 getCurrentIndex() const;
    Q_INVOKABLE void setCurrentIndex(const qint64 &value);

signals:
    void playListChanged();
    void getCurrentIndexChanged();

};

#endif // MEDIAPLAYLIST_H

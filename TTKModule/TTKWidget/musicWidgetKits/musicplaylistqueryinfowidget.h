#ifndef MUSICPLAYLISTQUERYINFOWIDGET_H
#define MUSICPLAYLISTQUERYINFOWIDGET_H

/***************************************************************************
 * This file is part of the TTK Music Player project
 * Copyright (C) 2015 - 2022 Greedysky Studio

 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License along
 * with this program; If not, see <http://www.gnu.org/licenses/>.
 ***************************************************************************/

#include "musicabstractitemquerywidget.h"
#include "musicabstractqueryrequest.h"

class QPushButton;
class QStackedWidget;
class MusicPlaylistQueryTableWidget;
class MusicPlaylistQueryCommentsWidget;

/*! @brief The class of the playlist music query info widget.
 * @author Greedysky <greedysky@163.com>
 */
class TTK_MODULE_EXPORT MusicPlaylistQueryInfoWidget : public MusicAbstractItemQueryWidget
{
    Q_OBJECT
    TTK_DECLARE_MODULE(MusicPlaylistQueryInfoWidget)
public:
    /*!
     * Object contsructor.
     */
    explicit MusicPlaylistQueryInfoWidget(QWidget *parent = nullptr);
    ~MusicPlaylistQueryInfoWidget();

    /*!
     * Resize window bound by widget resize called.
     */
    virtual void resizeWindow() override final;

    /*!
     * Set current id to search founds.
     */
    virtual void setSongNameById(const QString &id) override final;

    /*!
     * Set music playlist item.
     */
    void setMusicResultsItem(const MusicResultsItem &item, QObject *obj);
    /*!
     * Set network query input.
     */
    void setQueryInput(MusicAbstractQueryRequest *query);

public Q_SLOTS:
    /*!
     * Set current container index.
     */
    void setCurrentIndex(int index);
    /*!
     * Query all quality musics is finished.
     */
    void queryAllFinished();

protected:
    /*!
     * Init the third widget.
     */
    void initThirdWidget();

    MusicPlaylistQueryCommentsWidget *m_commentsWidget;

};

#endif // MUSICPLAYLISTQUERYINFOWIDGET_H

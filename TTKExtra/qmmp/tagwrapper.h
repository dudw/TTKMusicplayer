/***************************************************************************
 * This file is part of the TTK qmmp plugin project
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

#ifndef TAGWRAPPER_H
#define TAGWRAPPER_H

#include <QMap>
#include "qmmp.h"

/*! @brief The class of the file tag wrapper.
 * @author Greedysky <greedysky@163.com>
 */
class QMMP_EXPORT TagWrapper
{
public:
    enum Type
    {
        TITLE,       /*!< Title */
        ARTIST,      /*!< Artist  */
        ALBUM,       /*!< Album */
        COMMENT,     /*!< Comment */
        GENRE,       /*!< Genre */
        YEAR,        /*!< Year */
        TRACK,       /*!< Track number */
        URL,         /*!< Stream url or local file path */
        LENGTH,      /*!< Length */
        FORMAT,      /*!< Format */
        SAMPLERATE,  /*!< Sample rate */
        MODE,        /*!< Mode */
        BITRATE,     /*!< Bitrate */
        CHANNEL      /*!< Channel */
    };

    TagWrapper();
    explicit TagWrapper(const QString &file);

    bool readFile();
    bool readFile(const QString &path);

    bool writeMusicTag(Type tag, const QString &value, int id3v2Version);
    inline QMap<Type, QString> musicTags() const { return m_parameters; }

protected:
    QString m_path;
    QMap<Type, QString> m_parameters;

};

#endif

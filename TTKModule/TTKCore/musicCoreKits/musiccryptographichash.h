#ifndef MUSICCRYPTOGRAPHICHASH_H
#define MUSICCRYPTOGRAPHICHASH_H

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

#include "musicglobaldefine.h"

#if defined(_MSC_VER)
typedef unsigned __int32 xxtea_uint;
#  pragma warning(disable:4267)
#else
#  if defined(__FreeBSD__) && __FreeBSD__ < 5
#    include <inttypes.h>
#  else
#    include <stdint.h>
#  endif
typedef uint32_t xxtea_uint;
#endif

/*! @brief The class of the string cryptographic hash.
 * @author Greedysky <greedysky@163.com>
 */
class TTK_MODULE_EXPORT MusicCryptographicHash
{
    TTK_DECLARE_MODULE(MusicCryptographicHash)
public:
    /*!
     * Object contsructor.
     */
    MusicCryptographicHash();

    /*!
     * encrypt by QString data.
     */
    QString encrypt(const QString &data, const QString &key);
    /*!
     * decrypt by QString data.
     */
    QString decrypt(const QString &data, const QString &key);

protected:
    /*!
     * XXTEA encrypt by TTKString data.
     */
    TTKString xxteaEncrypt(const TTKString &data, const TTKString &key);
    /*!
     * XXTEA encrypt by QString data.
     */
    QString xxteaEncrypt(const QString &data, const QString &key);

    /*!
     * XXTEA decrypt by TTKString data.
     */
    TTKString xxteaDecrypt(const TTKString &data, const TTKString &key);
    /*!
     * XXTEA decrypt by QString data.
     */
    QString xxteaDecrypt(const QString &data, const QString &key);

    /*!
     * Do XXTEA encrypt.
     */
    uchar *doXxteaEncrypt(uchar *data, xxtea_uint len, uchar *key, xxtea_uint *retLength);
    /*!
     * Do XXTEA decrypt.
     */
    uchar *doXxteaDecrypt(uchar *data, xxtea_uint len, uchar *key, xxtea_uint *retLength);
    /*!
     * XXTEA uint encrypt.
     */
    void xxteaUintEncrypt(xxtea_uint *v, xxtea_uint len, xxtea_uint *k);
    /*!
     * XXTEA uint decrypt.
     */
    void xxteaUintDecrypt(xxtea_uint *v, xxtea_uint len, xxtea_uint *k);
    /*!
     * Fix key length.
     */
    uchar *fixKeyLength(uchar *key, xxtea_uint keyLength);
    /*!
     * XXTEA to uint array.
     */
    xxtea_uint *xxteaToUintArray(uchar *data, xxtea_uint len, int includeLength, xxtea_uint *retLength);
    /*!
     * XXTEA to byte array.
     */
    uchar *xxteaToByteArray(xxtea_uint *data, xxtea_uint len, int includeLength, xxtea_uint *retLength);

    /*!
     * XXTEA encrypt by uchar * data.
     */
    uchar *xxteaEncrypt(uchar *data, xxtea_uint dataLength, uchar *key, xxtea_uint keyLength, xxtea_uint *retLengthgth);
    /*!
     * XXTEA decrypt by uchar * data.
     */
    uchar *xxteaDecrypt(uchar *data, xxtea_uint dataLength, uchar *key, xxtea_uint keyLength, xxtea_uint *retLengthgth);

};

#endif // MUSICCRYPTOGRAPHICHASH_H

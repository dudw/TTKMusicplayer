#Common settings for Qmmp build

#Extra clean target

unix: QMAKE_DISTCLEAN += -r .build

#Some conf to redirect intermediate stuff in separate dirs

UI_DIR=./.build/ui/
MOC_DIR=./.build/moc/
OBJECTS_DIR=./.build/obj
RCC_DIR=./.build/rcc

#Defines

DEFINES += QT_NO_CAST_FROM_BYTEARRAY QT_STRICT_ITERATORS

equals(QT_MAJOR_VERSION, 5){
CONFIG -= depend_includepath
QT += widgets
unix:DEFINES += QMMP_WS_X11
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x050400 QT_DEPRECATED_WARNINGS
}

#Configuration

CONFIG += hide_symbols
CONFIG += c++11
QMAKE_CXXFLAGS += -std=c++11
QMAKE_CFLAGS += -std=gnu11
DEFINES += QMMP_LIBRARY


#Version

TTKMusicPlayer = 2.15.1.0
QMMP_VERSION = 1.5.0
CONFIG += USE_STATIC_LIBRARY

#Comment/uncomment this if you want to change plugins list

CONFIG += ALSA_PLUGIN
CONFIG += BS2B_PLUGIN
CONFIG += SOXR_PLUGIN
CONFIG += LADSPA_PLUGIN
CONFIG += SRC_PLUGIN

CONFIG += AAC_PLUGIN
CONFIG += CDAUDIO_PLUGIN
CONFIG += FFAP_PLUGIN
CONFIG += FFMPEG_PLUGIN
CONFIG += FLAC_PLUGIN
CONFIG += GME_PLUGIN
CONFIG += MODPLUG_PLUGIN
CONFIG += MUSEPACK_PLUGIN
CONFIG += WITH_MAD
CONFIG += WITH_ENCA
CONFIG += WILDMIDI_PLUGIN
CONFIG += OPUS_PLUGIN
CONFIG += SID_PLUGIN

#additional features
CONFIG += ADPLUG_PLUGIN
CONFIG += ASAP_PLUGIN
CONFIG += AYFLY_PLUGIN
CONFIG += BP_PLUGIN
CONFIG += DCA_PLUGIN
CONFIG += FC14_PLUGIN
CONFIG += HIVELY_PLUGIN
CONFIG += MDX_PLUGIN
CONFIG += OPTIMFROG_PLUGIN
CONFIG += ORGANYA_PLUGIN
CONFIG += PSF_PLUGIN
CONFIG += SC68_PLUGIN
CONFIG += V2M_PLUGIN
CONFIG += XSF_PLUGIN
CONFIG += YM_PLUGIN

CONFIG -= $$DISABLED_PLUGINS

contains(CONFIG, USE_STATIC_LIBRARY){
    STATIC_LIBRARY_SUFFIX = _static
    DEFINES += TAGLIB_STATIC
}else{
    STATIC_LIBRARY_SUFFIX =
}

#include "musicsemaphoreloop.h"

MusicSemaphoreLoop::MusicSemaphoreLoop(QObject *parent)
    : QEventLoop(parent)
{
    m_timer.setInterval(10 * MT_S2MS);
    connect(&m_timer, SIGNAL(timeout()), SLOT(quit()));
}

MusicSemaphoreLoop::~MusicSemaphoreLoop()
{
    quit();
}

void MusicSemaphoreLoop::quit()
{
    m_timer.stop();
    return QEventLoop::quit();
}

int MusicSemaphoreLoop::exec(ProcessEventsFlags flags)
{
    m_timer.start();
    return QEventLoop::exec(flags);
}

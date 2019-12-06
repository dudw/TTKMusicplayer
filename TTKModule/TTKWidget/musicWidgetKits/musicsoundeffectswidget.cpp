#include "musicsoundeffectswidget.h"
#include "ui_musicsoundeffectswidget.h"
#include "musicsettingmanager.h"
#include "musicconnectionpool.h"
#include "musicuiobject.h"
#include "musicplayer.h"
#include "musicwidgetheaders.h"
#include "musicqmmputils.h"
///
#include <QStyledItemDelegate>

MusicSoundEffectsItemWidget::MusicSoundEffectsItemWidget(QWidget *parent)
    : QWidget(parent)
{
    m_type = Null;
    m_enable = false;

    QVBoxLayout *layout = new QVBoxLayout(this);
    layout->setContentsMargins(1, 1, 1, 1);
    layout->setSpacing(0);

    m_textLabel = new QLabel(this);
    m_textLabel->setStyleSheet(MusicUIObject::MBackgroundStyle08);

    setText(tr("null"));

    QWidget *func = new QWidget(this);
    func->setStyleSheet(MusicUIObject::MBackgroundStyle04);
    QHBoxLayout *funcLayout = new QHBoxLayout(func);
    funcLayout->setContentsMargins(0, 5, 5, 0);
    funcLayout->setSpacing(0);

    m_settingButton = new QPushButton(func);
    m_settingButton->setStyleSheet(MusicUIObject::MPushButtonStyle01);
    m_settingButton->setCursor(QCursor(Qt::PointingHandCursor));
    m_settingButton->setFixedWidth(40);
    m_settingButton->setText(tr("Sets"));
    m_settingButton->setEnabled(false);
    connect(m_settingButton, SIGNAL(clicked()), SLOT(soundEffectValueChanged()));

    m_openButton = new QPushButton(func);
    m_openButton->setStyleSheet(MusicUIObject::MPushButtonStyle01);
    m_openButton->setIcon(QIcon(":/tiny/btn_effect_on"));
    m_openButton->setToolTip(tr("On"));
    m_openButton->setCursor(QCursor(Qt::PointingHandCursor));
    m_openButton->setFixedSize(16, 16);
    connect(m_openButton, SIGNAL(clicked()), SLOT(setPluginEnable()));

#ifdef Q_OS_UNIX
    m_settingButton->setFocusPolicy(Qt::NoFocus);
    m_openButton->setFocusPolicy(Qt::NoFocus);
#endif

    QLabel *iconLabel = new QLabel(func);
    iconLabel->setStyleSheet(MusicUIObject::MBackgroundStyle01);
    iconLabel->setPixmap(QPixmap(":/tiny/lb_arrow_down_normal"));
    iconLabel->setFixedSize(16, 16);

    funcLayout->addWidget(m_settingButton);
    funcLayout->addWidget(iconLabel);
    funcLayout->addStretch(1);
    funcLayout->addWidget(m_openButton);

    layout->addWidget(m_textLabel);
    layout->addWidget(func);

    setLayout(layout);
}

MusicSoundEffectsItemWidget::~MusicSoundEffectsItemWidget()
{
    delete m_textLabel;
    delete m_openButton;
    delete m_settingButton;
}

void MusicSoundEffectsItemWidget::setText(const QString &text)
{
    m_textLabel->setText(" " + text);
}

void MusicSoundEffectsItemWidget::setType(Type type)
{
    m_type = type;
}

void MusicSoundEffectsItemWidget::setPluginEnable(bool enable)
{
    m_enable = !enable;
    setPluginEnable();
}

bool MusicSoundEffectsItemWidget::pluginEnable() const
{
    return m_enable;
}

void MusicSoundEffectsItemWidget::soundEffectChanged(Type type, bool enable)
{
    const QString plugin(transformQStringFromEnum(type));
    MusicUtils::QMMP::enableEffectPlugin(plugin, enable);
}

void MusicSoundEffectsItemWidget::setPluginEnable()
{
    if(!m_enable)
    {
        m_enable = true;
        m_openButton->setIcon(QIcon(":/tiny/btn_effect_off"));
        soundEffectCheckBoxChanged(true);
        m_settingButton->setEnabled(true);
        m_openButton->setToolTip(tr("Off"));
    }
    else
    {
        m_enable = false;
        m_openButton->setIcon(QIcon(":/tiny/btn_effect_on"));
        soundEffectCheckBoxChanged(false);
        m_settingButton->setEnabled(false);
        m_openButton->setToolTip(tr("On"));
    }
}

void MusicSoundEffectsItemWidget::soundEffectCheckBoxChanged(bool state)
{
    soundEffectChanged(m_type, state);
}

void MusicSoundEffectsItemWidget::soundEffectValueChanged()
{
    const QString plugin(transformQStringFromEnum(m_type));
    MusicUtils::QMMP::enableEffectSetting(plugin, this);
}

QString MusicSoundEffectsItemWidget::transformQStringFromEnum(Type type)
{
    QString plugin;
    switch(type)
    {
        case BS2B:         plugin = "bs2b"; break;
        case Crossfade:    plugin = "crossfade"; break;
        case Stereo:       plugin = "stereo"; break;
        case LADSPA:       plugin = "ladspa"; break;
        case Soxr:         plugin = "soxr"; break;
        case SrcConverter: plugin = "srconverter"; break;
        case MonoStereo:   plugin = "monotostereo"; break;
        default:           plugin = "unknow"; break;
    }
    return plugin;
}



MusicSoundEffectsWidget::MusicSoundEffectsWidget(QWidget *parent)
    : MusicAbstractMoveDialog(parent),
      m_ui(new Ui::MusicSoundEffectsWidget)
{
    m_ui->setupUi(this);

    m_ui->topTitleCloseButton->setIcon(QIcon(":/functions/btn_close_hover"));
    m_ui->topTitleCloseButton->setStyleSheet(MusicUIObject::MToolButtonStyle04);
    m_ui->topTitleCloseButton->setCursor(QCursor(Qt::PointingHandCursor));
    m_ui->topTitleCloseButton->setToolTip(tr("Close"));
    connect(m_ui->topTitleCloseButton, SIGNAL(clicked()), SLOT(close()));

    m_ui->volumeLeftlabel->setStyleSheet(MusicUIObject::MColorStyle03);
    m_ui->volumeRightLabel->setStyleSheet(MusicUIObject::MColorStyle03);

    m_ui->volumeSlider->setStyleSheet(MusicUIObject::MSliderStyle08);
    m_ui->volumeSlider->setRange(-100, 100);
    m_ui->volumeSlider->setValue(0);
    m_ui->volumeSlider->setToolTip("0");
    connect(m_ui->volumeSlider, SIGNAL(valueChanged(int)), SLOT(volumeSliderChanged(int)));

    m_ui->stateComboBox->setItemDelegate(new QStyledItemDelegate(m_ui->stateComboBox));
    m_ui->stateComboBox->setStyleSheet(MusicUIObject::MComboBoxStyle01 + MusicUIObject::MItemView01);
    m_ui->stateComboBox->view()->setStyleSheet(MusicUIObject::MScrollBarStyle01);
    m_ui->stateComboBox->addItems( QStringList() << tr("OperatorAll") << tr("All On") << tr("All Off"));
    connect(m_ui->stateComboBox, SIGNAL(currentIndexChanged(int)), SLOT(stateComboBoxChanged(int)));

    m_ui->eqButton->setStyleSheet(MusicUIObject::MPushButtonStyle04);
    m_ui->eqButton->setCursor(QCursor(Qt::PointingHandCursor));
    m_ui->eqEffectButton->setCursor(QCursor(Qt::PointingHandCursor));
    m_ui->eqEffectButton->setStyleSheet(MusicUIObject::MPushButtonStyle04);
#ifdef Q_OS_UNIX
    m_ui->eqButton->setFocusPolicy(Qt::NoFocus);
    m_ui->eqEffectButton->setFocusPolicy(Qt::NoFocus);
#endif

    //
    m_ui->BS2BWidget->setText("BS2B");
    m_ui->BS2BWidget->setType(MusicSoundEffectsItemWidget::BS2B);

    m_ui->CrossfadeWidget->setText("Crossfade");
    m_ui->CrossfadeWidget->setType(MusicSoundEffectsItemWidget::Crossfade);

    m_ui->StereoWidget->setText("Stereo");
    m_ui->StereoWidget->setType(MusicSoundEffectsItemWidget::Stereo);

    m_ui->SOXWidget->setText("Soxr");
    m_ui->SOXWidget->setType(MusicSoundEffectsItemWidget::Soxr);

    m_ui->SRCWidget->setText("SrcConverter");
    m_ui->SRCWidget->setType(MusicSoundEffectsItemWidget::SrcConverter);

    m_ui->MonoStereoWidget->setText("MonoStereo");
    m_ui->MonoStereoWidget->setType(MusicSoundEffectsItemWidget::MonoStereo);

#ifdef Q_OS_UNIX
    m_ui->LADSPAWidget->setText("LADSPA");
    m_ui->LADSPAWidget->setType(MusicSoundEffectsItemWidget::LADSPA);
#endif

    readSoundEffect();

    M_CONNECTION_PTR->setValue(getClassName(), this);
    M_CONNECTION_PTR->poolConnect(getClassName(), MusicPlayer::getClassName());
}

MusicSoundEffectsWidget::~MusicSoundEffectsWidget()
{
    M_CONNECTION_PTR->removeValue(getClassName());
    writeSoundEffect();

    delete m_ui;
}

void MusicSoundEffectsWidget::setParentConnect(QObject *object)
{
    if(M_SETTING_PTR->value(MusicSettingManager::EqualizerEnable).toInt())
    {
        m_ui->eqButton->setText(tr("Off"));
    }
    else
    {
        m_ui->eqButton->setText(tr("On"));
    }

    m_ui->volumeSlider->setValue(M_SETTING_PTR->value(MusicSettingManager::EnhancedBalance).toInt());

    connect(m_ui->eqButton, SIGNAL(clicked()), SLOT(equalizerButtonChanged()));
    connect(m_ui->eqEffectButton, SIGNAL(clicked()), object, SLOT(musicSetEqualizer()));
}

void MusicSoundEffectsWidget::equalizerButtonChanged(bool state)
{
    m_ui->eqButton->setText(state ? tr("Off") : tr("On"));
}

void MusicSoundEffectsWidget::equalizerButtonChanged()
{
    const int state = !M_SETTING_PTR->value(MusicSettingManager::EqualizerEnable).toInt();
    equalizerButtonChanged(state);

    M_SETTING_PTR->setValue(MusicSettingManager::EqualizerEnable, state);

    emit setEqInformation();
}

void MusicSoundEffectsWidget::stateComboBoxChanged(int index)
{
    m_ui->stateComboBox->blockSignals(true);
    m_ui->stateComboBox->setCurrentIndex(0);
    m_ui->stateComboBox->blockSignals(false);

    if(index == 1)
    {
        m_ui->BS2BWidget->setPluginEnable(true);
        m_ui->CrossfadeWidget->setPluginEnable(true);
        m_ui->StereoWidget->setPluginEnable(true);
        m_ui->SOXWidget->setPluginEnable(true);
        m_ui->SRCWidget->setPluginEnable(true);
        m_ui->MonoStereoWidget->setPluginEnable(true);
#ifdef Q_OS_UNIX
        m_ui->LADSPAWidget->setPluginEnable(true);
#endif
    }
    else if(index == 2)
    {
        m_ui->BS2BWidget->setPluginEnable(false);
        m_ui->CrossfadeWidget->setPluginEnable(false);
        m_ui->StereoWidget->setPluginEnable(false);
        m_ui->SOXWidget->setPluginEnable(false);
        m_ui->SRCWidget->setPluginEnable(false);
        m_ui->MonoStereoWidget->setPluginEnable(false);
#ifdef Q_OS_UNIX
        m_ui->LADSPAWidget->setPluginEnable(false);
#endif
    }
}

void MusicSoundEffectsWidget::volumeSliderChanged(int value)
{
    m_ui->volumeSlider->setToolTip(QString::number(value));
    M_SETTING_PTR->setValue(MusicSettingManager::EnhancedBalance, value);
    emit volumeChanged(value);
}

int MusicSoundEffectsWidget::exec()
{
    setBackgroundPixmap(m_ui->background, size());
    return MusicAbstractMoveDialog::exec();
}

void MusicSoundEffectsWidget::readSoundEffect()
{
    m_ui->BS2BWidget->setPluginEnable(M_SETTING_PTR->value(MusicSettingManager::EnhancedBS2B).toInt());
    m_ui->CrossfadeWidget->setPluginEnable(M_SETTING_PTR->value(MusicSettingManager::EnhancedCrossfade).toInt());
    m_ui->StereoWidget->setPluginEnable(M_SETTING_PTR->value(MusicSettingManager::EnhancedStereo).toInt());
    m_ui->SOXWidget->setPluginEnable(M_SETTING_PTR->value(MusicSettingManager::EnhancedSOX).toInt());
    m_ui->SRCWidget->setPluginEnable(M_SETTING_PTR->value(MusicSettingManager::EnhancedSRC).toInt());
    m_ui->MonoStereoWidget->setPluginEnable(M_SETTING_PTR->value(MusicSettingManager::EnhancedMonoStereo).toInt());
#ifdef Q_OS_UNIX
    m_ui->LADSPAWidget->setPluginEnable(M_SETTING_PTR->value(MusicSettingManager::EnhancedLADSPA).toInt());
#endif
}

void MusicSoundEffectsWidget::writeSoundEffect()
{
    M_SETTING_PTR->setValue(MusicSettingManager::EnhancedBS2B, m_ui->BS2BWidget->pluginEnable());
    M_SETTING_PTR->setValue(MusicSettingManager::EnhancedCrossfade, m_ui->CrossfadeWidget->pluginEnable());
    M_SETTING_PTR->setValue(MusicSettingManager::EnhancedStereo, m_ui->StereoWidget->pluginEnable());
    M_SETTING_PTR->setValue(MusicSettingManager::EnhancedSOX, m_ui->SOXWidget->pluginEnable());
    M_SETTING_PTR->setValue(MusicSettingManager::EnhancedSRC, m_ui->SRCWidget->pluginEnable());
    M_SETTING_PTR->setValue(MusicSettingManager::EnhancedMonoStereo, m_ui->MonoStereoWidget->pluginEnable());
#ifdef Q_OS_UNIX
    M_SETTING_PTR->setValue(MusicSettingManager::EnhancedLADSPA, m_ui->LADSPAWidget->pluginEnable());
#endif
}

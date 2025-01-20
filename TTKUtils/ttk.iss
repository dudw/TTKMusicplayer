; Script generated by the Inno Setup Script Wizard.

#define MyAppNameZh "天天酷音"
#define MyAppNameEN "TTKMusicPlayer"
#define MyAppVersion "4.1.3.0"
#define MyAppPublisher "Greedysky Studio"
#define MyAppCopyright "Copyright (C) 2015 - 2025 Greedysky Studio"
#define MyAppURL "http://download.csdn.net/album/detail/3094"
#define MyAppExeName MyAppNameEN + ".exe"

#define OutputPath "D:\Qt\"
#define SourceBase OutputPath + MyAppNameEN + "\"
#define SourceMain SourceBase + MyAppExeName
#define SourceFolder SourceBase + "*"

#define ResourcesIcon "qicon.dll"
#define ResourcesBase "resource\"
#define SetupIconFilePath ResourcesBase + ResourcesIcon
#define ResourcesPath ResourcesBase + "*"

[setup]
AppId={{B246DC4A-B67B-4D3D-901E-8CA1D829BF55}
AppName={#MyAppNameZh}
AppVersion={#MyAppVersion}
AppVerName={#MyAppNameZh}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName= C:\{#MyAppNameEN}
OutputDir={#OutputPath}
OutputBaseFilename=v{#MyAppVersion}
SetupIconFile={#SetupIconFilePath}
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin
Uninstallable=yes
UninstallDisplayName={#MyAppNameZh}
UninstallDisplayIcon={app}\{#ResourcesIcon}
DefaultGroupName={#MyAppNameZh}
VersionInfoDescription={#MyAppNameZh} 安装程序
VersionInfoCopyright={#MyAppCopyright}
VersionInfoVersion={#MyAppVersion}
VersionInfoProductName={#MyAppNameZh}
DisableReadyPage=yes
DisableProgramGroupPage=yes
DirExistsWarning=no
DisableDirPage=yes

[Files]
Source: {#ResourcesPath}; DestDir: {tmp}; Flags: dontcopy solidbreak ; Attribs: hidden system
Source: {#SourceMain}; DestDir: "{app}"; Flags: ignoreversion
Source: {#SourceFolder}; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Messages]
SetupAppTitle={#MyAppNameZh} 安装向导
SetupWindowTitle={#MyAppNameZh} 安装向导

[Icons]
Name: "{group}\{#MyAppNameZh}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\卸载{#MyAppNameZh}"; Filename: "{uninstallexe}"

; 中文汉化语言包
; [Languages]
; Name: "chinese"; MessagesFile: "_resourcesPath_\ChineseSimp.isl"

[Code]
// for dll
type
  TBtnEventProc = procedure (h:HWND);
  TPBProc = function(h:hWnd;Msg,wParam,lParam:Longint):Longint;  //百分比
  TTimerProc = procedure(h:longword; msg:longword; idevent:longword; dwTime:longword);
const
  Radius  = 9;
  GWL_EXSTYLE = (-20);
  //窗口移动
  WM_SYSCOMMAND = $0112;
  WS_EX_LAYERED = $80000;
  WS_EX_TRANSPARENT = $20;
  LWA_COLORKEY = 1;
  TransparentColor = clLime;  //要去掉的图片底色
  TransparentPercent = 80;
  BTN_MAX_PATH = 1024;

  BtnClickEventID      = 1;
  BtnMouseEnterEventID = 2;
  BtnMouseLeaveEventID = 3;
  BtnMouseMoveEventID  = 4;
  BtnMouseDownEventID  = 5;
  BtnMouseUpEventID    = 6;


//botva2
function  ImgLoad(Wnd :HWND; FileName :PAnsiChar; Left, Top, Width, Height :integer; Stretch, IsBkg :boolean) :Longint; external 'ImgLoad@{tmp}\botva2.dll stdcall delayload';
procedure ImgSetVisibility(img :Longint; Visible :boolean); external 'ImgSetVisibility@{tmp}\botva2.dll stdcall delayload';
procedure ImgApplyChanges(h:HWND); external 'ImgApplyChanges@{tmp}\botva2.dll stdcall delayload';
procedure ImgSetPosition(img :Longint; NewLeft, NewTop, NewWidth, NewHeight :integer); external 'ImgSetPosition@files:botva2.dll stdcall';
procedure ImgRelease(img :Longint); external 'ImgRelease@{tmp}\botva2.dll stdcall delayload';
procedure gdipShutdown;  external 'gdipShutdown@{tmp}\botva2.dll stdcall delayload';
function  WrapBtnCallback(Callback: TBtnEventProc; ParamCount: Integer): Longword; external 'wrapcallback@{tmp}\innocallback.dll stdcall delayload';
function  BtnCreate(hParent:HWND; Left,Top,Width,Height:integer; FileName:PAnsiChar; ShadowWidth:integer; IsCheckBtn:boolean):HWND; external 'BtnCreate@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetVisibility(h:HWND; Value:boolean); external 'BtnSetVisibility@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetEvent(h:HWND; EventID:integer; Event:Longword); external 'BtnSetEvent@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetEnabled(h:HWND; Value:boolean); external 'BtnSetEnabled@{tmp}\botva2.dll stdcall delayload';
function  BtnGetChecked(h:HWND):boolean; external 'BtnGetChecked@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetChecked(h:HWND; Value:boolean); external 'BtnSetChecked@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetPosition(h:HWND; NewLeft, NewTop, NewWidth, NewHeight: integer);  external 'BtnSetPosition@{tmp}\botva2.dll stdcall delayload';
function  SetLayeredWindowAttributes(hwnd:HWND; crKey:Longint; bAlpha:byte; dwFlags:longint ):longint; external  'SetLayeredWindowAttributes@user32 stdcall';
function  SetWindowLong(Wnd: HWnd; Index: Integer; NewLong: Longint): Longint; external 'SetWindowLongA@user32.dll stdcall';
function  PBCallBack(P:TPBProc;ParamCount:integer):LongWord; external 'wrapcallback@files:innocallback.dll stdcall';
function  CallWindowProc(lpPrevWndFunc: Longint; hWnd: HWND; Msg: UINT; wParam, lParam: Longint): Longint; external 'CallWindowProcA@user32.dll stdcall';
procedure ImgSetVisiblePart(img:Longint; NewLeft, NewTop, NewWidth, NewHeight : integer); external 'ImgSetVisiblePart@files:botva2.dll stdcall';
function  ReleaseCapture(): Longint; external 'ReleaseCapture@user32.dll stdcall';
function  CreateRoundRectRgn(p1, p2, p3, p4, p5, p6: Integer): THandle; external 'CreateRoundRectRgn@gdi32 stdcall';
function  SetWindowRgn(hWnd: HWND; hRgn: THandle; bRedraw: Boolean): Integer; external 'SetWindowRgn@user32 stdcall';


procedure ShapeForm(aForm: TForm; edgeSize: integer); //圆角
  var
    FormRegion:LongWord;
  begin
    FormRegion:=CreateRoundRectRgn(0,0,aForm.Width,aForm.Height,edgeSize,edgeSize);
    SetWindowRgn(aForm.Handle,FormRegion,True);
  end;

// 安装前强制杀进
// 该函数在安装程序初始化时调用，返回False 将中断安装，True则继续安装.程
function InitializeSetup(): Boolean;
  var ErrorCode: Integer;
  begin
    ShellExec('open','taskkill.exe','/f /im {#MyAppExeName}','',SW_HIDE,ewNoWait,ErrorCode);
    ShellExec('open','tskill.exe',' {#MyAppNameZh}','',SW_HIDE,ewNoWait,ErrorCode);
    result := True;
  end;

// 卸载前强制杀进程
function InitializeUninstall(): Boolean;
  var ErrorCode: Integer;
  begin
    ShellExec('open','taskkill.exe','/f /im {#MyAppExeName}','',SW_HIDE,ewNoWait,ErrorCode);
    ShellExec('open','tskill.exe',' {#MyAppNameZh}','',SW_HIDE,ewNoWait,ErrorCode);
    result := True;
  end;

var
  BGimg:longint;
  systemVersion:Integer;
  btnShowLicense,CancelBtn,btnBrowser,btnSetup,customSetup,btnBack:HWND;
  isWelcomePage:boolean;
  pathEdit:tedit;
  labelReadImg,licenseImg,progressbgImg,PBOldProc,labelAutoRunImg:longint;
  checkboxLicense,checkboxAutoRun:HWND;
  licenseRich:TRichEditViewer;
  shellLinkImg,taskbarpinImg:longint;
  checkboxShellLink,checkboxTaskbarpin:HWND;
  
// 向导调用这个事件函数确定是否在所有页或不在一个特殊页 (用PageID 指定) 显示。如果返回True，将跳过该页；如果你返回False，该页被显示。
// 注意: 这个事件函数不被wpWelcome、wpPreparing 和wpInstalling 页调用，还有安装程序已经确定要跳过的页也不会调用
// wpWelcome, wpLicense, wpPassword, wpInfoBefore, wpUserInfo, wpSelectDir, wpSelectComponents, wpSelectProgramGroup, wpSelectTasks, wpReady, wpPreparing, wpInstalling, wpInfoAfter, wpFinished
function ShouldSkipPage(PageID: Integer): Boolean;
  begin
    if PageID=wpLicense then
      result:=true;
    if PageID=wpInfoBefore then
      result:=true;
    if PageID=wpUserInfo then
      result:=true;
    if PageID=wpSelectDir then
      result:=true;
    if PageID=wpSelectComponents then
      result:=true;
    if PageID=wpSelectProgramGroup then
      result:=true;
    if PageID=wpSelectTasks then
      result:=true;
  end;

// 关闭按钮
procedure CancelBtnOnClick(hBtn:HWND);
  begin
    WizardForm.CancelButton.Click;
  end;

// 浏览文件夹按钮
procedure btnBrowserclick(hBtn:HWND);
  begin
    WizardForm.DirBrowseButton.Click;
    pathEdit.text := WizardForm.DirEdit.text;
  end;

// 路径选择器 change
procedure pathEditChange(Sender: TObject);
  begin
    WizardForm.DirEdit.text:=pathEdit.Text ;
  end;

// 立即安装等按钮的操作就是不断地下一步
procedure nextSetpBtnClick(hBtn:HWND);
  begin
    WizardForm.NextButton.Click;
  end;

// 安装的进度条
function PBProc(h:hWnd;Msg,wParam,lParam:Longint):Longint;
  var
    pr,i1,i2 : Extended;
    w : integer;
  begin
    Result:=CallWindowProc(PBOldProc,h,Msg,wParam,lParam);
    if (Msg=$402) and (WizardForm.ProgressGauge.Position>WizardForm.ProgressGauge.Min) then
    begin
      i1:=WizardForm.ProgressGauge.Position-WizardForm.ProgressGauge.Min;
      i2:=WizardForm.ProgressGauge.Max-WizardForm.ProgressGauge.Min;
      pr:=i1*100/i2;
      w:=Round(650*pr/100);
      ImgSetPosition(progressbgImg,0,320,w,15);
      ImgSetVisiblePart(progressbgImg,0,0,w,15);
      ImgApplyChanges(WizardForm.Handle);
    end;
  end;

// 鼠标拖动
procedure WizardMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
    ReleaseCapture
    SendMessage(WizardForm.Handle, $0112, $F012, 0)
  end;

// 查看 license
procedure btnShowLicenseClick(hBtn:HWND);
  begin
    if isWelcomePage=true then
    begin
      licenseImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\bg_license.png'),0,0,650,450,false,false);
      isWelcomePage:=false
      licenseRich.Height:=295
      BtnSetVisibility(checkboxLicense,false)
      BtnSetVisibility(btnShowLicense,false)
      BtnSetVisibility(btnSetup,false)
      BtnSetVisibility(customSetup,false)
      BtnSetVisibility(btnBrowser,false)
      pathEdit.Hide
      BtnSetVisibility(btnBack,true)
    end else
    begin
      isWelcomePage:=true
      BGimg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\bg_welcome.png'),0,0,650,450,false,true);
      labelReadImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\label_read.png'),243,398,64,20,false,true);
      licenseRich.Height:=0
      BtnSetVisibility(checkboxLicense,true)
      BtnSetVisibility(btnShowLicense,true)
      BtnSetVisibility(btnSetup,true)
      BtnSetVisibility(customSetup,true)
      BtnSetVisibility(checkboxShellLink,false)
      BtnSetVisibility(checkboxTaskbarpin,false)
      ImgRelease(licenseImg)
      BtnSetVisibility(btnBrowser,true)
      pathEdit.show
      BtnSetVisibility(btnBack,false)
    end
      ImgApplyChanges(WizardForm.Handle)
  end;

// 自定义安装
procedure btnCustomSetupClick(hBtn:HWND);
  begin
    if isWelcomePage=true then
    begin
      isWelcomePage:=false
      shellLinkImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\label_shellLink.png'),60,340,110,20,false,true);
      taskbarpinImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\label_taskbarpin.png'),220,340,75,20,false,true);
      ImgRelease(labelReadImg)
      BtnSetVisibility(checkboxLicense,false)
      BtnSetVisibility(btnShowLicense,false)
      BtnSetVisibility(btnSetup,false)
      BtnSetVisibility(customSetup,false)
      BtnSetVisibility(btnBack,true)
      BtnSetVisibility(checkboxShellLink,true)
      BtnSetVisibility(checkboxTaskbarpin,true)
    end else
    begin
      isWelcomePage:=true
      labelReadImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\label_read.png'),243,398,64,20,false,true);
      ImgRelease(shellLinkImg)
      ImgRelease(taskbarpinImg)
      BtnSetVisibility(checkboxLicense,true)
      BtnSetVisibility(btnShowLicense,true)
      BtnSetVisibility(btnSetup,true)
      BtnSetVisibility(customSetup,true)
      BtnSetVisibility(btnBack,false)
      BtnSetVisibility(checkboxShellLink,false)
      BtnSetVisibility(checkboxTaskbarpin,false)
    end
      ImgApplyChanges(WizardForm.Handle)
  end;
  
// 勾选查看 license
procedure checkboxLicenseClick(hBtn:HWND);
  begin
    if BtnGetChecked(checkboxLicense)=true then
    begin
      BtnSetEnabled(btnSetup,true)
      BtnSetEnabled(customSetup,true)
    end else
    begin
      BtnSetEnabled(btnSetup,false)
      BtnSetEnabled(customSetup,false)
    end
  end;
  
// 安装系统检测
procedure MyGetWindowsVersion(); // 获取 Windows 版本
  var ProductName:String;//系统名称
  begin
    RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows NT\CurrentVersion', 'ProductName', ProductName);
    
    //Windows 7 系统检测
    if (Pos('Windows 7', ProductName) > 0)then
    begin
        systemVersion := 1;
        Exit;
    end
    
    //Windows 8 系统检测
    if (Pos('Windows 8', ProductName) > 0)then
    begin
        systemVersion := 2;
        Exit;
    end
    
    systemVersion := 0;
  end;

// 该过程在开始的时候改变向导或者向导页，不要指望使用InitializeSetup函数实现改变向导页的功能，因为InitializeSetup函数触发时向导窗口并不存在。
procedure InitializeWizard();
  begin
    // 安装系统检测
    MyGetWindowsVersion();
    
    // 设置欢迎向导页的尺寸大小
    WizardForm.OuterNotebook.hide;
    WizardForm.Bevel.Hide;
    WizardForm.BorderStyle:=bsnone;
    WizardForm.Position:=poDesktopCenter;
    // WizardForm.Center;
    WizardForm.Width:=650;
    WizardForm.Height:=450;
    // WizardForm.Color:=clWhite;
    WizardForm.OnMouseDown:=@WizardMouseDown
    isWelcomePage:=true;
    // WizardForm.InnerNotebook.Hide;
    // wizardform.Color:=TransparentColor;

    // 加载资源到 tmp 临时目录
    ExtractTemporaryFile('bg_welcome.png');
    ExtractTemporaryFile('bg_installing.png');
    ExtractTemporaryFile('bg_license.png');
    ExtractTemporaryFile('label_read.png');
    ExtractTemporaryFile('label_license.png');
    ExtractTemporaryFile('license.txt');
    ExtractTemporaryFile('btn_close.png');
    ExtractTemporaryFile('btn_back.png');
    ExtractTemporaryFile('btn_setup.png');
    ExtractTemporaryFile('btn_browser.png');
    ExtractTemporaryFile('checkbox.png');
    ExtractTemporaryFile('bg_finished.png');
    ExtractTemporaryFile('btn_complete.png');
    ExtractTemporaryFile('loading.png');
    ExtractTemporaryFile('label_autorun.png');
    ExtractTemporaryFile('btn_custom.png');
    ExtractTemporaryFile('label_shellLink.png');
    ExtractTemporaryFile('label_taskbarpin.png');

    // 关闭按钮样式
    CancelBtn:=BtnCreate(WizardForm.Handle,627,8,12,12,ExpandConstant('{tmp}\btn_close.png'),1,False)
    BtnSetEvent(CancelBtn,BtnClickEventID,WrapBtnCallback(@CancelBtnOnClick,1));
    
    // 立即安装按钮样式
    btnSetup:=BtnCreate(WizardForm.Handle,195,340,260,44,ExpandConstant('{tmp}\btn_setup.png'),1,False)
    BtnSetEvent(btnSetup,BtnClickEventID,WrapBtnCallback(@nextSetpBtnClick,1));
    
    // 自定义安装按钮样式
    customSetup:=BtnCreate(WizardForm.Handle,20,420,64,20,ExpandConstant('{tmp}\btn_custom.png'),1,False)
    BtnSetEvent(customSetup,BtnClickEventID,WrapBtnCallback(@btnCustomSetupClick,1));

    // 添加快捷方式到桌面
    checkboxShellLink:=BtnCreate(WizardForm.Handle,40,342,16,16,ExpandConstant('{tmp}\checkbox.png'),1,true)
    BtnSetChecked(checkboxShellLink,true)
    BtnSetVisibility(checkboxShellLink,false)
    
    // 锁定到任务栏
    checkboxTaskbarpin:=BtnCreate(WizardForm.Handle,200,342,16,16,ExpandConstant('{tmp}\checkbox.png'),1,true)
    BtnSetChecked(checkboxTaskbarpin,true)
    BtnSetVisibility(checkboxTaskbarpin,false)
    
    // 返回按钮样式
    btnBack:=BtnCreate(WizardForm.Handle,285,390,80,32,ExpandConstant('{tmp}\btn_back.png'),1,False)
    BtnSetEvent(btnBack,BtnClickEventID,WrapBtnCallback(@btnShowLicenseClick,1));
    BtnSetVisibility(btnBack,false)
    
    pathEdit:= TEdit.Create(WizardForm);
    with pathEdit do
    begin
      Parent:=WizardForm;
      text:=WizardForm.DirEdit.text;
      Font.Name:='宋体'
      BorderStyle:=bsNone;
      SetBounds(110,272,340,15)
      OnChange:=@pathEditChange;
      TabStop:=false;
    end;

    // 浏览按钮样式
    btnBrowser:=BtnCreate(WizardForm.Handle,470,262,80,32,ExpandConstant('{tmp}\btn_browser.png'),1,False)
    BtnSetEvent(btnBrowser,BtnClickEventID,WrapBtnCallback(@btnBrowserclick,1));

    PBOldProc:=SetWindowLong(WizardForm.ProgressGauge.Handle,-4,PBCallBack(@PBProc,4));

    // 查看 license 的文本区域
    licenseRich:= TRichEditViewer.Create(WizardForm);
    with licenseRich do
    begin
      Parent:=WizardForm;
      ReadOnly:=true;
      SCROLLBARS:=ssVertical;
      font.Name:='宋体'
      Color:=clWhite;
      BorderStyle:=bsNone;
      SetBounds(40,65,570,0)
      Lines.LoadFromFile(ExpandConstant('{tmp}\license.txt'));
      TabStop:=false;
    end;

    ImgApplyChanges(WizardForm.Handle)
  end;

// 该过程在安装终止时被调用，注意及时在用户没有安装任何文件之前退出也会被调用。
procedure DeinitializeSetup();
  var RCode: Integer;
  begin
    // 检查是否需要自动运行
    if BtngetChecked(checkboxAutoRun)=true then
    begin
      Exec(ExpandConstant('{app}\{#MyAppExeName}'),'','',SW_SHOW, ewNoWait,RCode);
    end

    gdipShutdown;
  end;
  
// 卸载程序。
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);        
  begin
    if CurUninstallStep = usDone then
    begin
      if(FileExists(ExpandConstant('{commondesktop}\{#MyAppNameZh}.lnk'))) then
      begin
        DeleteFile(ExpandConstant('{commondesktop}\{#MyAppNameZh}.lnk'));
      end;
      if MsgBox('您是否要删除用户配置信息？', mbConfirmation, MB_YESNO) = IDYES then
      begin
        DelTree(ExpandConstant('{app}'), True, True, True);
        DelTree(ExpandConstant(GetEnv('APPDATA') + '\ttkmp'), True, True, True);
      end;
    end;
  end;
  
// 在新向导页 (由CurPageID 指定) 显示后调用。
procedure CurPageChanged(CurPageID: Integer);
  var ResultCode: Integer;
  begin
    // 默认的流程按钮隐藏掉
    WizardForm.NextButton.Visible:=false;
    WizardForm.CancelButton.Height:=0;
    WizardForm.BackButton.Height:=0;
    
    if CurPageID=wpWelcome then
      begin
        BGimg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\bg_welcome.png'),0,0,650,450,true,true);

        // license 提示
        checkboxLicense:=BtnCreate(WizardForm.Handle,220,400,16,16,ExpandConstant('{tmp}\checkbox.png'),1,true)
        BtnSetEvent(checkboxLicense,BtnClickEventID,WrapBtnCallback(@checkboxLicenseClick,1))

        // 默认勾选 阅读并同意
        BtnSetChecked(checkboxLicense,true)
        labelReadImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\label_read.png'),243,398,64,20,false,true);
        btnShowLicense:=BtnCreate(WizardForm.Handle,320,398,90,20,ExpandConstant('{tmp}\label_license.png'),4,false)
        BtnSetEvent(btnShowLicense,BtnClickEventID,WrapBtnCallback(@btnShowLicenseClick,1))
        
        WizardForm.Width:=650;
        WizardForm.Height:=450;
        WizardForm.Show;
      end

    if CurPageID = wpInstalling then
      begin
        BtnSetPosition(checkboxLicense,560,421,75,15);
        pathEdit.Hide;
        BtnSetVisibility(btnBrowser,false)
        WizardForm.Height:=450
        BtnSetVisibility(btnShowLicense,false);
        BtnSetVisibility(checkboxLicense,false);
        BGimg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\bg_installing.png'),0,0,650,450,false,true);
        
        progressbgImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\loading.png'),0,320,0,0,True,True);

        BtnSetVisibility(btnSetup,false);
        BtnSetVisibility(customSetup,false);
      end
            
    if CurPageID = wpFinished then
      begin
        ImgSetVisibility(progressbgImg,false)
        btnSetup:=BtnCreate(WizardForm.Handle,195,340,260,44,ExpandConstant('{tmp}\btn_complete.png'),1,False)
        BtnSetEvent(btnSetup,BtnClickEventID,WrapBtnCallback(@nextSetpBtnClick,1));

        BGimg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\bg_finished.png'),0,0,650,450,false,true);

        // 是否自动运行
        checkboxAutoRun:=BtnCreate(WizardForm.Handle,275,400,16,16,ExpandConstant('{tmp}\checkbox.png'),1,true)
        labelAutoRunImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\label_autorun.png'),295,398,50,20,false,true);

        // 默认勾选
        BtnSetChecked(checkboxAutoRun,true)

        // 创建快捷方式
        if BtngetChecked(checkboxShellLink)=true then
        begin
          if(FileExists(ExpandConstant('{commondesktop}\{#MyAppNameZh}.lnk'))) then
          begin
            DeleteFile(ExpandConstant('{commondesktop}\{#MyAppNameZh}.lnk'));
          end;
          CreateShellLink(ExpandConstant('{commondesktop}\{#MyAppNameZh}.lnk'),'快捷方式',ExpandConstant('{app}\{#MyAppExeName}'),ExpandConstant(''),ExpandConstant('{app}'),ExpandConstant('{app}\{#ResourcesIcon}'),0,SW_SHOWNORMAL);
        end

        // 固定到任务栏
        if BtngetChecked(checkboxTaskbarpin)=true then
        begin
          if systemVersion>0 then
          begin
            ShellExec(ExpandConstant('taskbarpin'), ExpandConstant('{commondesktop}\{#MyAppNameZh}.lnk'), '', '', SW_SHOWNORMAL, ewNoWait, ResultCode);
          end
        end
        
      end

    ImgApplyChanges(WizardForm.Handle)
  end;

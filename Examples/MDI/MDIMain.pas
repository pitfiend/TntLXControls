unit MDIMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntLXForms, Menus, TntMenus, ComCtrls, ToolWin, ExtCtrls,
  TntExtCtrls, TntComCtrls, ActnList, TntActnList, StdActns, TntStdActns,
  ImgList, XPMan;

type
  TMDIMainForm = class(TTntFormLX)
    MainMenu: TTntMainMenu;
    Open1: TTntMenuItem;
    New1: TTntMenuItem;
    File1: TTntMenuItem;
    ArrangeAll1: TTntMenuItem;
    Cascade1: TTntMenuItem;
    ile1: TTntMenuItem;
    Window1: TTntMenuItem;
    TntControlBar1: TTntControlBar;
    ToolBar1: TTntToolBar;
    ToolButton1: TTntToolButton;
    ToolButton2: TTntToolButton;
    TntStatusBar1: TTntStatusBar;
    TntActionList1: TTntActionList;
    UpdateTimer: TTimer;
    ImageList1: TImageList;
    N1: TTntMenuItem;
    Exit1: TTntMenuItem;
    FileExit1: TTntFileExit;
    FileOpen1: TTntFileOpen;
    WindowArrange1: TTntWindowArrange;
    WindowMinimizeAll1: TTntWindowMinimizeAll;
    WindowTileVertical1: TTntWindowTileVertical;
    WindowTileHorizontal1: TTntWindowTileHorizontal;
    WindowCascade1: TTntWindowCascade;
    FileNew1: TTntAction;
    ileHorizontally1: TTntMenuItem;
    MinimizeAll1: TTntMenuItem;
    WindowDetach1: TTntAction;
    Detach1: TTntMenuItem;
    XPManifest1: TXPManifest;
    procedure UpdateTimerTimer(Sender: TObject);
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Accept(Sender: TObject);
    procedure TntFormLXCreate(Sender: TObject);
    procedure WindowDetach1Execute(Sender: TObject);
    procedure WindowDetach1Update(Sender: TObject);
  private
    procedure UpdateStatusBar;
  end;

var
  MDIMainForm: TMDIMainForm;

implementation

{$R *.dfm}

uses
  MDIChild, TntSysUtils;

procedure TMDIMainForm.TntFormLXCreate(Sender: TObject);
begin
  UpdateStatusBar;
end;

procedure TMDIMainForm.UpdateTimerTimer(Sender: TObject);
begin
  UpdateStatusBar;
end;

procedure TMDIMainForm.UpdateStatusBar;

  procedure UpdateKeyPanel(Index: Integer; vKey: Integer; const Text: WideString);
  begin
    if (GetKeyState(vKey) <> 0) then
      TntStatusBar1.Panels[Index].Text := Text
    else
      TntStatusBar1.Panels[Index].Text := '';
  end;

begin
  UpdateKeyPanel(1, VK_INSERT, 'INS');
  UpdateKeyPanel(2, VK_CAPITAL, 'CAP');
  UpdateKeyPanel(3, VK_NUMLOCK, 'NUM');
end;

procedure TMDIMainForm.FileNew1Execute(Sender: TObject);

  function NewFileName: WideString;
  begin
    repeat
      Tag := Tag + 1;
      Result := 'Document' + IntToStr(Tag) + '.rtf';
    until not WideFileExists(Result);
  end;

begin
  OpenTextFile(NewFileName);
end;

procedure TMDIMainForm.FileOpen1Accept(Sender: TObject);
begin
  OpenTextFile(FileOpen1.Dialog.FileName);
end;

procedure TMDIMainForm.WindowDetach1Execute(Sender: TObject);
var
  Pt: TPoint;
begin
  with ActiveMDIChild as TTntFormLX do begin
    Pt := Point(Left, Top);
    Windows.ClientToScreen(Application.MainForm.ClientHandle, Pt);
    FormStyle := fsNormal;
    SetBounds(Pt.X, Pt.Y, Width, Height);
    TaskBarButton := True;
  end;
end;

procedure TMDIMainForm.WindowDetach1Update(Sender: TObject);
begin
  WindowDetach1.Enabled := (ActiveMDIChild is TTntFormLX);
end;

end.

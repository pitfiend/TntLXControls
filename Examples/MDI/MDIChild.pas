unit MDIChild;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntLXForms, ComCtrls, TntComCtrls, ToolWin, ExtCtrls,
  TntExtCtrls, StdCtrls, StdActns, TntStdActns, ExtActns, TntExtActns,
  ActnList, TntActnList, ImgList, Menus, TntMenus, TntLXRichEdits, Buttons,
  TntButtons;

type
  TMDIChildForm = class(TTntFormLX)
    TntControlBar1: TTntControlBar;
    TntStatusBar1: TTntStatusBar;
    TntRichEditLX1: TTntRichEditLX;
    TntMainMenu1: TTntMainMenu;
    ImageList1: TImageList;
    TntActionList1: TTntActionList;
    Edit3: TTntMenuItem;
    Replace2: TTntMenuItem;
    Find2: TTntMenuItem;
    N7: TTntMenuItem;
    Paste2: TTntMenuItem;
    Copy2: TTntMenuItem;
    Cut2: TTntMenuItem;
    N8: TTntMenuItem;
    Undo2: TTntMenuItem;
    Format1: TTntMenuItem;
    Exit1: TTntMenuItem;
    N1: TTntMenuItem;
    Print1: TTntMenuItem;
    N2: TTntMenuItem;
    SaveAs1: TTntMenuItem;
    Save1: TTntMenuItem;
    Open1: TTntMenuItem;
    New1: TTntMenuItem;
    File1: TTntMenuItem;
    PageSetup1: TTntMenuItem;
    SearchReplace1: TTntSearchReplace;
    SearchFindNext1: TTntSearchFindNext;
    SearchFind1: TTntSearchFind;
    FilePageSetup1: TTntFilePageSetup;
    FileSaveAs1: TTntFileSaveAs;
    RichEditAlignCenter1: TTntRichEditAlignCenter;
    RichEditAlignRight1: TTntRichEditAlignRight;
    RichEditAlignLeft1: TTntRichEditAlignLeft;
    RichEditBullets1: TTntRichEditBullets;
    RichEditStrikeOut1: TTntRichEditStrikeOut;
    RichEditUnderline1: TTntRichEditUnderline;
    RichEditItalic1: TTntRichEditItalic;
    RichEditBold1: TTntRichEditBold;
    EditDelete1: TTntEditDelete;
    EditUndo1: TTntEditUndo;
    EditSelectAll1: TTntEditSelectAll;
    EditPaste1: TTntEditPaste;
    EditCopy1: TTntEditCopy;
    EditCut1: TTntEditCut;
    Clear1: TTntMenuItem;
    SelectAll1: TTntMenuItem;
    FindNext1: TTntMenuItem;
    AlignLeft1: TTntMenuItem;
    Center1: TTntMenuItem;
    AlignRight1: TTntMenuItem;
    Bold1: TTntMenuItem;
    Bullets1: TTntMenuItem;
    Italic1: TTntMenuItem;
    Strikeout1: TTntMenuItem;
    Underline1: TTntMenuItem;
    ToolBar1: TTntToolBar;
    ToolButton4: TTntToolButton;
    ToolButton5: TTntToolButton;
    ToolButton6: TTntToolButton;
    FileSave1: TTntAction;
    FilePrint1: TTntAction;
    N3: TTntMenuItem;
    ToolButton1: TTntToolButton;
    ToolButton2: TTntToolButton;
    ToolButton3: TTntToolButton;
    ToolButton7: TTntToolButton;
    ToolButton8: TTntToolButton;
    ToolButton9: TTntToolButton;
    ToolButton10: TTntToolButton;
    ToolButton11: TTntToolButton;
    ToolButton12: TTntToolButton;
    ToolButton13: TTntToolButton;
    ToolButton14: TTntToolButton;
    ToolButton15: TTntToolButton;
    ToolButton16: TTntToolButton;
    ToolButton17: TTntToolButton;
    ToolButton18: TTntToolButton;
    UpdateStatusBarTimer: TTimer;
    AutoUrlDetectionAction: TTntAction;
    Options1: TTntMenuItem;
    AutoURLdetection1: TTntMenuItem;
    ToolButton19: TTntToolButton;
    TntPanel1: TTntPanel;
    TntSpeedButton1: TTntSpeedButton;
    DetachAction: TTntAction;
    procedure FileSaveAs1Accept(Sender: TObject);
    procedure FileSaveAs1BeforeExecute(Sender: TObject);
    procedure TntFormLXClose(Sender: TObject; var Action: TCloseAction);
    procedure FilePrint1Execute(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);
    procedure UpdateStatusBarTimerTimer(Sender: TObject);
    procedure TntFormLXCreate(Sender: TObject);
    procedure TntRichEditLX1SelectionChange(Sender: TObject);
    procedure AutoUrlDetectionActionUpdate(Sender: TObject);
    procedure AutoUrlDetectionActionExecute(Sender: TObject);
    procedure DetachActionUpdate(Sender: TObject);
    procedure DetachActionExecute(Sender: TObject);
  private
    procedure SaveFile;
    procedure UpdateStatusBar;
    { Private declarations }
  public
    { Public declarations }
  end;

procedure OpenTextFile(const FileName: WideString);

implementation

{$R *.dfm}

uses
  TntSysUtils, MDIMain, ConvUtils, RichEdit, TntStdCtrls;

procedure OpenTextFile(const FileName: WideString);
begin
  with TMDIChildForm.Create(Application) do begin
    Caption := WideExtractFileName(FileName);
    FileSaveAs1.Dialog.FileName := FileName;
    if WideFileExists(FileName) then begin
      TntRichEditLX1.PlainText := not WideSameText(WideExtractFileExt(FileName), '.rtf');
      TntRichEditLX1.Lines.LoadFromFile(FileName);
    end;
  end;
end;

{ TMDIChildForm }

procedure TMDIChildForm.TntFormLXCreate(Sender: TObject);
begin
  UpdateStatusBar;
end;

procedure TMDIChildForm.TntFormLXClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMDIChildForm.UpdateStatusBarTimerTimer(Sender: TObject);
begin
  UpdateStatusBar;
end;

resourcestring
  SLinePos = 'Line %d, Char %d';
  SNumLines = '%d Lines';
  SOneLine = '1 Line';

procedure TMDIChildForm.UpdateStatusBar;
var
  ThisLine: Integer;
  ThisChar: Integer;
begin
  ThisLine := SendMessage(TntRichEditLX1.Handle, EM_EXLINEFROMCHAR, 0, TntCustomEdit_GetSelStart(TntRichEditLX1));
  ThisChar := TntCustomEdit_GetSelStart(TntRichEditLX1) - SendMessage(TntRichEditLX1.Handle, EM_LINEINDEX, ThisLine, 0);
  TntStatusBar1.Panels[0].Text := WideFormat(SLinePos, [ThisLine + 1, ThisChar + 1]);

  if TntRichEditLX1.Lines.Count = 0 then
    TntStatusBar1.Panels[1].Text := SOneLine
  else
    TntStatusBar1.Panels[1].Text := WideFormat(SNumLines, [TntRichEditLX1.Lines.Count + 1]);
end;

procedure TMDIChildForm.FileSaveAs1BeforeExecute(Sender: TObject);
begin
  if WideSameText(WideExtractFileExt(FileSaveAs1.Dialog.FileName), '.pas') then
    FileSaveAs1.Dialog.FilterIndex := 3
  else if WideSameText(WideExtractFileExt(FileSaveAs1.Dialog.FileName), '.txt') then
    FileSaveAs1.Dialog.FilterIndex := 2
  else if WideSameText(WideExtractFileExt(FileSaveAs1.Dialog.FileName), '.rtf') then
    FileSaveAs1.Dialog.FilterIndex := 1
end;

procedure TMDIChildForm.FileSaveAs1Accept(Sender: TObject);
begin
  Caption := WideExtractFileName(FileSaveAs1.Dialog.FileName);
  SaveFile;
end;

procedure TMDIChildForm.SaveFile;
begin
  with FileSaveAs1.Dialog do begin
    TntRichEditLX1.PlainText := not WideSameText(WideExtractFileExt(FileName), '.rtf');
    TntRichEditLX1.Lines.SaveToFile(FileName);
  end;
end;

procedure TMDIChildForm.FileSave1Execute(Sender: TObject);
begin
  if WideFileExists(FileSaveAs1.Dialog.FileName) then
    SaveFile
  else
    FileSaveAs1.Execute;
end;

procedure TMDIChildForm.FilePrint1Execute(Sender: TObject);
begin
  TntRichEditLX1.Print('Tnt LX Demo');
end;

procedure TMDIChildForm.TntRichEditLX1SelectionChange(Sender: TObject);
begin
  UpdateStatusBar;
end;

procedure TMDIChildForm.AutoUrlDetectionActionUpdate(Sender: TObject);
begin
  AutoUrlDetectionAction.Checked := TntRichEditLX1.AutoUrlDetect;
end;

procedure TMDIChildForm.AutoUrlDetectionActionExecute(Sender: TObject);
begin
  TntRichEditLX1.AutoUrlDetect := not TntRichEditLX1.AutoUrlDetect;
end;

procedure TMDIChildForm.DetachActionUpdate(Sender: TObject);
begin
  DetachAction.Enabled := (FormStyle = fsMDIChild);
end;

procedure TMDIChildForm.DetachActionExecute(Sender: TObject);
begin
  MDIMainForm.WindowDetach1.Execute;
end;

end.

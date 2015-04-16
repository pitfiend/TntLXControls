program Example1;

uses
  TntSystem,
  Forms,
  MDIMain in 'MDIMain.pas' {MDIMainForm: TTntFormLX},
  MDIChild in 'MDIChild.pas' {MDIChildForm: TTntFormLX};

{$R *.res}

begin
  InstallTntSystemUpdates;
  Application.Initialize;
  Application.CreateForm(TMDIMainForm, MDIMainForm);
  Application.Run;
end.

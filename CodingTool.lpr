program CodingTool;

{$mode delphi}{$H+}
{$IFDEF WINDOWS}{$APPTYPE GUI}{$ENDIF}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces,
  Forms,
  Unit1,
  Unit_Utility,
  Unit_UtilityCommon,
  Unit_UtilitySQL,
  Unit_UtilityMASM,
  Unit_UtilitySequence;

{$R *.res}
{$R app.res}

begin
  RequireDerivedFormResource := True;
  Application.Scaled := True;
  Application.Initialize;
  Application.Title := '程序员编码辅助工具';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

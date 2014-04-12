program CodingTool;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmMain},
  Unit_Utility in 'Unit_Utility.pas',
  Unit_UtilityCommon in 'Unit_UtilityCommon.pas',
  Unit_UtilitySQL in 'Unit_UtilitySQL.pas',
  Unit_UtilityVB in 'Unit_UtilityVB.pas',
  Unit_SendKeys in 'Unit_SendKeys.pas',
  Unit_UtilityCSharp in 'Unit_UtilityCSharp.pas',
  Unit_UtilityPascal in 'Unit_UtilityPascal.pas',
  Unit_UtilityPHP in 'Unit_UtilityPHP.pas',
  Unit_UtilityIe in 'Unit_UtilityIe.pas',
  Unit_UtilityMASM in 'Unit_UtilityMASM.pas',
  Unit_UtilityHtml in 'Unit_UtilityHtml.pas',
  Unit_UtilitySendKeys in 'Unit_UtilitySendKeys.pas',
  Unit_UtilitySequence in 'Unit_UtilitySequence.pas';

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.Title := '±à³Ì¸¨Öú¹¤¾ß';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

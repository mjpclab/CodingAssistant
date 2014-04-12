unit Unit_Utility;

interface
uses SysUtils,Classes,
  Unit_UtilityCommon,Unit_UtilitySequence,Unit_UtilitySendKeys,Unit_UtilityCSharp,Unit_UtilityVB,
  Unit_UtilityPascal,Unit_UtilityPHP,Unit_UtilitySQL,Unit_UtilityIe
  ,Unit_UtilityMASM,Unit_UtilityHtml;

type TCodeUtility=class
  private
    FLines:TStrings;
  public
    Common:TCodeUtilityCommon;
    Sequence:TCodeUtilitySequence;
    SendKeys:TCodeUtilitySendKeys;
    VB:TCodeUtilityVB;
    CSharp:TCodeUtilityCSharp;
    ObjectPascal:TCodeUtilityPascal;
    PHP:TCodeUtilityPHP;
    SQL:TCodeUtilitySQL;
    IE:TCodeUtilityIE;
    HTML:TCodeUtilityHTML;
    MASM:TCodeUtilityMASM;

    constructor Create(theLines: TStrings);
    destructor Destroy;override;
    property Lines:TStrings read FLines write FLines;
 end;
implementation

{ TCodeUtily }

constructor TCodeUtility.Create(theLines: TStrings);
begin
    inherited Create();

    //Bind a TStrings to the class.
    FLines:=theLines;
    Common:=TCodeUtilityCommon.Create(theLines);
    Sequence:=TCodeUtilitySequence.Create(theLines);
    SendKeys:=TCodeUtilitySendKeys.Create(theLines);
    VB:=TCodeUtilityVB.Create(theLines);
    CSharp:=TCodeUtilityCSharp.Create(theLines);
    ObjectPascal:=TCodeUtilityPascal.Create(theLines);
    PHP:=TCodeUtilityPHP.Create(theLines);
    SQL:=TCodeUtilitySQL.Create(theLines);
    IE:=TCodeUtilityIE.Create(theLines);
    HTML:=TCodeUtilityHTML.Create(theLines);
    MASM:=TCodeUtilityMASM.Create(theLines);
end;

destructor TCodeUtility.Destroy;
begin
    //Free members
    Common.Free;
    Sequence.Free;
    SendKeys.Free;
    VB.Free;
    CSharp.Free;
    ObjectPascal.Free;
    PHP.Free;
    SQL.Free;
    IE.Free;
    HTML.Free;
    MASM.Free;

    inherited;
end;

end.

unit Unit_Utility;
{$mode Delphi}{$H+}

interface
uses SysUtils,Classes,
  Unit_UtilityCommon,Unit_UtilitySequence,Unit_UtilityCSharp,Unit_UtilityVB,
  Unit_UtilityPascal,Unit_UtilityPHP,Unit_UtilitySQL,Unit_UtilityIe
  ,Unit_UtilityMASM,Unit_UtilityHtml;

type TCodeUtility=class
  private
    FLines:TStrings;
  public
    Common:TCodeUtilityCommon;
    Sequence:TCodeUtilitySequence;
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
    procedure SetLines(theLines:TStrings);
    property Lines:TStrings read FLines write SetLines;
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
    VB:=TCodeUtilityVB.Create(theLines);
    CSharp:=TCodeUtilityCSharp.Create(theLines);
    ObjectPascal:=TCodeUtilityPascal.Create(theLines);
    PHP:=TCodeUtilityPHP.Create(theLines);
    SQL:=TCodeUtilitySQL.Create(theLines);
    IE:=TCodeUtilityIE.Create(theLines);
    HTML:=TCodeUtilityHTML.Create(theLines);
    MASM:=TCodeUtilityMASM.Create(theLines);
end;

procedure TCodeUtility.SetLines(theLines: TStrings);
begin
    //Propagate the current TStrings to every sub-utility. Needed because LCL
    //recreates a TMemo's Lines object when its handle is (re)allocated, so the
    //reference captured at construction time can become stale.
    FLines:=theLines;
    Common.Lines:=theLines;
    Sequence.Lines:=theLines;
    VB.Lines:=theLines;
    CSharp.Lines:=theLines;
    ObjectPascal.Lines:=theLines;
    PHP.Lines:=theLines;
    SQL.Lines:=theLines;
    IE.Lines:=theLines;
    HTML.Lines:=theLines;
    MASM.Lines:=theLines;
end;

destructor TCodeUtility.Destroy;
begin
    //Free members
    Common.Free;
    Sequence.Free;
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

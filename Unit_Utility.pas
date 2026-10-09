unit Unit_Utility;
{$mode Delphi}{$H+}

interface
uses SysUtils,Classes,
  Unit_UtilityCommon,Unit_UtilitySequence,Unit_UtilitySQL,Unit_UtilityMASM;

type TCodeUtility=class
  private
    FLines:TStrings;
  public
    Common:TCodeUtilityCommon;
    Sequence:TCodeUtilitySequence;
    SQL:TCodeUtilitySQL;
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
    SQL:=TCodeUtilitySQL.Create(theLines);
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
    SQL.Lines:=theLines;
    MASM.Lines:=theLines;
end;

destructor TCodeUtility.Destroy;
begin
    //Free members
    Common.Free;
    Sequence.Free;
    SQL.Free;
    MASM.Free;

    inherited;
end;

end.

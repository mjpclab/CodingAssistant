unit Unit_UtilityMASM;

interface
uses SysUtils,Classes,StrUtils;

type TCodeUtilityMASM=class
  private const
    CppDefine:string='#define';
    AsmEqual:string='equ';
    SpaceWhite:char=' ';
    SpaceTab:char=#9;
    CppHexPrefix:string='0x';
    AsmHexSuffix:string='h';
    CppRemark:string='//';
    AsmRemark:string=';';
  private
    FLines:TStrings;
  public
    constructor Create(theLines:TStrings);
    property Lines:TStrings read FLines write FLines;

    procedure DefineToEqu;
    procedure EquToDefine;
end;

implementation

{ TCodeUtilityMASM }

constructor TCodeUtilityMASM.Create(theLines: TStrings);
begin
    FLines:=theLines;
end;

procedure TCodeUtilityMASM.DefineToEqu;     //#define ABC (0x)1234
var
    i:Integer;
    currentLine:string;
    buffer:string;
    bufferLine:string;
    spacePos:Integer;
    spacePos1:Integer;
    spacePos2:Integer;

    ExprName:string;
    ExprValue:string;
begin
    buffer:='';

    for i:=0 to FLines.Count-1 do begin
        currentLine:=Trim(FLines[i]);
        bufferLine:=FLines[i];

        if
        (
            CompareText(CppDefine,LeftStr(currentLine,Length(CppDefine)))=0
        )
        and
        (
            (MidStr(currentLine,Length(CppDefine)+1,1)=SpaceWhite)
            or
            (MidStr(currentLine,Length(CppDefine)+1,1)=SpaceTab)
        )    //ÕÒµ½ '#define '
        then begin
            Delete(currentLine,1,Length(CppDefine));
            currentLine:=TrimLeft(currentLine);

            spacePos1:=Pos(SpaceWhite,currentLine);
            spacePos2:=Pos(SpaceTab,currentLine);
            spacePos:=Length(currentLine)+1;
            if (spacePos1>0) and (spacePos1<spacePos) then spacepos:=spacePos1;
            if (spacePos2>0) and (spacePos2<spacePos) then spacepos:=spacePos2;

            if spacePos>0 then begin
                ExprName:=LeftStr(currentLine,spacePos-1);
                ExprValue:=RightStr(currentLine,Length(currentLine)-spacePos);
                ExprValue:=StringReplace(ExprValue,CppRemark,AsmRemark,[rfReplaceAll]);
                ExprValue:=Trim(ExprValue);
                if CompareText(CppHexPrefix, LeftStr(ExprValue,Length(CppHexPrefix)))=0 then begin
                    ExprValue:=Trim(RightStr(ExprValue,Length(ExprValue)-length(CppHexPrefix)));

                    spacePos1:=Pos(SpaceWhite,ExprValue);
                    spacePos2:=Pos(SpaceTab,ExprValue);
                    spacePos:=Length(ExprValue)+1;
                    if (spacePos1>0) and (spacePos1<spacePos) then spacepos:=spacePos1;
                    if (spacePos2>0) and (spacePos2<spacePos) then spacepos:=spacePos2;
                    Insert(AsmHexSuffix,ExprValue,spacePos);
                end;

                bufferLine:=ExprName + SpaceTab + AsmEqual + SpaceTab + ExprValue;
            end;
        end;

        if buffer<>'' then buffer:=buffer+ FLines.LineBreak;
        buffer:=buffer + bufferLine;
    end;

    FLines.Text:=buffer;
end;

procedure TCodeUtilityMASM.EquToDefine;
var
    i:Integer;
    currentLine:string;
    bufferLine:string;
    buffer:string;
    equPos:integer;

    spacePos:Integer;
    spacePos1:Integer;
    spacePos2:Integer;

    ExprName:string;
    ExprValue:string;
begin

    for i:=0 to FLines.Count-1 do begin
        //currentLine:=Trim(FLines[i]);
        bufferLine:=FLines[i];

        currentLine:=Trim(FLines[i]);
        currentLine:=LowerCase(currentLine);
        equPos:=Pos(AsmEqual,currentLine);
        currentLine:=Trim(FLines[i]);
        if
        (equPos>1)
        and
        (
            (MidStr(currentLine,equPos-1,1)=SpaceWhite)
            or
            (MidStr(currentLine,equPos-1,1)=SpaceTab)
        )
        and
        (
            (MidStr(currentLine,equPos+Length(AsmEqual),1)=SpaceWhite)
            or
            (MidStr(currentLine,equPos+Length(AsmEqual),1)=SpaceTab)
        )
        then begin
            ExprName:=Trim(LeftStr(currentLine,equPos-2));
            ExprValue:=
                RightStr(
                    currentLine,
                    Length(currentLine)-(equPos+Length(AsmEqual))
                );
            ExprValue:=StringReplace(ExprValue,AsmRemark,CppRemark,[rfReplaceAll]);
            ExprValue:=Trim(ExprValue);

            spacePos1:=Pos(SpaceWhite,ExprValue);
            spacePos2:=Pos(SpaceTab,ExprValue);
            spacePos:=Length(ExprValue)+1;
            if (spacePos1>0) and (spacePos1<spacePos) then spacepos:=spacePos1;
            if (spacePos2>0) and (spacePos2<spacePos) then spacepos:=spacePos2;
            if CompareText(AsmHexSuffix,MidStr(ExprValue,spacePos-length(AsmHexSuffix),length(AsmHexSuffix)))=0 then begin
                Delete(ExprValue,spacepos-length(AsmHexSuffix),length(AsmHexSuffix));
                ExprValue:=CppHexPrefix + ExprValue;
            end;

            bufferLine:=CppDefine + SpaceTab + ExprName + SpaceTab + ExprValue;
        end;

        if buffer<>'' then buffer:=buffer+ FLines.LineBreak;
        buffer:=buffer + bufferLine;
    end;

    FLines.Text:=buffer;
end;

end.

unit Unit_UtilityIe;

interface
uses Classes,StrUtils,SysUtils;

type TCodeUtilityIE=class
  private const
    strPrefixIf:string='<!--[if ';
    strSuffixIf:string=']>';
    strEndIf:string='<![endif]-->';
  private
    FLines:TStrings;
  public
    constructor Create(theLines:TStrings);
    property Lines:TStrings read FLines write FLines;

    procedure AddIfIE;
    procedure AddIfCondition(const strOperator,strVersion:string);
    procedure RemoveIf;
 end;

implementation

{ TCodeUtilityIE }

constructor TCodeUtilityIE.Create(theLines: TStrings);
begin
    FLines:=theLines;
end;

procedure TCodeUtilityIE.AddIfIE;
const
    strIfIeExpr:string='IE';
var
    expression:string;
begin
    RemoveIf;
    expression:=strPrefixIf + strIfIeExpr + strSuffixIf;
    FLines.Text:=expression + FLines.LineBreak + FLines.Text + FLines.LineBreak + strEndIf;
end;

procedure TCodeUtilityIE.AddIfCondition(const strOperator, strVersion:string);
var
    actualOperator:string;
    expression:string;
begin
    if strOperator='!' then begin
        actualOperator:='!';
    end else if strOperator='=' then begin
        actualOperator:='';
    end else if strOperator='>' then begin
        actualOperator:='gt';
    end else if strOperator='>=' then begin
        actualOperator:='gte';
    end else if strOperator='<' then begin
        actualOperator:='lt';
    end else if strOperator='<=' then begin
        actualOperator:='lte';
    end else begin
        actualOperator:='';
    end;
    if actualOperator<>'' then actualOperator:=actualOperator + ' ';


    if strVersion<>'' then begin
        RemoveIf;

        expression:=strPrefixIf + actualOperator + strVersion + strSuffixIf;
        FLines.Text:=expression + FLines.LineBreak + FLines.Text + FLines.LineBreak + strEndIf;
    end;
end;

procedure TCodeUtilityIE.RemoveIf;
var
    firstLine,lastLine:string;
begin
    if FLines.Count>0 then begin
        firstLine:=FLines[0];
        lastLine:=FLines[FLines.Count-1];

        if CompareText(lastLine,strEndIf)=0 then begin
            FLines.Delete(FLines.Count-1);
            if RightStr(FLines.Text,Length(FLines.LineBreak))=FLines.LineBreak then begin
                FLines.Text:=LeftStr(FLines.Text,Length(FLines.Text)-Length(FLines.LineBreak));
            end;
        end;

        if (
                CompareText(
                    LeftStr(firstLine,Length(strPrefixIf))
                    ,strPrefixIf
                )=0
            )
            and
            (
                CompareText(
                    RightStr(firstLine,Length(strSuffixIf))
                    ,strSuffixIf
                )=0
            )
        then begin
            FLines.Delete(0);
        end;

    end;
end;

end.

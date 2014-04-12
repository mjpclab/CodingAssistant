unit Unit_UtilityPHP;

interface
uses SysUtils,Classes,StrUtils;

type TCodeUtilityPHP=class
  private
    FLines:TStrings;
    const SignSingleQuote='''';
    const SignDoubleQuote='"';
    const SignStrConcat=' .';
    const SignHereDoc='<<<';
    const strNewLine:string=#13#10;

    procedure CombineToStringExpression(const quoteChar:char);
    procedure CancelCombineStringExpression(const quoteChar:char);
  public
    constructor Create(theLines:TStrings);
    property Lines:TStrings read FLines write FLines;

    procedure CombineToSingleQuoteStringExpression;
    procedure CombineToDoubleQuoteStringExpression;
    procedure CancelCombineSingleQuoteStringExpression;
    procedure CancelCombineDoubleQuoteStringExpression;

    procedure AddHereDocFlag(const Flag:string);
    procedure RemoveHereDocFlag;
 end;

implementation

constructor TCodeUtilityPHP.Create(theLines:TStrings);
begin
    //Bind a TStrings to the class.
    FLines:=theLines;
end;

{$REGION '组合'}
    procedure TCodeUtilityPHP.CombineToStringExpression(const quoteChar:char);
    var
        i:integer;
        strBuffer:string;
        changed:boolean;
        SignStrBegin:string;
        SignStrContinue:string;
        buffer:TStrings;
    begin
        SignStrBegin:=quoteChar;
        SignStrContinue:=quoteChar + SignStrConcat;

        buffer:=TStringList.Create;
        buffer.Assign(FLines);

        with buffer do begin
            for i := 0 to Count - 1 do begin
                changed:=false;
                strBuffer:=Strings[i];

                //Adjust left side
                if LeftStr(TrimLeft(strBuffer),Length(SignStrBegin))<>SignStrBegin then begin
                    strBuffer:=SignStrBegin + strBuffer;
                    changed:=true;
                end;

                //Adjust right side
                if RightStr(TrimRight(strBuffer),Length(SignStrContinue))<>SignStrContinue then begin
                    strBuffer:=strBuffer + SignStrContinue;
                    changed:=true;
                end;

                //finally
                if changed then Strings[i]:=strBuffer;
            end;
        end;

        FLines.Assign(buffer);
        buffer.Free;
    end;

    procedure TCodeUtilityPHP.CombineToSingleQuoteStringExpression;
    begin
        CombineToStringExpression(SignSingleQuote);
    end;

    procedure TCodeUtilityPHP.CombineToDoubleQuoteStringExpression;
    begin
        CombineToStringExpression(SignDoubleQuote);
    end;

{$ENDREGION}

{$REGION '取消组合'}
    procedure TCodeUtilityPHP.CancelCombineStringExpression(const quoteChar:char);
    var
        i:integer;
        strTrimmed:string;
        strBuffer:string;
        changed:boolean;
        SignStrBegin:string;
        SignStrContinue:string;
        buffer:TStrings;
    begin
        SignStrBegin:=quoteChar;
        SignStrContinue:=quoteChar + SignStrConcat;

        buffer:=TStringList.Create;
        buffer.Assign(FLines);

        with buffer do begin
            for i := 0 to Count - 1 do begin
                changed:=false;
                strBuffer:=Strings[i];

                //Adjust left side
                strTrimmed:=TrimLeft(strBuffer);
                if LeftStr(strTrimmed,Length(SignStrBegin))=SignStrBegin then begin
                    strBuffer:=RightStr(strTrimmed,Length(strTrimmed)-Length(SignStrBegin));
                    changed:=true;
                end;

                //Adjust right side
                strTrimmed:=TrimRight(strBuffer);
                if RightStr(strTrimmed,Length(SignStrContinue))=SignStrContinue then begin
                    strBuffer:=LeftStr(strTrimmed,Length(strTrimmed)-Length(SignStrContinue));
                    changed:=true;
                end;

                //finally
                if changed then Strings[i]:=strBuffer;
            end;
        end;

        FLines.Assign(buffer);
        buffer.Free;
    end;

    procedure TCodeUtilityPHP.CancelCombineSingleQuoteStringExpression;
    begin
        CancelCombineStringExpression(SignSingleQuote);
    end;

    procedure TCodeUtilityPHP.CancelCombineDoubleQuoteStringExpression;
    begin
        CancelCombineStringExpression(SignDoubleQuote);
    end;
{$ENDREGION}

procedure TCodeUtilityPHP.AddHereDocFlag(const Flag: string);
const
    separator:char=' ';
var
    buffer:string;
begin
    buffer:= SignHereDoc + separator + Flag + strNewLine +
                    FLines.Text;
    if RightStr(buffer,Length(strNewLine))<>strNewLine then buffer:=buffer+strNewLine;
    buffer:=buffer+Flag;

    FLines.Text:=buffer;
end;

procedure TCodeUtilityPHP.RemoveHereDocFlag;
var
    buffer:TStrings;
    firstLine,lastLine:string;
    flag:string;
begin
    buffer:=TStringList.Create;
    buffer.Assign(FLines);

    if buffer.Count>0 then begin                             //存在数据
        firstLine:=Trim(buffer[0]);
        lastLine:=Trim(buffer[buffer.Count-1]);
        if Pos(SignHereDoc,firstLine)=1 then begin           //存在here doc
            flag:=Trim(
                RightStr(
                    firstLine
                    ,Length(firstLine)-Length(SignHereDoc)
                )
            );

            if flag=lastLine then buffer.Delete(buffer.Count-1);
            if buffer.Count>0 then buffer.Delete(0);
        end;
    end;

    FLines.Assign(buffer);
    buffer.Free;
end;

end.

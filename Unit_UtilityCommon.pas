unit Unit_UtilityCommon;

interface
uses
    SysUtils,Classes,StrUtils;

type TCodeUtilityCommon=class
  private const
    chrTab:Char=#9;
    chrSpace:Char=' ';
    chrComma:Char=',';
  private
    FLines:TStrings;
    procedure AddColumnSeparator(const Separator: string;const OtherSpace:array of char; var strBuffer:string);
    procedure MergeContinuousSeparator(const Separator: string;var strBuffer:string);
    function PosRev(const subStr,str:string):Integer;
  public
    constructor Create(theLines:TStrings);
    property Lines:TStrings read FLines write FLines;

    procedure AddPrefix(const Value:string);
    procedure AddPostfix(const Value:string);
    procedure DeleteNPrefix(const Value:integer);
    procedure DeleteNSuffix(const Value:integer);
    procedure DeletePrefix(const prefix:string);
    procedure DeleteSuffix(const suffix:string);
    procedure DeleteBeforeStringLookForward(const find:string;const deleteFindString:Boolean);
    procedure DeleteBeforeStringLookBackward(const find:string;const deleteFindString:Boolean);
    procedure DeleteAfterStringLookForward(const find:string;const deleteFindString:Boolean);
    procedure DeleteAfterStringLookBackward(const find:string;const deleteFindString:Boolean);
    procedure InsertBeforeString(const find,input:string);
    procedure InsertAfterString(const find,input:string);
    procedure SplitLines(const Separator:string;const ReserveSeparator:integer);
    procedure MergeLines(const Separator:string);
    //procedure ExchangeEqualSide;
    procedure ExchangeLetOperatorSide(const separator:string);
    procedure ConvertToLowerCase;
    procedure ConvertToUpperCase;
    procedure Trim;
    procedure TrimLeft;
    procedure TrimRight;
    procedure CompressSpaces;
    procedure ConvertSpaceToTab;
    procedure ConvertTabToSpace;
    procedure ConvertTabToComma;
    procedure ConvertCommaToTab;
    procedure DeleteEmptyLine(const IncludeWhiteSpaceLine:boolean);
    procedure CompactEmptyLine(const IncludeWhiteSpaceLine:boolean);
    procedure Replace(const strFrom:string; const strTo:string);
    //procedure SendKeyPress(const IsPureText:Boolean);
    procedure RevertLines;

    procedure InsertString(const index:Integer;const content:string);
    procedure RInsertString(const rIndex:Integer;const content:string);
    procedure DeleteString(const start,count:integer);
    procedure DeleteStringByPosition(const start,stop:Integer);
    procedure RDeleteString(const rStart,rCount:integer);
    procedure RDeleteStringByPosition(const rStart,rStop:Integer);
    procedure DeleteColumn(const delimit:string;const colno:Integer);
    procedure ExtractString(const start,count:integer);
    procedure ExtractStringByPosition(const start,stop:Integer);
    procedure RExtractString(const rStart,rCount:integer);
    procedure RExtractStringByPosition(const rStart,rStop:Integer);
    procedure ExtractColumn(const delimit:string;const colno:Integer);

    procedure ReplaceEachLine(const outerLines:TStrings;find:string);
    procedure JoinAfterEachLine(const outerLines:TStrings);
    procedure JoinBeforeEachLine(const outerLines:TStrings);
    procedure CrossInsertBeforeEachLine(const outerLines:TStrings);
    procedure CrossInsertAfterEachLine(const outerLines:TStrings);
    procedure CircuCrossInsertBeforeEachLine(const outerLines:TStrings);
    procedure CircuCrossInsertAfterEachLine(const outerLines:TStrings);
    procedure RepeatHorz(const separator:string;const count:Integer);
    procedure RepeatEachLine(const count:Integer);
    procedure RepeatAllLines(const count:Integer);


    procedure LineFirstLower;
    procedure LineFirstUpper;
    procedure AfterFirstLower(const find:string);
    procedure AfterFirstUpper(const find:string);

    procedure DeleteDuplicatedLine(const ignoreCase, ignoreWhitePadding:Boolean);
 end;

implementation

constructor TCodeUtilityCommon.Create(theLines:TStrings);
begin
    //Bind a TStrings to the class.
    FLines:=theLines;
end;

{Private}
procedure TCodeUtilityCommon.AddColumnSeparator(const Separator: string;const OtherSpace:array of char; var strBuffer:string);
//将行中的空白替换为特定分隔符，以便导入导出为表格式数据
var
    i:integer;
begin
    strBuffer:=FLines.Text;
    for i := Low(OtherSpace) to High(OtherSpace) do begin
        strBuffer:=StringReplace(strBuffer,OtherSpace[i],Separator,[rfReplaceAll]);
    end;

    //MergeContinuousSeparator(Separator,strBuffer);
    Flines.Text:=strBuffer;
end;

procedure TCodeUtilityCommon.MergeContinuousSeparator(const Separator: string;var strBuffer:string);
var
    WordPos:integer;
    SeparatorCount:integer;
    SeparatorSize:integer;
begin
    WordPos:=0;
    SeparatorSize:=Length(Separator);

    while true do begin
        WordPos:=PosEx(Separator,strBuffer,WordPos+1);
        if WordPos=0 then break;

        SeparatorCount:=1;
        while Copy(strBuffer,WordPos+SeparatorCount*SeparatorSize,SeparatorSize)=Separator do Inc(SeparatorCount);
        if SeparatorCount>1 then Delete(strBuffer,WordPos+SeparatorSize,(SeparatorCount-1)*SeparatorSize);
    end;
end;

function TCodeUtilityCommon.PosRev(const subStr, str: string): Integer;
var
    i:integer;
begin
    Result:=0;

    for i := Length(str)-Length(subStr)+1 downto 1 do begin
        if MidStr(str,i,Length(subStr))=subStr then begin
            Result:=i;
            break;
        end;
    end;

end;



{Public}
procedure TCodeUtilityCommon.AddPrefix(const Value: string);
const
    strReturn:string=#13#10;
var
    //i:integer;
    EndWithNewLine:boolean;
begin
    with FLines do begin
        //for i:=0 to Count-1 do Strings[i]:=Value + Strings[i];
        if RightStr(Text,Length(strReturn))=strReturn then begin
            Text:=LeftStr(Text,Length(Text)-Length(strReturn));
            EndWithNewLine:=true;
        end else begin
            EndWithNewLine:=false;
        end;
        Text:=Value+StringReplace(Text,strReturn,strReturn+Value,[rfReplaceAll]);
        if EndWithNewLine then Text:=Text+strReturn;
    end;
end;

procedure TCodeUtilityCommon.AddPostfix(const Value: string);
const
    strReturn:string=#13#10;
var
    //i:integer;
    EndWithNewLine:boolean;
begin
    with FLines do begin
        //for i:=0 to Count-1 do Strings[i]:=Strings[i] + Value;
        if RightStr(Text,Length(strReturn))=strReturn then begin
            Text:=LeftStr(Text,Length(Text)-Length(strReturn));
            EndWithNewLine:=true;
        end else begin
            EndWithNewLine:=false;
        end;

        Text:=StringReplace(Text,strReturn,Value+strReturn,[rfReplaceAll])+Value;
        if EndWithNewLine then Text:=Text+strReturn;
    end;
end;

procedure TCodeUtilityCommon.DeleteNPrefix(const Value: integer);
var
    buffer:TStrings;
    tmpStr:WideString;
    i:integer;
begin
    buffer:=TStringList.Create;
    buffer.Assign(FLines);

    for i := 0 to buffer.Count - 1 do begin
        tmpStr:=buffer.Strings[i];
        Delete(tmpStr,1,Value);
        buffer.Strings[i]:=tmpStr;
    end;

    FLines.Assign(buffer);
    buffer.Free;
end;

procedure TCodeUtilityCommon.DeleteNSuffix(const Value: integer);
var
    buffer:TStrings;
    tmpStr:WideString;
    DelPos:integer;
    i:integer;
begin
    buffer:=TStringList.Create;
    buffer.Assign(FLines);

    for i := 0 to buffer.Count - 1 do begin
        tmpStr:=buffer.Strings[i];
        DelPos:=Length(tmpStr)-Value+1;
        if DelPos<1 then DelPos:=1;


        Delete(tmpStr,DelPos,Value);
        buffer.Strings[i]:=tmpStr;
    end;

    FLines.Assign(buffer);
    buffer.Free;
end;

procedure TCodeUtilityCommon.DeletePrefix(const prefix: string);
var
    buffer:string;
begin
    buffer:=FLines.Text;

    if LeftStr(buffer,Length(prefix))=prefix then begin
        Delete(buffer,1,Length(prefix));
    end;

    buffer:=StringReplace(buffer,FLines.LineBreak+prefix,FLines.LineBreak,[rfReplaceAll]);

    FLines.Text:=buffer;
end;

procedure TCodeUtilityCommon.DeleteSuffix(const suffix: string);
var
    buffer:string;
begin
    buffer:=FLines.Text;

    if RightStr(buffer,Length(suffix))=suffix then begin
        buffer:=LeftStr(buffer,Length(buffer)-length(suffix));
    end;


    buffer:=StringReplace(buffer,suffix+FLines.LineBreak,FLines.LineBreak,[rfReplaceAll]);

    FLines.Text:=buffer;
end;

procedure TCodeUtilityCommon.DeleteBeforeStringLookForward(const find: string;const deleteFindString:Boolean);
var
    foundIndex:integer;
    buffer:TStrings;
    reservedLength:integer;
    i:Integer;
begin
    buffer:=TStringList.Create;
    buffer.Assign(FLines);

    for i := 0 to buffer.Count - 1 do begin
        foundIndex:=Pos(find,buffer[i]);
        if foundIndex>0 then begin
            if deleteFindString then
                reservedLength:=Length(buffer[i])-foundIndex+1-Length(find)
            else
                reservedLength:=Length(buffer[i])-foundIndex+1;

            buffer[i]:=RightStr(buffer[i],reservedLength);
        end;
    end;

    FLines.Assign(buffer);
end;

procedure TCodeUtilityCommon.DeleteBeforeStringLookBackward(const find: string;const deleteFindString:Boolean);
var
    foundIndex:integer;
    buffer:TStrings;
    reservedLength:integer;
    i:Integer;
begin
    buffer:=TStringList.Create;
    buffer.Assign(FLines);

    for i := 0 to buffer.Count - 1 do begin
        foundIndex:=PosRev(find,buffer[i]);
        if foundIndex>0 then begin
            if deleteFindString then
                reservedLength:=Length(buffer[i])-foundIndex+1-Length(find)
            else
                reservedLength:=Length(buffer[i])-foundIndex+1;

            buffer[i]:=RightStr(buffer[i],reservedLength);
        end;
    end;

    FLines.Assign(buffer);
end;

procedure TCodeUtilityCommon.DeleteAfterStringLookForward(const find: string;const deleteFindString:Boolean);
var
    foundIndex:integer;
    buffer:TStrings;
    reservedLength:integer;
    i:Integer;
begin
    buffer:=TStringList.Create;
    buffer.Assign(FLines);

    for i := 0 to buffer.Count - 1 do begin
        foundIndex:=Pos(find,buffer[i]);
        if foundIndex>0 then begin
            if deleteFindString then
                reservedLength:=foundIndex-1
            else
                reservedLength:=foundIndex-1+Length(find);

            buffer[i]:=LeftStr(buffer[i],reservedLength)
        end;
    end;

    FLines.Assign(buffer);
end;

procedure TCodeUtilityCommon.DeleteAfterStringLookBackward(const find: string;const deleteFindString:Boolean);
var
    foundIndex:integer;
    buffer:TStrings;
    reservedLength:integer;
    i:Integer;
begin
    buffer:=TStringList.Create;
    buffer.Assign(FLines);

    for i := 0 to buffer.Count - 1 do begin
        foundIndex:=PosRev(find,buffer[i]);
        if foundIndex>0 then begin
            if deleteFindString then
                reservedLength:=foundIndex-1
            else
                reservedLength:=foundIndex-1+Length(find);

            buffer[i]:=LeftStr(buffer[i],reservedLength)
        end;
    end;

    FLines.Assign(buffer);
end;

procedure TCodeUtilityCommon.InsertBeforeString(const find, input: string);
begin
    FLines.Text:=StringReplace(FLines.Text,find,input+find,[rfReplaceAll]);
end;

procedure TCodeUtilityCommon.InsertAfterString(const find, input: string);
begin
    FLines.Text:=StringReplace(FLines.Text,find,find+input,[rfReplaceAll]);
end;

{
procedure TCodeUtilityCommon.SendKeyPress(const IsPureText:Boolean);
const
    strReturn:string=#13#10;
    strEnter:string=#13;

var
    Buffer:string;
begin
    if Length(FLines.Text)>0 then begin
        //Get Buffer
        Buffer:=StringReplace(FLines.Text,strReturn,strEnter,[rfReplaceAll]);
        SendKeys(Buffer,false,IsPureText);
    end;
end;
}

procedure TCodeUtilityCommon.SplitLines(const Separator: string; const ReserveSeparator: integer);
const
    PreservePrefix:integer=1;
    PreservePostfix:integer=2;
var
    ReplacedString:string;
begin
    if Separator<>EmptyStr then begin
        ReplacedString:=#13#10;
        if ReserveSeparator=PreservePrefix then begin             //保留为前缀分隔符
            ReplacedString:=ReplacedString+Separator;
        end else if ReserveSeparator=PreservePostfix then begin   //保留为后缀分隔符
            ReplacedString:=Separator+ReplacedString;
        end;

        with FLines do begin
            Text:=StringReplace(Text,Separator,ReplacedString,[rfReplaceAll]);
        end;
    end;
end;

procedure TCodeUtilityCommon.MergeLines(const Separator: string);
var
    ReturnString:string;
begin
    ReturnString:=#13#10;
    with FLines do begin
        Text:=StringReplace(Text,ReturnString,Separator,[rfReplaceAll]);
    end;
end;

{procedure TCodeUtilityCommon.ExchangeEqualSide;
const
    strOperator:string='=';
var
    i:integer;
    str1,str2:string;
    equalpos:integer;
    tempstr:string;
    buffer:TStrings;
begin
    buffer:=TStringList.Create;
    buffer.Assign(FLines);

    for i:=0 to buffer.Count-1 do begin
        tempstr:=buffer.Strings[i];
        equalpos:=pos(strOperator,tempstr);
        if equalpos>0 then begin
            str1:=LeftStr(tempstr,equalpos-1);
            str2:=RightStr(tempstr,length(tempstr)-(equalpos+Length(strOperator)-1));
            buffer.Strings[i]:=str2 + strOperator + str1;
        end;
    end;

    FLines.Assign(buffer);
    buffer.Free;
end;}

procedure TCodeUtilityCommon.ExchangeLetOperatorSide(const separator: string);
const
    sentenceTerminator:char=';';
    strNewLine:string=#13#10;
    spaceChar:char=' ';
    tabChar:char=#9;
var
    i,j:integer;
    strLeft,strRight:string;
    equalPos:integer;
    paddedSeparator:string;
    paddedEqualStart,paddedEqualEnd:integer;
    currentLine:string;
    currentChar:string;
    currentLineLength:integer;
    fixedLeft,fixedRight:string;
    fixedLeftLength,fixedRightLength:integer;
    bufferIn:TStrings;
    bufferOut:string;
begin
    bufferIn:=TStringList.Create;
    bufferIn.Assign(FLines);

    bufferOut:=EmptyStr;

    for i:=0 to bufferIn.Count-1 do begin
        currentLine:=bufferIn.Strings[i];
        currentLineLength:=Length(currentLine);
        equalPos:=pos(separator,currentLine);
        if equalPos>0 then begin
            //beginning and ending white space will not be exchanged, recognize them
            for j := 1 to equalPos do begin
                currentChar:=CurrentLine[j];
                if (currentChar<>spaceChar) and (currentChar<>tabChar) then break;
            end;
            fixedLeft:=LeftStr(CurrentLine,j-1);
            fixedLeftLength:=j-1;

            for j := currentLineLength downto equalPos do begin
                currentChar:=CurrentLine[j];
                if (currentChar<>spaceChar) and (currentChar<>tabChar) and (currentChar<>sentenceTerminator) then break;
            end;
            fixedRight:=RightStr(CurrentLine,currentLineLength-j);
            fixedRightLength:=currentLineLength-j;

            //white space boefore and after separator will not join the exchange
            paddedEqualStart:=equalPos;
            for j := equalPos-1 downto fixedLeftLength+1 do begin
                currentChar:=CurrentLine[j];
                if (currentChar=spaceChar) or (currentChar=tabChar) then begin
                    paddedEqualStart:=j;
                end else begin
                    break;
                end;
            end;

            paddedEqualEnd:=equalPos+Length(separator)-1;
            for j := equalPos+Length(separator) to currentLineLength-fixedRightLength do begin
                currentChar:=CurrentLine[j];
                if (currentChar=spaceChar) or (currentChar=tabChar) then begin
                    paddedEqualEnd:=j;
                end else begin
                    break;
                end;
            end;

            paddedSeparator:=MidStr(currentLine,paddedEqualStart,paddedEqualEnd-paddedEqualStart+1);

            //recognize strings need to be exchanged
            strLeft:=MidStr(currentLine,fixedLeftLength+1, paddedEqualStart-1-fixedLeftLength);
            strRight:=MidStr(currentLine,paddedEqualEnd+1,currentLineLength-fixedRightLength-paddedEqualEnd);

            bufferOut:=bufferOut + fixedLeft + strRight + paddedSeparator + strLeft + fixedRight + strNewLine;
            {
            bufferOut:=bufferOut
                + ',fixedLeft:' + fixedLeft
                + ',strLeft:' + strLeft
                + ',paddedSep:' + paddedSeparator
                + ',strRight:' + strRight
                + ',fixedRight:' + fixedRight
                + strNewLine;
            }
        end else begin
            bufferOut:=bufferOut + currentLine + strNewLine;
        end;
    end;

    FLines.Text:=bufferOut;
    bufferIn.Free;
end;

procedure TCodeUtilityCommon.ConvertToLowerCase;
begin
    FLines.Text:=LowerCase(FLines.Text);
end;

procedure TCodeUtilityCommon.ConvertToUpperCase;
begin
    FLines.Text:=UpperCase(FLines.Text);
end;

procedure TCodeUtilityCommon.Trim;
var
    i:integer;
    buffer:TStrings;
begin
    buffer:=TStringList.Create;
    buffer.Assign(FLines);

    with buffer do begin
        for i := 0 to Count - 1 do Strings[i]:=SysUtils.Trim(Lines[i]);
    end;

    FLines.Assign(buffer);
    buffer.Free;
end;

procedure TCodeUtilityCommon.TrimLeft;
var
    i:integer;
    buffer:TStrings;
begin
    buffer:=TStringList.Create;
    buffer.Assign(FLines);

    with buffer do begin
        for i := 0 to Count - 1 do Strings[i]:=SysUtils.TrimLeft(Lines[i]);
    end;

    FLines.Assign(buffer);
    buffer.Free;
end;

procedure TCodeUtilityCommon.TrimRight;
var
    i:integer;
    buffer:TStrings;
begin
    buffer:=TStringList.Create;
    buffer.Assign(FLines);

    with buffer do begin
        for i := 0 to Count - 1 do Strings[i]:=SysUtils.TrimRight(Lines[i]);
    end;

    FLines.Assign(buffer);
    buffer.Free;
end;

procedure TCodeUtilityCommon.CompressSpaces;
const
    chrSpace:char=' ';
    chrOtherSpaces:array[0..0] of char=(#9);
var
    buffer:string;
begin
    buffer:=FLines.Text;

    AddColumnSeparator(chrSpace,chrOtherSpaces,buffer);
    MergeContinuousSeparator(chrSpace,buffer);

    Flines.Text:=buffer;
end;

procedure TCodeUtilityCommon.ConvertSpaceToTab;
begin
    FLines.Text:=StringReplace(FLines.Text,chrSpace,chrTab,[rfReplaceAll]);
end;

procedure TCodeUtilityCommon.ConvertTabToSpace;
begin
    FLines.Text:=StringReplace(FLines.Text,chrTab,chrSpace,[rfReplaceAll]);
end;

procedure TCodeUtilityCommon.ConvertTabToComma;
begin
    FLines.Text:=StringReplace(FLines.Text,chrTab,chrComma,[rfReplaceAll]);
end;

procedure TCodeUtilityCommon.ConvertCommaToTab;
begin
    FLines.Text:=StringReplace(FLines.Text,chrComma,chrTab,[rfReplaceAll]);
end;

procedure TCodeUtilityCommon.DeleteEmptyLine(const IncludeWhiteSpaceLine: boolean);
const
    strReturn=#13#10;
var
    buffer,currentLine:string;
    i:Integer;
begin
    for i := 0 to FLines.Count-1 do begin
        currentLine:=FLines[i];
        if IncludeWhiteSpaceLine then currentLine:=SysUtils.Trim(currentLine);

        if currentLine<>'' then begin
            if buffer<>'' then buffer:=buffer + strReturn;
            buffer:=buffer + FLines[i];
        end;
    end;

    FLines.Text:=buffer;
end;

procedure TCodeUtilityCommon.CompactEmptyLine(const IncludeWhiteSpaceLine: boolean);
const
    strReturn=#13#10;
var
    buffer,currentLine:string;
    i:Integer;
    emptyLineFound:Boolean;
begin
    emptyLineFound:=False;

    for i := 0 to FLines.Count-1 do begin
        currentLine:=FLines[i];
        if IncludeWhiteSpaceLine then currentLine:=SysUtils.Trim(currentLine);

        if currentLine<>'' then begin
            //if buffer<>'' then buffer:=buffer + strReturn;
            buffer:=buffer + FLines[i] + strReturn;
            emptyLineFound:=False;
        end else if (currentLine='') and (emptyLineFound=False) then begin
            //if buffer<>'' then buffer:=buffer + strReturn;
            buffer:=buffer + FLines[i] + strReturn;
            emptyLineFound:=True;
        end;
    end;

    FLines.Text:=buffer;
end;

procedure TCodeUtilityCommon.Replace(const strFrom, strTo: string);
begin
    with FLines do Text:=StringReplace(Text,strFrom,strTo,[rfReplaceAll]);
end;

procedure TCodeUtilityCommon.RevertLines;
var
    buffer:TStrings;
    i:integer;
begin
    buffer:=TStringList.Create;

    for i := FLines.Count-1 downto 0 do begin
        buffer.Append(FLines.Strings[i]);
    end;

    FLines.Text:=buffer.Text;

end;

procedure TCodeUtilityCommon.InsertString(const index: Integer; const content: string);
const
    newLine:string=#13#10;
var
    buffer:string;
    currentLine:string;
    s:string;
begin
    buffer:='';

    for s in FLines do begin
        currentLine:=s;
        Insert(content,currentLine,index+1);
        buffer:=buffer+currentLine + newLine;
    end;

    FLines.Text:=buffer;
end;

procedure TCodeUtilityCommon.RInsertString(const rIndex: Integer;
  const content: string);
const
    newLine:string=#13#10;
var
    buffer:string;
    currentLine:string;
    s:string;
begin
    buffer:='';

    for s in FLines do begin
        currentLine:=s;
        Insert(content,currentLine,Length(currentLine)-rIndex+1);
        buffer:=buffer+currentLine + newLine;
    end;

    FLines.Text:=buffer;
end;

procedure TCodeUtilityCommon.DeleteString(const start, count: integer);
const
    newLine:string=#13#10;
var
    buffer:string;
    currentLine:string;
    s:string;
begin
    buffer:='';

    for s in FLines do begin
        currentLine:=s;
        Delete(currentLine,start,count);
        buffer:=buffer+currentLine + newLine;
    end;

    FLines.Text:=buffer;
end;

procedure TCodeUtilityCommon.RDeleteString(const rStart, rCount: integer);
const
    newLine:string=#13#10;
var
    buffer:string;
    currentLine:string;
    s:string;
begin
    buffer:='';

    for s in FLines do begin
        currentLine:=s;
        Delete(currentLine,Length(currentLine)-rStart-rCount+2,rCount);
        buffer:=buffer+currentLine + newLine;
    end;

    FLines.Text:=buffer;
end;


procedure TCodeUtilityCommon.DeleteStringByPosition(const start, stop: Integer);
begin
    Self.DeleteString(start,stop-start+1);
end;

procedure TCodeUtilityCommon.RDeleteStringByPosition(const rStart, rStop: Integer);
begin
    Self.RDeleteString(rStart,rStop-rStart+1);
end;

procedure TCodeUtilityCommon.ExtractString(const start, count: integer);
const
    newLine:string=#13#10;
var
    buffer:string;
    currentLine:string;
    s:string;
begin
    buffer:='';

    for s in FLines do begin
        currentLine:=MidStr(s,start,count);
        buffer:=buffer+currentLine + newLine;
    end;

    FLines.Text:=buffer;
end;

procedure TCodeUtilityCommon.RExtractString(const rStart, rCount: integer);
const
    newLine:string=#13#10;
var
    buffer:string;
    currentLine:string;
    s:string;
begin
    buffer:='';

    for s in FLines do begin
        currentLine:=MidStr(s,Length(s)-rStart-rCount+2,rCount);
        buffer:=buffer+currentLine + newLine;
    end;

    FLines.Text:=buffer;
end;

procedure TCodeUtilityCommon.ExtractStringByPosition(const start, stop: Integer);
begin
    Self.ExtractString(start,stop-start+1);
end;

procedure TCodeUtilityCommon.RExtractStringByPosition(const rStart, rStop: Integer);
begin
    Self.RExtractString(rStart,rStop-rStart+1);
end;

procedure TCodeUtilityCommon.ReplaceEachLine(const outerLines: TStrings; find: string);
const
    newLine:string=#13#10;
var
    oldBuffer,replacementBuffer:TStrings;
    minLines:integer;
    i:integer;
    replacedLine:string;
    bufferResult:string;
begin
    oldBuffer:=TStringList.Create;
    oldBuffer.Assign(FLines);

    replacementBuffer:=TStringList.Create;
    replacementBuffer.Assign(outerLines);

    if oldBuffer.Count<=replacementBuffer.Count then begin
        minLines:=oldBuffer.Count;
    end else begin
        minLines:=replacementBuffer.Count;
    end;

    for i := 0 to minLines - 1 do begin
        replacedLine:=StringReplace(oldBuffer[i],find,replacementBuffer[i],[rfReplaceAll]);
        bufferResult:=bufferResult+replacedLine+newLine;
    end;

    FLines.Text:=bufferResult;
end;

procedure TCodeUtilityCommon.JoinBeforeEachLine(const outerLines: TStrings);
const
    newLine:string=#13#10;
var
    buffer1,buffer2:TStrings;
    maxLines:integer;
    i:integer;
    joinedLine:string;
    bufferResult:string;
begin
    buffer1:=TStringList.Create;
    buffer1.Assign(FLines);

    buffer2:=TStringList.Create;
    buffer2.Assign(outerLines);

    if buffer1.Count>=buffer2.Count then begin
        maxLines:=buffer1.Count;
    end else begin
        maxLines:=buffer2.Count;
    end;

    for i := 0 to maxLines - 1 do begin
        joinedLine:='';
        if i<buffer2.Count then joinedLine:=JoinedLine+buffer2[i];
        if i<buffer1.Count then joinedLine:=JoinedLine+buffer1[i];

        bufferResult:=bufferResult+joinedLine+newLine;
    end;

    FLines.Text:=bufferResult;
end;

procedure TCodeUtilityCommon.JoinAfterEachLine(const outerLines: TStrings);
const
    newLine:string=#13#10;
var
    buffer1,buffer2:TStrings;
    maxLines:integer;
    i:integer;
    joinedLine:string;
    bufferResult:string;
begin
    buffer1:=TStringList.Create;
    buffer1.Assign(FLines);

    buffer2:=TStringList.Create;
    buffer2.Assign(outerLines);

    if buffer1.Count>=buffer2.Count then begin
        maxLines:=buffer1.Count;
    end else begin
        maxLines:=buffer2.Count;
    end;

    for i := 0 to maxLines - 1 do begin
        joinedLine:='';
        if i<buffer1.Count then joinedLine:=JoinedLine+buffer1[i];
        if i<buffer2.Count then joinedLine:=JoinedLine+buffer2[i];

        bufferResult:=bufferResult+joinedLine+newLine;
    end;

    FLines.Text:=bufferResult;
end;

procedure TCodeUtilityCommon.CrossInsertBeforeEachLine(const outerLines: TStrings);
const
    newLine:string=#13#10;
var
    maxLines:integer;
    i:integer;
    bufferResult:string;
begin
    if FLines.Count>=outerLines.Count then begin
        maxLines:=FLines.Count;
    end else begin
        maxLines:=outerLines.Count;
    end;

    bufferResult:='';
    for i := 0 to maxLines - 1 do begin
        if i<outerLines.Count then bufferResult:=bufferResult+outerLines[i]+newLine;
        if i<FLines.Count then bufferResult:=bufferResult+FLines[i]+newLine;
    end;

    FLines.Text:=bufferResult;
end;

procedure TCodeUtilityCommon.CrossInsertAfterEachLine(const outerLines: TStrings);
const
    newLine:string=#13#10;
var
    maxLines:integer;
    i:integer;
    bufferResult:string;
begin
    if FLines.Count>=outerLines.Count then begin
        maxLines:=FLines.Count;
    end else begin
        maxLines:=outerLines.Count;
    end;

    bufferResult:='';
    for i := 0 to maxLines - 1 do begin
        if i<FLines.Count then bufferResult:=bufferResult+FLines[i]+newLine;
        if i<outerLines.Count then bufferResult:=bufferResult+outerLines[i]+newLine;
    end;

    FLines.Text:=bufferResult;
end;

procedure TCodeUtilityCommon.CircuCrossInsertBeforeEachLine(const outerLines: TStrings);
const
    newLine:string=#13#10;
var
    iLine,iOuter:Integer;
    buffer:string;
begin
    if (FLines.Count>0) and (outerLines.Count>0) then begin
        buffer:='';
        iOuter:=0;

        for iLine := 0 to FLines.Count - 1 do begin
            buffer:=buffer + outerLines[iOuter] + newLine + FLines[iLine] + newLine;
            iOuter:=(iOuter+1) mod outerLines.Count;
        end;

        FLines.Text:=buffer;
    end;
end;

procedure TCodeUtilityCommon.CircuCrossInsertAfterEachLine(const outerLines: TStrings);
const
    newLine:string=#13#10;
var
    iLine,iOuter:Integer;
    buffer:string;
begin
    if (FLines.Count>0) and (outerLines.Count>0) then begin
        buffer:='';
        iOuter:=0;

        for iLine := 0 to FLines.Count - 1 do begin
            buffer:=buffer + FLines[iLine] + newLine + outerLines[iOuter] + newLine;
            iOuter:=(iOuter+1) mod outerLines.Count;
        end;

        FLines.Text:=buffer;
    end;
end;


procedure TCodeUtilityCommon.RepeatHorz(const separator: string; const count: Integer);
var
    buffer:TStrings;
    currentLineString,combinedLineString:string;
    i:Integer;
begin
    buffer:=TStringList.Create;

    for currentLineString in FLines do begin
        combinedLineString:=currentLineString;
        for i := 1 to count do begin
            combinedLineString:=combinedLineString + separator + currentLineString;
        end;
        buffer.Append(combinedLineString);
    end;

    FLines.Text:=buffer.Text;
    buffer.Free;
end;

procedure TCodeUtilityCommon.RepeatEachLine(const count: Integer);
const
    newLine:string=#13#10;
var
	buffer,currentLineString:string;
    i:integer;
begin
	for currentLineString in Flines do begin
		for i := 1 to count do begin
	        buffer:=buffer + currentLineString + newLine;
        end;
    end;

    FLines.Text:=buffer;
end;

procedure TCodeUtilityCommon.RepeatAllLines(const count: Integer);
const
    newLine:string=#13#10;
var
	buffer,bufferOriginal:string;
    i:integer;
begin
	bufferOriginal:=FLines.Text;
	for i := 1 to count do begin
        buffer:=buffer + bufferOriginal;
        if i<count then begin
	        buffer:=buffer + newLine;
        end;
    end;

    FLines.Text:=buffer;
end;


procedure TCodeUtilityCommon.DeleteColumn(const delimit: string; const colno: Integer);
var
    currentLine:TStrings;
    currentLineString:string;
    buffer:TStrings;
    i:Integer;
begin
    if delimit<>'' then begin
        currentLine:=TStringList.Create;
        currentLine.LineBreak:=delimit;

        buffer:=TStringList.Create;

        for i:=0 to FLines.Count -1 do begin
            currentLineString:=FLines.Strings[i]+delimit;
            currentLine.Text:=currentLineString;
            if (colno>=0) and (colno<=currentLine.Count) then currentLine.Delete(colno-1);
            currentLineString:=currentLine.Text;
            currentLineString:=LeftStr(currentLineString,Length(currentLineString)-Length(delimit));
            buffer.Append(currentLineString);
        end;

        FLines.Text:=buffer.Text;
    end;
end;

procedure TCodeUtilityCommon.ExtractColumn(const delimit: string; const colno: Integer);
var
    currentLine:TStrings;
    buffer:TStrings;
    fieldvalue:string;
    i:Integer;
begin
    if delimit<>'' then begin
        currentLine:=TStringList.Create;
        currentLine.LineBreak:=delimit;

        buffer:=TStringList.Create;

        for i:=0 to FLines.Count -1 do begin
            currentLine.Text:=FLines.Strings[i];
            if (colno>=0) and (colno<=currentLine.Count) then begin
                fieldvalue:=currentLine.Strings[colno-1];
            end else begin
                fieldvalue:='';
            end;
            buffer.Append(fieldvalue);
        end;

        FLines.Text:=buffer.Text;
    end;
end;

procedure TCodeUtilityCommon.LineFirstLower;
var
    buffer:TStrings;
    i:integer;
begin
    buffer:=TStringList.Create;
    buffer.Text:=FLines.Text;

    for i:= 0 to buffer.Count-1 do begin
        if Length(buffer[i])>0 then begin
            buffer[i]:=LowerCase(buffer[i][1]) + RightStr(buffer[i],Length(buffer[i])-1);
        end;
    end;

    FLines.Text:=buffer.Text;
    buffer.Free;
end;

procedure TCodeUtilityCommon.LineFirstUpper;
var
    buffer:TStrings;
    i:integer;
begin
    buffer:=TStringList.Create;
    buffer.Text:=FLines.Text;

    for i:= 0 to buffer.Count-1 do begin
        if Length(buffer[i])>0 then begin
            buffer[i]:=UpperCase(buffer[i][1]) + RightStr(buffer[i],Length(buffer[i])-1);
        end;
    end;

    FLines.Text:=buffer.Text;
    buffer.Free;
end;

procedure TCodeUtilityCommon.AfterFirstLower(const find:string);
var
    buffer:TStrings;
    i:integer;
begin
    buffer:=TStringList.Create;
    buffer.LineBreak:=find;
    buffer.Text:=FLines.Text;

    for i:= 1 to buffer.Count-1 do begin
        if Length(buffer[i])>0 then begin
            buffer[i]:=LowerCase(buffer[i][1]) + RightStr(buffer[i],Length(buffer[i])-1);
        end;
    end;

    FLines.Text:=LeftStr(buffer.Text,Length(FLines.Text));
    buffer.Free;
end;

procedure TCodeUtilityCommon.AfterFirstUpper(const find:string);
var
    buffer:TStrings;
    i:integer;
begin
    buffer:=TStringList.Create;
    buffer.LineBreak:=find;
    buffer.Text:=FLines.Text;

    for i:= 1 to buffer.Count-1 do begin
        if Length(buffer[i])>0 then begin
            buffer[i]:=UpperCase(buffer[i][1]) + RightStr(buffer[i],Length(buffer[i])-1);
        end;
    end;

    FLines.Text:=LeftStr(buffer.Text,Length(FLines.Text));
    buffer.Free;
end;

procedure TCodeUtilityCommon.DeleteDuplicatedLine(const ignoreCase, ignoreWhitePadding: Boolean);
var
    buffer:TStrings;
    i,j:integer;
    str1,str2:string;
    foundDuplicated:Boolean;
begin
    buffer:=TStringList.Create;    //buffer中存放比较之后没有重复的行

    for i := 0 to FLines.Count-1 do begin
        //获取待比较的那行
        str1:=FLines[i];
        if ignoreCase then str1:=LowerCase(str1);
        if ignoreWhitePadding then str1:=SysUtils.Trim(str1);

        //开始和buffer中的行比较，查找是否有重复行
        foundDuplicated:=false;
        for j := 0 to buffer.Count - 1 do begin
            str2:=buffer[j];    //获取待比较的那行
            if ignoreCase then str2:=LowerCase(str2);
            if ignoreWhitePadding then str2:=SysUtils.Trim(str2);

            if str1=str2 then begin     //找到重复行，结束
                foundDuplicated:=True;
                Break;
            end;
        end;

        //如果没有找到重复行，添加到buffer
        if foundDuplicated=false then buffer.Add(FLines[i]);
    end;

    FLines.Assign(buffer);
    buffer.Free;
end;

end.

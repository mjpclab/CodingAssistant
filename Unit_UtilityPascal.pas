unit Unit_UtilityPascal;

interface
uses SysUtils,Classes,StrUtils;

type TCodeUtilityPascal=class
  private
    FLines:TStrings;
    const SignStrBegin='''';
    const SignStrContinue=''' +';
  public
    constructor Create(theLines:TStrings);
    property Lines:TStrings read FLines write FLines;

    procedure CombineToStringExpression;
    procedure CancelCombineStringExpression;

    function GeneratePropertyDeclaration(const typeName,privateMember,publicMember:string):string;
    procedure CompletePropertyFromPublicDeclaration(const privateMemberPrefix:string);
    procedure CompletePropertyFromPrivateDeclaration(const privateMemberPrefix:string);
 end;

implementation

constructor TCodeUtilityPascal.Create(theLines:TStrings);
begin
    //Bind a TStrings to the class.
    FLines:=theLines;
end;

procedure TCodeUtilityPascal.CombineToStringExpression;
var
    i:integer;
    strBuffer:string;
    changed:boolean;
    buffer:TStrings;
begin
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

procedure TCodeUtilityPascal.CancelCombineStringExpression;
var
    i:integer;
    strTrimmed:string;
    strBuffer:string;
    changed:boolean;
    buffer:TStrings;
begin
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

function TCodeUtilityPascal.GeneratePropertyDeclaration(const typeName, privateMember, publicMember: string):string;
begin
    Exit('property ' + publicMember + ':' + typeName + ' read ' +privateMember+ ' write ' + privateMember + ';');
end;

procedure TCodeUtilityPascal.CompletePropertyFromPublicDeclaration(const privateMemberPrefix:string);
const
    strNewLine:string=#13#10;
    spaceChar:char=' ';
    tabChar:char=#9;
var
    i:integer;
    currentLine:string;
    currentChar:string;
    currentLineLength:integer;
    firstCharPos:integer;
    fixedLeft:string;
    bufferIn:TStrings;
    bufferOut:string;
    publicDeclare:string;
    varName:string;
    colonPos:integer;
begin
    bufferIn:=TStringList.Create;
    bufferIn.Assign(FLines);

    bufferOut:='';

    for i:=0 to bufferIn.Count-1 do begin
        currentLine:=bufferIn.Strings[i];
        currentLineLength:=Length(currentLine);
        firstCharPos:=1;
        for firstCharPos := 1 to currentLineLength do begin
            currentChar:=CurrentLine[firstCharPos];
            if (currentChar<>spaceChar) and (currentChar<>tabChar) then break;
        end;
        fixedLeft:=LeftStr(CurrentLine,firstCharPos-1);
        bufferOut:=bufferOut + fixedLeft;

        publicDeclare:=Trim(currentLine);
        if RightStr(publicDeclare,1)=';' then publicDeclare:=LeftStr(publicDeclare,Length(publicDeclare)-1);
        if publicDeclare<>'' then begin
            colonPos:=Pos(':',publicDeclare);
            if colonPos>0 then begin
                varName:=LeftStr(publicDeclare,colonPos-1);
            end else begin
                varName:=publicDeclare;
            end;

            bufferOut:=bufferOut +
                'property ' + publicDeclare + ' read '+privateMemberPrefix+varName+ ' write '+ privateMemberPrefix+varName + ';';
        end;

        bufferOut:=bufferOut + strNewLine;
    end;

    FLines.Text:=bufferOut;
    bufferIn.Free;
end;

procedure TCodeUtilityPascal.CompletePropertyFromPrivateDeclaration(const privateMemberPrefix: string);
const
    strNewLine:string=#13#10;
    spaceChar:char=' ';
    tabChar:char=#9;
var
    i:integer;
    currentLine:string;
    currentChar:string;
    currentLineLength:integer;
    firstCharPos:integer;
    fixedLeft:string;
    bufferIn:TStrings;
    bufferOut:string;
    publicDeclare:string;
    privateDeclare:string;
    varName:string;
    colonPos:integer;
begin
    bufferIn:=TStringList.Create;
    bufferIn.Assign(FLines);

    bufferOut:='';

    for i:=0 to bufferIn.Count-1 do begin
        currentLine:=bufferIn.Strings[i];
        currentLineLength:=Length(currentLine);
        firstCharPos:=1;
        for firstCharPos := 1 to currentLineLength do begin
            currentChar:=CurrentLine[firstCharPos];
            if (currentChar<>spaceChar) and (currentChar<>tabChar) then break;
        end;
        fixedLeft:=LeftStr(CurrentLine,firstCharPos-1);
        bufferOut:=bufferOut + fixedLeft;

        privateDeclare:=Trim(currentLine);
        if RightStr(privateDeclare,1)=';' then privateDeclare:=LeftStr(privateDeclare,Length(privateDeclare)-1);
        if privateDeclare<>'' then begin
            if LeftStr(privateDeclare,Length(privateMemberPrefix))=privateMemberPrefix then begin
                publicDeclare:=RightStr(privateDeclare,Length(privateDeclare)-length(privateMemberPrefix));
            end else begin
                publicDeclare:=privateDeclare;
            end;

            colonPos:=Pos(':',privateDeclare);
            if colonPos>0 then begin
                varName:=LeftStr(privateDeclare,colonPos-1);
            end else begin
                varName:=privateDeclare;
            end;

            bufferOut:=bufferOut +
                'property ' + publicDeclare + ' read '+varName+ ' write '+ varName + ';';
        end;

        bufferOut:=bufferOut + strNewLine;
    end;

    FLines.Text:=bufferOut;
    bufferIn.Free;
end;


end.

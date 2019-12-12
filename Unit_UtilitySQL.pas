unit Unit_UtilitySQL;

interface
uses SysUtils,Classes,StrUtils;

type TCodeUtilitySQL=class
  private
    FLines:TStrings;
    function IsEdgeChar(const Value:char):boolean;
  public
    constructor Create(theLines:TStrings);
    property Lines:TStrings read FLines write FLines;

    procedure ConvertKeyWordsToUpperCase;
    procedure AdjustWrapBySyntax;
    procedure CombineToEnumeration;
    procedure CombineToQuotedEnumeration;
    procedure CancelCombineEnumeration;
    procedure CancelCombineQuotedEnumeration;
end;

implementation

constructor TCodeUtilitySQL.Create(theLines:TStrings);
begin
    //Bind a TStrings to the class.
    FLines:=theLines;
end;

function TCodeUtilitySQL.IsEdgeChar(const Value: char): boolean;
//判断输入的字符是否可以被认为单词边界的分隔符
const
    EdgeChars:string=#9#32#61#42#43#44#45#46#47#59#40#41#13#10;     //<Tab> =*+,-./;()<Cr><Lf>
begin
    Result:=(Pos(Value,EdgeChars)<>0);
end;

procedure TCodeUtilitySQL.AdjustWrapBySyntax;
const
    WrapStr:string=#13#10;
    KeyWords:array[0..23] of string=(
        'SELECT','INSERT','VALUES','FROM','WHERE','GROUP','HAVING','ORDER'
        ,'LEFT JOIN','RIGHT JOIN','LEFT OUTER JOIN','RIGHT OUTER JOIN'
        ,'INNER JOIN','FULL JOIN','CROSS JOIN'
        ,'BEGIN','END','CREATE','UPDATE','SET','DELETE'
        ,'COMMIT','ROLLBACK'
        ,'GO'
    );
var
    i:integer;
    //j:integer;
    strBuffer:string;
    strOriginalBuffer:string;
    WordPos:integer;
    EdgeLeft,EdgeRight:boolean;
begin
    strOriginalBuffer:=Trim(FLines.Text);
    strBuffer:=UpperCase(strOriginalBuffer);
    for i := Low(KeyWords) to High(KeyWords) do begin
        WordPos:=0;
        while True do begin
            EdgeLeft:=false;
            EdgeRight:=false;

            WordPos:=PosEx(KeyWords[i],strBuffer,WordPos+1);
            if WordPos=0 then break;
            EdgeLeft:=(WordPos=1) or (IsEdgeChar(strBuffer[WordPos-1]));
            EdgeRight:=(WordPos+Length(KeyWords[i])-1=Length(strBuffer)) or (IsEdgeChar(strBuffer[WordPos+Length(KeyWords[i])]));

            if (EdgeLeft)
            and (EdgeRight)
            and (WordPos>1)
            and ((WordPos<Length(WrapStr)) or (Copy(strBuffer,WordPos-Length(WrapStr),Length(WrapStr))<>WrapStr))
            then begin    //match Keywords
                Insert(WrapStr,strBuffer,WordPos);
                Insert(WrapStr,strOriginalBuffer,WordPos);
                WordPos:=WordPos+Length(WrapStr);
            end;
        end;
    end;

    FLines.Text:=strOriginalBuffer;
end;


procedure TCodeUtilitySQL.ConvertKeyWordsToUpperCase;
const
    KeyWords:array[0..47] of string=(
        'UNION','SELECT','INSERT','INTO','VALUES','DISTINCT','TOP','PERCENT','FROM',
        'WHERE','LIKE','IN','EXISTS','GROUP','BY','HAVING','ORDER',
        'ASC','DESC','LEFT','OUTER','FULL','CROSS','JOIN','RIGHT','INNER','ON','MIN','MAX',
        'SUM','AVERAGE','COUNT','BEGIN','END','CREATE','ALTER','DROP','UPDATE','SET',
        'DELETE','AS','GO','AND','OR','IS','NOT','NULL','VIEW'
    );
var
    i:integer;
    j:integer;
    strBuffer:string;
    strOriginalBuffer:string;
    WordPos:integer;
    EdgeLeft,EdgeRight:boolean;
begin
    strOriginalBuffer:=FLines.Text;
    strBuffer:=UpperCase(strOriginalBuffer);
    for i := Low(KeyWords) to High(KeyWords) do begin
        WordPos:=0;
        while True do begin
            EdgeLeft:=false;
            EdgeRight:=false;

            WordPos:=PosEx(KeyWords[i],strBuffer,WordPos+1);
            if WordPos=0 then break;
            EdgeLeft:=(WordPos=1) or (IsEdgeChar(strBuffer[WordPos-1]));
            EdgeRight:=(WordPos+Length(KeyWords[i])-1=Length(strBuffer)) or (IsEdgeChar(strBuffer[WordPos+Length(KeyWords[i])]));

            if EdgeLeft and EdgeRight then begin    //match Keywords
                for j := WordPos to WordPos+Length(KeyWords[i]) - 1 do begin
                    strOriginalBuffer[j]:=UpperCase(strOriginalBuffer[j])[1];
                end;
            end;
        end;
    end;

    FLines.Text:=strOriginalBuffer;
end;

procedure TCodeUtilitySQL.CombineToEnumeration;
const
    chrComma:char=',';
    strReturn:string=#13#10;
begin
    with FLines do begin
        Text:=Trim(Text);
        Text:=StringReplace(Text,strReturn,chrComma,[rfReplaceAll]);
    end;
end;

procedure TCodeUtilitySQL.CombineToQuotedEnumeration;
const
    chrComma:char=',';
    chrQuote:char='''';
    strReturn:string=#13#10;
begin
    with FLines do begin
        Text:=Trim(Text);
        if Text<>'' then begin
            Text:=StringReplace(Text,chrQuote,chrQuote+chrQuote,[rfReplaceAll]);
            Text:='''' + StringReplace(Text,strReturn,chrQuote+chrComma+chrQuote,[rfReplaceAll]) + '''';
        end;
    end;
end;

procedure TCodeUtilitySQL.CancelCombineEnumeration;
const
    strSeparator:string=',';
    strReturn:string=#13#10;
begin
    with FLines do begin
         Text:=StringReplace(Text,strSeparator,strReturn,[rfReplaceAll]);
    end;
end;

procedure TCodeUtilitySQL.CancelCombineQuotedEnumeration;
const
    chrQuote='''';
    strSeparator:string=''',''';
    strReturn:string=#13#10;
begin
    with FLines do begin
        if Length(Text)>=Length(chrQuote) then begin
            if Text[1]=chrQuote then Text:=RightStr(Text,Length(Text)-1);
            if Text[Length(Text)]=chrQuote then Text:=LeftStr(Text,Length(Text)-1);
        end;
        Text:=StringReplace(Text,strSeparator,strReturn,[rfReplaceAll]);
    end;
end;

end.

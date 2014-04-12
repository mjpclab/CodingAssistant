unit Unit_UtilityHtml;

interface
uses Classes;

type TCodeUtilityHTML=class
  private
    FLines:TStrings;
    procedure WrapTag(const tagName,quoteBegin,quoteEnd:string);
    procedure UnWrapTag(const tagName,quoteBegin,quoteEnd:string);
  public
    constructor Create(theLines:TStrings);
    property Lines:TStrings read FLines write FLines;

    procedure WrapHtml(const tagName:string);
    procedure UnWrapHtml(const tagName:string);
    procedure WrapBBCode(const tagName:string);
    procedure UnWrapBBCode(const tagName:string);

    procedure EscapeHtml;
    procedure UnEscapeHtml;
end;

implementation
uses SysUtils,StrUtils,Dialogs;

{ TCodeUtilityVB }

constructor TCodeUtilityHTML.Create(theLines: TStrings);
begin
    FLines:=theLines;
end;

procedure TCodeUtilityHTML.WrapTag(const tagName, quoteBegin, quoteEnd: string);
var
    tagExpression:string;
    tagPure:string;
    signPos:Integer;
    tagBegin,tagEnd:string;
    lineBreaker:string;
begin
    tagExpression:=Trim(tagName);

    tagPure:=tagExpression;
    signPos:=Pos('=',tagPure);
    if signPos>0 then tagPure:=LeftStr(tagPure,signPos-1);
    signPos:=Pos(' ',tagPure);
    if signPos>0 then tagPure:=LeftStr(tagPure,signPos-1);


    tagBegin:=quoteBegin + tagExpression + quoteEnd;
    tagEnd:=quoteBegin + '/' + tagPure + quoteEnd;

    lineBreaker:=FLines.LineBreak;
    FLines.Text:=tagBegin +
        StringReplace(FLines.Text,lineBreaker,tagEnd + lineBreaker + tagBegin,[rfReplaceAll]) +
        tagEnd;
end;

procedure TCodeUtilityHTML.UnWrapTag(const tagName, quoteBegin,  quoteEnd: string);
var
    tagExpression:string;
    tagPure:string;
    signPos:Integer;
    tagBegin,tagEnd:string;

    i:Integer;
    buffer:TStrings;
    strLine,strLineLCase:string;
    tagBeginAfter:char;
	tagBeginQuoteEnd:integer;
begin
    tagExpression:=Trim(tagName);

    tagPure:=tagExpression;
    signPos:=Pos('=',tagPure);
    if signPos>0 then tagPure:=LeftStr(tagPure,signPos-1);
    signPos:=Pos(' ',tagPure);
    if signPos>0 then tagPure:=LeftStr(tagPure,signPos-1);


    tagBegin:=LowerCase(quoteBegin + tagExpression{ + quoteEnd});
    tagEnd:=LowerCase(quoteBegin + '/' + tagPure + quoteEnd);

    buffer:=TStringList.Create;
    buffer.Assign(FLines);
    //remove beginning/endding tag (include attributes)
    for i := 0 to buffer.Count-1 do begin
        strLine:=Trim(buffer.Strings[i]);
        strLineLCase:=LowerCase(strLine);

		if Pos(tagBegin,strLineLCase)=1 then begin    // tag beginning part match
        	tagBeginAfter:=strLineLCase[Length(tagBegin)+1];
            if not ((tagBeginAfter in ['a'..'z']) or (tagBeginAfter in ['A'..'Z'])) then begin	// if after tag begin there is a space or other sign, tag name matched
                tagBeginQuoteEnd:=Pos(quoteEnd,strLineLCase);
                if tagBeginQuoteEnd>0 then begin
                    Delete(strLine,1,tagBeginQuoteEnd);
                    //strLineLCase:=LowerCase(strLine);
                end;
            end;
        end;

        if RightStr(strLineLCase,Length(tagEnd))=tagEnd then begin // remoe endding tag
            Delete(strLine,Length(strLine)-Length(tagEnd)+1,Length(tagEnd));
	    end;

        buffer.Strings[i]:=strLine;
    end;

    FLines.Assign(buffer);
    buffer.Free;
end;

procedure TCodeUtilityHTML.WrapHtml(const tagName: string);
begin
    WrapTag(tagName , '<' , '>');
end;

procedure TCodeUtilityHTML.UnWrapHtml(const tagName: string);
begin
    UnWrapTag(tagName,'<','>');
end;

procedure TCodeUtilityHTML.WrapBBCode(const tagName: string);
begin
    WrapTag(tagName , '[' , ']');
end;

procedure TCodeUtilityHTML.UnWrapBBCode(const tagName: string);
begin
    UnWrapTag(tagName,'[',']');
end;

procedure TCodeUtilityHTML.EscapeHtml;
var
    buffer:string;
begin
    buffer:=FLines.Text;

    buffer:=StringReplace(buffer,'&','&amp;',[rfReplaceAll]);
    buffer:=StringReplace(buffer,'<','&lt;',[rfReplaceAll]);
    buffer:=StringReplace(buffer,'>','&gt;',[rfReplaceAll]);
    buffer:=StringReplace(buffer,'"','&quot;',[rfReplaceAll]);
    buffer:=StringReplace(buffer,'''','&apos;',[rfReplaceAll]);

    FLines.Text:=buffer;
end;

procedure TCodeUtilityHTML.UnEscapeHtml;
var
    buffer:string;
begin
    buffer:=FLines.Text;

    buffer:=StringReplace(buffer,'&lt;','<',[rfReplaceAll]);
    buffer:=StringReplace(buffer,'&gt;','>',[rfReplaceAll]);
    buffer:=StringReplace(buffer,'&quot;','"',[rfReplaceAll]);
    buffer:=StringReplace(buffer,'&apos;','''',[rfReplaceAll]);
    buffer:=StringReplace(buffer,'&amp;','&',[rfReplaceAll]);

    FLines.Text:=buffer;
end;

end.

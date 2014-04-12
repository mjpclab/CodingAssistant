unit Unit_UtilityCSharp;

interface
uses SysUtils,Classes,StrUtils;

type TCodeUtilityCSharp=class
  private
    FLines:TStrings;
    const SignStrBegin='"';
    const SignStrContinue='" +';
  public
    constructor Create(theLines:TStrings);
    property Lines:TStrings read FLines write FLines;

    procedure CombineToStringExpression;
    procedure CancelCombineStringExpression;

    procedure GeneratePropertyChanged;
    procedure PrivateSetToOnPropertyChanged;
    procedure PrivateSetToPropertyChanged;
  end;

implementation

constructor TCodeUtilityCSharp.Create(theLines:TStrings);
begin
    //Bind a TStrings to the class.
    FLines:=theLines;
end;

procedure TCodeUtilityCSharp.CombineToStringExpression;
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

procedure TCodeUtilityCSharp.CancelCombineStringExpression;
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

procedure TCodeUtilityCSharp.GeneratePropertyChanged;
const
    strNewLine:string=#13#10;
begin
    FLines.Text:=
        '#region INotifyPropertyChanged 成员' + strNewLine +
        'public event PropertyChangedEventHandler PropertyChanged;' + strNewLine +
        '' + strNewLine +
        'protected virtual void OnPropertyChanged(string propertyName)' + strNewLine +
        '{' + strNewLine +
        '	if (PropertyChanged != null)' + strNewLine +
        '	{' + strNewLine +
        '		PropertyChangedEventArgs e = new PropertyChangedEventArgs(propertyName);' + strNewLine +
        '		PropertyChanged(this, e);' + strNewLine +
        '	}' + strNewLine +
        '}' + strNewLine +
        '#endregion' + strNewLine +
        '';
end;

procedure TCodeUtilityCSharp.PrivateSetToOnPropertyChanged;
const
    signBlockBegin:string='{';
    signBlockEnd:string='}';
    signStatementEnd:string=';';
    letOperator:string='=';
    privateVarPrefix='_';
var
    buffer:TStrings;
    bufferLine:string;
    privateVar,publicProperty:string;
    letPos:integer;
begin
    buffer:=TStringList.Create;
    buffer.Text:=Trim(FLines.Text);
    if buffer.Count>0 then begin
        //清理，以获得_var=value的形式
        bufferLine:=Trim(buffer[0]);
        if LeftStr(bufferLine,1)=signBlockBegin then begin
            bufferLine:=RightStr(bufferLine,Length(bufferLine)-Length(signBlockBegin));
            bufferLine:=TrimLeft(bufferLine);
        end;
        if RightStr(bufferLine,1)=signBlockEnd then begin
            bufferLine:=LeftStr(bufferLine,Length(bufferLine)-Length(signBlockEnd));
            bufferLine:=TrimRight(bufferLine);
        end;
        if RightStr(bufferLine,1)=signStatementEnd then begin
            bufferLine:=LeftStr(bufferLine,Length(buffer.Text)-Length(signStatementEnd));
            bufferLine:=TrimRight(bufferLine);
        end;

        //获取privateVar,publicPropery
        letPos:=Pos(letOperator,bufferLine);
        if letPos>0 then begin
            privateVar:=Trim(LeftStr(bufferLine,letPos-1));
            publicProperty:=privateVar;
            if LeftStr(publicProperty,1)=privateVarPrefix then begin
                publicProperty:=RightStr(publicProperty,Length(publicProperty)-Length(privateVarPrefix));
            end;
            publicProperty:=UpperCase(LeftStr(publicProperty,1))+RightStr(publicProperty,Length(publicProperty)-1);

            //输出格式
            FLines.Clear;
            FLines.Add('if (' +privateVar+ ' != value)');
            FLines.Add('{');
            FLines.Add('	' +privateVar + ' = value;');
            FLines.Add('	OnPropertyChanged("' +publicProperty+ '");');
            FLines.Add('}');
        end;
    end;

    buffer.Free;
end;

procedure TCodeUtilityCSharp.PrivateSetToPropertyChanged;
const
    signBlockBegin:string='{';
    signBlockEnd:string='}';
    signStatementEnd:string=';';
    letOperator:string='=';
    privateVarPrefix='_';
var
    buffer:TStrings;
    bufferLine:string;
    privateVar,publicProperty:string;
    letPos:integer;
begin
    buffer:=TStringList.Create;
    buffer.Text:=Trim(FLines.Text);
    if buffer.Count>0 then begin
        //清理，以获得_var=value的形式
        bufferLine:=Trim(buffer[0]);
        if LeftStr(bufferLine,1)=signBlockBegin then begin
            bufferLine:=RightStr(bufferLine,Length(bufferLine)-Length(signBlockBegin));
            bufferLine:=TrimLeft(bufferLine);
        end;
        if RightStr(bufferLine,1)=signBlockEnd then begin
            bufferLine:=LeftStr(bufferLine,Length(bufferLine)-Length(signBlockEnd));
            bufferLine:=TrimRight(bufferLine);
        end;
        if RightStr(bufferLine,1)=signStatementEnd then begin
            bufferLine:=LeftStr(bufferLine,Length(buffer.Text)-Length(signStatementEnd));
            bufferLine:=TrimRight(bufferLine);
        end;

        //获取privateVar,publicPropery
        letPos:=Pos(letOperator,bufferLine);
        if letPos>0 then begin
            privateVar:=Trim(LeftStr(bufferLine,letPos-1));
            publicProperty:=privateVar;
            if LeftStr(publicProperty,1)=privateVarPrefix then begin
                publicProperty:=RightStr(publicProperty,Length(publicProperty)-Length(privateVarPrefix));
            end;
            publicProperty:=UpperCase(LeftStr(publicProperty,1))+RightStr(publicProperty,Length(publicProperty)-1);

            //输出格式
            FLines.Clear;
            FLines.Add('if (' +privateVar+ ' != value)');
            FLines.Add('{');
            FLines.Add('	' +privateVar + ' = value;');
            FLines.Add('	if (PropertyChanged != null) PropertyChanged(this, new PropertyChangedEventArgs("' +publicProperty+ '"));');
            FLines.Add('}');
        end;
    end;

    buffer.Free;
end;
end.

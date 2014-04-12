unit Unit_UtilityVB;

interface
uses SysUtils,Classes,StrUtils;

type TCodeUtilityVB=class
  private
    FLines:TStrings;
    const SignStrBegin='"';
    const SignStrContinue='" & _';
  public
    constructor Create(theLines:TStrings);
    property Lines:TStrings read FLines write FLines;

    procedure CombineToStringExpression;
    procedure CancelCombineStringExpression;

    procedure GenerateClassicPropertyDeclaration(const propertyName,typeName:string);

    procedure GeneratePropertyChanged;
    procedure PrivateSetToOnPropertyChanged;
    procedure PrivateSetToPropertyChanged;
  end;

implementation

constructor TCodeUtilityVB.Create(theLines:TStrings);
begin
    //Bind a TStrings to the class.
    FLines:=theLines;
end;

procedure TCodeUtilityVB.CombineToStringExpression;
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

procedure TCodeUtilityVB.CancelCombineStringExpression;
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

procedure TCodeUtilityVB.GenerateClassicPropertyDeclaration(const propertyName, typeName: string);
const
    newLine:string=#13#10;
begin
    FLines.Text:=
        'Public Property Get ' +propertyName+ '() As ' + typeName + newLine +
        'End Property' + newLine +
        '' + newLine +
        'Public Property Let ' +propertyName+ '(ByVal Value As ' +typeName+ ')' + newLine +
        'End Property' + newLine +
        '';
end;

procedure TCodeUtilityVB.GeneratePropertyChanged;
const
    strNewLine:string=#13#10;
begin
    FLines.Text:=
        '#Region "INotifyPropertyChanged 成员"' + strNewLine +
        '	Public Event PropertyChanged As PropertyChangedEventHandler Implements INotifyPropertyChanged.PropertyChanged' + strNewLine +
        '' + strNewLine +
        '	Protected Overridable Sub OnPropertyChanged(ByVal propertyName As String)' + strNewLine +
        '		RaiseEvent PropertyChanged(Me, New PropertyChangedEventArgs(propertyName))' + strNewLine +
        '	End Sub' + strNewLine +
        '#End Region' + strNewLine +
        '';
end;

procedure TCodeUtilityVB.PrivateSetToOnPropertyChanged;
const
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
            FLines.Add('If ' +privateVar+ ' <> value Then');
            FLines.Add('	' +privateVar + ' = value');
            FLines.Add('	OnPropertyChanged("' +publicProperty+ '")');
            FLines.Add('End If');
        end;
    end;

    buffer.Free;
end;

procedure TCodeUtilityVB.PrivateSetToPropertyChanged;
const
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
            FLines.Add('If ' +privateVar+ ' <> value Then');
            FLines.Add('	' +privateVar + ' = value');
            FLines.Add('	RaiseEvent PropertyChanged(Me, New PropertyChangedEventArgs("' +publicProperty+ '"))');
            FLines.Add('End If');
        end;
    end;

    buffer.Free;
end;

end.

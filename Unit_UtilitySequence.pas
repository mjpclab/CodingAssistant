unit Unit_UtilitySequence;

interface
uses SysUtils,Classes,StrUtils;

type TCodeUtilitySequence=class
  private const
	newLine:string=#13#10;
    doubleNewLine:string=#13#10#13#10;
  private
    FLines:TStrings;
  public
    constructor Create(theLines:TStrings);
    property Lines:TStrings read FLines write FLines;

    procedure SequenceToEndValue(const template,placeHolder,formatString:string; const startValue,stepLength,endValue:Integer);
    procedure SequenceByRepeatCount(const template,placeHolder,formatString:string;const startValue,stepLength,repeatCount:Integer);
  end;

implementation

{ TCodeUtilitySequence }

constructor TCodeUtilitySequence.Create(theLines: TStrings);
begin
    //Bind a TStrings to the class.
    FLines:=theLines;
end;

procedure TCodeUtilitySequence.SequenceToEndValue(const template,placeHolder,formatString:string; const startValue,stepLength,endValue:Integer);
	var i:Integer;
    var current,currentEntry:string;
    var buffer:TStrings;
begin
	if stepLength<>0 then begin
    	buffer:=TStringList.Create;

		i:=startValue;
        while ((stepLength>0) and (i<=endValue)) or ((stepLength<0) and (i>=endValue)) do begin
            //do something
			if Length(formatString)=0 then begin
				current:=IntToStr(i);
            end else begin
                current:=Format(formatString,[i]);
            end;
            currentEntry:=StringReplace(template,placeHolder,current,[rfReplaceAll]);
            buffer.Append(currentEntry);

            i:=i+stepLength;
        end;

        FLines.Add(buffer.Text);
        if FLines.Strings[FLines.Count-1]='' then FLines.Delete(FLines.Count-1);
        buffer.Free;
    end;
end;

procedure TCodeUtilitySequence.SequenceByRepeatCount(const template,placeHolder,formatString:string;const startValue,stepLength,repeatCount:Integer);
	var i,repeated:Integer;
    var current,currentEntry:string;
    var buffer:TStrings;
begin
    buffer:=TStringList.Create;

    i:=startValue;
    for repeated := 1 to repeatCount do begin
        //do something
        if Length(formatString)=0 then begin
            current:=IntToStr(i);
        end else begin
            current:=Format(formatString,[i]);
        end;
        currentEntry:=StringReplace(template,placeHolder,current,[rfReplaceAll]);
        buffer.Append(currentEntry);

        i:=i+stepLength;
    end;

    FLines.Add(buffer.Text);
    if FLines.Strings[FLines.Count-1]='' then FLines.Delete(FLines.Count-1);
    buffer.Free;
end;

end.

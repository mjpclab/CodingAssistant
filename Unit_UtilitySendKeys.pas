unit Unit_UtilitySendKeys;

interface
uses SysUtils,Classes,StrUtils;

type TCodeUtilitySendKeys=class
  private
    FLines:TStrings;

    FIsPureText:boolean;
    FSendByLines:boolean;
    FDelay:integer;
  public
    property IsPureText:boolean read FIsPureText write FIsPureText;
    property SendByLines:boolean read FSendByLines write FSendByLines;
    property Delay:integer read FDelay write FDelay;

    procedure SendKeys(const buffer:string);
    constructor Create(theLines:TStrings);
end;

implementation
uses Unit_SendKeys;

constructor TCodeUtilitySendKeys.Create(theLines:TStrings);
begin
    //Bind a TStrings to the class.
    FLines:=theLines;
end;

procedure TCodeUtilitySendKeys.SendKeys(const buffer:string);
var
    i:Integer;
    bufferLines:TStrings;
begin
    if SendByLines=false then begin
        Unit_SendKeys.SendKeys(buffer,False,IsPureText);
    end else begin
        bufferLines:=TStringList.Create;
        bufferLines.Text:=buffer;

        for i := 0 to bufferLines.Count - 1 do begin
            Sleep(Delay*MSecsPerSec);
            Unit_SendKeys.SendKeys(bufferLines[i],False,IsPureText);
        end;

        bufferLines.Free;
    end;
end;

end.

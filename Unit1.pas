unit Unit1;

interface

uses

  Windows, ShellAPI, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,  ComCtrls,
  Unit_Utility, ImgList, Buttons, ToolWin, XPStyleActnCtrls, ActnList, ActnMan,
  Menus, ActnPopup, Spin, PlatformDefaultStyleActnCtrls, System.Actions;


type
  TfrmMain = class(TForm)
    txtMemo: TMemo;
    pnlTop: TPanel;
    pageTabs: TPageControl;
    TabSheet1: TTabSheet;
    edtPrefix: TEdit;
    edtSplitLines: TEdit;
    btnSplitLines: TButton;
    btnPrefix: TButton;
    edtMergeLines: TEdit;
    edtPostfix: TEdit;
    btnPostfix: TButton;
    btnMergeLines: TButton;
    btnExchangeEqual: TButton;
    btnTrimLeft: TButton;
    btnTrim: TButton;
    btnLowerCase: TButton;
    btnUpperCase: TButton;
    btnTrimRight: TButton;
    btnCompressSpaces: TButton;
    TabSheet2: TTabSheet;
    btnVBCancelCombineString: TButton;
    btnVBCombineString: TButton;
    TabSheet3: TTabSheet;
    btnSqlUpperKeyWords: TButton;
    btnSqlWrapBySyntax: TButton;
    btnSqlUpperWrapBySyntax: TButton;
    btnSqlCombineToEnumeration: TButton;
    btnSqlCombineToQuotedEnumeration: TButton;
    btnSqlCancelCombineToEnumeration: TButton;
    btnSqlCancelCombineToQuotedEnumeration: TButton;
    btnConvertSpaceToTab: TButton;
    btnConvertTabToComma: TButton;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    barTools: TToolBar;
    btnNew: TToolButton;
    btnLoad: TToolButton;
    btnSave: TToolButton;
    btnSaveAs: TToolButton;
    imgTools: TImageList;
    pnlTitle: TPanel;
    actPopup: TActionManager;
    mnuPopup: TPopupActionBar;
    actCopy: TAction;
    actCut: TAction;
    actPaste: TAction;
    actSelectAll: TAction;
    actClear: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    drpSplitMethod: TComboBox;
    TabSheet4: TTabSheet;
    edtReplaceFrom: TEdit;
    edtReplaceTo: TEdit;
    btnReplace: TButton;
    timSendKeys: TTimer;
    TabSheet5: TTabSheet;
    btnCSCombineString: TButton;
    btnCSCancelCombineString: TButton;
    TabSheet6: TTabSheet;
    btnPascalCombineString: TButton;
    btnPascalCancelCombineString: TButton;
    btnPascalExchangePascalLet: TButton;
    btnRevertLines: TButton;
    TabSheet7: TTabSheet;
    btnPhpCombineSingleQuoteString: TButton;
    btnPhpCancelCombineSingleQuoteString: TButton;
    btnPhpCombineDoubleQuoteString: TButton;
    btnPhpCancelCombineDoubleQuoteString: TButton;
    edtPhpHereDocFlag: TEdit;
    btnPhpAddHereDoc: TButton;
    btnPhpRemoveHereDoc: TButton;
    ToolButton1: TToolButton;
    btnCut: TToolButton;
    btnCopy: TToolButton;
    btnPaste: TToolButton;
    lblReplaceExchange: TLabel;
    ToolButton2: TToolButton;
    btnStayOnTop: TToolButton;
    actStayOnTop: TAction;
    TabSheet8: TTabSheet;
    edtEachLine: TMemo;
    btnJoinBeforeEachLine: TButton;
    btnReplaceEachLine: TButton;
    edtReplaceEachLine: TEdit;
    btnDeleteEmptyLine: TButton;
    chkDeleteWhiteSpaceLine: TCheckBox;
    numDelNPrefix: TSpinEdit;
    btnDelNPrefix: TButton;
    numDelNSuffix: TSpinEdit;
    btnDelNSuffix: TButton;
    edtDeleteBeforeStringLookForward: TEdit;
    btnDeleteBeforeStringLookForward: TButton;
    btnDeleteAfterStringLookBackward: TButton;
    edtDeleteAfterStringLookBackward: TEdit;
    numInsertIndex: TSpinEdit;
    edtInsertString: TEdit;
    btnInsertString: TButton;
    numDeleteIndex1: TSpinEdit;
    btnDeleteString1: TButton;
    numDeleteLength1: TSpinEdit;
    numDeleteIndex2: TSpinEdit;
    numDeleteEndIndex2: TSpinEdit;
    btnDeleteString2: TButton;
    btnCrossInsertAfterEachLine: TButton;
    btnCrossInsertBeforeEachLine: TButton;
    edtInsertFindString: TEdit;
    btnInsertBeforeString: TButton;
    edtInsertTheString: TEdit;
    btnInsertAfterString: TButton;
    lblInsertFindString: TLabel;
    lblInsertTheString: TLabel;
    btnCompactEmptyLine: TButton;
    chkCompactWhiteSpaceLine: TCheckBox;
    btnCopyTab: TToolButton;
    actCopyTab: TAction;
    tabIe: TTabSheet;
    btnIeIfIe: TButton;
    btnIeIfCondition: TButton;
    btnIeRemoveIf: TButton;
    drpIeIfOperator: TComboBox;
    drpIeIfVersion: TComboBox;
    pnlCursorPosotion: TPanel;
    edtDelPrefix: TEdit;
    btnDelPrefix: TButton;
    edtDelSuffix: TEdit;
    btnDelSuffix: TButton;
    tabMasn: TTabSheet;
    btnMasmDefineToEqual: TButton;
    btnMasmEqualToDefine: TButton;
    btnConvertTabToSpace: TButton;
    btnConvertCommaToTab: TButton;
    btnCircuCrossInsertBeforeEachLine: TButton;
    btnCurcuCrossInsertAfterEachLine: TButton;
    btnRInsertString: TButton;
    numRDeleteIndex1: TSpinEdit;
    numRDeleteLength1: TSpinEdit;
    btnRDeleteString1: TButton;
    btnRDeleteString2: TButton;
    numRDeleteEndIndex2: TSpinEdit;
    numRDeleteIndex2: TSpinEdit;
    numRInsertIndex: TSpinEdit;
    edtRInsertString: TEdit;
    edtDeleteColumnDelimit: TEdit;
    numDeleteColumnIndex: TSpinEdit;
    btnDeleteColumn: TButton;
    edtExtractColumnDelimit: TEdit;
    numExtractColumnIndex: TSpinEdit;
    btnExtractColumn: TButton;
    lblPascalPropType: TLabel;
    lblPascalPropPrivate: TLabel;
    lblPascalPropPublic: TLabel;
    edtPascalPropType: TEdit;
    edtPascalPropPrivate: TEdit;
    edtPascalPropPublic: TEdit;
    edtPascalPropDeclaration: TEdit;
    btnPascalPropGenerate: TButton;
    btnPascalPropGenerateCopy: TButton;
    btnPascalCompletePropertyFromPublicDeclare: TButton;
    lblPascalCompletePropertyPrivatePrefix: TLabel;
    edtPascalCompleteDeclarePrivatePrefix: TEdit;
    btnPascalCompletePropertyFromPrivateDeclare: TButton;
    lbl1: TLabel;
    Label1: TLabel;
    edtVBGeneratePropName: TEdit;
    edtVBGeneratePropType: TEdit;
    btnVBGeneratePropDeclaration: TButton;
    tabHtml: TTabSheet;
    edtHtmlHtmlTag: TEdit;
    btnHtmlHtmlTag: TButton;
    edtHtmlBBCode: TEdit;
    btnHtmlBBCode: TButton;
    btnLineFirstUpper: TButton;
    btnLineFirstLower: TButton;
    edtAfterFirstUpper: TEdit;
    edtAfterFirstLower: TEdit;
    btnAfterFirstUpper: TButton;
    btnAfterFirstLower: TButton;
    btnJoinAfterEachLine: TButton;
    chkDeleteBeforeAndStringLookForward: TCheckBox;
    chkDeleteAfterAndStringLookBackward: TCheckBox;
    btnCSharpPrivateSetToPropertyChanged: TButton;
    btnCSharpPropertyChanged: TButton;
    btnVBPrivateSetToOnPropertyChanged: TButton;
    btnVBPrivateSetToPropertyChanged: TButton;
    btnCSharpGeneratePropertyChanged: TButton;
    btnVBGeneratePropertyChanged: TButton;
    numExtractIndex1: TSpinEdit;
    numExtractLength1: TSpinEdit;
    btnExtractString1: TButton;
    numExtractIndex2: TSpinEdit;
    numExtractEndIndex2: TSpinEdit;
    btnExtractString2: TButton;
    numRExtractIndex1: TSpinEdit;
    numRExtractIndex2: TSpinEdit;
    numRExtractEndIndex2: TSpinEdit;
    numRExtractLength1: TSpinEdit;
    btnRExtractString1: TButton;
    btnRExtractString2: TButton;
    btnDeleteDuplicatedLine: TButton;
    chkDeleteDuplicatedLineIgnoreCase: TCheckBox;
    chkDeleteDuplicatedLineIgnoreWhitePadding: TCheckBox;
    btnHtmlEscape: TButton;
    btnHtmlUnescape: TButton;
    btnHtmlUnHtml: TButton;
    btnHtmlUnBBCode: TButton;
    tabSendkeys: TTabSheet;
    numSendKeysWait: TSpinEdit;
    btnSendKeysWait: TButton;
    chkSendKeysPureTextOnly: TCheckBox;
    chkSendKeysByLine: TCheckBox;
    numSendKeysByLine: TSpinEdit;
    drpSendKeysSourceRange: TComboBox;
    lblSendInform: TLabel;
    edtRepeatHorz: TEdit;
    btnRepeatHorz: TButton;
    numRepeatHorz: TSpinEdit;
    edtDeleteBeforeStringLookBackward: TEdit;
    chkDeleteBeforeAndStringLookBackward: TCheckBox;
    btnDeleteBeforeStringLookBackward: TButton;
    edtDeleteAfterStringLookForward: TEdit;
    chkDeleteAfterAndStringLookForward: TCheckBox;
    btnDeleteAfterStringLookForward: TButton;
    lblMemoExchange: TLabel;
    btnRepeatEachLine: TButton;
    btnRepeatAllLines: TButton;
    numRepeatEachLine: TSpinEdit;
    numRepeatAllLines: TSpinEdit;
    TabSheet9: TTabSheet;
    numSeqStartValue: TSpinEdit;
    numSeqEndValue: TSpinEdit;
    numSeqStepLength: TSpinEdit;
    numSeqRepeatCount: TSpinEdit;
    edtSeqPlaceHolder: TEdit;
    edtSeqFormat: TEdit;
    btnSeqToEndValue: TButton;
    btnSeqRepeatCount: TButton;
    lblSeqPlaceHolder: TLabel;
    lblSeqFormat: TLabel;
    btnClear: TToolButton;
    lblSeqTemplate: TLabel;
    edtSeqTemplate: TMemo;
    lblSeqStartValue: TLabel;
    lblSeqStepLength: TLabel;
    lblSeqEndValue: TLabel;
    lblSeqStepCount: TLabel;
    procedure btnMergeLinesClick(Sender: TObject);
    procedure nPrefixClick(Sender: TObject);
    procedure btnPostfixClick(Sender: TObject);
    procedure btnExchangeEqualClick(Sender: TObject);
    procedure btnSplitLinesClick(Sender: TObject);
    procedure btnTrimLeftClick(Sender: TObject);
    procedure btnTrimClick(Sender: TObject);
    procedure btnTrimRightClick(Sender: TObject);
    procedure txtMemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnUpperCaseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLowerCaseClick(Sender: TObject);
    procedure btnVBCombineStringClick(Sender: TObject);
    procedure btnVBCancelCombineStringClick(Sender: TObject);
    procedure btnSqlUpperKeyWordsClick(Sender: TObject);
    procedure btnSqlWrapBySyntaxClick(Sender: TObject);
    procedure btnSqlUpperWrapBySyntaxClick(Sender: TObject);
    procedure btnCompressSpacesClick(Sender: TObject);
    procedure btnSqlCombineToEnumerationClick(Sender: TObject);
    procedure btnSqlCombineToQuotedEnumerationClick(Sender: TObject);
    procedure btnSqlCancelCombineToEnumerationClick(Sender: TObject);
    procedure btnSqlCancelCombineToQuotedEnumerationClick(Sender: TObject);
    procedure btnConvertSpaceToTabClick(Sender: TObject);
    procedure btnConvertTabToCommaClick(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actCutExecute(Sender: TObject);
    procedure actPasteExecute(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure btnDelNPrefixClick(Sender: TObject);
    procedure btnDelNSuffixClick(Sender: TObject);
    procedure btnDeleteEmptyLineClick(Sender: TObject);
    procedure btnSendKeysWaitClick(Sender: TObject);
    procedure timSendKeysTimer(Sender: TObject);
    procedure pnlTitleClick(Sender: TObject);
    procedure btnCSCombineStringClick(Sender: TObject);
    procedure btnCSCancelCombineStringClick(Sender: TObject);
    procedure btnPascalCancelCombineStringClick(Sender: TObject);
    procedure btnPascalCombineStringClick(Sender: TObject);
    procedure btnPascalExchangePascalLetClick(Sender: TObject);
    procedure btnRevertLinesClick(Sender: TObject);
    procedure btnPhpCombineSingleQuoteStringClick(Sender: TObject);
    procedure btnPhpCancelCombineSingleQuoteStringClick(Sender: TObject);
    procedure btnPhpCombineDoubleQuoteStringClick(Sender: TObject);
    procedure btnPhpCancelCombineDoubleQuoteStringClick(Sender: TObject);
    procedure btnPhpAddHereDocClick(Sender: TObject);
    procedure btnPhpRemoveHereDocClick(Sender: TObject);
    procedure lblReplaceExchangeClick(Sender: TObject);
    procedure actStayOnTopExecute(Sender: TObject);
    procedure btnJoinBeforeEachLineClick(Sender: TObject);
    procedure btnReplaceEachLineClick(Sender: TObject);
    procedure btnDeleteBeforeStringLookForwardClick(Sender: TObject);
    procedure btnDeleteAfterStringLookBackwardClick(Sender: TObject);
    procedure btnInsertStringClick(Sender: TObject);
    procedure btnDeleteString1Click(Sender: TObject);
    procedure btnDeleteString2Click(Sender: TObject);
    procedure btnCrossInsertBeforeEachLineClick(Sender: TObject);
    procedure btnCrossInsertAfterEachLineClick(Sender: TObject);
    procedure btnInsertBeforeStringClick(Sender: TObject);
    procedure btnInsertAfterStringClick(Sender: TObject);
    procedure btnCompactEmptyLineClick(Sender: TObject);
    procedure actCopyTabExecute(Sender: TObject);
    procedure btnIeIfIeClick(Sender: TObject);
    procedure btnIeRemoveIfClick(Sender: TObject);
    procedure btnIeIfConditionClick(Sender: TObject);
    procedure txtMemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtMemoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDelPrefixClick(Sender: TObject);
    procedure btnDelSuffixClick(Sender: TObject);
    procedure btnMasmDefineToEqualClick(Sender: TObject);
    procedure btnMasmEqualToDefineClick(Sender: TObject);
    procedure btnConvertTabToSpaceClick(Sender: TObject);
    procedure btnConvertCommaToTabClick(Sender: TObject);
    procedure btnCircuCrossInsertBeforeEachLineClick(Sender: TObject);
    procedure btnCurcuCrossInsertAfterEachLineClick(Sender: TObject);
    procedure btnRInsertStringClick(Sender: TObject);
    procedure btnRDeleteString1Click(Sender: TObject);
    procedure btnRDeleteString2Click(Sender: TObject);
    procedure btnDeleteColumnClick(Sender: TObject);
    procedure btnExtractColumnClick(Sender: TObject);
    procedure btnPascalPropGenerateClick(Sender: TObject);
    procedure btnPascalPropGenerateCopyClick(Sender: TObject);
    procedure btnPascalCompletePropertyFromPublicDeclareClick(Sender: TObject);
    procedure btnPascalCompletePropertyFromPrivateDeclareClick(Sender: TObject);
    procedure btnVBGeneratePropDeclarationClick(Sender: TObject);
    procedure btnHtmlHtmlTagClick(Sender: TObject);
    procedure btnHtmlBBCodeClick(Sender: TObject);
    procedure btnLineFirstUpperClick(Sender: TObject);
    procedure btnLineFirstLowerClick(Sender: TObject);
    procedure btnAfterFirstUpperClick(Sender: TObject);
    procedure btnAfterFirstLowerClick(Sender: TObject);
    procedure btnJoinAfterEachLineClick(Sender: TObject);
    procedure btnCSharpPrivateSetToPropertyChangedClick(Sender: TObject);
    procedure btnCSharpPropertyChangedClick(Sender: TObject);
    procedure btnVBPrivateSetToOnPropertyChangedClick(Sender: TObject);
    procedure btnVBPrivateSetToPropertyChangedClick(Sender: TObject);
    procedure btnCSharpGeneratePropertyChangedClick(Sender: TObject);
    procedure btnDeleteDuplicatedLineClick(Sender: TObject);
    procedure btnExtractString1Click(Sender: TObject);
    procedure btnExtractString2Click(Sender: TObject);
    procedure btnHtmlEscapeClick(Sender: TObject);
    procedure btnHtmlUnescapeClick(Sender: TObject);
    procedure btnRExtractString1Click(Sender: TObject);
    procedure btnRExtractString2Click(Sender: TObject);
    procedure btnVBGeneratePropertyChangedClick(Sender: TObject);
    procedure btnHtmlUnHtmlClick(Sender: TObject);
    procedure btnHtmlUnBBCodeClick(Sender: TObject);
    procedure btnRepeatHorzClick(Sender: TObject);
    procedure btnDeleteBeforeStringLookBackwardClick(Sender: TObject);
    procedure btnDeleteAfterStringLookForwardClick(Sender: TObject);
    procedure lblMemoExchangeClick(Sender: TObject);
    procedure btnRepeatEachLineClick(Sender: TObject);
    procedure btnRepeatAllLinesClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSeqToEndValueClick(Sender: TObject);
    procedure btnSeqRepeatCountClick(Sender: TObject);
  private
    Tool:TCodeUtility;
    procedure GetCursorPosition(const txt:TCustomEdit;out rowNum,colNum:integer);
    procedure RefreshMemoPosition;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
uses Clipbrd;

{$R *.dfm}

{$REGION 'UI'}
    procedure TfrmMain.btnSendKeysWaitClick(Sender: TObject);
    begin
        with timSendKeys do begin
            Tag:=numSendKeysWait.Value;
            Interval:=1;                    //使timer立即开始
            Enabled:=true;
        end;
    end;

    procedure TfrmMain.timSendKeysTimer(Sender: TObject);
    const
        strWaittingSend:string='%d 秒后发送字符串';
    var
        buffer:string;
        rowNum,colNum:Integer;
    begin
        with timSendKeys do begin
            if Interval=1 then Interval:=MSecsPerSec;      //切换到以秒为单位计时
            if Tag<>0 then begin
                lblSendInform.Caption:=Format(strWaittingSend,[Tag]);
                Tag:=Tag-1;
            end else begin
                Enabled:=false;
                lblSendInform.Caption:=EmptyStr;

                case drpSendKeysSourceRange.ItemIndex of
                0:  //全部
                    begin
                        buffer:=txtMemo.Text;
                    end;
                1:  //当前行
                    begin
                        GetCursorPosition(txtMemo,rowNum,colNum);
                        buffer:=txtMemo.Lines[rowNum-1];
                    end;
                2:  //选中的行
                    begin
                        buffer:=txtMemo.SelText;
                    end;
                3:  //选中的或全部
                    begin
                        if txtMemo.SelLength>0 then begin
                            buffer:=txtMemo.SelText;
                        end else begin
                            buffer:=txtMemo.Text;
                        end;
                    end
                end;

                with Tool.SendKeys do begin
                    IsPureText:=chkSendKeysPureTextOnly.Checked;
                    SendByLines:=chkSendKeysByLine.Checked;
                    Delay:=numSendKeysByLine.Value;
                    SendKeys(buffer);
                end;
            end;

        end;
    end;

    procedure TfrmMain.txtMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        if (ssCtrl in Shift) and (Key=Ord('A')) then txtMemo.SelectAll;
    end;

    procedure TfrmMain.txtMemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        RefreshMemoPosition;
    end;
    procedure TfrmMain.txtMemoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    begin
        RefreshMemoPosition;
    end;

    procedure TfrmMain.btnNewClick(Sender: TObject);
    begin
        txtMemo.Lines.Clear;
        dlgOpen.FileName:='';
    end;

    procedure TfrmMain.btnLoadClick(Sender: TObject);
    begin
        if dlgOpen.Execute then txtMemo.Lines.LoadFromFile(dlgOpen.FileName);
    end;

    procedure TfrmMain.btnSaveClick(Sender: TObject);
    begin
        if dlgOpen.FileName<>'' then begin
            txtMemo.Lines.SaveToFile(dlgOpen.FileName);
        end else begin
            btnSaveAsClick(Sender);
        end;
    end;

    procedure TfrmMain.btnSaveAsClick(Sender: TObject);
    begin
        if dlgSave.Execute(self.Handle) then begin
            txtMemo.Lines.SaveToFile(dlgSave.FileName);
            dlgOpen.FileName:=dlgSave.FileName;
        end;
    end;

    procedure TfrmMain.actCopyExecute(Sender: TObject);
    begin
        if txtMemo.SelLength=0 then begin
            ClipBoard.SetTextBuf(PWideChar(txtMemo.Text));
        end else begin
            txtMemo.CopyToClipboard;
        end;
    end;

    procedure TfrmMain.actClearExecute(Sender: TObject);
    begin
        txtMemo.Clear;
    end;

    procedure TfrmMain.actCutExecute(Sender: TObject);
    begin
        if txtMemo.SelLength=0 then begin
            ClipBoard.SetTextBuf(PWideChar(txtMemo.Text));
            txtMemo.Clear;
        end else begin
            txtMemo.CutToClipboard;
        end;
    end;

    procedure TfrmMain.actPasteExecute(Sender: TObject);
    begin
        txtMemo.PasteFromClipboard;
    end;

    procedure TfrmMain.btnClearClick(Sender: TObject);
    begin
		txtMemo.Clear;
    end;

    procedure TfrmMain.actSelectAllExecute(Sender: TObject);
    begin
        txtMemo.SelectAll;
    end;

    procedure TfrmMain.pnlTitleClick(Sender: TObject);
    begin
        shellexecute(self.Handle,'open','http://mjpclab.net/',nil,nil,sw_shownormal);
    end;

    procedure TfrmMain.lblReplaceExchangeClick(Sender: TObject);
    var
        buffer:string;
    begin
        buffer:=edtReplaceFrom.Text;
        edtReplaceFrom.Text:=edtReplaceTo.Text;
        edtReplaceTo.Text:=buffer;
    end;

    procedure TfrmMain.actCopyTabExecute(Sender: TObject);
    begin
        Clipboard.AsText:=#9;
    end;

    procedure TfrmMain.actStayOnTopExecute(Sender: TObject);
    begin
        if btnStayOnTop.Down then begin
            self.FormStyle:=fsStayOnTop;
        end else begin
            self.FormStyle:=fsNormal;
        end;

    end;

    procedure TfrmMain.GetCursorPosition(const txt: TCustomEdit; out rowNum,colNum: integer);
    begin
        rowNum := SendMessage(txt.Handle, EM_LINEFROMCHAR, txt.SelStart, 0) +1;
        colNum := txt.SelStart - SendMessage(txt.Handle, EM_LINEINDEX, -1, 0) +1;
    end;

    procedure TfrmMain.RefreshMemoPosition;
    var
        rowNum,colNum:Integer;
    begin
        GetCursorPosition(txtMemo,rowNum,colNum);
        pnlCursorPosotion.Caption:=Format('%d 行 , %d 列',[rownum,colnum]);
    end;

{$ENDREGION}

{$REGION 'Tool''s Life Cycle'}
    procedure TfrmMain.FormCreate(Sender: TObject);
    begin
        Tool:=TCodeUtility.Create(txtMemo.Lines);
        edtSeqTemplate.Text:=TrimRight(edtSeqTemplate.Text);     //remove the end new empty line
    end;
    
    procedure TfrmMain.FormDestroy(Sender: TObject);
    begin
        Tool.Free;
    end;
{$ENDREGION}

{$REGION 'Tools Common'}
    procedure TfrmMain.btnLowerCaseClick(Sender: TObject);
    begin
        Tool.Common.ConvertToLowerCase;
    end;
    
    procedure TfrmMain.btnMergeLinesClick(Sender: TObject);
    begin
        Tool.Common.MergeLines(edtMergeLines.Text);
    end;
    
    procedure TfrmMain.nPrefixClick(Sender: TObject);
    
    begin
        Tool.Common.AddPrefix(edtPrefix.Text);
    end;

    procedure TfrmMain.btnSplitLinesClick(Sender: TObject);
    begin
        Tool.Common.SplitLines(edtSplitLines.Text,drpSplitMethod.ItemIndex);
    end;

    procedure TfrmMain.btnTrimClick(Sender: TObject);
    begin
        Tool.Common.Trim;
    end;
    
    procedure TfrmMain.btnTrimLeftClick(Sender: TObject);
    begin
        Tool.Common.TrimLeft;
    end;
    
    procedure TfrmMain.btnTrimRightClick(Sender: TObject);
    begin
        Tool.Common.TrimRight;
    end;
    
    procedure TfrmMain.btnUpperCaseClick(Sender: TObject);
    begin
        Tool.Common.ConvertToUpperCase;
    end;

    procedure TfrmMain.btnPostfixClick(Sender: TObject);
    begin
        Tool.Common.AddPostfix(edtPostfix.Text);
    end;

    procedure TfrmMain.btnExchangeEqualClick(Sender: TObject);
    begin
        Tool.Common.ExchangeLetOperatorSide('=');
    end;

    procedure TfrmMain.btnCompressSpacesClick(Sender: TObject);
    begin
        Tool.Common.CompressSpaces;
    end;

   procedure TfrmMain.btnConvertSpaceToTabClick(Sender: TObject);
    begin
        Tool.Common.ConvertSpaceToTab;
    end;

    procedure TfrmMain.btnConvertTabToSpaceClick(Sender: TObject);
    begin
        Tool.Common.ConvertTabToSpace;
    end;

    procedure TfrmMain.btnConvertTabToCommaClick(Sender: TObject);
    begin
        Tool.Common.ConvertTabToComma;
    end;

    procedure TfrmMain.btnConvertCommaToTabClick(Sender: TObject);
    begin
        Tool.Common.ConvertCommaToTab;
    end;

    procedure TfrmMain.btnReplaceClick(Sender: TObject);
    begin
        Tool.Common.Replace(edtReplaceFrom.Text,edtReplaceTo.Text);
    end;

    procedure TfrmMain.btnRevertLinesClick(Sender: TObject);
    begin
        Tool.Common.RevertLines;
    end;

    procedure TfrmMain.btnDelNPrefixClick(Sender: TObject);
    begin
        Tool.Common.DeleteNPrefix(numDelNPrefix.Value);
    end;

    procedure TfrmMain.btnDelNSuffixClick(Sender: TObject);
    begin
        Tool.Common.DeleteNSuffix(numDelNSuffix.Value);
    end;

    procedure TfrmMain.btnDelPrefixClick(Sender: TObject);
    begin
        Tool.Common.DeletePrefix(edtDelPrefix.Text);
    end;

    procedure TfrmMain.btnDelSuffixClick(Sender: TObject);
    begin
        Tool.Common.DeleteSuffix(edtDelSuffix.Text);
    end;

    procedure TfrmMain.btnDeleteBeforeStringLookForwardClick(Sender: TObject);
    begin
        Tool.Common.DeleteBeforeStringLookForward(edtDeleteBeforeStringLookForward.Text,chkDeleteBeforeAndStringLookForward.Checked);
    end;

    procedure TfrmMain.btnDeleteBeforeStringLookBackwardClick(Sender: TObject);
    begin
		Tool.Common.DeleteBeforeStringLookBackward(edtDeleteBeforeStringLookBackward.Text,chkDeleteBeforeAndStringLookBackward.Checked);
    end;

    procedure TfrmMain.btnDeleteAfterStringLookForwardClick(Sender: TObject);
    begin
        Tool.Common.DeleteAfterStringLookForward(edtDeleteAfterStringLookForward.Text,chkDeleteAfterAndStringLookForward.Checked);
    end;

    procedure TfrmMain.btnDeleteAfterStringLookBackwardClick(Sender: TObject);
    begin
        Tool.Common.DeleteAfterStringLookBackward(edtDeleteAfterStringLookBackward.Text,chkDeleteAfterAndStringLookBackward.Checked);
    end;

    procedure TfrmMain.btnInsertBeforeStringClick(Sender: TObject);
    begin
        Tool.Common.InsertBeforeString(edtInsertFindString.Text,edtInsertTheString.Text);
    end;

    procedure TfrmMain.btnInsertAfterStringClick(Sender: TObject);
    begin
        Tool.Common.InsertAfterString(edtInsertFindString.Text,edtInsertTheString.Text);
    end;

    procedure TfrmMain.btnDeleteEmptyLineClick(Sender: TObject);
    begin
        Tool.Common.DeleteEmptyLine(chkDeleteWhiteSpaceLine.Checked);
    end;

    procedure TfrmMain.btnCompactEmptyLineClick(Sender: TObject);
    begin
        Tool.Common.CompactEmptyLine(chkCompactWhiteSpaceLine.Checked);
    end;

    procedure TfrmMain.btnJoinBeforeEachLineClick(Sender: TObject);
    begin
        Tool.Common.JoinBeforeEachLine(edtEachLine.Lines);
    end;

    procedure TfrmMain.btnJoinAfterEachLineClick(Sender: TObject);
    begin
        Tool.Common.JoinAfterEachLine(edtEachLine.Lines);
    end;

    procedure TfrmMain.btnReplaceEachLineClick(Sender: TObject);
    begin
        Tool.Common.ReplaceEachLine(edtEachLine.Lines,edtReplaceEachLine.Text);
    end;

    procedure TfrmMain.btnCrossInsertBeforeEachLineClick(Sender: TObject);
    begin
        Tool.Common.CrossInsertBeforeEachLine(edtEachLine.Lines);
    end;

    procedure TfrmMain.btnCrossInsertAfterEachLineClick(Sender: TObject);
    begin
        Tool.Common.CrossInsertAfterEachLine(edtEachLine.Lines);
    end;

    procedure TfrmMain.btnCircuCrossInsertBeforeEachLineClick(Sender: TObject);
    begin
        Tool.Common.CircuCrossInsertBeforeEachLine(edtEachLine.Lines);
    end;

    procedure TfrmMain.btnCurcuCrossInsertAfterEachLineClick(Sender: TObject);
    begin
        Tool.Common.CircuCrossInsertAfterEachLine(edtEachLine.Lines);
    end;

    procedure TfrmMain.btnRepeatHorzClick(Sender: TObject);
    begin
        Tool.Common.RepeatHorz(edtRepeatHorz.Text,numRepeatHorz.Value);
    end;

    procedure TfrmMain.btnRepeatEachLineClick(Sender: TObject);
    begin
		Tool.Common.RepeatEachLine(numRepeatEachLine.Value);
    end;

    procedure TfrmMain.btnRepeatAllLinesClick(Sender: TObject);
    begin
		Tool.Common.RepeatAllLines(numRepeatAllLines.Value);
    end;

    procedure TfrmMain.btnInsertStringClick(Sender: TObject);
    begin
        Tool.Common.InsertString(numInsertIndex.Value,edtInsertString.Text);
    end;

    procedure TfrmMain.btnRInsertStringClick(Sender: TObject);
    begin
        Tool.Common.RInsertString(numRInsertIndex.Value,edtRInsertString.Text);
    end;

    procedure TfrmMain.btnDeleteString1Click(Sender: TObject);
    begin
        Tool.Common.DeleteString(numDeleteIndex1.Value,numDeleteLength1.Value);
    end;

    procedure TfrmMain.btnRDeleteString1Click(Sender: TObject);
    begin
        Tool.Common.RDeleteString(numRDeleteIndex1.Value,numRDeleteLength1.Value);
    end;

    procedure TfrmMain.btnDeleteString2Click(Sender: TObject);
    begin
        Tool.Common.DeleteStringByPosition(numDeleteIndex2.Value,numDeleteEndIndex2.Value);
    end;

    procedure TfrmMain.btnRDeleteString2Click(Sender: TObject);
    begin
        Tool.Common.RDeleteStringByPosition(numRDeleteIndex2.Value,numRDeleteEndIndex2.Value);
    end;

    procedure TfrmMain.btnExtractString1Click(Sender: TObject);
    begin
        Tool.Common.ExtractString(numExtractIndex1.Value,numExtractLength1.Value);
    end;

    procedure TfrmMain.btnRExtractString1Click(Sender: TObject);
    begin
        Tool.Common.RExtractString(numRExtractIndex1.Value,numRExtractLength1.Value);
    end;

    procedure TfrmMain.btnExtractString2Click(Sender: TObject);
    begin
        Tool.Common.ExtractStringByPosition(numExtractIndex2.Value,numExtractEndIndex2.Value);
    end;

    procedure TfrmMain.btnRExtractString2Click(Sender: TObject);
    begin
        Tool.Common.RExtractStringByPosition(numRExtractIndex2.Value,numRExtractEndIndex2.Value);
    end;

    procedure TfrmMain.btnDeleteColumnClick(Sender: TObject);
    begin
        Tool.Common.DeleteColumn(edtDeleteColumnDelimit.Text,numDeleteColumnIndex.Value);
    end;

    procedure TfrmMain.btnExtractColumnClick(Sender: TObject);
    begin
        Tool.Common.ExtractColumn(edtExtractColumnDelimit.Text,numExtractColumnIndex.Value);
    end;

    procedure TfrmMain.btnLineFirstLowerClick(Sender: TObject);
    begin
        Tool.Common.LineFirstLower;
    end;

    procedure TfrmMain.btnLineFirstUpperClick(Sender: TObject);
    begin
        Tool.Common.LineFirstUpper;
    end;

    procedure TfrmMain.btnAfterFirstUpperClick(Sender: TObject);
    begin
        Tool.Common.AfterFirstUpper(edtAfterFirstUpper.Text);
    end;

    procedure TfrmMain.btnAfterFirstLowerClick(Sender: TObject);
    begin
        Tool.Common.AfterFirstLower(edtAfterFirstLower.Text);
    end;

    procedure TfrmMain.btnDeleteDuplicatedLineClick(Sender: TObject);
    begin
        Tool.Common.DeleteDuplicatedLine(chkDeleteDuplicatedLineIgnoreCase.Checked,chkDeleteDuplicatedLineIgnoreWhitePadding.Checked);
    end;

    procedure TfrmMain.lblMemoExchangeClick(Sender: TObject);
    var
    	buffer:string;
    begin
		buffer:=edtEachLine.Text;
		edtEachLine.Text:=txtMemo.Text;
        txtMemo.Text:=buffer;
    end;

{$ENDREGION}

{$REGION 'Sequence'}
    procedure TfrmMain.btnSeqToEndValueClick(Sender: TObject);
    begin
        Tool.Sequence.SequenceToEndValue(
        	edtSeqTemplate.Text,
        	edtSeqPlaceHolder.Text,
            edtSeqFormat.Text,
            numSeqStartValue.Value,
            numSeqStepLength.Value,
            numSeqEndValue.value
        );
    end;

    procedure TfrmMain.btnSeqRepeatCountClick(Sender: TObject);
    begin
        Tool.Sequence.SequenceByRepeatCount(
        	edtSeqTemplate.Text,
            edtSeqPlaceHolder.Text,
            edtSeqFormat.Text,
            numSeqStartValue.Value,
            numSeqStepLength.Value,
            numSeqRepeatCount.Value
        );
    end;
{$ENDREGION}

{$REGION 'VB'}
    procedure TfrmMain.btnVBCombineStringClick(Sender: TObject);
    begin
        Tool.VB.CombineToStringExpression;
    end;

    procedure TfrmMain.btnVBCancelCombineStringClick(Sender: TObject);
    begin
        Tool.VB.CancelCombineStringExpression;
    end;

    procedure TfrmMain.btnVBPrivateSetToOnPropertyChangedClick(Sender: TObject);
    begin
        Tool.VB.PrivateSetToOnPropertyChanged;
    end;

    procedure TfrmMain.btnVBGeneratePropertyChangedClick(Sender: TObject);
    begin
        Tool.VB.GeneratePropertyChanged;
    end;

    procedure TfrmMain.btnVBPrivateSetToPropertyChangedClick(Sender: TObject);
    begin
        Tool.VB.PrivateSetToPropertyChanged;
    end;

    procedure TfrmMain.btnVBGeneratePropDeclarationClick(Sender: TObject);
    begin
        Tool.VB.GenerateClassicPropertyDeclaration(edtVBGeneratePropName.Text,edtVBGeneratePropType.Text);
    end;

{$ENDREGION}

{$REGION 'CSharp'}
    procedure TfrmMain.btnCSCombineStringClick(Sender: TObject);
    begin
        Tool.CSharp.CombineToStringExpression;
    end;

   procedure TfrmMain.btnCSCancelCombineStringClick(Sender: TObject);
    begin
        Tool.CSharp.CancelCombineStringExpression;
    end;

    procedure TfrmMain.btnCSharpGeneratePropertyChangedClick(Sender: TObject);
    begin
        Tool.CSharp.GeneratePropertyChanged;
    end;

    procedure TfrmMain.btnCSharpPrivateSetToPropertyChangedClick(Sender: TObject);
    begin
        Tool.CSharp.PrivateSetToOnPropertyChanged;
    end;

    procedure TfrmMain.btnCSharpPropertyChangedClick(Sender: TObject);
    begin
        Tool.CSharp.PrivateSetToPropertyChanged;
    end;

{$ENDREGION}

{$REGION 'Pascal'}
    procedure TfrmMain.btnPascalCombineStringClick(Sender: TObject);
    begin
        Tool.ObjectPascal.CombineToStringExpression;
    end;

    procedure TfrmMain.btnPascalCancelCombineStringClick(Sender: TObject);
    begin
        Tool.ObjectPascal.CancelCombineStringExpression;
    end;

    procedure TfrmMain.btnPascalExchangePascalLetClick(Sender: TObject);
    begin
        Tool.Common.ExchangeLetOperatorSide(':=');
    end;

    procedure TfrmMain.btnPascalPropGenerateClick(Sender: TObject);
    begin
        edtPascalPropDeclaration.Text:=Tool.ObjectPascal.GeneratePropertyDeclaration
        (
            edtPascalPropType.Text,
            edtPascalPropPrivate.Text,
            edtPascalPropPublic.Text
        );
    end;

    procedure TfrmMain.btnPascalPropGenerateCopyClick(Sender: TObject);
    begin
        btnPascalPropGenerate.Click;
        edtPascalPropDeclaration.SelectAll;
        edtPascalPropDeclaration.CopyToClipboard;
    end;

    procedure TfrmMain.btnPascalCompletePropertyFromPublicDeclareClick(Sender: TObject);
    begin
        Tool.ObjectPascal.CompletePropertyFromPublicDeclaration(edtPascalCompleteDeclarePrivatePrefix.Text);
    end;

    procedure TfrmMain.btnPascalCompletePropertyFromPrivateDeclareClick(Sender: TObject);
    begin
        Tool.ObjectPascal.CompletePropertyFromPrivateDeclaration(edtPascalCompleteDeclarePrivatePrefix.Text);
    end;

{$ENDREGION}

{$REGION 'PHP'}
    procedure TfrmMain.btnPhpCombineSingleQuoteStringClick(Sender: TObject);
    begin
        Tool.PHP.CombineToSingleQuoteStringExpression;
    end;

    procedure TfrmMain.btnPhpCancelCombineSingleQuoteStringClick(Sender: TObject);
    begin
        Tool.PHP.CancelCombineSingleQuoteStringExpression;
    end;

    procedure TfrmMain.btnPhpCombineDoubleQuoteStringClick(Sender: TObject);
    begin
        Tool.PHP.CombineToDoubleQuoteStringExpression;
    end;

    procedure TfrmMain.btnPhpCancelCombineDoubleQuoteStringClick(Sender: TObject);
    begin
        Tool.PHP.CancelCombineDoubleQuoteStringExpression;
    end;

    procedure TfrmMain.btnPhpAddHereDocClick(Sender: TObject);
    begin
        Tool.PHP.AddHereDocFlag(edtPhpHereDocFlag.Text);
    end;

    procedure TfrmMain.btnPhpRemoveHereDocClick(Sender: TObject);
    begin
        Tool.PHP.RemoveHereDocFlag;
    end;

{$ENDREGION}

{$REGION 'SQL'}
    procedure TfrmMain.btnSqlUpperKeyWordsClick(Sender: TObject);
    begin
        Tool.SQL.ConvertKeyWordsToUpperCase;
    end;

    procedure TfrmMain.btnSqlWrapBySyntaxClick(Sender: TObject);
    begin
        Tool.SQL.AdjustWrapBySyntax;
    end;

    procedure TfrmMain.btnSqlUpperWrapBySyntaxClick(Sender: TObject);
    begin
        Tool.Common.CompressSpaces;
        Tool.SQL.ConvertKeyWordsToUpperCase;
        Tool.SQL.AdjustWrapBySyntax;
    end;

    procedure TfrmMain.btnSqlCombineToEnumerationClick(Sender: TObject);
    begin
        Tool.SQL.CombineToEnumeration;
    end;

    procedure TfrmMain.btnSqlCombineToQuotedEnumerationClick(Sender: TObject);
    begin
        Tool.SQL.CombineToQuotedEnumeration;
    end;

    procedure TfrmMain.btnSqlCancelCombineToEnumerationClick(Sender: TObject);
    begin
        Tool.SQL.CancelCombineEnumeration;
    end;

    procedure TfrmMain.btnSqlCancelCombineToQuotedEnumerationClick(Sender: TObject);
    begin
        Tool.SQL.CancelCombineQuotedEnumeration;
    end;

{$ENDREGION}

{$REGION 'IE'}
    procedure TfrmMain.btnIeIfIeClick(Sender: TObject);
    begin
        Tool.IE.AddIfIE;
    end;

    procedure TfrmMain.btnIeIfConditionClick(Sender: TObject);
    begin
        Tool.IE.AddIfCondition(drpIeIfOperator.Text,drpIeIfVersion.Text);
    end;

    procedure TfrmMain.btnIeRemoveIfClick(Sender: TObject);
    begin
        Tool.IE.RemoveIf;
    end;

{$ENDREGION}

{$REGION 'HTML'}
    procedure TfrmMain.btnHtmlHtmlTagClick(Sender: TObject);
    begin
        Tool.HTML.WrapHtml(edtHtmlHtmlTag.Text);
    end;

    procedure TfrmMain.btnHtmlUnHtmlClick(Sender: TObject);
    begin
        Tool.HTML.UnWrapHtml(edtHtmlHtmlTag.Text);
    end;

    procedure TfrmMain.btnHtmlBBCodeClick(Sender: TObject);
    begin
        Tool.HTML.WrapBBCode(edtHtmlBBCode.Text);
    end;

    procedure TfrmMain.btnHtmlUnBBCodeClick(Sender: TObject);
    begin
        Tool.HTML.UnWrapBBCode(edtHtmlBBCode.Text);
    end;

    procedure TfrmMain.btnHtmlEscapeClick(Sender: TObject);
    begin
        Tool.HTML.EscapeHtml;
    end;

    procedure TfrmMain.btnHtmlUnescapeClick(Sender: TObject);
    begin
        Tool.HTML.UnEscapeHtml;
    end;

{$ENDREGION}

{$REGION 'MASM'}
    procedure TfrmMain.btnMasmDefineToEqualClick(Sender: TObject);
    begin
        Tool.MASM.DefineToEqu;
    end;

    procedure TfrmMain.btnMasmEqualToDefineClick(Sender: TObject);
    begin
        Tool.MASM.EquToDefine;
    end;

{$ENDREGION}

end.

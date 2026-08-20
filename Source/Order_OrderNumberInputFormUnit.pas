 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Order_OrderNumberInputFormUnit;

interface uses
	img_storageformunit,
   constantsunit,
   toolboxunit,
   //
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   Buttons,
   ExtCtrls,
   ComCtrls,
   ToolWin,
   jpeg,
   themes, Mask;

type
   tOrderNumberInputForm = class(TForm)
      ORDER_NUM_BACK_PANEL: TPanel;
      BackPanel: TPanel;
      ErrorImg: TImage;
      BOT_PANEL: TPanel;
      MOPButtonBar: TToolBar;
      OkButton: TToolButton;
      CancelButton: TToolButton;
    header_label: TLabel;
      ordNumLabel: TLabel;
    db_num: TMaskEdit;
    imgAvoName: TImage;
    imgAvoIcon: TImage;
      procedure OkButtonClick(Sender: TObject);
      procedure CancelButtonClick(Sender: TObject);
    procedure db_numKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
   private
      fResult : TMsgDlgBtn;
      function fGetOrderNum : string;
   public
      property InputResult : TMsgDlgBtn read fResult;
      property OrderNum : string read fGetOrderNum;
      //
      constructor create( owner : tComponent; inHeader : string );
   end;

function Order_GetOrderNumberInputForm( inHeader : string ) : String;

implementation

{$R *.dfm}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function Order_GetOrderNumberInputForm( inHeader : string ) : String;
var
   OrdNumDialogForm : tOrderNumberInputForm;
   ordNum : string;
   ordID : string;
begin
   ordNumDialogForm := tOrderNumberInputForm.Create( Application, inHeader );
   ordNum := '';
   try
      ordNumDialogForm.ShowModal();
      if ( ordNumDialogForm.InputResult = mbOk ) then
         ordNum := ordNumDialogForm.OrderNum;
   finally
      FreeAndNil( ordNumDialogForm );
   end;
   result := ordNum;
end;


// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

constructor tOrderNumberInputForm.create(owner: tComponent; inHeader: string);
begin
   inherited Create( owner );
   //
   header_label.Caption := inHeader;
end;

procedure tOrderNumberInputForm.CancelButtonClick(Sender: TObject);
begin
   fResult := mbCancel;
   Close();
end;

procedure tOrderNumberInputForm.OkButtonClick(Sender: TObject);
begin
   fResult := mbOk;
   Close();
end;


procedure tOrderNumberInputForm.db_numKeyPress(Sender: TObject;
  var Key: Char);
begin
   if ( Key = #$1B ) then
   begin
      fResult := mbCancel;
      Close();
   end;
   if ( Key = #13 ) then
   begin
      fResult := mbOk;
      Close();
   end;
end;

function tOrderNumberInputForm.fGetOrderNum: string;
begin
   result := Trim(db_num.text);
end;


procedure tOrderNumberInputForm.FormShow(Sender: TObject);
begin
   db_num.SetFocus();
end;

end.

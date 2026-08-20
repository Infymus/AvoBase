 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Accounting_EscrowModifyFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   recordstructureunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   ToolBox_PreferenceToolBoxUnit,
   masterdata_BaseDataClassUnit,
   toolbox_customertoolboxunit,
   encryptunit,
   toolbox_escrowtoolboxunit,
   AvoBase_HelpFormUnit,
   //
   windows,
   messages,
   dbtables,
   sysutils,
   variants,
   classes,
   ActnList,
   graphics,
   controls,
   forms,
   dialogs,
   stdctrls,
   extctrls,
   ComCtrls,
   ToolWin,
   Mask;

type
   tEscrowModifyForm = class(TAvoBase_BaseForm_Menu)
    AmountDueLabel: TLabel;
    db_escrow: TLabel;
    CustSoldToName: TLabel;
    CustSoldToAddress: TLabel;
    CustSoldToCityStateZip: TLabel;
    CustSoldToPhone: TLabel;
    RetailCostLabel: TLabel;
    db_adjust: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure RetailCostLabelClick(Sender: TObject);
   private
      fCustQuery : tMasterData_BaseDataClass;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      function fGetID : string;
      function fGetAmount : currency;
      function fGetCustName : string;

   public
      procedure StartUpForm();
      function Save() : boolean;
      //
      property ID : string read fGetID;
      property Amount : currency read fGetAmount;
      property CustName : string read fGetCustName;
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; inQuery : tMasterData_BaseDataClass); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TEscrowModifyForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean; inQuery: tMasterData_BaseDataClass);
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fCustQuery := inQuery;
   //
	StartUpForm();
end;

procedure TEscrowModifyForm.StartUpForm;
var
   custRec : tCustRec;
begin
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_HELP );
   CreateButtonSep();
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_OK );
   //
   CustRec := Customer_GetCustomerByCustID( ID );
   CustSoldToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
   CustSoldToAddress.Caption := CustRec.ADDR1;
   CustSoldToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
   if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
   	CustSoldToCityStateZip.Caption := '';
   CustSoldToPhone.Caption := CustRec.PHONEH;
   //
   db_escrow.caption := FormatCurrency( Escrow_GetCustomerEscrowByCustomerID( ID ) );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tEscrowModifyForm.fGetAmount: currency;
begin
   result := Return_MaskEdit_Curr( db_adjust.Text );
end;

function tEscrowModifyForm.fGetCustName: string;
begin
   result := fCustQuery.GetFieldByName('FNAME').AsString + ' ' +
      fCustQuery.GetFieldByName('LNAME').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tEscrowModifyForm.fGetID: string;
begin
   result := fCustQuery.GetFieldByName('ID').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEscrowModifyForm.FormShow(Sender: TObject);
begin
   inherited;
   db_adjust.SetFocus();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tEscrowModifyForm.Save: boolean;
var
   errMsg : string;
begin
   errMsg := '';

   // validate here
   if AvoBaseDialog('Adjust Customer Escrow',
      'Confirm that you are adjusting Customer Escrow:\n\n' + CustName + '.\n\n'+
      'New Escrow Amount will be : ' + Pref_GetCashSymbol + FormatCurrency( Amount ) + '\n\n' +
      'Are you sure you wish to adjust Escrow?', mtConfirmation, [mbyes, mbno], 0) = mbYes then
   begin
      Escrow_AdjustEscrowByCustomerID( ID, Amount );
      AvoBaseDialog('Customer Escrow Adjusted',
         'Customer ' + CustName + ' Escrow adjusted to ' + Pref_GetCashSymbol + FormatCurrency( Amount ) + '.', mtInformation, [mbOk], 0);
   end;
{
   if (db_fname.text = '') then
      errMsg := 'First Name cannot be blank.';
}
   if (errMsg = '') then
   begin
      //
      // do the save
   end;
   if ( errMsg <> '') then
      AvoBaseDialog('Unable To Process Escrow', errMsg, mtWarning, [mbOk], 0);
   result := (errMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEscrowModifyForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_OK :
      begin
         if ( Save() ) then
         begin
            Self.fFormEvent := mrOk;
            Close();
         end;
      end;
      CMD_CANCEL :
      begin
      	if AvoBaseDialog('Cancel Escrow Changes', 'Are you sure you want to Cancel Escrow Adjustments?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
				fCustQuery.Cancel();
            Close();
         end;
      end;
      CMD_HELP : AvoBaseHelp_Execute('EscrowModifyForm');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tEscrowModifyForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;

procedure tEscrowModifyForm.RetailCostLabelClick(Sender: TObject);
begin
  inherited;

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.

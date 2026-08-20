 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Payment_VoidPaymentFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
  recordstructureunit,
   toolbox_PreferenceToolBoxUnit,
   masterdata_BaseDataClassUnit,
   toolbox_customertoolboxunit,
   toolbox_OrderToolBoxUnit,
   encryptunit,
   Order_InvoiceObjectUnit,
   Invoice_MOPItem_FormUnit,
   toolbox_paymenttoolboxunit,
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
  TPayment_VoidPaymentForm = class(TAvoBase_BaseForm_Menu)
    MOP_DOCK_PANEL: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    db_voidreason: TComboBox;
    GroupBox2: TGroupBox;
    CustSoldToName: TLabel;
    CustSoldToAddress: TLabel;
    CustSoldToCityStateZip: TLabel;
    CustSoldToPhone: TLabel;
    db_voiddate: TDateTimePicker;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function fGetVoidDate : tDateTime;
   private
      fMOPQuery : tMasterData_BaseDataClass;
   	fCloseAction : tFormActions;
      fOrderID : string;
      fMOPID : string;
      orderInvoice : tInvoice;
      FVoidType: tVoidTypes;
      //
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure StartupForm;
      function Save : boolean;
      function fReadVoidType : tVoidTypes;
      procedure SetVoidType(const Value: tVoidTypes);
   public
      MOPItem_Form : tInvoice_MOPItem_Form;
   	property CloseAction : tFormActions read fCloseAction;
      property VoidType : tVoidTypes read fReadVoidType write SetVoidType;
      property VoidDate : tDateTime read fGetVoidDate;
      constructor Create( owner: TComponent; InCaption : string; inOrderID : string; inMOPID : string; isTopBarVisble : boolean); overload;
   end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TPayment_VoidPaymentForm.Create(owner: TComponent; InCaption, inOrderID: string; inMOPID : string; isTopBarVisble: boolean);
begin
	inherited create( owner, incaption, isTopBarVisble, false );
   //
   fOrderID := inOrderID;
   fMOPID := inMOPID;
   //
   StartupForm();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{
            table_mop :
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // customer ID
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'MOPCCEXPM INTEGER, ' + // cc expiration date Month
            'MOPCCEXPY INTEGER, ' + // cc expiration date Year
            'MOPNOC VARCHAR(30), ' + // cc name on card
            'MOPCVV VARCHAR(6), ' + // cc CVV (security #)
            'MOPCCT INTEGER, ' + // credit card type ( see tCreditCardTypes );
            'MOP_REV BOOLEAN, ' + // payment reversed?
            'AMOUNT MONEY',
}
procedure TPayment_VoidPaymentForm.StartupForm;
var
   custRec : tCustRec;
   payRec : tPaymentRec;
begin
   fMOPQuery := tMasterData_BaseDataClass.Create( masterData, masterData.GetTable_Mop);
   fMOPQuery.Load( fMOPID );
   orderInvoice := tInvoice.Create( InvoiceTypeReport, NIL, NIL, NIL);
   orderInvoice.Load( fOrderID );
   //
   BASE_FORM_CAPTION_LABEL.Caption := 'Void Payment On Order # ' + orderInvoice.Order_GetOrderNumberName;
   //
   Payment_FillVoidTypes( db_voidreason );
   db_voiddate.Date := Now;
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_HELP );
   CreateButtonSep();
   CreateButton( CMD_CANCEL );
   CreateButton( CMD_VOID_PAYMENT );
   //
   CustRec := Customer_GetCustomerByCustID( orderInvoice.Customer_SoldToID );
   CustSoldToName.Caption := CustRec.FNAME + ' ' + CustRec.LNAME;
   CustSoldToAddress.Caption := CustRec.ADDR1;
   CustSoldToCityStateZip.Caption := CustRec.CITY + ' | ' + CustRec.STATE + ' | ' + CustRec.ZIP;
   if (CustRec.CITY = '') OR (CustRec.STATE = '') OR (CustRec.ZIP = '') then
   	CustSoldToCityStateZip.Caption := '';
   CustSoldToPhone.Caption := CustRec.PHONEH;
   //
   MOPItem_Form := tInvoice_MOPItem_Form.Create( MOP_DOCK_PANEL );
   with MOPItem_Form do
   begin
      ManualDock( MOP_DOCK_PANEL );
      Visible := True;
      Show();
      Align := alClient;
   end;
   MOPItem_Form.ReadOnly := true;
   //
   MOPItem_Form.LineNumber := 0;
   MOPItem_Form.ID := masterData.NewDBGuid;
   MOPItem_Form.OrderID := fOrderID;
   //
   MOPItem_Form.Repaint();
   MOPItem_Form.Show();
   //
   payRec := Payment_GetPaymentRecordByID( fMOPID );
   MOPItem_Form.MopDate := payRec.mopdate;
   MOPItem_FOrm.TurnOffBackPanel();
   MOPItem_Form.TurnOffSidePanel();
   MOPItem_Form.MopType := payRec.moptype;
   MOPItem_Form.MopValue := payRec.mopvalue;
   MOPItem_Form.MopCCExpM := payRec.mopccexpm;
   MOPItem_Form.MopCCExpY := payRec.mopccexpy;
   MOPItem_Form.MopNoc := payRec.mopnoc;
   MOPItem_Form.MopCVV := payRec.mopcvv;
   MOPItem_Form.Amount := payRec.amount;
   //
   // Self.Width := MOPItem_Form.FormWidth_Void;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPayment_VoidPaymentForm.fGetVoidDate: tDateTime;
begin
   result := db_voiddate.Date;
end;

procedure TPayment_VoidPaymentForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   // DO NOT INHERITED HERE... WE CONTROL THIS POPUP BS
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


procedure TPayment_VoidPaymentForm.FormDestroy(Sender: TObject);
begin
   FreeAndNil( fMOPQuery );
   FreeAndNil( orderInvoice );
   FreeAndNil( MOPItem_Form );
   //
  inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPayment_VoidPaymentForm.FormShow(Sender: TObject);
begin
  inherited;
   //
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPayment_VoidPaymentForm.fReadVoidType: tVoidTypes;
begin
   result := Payment_GetVoidTypeByName( db_voidreason.Text );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPayment_VoidPaymentForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_VOID_PAYMENT :
      begin
         if (Save) then
         begin
            if AvoBaseDialog('Confirm Void Payment', 'Voided Payments cannot be undone.' + #13 + #13 +
               'Are you sure you want to Void this Payment?', mtConfirmation, [mbYes, mbNo], 0) = mbyes then
                  fCloseAction := actionSave
               else
                  fCloseAction := actionCancel;
            Close();
         end;
      end;
      CMD_CANCEL :
      begin
      	if AvoBaseDialog('Cancel Void Payment', 'Are you sure you want to Cancel this Void Payment?',
         	mtConfirmation, [mbYes, mbNo], 0) = mbyes then
         begin
         	fCloseAction := actionCancel;
            Close();
         end;
      end;
      CMD_HELP : AvoBaseHelp_Execute('Payment_VoidPaymentForm');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPayment_VoidPaymentForm.HandleActionListUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
   // this handles the action list being updated to determine if tActions are enabled or not
   handled := true;
   with Action as tAction do
      case tag of
         CMD_SAVE : enabled := true;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TPayment_VoidPaymentForm.Save: boolean;
var
   errMsg : string;
   oPay : currency;
   payRec : tPaymentRec;
begin
   errMsg := '';

   // validate here
   payRec := Payment_GetPaymentRecordByID( fMOPID );
   //
   case payRec.moptype of
      integer(PayTypeCash) : errMsg := 'You cannot Void or NSF a Cash Payment.';
      integer(PayTypeEscrow) : errMsg := 'You cannot Void or NSF an Escrow Payment.';
   end;
   //
   if (errMsg <> '') then
      AvoBaseDialog('Unable to Void Payment', errMsg, mtWarning, [mbOk], 0);
   //
   result := (errMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TPayment_VoidPaymentForm.SetVoidType(const Value: tVoidTypes);
begin
  FVoidType := Value;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.





 (* WHAT NEEDS TO BE DONE:


 1. bring in the method of payment.

 2. display the entire method of payment on the screen. it is NOT editable. just display the shit for them.

 3. the ONLY items that ARE editable are:

   - date of VOID
   - type of VOID

               'RDATE DATE, ' + // reversal date
            'RTYPE INTEGER, ' + // reversal type - see tReversalTypes

      tVoidTypes = ( VoidNSF = 1, Void = 2 );


         retVal := masterData.AddTable(masterData.dbPath + table_reversal,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ORDER_ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // customer ID
            'PAY_ID VARCHAR(40), ' + // original method of payment ID
            'RDATE DATE, ' + // reversal date
            'RTYPE INTEGER, ' + // reversal type - see tReversalTypes
            'MOPDATE DATE, ' + // date of MOP
            'MOPTYPE INTEGER, ' + // see tMethodOfPaymentTypes for details.
            'MOPVALUE VARCHAR(30), ' + // credit card # or check # or money order #
            'MOPCCEXPM INTEGER, ' + // cc expiration date Month
            'MOPCCEXPY INTEGER, ' + // cc expiration date Year
            'MOPNOC VARCHAR(30), ' + // cc name on card
            'MOPCVV VARCHAR(6), ' + // cc CVV (security #)
            'MOPCCT INTEGER, ' + // credit card type ( see tCreditCardTypes );
            'AMOUNT MONEY',

*)


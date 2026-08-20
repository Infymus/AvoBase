 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
 unit Customer_SelectFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   masterdata_BaseDataClassUnit,
   masterdata_basegridunit,
   masterdata_navigationtoolunit,
   AvoBase_ToolBarUnit,
   recordstructureunit,
   toolbox_orgtoolboxunit,
   AvoBase_BaseForm_SelectUnit,
   MasterData_CustSelectUnit,
   customer_editformunit,
   errorresultunit,
   //
   windows,
   messages,
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
   Mask,
   DB,
   jpeg;

type
  TCustomerSelectForm = class(TAvoBase_BaseForm_Select)
   private
      fLoadOrderEvent : tLoadOrderEvent;
      CustomerDetailListQuery : tMasterDataCustomerSelectList;
      function fGetCustomerID : string;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure HandleDoubleClick( sender : tObject );
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
   public
      procedure StartUpForm();
      procedure UpdateQuery();
      procedure StatBarUpdate();
      procedure CustomerNewCustomer();
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property CustID : string read fGetCustomerID;
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TCustomerSelectForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   CustomerDetailListQuery := tMasterDataCustomerSelectList.Create( masterData);
   //
   dataListGrid.Init( CustomerDetailListQuery, 'FNAME');
   gridDataSource.DataSet := CustomerDetailListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   dataListGrid.Clear;
   //
   dataListGrid.Add(CustomerDetailListQuery.FieldByName('FULLNAME'), 'CUSTOMER NAME', 164, clRed, [fsBold], taLeftJustify);
   dataListGrid.Add(CustomerDetailListQuery.FieldByName('PHONEH'), 'PHONE', 120, clBlue, [], taLeftJustify);
   dataListGrid.Add(CustomerDetailListQuery.FieldByName('PHONEC'), 'CELL', 120, clHighlight, [], taLeftJustify);
   dataListGrid.Add(CustomerDetailListQuery.FieldByName('FULLADDR'), 'ADDRESS', 300, clBlack, [], taLeftJustify);

   //
   dataListGrid.OnDblClick := HandleDoubleClick;
   //
   dbNavTool.Init( CustomerDetailListQuery );
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   //
   CreateButtonSep();
   CreateButton( CMD_NEW );
   //
	StartUpForm();
   StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerSelectForm.StartUpForm;
begin
   //
   BASE_FORM_CAPTION_LABEL.Caption := 'Select Customer';
   //
   OPTION_DOCK.Visible := false;
   UpdateQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TCustomerSelectForm.fGetCustomerID: string;
begin
   result := CustomerDetailListQuery.FieldByName('ID').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerSelectForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   case actionID of
      CMD_SELECT_OK :
      begin
         fFormEvent := mrOk;
         Close();
      end;
      CMD_SELECT_CANCEL :
      begin
         fFormEvent := mrCancel;
         Close();
      end;
      CMD_NEW :
      begin
         CustomerNewCustomer();
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerSelectForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerSelectForm.HandleDoubleClick(sender: tObject);
begin
   fFormEvent := mrOk;
   Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerSelectForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerSelectForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(CustomerDetailListQuery.RecNo) + ' of ' + IntToStr(CustomerDetailListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerSelectForm.UpdateQuery;
begin
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TCustomerSelectForm.CustomerNewCustomer;
var
	errRec : tErrorResult;
   id : string;
   custQuery : tMasterData_BaseDataClass;
   	frmCustEdit : tCustomerEditForm;
begin
   custQuery := tMasterData_BaseDataClass.create( masterData, masterData.Gettable_Customer );
   custQuery.Append();
   id := custQuery.GetFieldByName('ID').AsString;
   frmCustEdit := tCustomerEditForm.Create( Application, 'New Customer', true, custQuery);
   frmCustEdit.IsNew := true;
   try
      frmCustEdit.ShowModal();
      if ( frmCustEdit.CloseAction = actionSave ) then
      begin
         id := custQuery.GetFieldByName('ID').AsString;
         CustomerDetailListQuery.Close();
         CustomerDetailListQuery.Open();
         CustomerDetailListQuery.Locate('ID', id, [loCaseInsensitive]);
      end;
   finally
      FreeAndNil( custQuery );
      // DONT FreeAndNil(frmCustEdit);
   end;
end;

end.

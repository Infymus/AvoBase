 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit Order_SelectOrderToReturnFormUnit;

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
   AvoBase_BaseForm_SelectUnit,
   MasterData_OrderSelectClosedOnlyListUnit,
   toolbox_customertoolboxunit,
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
  TOrderSelectOrderToReturnForm = class(TAvoBase_BaseForm_Select)
   private
      fCustID : string;
      fOrdStat : tOrderStatusTypes;
      fLoadOrderEvent : tLoadOrderEvent;
      OrderDetailListQuery : tMasterDataReturnOrderList;
      function fOrderID : string;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure HandleDoubleClick( sender : tObject );
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
   public
      procedure StartUpForm();
      procedure UpdateQuery();
      procedure StatBarUpdate();
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property OrderID : string read fOrderID;
      constructor Create( owner: TComponent; inCustID : string; InCaption : string; isTopBarVisble : boolean); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TOrderSelectOrderToReturnForm.Create(owner: TComponent; inCustID : string; InCaption: string; isTopBarVisble: boolean);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   fCustID := inCustID;
   fOrdStat := OrderStatusClosed;
   //
   OrderDetailListQuery := tMasterDataReturnOrderList.Create( masterData);
   //
   dataListGrid.Init( OrderDetailListQuery, 'ORGNAME');
   gridDataSource.DataSet := OrderDetailListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   dataListGrid.Clear;
   //
   DataListGrid.Add(OrderDetailListQuery.FieldByName('ONUM'), 'ORDER #', 60, clBlack, [fsBold], tarightJustify);
   DataListGrid.Add(OrderDetailListQuery.FieldByName('ODATE'), 'DATE', 90, clTeal, [], taRightJustify);
   DataListGrid.Add(OrderDetailListQuery.FieldByName('OTYPE'), 'OTYPE', 60, clBlack, [], taLeftJustify);
   DataListGrid.Add(OrderDetailListQuery.FieldByName('CYCLE'), 'CYCLE', 60, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(OrderDetailListQuery.FieldByName('DISPSTATUS'), 'STATUS', 75, $00000040, [fsBold], taLeftJustify);
   //
   dataListGrid.OnDblClick := HandleDoubleClick;
   //
   dbNavTool.Init( OrderDetailListQuery );
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   //
   OPTION_DOCK.Visible := false;
   //
	StartUpForm();
   StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TOrderSelectOrderToReturnForm.StartUpForm;
begin
   //
   BASE_FORM_CAPTION_LABEL.Caption := 'Select Open Orders For ' + Customer_GetCustomerNameByCustID( fCustID );
   //
   UpdateQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TOrderSelectOrderToReturnForm.fOrderID: string;
begin
   result := OrderDetailListQuery.FieldByName('ID').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TOrderSelectOrderToReturnForm.HandleActionExecute(sender: tObject; actionID: integer);
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
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TOrderSelectOrderToReturnForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case tag of
         CMD_SELECT_OK : enabled := ( OrderDetailListQuery.RecordCount <> 0);
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TOrderSelectOrderToReturnForm.HandleDoubleClick(sender: tObject);
begin
   fFormEvent := mrOk;
   Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TOrderSelectOrderToReturnForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TOrderSelectOrderToReturnForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(OrderDetailListQuery.RecNo) + ' of ' + IntToStr(OrderDetailListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TOrderSelectOrderToReturnForm.UpdateQuery;
begin
   OrderDetailListQuery.UpdateByCustIDAndStatus( fCustID, fOrdStat);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.

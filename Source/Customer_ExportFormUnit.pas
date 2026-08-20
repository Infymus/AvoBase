 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Customer_ExportFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_percentformunit,
   avobase_baseform_menuunit,
   masterdata_BaseDataClassUnit,
   recordstructureunit,
   masterdata_basegridunit,
   masterdata_navigationtoolunit,
   ErrorResultUnit,
   AvoBase_ToolBarUnit,
   MasterData_CustomerListUnit,
   toolbox_ordertoolboxunit,
   toolbox_PreferenceToolBoxUnit,
   ToolBox_EscrowToolBoxUnit,
   avobase_dialogformunit,
   Customer_ExportSelectTypeFormUnit,
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
	tExport_Customer = class(TAvoBase_BaseForm_Menu)
    BASE_NAVBAR_PANEL: TPanel;
    BASE_NAVBAR_DOCK_PANEL: TPanel;
    sortViewLabel: TLabel;
    SortViewComboBox: TComboBox;
    activityLabel: TLabel;
    ActiveComboBox: TComboBox;
    SaveDialog: TSaveDialog;
    Panel1: TPanel;
    procedure UpdateEventQuery(Sender: TObject);
   private
      fCustQuery : tMasterData_BaseDataClass;
   	custOrderDetailListGrid : tAvoBaseDBGrid;
      custListQuery : tMasterDataCustomerList;
      dbNavTool : tAvoBaseDBNavigationTool;
   	//
      procedure StartUpForm();
      procedure CloseForm();
      procedure ExportCustomerData();
   	procedure StatBarUpdate();
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure UpdateCustQuery;
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
   public
   	constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tExport_Customer.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   custListQuery := tMasterDataCustomerList.Create( masterData);
   custListQuery.open;
   //
   custOrderDetailListGrid := tAvoBaseDBGrid.Create( nil, BASE_DOCK_PANEL, custListQuery, 'FNAME' );
   custOrderDetailListGrid.Clear;
   //
   custOrderDetailListGrid.Init( custListQuery, 'FNAME' );
   custOrderDetailListGrid.Clear;
   custOrderDetailListGrid.Add(custListQuery.FieldByName('FULLNAME'), 'CUSTOMER NAME', 150, clRed, [fsBold], taLeftJustify);
   custOrderDetailListGrid.Add(custListQuery.FieldByName('PHONEH'), 'PHONE', 110, clHighlight, [], taLeftJustify);
   custOrderDetailListGrid.Add(custListQuery.FieldByName('PHONEC'), 'CELL', 110, clHighlight, [], taLeftJustify);
   custOrderDetailListGrid.Add(custListQuery.FieldByName('FULLADDR'), 'ADDRESS', 250, clBlack, [], taLeftJustify);
   custOrderDetailListGrid.Add(custListQuery.FieldByName('TOTO'), 'OPEN', 60, clGreen, [], taRightJustify);
   custOrderDetailListGrid.Add(custListQuery.FieldByName('TOTC'), 'CLOSED', 60, clGreen, [], taRightJustify);
   custOrderDetailListGrid.Add(custListQuery.FieldByName('BOT'), 'B/O', 60, clGreen, [], taRightJustify);
   custOrderDetailListGrid.Add(custListQuery.FieldByName('TOTN'), 'NOTES', 60, clGreen, [], taRightJustify);
   //
   custOrderDetailListGrid.DataSource.OnDataChange := HandleQueryUpdate;
   //
	dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL, custListQuery);
   //
  //
	StartUpForm();
   StatBarUpdate();
   //
   UpdateCustQuery();
end;


procedure tExport_Customer.StartUpForm;
begin
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
	CreateButton( CMD_CLOSE );
   CreateButtonSep();
   CreateButton( CMD_CUST_EXPORT );
end;

procedure tExport_Customer.CloseForm;
begin
	FreeAndNil(custOrderDetailListGrid);
   FreeAndNil(dbNavTool);
   freeAndNil(custListQuery);
	Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tExport_Customer.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(custListQuery.RecNo) + ' of ' + IntToStr(custListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tExport_Customer.UpdateCustQuery;
var
	sortDir : string;
   onlyActive : tActiveStates;
begin
	if (SortViewComboBox.ItemIndex = 1) then
   	sortDir := 'DESC'
   else
   	sortDir := '';
   //
   case ActiveComboBox.ItemIndex of
   	0 : onlyActive := tActiveStates.stateActive;
   	1 : onlyActive := tActiveStates.stateInactive;
   	2 : onlyActive := tActiveStates.stateAll;
   end;
   //
   custListQuery.Update('FNAME', sortDir, onlyActive);
end;

procedure tExport_Customer.UpdateEventQuery(Sender: TObject);
begin
	UpdateCustQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tExport_Customer.HandleActionExecute(sender: tObject; actionID: integer);
begin
   // this handles whether an item was clicked
   case actionID of
      CMD_CLOSE : CloseForm();
      CMD_CUST_EXPORT : ExportCustomerData();
   end;
end;

procedure tExport_Customer.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_CUST_EXPORT : enabled := ( custListQuery.RecordCount <> 0 );
         CMD_CLOSE : enabled := true;
      end;

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tExport_Customer.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
   StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tExport_Customer.ExportCustomerData;
var
	exportForm : tCustomer_ExportSelectTypeForm;
   exportType : tAvoBaseExportTypes;
   errResult : tErrorResult;
   canRun : boolean;
begin
   exportType := tAvoBaseExportTypes.None;
	exportForm := tCustomer_ExportSelectTypeForm.Create( Application, 'Select Customer Export Types', False );
   exportForm.ShowModal();
   exportType := exportForm.ExportType;

   // don't free, it's caFree action type on tCustomer_ExportSelectTypeForm.

   if ( exportForm.FormCloseType = mrOK ) then
   begin
   	// what kind of file do we have?
      case exportType of
      	// Text
      	tAvoBaseExportTypes.Text_CommaDelimited,
         tAvoBaseExportTypes.Text_CommaDelimitedQuotes,
         tAvoBaseExportTypes.Text_CommaDelimitedSingleQuotes :
         begin
         	SaveDialog.Filter := 'Text Files|txt';
            SaveDialog.FileName := 'AvoBaseCustExport.txt';
         end;
         // Excel
      end;

		if ( SaveDialog.Execute ) then
      begin
      	canRun := true;
      	if FileExists( SaveDialog.FileName ) then
         	if AvoBaseDialog('Replace File', 'File ' + SaveDialog.FileName + ' already exists. Overwrite it?', mtConfirmation, [mbYes, mbNo], 0 ) = mbNo then
            	canRun := false;
			//
         if ( canRun ) then
         begin
         	errResult := custListQuery.Export( SaveDialog.FileName, exportType );
            if ( errResult.errorResult ) then
            	AvoBaseDialog('Export Error', errResult.errorMessage, mtError, [mbok], 0)
            else
            	AvoBaseDialog('Export Complete', 'Results saved in ' + SaveDialog.FileName, mtInformation, [mbOk], 0);
         end;
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.

 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Cycle_ListFormUnit;

interface uses
   toolboxunit,
   constantsunit,
   masterdataunit,
   inifileunit,
   img_storageformunit,
   recordstructureunit,
   errorresultunit,
   actionunit,
   masterdata_basegridunit,
   AvoBase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   masterdata_navigationtoolunit,
   masterdata_BaseDataClassUnit,
   masterdata_Cyclelistunit,
   cycle_editformunit,
   Avobase_BaseForm_ListUnit,
   cycle_vieworderlistunit,
   toolbox_cycletoolboxunit,
   toolbox_orgtoolboxunit,
   //
   db,
   dbtables,
   bde,
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   dbgrids,
   grids,
   Forms,
   Dialogs,
   StdCtrls,
   ExtCtrls,
   ComCtrls,
   ToolWin,
   ActnList,
   jpeg;

type
   tCycleListForm = class(TAvobase_BaseForm_List)
    Label1: TLabel;
    orgComboBox: TComboBox;
    Label4: TLabel;
    SortViewComboBox: TComboBox;
    Label3: TLabel;
    SortByComboBox: TComboBox;
      //
      procedure EventUpdateQuery(Sender: TObject);
    procedure SortComboBoxChange(Sender: TObject);
   private
      fLoadOrderEvent : tLoadOrderEvent;
   	frmCycleView : TCycleViewOrderListForm;
   	frmCycleEdit : tCycleEditForm;
      CycleQuery : tMasterData_BaseDataClass;
      cycleListQuery : tMasterDataCycleList;
      fViewInvoiceEvent : tViewInvoiceEvent;
      fCycleRefreshEvent : tCycleRefreshEvent;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleOnLoadOrderEvent( sender : tObject; inOrderID : string );
      function fGetCycleRecCount : integer;
      procedure HandleOnViewInvoiceEvent( sender : tobject; inorderid : string );
      procedure HandleDoubleClick( sender : tObject );
   public
      //
      function Check_CanCreate: boolean;
      procedure CycleNew();
      procedure CycleEdit();
      procedure CycleGenerate();
      procedure CycleReports();
      procedure CycleView();
      procedure CycleViewOrders();
      procedure UpdateCycleComboBox();
      procedure Recalculate( inID : string );
      procedure GlobalRefreshEvent();
      //
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property OnViewInvoiceEvent : tViewInvoiceEvent read fViewInvoiceEvent write fViewInvoiceEvent;
      property CycleRecCount : integer read fGetCycleRecCount;
      property OnCycleRefreshEvent : tCycleRefreshEvent read fCycleRefreshEvent write fCycleRefreshEvent;
      procedure UpdateCycleQuery();
      constructor Create(owner : tComponent);  overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TCycleListForm.create(owner : TComponent);
begin
	inherited create( NIL, 'Cycles', false, True);
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   cycleListQuery := tMasterDataCycleList.Create( masterData);
   //
   CycleQuery := tMasterData_BaseDataClass.create( masterData, masterData.Gettable_Cycle );
   //
   gridDataSource.DataSet := cycleListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   DataListGrid.Init( cycleListQuery, 'ORG' );
   DataListGrid.Clear;
   DataListGrid.Add(cycleListQuery.FieldByName('ORGNAME'), 'ORG', 180, clNavy, [fsBold], taLeftJustify);
   DataListGrid.Add(cycleListQuery.FieldByName('CNAME'), 'CYCLE', 60, clBlue, [fsBold], taRightjustify);
   DataListGrid.Add(cycleListQuery.FieldByName('SDATE'), 'START DATE', 90, clBlack, [fsBold], taRightjustify);
   DataListGrid.Add(cycleListQuery.FieldByName('EDATE'), 'END DATE', 90, clBlack, [fsBold], taRightjustify);
   DataListGrid.Add(cycleListQuery.FieldByName('OOPEN'), 'OPEN', 86, $008080FF, [fsBold], taRightJustify);
   DataListGrid.Add(cycleListQuery.FieldByName('OCLOSED'), 'CLOSED', 86, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(cycleListQuery.FieldByName('OCANCELLED'), 'CANCELLED', 86, clBlack, [fsBold], taRightJustify);
   DataListGrid.OnDblClick := HandleDoubleClick;
   //
	dbNavTool.Init ( cycleListQuery);
   //
   SortByComboBox.Clear;
   SortByComboBox.Items.Add('CYCLE');
   SortByComboBox.Items.Add('ORG');
   SortByComboBox.Items.Add('START DATE');
   SortByComboBox.Items.Add('END DATE');
   SortByComboBox.ItemIndex := 0;
   //
   UpdateCycleComboBox();
   //
   // Must be LAST
   UpdateCycleQuery();
end;

destructor tCycleListForm.Destroy;
begin
	cycleListQuery.Close();
   freeAndNil(cycleListQuery);
   FreeAndNil(CycleQuery);
   //
	inherited;
end;

// ################################################################################### //

function tCycleListForm.Check_CanCreate: boolean;
var
	errMsg : string;
begin
	errMsg := '';
   //
   if ( Org_GetOrgCount = 0 ) then
   	errMsg := 'You must first create a Sales Organization.';
   //
   if ( errMsg <> '' ) then
   	AvoBaseDialog('Unable To Proceed', errMsg, mtError, [mbOk], 0);
   //
   result := ( errMsg = '');
end;

// ################################################################################### //

procedure tCycleListForm.CycleEdit;
var
	errRec : tErrorResult;
begin
	if ( cycleListQuery.RecordCount <> 0 ) then
   begin
      errRec := CycleQuery.Load( cycleListQuery.FieldByName('ID').AsString );
      if NOT (errRec.errorResult) then
      begin
         CycleQuery.Edit();
         frmCycleEdit := tCycleEditForm.Create( Application, 'Edit Cycle', true, CycleQuery);
   //      CycleQuery.SetFieldByName('ORG_ID', cycleListQuery.FieldByName('ORG_ID').AsString);
         frmCycleEdit.IsNew := false;
         frmCycleEdit.StartUpForm();
         try
            frmCycleEdit.ShowModal();
            if ( frmCycleEdit.CloseAction = actionSave ) then
            begin
               Recalculate( cycleListQuery.FieldByName('ID').AsString );
               if Assigned( fCycleRefreshEvent ) then
                  fCycleRefreshEvent();
            end;
         finally
            // DO NOT FREE!!! FreeAndNil(frmCycleEdit);
         end;
       end else
         Error_Log( errRec, true);
	end;
end;

// ################################################################################### //

procedure tCycleListForm.CycleGenerate;
begin
   ShowMessage('CycleGenerate');
end;

// ################################################################################### //

{ RIBBON New Cycle Pressed }
procedure tCycleListForm.CycleNew;
var
	errRec : tErrorResult;
   dateRec : tDateRecord;
   id : string;
begin
	if ( Check_CanCreate ) then
   begin
      errRec := CycleQuery.Append();
      id := CycleQuery.GetFieldByName('ID').AsString;
      if NOT (errRec.errorResult) then
      begin
         dateREc := Date_GetDateRecord(NOW);
         CycleQuery.Edit();
         CycleQuery.SetFieldByName('SDATE', Now);
         CycleQuery.SetFieldByName('EDATE', Now);
         CycleQuery.SetFieldByName('NUM', 1);
         CycleQuery.SetFieldByName('CYEAR', dateRec.fYear);
         CycleQuery.SetFieldByName('ISACTIVE', True);
         CycleQuery.SetFieldByName('ORG_ID', Org_GetFirstActiveOrg);
         //
         frmCycleEdit := tCycleEditForm.Create( Application, 'Edit Cycle', true, CycleQuery);
         frmCycleEdit.IsNew := true;
         frmCycleEdit.StartUpForm();
         try
            frmCycleEdit.ShowModal();
            if ( frmCycleEdit.CloseAction = actionSave ) then
            begin
               Recalculate( id );
               if Assigned( fCycleRefreshEvent ) then
                  fCycleRefreshEvent();
            end;
         finally
            //FreeAndNil(frmCycleEdit);
         end;
       end else
         Error_Log( errRec, true);
    end;
end;

// ################################################################################### //

procedure tCycleListForm.CycleReports;
begin

   ShowMessage('CycleReports');
end;

// ################################################################################### //

procedure tCycleListForm.CycleView;
begin
   ShowMessage('CycleView');

end;

// ################################################################################### //

procedure tCycleListForm.CycleViewOrders;
var
	errRec : tErrorResult;
begin
	if ( cycleListQuery.RecordCount <> 0 ) then
   begin
      if ( Cycle_GetTotalOrdersByCycleID( cycleListQuery.FieldByName('ID').AsString ) <> 0 ) then
      begin
         errRec := CycleQuery.Load( cycleListQuery.FieldByName('ID').AsString );
         if NOT (errRec.errorResult) then
         begin
            frmCycleView := TCycleViewOrderListForm.Create( Application, 'Cycle Orders', true, CycleQuery);
            frmCycleView.OnLoadOrderEvent := Self.HandleOnLoadOrderEvent;
            frmCycleView.onViewOrderEvent := Self.HandleOnViewInvoiceEvent;
            try
               frmCycleView.ShowModal();
            finally
               //FreeAndNil(frmCycleView);
            end;
         end else
         Error_Log( errRec, true);
      end else
         AvoBaseDialog('No Orders Found', 'There are no Orders found in that Sales Cycle.', mtInformation, [mbok], 0)
   end;
end;

// ################################################################################### //

procedure tCycleListForm.EventUpdateQuery(Sender: TObject);
begin
	UpdateCycleQuery();
end;

function tCycleListForm.fGetCycleRecCount: integer;
begin
	result := ( cycleListQuery.RecordCount );
end;

procedure tCycleListForm.GlobalRefreshEvent;
var
   findID : string;
begin
   findID := cycleListQuery.FieldByName('ID').AsString;
   cycleListQuery.Close();
   cycleListQuery.Open();
   cycleListQuery.Locate('ID', findID, [loCaseInsensitive]);
end;

// ################################################################################### //

procedure tCycleListForm.HandleDoubleClick(sender: tObject);
begin
   CycleEdit();
end;

procedure tCycleListForm.HandleOnLoadOrderEvent(sender: tObject; inOrderID: string);
begin
	if Assigned(fLoadOrderEvent) then
   	fLoadOrderEvent( self, inOrderID );
end;

procedure tCycleListForm.HandleOnViewInvoiceEvent(sender: tobject; inorderid: string);
begin
   if assigned( fViewInvoiceEvent ) then
      fViewInvoiceEvent( self, inorderid );
end;

// ################################################################################### //

procedure TCycleListForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(cycleListQuery.RecNo) + ' of ' + IntToStr(cycleListQuery.RecordCount);
end;

procedure tCycleListForm.SortComboBoxChange(Sender: TObject);
begin
   UpdateCycleQuery();
end;

// ################################################################################### //

procedure tCycleListForm.Recalculate( inID : string );
begin
   cycleListQuery.Close();
   cycleListQuery.Open();
   cycleListQuery.Locate('ID', inID, [loCaseInsensitive]);
end;

// ################################################################################### //

procedure tCycleListForm.UpdateCycleComboBox;
begin
   Org_ComboBox_FillActiveOrgs( 'ALL', orgComboBox);
end;

// ################################################################################### //

procedure tCycleListForm.UpdateCycleQuery;
var
	sortDir : string;
   sortType : tSortCycleTypes;
begin
	if (SortViewComboBox.ItemIndex = 1) then
      cycleListQuery.SortDir := ''
   else
      cycleListQuery.SortDir := 'DESC';
   //
   case SortByComboBox.ItemIndex of
      0 :
      begin
         cycleListQuery.SortField := 'CNAME';
      end;
      1 :
      begin
         cycleListQuery.SortField := 'ORG_ID';
      end;
      2 :
      begin
         cycleListQuery.SortField := 'SDATE';
      end;
      3 :
      begin
         cycleListQuery.SortField := 'EDATE';
      end;
   end;
   //
   //
   if ( orgComboBox.Text = 'ALL' ) then
      cycleListQuery.SortOrgID := ''
   else
      cycleListQuery.SortOrgID := Org_GetOrgIDByOrgName( orgComboBox.Text );
   //
   cycleListQuery.Update();
end;

// ################################################################################### //

{
         retVal := masterData.AddTable(masterData.dbPath + table_cycle,
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NUM INTEGER, ' + // Cycle Number
            'CYEAR INTEGER, ' + // Cycle Year
            'IMSG BLOB(240, 1), ' + // specific invoice message for cycle
            'SDATE DATE, ' + // start date
            'EDATE DATE ',  // end date

}
end.

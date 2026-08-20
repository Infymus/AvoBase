 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Customer_NoteListFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   masterdata_BaseDataClassUnit,
   toolbox_PreferenceToolBoxUnit,
   toolbox_cycletoolboxunit,
   toolbox_orgtoolboxunit,
   AvoBase_HelpFormUnit,
   MasterData_CustomerNoteListUnit,
   MasterData_NavigationToolUnit,
   MasterData_BaseGridUnit,
   AvoBase_ToolBarUnit,
   Toolbox_CustomerToolBoxUnit,
   AvoBase_TextEditorFormUnit,
   DB,
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
   ToolWin;

type
   tCustomer_NoteListForm = class(tForm)
    BASEFORM_DOCK: TPanel;
    BASEFORM_BACK_PANEL: TPanel;
    BASE_FORM_TOP_PANEL: TPanel;
    BASE_FORM_CAPTION_LABEL: TLabel;
    BASE_LABEL_SEP_PANEL: TPanel;
    menu_dock_panel: TPanel;
    LIST_PANEL: TPanel;
    StatusBar: TStatusBar;
    right_back_panel: TPanel;
    Panel2: TPanel;
    EDIT_PANEL: TPanel;
    top_edit_panel: TPanel;
    db_NDESC: TLabeledEdit;
    db_date: TDateTimePicker;
    Label1: TLabel;
   private
      toolBar : tAvoBaseToolBar;
      custNoteListQuery : tMasterDataCustNoteListQuery;
      dbNavTool : tAvoBaseDBNavigationTool;
   	fCustNoteQuery : tMasterData_BaseDataClass;
      dataListGrid : tAvoBaseDBGrid;
      gridDataSource : tDataSource;
   	actionList : tAvoActionList;
      noteEditor : tAvoBaseTextEditor;
      fBorder : boolean;
      fCustID : string;
      //
      procedure fSetBorder( inVal : boolean );
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure HandleGridUpdateData(Sender: TObject; Field: TField);
      function fGetBorder : boolean;
      procedure PutEditFormData;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      function fGetID : string;
      procedure Recalculate( inID : string );
   public
      procedure LoadCustomer( inCustID : string );
      procedure New();
      procedure Edit();
      procedure Cancel();
      procedure Save();
      procedure Delete();
      function CanSave : boolean;
      //
      property ShowBorder : boolean read fGetBorder write fSetBorder;
      property ID : string read fGetID;
      //
      constructor Create( owner: TComponent; inDockPanel : tPanel; inCustID : string); virtual;
      destructor Destroy; override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tCustomer_NoteListForm.Create( owner: TComponent; inDockPanel : tPanel;  inCustID : string);
begin
	inherited create( owner );
   //
   ShowBorder := True;
   //
   fCustID := inCustID;
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   fCustNoteQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_CustomerNotes);
   //
   BASE_FORM_CAPTION_LABEL.Caption := 'Customer Notes For ' + Customer_GetCustomerNameByCustID( fCustID );
   //
   custNoteListQuery := tMasterDataCustNoteListQuery.Create( masterData, fCustID );
   //
   gridDataSource := tDataSource.Create(nil);
   gridDataSource.DataSet := custNoteListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //

   dataListGrid := tAvoBaseDBGrid.Create( nil, LIST_PANEL );
   DataListGrid.Init( custNoteListQuery, '' );
   DataListGrid.Clear;
   DataListGrid.Add(custNoteListQuery.FieldByName('NDATE'), 'DATE', 80, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(custNoteListQuery.FieldByName('NDESC'), 'DESCRIPTION', 230, clRed, [fsBold], taLeftJustify);
//   DataListGrid.OnDblClick := HandleDoubleClick;
   DataListGrid.DataSource.OnDataChange := HandleGridUpdateData;
   //
   dbNavTool := tAvoBaseDBNavigationTool.Create( Application, MENU_DOCK_PANEL );
   dbNavTool.Align := alRight;
   dbNavTool.Init( custNoteListQuery );
   //
   noteEditor := tAvoBaseTextEditor.Create(nil, EDIT_PANEL);
   //
   toolBar := tAvoBaseToolBar.Create( menu_dock_panel );
   toolBar.actionList.OnUpdate := HandleActionListUpdate;
   toolBar.actionList.onActionEvent := HandleActionExecute;
   toolBar.Align := alClient;
   toolbar.CreateButton( CMD_CLOSE );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_HELP );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_DELETE );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_CANCEL);
   toolBar.CreateButton( CMD_SAVE );
   toolBar.CreateButtonSep();
   toolBar.CreateButton( CMD_EDIT);
   toolBar.CreateButton( CMD_NEW);
   //
   custNoteListQuery.Update();
   //
   if ( inDockPanel <> NIL ) then
      with Self do
      begin
         ManualDock(inDockPanel, nil, alClient);
         BorderStyle := bsNone;
//         Left := (Self.Width - inDockPanel.Width) div 2;
//         Top := (Self.Height - inDockPanel.Height) div 2;
         WindowState := wsMaximized;
         Anchors := [AkLeft,AkTop,AkRight,AkBottom];
         BorderIcons := [];
         Position := poDefault;
         Align := alClient;
         //BASE_FORM_TOP_PANEL.Visible := false;
         Show();
      end;
end;

destructor tCustomer_NoteListForm.Destroy;
begin
	custNoteListQuery.Close();
   FreeAndNil(custNoteListQuery);
   FreeAndNil(gridDataSource);
   FreeAndNil(toolBar);
   FreeAndNil(noteEditor);
   //
	inherited
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tCustomer_NoteListForm.fGetBorder: boolean;
begin
   result := fBorder;
end;

function tCustomer_NoteListForm.fGetID: string;
begin
   result := custNoteListQuery.FieldByName('ID').AsString;
end;

procedure tCustomer_NoteListForm.fSetBorder(inVal: boolean);
begin
   fBorder := inVal;
   if ( fBorder) then
      self.BASEFORM_DOCK.BorderWidth := 1
   else
      self.BASEFORM_DOCK.BorderWidth := 0;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomer_NoteListForm.HandleActionExecute(sender: tObject;
  actionID: integer);
begin
   case actionID of
      CMD_NEW : New();
      CMD_SAVE : Save();
      CMD_HELP : AvoBaseHelp_Execute('CustomerNoteEdit');
      CMD_EDIT : Edit();
      CMD_CANCEL : Cancel();
      CMD_DELETE : Delete();
      CMD_CLOSE : Close();
   end;
end;

procedure tCustomer_NoteListForm.HandleActionListUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
   with Action as tAction do
      case action.Tag of
         CMD_SAVE,CMD_CANCEL : Enabled := ( fCustNoteQuery.State in [dsEdit, dsInsert]);
         CMD_NEW,CMD_CLOSE : Enabled := ( fCustNoteQuery.State in [dsBrowse] );
         CMD_EDIT, CMD_DELETE : Enabled := ( fCustNoteQuery.State in [dsBrowse]) AND ( custNoteListQuery.RecordCount <> 0);
      end;
   if ( fCustNoteQuery.State in [dsEdit, dsInsert] ) then
   begin
      dataListGrid.Enabled := false;
      db_NDESC.ReadOnly := false;
      noteEditor.Readonly := false;
      db_date.Enabled := true;
   end else
      begin
         db_date.enabled := false;
         dataListGrid.Enabled := true;
         db_NDESC.ReadOnly := True;
         noteEditor.Readonly := true;
      end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomer_NoteListForm.HandleGridUpdateData(Sender: TObject;
  Field: TField);
begin
   PutEditFormData();
end;

procedure tCustomer_NoteListForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(custNoteListQuery.RecNo) + ' of ' + IntToStr(custNoteListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomer_NoteListForm.LoadCustomer(inCustID: string);
begin
   custNoteListQuery.Load( inCustID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tCustomer_NoteListForm.CanSave: boolean;
var
   errMsg : string;
begin
   errMsg := '';
   //
   if ( db_NDESC.Text = '' ) then
      errMsg := 'Note Name or Descriptiony cannot be blank.';
   if ( noteEditor.Text = '' ) then
      errMsg := 'Note Text cannot be blank.';
   //
   if ( errMsg <> '' ) then
      AvoBaseDialog('Unable to Save', errMsg, mtError, [mbok], 0);
   result := ( errMsg = '');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomer_NoteListForm.PutEditFormData;
begin
   noteEditor.Text := custNoteListQuery.FieldByName('CNOTE').AsString;
   db_NDESC.Text := custNoteListQuery.FieldByname('NDESC').AsString;
   db_date.Date := custNoteListQuery.FieldByname('NDATE').AsDateTime;
   noteEditor.ReadOnly := true;
end;

procedure tCustomer_NoteListForm.Recalculate(inID: string);
begin
   custNoteListQuery.Update();
   custNoteListQuery.Locate('ID', inID, [loCaseInsensitive]);
   PutEditFormData();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomer_NoteListForm.Save;
var
   custID : string;
begin
   if ( CanSave ) then
   begin
      fCustNoteQuery.SetFieldByName('C_ID', fCustID);
      fCustNoteQuery.SetFieldByName('NDATE', db_date.Date);
      fCustNoteQuery.SetFieldByName('NDESC', db_NDESC.Text);
      fCustNoteQuery.SetFieldByName('CNOTE', noteEditor.Text);
      custID := fCustNoteQuery.GetFieldByName('ID').AsString;
      fCustNoteQuery.Post();
      Recalculate( custID );
      dataListGrid.Repaint;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomer_NoteListForm.Edit;
begin
   fCustNoteQuery.Load( ID );
   fCustNoteQuery.Edit;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomer_NoteListForm.New;
begin
   fCustNoteQuery.Append();
   db_date.Date := now;
   db_ndesc.Text := '';
   noteEditor.Text := '';
   db_ndesc.enabled := true;
   db_ndesc.SetFocus();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomer_NoteListForm.Cancel;
begin
   if AvoBaseDialog('Cancel Note Changes', 'Are you sure you want to Cancel changes to this Note?',
      mtConfirmation, [mbYes, mbNo], 0) = mbyes then
   begin
      fCustNoteQuery.Cancel();
      PutEditFormData();
      dataListGrid.Repaint;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tCustomer_NoteListForm.Delete;
begin
   if AvoBaseDialog('Delete Note', 'Are you sure you want to Delete this Note?',
      mtConfirmation, [mbYes, mbNo], 0) = mbyes then
   begin
      custNoteListQuery.Delete();
      Recalculate('');
   end;
end;



end.




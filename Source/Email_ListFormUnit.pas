 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Email_ListFormUnit;

interface uses
   toolboxunit,
   constantsunit,
   masterdataunit,
   inifileunit,
   img_storageformunit,
   errorresultunit,
   actionunit,
   masterdata_basegridunit,
   AvoBase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   masterdata_navigationtoolunit,
   masterdata_BaseDataClassUnit,
   MasterData_EmailListUnit,
   Avobase_BaseForm_ListUnit,
   toolbox_cycletoolboxunit,
   toolbox_orgtoolboxunit,
   toolbox_emailtoolboxunit,
   Toolbox_OrderToolBoxUnit,
   Toolbox_PreferenceToolBoxUnit,
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
  TEmailListForm = class(TAvobase_BaseForm_List)
    Label4: TLabel;
    SortViewComboBox: TComboBox;
    Label3: TLabel;
    SortByComboBox: TComboBox;
    db_ShowDeleted: TCheckBox;
    procedure db_ShowDeletedClick(Sender: TObject);
    procedure SortByComboBoxChange(Sender: TObject);
    procedure SortViewComboBoxChange(Sender: TObject);
   private
      EmailQuery : tMasterData_BaseDataClass;
      emailListQuery : tMasterDataEmailList;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
      procedure UpdateQuery();
      //
      function fGetID : string;
      function fGetFname : string;
      function fGetC_ID : string;
      function fGetORDER_ID : string;
      function fGetEmailCount : integer;
      function fGetStatus : tEmailStatusTypes;
   public
      procedure UpdateEmailEvent();
      procedure Requeue();
      procedure RequeueAll();
      procedure GlobalRefreshEvent();
      procedure SetStatus(inID: string; inStatus: tEmailStatusTypes);
      //
      property ID : string read fGetID;
      property Fname : string read fGetFname;
      property C_ID : string read fGetC_ID;
      property Order_ID : string read fGetORDER_ID;
      property EmailCount : integer read fGetEmailCount;
      property Status : tEmailStatusTypes read fGetStatus;
      //
      constructor Create(owner : tComponent);  overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

{

   tEmailStatusTypes = ( EmailPending = 1, EmailSent = 2, EmailFailed = 3, EmailError = 4 );
   tEmailTypes = ( EmailTypeOrder = 1 );

         retVal := masterData.AddTable(masterData.dbPath + table_email,
            'ID VARCHAR(40), ' +
            'FNAME VARCHAR(80), ' + // filename
            'C_ID VARCHAR(40), ' + // customer_id
            'ORDER_ID VARCHAR(40), ' + // order_id
            'ETIME TIME, ' + // queued time
            'EDATE DATE, ' + // queued date
            'SDATE DATE, ' + // date sent
            'STIME TIME, ' + // time sent
            'ETYPE INTEGER, ' + // email type - see tEmailTypes
            'STATUS INTEGER, ' + // email status - see tEmailStatusTypes
            'RET INTEGER, ' + // retries
            'DESCR VARCHAR(40)',
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TEmailListForm.db_ShowDeletedClick(Sender: TObject);
begin
   UpdateQuery();
end;

constructor TEmailListForm.create(owner : TComponent);
begin
	inherited create( NIL, 'Cycles', false, True);
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   emailListQuery := tMasterDataEmailList.Create( masterData);
   emailListQuery.RequestLive := True;
   //
   EmailQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Email );
   //
   gridDataSource.DataSet := emailListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   DataListGrid.Init( emailListQuery, 'ORG' );
   DataListGrid.Clear;
   DataListGrid.Add(emailListQuery.FieldByName('EDATE'), 'QUEUED', 90, clBlack, [fsBold], taLeftJustify);
   DataListGrid.Add(emailListQuery.FieldByName('SENT'), 'SENT', 90, clBlack, [fsBold], taLeftJustify);
   DataListGrid.Add(emailListQuery.FieldByName('ONUM'), 'ORDER #', 60, clBlack, [fsBold], taRightjustify);
   DataListGrid.Add(emailListQuery.FieldByName('CUSTNAME'), 'CUSTOMER', 120, clBlack, [fsBold], taLeftJustify);
   DataListGrid.Add(emailListQuery.FieldByName('RET'), 'RETRIES', 60, clBlack, [fsBold], taRightjustify);
   DataListGrid.Add(emailListQuery.FieldByName('STAT'), 'STATUS', 90, clBlack, [fsBold], taRightjustify);
   //
	dbNavTool.Init ( emailListQuery);
   //
   SortByComboBox.Clear();
   SortByComboBox.Items.Add('DATE');
   SortByComboBox.Items.Add('STATUS');
   SortByComboBox.ItemIndex := 0;
   //
   UpdateQuery();
end;

// ################################################################################### //

destructor TEmailListForm.Destroy;
begin
	emailListQuery.Close();
   freeAndNil(emailListQuery);
   FreeAndNil(EmailQuery);
   //
	inherited;
end;

// ################################################################################### //

function TEmailListForm.fGetC_ID: string;
begin
   result := emailListQuery.FieldByName('C_ID').AsString;
end;

// ################################################################################### //

function TEmailListForm.fGetEmailCount: integer;
begin
   result := emailListQuery.RecordCount;
end;

// ################################################################################### //

function TEmailListForm.fGetFname: string;
begin
   result := emailListQuery.FieldByName('FNAME').AsString;
end;

// ################################################################################### //

function TEmailListForm.fGetID: string;
begin
   result := emailListQuery.FieldByName('ID').AsString;
end;

// ################################################################################### //

function TEmailListForm.fGetORDER_ID: string;
begin
   result := emailListQuery.FieldByName('ORDER_ID').AsString;
end;

// ################################################################################### //

function TEmailListForm.fGetStatus: tEmailStatusTypes;
begin
   case emailListQuery.FieldByName('STATUS').AsInteger of
      integer(EmailPending) : result := EmailPending;
      integer(EmailSent) : result := EmailSent;
      integer(EmailFailed) : result := EmailFailed;
      integer(EmailError) : result := EmailError;
      integer(EmailDeleted) : result := EmailDeleted;
   end;
end;


// ################################################################################### //

procedure TEmailListForm.GlobalRefreshEvent;
begin
   UpdateQuery();
end;

// ################################################################################### //

procedure TEmailListForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatusBar.Panels[0].Text := IntToStr(emailListQuery.RecNo) + ' of ' + IntToStr(emailListQuery.RecordCount);
end;

// ################################################################################### //

procedure TEmailListForm.Requeue;
begin
   Email_RequeueEmailByID(emailListQuery.FieldByName('ID').AsString);
   UpdateEmailEvent();
end;

// ################################################################################### //

procedure TEmailListForm.RequeueAll;
begin
   emailListQuery.First();
   repeat
      Email_RequeueEmailByID(emailListQuery.FieldByName('ID').AsString);
      emailListQuery.Next();
   until emailListQuery.Eof;
   UpdateEmailEvent();
end;

// ################################################################################### //

procedure TEmailListForm.SetStatus(inID: string; inStatus: tEmailStatusTypes);
begin
   Email_SetStatus( inID, inStatus );
   UpdateQuery();
end;

procedure TEmailListForm.SortByComboBoxChange(Sender: TObject);
begin
   UpdateQuery();
end;

procedure TEmailListForm.SortViewComboBoxChange(Sender: TObject);
begin
   UpdateQuery();
end;

// ################################################################################### //

procedure TEmailListForm.UpdateQuery;
var
	sortDir : string;
   sortType : tSortCycleTypes;
   ID : string;
begin
   emailListQuery.ShowDeleted := db_ShowDeleted.Checked;
   //
   if ( SortViewComboBox.ItemIndex = 0 ) then
      emailListQuery.SortDir := 'DESC'
   else
      emailListQuery.SortDir := '';
   //
   case SortByComboBox.ItemIndex of
      0 : emailListQuery.SortField := 'EDATE';
      1 : emailListQuery.SortField := 'STATUS';
   end;
   //
   ID := emailListQuery.FieldByName('ID').AsString;
   emailListQuery.Update();
   emailListQuery.Locate('ID', ID, [loCaseInsensitive]);
end;

// ################################################################################### //

procedure TEmailListForm.UpdateEmailEvent;
begin
   //
   UpdateQuery();
end;

// ################################################################################### //

end.

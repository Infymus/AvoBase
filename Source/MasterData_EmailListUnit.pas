 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_EmailListUnit;

interface uses
	sysutils,
   classes,
   constantsunit,
   toolboxunit,
   db,
   dbtables,
   recordstructureunit,
   bde,
   dateutils,
   inifileunit,
   toolbox_ordertoolboxunit,
   toolbox_customertoolboxunit,
   masterdataunit,
   ErrorResultUnit;

type
   tMasterDataEmailList = class(tQuery)
   private
      fShowDeleted : boolean;
      fSortDir : string;
      fSortField : string;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
   	fSQLString : string;
      fMasterData : tMasterData;
      property ShowDeleted : boolean read fShowDeleted write fShowDeleted;
      property SortDir : string read fSortDir write fSortDir;
      property SortField : string read fSortField write fSortField;
      procedure Update();
      constructor Create( inMasterData : tMasterData);  overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataEmailList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
begin
   inherited create(nil);
   self.SessionName := masterData.AvoBaseSession.SessionName;
   fMasterData := inMasterData;
	fSQLString := 'SELECT * FROM ' + fMasterData.GetTable_Email;
   self.SQL.Clear();
   self.SQL.Text := fSQLString;
   errResult := fMasterData.QueryAddFields( self );
   masterData.QueryAddCalculatedField( self, 'ONUM', 15, ftString);
   masterData.QueryAddCalculatedField( self, 'CUSTNAME', 50, ftString);
   masterData.QueryAddCalculatedField( self, 'STAT', 50, ftString);
   masterData.QueryAddCalculatedField( self, 'SENT', 50, ftString);
   self.OnCalcFields := HandleCalculated;
   self.RequestLive := true;
end;
{
   tEmailStatusTypes = ( EmailPending = 1, EmailSent = 2, EmailFailed = 2, EmailError = 3 );
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

procedure tMasterDataEmailList.HandleCalculated(DataSet: TDataSet);
begin
	DataSet.FieldByName('ONUM').Value := Order_GetOrderNumberByOrderID( self.FieldByName('ORDER_ID').AsString );
	DataSet.FieldByName('CUSTNAME').Value := Customer_GetCustomerNameByCustID( self.FieldByName('C_ID').AsString );
   DataSet.FieldByName('SENT').AsString := '';
   case self.FieldByName('STATUS').AsInteger of
      integer(EmailPending): DataSet.FieldByName('STAT').AsString := 'Pending';
      integer(EmailSent):
      begin
         DataSet.FieldByName('STAT').AsString := 'Sent';
         DataSet.FieldByName('SENT').AsString := self.FieldByName('SDATE').AsString;
      end;
      integer(EmailFailed): DataSet.FieldByName('STAT').AsString := 'Failed';
      integer(EmailError): DataSet.FieldByName('STAT').AsString := 'Error';
      integer(EmailDeleted): DataSet.FieldByName('STAT').AsString := 'Deleted';
   end;
end;

procedure tMasterDataEmailList.Update();
var
   sql : string;
begin
	self.Close();
   sql := fSQLString;
   //
   if ( NOT fShowDeleted ) then
      sql := sql + ' WHERE STATUS <> ' + IntToStr(Integer(EmailDeleted));
   //
   if ( fSortField <> '' ) then
   begin
      sql := sql + ' ORDER BY ' + fSortField;
      //
      sql := sql + ' ' + fSortDir;
   end;
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   self.Open();
end;




end.

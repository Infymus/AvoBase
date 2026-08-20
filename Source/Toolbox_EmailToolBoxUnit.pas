 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_EmailToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  inifileunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
  //
  Toolbox_PreferenceToolBoxUnit,
   recordstructureunit,
  Toolbox_OrgToolBoxUnit,
  Toolbox_OrderToolBoxUnit,
  Toolbox_CycleToolBoxUnit,
  db,
  dbtables,
  bde,
  sysutils,
  classes,
  forms,
  dateutils,
  inifiles,
  stdctrls;



function Email_InitEmailRecord : tEmailRec;
function Email_GetEmailSettings : tEmailSettings;
function Email_GetEmailRecord( inID : string ) : tEmailRec;
function Email_CreateOrderEmail( inOrderID, inCustID : string ) : tErrorResult;
function Email_DeleteEmailByID( inID : string ) : tErrorResult;
function Email_DeleteAllEmails : tErrorResult;
function Email_RequeueEmailByID( inID: string ) : tErrorResult;
function Email_ValidateDropDirectory : tErrorResult;
function Email_SetStatus( inID : string; inStatus : tEmailStatusTypes ) : tErrorResult;
function Email_DeleteEmail( inID : string ) : tErrorResult;
function Email_DeleteEmailFile( inID : string ) : tErrorResult;
function Email_SetRetries( inID : string; inRetries : integer ) : tErrorResult;
function Email_DeleteEmailsByStatus( inStatusType : tEmailStatusTypes ) : tErrorResult;
function Email_GetEmailStatusByOrderID( inOrderID : string ) : tEmailRec;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{
         retVal := masterData.AddTable(masterData.dbPath + table_email,
            'ID VARCHAR(40), ' +
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

   tEmailStatusTypes = ( EmailPending = 1, EmailSent = 2, EmailFailed = 2, EmailError = 3 );
   tEmailTypes = ( EmailTypeOrder = 1 );

}

function Email_InitEmailRecord : tEmailRec;
begin
   with result do
   begin
      id := '';
      c_id := '';
      order_id := '';
      etime := now;
      edate := now;
      sdate := now;
      etype := tEmailTypes.EmailTypeOrder;
      status := tEmailStatusTypes.EmailPending;
      ret := 0;
      descr := '';
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_GetEmailSettings : tEmailSettings;
begin
   with result do
   begin
      SMTPS := Pref_GetString(tPrefConstants.SMTPS, '');
      SMTPUSER := Pref_GetString(tPrefConstants.SMTPUSER,'');
      SMTPPW := Pref_GetString(tPrefConstants.SMTPPW,'');
      SMTPF := Pref_GetString(tPrefConstants.SMTPF,'');
      SMTPORT := Pref_GetInteger(tPrefConstants.SMTPORT,0);
      SMTPAUTHTYPE := Pref_GetInteger(tPrefConstants.SMTPAUTHTYPE,0);
      ORDBODY := Pref_GetMemo(tPrefConstants.SMTPORDMSG,'');
      RETBODY := Pref_GetMemo(tPrefConstants.SMTPRETMSG,'');
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_GetEmailRecord( inID : string ) : tEmailRec;
var
	fQuery : tQuery;
begin
   result := Email_InitEmailRecord;
   //
	fQuery := masterData.GetQuery;
   //
   fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Email +
      ' WHERE ID = ' + masterData.WrapDBID(inID);
   fQuery.Open();
   //
   if ( fQuery.RecordCount <> 0 ) then
   begin
      with result do
      begin
         id := fQuery.FieldByName('ID').AsString;
         c_id := fQuery.FieldByName('C_ID').AsString;
         order_id := fQuery.FieldByName('ORDER_ID').AsString;
         etime := fQuery.FieldByName('ETIME').AsDateTime;
         edate := fQuery.FieldByName('edate').AsDateTime;
         sdate := fQuery.FieldByName('sdate').AsDateTime;
         case fQuery.FieldByName('etype').AsInteger of
            integer(EmailTypeOrder) : etype := EmailTypeOrder;
         end;
         case fQuery.FieldByName('status').AsInteger of
            integer(EmailPending) : status := EmailPending;
            integer(EmailSent) : status := EmailSent;
            integer(EmailFailed) : status := EmailFailed;
            integer(EmailError) : status := EmailError;
            integer(EmailDeleted) : status := EmailDeleted;
         end;
         ret := fQuery.FieldByName('ret').AsInteger;
         descr := fQuery.FieldByName('descr').AsString;
      end;
   end;
   //
   fQuery.Close();
   //
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_CreateOrderEmail( inOrderID, inCustID : string ) : tErrorResult;
var
	fQuery : tQuery;
   fID : string;
begin
	fQuery := masterData.GetQuery;
   //
   fID := '';
   fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Email +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0 ) then
      fID := fQuery.FieldByName('ID').AsString;
   fQuery.Close();
   //

   if ( fID <> '' ) then
   begin
      fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Email +
         ' WHERE ID = ' + masterData.WrapDBID( fID );
      fQuery.Open();
      fQuery.Edit();
   end else
      begin
         fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Email;
         fQuery.Open();
         fQuery.Append();
         fQuery.FieldByName('ID').AsString := masterData.NewDBGuid();
      end;
   //
   fQuery.FieldByName('C_ID').AsString := inCustId;
   fQuery.FieldByName('ORDER_ID').AsString := inOrderID;
   fQuery.FieldByName('ETIME').AsDateTime := Now;
   fQuery.FieldByName('EDATE').AsDateTime := Now;
   fQuery.FieldByName('SDATE').AsDateTime := Now;
   //    STIME TIME <-- don't do, it hasn't been sent, we don't want to set it yay ya
   fQuery.FieldByName('ETYPE').AsInteger := integer(tEmailTypes.EmailTypeOrder);
   fQuery.FieldByName('STATUS').AsInteger := integer(tEmailStatusTypes.EmailPending);
   fQuery.FieldByName('RET').AsInteger := 0;
   fQuery.FieldByName('DESCR').AsString := '';
   fQuery.Post();
   //
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_DeleteEmailByID( inID : string ) : tErrorResult;
var
	fQuery : tQuery;
begin
   result := Error_Init;
   //
	fQuery := masterData.GetQuery;
   //
   fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Email +
      ' WHERE ID = ' + masterData.WrapDBID( inID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0 ) then
   begin
      fQuery.Close();
      // now delete it
      fQuery.SQL.Text := 'DELETE FROM ' + masterData.GetTable_Email +
         ' WHERE ID = ' + masterData.WrapDBID( inID );
      fQuery.ExecSQL();
   end else
      begin
         fQuery.Close();
         result.errorResult := true;
         result.errorMessage := 'ID NOT FOUND';
      end;
   //
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_RequeueEmailByID( inID: string ) : tErrorResult;
var
	fQuery : tQuery;
begin
   result := Error_Init;
   //
	fQuery := masterData.GetQuery;
   //
   fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Email +
      ' SET STATUS = ' + IntToStr( integer(EmailPending )) +
      ' WHERE ID = ' + masterData.WrapDBID( inID );
   fQuery.ExecSQL();
   //
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_ValidateDropDirectory : tErrorResult;
var
   emailDir : string;
begin
   result := Error_Init;
   //
   emailDir := Pref_GetEmailDir();
   if NOT DirectoryExists( emailDir ) then
   begin
      try
         if NOT CreateDir( emailDir ) then
         begin
            result.errorResult := true;
            result.errorMessage := 'Unable to create Email Directory ' + emailDir + '.' +
            	'Permissions? Rights? Please create the directory manually.';
         end;
      except
         on E:Exception do
         begin
            result.errorResult := true;
            result.errorMessage := E.Message;
         end;
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_SetStatus( inID : string; inStatus : tEmailStatusTypes ) : tErrorResult;
var
	fQuery : tQuery;
begin
   result := Error_Init;
   //
	fQuery := masterData.GetQuery;
   //
   fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Email +
      ' SET STATUS = ' + IntToStr( integer(inStatus) ) +
      ' WHERE ID = ' + masterData.WrapDBID( inID );
   fQuery.ExecSQL();
   //
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_SetRetries( inID : string; inRetries : integer ) : tErrorResult;
var
	fQuery : tQuery;
begin
   result := Error_Init;
   //
	fQuery := masterData.GetQuery;
   //
   fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Email +
      ' SET RET = ' + IntToStr( inRetries ) +
      ' WHERE ID = ' + masterData.WrapDBID( inID );
   fQuery.ExecSQL();
   //
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_DeleteEmail( inID : string ) : tErrorResult;
var
	fQuery : tQuery;
begin
   result := Error_Init;
   //
	fQuery := masterData.GetQuery;
   //
   fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Email +
      ' SET STATUS = ' + IntToStr ( integer(EmailDeleted) ) +
      ' WHERE ID = ' + masterData.WrapDBID(inID);
   fQuery.ExecSQL();
   //
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_DeleteAllEmails : tErrorResult;
var
	fQuery : tQuery;
begin
   result := Error_Init;
   //
	fQuery := masterData.GetQuery;
   //
   // Delete only means they are marked as deleted. They won't show anymore.
   //
   fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Email +
      ' SET STATUS = ' + IntToStr ( integer(EmailDeleted) ) +
      ' WHERE STATUS = ' + IntToStr( integer(EmailPending) ) +
      ' OR STATUS = ' + IntToStr( integer(EmailFailed) ) +
      ' OR STATUS = ' + IntToStr( integer(EmailFailed ) ) +
      ' OR STATUS = ' + IntToStr( integer(EmailError) );
   fQuery.ExecSQL();
   //
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_DeleteEmailFile( inID : string ) : tErrorResult;
var
   emailDir : string;
   emailFileName : string;
   orgID : string;
	fQuery : tQuery;
begin
   result := Error_Init;
   //
   try
      fQuery := masterData.GetQuery;
      //
      fQuery.SQL.Text := 'SELECT * FROM ' + masterData.GetTable_Email +
         ' WHERE ID = ' + masterData.WrapDBID(inID);
      fQuery.Open();
      //
      if ( fQuery.RecordCount <> 0 ) then
      begin
         emailDir := Pref_GetEmailDir();
         orgID := Order_GetOrgIDByOrderID( fQuery.FieldByName('ORDER_ID').AsString );
         case Order_GetOrderTypeByOrderID( fQuery.FieldByName('ORDER_ID').AsString ) of
            OrdTypeOrder:
            begin
               emailFileName := Org_GetOrgNameByOrgID( orgID ) + 'Invoice' + Order_GetOrderNumberByOrderID( fQuery.FieldByName('ORDER_ID').AsString ) + '.PDF';
               //
               if ( FileExists( emailDir + emailFileName )) then
                  DeleteFile( emailDir + emailFileName );
            end;
            OrdTypeReturn:
            begin
               emailFileName := Org_GetOrgNameByOrgID( orgID ) + 'Return' + Order_GetOrderNumberByOrderID( fQuery.FieldByName('ORDER_ID').AsString ) + '.PDF';
               //
               if ( FileExists( emailDir + emailFileName )) then
                  DeleteFile( emailDir + emailFileName );
            end;
         end;
      end;
   except
      on E:Exception do
      begin
         result.errorResult := true;
         result.errorMessage := E.Message;
      end;
   end;
   //
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_DeleteEmailsByStatus( inStatusType : tEmailStatusTypes ) : tErrorResult;
var
	fQuery : tQuery;
begin
   result := Error_Init;
   //
	fQuery := masterData.GetQuery;
   //
   fQuery.SQL.Text := 'DELETE FROM ' + masterData.GetTable_Email +
      ' WHERE STATUS = ' + IntToStr ( integer(inStatusType) );
   fQuery.ExecSQL();
   //
   FreeAndNil(fQuery);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Email_GetEmailStatusByOrderID( inOrderID : string ) : tEmailRec;
var
	fQuery : tQuery;
   emailRec : tEmailRec;
   id : string;
begin
   id := '';
   result := Email_InitEmailRecord;
   result.status := tEmailStatusTypes.EmailNonExist;
   //
	fQuery := masterData.GetQuery;
   //
   fQuery.SQL.Text := 'SELECT ID, ORDER_ID FROM ' + masterData.GetTable_Email +
      ' WHERE ORDER_ID = ' + masterData.WrapDBID( inOrderID );
   fQuery.Open();
   if ( fQuery.RecordCount <> 0 ) then
      id := fQuery.FieldByName('ID').AsString;
   //
   FreeAndNil(fQuery);
   //
   if ( id <> '' ) then
      result := Email_GetEmailRecord( id );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.



   { 'SMTPS VARCHAR(100), ' + // SMTP Server
     'SMTPUSER VARCHAR(100), ' + // SMTP User
     'SMTPPW VARCHAR(100), ' + // SMTP Password
     'SMTPORT INTEGER, ' + // SMTP Port
     'SMTPAUTHTYPE INTEGER, ' + //    tEmailAuthTypes = ( EmailAuthDefault = 0, EmailAuthSASL = 1, EmailAuthNone = 2 );
     'SMTPF  VARCHAR(100)', ''); // SMTP From Email }


 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_CustomerToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  inifileunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
  recordstructureunit,
  encryptunit,
  //
  db,
  dbtables,
  bde,
  sysutils,
  classes,
  forms,
  dateutils,
  inifiles,
  stdctrls;



function Customer_Initialize_Record : tCustRec;
function Customer_GetCustomerNameByCustID( inCustID : string ) : string;
function Customer_GetCustomerByCustID( inCustID : string ) : tCustRec;
function Customer_GetCustomerByOrderID( InOrderID : string ) : tCustRec;
function Customer_GetCustomerCount : integer;
function Customer_GetEmailByCustID( inCustID : string ) : string;
function Customer_GetCustomerIDByCustomerName( inFirst, inMiddle, inLast : string ) : string;
function Customer_CreateCustomerByCustRec( inCustRec : tCustRec ) : string;
function Customer_GetTotalNoteCountByCustID( inCustID : string ) : integer;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Customer_Initialize_Record : tCustRec;
begin
   with result do
   begin
      ISACTIVE := true;
      FNAME :=  '';
      MNAME :=  '';
      LNAME :=  '';
      FULLNAME := '';
      ADDR1 :=  '';
      ADDR2 :=  '';
      CITY :=  '';
      STATE :=  '';
      ZIP :=  '';
      CITYSTATEZIP := '';
      PHONEH :=  '';
      PHONEC :=  '';
      PHONEW :=  '';
      BDAY :=  Now;
      EMAIL := '';
      TAXE := false;
      TAXEXID := '';
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Customer_GetCustomerByCustID( inCustID : string ) : tCustRec;
var
   fQuery : tQuery;
begin
   result.ID := inCustID;
   result := Customer_Initialize_Record;
   if (inCustID = '') then
      exit;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT * FROM ' + masterData.Gettable_Customer +
         ' WHERE ID = ' + masterData.WrapDBID( inCustID );
      fQuery.Open();
      //
      result.ISACTIVE := fQuery.FieldByName('ISACTIVE').AsBoolean;
      result.FNAME := fQuery.FieldByName('FNAME').AsString;
      result.MNAME := fQuery.FieldByName('MNAME').AsString;
      result.LNAME := fQuery.FieldByName('LNAME').AsString;
      if (fQuery.FieldByName('FNAME').AsString <> '') then
         result.FULLNAME := result.FULLNAME + fQuery.FieldByName('FNAME').AsString;
      if (fQuery.FieldByName('MNAME').AsString <> '') then
         result.FULLNAME := result.FULLNAME + ' ' + fQuery.FieldByName('MNAME').AsString;
      if (fQuery.FieldByName('LNAME').AsString <> '') then
         result.FULLNAME := result.FULLNAME + ' ' + fQuery.FieldByName('LNAME').AsString;
      result.ADDR1 := fQuery.FieldByName('ADDR1').AsString;
      result.ADDR2 := fQuery.FieldByName('ADDR2').AsString;
      result.CITY := fQuery.FieldByName('CITY').AsString;
      result.STATE := fQuery.FieldByName('STATE').AsString;
      result.ZIP := fQuery.FieldByName('ZIP').AsString;
      if (fQuery.FieldByName('CITY').AsString <> '') then
         result.CITYSTATEZIP := fQuery.FieldByName('CITY').AsString;
      if (fQuery.FieldByName('STATE').AsString <> '') then
         result.CITYSTATEZIP := result.CITYSTATEZIP + ', ' + fQuery.FieldByName('STATE').AsString;
      if (fQuery.FieldByName('ZIP').AsString <> '') then
         result.CITYSTATEZIP := result.CITYSTATEZIP + ', ' + fQuery.FieldByName('ZIP').AsString;
      result.PHONEH := fQuery.FieldByName('PHONEH').AsString;
      result.PHONEC := fQuery.FieldByName('PHONEC').AsString;
      result.PHONEW := fQuery.FieldByName('PHONEW').AsString;
      result.BDAY := fQuery.FieldByName('BDAY').AsDateTime;
      result.EMAIL := fQuery.FieldByName('EMAIL').AsString;
      result.TAXE := fQuery.FieldByName('TAXE').AsBoolean;
      result.TAXEXID := fQuery.FieldByName('TAXEXID').AsString;
      //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Customer_GetCustomerNameByCustID( inCustID : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT * FROM ' + masterData.Gettable_Customer +
         ' WHERE ID = ' + masterData.WrapDBID( inCustID );
      fQuery.Open();
      //
      result := fQuery.FieldByName('FNAME').AsString + ' ' +
         fQuery.FieldByName('LNAME').AsString;
      //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


function Customer_GetCustomerByOrderID( InOrderID : string ) : tCustRec;
var
   fQuery : tQuery;
   custID : string;
begin
   result := Customer_Initialize_Record;
   if (InOrderID = '') then
      exit;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, C_STID  FROM ' + masterData.GetTable_Order +
         ' WHERE ID = ' + masterData.WrapDBID( InOrderID );
      fQuery.Open();
      //
      custID := fQuery.FieldByName('C_STID').AsString;
      //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
   if ( custID <> '' ) then
      result := Customer_GetCustomerByCustID( custID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Customer_GetCustomerCount : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.Gettable_Customer;
      fQuery.Open();
      result := fQuery.FieldByName('TOT').AsInteger;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Customer_GetEmailByCustID( inCustID : string ) : string;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, EMAIL FROM ' + masterData.Gettable_Customer +
         ' WHERE ID = ' + masterData.WrapDBID( inCustID );
      fQuery.Open();
      //
      result := fQuery.FieldByName('EMAIL').AsString;
      //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Customer_GetCustomerIDByCustomerName( inFirst, inMiddle, inLast : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID FROM ' + masterData.Gettable_Customer +
         ' WHERE FNAME = ' + masterData.WrapDBID( inFirst ) +
         ' AND  MNAME = ' + masterData.WrapDBID( inMiddle ) +
         ' AND LNAME = ' + masterData.WrapDBID( inLast );
      fQuery.Open();
      //
      if ( fQuery.RecordCount <> 0 ) then
         result := fQuery.FieldByName('ID').AsString;
      //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Customer_CreateCustomerByCustRec( inCustRec : tCustRec ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT * FROM ' + masterData.Gettable_Customer;
      fQuery.Open();
      //
      fQuery.Append();
      result := masterData.NewDBGuid();
      //
      fQuery.FieldByname('ID').AsString := result;
      fQuery.FieldByname('FNAME').AsString := inCustRec.FNAME;
      fQuery.FieldByname('MNAME').AsString := inCustRec.MNAME;
      fQuery.FieldByname('LNAME').AsString := inCustRec.lname;
      fQuery.FieldByname('ADDR1').AsString := inCustRec.ADDR1;
      fQuery.FieldByname('ADDR2').AsString := inCustRec.addr2;
      fQuery.FieldByname('CITY').AsString := inCustRec.city;
      fQuery.FieldByname('STATE').AsString := inCustRec.state;
      fQuery.FieldByname('ZIP').AsString := inCustRec.zip;
      fQuery.FieldByname('PHONEH').AsString := inCustRec.phoneh;
      fQuery.FieldByname('PHONEC').AsString := inCustRec.phonec;
      fQuery.FieldByname('PHONEW').AsString := inCustRec.phonew;
      fQuery.FieldByname('EMAIL').AsString := inCustRec.email;
      fQuery.FieldByname('TAXE').AsBoolean := inCustRec.taxe;
      fQuery.FieldByname('ISACTIVE').AsBoolean := inCustRec.isactive;
      fQuery.FieldByname('BDAY').AsDateTime := inCustRec.bday;
      fQuery.FieldByname('TAXEXID').AsString := inCustRec.TAXEXID;
      //
      fQuery.Post();
      //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Customer_GetTotalNoteCountByCustID( inCustID : string ) : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_CustomerNotes +
         ' WHERE C_ID = ' + masterData.WrapDBID( inCustID );
      fQuery.Open();
      result := fQuery.FieldByName('TOT').AsInteger;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

end.







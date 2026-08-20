 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_OrgToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  inifileunit,
  recordstructureunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
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

function Org_GetOrgNameByOrgID( inOrgID : string ) : string;
function Org_GetOrgCycleNameByID( inOrgID : string ) : string;
function Org_OrgExitsByName( inOrgName : string ) : boolean;
function Org_GetOrgDependantsByOrgID( inOrgID : string ) : boolean;
function Org_GetOrgIDByOrgName( inOrgName : string ) : string;
function Org_GetFirstActiveOrg : string;
function Org_GetOrgInvoiceTitleByOrgID( inOrgID : string ) : string;
function Org_GetProductMaskByOrgID( inOrgID : string ) : string;
function Org_GetOrgCount : integer;
function Org_GetOrgProductSpecialField( inOrgID, inValue : string ) : string;



procedure Org_ComboBox_FillActiveOrgs( VAR inComboBox : tComboBox); overload;
procedure Org_ComboBox_FillActiveOrgs( inTopLevel : string; VAR inComboBox : tComboBox); overload;
procedure Org_ComboBox_FillAllOrgs( VAR inComboBox : tComboBox);
procedure Org_ComboBox_FillActiveOrgs_WithCycles( VAR inComboBox : tComboBox); overload;
procedure Org_ComboBox_FillActiveOrgs_WithCycles( inOrgID : string; VAR inComboBox : tComboBox); overload;
Procedure Org_PutOrgProductSpecialField( inOrgID, inProdN, inValue : string );

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Org_GetOrgNameByOrgID( inOrgID : string ) : string;
var
   fOrgQuery : tMasterData_BaseDataClass;
   dateRec : tDateRecord;
begin
   if ( inOrgID <> '') then
   begin
      if ( inOrgID = 'ALL' ) then
      begin
         result := 'ALL';
         exit;
      end;
      fOrgQuery := tMasterData_BaseDataClass.create(masterData, masterData.GetTable_Org);
      fOrgQuery.Load( inOrgID );
      //
      result := fOrgQuery.GetFieldByName('NAME').AsString;
      //
      fOrgQuery.Close();
      FreeAndNil( fOrgQuery );
   end else
      result := 'Unknown';
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Org_OrgExitsByName( inOrgName : string ) : boolean;
var
   fOrgQuery : tQuery;
begin
	result := false;
   if ( inOrgName <> '') then
   begin
   	inOrgName := ProperCase( inOrgName, true );
   	fOrgQuery := masterData.GetQuery();
      fOrgQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Org +
      	'WHERE NAME = "' + inOrgName + '"';
      fOrgQuery.Open();
      if (fOrgQuery.FieldByName('TOT').AsInteger <> 0) then
      	result := true;
      fOrgQuery.Close();
      //
      FreeAndNil( fOrgQuery );
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// This scans ALL the tables in the database to ensure there isn't anything tied to that org.
function Org_GetOrgDependantsByOrgID( inOrgID : string ) : boolean;
var
	totCount : integer;

   {======================================================================}
   function PerformCheck( inOrgID : string; inTable : string ) : integer;
   var
   	fOrgQuery : tQuery;
   begin
   	fOrgQuery := masterData.GetQuery();
      try
         fOrgQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + inTable + ' WHERE ORG_ID = "' + inOrgID + '"';
         fOrgQuery.Open();
         result := fOrgQuery.FieldByName('TOT').AsInteger;
         fOrgQuery.Close();
      finally
      	FreeAndNil(fOrgQuery);
      end;
   end;
   {======================================================================}

begin
   totCount := 0;
   if ( inOrgID <> '') then
   begin

      //----------------------------------------
      // Orders
      totCount := totCount + PerformCheck( inOrgID, masterData.GetTable_Order);

      //----------------------------------------
      // Method Of Payment

      //----------------------------------------
      // Credits

      //----------------------------------------
      // Expenses

      //----------------------------------------
      // Brochures

      //----------------------------------------
      // Cycles
      totCount := totCount + PerformCheck( inOrgID, masterData.GetTable_Cycle);

      //
   end;
   result := (totCount <> 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Org_ComboBox_FillActiveOrgs( VAR inComboBox : tComboBox);
var
   fQuery : tQuery;
begin
   inComboBox.Items.Clear;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT NAME, ISACTIVE FROM ' + masterData.GetTable_Org + ' ORDER BY NAME';
      fQuery.Open();
      //
      repeat
         if (fQuery.FieldByName('ISACTIVE').AsBoolean) then
            inComboBox.Items.Add(fQuery.FieldByName('NAME').AsString);
         fQuery.Next();
      until fQuery.Eof;
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
   if ( inComboBox.Items.Count <> 0) then
      inComboBox.ItemIndex := 0;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Org_ComboBox_FillActiveOrgs( inTopLevel : string; VAR inComboBox : tComboBox);
var
   fQuery : tQuery;
begin
   inComboBox.Items.Clear;
   inComboBox.Items.Add( inTopLevel );
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT NAME, ISACTIVE FROM ' + masterData.GetTable_Org + ' ORDER BY NAME';
      fQuery.Open();
      //
      repeat
         if (fQuery.FieldByName('ISACTIVE').AsBoolean) then
            inComboBox.Items.Add(fQuery.FieldByName('NAME').AsString);
         fQuery.Next();
      until fQuery.Eof;
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
   if ( inComboBox.Items.Count <> 0) then
      inComboBox.ItemIndex := 0;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Org_ComboBox_FillAllOrgs( VAR inComboBox : tComboBox);
var
   fQuery : tQuery;
begin
   inComboBox.Items.Clear;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT NAME FROM ' + masterData.GetTable_Org + ' ORDER BY NAME';
      fQuery.Open();
      //
      repeat
         inComboBox.Items.Add(fQuery.FieldByName('NAME').AsString);
         fQuery.Next();
      until fQuery.Eof;
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
   if ( inComboBox.Items.Count <> 0) then
      inComboBox.ItemIndex := 0;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Org_GetOrgIDByOrgName( inOrgName : string ) : string;
var
   fQuery : tQuery;
begin
   result := '?';
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, NAME FROM ' + masterData.GetTable_Org + ' WHERE NAME = "' + InOrgName + '"';
      fQuery.Open();
      if (fQuery.RecordCount <> 0) then
         result := fQuery.FieldByName('ID').AsString;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Org_GetFirstActiveOrg : string;
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID FROM ' + masterData.GetTable_Org;
      fQuery.Open();
      result := fQuery.FieldByName('ID').AsString;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Org_GetOrgInvoiceTitleByOrgID( inOrgID : string ) : string;
var
   fOrgQuery : tMasterData_BaseDataClass;
   dateRec : tDateRecord;
begin
   if ( inOrgID <> '') then
   begin
      fOrgQuery := tMasterData_BaseDataClass.create(masterData, masterData.GetTable_Org);
      fOrgQuery.Load( inOrgID );
      //
      result := fOrgQuery.GetFieldByName('IHEADD').AsString;
      //
      fOrgQuery.Close();
      FreeAndNil( fOrgQuery );
   end else
      result := 'Unknown';
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function org_GetProductMaskByOrgID( inOrgID : string ) : string;
var
   fQuery : tQuery;
begin
   result := ''; // we are not using this for now.
   {
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, PRODFMT FROM ' + masterData.GetTable_Org +
         ' WHERE ID = ' + masterData.WrapDBID( inOrgID );
      fQuery.Open();
      result := fQuery.FieldByName('PRODFMT').AsString;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
   }
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Org_ComboBox_FillActiveOrgs_WithCycles( VAR inComboBox : tComboBox);
var
   fQuery : tQuery;
begin
   inComboBox.Items.Clear;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT DISTINCT O.ISACTIVE, O.ID, O.NAME, C.ORG_ID   ' +
         ' FROM ' + masterData.GetTable_Org + ' AS O, ' + masterData.GetTable_Cycle + ' AS C' +
         ' WHERE C.ORG_ID = O.ID AND ISACTIVE = TRUE';
      fQuery.Open();
      //
      repeat
         inComboBox.Items.Add(fQuery.FieldByName('NAME').AsString);
         fQuery.Next();
      until fQuery.Eof;
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
   if ( inComboBox.Items.Count <> 0) then
      inComboBox.ItemIndex := 0;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure Org_ComboBox_FillActiveOrgs_WithCycles( inOrgID : string; VAR inComboBox : tComboBox); overload;
var
   fQuery : tQuery;
begin
   inComboBox.Items.Clear;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT DISTINCT O.ISACTIVE, O.ID, O.NAME, C.ORG_ID   ' +
         ' FROM ' + masterData.GetTable_Org + ' AS O, ' + masterData.GetTable_Cycle + ' AS C' +
         ' WHERE C.ORG_ID = O.ID AND ISACTIVE = TRUE AND O.ID = ' + masterData.WrapDBID( inOrgID );
      fQuery.Open();
      //
      repeat
         inComboBox.Items.Add(fQuery.FieldByName('NAME').AsString);
         fQuery.Next();
      until fQuery.Eof;
       //
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
   if ( inComboBox.Items.Count <> 0) then
      inComboBox.ItemIndex := 0;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Org_GetOrgCount : integer;
var
   fQuery : tQuery;
begin
   result := 0;
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Org;
      fQuery.Open();
      result := fQuery.FieldByName('TOT').AsInteger;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Org_GetOrgProductSpecialField( inOrgID, inValue : string ) : string;
var
   fQuery : tQuery;
begin
   result := '';
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'SELECT ID, PRODN1, PRODN2, PRODN3, PRODN4 FROM ' + masterData.GetTable_Org +
         ' WHERE ID = "' + inOrgID + '"';
      fQuery.Open();
      if (fQuery.RecordCount <> 0) then
      begin
         if ( inValue = 'PRODN1' ) then
            result := fQuery.FieldByName('PRODN1').AsString;
         if ( inValue = 'PRODN2' ) then
            result := fQuery.FieldByName('PRODN2').AsString;
         if ( inValue = 'PRODN3' ) then
            result := fQuery.FieldByName('PRODN3').AsString;
         if ( inValue = 'PRODN4' ) then
            result := fQuery.FieldByName('PRODN4').AsString;
      end;
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Org_GetOrgCycleNameByID( inOrgID : string ) : string;
var
   fOrgQuery : tMasterData_BaseDataClass;
   dateRec : tDateRecord;
begin
   if ( inOrgID <> '') then
   begin
      fOrgQuery := tMasterData_BaseDataClass.create(masterData, masterData.GetTable_Org);
      fOrgQuery.Load( inOrgID );
      //
      if ( fOrgQuery.GetFieldByName('CNAME').AsString = '' ) then
         result := 'Sales Cycle'
      else
         result := fOrgQuery.GetFieldByName('CNAME').AsString;
      //
      fOrgQuery.Close();
      FreeAndNil( fOrgQuery );
   end else
      result := 'Sales Cycle';
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

Procedure Org_PutOrgProductSpecialField( inOrgID, inProdN, inValue : string );
var
   fQuery : tQuery;
begin
   fQuery := masterData.GetQuery();
   try
      fQuery.SQL.Text := 'UPDATE ' + masterData.GetTable_Org + ' SET ' + inProdN + ' = "' + inValue + '" WHERE ID = "' + inOrgID + '"';
      fQuery.ExecSQL();
      fQuery.Close();
   finally
      FreeAndNil(fQuery);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.

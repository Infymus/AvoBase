 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_OrgWelcomeFormListUnit;

interface uses
  constantsunit,
  toolboxunit,
  inifileunit,
  masterdataunit,
  ErrorResultUnit,
  recordstructureunit,
  toolbox_ordertoolboxunit,
  toolbox_cycletoolboxunit,
  //
  sysutils,
  classes,
  db,
  dbtables,
  bde,
  dateutils;

type
   tMasterDataOrgWelcomeList = class( tQuery )
   private
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update;
      constructor Create( inMasterData : tMasterData );  overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataOrgWelcomeList.Create( inMasterData: tMasterData );
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create(nil);
   self.SessionName := masterData.AvoBaseSession.SessionName;
   fMasterData := inMasterData;
   // build the sql
   sql := 'SELECT * FROM ' + fMasterData.Gettable_Org + ' WHERE ISACTIVE = TRUE';
   self.SQL.Clear();
   self.SQL.Text := sql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   // Org Name | Cycle | End Date | Days Left | Orders
   masterData.QueryAddCalculatedField( self, 'ORGEND', 20, ftString);
   masterData.QueryAddCalculatedField( self, 'DAYSLEFT', 0, ftString);
   masterData.QueryAddCalculatedField( self, 'CYCLE', 20, ftString);
   masterData.QueryAddCalculatedField( self, 'OPEN', 0, ftInteger);
   masterData.QueryAddCalculatedField( self, 'CLOSED', 0, ftInteger);
   masterData.QueryAddCalculatedField( self, 'CANCELLED', 0, ftInteger);
   masterData.QueryAddCalculatedField( self, 'EXPIRED', 0, ftBoolean);
   //
   self.OnCalcFields := HandleCalculated;
end;

procedure tMasterDataOrgWelcomeList.HandleCalculated( DataSet: TDataSet );
var
	fQuery : tQuery;
   sql : string;
   sDate,eDate : tDateTime;
   daysLeft : double;
   orgID : string;
begin
   DataSet.FieldByName('CYCLE').Value := 'None';
   DataSet.FieldByName('ORGEND').Value := 'Expired';
   DataSet.FieldByName('DAYSLEFT').Value := 0;
   DataSet.FieldByName('OPEN').Value := 0;
   DataSet.FieldByName('CLOSED').Value := 0;
   DataSet.FieldByName('CANCELLED').Value := 0;
   DataSet.FieldByName('EXPIRED').Value := false;

	//
	fQuery := masterData.GetQuery;
   orgID := masterData.WrapDBID( self.FieldByname('ID').AsString );

   // Cycle and # of Days Left
   fQuery.Close();
   sql := 'SELECT ID, ORG_ID, NUM, ISACTIVE, SDATE, EDATE FROM ' + masterData.GetTable_Cycle + ' ' +
   	'WHERE ORG_ID = ' + orgID + ' ' +
      'AND ISACTIVE = TRUE';
   fQuery.SQL.Text := sql;
   fQuery.Open();

   // we now have to go through the entire dataset and find out WHICH one it is
   repeat
   	try
      sDate := fQuery.FieldByname('SDATE').AsDateTime;
      eDate := fQuery.FieldByname('EDATE').AsDateTime;
      if (NOW >= sDate) AND (NOW <= eDate) then
      begin
      	DataSet.FieldByName('ORGEND').Value := DateToStr(eDate);
         daysLeft := DaySpan(eDate, NOW);
         DataSet.FieldByName('DAYSLEFT').AsString := FloatToStrF(daysLeft, ffNumber, 2, 0);
			DataSet.FieldByName('OPEN').Value := Cycle_GetTotalOrdersByCycleID( OrderStatusOpen, fQuery.FieldByname('ID').AsString );
			DataSet.FieldByName('CLOSED').Value := Cycle_GetTotalOrdersByCycleID( OrderStatusClosed, fQuery.FieldByname('ID').AsString );
			DataSet.FieldByName('CANCELLED').Value := Cycle_GetTotalOrdersByCycleID( OrderStatusCancelled, fQuery.FieldByname('ID').AsString );
         DataSet.FieldByName('CYCLE').Value := Cycle_GetCycleNameByDateAndNum( fQuery.FieldByname('SDATE').AsDateTime, fQuery.FieldByname('NUM').AsInteger);
      end;
      finally
      end;
      fQuery.Next();
   until fQuery.EOF;
   fQuery.Close();

   // Check the query to make sure if it is expired, we then just default to the LAST sales cycle
   if ( DataSet.FieldByName('ORGEND').Value = 'Expired' ) then
   begin
      // Ok, so one was NOT found, so lets do a NEW query.
      fQuery.Close();
      sql := 'SELECT ID, ORG_ID, NUM, ISACTIVE, SDATE, EDATE FROM ' + masterData.GetTable_Cycle + ' ' +
         'WHERE ORG_ID = ' + orgID + ' ' +
         'AND ISACTIVE = TRUE ORDER BY EDATE DESC';
      fQuery.SQL.Text := sql;
      fQuery.Open();
      if ( fQuery.RecordCount <> 0 ) then
      begin
         DataSet.FieldByName('EXPIRED').Value := true;
      	DataSet.FieldByName('ORGEND').Value := DateToStr( fQuery.FieldByname('EDATE').AsDateTime );
         DataSet.FieldByName('DAYSLEFT').AsString := 'Expired';
			DataSet.FieldByName('OPEN').Value := Cycle_GetTotalOrdersByCycleID( OrderStatusOpen, fQuery.FieldByname('ID').AsString );
			DataSet.FieldByName('CLOSED').Value := Cycle_GetTotalOrdersByCycleID( OrderStatusClosed, fQuery.FieldByname('ID').AsString );
			DataSet.FieldByName('CANCELLED').Value := Cycle_GetTotalOrdersByCycleID( OrderStatusCancelled, fQuery.FieldByname('ID').AsString );
         DataSet.FieldByName('CYCLE').Value := Cycle_GetCycleNameByDateAndNum( fQuery.FieldByname('SDATE').AsDateTime, fQuery.FieldByname('NUM').AsInteger);
      end;
      fQuery.Close();
   end;
   FreeAndNil(fQuery);
end;

procedure tMasterDataOrgWelcomeList.Update;
begin
	self.Close();
   Self.Open();
end;

end.

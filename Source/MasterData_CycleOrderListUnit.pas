 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_CycleOrderListUnit;

interface uses
  sysutils,
  classes,
  Order_InvoiceObjectUnit,
  constantsunit,
  avobase_percentformunit,
  recordstructureunit,
  toolboxunit,
  db,
  dbtables,
  bde,
  dateutils,
  inifileunit,
  masterdataunit,
  ErrorResultUnit;

// This is the customer ORDER DETAILS list
type
   tMasterDataCycleOrderList = class(tQuery)
   private
      fID : string;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
      constructor Create(inMasterData : tMasterData; inCycleID : string ); virtual;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataCycleOrderList.Create(inMasterData : tMasterData; inCycleID : string );
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( owner );
   //
   PercentForm_Create('Generating View...', 0, 0);
   fID := inCycleID;
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Order +
   	' WHERE C_ID = ' + masterData.WrapDBID(fID) +
      ' ORDER BY ONUM DESC';
   self.SQL.Clear();
   self.SQL.Text := sql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   // QueryAddCalculatedField( inQuery : tQuery; inName : string; inFieldName : string; inSize : integer; inFieldType : TFieldType ) : tErrorResult;
   masterData.QueryAddCalculatedField( self, 'CUSTNAME', 50, ftString);
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 30, ftString);
   masterData.QueryAddCalculatedField( self, 'OTYPE', 10, ftString);
   masterData.QueryAddCalculatedField( self, 'CYCLE', 7, ftString);
   masterData.QueryAddCalculatedField( self, 'ITEMS', 1, ftInteger);
   masterData.QueryAddCalculatedField( self, 'TOTAL', 1, ftCurrency);
   masterData.QueryAddCalculatedField( self, 'PAID', 1, ftCurrency);
   masterData.QueryAddCalculatedField( self, 'DISPSTATUS', 30, ftString);
   // even if we add active := true here, it won't activate within the create methodology.
   Self.Open();
   PercentForm_Free();
end;

procedure tMasterDataCycleOrderList.HandleCalculated(DataSet: TDataSet);
var
	InvoiceObj : tInvoice;
begin
   // get what we can out of the invoice
	InvoiceObj := tInvoice.Create( InvoiceTypeReport, nil, nil, nil );
   InvoiceObj.Load( DataSet.FieldByName('ID').AsString );
   try
      DataSet.FieldByName('CUSTNAME').AsString := InvoiceObj.Customer_GetSoldToName;
      DataSet.FieldByName('ORGNAME').AsString := InvoiceObj.Org_GetOrgName;
      case InvoiceObj.Order_Type of
      	OrdTypeOrder : DataSet.FieldByName('OTYPE').AsString := 'ORDER';
      	OrdTypeReturn : DataSet.FieldByName('OTYPE').AsString := 'RETURN';
      end;
      DataSet.FieldByName('CYCLE').AsString := InvoiceObj.Cycle_GetCycleName;
      DataSet.FieldByName('ITEMS').asInteger := InvoiceObj.LineItemCount;
      DataSet.FieldByName('TOTAL').AsCurrency := InvoiceObj.Amount_Total;
      DataSet.FieldByName('PAID').AsCurrency := InvoiceObj.Amount_TotalMOP;
      DataSet.FieldByName('DISPSTATUS').AsString := InvoiceObj.Order_GetOrderStatusName;
      {
   masterData.QueryAddCalculatedField( self, 'DISPSTATUS', 30, ftString);
   }
      // finish
   finally
   	FreeAndNil(InvoiceObj);
   end;
	//
end;

procedure tMasterDataCycleOrderList.Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
var
   errResult : tErrorResult;
   sql : string;
begin
	self.Close();
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Order +
   	' WHERE C_ID = ' + masterData.WrapDBID(fID) +
      ' ORDER BY ONUM DESC';
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
end;

end.


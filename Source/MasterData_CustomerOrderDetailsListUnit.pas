 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit 	MasterData_CustomerOrderDetailsListUnit;

interface uses
  sysutils,
  classes,
  Order_InvoiceObjectUnit,
  Return_InvoiceObjectUnit,
  constantsunit,
  recordstructureunit,
  avobase_percentformunit,
  toolboxunit,
  toolbox_ordertoolboxunit,
  Toolbox_PreferenceToolBoxUnit,
  db,

  dbtables,
  bde,
  dateutils,
  inifileunit,
  masterdataunit,
  ErrorResultUnit;

// This is the customer ORDER DETAILS list
type
   tMasterDataCustomerOrderDetailsList = class(tQuery)
   private
      fID : string;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
      constructor Create(inMasterData : tMasterData; inCustID : string ); virtual;
   end;


implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataCustomerOrderDetailsList.Create(inMasterData : tMasterData; inCustID : string );
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( owner );
   //
   PercentForm_Create('Generating Customer View...', 0, 0);
   fID := inCustID;
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Order +
   	' WHERE C_STID = ' + masterData.WrapDBID(fID) +
      ' ORDER BY ONUM DESC';
   self.SQL.Clear();
   self.SQL.Text := sql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   // QueryAddCalculatedField( inQuery : tQuery; inName : string; inFieldName : string; inSize : integer; inFieldType : TFieldType ) : tErrorResult;
   masterData.QueryAddCalculatedField( self, 'ORDTYPE', 20, ftString);
   masterData.QueryAddCalculatedField( self, 'CYCLE', 10, ftString );
   masterData.QueryAddCalculatedField( self, 'ORDITEMS', 10, ftInteger );
   masterData.QueryAddCalculatedField( self, 'TOTALINVAMOUNT', 10, ftCurrency );
   masterData.QueryAddCalculatedField( self, 'TOTPAID', 25, ftString );
   masterData.QueryAddCalculatedField( self, 'ORDSTATUS', 10, ftString );
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 40, ftString );
   // even if we add active := true here, it won't activate within the create methodology.
   Self.Open();
   PercentForm_Free();
end;

procedure tMasterDataCustomerOrderDetailsList.HandleCalculated(DataSet: TDataSet);
var
	InvoiceObj : tInvoice;
   ReturnObj : tReturnInvoice;
begin
   if ( Order_GetOrderTypeByOrderID( Self.FieldByname('ID').AsString ) = OrdTypeOrder ) then
   begin
      InvoiceObj := tInvoice.Create( InvoiceTypeReport, nil, nil, nil );
      invoiceObj.Load( DataSet.FieldByName('ID').AsString );
      try
         DataSet.FieldByName('ORDSTATUS').Value := InvoiceObj.Order_GetOrderStatusName;
         //
         case Self.FieldByname('O_TYPE').AsInteger of
            integer(tOrderTypes.OrdTypeOrder) : DataSet.FieldByName('ORDTYPE').Value := 'ORDER';
            integer(tOrderTypes.OrdTypeReturn) : DataSet.FieldByName('ORDTYPE').Value := 'RETURN';
         end;
         //
         DataSet.FieldByName('CYCLE').Value := InvoiceObj.Cycle_GetCycleName;
         DataSet.FieldByName('ORDITEMS').Value := InvoiceObj.LineItemCount;
         DataSet.FieldByName('TOTALINVAMOUNT').Value := InvoiceObj.Amount_Total;
         DataSet.FieldByName('TOTPAID').Value := Pref_GetCashSymbol + CurrToStr( InvoiceObj.Amount_TotalMOP );
         InvoiceObj.Amount_TotalMOP;
         DataSet.FieldByName('ORGNAME').Value := InvoiceObj.Org_GetOrgName;
      finally
         FreeAndNil(InvoiceObj);
      end;
   end;
   //
   if ( Order_GetOrderTypeByOrderID( Self.FieldByname('ID').AsString ) = OrdTypeReturn ) then
   begin
      ReturnObj := tReturnInvoice.Create( InvoiceTypeReport, nil, nil );
      ReturnObj.Load( DataSet.FieldByName('ID').AsString );
      try
         DataSet.FieldByName('ORDSTATUS').Value := ReturnObj.Order_GetOrderStatusName;
         //
         case Self.FieldByname('O_TYPE').AsInteger of
            integer(tOrderTypes.OrdTypeOrder) : DataSet.FieldByName('ORDTYPE').Value := 'ORDER';
            integer(tOrderTypes.OrdTypeReturn) : DataSet.FieldByName('ORDTYPE').Value := 'RETURN';
         end;
         //
         DataSet.FieldByName('CYCLE').Value := ReturnObj.Cycle_GetCycleName;
         DataSet.FieldByName('ORDITEMS').Value := ReturnObj.LineItemCount;
         DataSet.FieldByName('TOTALINVAMOUNT').Value := ReturnObj.Amount_TotalRefund;
         DataSet.FieldByName('TOTPAID').Value := 'n/a';
         DataSet.FieldByName('ORGNAME').Value := ReturnObj.OrgName;
      finally
         FreeAndNil(ReturnObj);
      end;
   end;
end;



procedure tMasterDataCustomerOrderDetailsList.Update(inOrderBy : string; inSortOpt : string; inActiveState : tActiveStates);
var
   errResult : tErrorResult;
   sql : string;
begin
	self.Close();
   sql := 'SELECT * FROM ' + fMasterData.Gettable_Customer;
   if (inActiveState in [stateActive]) then
      sql := sql + ' WHERE ISACTIVE = TRUE';
   if (inActiveState in [stateInactive]) then
   	sql := sql + ' WHERE ISACTIVE = FALSE';
   if (inOrderBy <> '') then
      sql := sql + ' ORDER BY ' + inOrderBy;
   if (inSortOpt <> '') then
   	sql := sql + ' ' + inSortOpt;
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   Self.Open();
end;

end.

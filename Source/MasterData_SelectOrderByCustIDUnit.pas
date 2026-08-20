 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_SelectOrderByCustIDUnit;

interface uses
   inifileunit,
   masterdata_BaseDataClassUnit,
   Order_InvoiceObjectUnit,
   masterdataunit,
   ErrorResultUnit,
  recordstructureunit,
   constantsunit,
   toolboxunit,
   //
	sysutils,
   classes,
   db,
   dbtables,
   bde,
   dateutils;

type
   tMasterDataOrderListByCustID = class(tQuery)
   private
      fCustID : string;
      invoiceObj : tInvoice;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      procedure Update();
      //
      constructor Create( inMasterData : tMasterData; inCustID : string );  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataOrderListByCustID.Create(inMasterData: tMasterData; inCustID : string);
var
   errResult : tErrorResult;
   fSQLString : string;
begin
   inherited create( nil );
   //
   fCustID := inCustID;
   //
   self.RequestLive := true;
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fSQLString := 'SELECT * FROM ' + MasterData.Gettable_Order +
      ' WHERE C_STID = ' + masterData.WrapDBID( fCustID ) +
      ' AND O_TYPE = ' + IntToStr( integer(tOrderTypes.OrdTypeOrder) ) +
      ' AND STATUS = ' + IntToStr( integer(tOrderStatusTypes.OrderStatusOpen) );
   //
   self.SQL.Clear();
   self.SQL.Text := fSQLString;
   errResult := MasterData.QueryAddFields( self );
   //
   masterData.QueryAddCalculatedField( self, 'CUSTNAME', 50, ftString);
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 30, ftString);
   masterData.QueryAddCalculatedField( self, 'OTYPE', 10, ftString);
   masterData.QueryAddCalculatedField( self, 'CYCLE', 7, ftString);
   masterData.QueryAddCalculatedField( self, 'ITEMS', 1, ftInteger);
   masterData.QueryAddCalculatedField( self, 'TOTAL', 1, ftCurrency);
   masterData.QueryAddCalculatedField( self, 'PAID', 1, ftCurrency);
   masterData.QueryAddCalculatedField( self, 'DISPSTATUS', 30, ftString);
   masterData.QueryAddCalculatedField( self, 'BOI', 1, ftInteger);
   //
	InvoiceObj := tInvoice.Create( InvoiceTypeReport, nil, nil, nil );
end;

destructor tMasterDataOrderListByCustID.destroy;
begin
   FreeAndNil(InvoiceObj);
   //
   inherited destroy;
end;

procedure tMasterDataOrderListByCustID.HandleCalculated(DataSet: TDataSet);
var
   errResult : tErrorResult;
begin
   if ( Self.FieldByname('O_TYPE').AsInteger = integer(OrdTypeOrder) ) then
   begin
      errResult := InvoiceObj.Load( Self.FieldByname('ID').AsString );
      DataSet.FieldByName('CUSTNAME').AsString := InvoiceObj.Customer_GetSoldToName;
      DataSet.FieldByName('ORGNAME').AsString := InvoiceObj.Org_GetOrgName;
      DataSet.FieldByName('OTYPE').AsString := 'ORDER';
      DataSet.FieldByName('CYCLE').AsString := InvoiceObj.Cycle_GetCycleName;
      DataSet.FieldByName('ITEMS').asInteger := InvoiceObj.LineItemCount;
      DataSet.FieldByName('TOTAL').AsCurrency := InvoiceObj.Amount_Total;
      DataSet.FieldByName('PAID').AsCurrency := InvoiceObj.Amount_TotalMOP - invoiceObj.Amount_VoidNSF;
      DataSet.FieldByname('BOI').AsInteger := InvoiceObj.BackOrderCount;
      DataSet.FieldByName('DISPSTATUS').AsString := InvoiceObj.Order_GetOrderStatusName;
   end;
end;

procedure tMasterDataOrderListByCustID.Update;
begin
   Self.Close();
   Self.Open();
end;

end.

 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ProductBOListUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  recordstructureunit,
  dbtables,
  bde,
  dateutils,
  inifileunit,
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  toolbox_orgtoolboxunit,
  toolbox_cycletoolboxunit,
  toolbox_customertoolboxunit,
  masterdataunit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterData_ProductBOTempList = class(tQuery)
   private
      fSQL : string;
      fSortProdType : tSortProdTypes;
      fSortOpt : string;
      fSortOrg : string;
      fSearchText : string;
      fStatusType : tBackOrderStatus;


      fMasterData : tMasterData;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      procedure Update();
      //
      property SortType : tSortProdTypes read fSortProdType write fSortProdType;
      property SortOption : string read fSortOpt write fSortOpt;
      property SearchText : string read fSearchText write fSearchText;
      property SearchOrg : string read fSortOrg write fSortOrg;
      property StatusType : tBackOrderStatus read fStatusType write fStatusType;
      //
      constructor Create( inMasterData : tMasterData);  overload;
   end;


implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

{
         retVal := masterData.AddTable(masterData.dbPath + table_backordered,
            'ID VARCHAR(40), ' +
            'OPT_ID VARCHAR(40),' + // order_product_table product_id
            'ORDER_ID VARCHAR(40), ' +
            'ONUM INTEGER, ' + // integer
            'C_STID VARCHAR(40), ' + // sold to id
            'C_ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'NUM VARCHAR(20), ' +
            'BOT INTEGER, ' + // back ordered type : see tBackOrderTypes
            'LIFREE BOOLEAN, ' + // line item free? ( true = yes, false = is free )
            'TAX FLOAT, ' + // tax AT TIME of invoice
            'SQTY INTEGER, ' +
            'NAME VARCHAR(40), ' +
            'DESCR VARCHAR(40), ' +
            'PSIZE VARCHAR(20), ' +
            'PPAGE VARCHAR(8), ' +
            'STATUS INTEGER, ' + // status : see tBackOrderStatus
            'SCOST MONEY, ' + // sell at cost
            'RCOST MONEY',  // retail cost

}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterData_ProductBOTempList.Create(inMasterData: tMasterData);
var
   errResult : tErrorResult;
begin
   inherited create(nil);
   //
   fMasterData := inMasterData;
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   //
   fSQL := 'SELECT * FROM ' + fMasterData.GetTable_BackOrdered;
   self.SQL.Clear();
   self.SQL.Text := fSQL;
   //
   errResult := fMasterData.QueryAddFields( self );
   //
   masterData.QueryAddCalculatedField( self, 'CYCLE', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'ORGNAME', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'CUST', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'ORDER', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'STAT', 120, ftString);
   //
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterData_ProductBOTempList.HandleCalculated(DataSet: TDataSet);
begin
	DataSet.FieldByName('CYCLE').Value := Cycle_GetCycleNameByCycleID( self.FieldByName('C_ID').AsString );
	DataSet.FieldByName('ORGNAME').Value := Org_GetOrgNameByOrgID( self.FieldByName('ORG_ID').AsString );
	DataSet.FieldByName('ORDER').Value := Order_GetOrderNumberByOrderID( self.FieldByName('ORDER_ID').AsString );
	DataSet.FieldByName('CUST').Value := Customer_GetCustomerNameByCustID( self.FieldByName('C_STID').AsString );
   case self.FieldByName('STATUS').AsInteger of
      integer(BOSPending): DataSet.FieldByName('STAT').Value := 'Pending';
      integer(BOSDelivered): DataSet.FieldByName('STAT').Value := 'Delivered';
      integer(BOSNotAvail): DataSet.FieldByName('STAT').Value := 'No Longer Avaialble';
   end;
	DataSet.FieldByName('CUST').Value := Customer_GetCustomerNameByCustID( self.FieldByName('C_STID').AsString );
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterData_ProductBOTempList.Update;
var
   workSql : string;
begin
	self.Close();
   workSql := fSQL;
   //
   workSql := workSQL + ' WHERE STATUS = ' + IntToStr(integer(fStatusType));
   //
   if (fSearchText <> '') then
   begin
      workSql := workSQL + ' AND (NAME LIKE "%' + fSearchText + '%"' + ') ';
      workSql := workSQL + ' OR (NUM LIKE "%' + fSearchText + '%"' + ') ';
   end;
   //
   case fSortProdType of
      ProdOrg : workSql := workSql + ' ORDER BY ORG_ID';
   	ProdCycle : workSql := workSql + ' ORDER BY C_ID';
   	ProdNum : workSql := workSql + ' ORDER BY NUM';
   	ProdName : workSql := workSql + ' ORDER BY NAME';
   	ProdOrder : workSql := workSql + ' ORDER BY ONUM';
   end;
   //
   if (fSortOpt <> '') then
   	workSql := workSql + ' ' + fSortOpt;
   //
   self.SQL.Clear();
   self.SQL.Text := workSql;
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.d.

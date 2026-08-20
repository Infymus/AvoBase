 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_CustomerProdHistoryUnit;

interface uses
  sysutils,
  classes,
  constantsunit,
  toolboxunit,
  db,
  dbtables,
  bde,
  recordstructureunit,
  dateutils,
  inifileunit,
  masterdataunit,
  toolbox_paymenttoolboxunit,
  toolbox_ordertoolboxunit,
  Order_InvoiceObjectUnit,
  Return_InvoiceObjectUnit,
  toolbox_escrowtoolboxunit,
  encryptunit,
  ErrorResultUnit;

type
   tMasterDataCustomerProdHistoryQuery = class(tQuery)
   private
      fCustID : string;
      fSQL : string;
      fSortField : string;
      fSortDir : string;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update;
      //
      property SortField : string read fSortField write fSortField;
      property SortDir : string read fSortDir write fSortDir;
      //
      constructor Create( inMasterData : tMasterData; inCustID : string);  overload;
      destructor destroy; overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataCustomerProdHistoryQuery.Create(inMasterData: tMasterData; inCustID : string);
var
   errResult : tErrorResult;
   workQuery : tQuery;
begin
   inherited create( nil );
   //
   fCustID := inCustID;
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;


   // setup the SQL initially
   fSQL := 'SELECT O.ID, O.ODATE, P.ID, O.CYCLENAME, P.NUM, P.SQTY, P.NAME, P.SCOST, P.RCOST, C.ID, C.FNAME, C.LNAME FROM ' + masterData.GetTable_Order + ' O ' +
      'INNER JOIN ' + masterData.GetTable_Order_Product + ' P ON P.ORDER_ID = O.ID ' +
      'INNER JOIN ' + masterData.Gettable_Customer + ' C ON O.C_STID = C.ID ' +
      'WHERE C_STID = ' + masterData.WrapDBID( fCustID );
{
select o.id, o.odate, p.*, c.id, c.fname, c.lname from ord o
inner join ordprod p on p.order_id = o.id
inner join cust c on o.c_stid = c.id
where c_stid = '170DC49A-B048-4EF9-9C4C-EEE12AF3B8D1'
order by o.odate desc
}
   self.SQL.Clear();
   self.SQL.Text := fSQL + ' ORDER BY O.ODATE DESC';

   //
   Self.RequestLive := true;

   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );

   // Add the calculated fields
   masterData.QueryAddCalculatedField( self, 'FULLNAME', 40, ftString); // display Type

   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

destructor tMasterDataCustomerProdHistoryQuery.destroy;
begin
   inherited;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataCustomerProdHistoryQuery.HandleCalculated(DataSet: TDataSet);
begin
   DataSet.FieldByName('FULLNAME').Value := self.FieldByName('FNAME').AsString + ' ' + self.FieldByName('LNAME').AsString;
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

procedure tMasterDataCustomerProdHistoryQuery.Update();
begin
	self.Close();
   self.SQL.Clear();
   self.SQL.Text := fSQL + ' ORDER BY ' + fSortField + ' ' + fSortDir;
   Self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)


end.


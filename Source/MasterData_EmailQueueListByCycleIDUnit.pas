 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_EmailQueueListByCycleIDUnit;

interface uses
	sysutils,
   classes,
   constantsunit,
   toolboxunit,
   db,
   dbtables,
   bde,
   dateutils,
   inifileunit,
   recordstructureunit,
   masterdataunit,
   ErrorResultUnit;

type
   tMasterDataEmailQueueListByCycleID = class(tQuery)
   private
   	fSQLString : string;
      fMasterData : tMasterData;
   public
      constructor Create( inMasterData : tMasterData; inCycleID : string );  overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataEmailQueueListByCycleID.Create( inMasterData : tMasterData; inCycleID : string );
var
   errResult : tErrorResult;
begin
   inherited create(nil);
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.RequestLive := true;
   fMasterData := inMasterData;
   //
	fSQLString := 'SELECT ID, C_STID, C_ID FROM ' + fMasterData.GetTable_Order+
      ' WHERE C_ID = ' + masterData.WrapDBID( inCycleID );
   self.SQL.Clear();
   self.SQL.Text := fSQLString;
   //
   errResult := fMasterData.QueryAddFields( self );
   //
end;

end.

{
         retVal := masterData.AddTable(masterData.dbPath + table_order,
            'ID VARCHAR(40), ' +
            'C_ID VARCHAR(40), ' + // cycle id
            'RET_ID VARCHAR(40), ' + // The prior order ID only for returns
            'C_SHID VARCHAR(40), ' + // Customer SHIP TO ID
            'C_STID VARCHAR(40), ' + // sold to id
            'ORG_ID VARCHAR(40), ' +
            'CYCLENAME VARCHAR(7), ' + // pretty name for sorting 0000/00
            'SHIPTAXID VARCHAR(40), ' + // shipping Tax ID
            'ORDTAXID VARCHAR(40), ' + // order tax ID for compound tax
            'ONUM INTEGER, ' + // order number
            'ODATE DATE, ' +
            'OTIME TIME, ' +
            'SHIPAMT MONEY, ' + // stored shipping amount
            'SHIPTAXAMT MONEY, ' + // stored shipping tax
            'CTAXAMT MONEY, ' + // stored compound tax amount
            'STATUS INTEGER, ' +
            'WTAX BOOLEAN, ' +
            'WSHIP BOOLEAN, ' +
            'TAXEXID VARCHAR(40), ' + // tax exempt id
            'EXORDTAX MONEY, ' + // stored WAVE Order Tax AMOUNT ( for tax exemptions )
            'SHIPTAX FLOAT, ' + // shipping tax rate
            'REFSHIP BOOLEAN, ' + // for returns only. Refund shipping?
            'SHIPREF BOOLEAN, ' + // for prior orders, mark shipping as refunded
            'SHOW_DISC BOOLEAN, ' + // show discounts on invoice?
            'O_TYPE INTEGER, ' + // order type
            'I_MSG BLOB(240,1)', // invoice special message
}
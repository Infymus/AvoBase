 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_ShippingListUnit;

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
   ErrorResultUnit,
   toolbox_preferencetoolboxunit,
   toolbox_orgtoolboxunit;


type
   tMasterDataShippingList = class(tQuery)
   private
      fOrgID : string;
      fSQL : string;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update;
      //
      property OrgID : string read fOrgID write fOrgID;
      //
      constructor Create(inMasterData : tMasterData); virtual;
   end;


implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataShippingList.Create(inMasterData : tMasterData);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( owner );
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   sql := 'SELECT * FROM ' + fMasterData.GetTable_Shipping + ' ORDER BY NAME, EAMT';
   self.SQL.Clear();
   self.SQL.Text := sql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   masterData.QueryAddCalculatedField( self, 'SHIPTYPE', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'SHIPDATA', 120, ftString);
   masterData.QueryAddCalculatedField( self, 'ORG', 120, ftString);
{
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'SAMT MONEY, ' + // start amount
            'EAMT MONEY, ' + // end amount
            'PCNT FLOAT, ' + // PERCENT if STYPE = 2
            'RATE MONEY, ' + // RATE if STYPE = 1
            'STYPE INTEGER', // TYPE - 1 = $RATE$ - 2 = %PCNT%
 }
   // even if we add active := true here, it won't activate within the create methodology.
   Self.Open();
end;

procedure tMasterDataShippingList.HandleCalculated(DataSet: TDataSet);
begin
   case self.FieldByname('STYPE').AsInteger of
   	integer(tShippingTypes.ShipPcnt) :
      begin
         DataSet.FieldByName('SHIPTYPE').Value := 'Percent';
         DataSet.FieldByName('SHIPDATA').Value := Self.FieldByName('PCNT').AsString + '%';
      end;
   	integer(tShippingTypes.ShipRate ) :
      begin
         DataSet.FieldByName('SHIPTYPE').Value := 'Rate';
         DataSet.FieldByName('SHIPDATA').Value := Pref_GetCashSymbol + FormatFloat('#####0.00', Self.FieldByName('RATE').AsCurrency);
      end;
   end;
   //
   DataSet.FieldByName('ORG').Value := Org_GetOrgNameByOrgID( self.FieldByname('ORG_ID').AsString );
end;

procedure tMasterDataShippingList.Update;
begin
   self.Close();
   //
   fSQL := 'SELECT * FROM ' + fMasterData.GetTable_Shipping;
   if ( fOrgID <> '' ) then
      fSQL := fSQL + ' WHERE ORG_ID = ' + masterData.WrapDBID( fOrgID );
   //
   fSQL := fSQL + ' ORDER BY NAME, EAMT';
   //
   self.SQL.Text := fSQL;
   self.Open();
end;



end.

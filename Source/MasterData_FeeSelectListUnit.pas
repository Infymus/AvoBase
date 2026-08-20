 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_FeeSelectListUnit;

interface uses
	sysutils,
   classes,
   constantsunit,
   toolboxunit,
   db,
   dbtables,
   RecordStructureUnit,
   bde,
   dateutils,
   inifileunit,
   masterdataunit,
   ErrorResultUnit,
   toolbox_preferencetoolboxunit,
   toolbox_orgtoolboxunit;

type
   tMasterDataFeeSelectList = class(tQuery)
   private
      fsql : string;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
      fMasterData : tMasterData;
      procedure Update( inOrgName : string );
      constructor Create(inMasterData : tMasterData); virtual;
   end;


implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataFeeSelectList.Create(inMasterData : tMasterData);
var
   errResult : tErrorResult;
begin
	// create and assign
   inherited create( owner );
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   fsql := 'SELECT * FROM ' + fMasterData.GetTable_Fee;
   self.SQL.Clear();
   self.SQL.Text := fsql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   masterData.QueryAddCalculatedField( self, 'ORG', 120, ftString);
{
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +
            'AUTOINV BOOLEAN, ' + // auto-add to invoice
            'TAX BOOLEAN, ' +  // whether this is a line item taxation on the invoice
            'AMOUNT MONEY',
 }
   // even if we add active := true here, it won't activate within the create methodology.
   Self.Open();
end;

procedure tMasterDataFeeSelectList.HandleCalculated(DataSet: TDataSet);
begin
   DataSet.FieldByName('ORG').Value := Org_GetOrgNameByOrgID( self.FieldByname('ORG_ID').AsString );
end;

procedure tMasterDataFeeSelectList.Update( inOrgName : string );
begin
   self.Close();
   self.sql.Clear();
   fsql := fsql + ' WHERE ISACTIVE = TRUE';
   self.sql.text := fsql;
   self.Open();
end;

end.
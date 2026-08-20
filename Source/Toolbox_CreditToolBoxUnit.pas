 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_CreditToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  inifileunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
  //
  db,
  dbtables,
  bde,
  sysutils,
  math,
  classes,
  forms,
  dateutils,
  inifiles,
  stdctrls;

function Credit_ReturnCreditAmountByCustID( inValue : string ) : currency;

implementation

function Credit_ReturnCreditAmountByCustID( inValue : string ) : currency;
var
   fQuery : tQuery;
begin
	result := 1.00;
{
   if ( inValue <> '') then
   begin
   	fQuery := masterData.GetQuery();
      fQuery.SQL.Text := 'SELECT COUNT(*) AS TOT FROM ' + masterData.GetTable_Credit +
      	'WHERE C_ID = ' + masterData.WrapDBID( inValue );
      fQuery.Open();
      // do.
      fQuery.Close();
      //
      FreeAndNil( fQuery );
   end;
}
end;

end.



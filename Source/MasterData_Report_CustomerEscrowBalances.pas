 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_Report_CustomerEscrowBalances;

interface uses
	sysutils,
   classes,
   constantsunit,
   recordstructureunit,
   toolboxunit,
   db,
   dbtables,
   bde,
   dateutils,
   inifileunit,
   toolbox_cycletoolboxunit,
   toolbox_orgtoolboxunit,
   masterdataunit,
   ErrorResultUnit;

type
   tMasterDataReport_CustomerEscrowList = class(tQuery)
   private
      fSortDir : string;
      fSortOrgID : string;
      fSortField : string;
   	procedure HandleCalculated(DataSet: TDataSet);
   public
   	fSQLString : string;
      fMasterData : tMasterData;
      //
      procedure Update();
      //
      property SortDir : string read fSortDir write fSortDir;
      property SortOrgID : string read fSortOrgID write fSortOrgID;
      property SortField : string read fSortField write fSortField;
      //
      constructor Create( inMasterData : tMasterData);  overload;
   end;

implementation

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tMasterDataReport_CustomerEscrowList.Create( inMasterData : tMasterData );
var
   errResult : tErrorResult;
   cnt : integer;
begin
   inherited create(nil);
   //
   self.SessionName := masterData.AvoBaseSession.SessionName;
   fMasterData := inMasterData;
   //
	fSQLString := 'SELECT C.ID, C.FNAME, C.LNAME, E.C_ID, E.AMOUNT FROM ' + masterData.Gettable_Customer + ' C ' +
      ' LEFT JOIN ' + masterData.GetTable_Escrow + ' E ON E.C_ID = C.ID WHERE E.AMOUNT > 0 ORDER BY C.LNAME';
   self.SQL.Clear();
   self.SQL.Text := fSQLString;
   //
   errResult := fMasterData.QueryAddFields( self );
   masterData.QueryAddCalculatedField( self, 'CNAME', 60, ftString);
   // even if we add active := true here, it won't activate within the create methodology.
   self.OnCalcFields := HandleCalculated;
   Self.Open();
end;

procedure tMasterDataReport_CustomerEscrowList.HandleCalculated(DataSet: TDataSet);
begin
   DataSet.FieldByName('CNAME').Value := Self.FieldByname('LNAME').AsString + ', ' +
      Self.FieldByname('FNAME').AsString;
end;

procedure tMasterDataReport_CustomerEscrowList.Update();
begin
	self.Close();
   self.Open();
end;

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

end.

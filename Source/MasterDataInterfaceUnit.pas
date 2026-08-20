 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

 UNIT  MasterDataInterfaceUnit;

INTERFACE USES
   classes,
   db,
   dbtables,
   bde,
   forms,
     recordstructureunit,
   sysutils,
   errorresultunit;

type
	iMasterDataInterface = interface['{0D57624C-CDDE-458B-A36C-436AE465B477}']
      function AddField(inTableName : string; inFieldName : string; inFieldType : string ) : tErrorResult;
      function AddIndex(inTableName : string; inIndexName : string; inIndexType : TIndexOptions ) : tErrorResult;
      function AddTable(inTableName : string; inFields : string; inPrimaryKey : string ) : tErrorResult;
      function RemoveField(inTableName : string; inFieldName : string ) : tErrorResult;
      function RemoveIndex(inTableName : string; inIndexName : string ) : tErrorResult;
      function RemoveTable(inTableName : string ) : tErrorResult;
      function TableExists(inTableName : string ) : boolean;
      function SetDataBaseVersion(  inDBVersion : integer ) : tErrorResult;
	end;

   implementation

end.

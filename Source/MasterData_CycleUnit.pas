 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit MasterData_CycleUnit;

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
  masterdataunit,
  ErrorResultUnit;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

type
   tMasterDataCycleList = class(tQuery)
   private
   public
   end;

   {%%% implementation %%%}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

implementation

// CYCLE LIST ################################################# //

{$REGION 'Cycle List'}

constructor tMasterDataCycleList.Create(owner: tComponent; inMasterData: tMasterData; inOrg : string; inOrderBy : string; inSortOpt : string);
var
   errResult : tErrorResult;
   sql : string;
begin
	// create and assign
   inherited create( owner );
   self.OnCalcFields := HandleCalculated;
   fMasterData := inMasterData;
   // build the sql
   if ( inOrg <> '') then
     sql := 'SELECT * FROM ' + fMasterData.Gettable_Cycle + ' WHERE ID = "' + InOrg + '"'
   else
     sql := 'SELECT * FROM ' + fMasterData.Gettable_Cycle;
   // do we order it by?
   if (inOrderBy <> '') then
      sql := sql + ' ORDER BY ' + inOrderBy;
   // do we DESC?
   if (inSortOpt <> '') then
   	sql := sql + ' ' + inSortOpt;
   //
   self.SQL.Clear();
   self.SQL.Text := sql;
   // Add the fields from the above SQL string
   errResult := fMasterData.QueryAddFields( self );
   // Add the calculated fields
   masterData.QueryAddCalculatedField( self, 'TotOrd', 10, ftInteger );
   // even if we add active := true here, it won't activate within the create methodology.
   Self.Open();
end;

procedure tMasterDataCycleList.HandleCalculated(DataSet: TDataSet);
var
	fQuery : tQuery;
begin
	fQuery := masterData.GetQuery;
   try
   	fQuery.SessionName := fMasterData.AvoBaseSession.SessionName;
      //

      // Total Orders within the ORG
      fQuery.Close();
      // might want to do a larger query here to pull orders and returns 
      fQuery.SQL.Text := 'SELECT COUNT(*) FROM ' + masterData.GetTable_Order + ' WHERE ORG_ID = "' + DataSet.FieldByName('ID').AsString + '"';
      fQuery.Open();
      DataSet.FieldByName('TotOrd').Value := fQuery.FieldByName('COUNT(*)').AsInteger;
      fQuery.Close();
      //
      // finish
   finally
   	FreeAndNil(fQuery);
   end;
end;

{$ENDREGION}
end.



(*

THIS STUFF DOES GO IN HERE...

procedure TMainForm.Check_Current_Campaign_Expired;
Var
  CampGenForm : TCampaignGeneratorForm;
begin
  if (NOW > MasterData.Get_Current_Campaign_End_Date) then
  begin
    if (MasterData.Get_Current_CampaignNum = 0) AND (MasterData.CampaignCount <> 0) then
      AvoBaseDialog('No Campaign Selected.',
        'It appears that no Campaign has been selected. If this is your first time ' +
        'running AvoBase, you will need to start off by creating and selecting a ' +
        'current Campaign.' + #13 + #13 +
        'You may create and select a Campaign by clicking the "Campaign" button located on the AvoBase ' +
        'ToolBar.', mtInformation, [mbOk], 0);
   if (MasterData.Get_Current_CampaignNum <> 0) AND (MasterData.CampaignCount <> 0) then
        AvoBaseDialog('Campaign # ' + IntToStr(MasterData.Get_Current_CampaignNum) + ' has Expired.',
          'Please select your Current Campaign by clicking the Campaign button on the top menu, and then click ' +
          'the Select button. If you do not have any Campaigns entered yet, you may do so from the same area.' + #13 + #13 +
          '* You may turn this warning message off in Preferences.', mtInformation, [mbOk], 0);
  end;
  { if there are NO campaigns at all, then lets give them the opportunity to create them }
  if (MasterData.CampaignCount = 0) then
  begin
    if AvoBaseDialog('Generate New Campaigns?',
      'Hi! It appears that you don''t have any Campaigns created yet!' + #13 + #13 +
      'AvoBase can generate a year''s worth of Campaigns for you automatically. You ' +
      'simply tell AvoBase which Year you wish, and when Campaign 1 started - and ' +
      'it will do the rest for you.' + #13 + #13 + 'Would you like generate Campaigns automatically?', mtConfirmation, [mbYes, mbNo], 0) = mbyes then
    begin
      CampGenForm := TCampaignGeneratorForm.Create(nil);
      Try
        CampGenForm.ShowModal;
      Finally
        FreeAndNil(CampGenForm);
      end;
    end;
    if (MasterData.Get_Current_CampaignNum = 0) AND (MasterData.CampaignCount <> 0) then
      AvoBaseDialog('No Campaign Selected.',
        'It appears that no Campaign has been selected. If this is your first time ' +
        'running AvoBase, you will need to start off by creating and selecting a ' +
        'current Campaign.' + #13 + #13 +
        'You may create and select a Campaign by clicking the "Campaign" button located on the AvoBase ' +
        'ToolBar.', mtInformation, [mbOk], 0);
  end;
  if (MasterData.CampaignCount = 0) then
    AvoBaseDialog('No Campaigns Created',
      'Before you can use AvoBase you will need to create a Campaign and make that Campaign active.' + #13 + #13 +
      'You may create and select a Campaign by clicking the "Campaign" button located on the AvoBase ToolBar.', mtInformation, [mbOk], 0);
end;

*)
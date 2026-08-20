 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Fee_SelectFormUnit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   masterdata_BaseDataClassUnit,
   masterdata_basegridunit,
   masterdata_navigationtoolunit,
   AvoBase_ToolBarUnit,
   AvoBase_BaseForm_SelectUnit,
   MasterData_FeeSelectListUnit,
   Toolbox_OrgToolBoxUnit,
   //
   windows,
   messages,
   sysutils,
   variants,
   classes,
   ActnList,
   graphics,
   controls,
   forms,
   dialogs,
   stdctrls,
   extctrls,
   ComCtrls,
   ToolWin,
   Mask,
   DB,
   jpeg;

type
  TFeeSelectForm = class(TAvoBase_BaseForm_Select)
    selectLabel: TLabel;
    OrgCombo: TComboBox;
    procedure OrgComboChange(Sender: TObject);
   private
      fLoadOrderEvent : tLoadOrderEvent;
      FeeListQuery : tMasterDataFeeSelectList;
      function fGetFeeID : string;
   	procedure HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
      procedure HandleActionExecute(sender : tObject; actionID : integer);
      procedure HandleDoubleClick( sender : tObject );
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
   public
      procedure StartUpForm();
      procedure UpdateQuery();
      procedure StatBarUpdate();
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property FeeID : string read fGetFeeID;
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean); overload;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TFeeSelectForm.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean);
begin
	inherited create( owner, incaption, isTopBarVisble, True );
   //
   FeeListQuery := tMasterDataFeeSelectList.Create( masterData);
   //
   dataListGrid.Init( FeeListQuery, 'ORG');
   gridDataSource.DataSet := FeeListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   dataListGrid.Clear;
   //
   dataListGrid.Add(FeeListQuery.FieldByName('ORG'), 'ORG', 120, clNavy, [fsBold], taLeftJustify);
   dataListGrid.Add(FeeListQuery.FieldByName('NAME'), 'NAME', 180, clBlue, [fsBold], taRightjustify);
   dataListGrid.Add(FeeListQuery.FieldByName('AMOUNT'), 'AMOUNT', 80, clBlack, [fsBold], taRightjustify);
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
   //
   dataListGrid.OnDblClick := HandleDoubleClick;
   //
   dbNavTool.Init( FeeListQuery );
   //
   actionList.OnUpdate := HandleActionListUpdate;
   actionList.onActionEvent := HandleActionExecute;
   //
	StartUpForm();
   StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TFeeSelectForm.StartUpForm;
begin
   //
   BASE_FORM_CAPTION_LABEL.Caption := 'Select Organization Fee';
   //
   orgCombo.OnChange := nil;
   Org_ComboBox_FillActiveOrgs ( 'ALL', orgCombo );
   orgCombo.OnChange := OrgComboChange;
   //
   UpdateQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TFeeSelectForm.fGetFeeID: string;
begin
   result := FeeListQuery.FieldByName('ID').AsString;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TFeeSelectForm.HandleActionExecute(sender: tObject; actionID: integer);
begin
   case actionID of
      CMD_SELECT_OK :
      begin
         fFormEvent := mrOk;
         Close();
      end;
      CMD_SELECT_CANCEL :
      begin
         fFormEvent := mrCancel;
         Close();
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TFeeSelectForm.HandleActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
	handled := true;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TFeeSelectForm.HandleDoubleClick(sender: tObject);
begin
   fFormEvent := mrOk;
   Close();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TFeeSelectForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin
	StatBarUpdate();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TFeeSelectForm.OrgComboChange(Sender: TObject);
begin
   UpdateQuery();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TFeeSelectForm.StatBarUpdate;
begin
	StatusBar.Panels[0].Text := IntToStr(FeeListQuery.RecNo) + ' of ' + IntToStr(FeeListQuery.RecordCount);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TFeeSelectForm.UpdateQuery;
begin
	FeeListQuery.Update( OrgCombo.Text );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.

 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit	MasterData_BaseGridUnit;

interface uses
   constantsunit,
   masterdataunit,
   classes,
   sysutils,
   RecordStructureUnit,
   controls,
   graphics,
   forms,
   ErrorResultUnit,
   AvoBase_PopMenuUnit,
   grids,
   Toolbox_PreferenceToolBoxUnit,
   db,
   windows,
   dbgrids;

// good resource: http://delphi.about.com/od/usedbvcl/a/tdbgrid.htm

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

type
   tAvoBaseDBGrid = class( tdbgrid )
   private
      fToggleColor : boolean;
   	PopMenu : tAvoBase_PopMenu;
      gridDataSource : tDataSource;
      fKeyPressFieldName : string;
      procedure HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
      procedure HandleGridKeyPress( sender : tObject; var key : Char );
      procedure SetValues;
   public
      function Add ( inField : tField; inName : string; inWidth : integer; inColor : tColor; inStyle : TFontStyles; inAlign : TAlignment  ) : tErrorResult;
      procedure Clear;
      procedure DockGrid( inParent : tWinControl );
      //
      procedure Init( inParent : tWinControl; inDataSet : tDataSet; inFieldName : String ); overload;
      procedure Init( inParent : tWinControl); overload;
      procedure Init( inDataSet : tDataSet; inFieldName : string ); overload;
      //
      Constructor Create( owner: TComponent; inParent : tWinControl ); overload;
      Constructor Create( owner: TComponent; inParent : tWinControl; inDataSet : tDataSet; inFieldName : String ); overload;
      Destructor Destroy; OVERRIDE;
      //
      property keyPressFieldName : string read fKeyPressFieldName write fKeyPressFieldName;
   end;

implementation

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoBaseDBGrid.SetValues;
begin
   with Self do
   begin
      OnKeyPress := HandleGridKeyPress;
      //
      columns.RebuildColumns(); // this command pulls ALL of the fields, regardless. outside methods must clear and add for distinct.
      //
      ParentColor := false;
      ReadOnly := True;
      Align := tAlign(alClient);
      BorderStyle := TFormBorderStyle.bsNone;
      FixedColor := clCream;
      Options := [dgTitles,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,dgConfirmDelete,dgCancelOnExit];
      TitleFont.Name := 'MS Sans Serif';
      TitleFont.Size := 8;
      TitleFont.Pitch := fpDefault;
      TitleFont.Color := clBlack;
      Color := clWhite;
      //
   end;
end;

// This one allows the creation AND docking of the form
constructor tAvoBaseDBGrid.Create( Owner: TComponent; inParent : tWinControl; inDataSet : tDataSet; inFieldName : String );
begin
   Inherited Create( owner );
   //
   fToggleColor := Pref_GetBoolean(tPrefConstants.dbGridColorGridLines, false);
   gridDataSource := tDataSource.Create(nil);
   gridDataSource.DataSet := inDataSet;
   PopMenu := tAvoBase_PopMenu.Create( self );
   //
   with Self do
   begin
      PopupMenu := PopMenu;
		DataSource := GridDataSource;
      OnKeyPress := HandleGridKeyPress;
      keyPressFieldName := inFieldName;
      OnDrawColumnCell := HandleOnDrawCellEvent;
      //
      SetValues();
      //
      Parent := inParent;
      Show();
   end;
end;

// This one allows the creation, but does nothing else with it
constructor tAvoBaseDBGrid.Create(owner: TComponent; inParent : tWinControl );
begin
   Inherited Create( owner );
   //
   fToggleColor := Pref_GetBoolean(tPrefConstants.dbGridColorGridLines, True);
   PopMenu := tAvoBase_PopMenu.Create( self );
   gridDataSource := tDataSource.Create(nil);
   Self.Parent := inParent;
   Self.OnDrawColumnCell := HandleOnDrawCellEvent;
   SetValues();
   Show();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

destructor tAvoBaseDBGrid.Destroy;
begin
	FreeAndNil( PopMenu );
	FreeAndNil(gridDataSource);
   //
   inherited Destroy;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoBaseDBGrid.Init( inParent : tWinControl; inDataSet : tDataSet; inFieldName : String );
begin
   gridDataSource.DataSet := inDataSet;
   //
   with Self do
   begin
		DataSource := GridDataSource;
      OnKeyPress := HandleGridKeyPress;
      keyPressFieldName := inFieldName;
      //
      SetValues();
      //
      Parent := inParent;
      Show();
   end;
end;

procedure tAvoBaseDBGrid.Init(inParent: tWinControl);
begin
   with Self do
   begin
      Parent := inParent;
      Show();
   end;
end;

procedure tAvoBaseDBGrid.Init(inDataSet: tDataSet; inFieldName: string);
begin
   gridDataSource.DataSet := inDataSet;
   with Self do
   begin
		DataSource := GridDataSource;
      OnKeyPress := HandleGridKeyPress;
      keyPressFieldName := inFieldName;
      SetValues();
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

// this does the docking
procedure tAvoBaseDBGrid.DockGrid(inParent: tWinControl);
begin
   with Self do
   begin
		DataSource := GridDataSource;
      //
      Parent := inParent;
      Show();
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoBaseDBGrid.Clear;
begin
	Self.Columns.Clear();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tAvoBaseDBGrid.Add (inField : tField; inName : string; inWidth : integer; inColor : tColor; inStyle : TFontStyles; inAlign : TAlignment ) : tErrorResult;
begin
   result := Error_Init();
   Self.Columns.Add;
   With Self.Columns.Items[Self.Columns.Count -1] do
   begin
      {
      Field := inField;
      FieldName := inField.FieldName;
      Width := inWidth;
      Title.Caption := inName;
      Font.Color := inColor;
      Font.Style := inStyle;
      Title.Font.Name := 'Arial';
      Title.Font.Size := 8;
      Title.Font.Style := [fsBold];
      Title.Alignment := inAlign;
      Title.Color := $00FAEDE2;
		Alignment := inAlign;
      }
      Field := inField;
      FieldName := inField.FieldName;
      Width := inWidth;
      Title.Caption := inName;
      Font.Color := inColor;
      Font.Style := inStyle;
      Title.Font.Name := 'Verdana';
      Title.Font.Size := 8;
      Title.Font.Style := [fsBold];
      Title.Alignment := inAlign;
      Title.Color := clGray;
      Title.Font.Color := clWhite;
		Alignment := inAlign;
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoBaseDBGrid.HandleGridKeyPress(sender: tObject; var key: Char);
var
   keyP : string;
   keyV : string;
begin
	if (Self.DataSource.DataSet.RecordCount <> 0) then
   begin
      if (keyPressFieldName <> '') then
      begin
         keyP := UpperCase( key );
         keyV := Self.DataSource.DataSet.FieldByName(keyPressFieldName).AsString;
         if (KeyP[1] = keyV[1]) AND (Self.DataSource.DataSet.RecNo < Self.DataSource.DataSet.RecordCount) then
         begin
            Self.DataSource.DataSet.Next();
            keyV := Self.DataSource.DataSet.FieldByName(keyPressFieldName).AsString;
            if (KeyP[1] <> KeyV[1]) then
               Self.DataSource.DataSet.Locate(keyPressFieldName, KeyP, [loPartialKey]);
         end else
            Self.DataSource.DataSet.Locate(keyPressFieldName, KeyP, [loPartialKey]);
      end;
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoBaseDBGrid.HandleOnDrawCellEvent(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if ( fToggleColor ) then
      if ( Odd( Self.DataSource.DataSet.RecNo ) ) then
         if NOT (gdSelected in State) then
         begin
            Self.Canvas.Brush.Color := $00E5E5E5;
            Self.DefaultDrawColumnCell(Rect, DataCol, Column, State);
         end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

end.




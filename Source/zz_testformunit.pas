 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
 unit zz_testformunit;

interface uses
   toolboxunit,
   constantsunit,
   masterdataunit,
   inifileunit,
   img_storageformunit,
   errorresultunit,
   actionunit,
   masterdata_basegridunit,
   AvoBase_BaseForm_StandardUnit,
   masterdata_navigationtoolunit,
   //
   db,
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   ExtCtrls,
   ComCtrls,
   ToolWin, ActnList, Menus, Grids, DBGrids;


type
  TForm1 = class(TForm)
    ToolBar3: TToolBar;
    DbFirstButton: TToolButton;
    DbPriorButton: TToolButton;
    dbNextButton: TToolButton;
    dbLastButton: TToolButton;
    navActionList: TActionList;
    PopupMenu1: TPopupMenu;
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.


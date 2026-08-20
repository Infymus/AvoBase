 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

UNIT  IMG_StorageFormUnit;

INTERFACE USES
  windows,
  messages,
  sysutils,
  variants,
  classes,
  graphics,
  controls,
  forms,
  dialogs,
  imglist,
  stdctrls,
  comctrls,
  toolwin;

// these contstanst conform to the Avobase_Toolbar_Img ONLY and are for menu and action items.
const
   IMG_NEW              = 0 ;
   IMG_EDIT             = 1 ;
   IMG_SAVE             = 2 ;
   IMG_CANCEL           = 3 ;
   IMG_CLOSE            = 4 ;
   IMG_BLUE_DB          = 5 ;
   IMG_REDO_BOX         = 6 ;
   IMG_PAGE             = 7 ;
   IMG_PRINT            = 8 ;
   IMG_DELETE           = 9 ;
   IMG_CHECK            = 10;
   IMG_ORANGE_DB        = 11;
   IMG_CUST             = 12;
   IMG_BROCHURE         = 13;
   IMG_CREDIT           = 14;
   IMG_SEARCH           = 15;
   IMG_IDEA             = 16;
   IMG_HOME             = 17;
   IMG_RED_ARROWL       = 18;
   IMG_RED_ARROWR       = 19;
   IMG_REDO_WHITE       = 20;
   IMG_GREEN_ARROWR     = 21;
   IMG_CUST_ACTIVE      = 22;
   IMG_EMAIL            = 23;
   IMG_HELP             = 24;
   IMG_EMAIL2           = 25;
   IMG_ENVELOPE         = 26;
   IMG_PAINT            = 27;
   IMG_CUST_UNK         = 28;
   IMG_FONTA            = 29;
   IMG_BOLD             = 30;
   IMG_UNDERLINE        = 31;
   IMG_ITALIC           = 32;
   IMG_NEW_PAGE         = 33;
   IMG_PRODUCT          = 34;
   IMG_SALE             = 35;
   IMG_PAGE_BLANK       = 36;
   IMG_CART             = 37;
   IMG_CALENDAR         = 38;
   IMG_EXPENSE          = 39;
   IMG_REPORT           = 40;
   IMG_CUST_REDO        = 41;
   IMG_KEYS             = 42;
   IMG_TOOLS            = 43;
   IMG_FILE             = 44;
   IMG_ARRLOW_BLACK     = 45;
   IMG_ARROWR_BLACK     = 46;
   IMG_ARROWD_BLACK     = 47;
   IMG_ARROWU_BLACK     = 48;
   IMG_NAV_LAST         = 49;
   IMG_NAV_FIRST        = 50;
   IMG_NAV_NEXT         = 51;
   IMG_NAV_PRIOR        = 52;
   IMG_EXP_TYPE         = 57;
   IMG_TAKE_PAYMENT     = 59;
   IMG_CUST_DOUBLE      = 60;
   IMG_VOID             = 62;
   IMG_BO               = 63;
   IMG_YES              = 70;
   IMG_NO               = 71;
   IMG_ORDER_FINALIZE   = 64;
   IMG_PO_RETURN        = 65;
   IMG_PO_RESTOCK       = 54;
   IMG_REPORT3          = 66;
   IMG_REGISTER         = 69;
   IMG_OK               = 72;
   IMG_WEB              = 67;
   IMG_FILE_EXPORT      = 79;
   IMG_FILE_IMPORT      = 80;
   IMG_CASH 			 	= 68;

type
  tIMG_StorageForm = class(tForm)
    Avobase_25x25_Images: TImageList;
    AvoBase_50x50_Images: TImageList;
    Disable_Img: TImageList;
    Avobase_ToolBar_Img: TImageList;
    AvoBase_Delphi_Images: TImageList;
    AvoBase_30x30_Images: TImageList;
    Disabl_img_25x25: TImageList;
    Disable_Img_50x50: TImageList;
    AvoBase_30x30_DisabledImages: TImageList;
    AvoBase_20x20_Images: TImageList;
  end;

var
  img_StorageForm : tIMG_StorageForm;

IMPLEMENTATION

{$R *.dfm}

end.

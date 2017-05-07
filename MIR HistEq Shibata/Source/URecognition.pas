unit URecognition;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles, UPPED, Menus, ExtDlgs, SyncObjs, Math,
  DateUtils;

const
  landmarks: array[1..10] of string =
                ('Porion','Gnation','Gonion','Menton','Nasion',
                 'Orbital','Pogonion','PointA','PointB','Sella');

  MaxPixelCount = 65536;

type
  TFRecognition = class(TForm)
    Panel1: TPanel;
    pnQueryJudul: TPanel;
    Panel4: TPanel;
    imgQuery: TImage;
    ckLandmark1: TCheckBox;
    shpLandmark1: TShape;
    ckLandmark2: TCheckBox;
    shpLandmark2: TShape;
    ckLandmark3: TCheckBox;
    shpLandmark3: TShape;
    ckLandmark4: TCheckBox;
    shpLandmark4: TShape;
    ckLandmark5: TCheckBox;
    shpLandmark5: TShape;
    ckLandmark6: TCheckBox;
    shpLandmark6: TShape;
    ckLandmark7: TCheckBox;
    shpLandmark7: TShape;
    ckLandmark8: TCheckBox;
    shpLandmark8: TShape;
    ckLandmark9: TCheckBox;
    shpLandmark9: TShape;
    ckLandmark10: TCheckBox;
    shpLandmark10: TShape;
    popQuery: TPopupMenu;
    LoadImage1: TMenuItem;
    Recognize1: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    Timer1: TTimer;
    lbScanProgres: TLabel;
    Rescale1: TMenuItem;
    EnhanceContrast1: TMenuItem;
    ConvertColorMode1: TMenuItem;
    Save1: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure shpLandmark1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LoadImage1Click(Sender: TObject);
    procedure popQueryPopup(Sender: TObject);
    procedure Recognize1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ckLandmark1Click(Sender: TObject);
    procedure Rescale1Click(Sender: TObject);
    procedure EnhanceContrast1Click(Sender: TObject);
    procedure ConvertColorMode1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vkTemplate: array of array of arr64;
    bmpQuery, bmpCitra, bmpRescale, bmpHisteq, bmpScanning: TBitmap;
    matRescale,matHisteq, matQuery: array of array of Byte;
    matSkor: array of array of array of Double;
    cntH,cntV, cntHV: integer;
    posHasil: array of TPoint;
    FCriticalSection: TCriticalSection;
    FPosX,FPosY,FCntPos: Integer;
    FSkor: array[0..9] of Double;
    isScanning: Boolean;
    waktuMulai: TDateTime;
    PC, PH: PByteArray;
    c, cKum: array [0..255] of integer;
    Ko : array [0..255] of byte;
    //TRGBArray : array [0..MaxPixelCount-1] OF TRGBTriple;
    //pRGBArray : ^TRGBArray;
    procedure UpdateHasilScan;
  end;

var
  FRecognition: TFRecognition;

implementation

uses UTrdScan;

{$R *.dfm}

// create form
procedure TFRecognition.FormCreate(Sender: TObject);
begin
  bmpRescale:= TBitmap.Create;
  bmpHisteq:= TBitmap.Create;
  bmpCitra:= TBitmap.Create;
  bmpQuery:= TBitmap.Create;
  bmpScanning:= TBitmap.Create;
  FCriticalSection:= TCriticalSection.Create;
  DoubleBuffered:= True;
end;

// Ambil vektor PPED citra template yang ada di database
procedure TFRecognition.FormShow(Sender: TObject);       // prosedur untuk menampilkan form Recognition
var pped: TIniFile;
    templates: TStrings;
    i,n,x: integer;
begin
  bmpRescale.FreeImage;
  imgQuery.Picture:= nil;

  templates:= TStringList.Create;
  vkTemplate:= nil;
  SetLength(vkTemplate,10);
  matSkor:= nil;
  matRescale:= nil;
  posHasil:= nil;
  isScanning:= False;

  for i:= 0 to 9 do          // i = jumlah titik landmark
  begin
    TCheckBox(FindComponent('ckLandmark'+IntToStr(i+1))).Checked:= True;
    pped:= TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Template\' + landmarks[i+1] + '\pped.ini');
    pped.ReadSections(templates);
    if(templates.Count = 0)then Continue;

    SetLength(vkTemplate[i],templates.Count);
    for n:= 0 to templates.Count-1 do        // ambil vektor pped citra template yang ada di database
      for x:= 0 to 63 do
        vkTemplate[i][n][x]:= pped.ReadInteger(templates[n],IntToStr(x),0);

    pped.Free;
  end;

  templates.Free;
end;

procedure TFRecognition.shpLandmark1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
end;

// load citra uji
procedure TFRecognition.LoadImage1Click(Sender: TObject);     // prosedur untuk me-load citra query
begin
  if(OpenPictureDialog1.Execute)then       // jika window open dialog di eksekusi, maka
  try
    Screen.Cursor:= crHourGlass;
    bmpRescale.LoadFromFile(OpenPictureDialog1.FileName);   // load citra query dan namakan sebagai variabel bmpQuery
    bmpRescale.PixelFormat:= pf8bit;       // format citra = bmp 24 bit
    //bmpHisteq.Assign(bmpRescale);
    {matQuery:= nil;
    SetLength(matQuery,bmpQuery.Width,bmpQuery.Height);   // setting panjang matQuery seukuran dengan nilai lebar dan tinggi bmp.query
    for i:= 0 to bmpQuery.Width-1 do                      // ukuran matQuery = 700x800
      for j:= 0 to bmpQuery.Height-1 do
        matQuery[i,j]:= bmpQuery.Canvas.Pixels[i,j] mod $100;
    }
    imgQuery.Picture.Assign(bmpRescale);   // panel imgQuery ditempati bmpQuery
    pnQueryJudul.Caption:= 'Image Query ('+IntToStr(bmpRescale.Width)+'x'+IntToStr(bmpRescale.Height)+')';

    posHasil:= nil;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TFRecognition.popQueryPopup(Sender: TObject);   // popup Recognize hanya akan ditampilkan jika citra query sudah di load
begin
  Recognize1.Visible:= not(bmpQuery.Empty);
end;

// pencocokan vektor PPED citra template dan citra uji
procedure TFRecognition.Recognize1Click(Sender: TObject);    // prosedur ini akan dieksekusi jika tombol Recognize pada popup di klik
var a, b, i: integer;
begin
  imgQuery.Picture.Assign(bmpQuery);   // imgQuery ditempati oleh bmpQuery
  bmpScanning.Assign(bmpQuery);        // bmpScanning ditempati oleh bmpQuery

  matQuery:= nil;
  SetLength(matQuery,bmpQuery.Width,bmpQuery.Height);
  for a:= 0 to bmpQuery.Width-1 do
    for b:= 0 to bmpQuery.Height-1 do
      matQuery[a,b]:= bmpQuery.Canvas.Pixels[a,b] mod $100;

  cntH:= 1 + (bmpQuery.Width - 68) shr 3;     // cntH = 1 + (700-68)/8 = 80
  cntV:= 1 + (bmpQuery.Height - 68) shr 3;    // cntV = 1 + (800-68)/8 = 92
  cntHV:= cntH * cntV;                        // cntHV = 732
  matSkor:= nil;
  SetLength(matSkor,10,cntH,cntV);            // matSkor = 10 (titik landmark) dengan masing-masing landamrk pada arah horizontal setiap blok 68x68 nya berjumlah 80
  FCntPos:= 0;                                // dan arah vertikal berjumlah 92
  waktuMulai:= Now;
  isScanning:= True;
  imgQuery.PopupMenu:= nil;

  for i:= 0 to cntH-1 do          // untuk i = 0 sampai 79
  begin                           // EKSEKUSI THREADING
    TTrdScan.Create(i,cntV);
  end;
end;

// scanning (warna hijau)
procedure TFRecognition.UpdateHasilScan;
var i,j: Integer;
begin
  for i:= 0 to 9 do
    matSkor[i,FPosX,FPosY]:= FSkor[i];

  for j:= (FPosY shl 3 + 30) to (FPosY shl 3 + 37) do
    for i:= (FPosX shl 3 + 30) to (FPosX shl 3 + 37) do
      bmpScanning.Canvas.Pixels[i,j]:= bmpScanning.Canvas.Pixels[i,j] and $00FF00;
end;

//penentuan hasil identifikasi posisi landmark dengan jarak Euc paling minimum
procedure TFRecognition.Timer1Timer(Sender: TObject);
var d: Double;
    i,x,y: Integer;
begin
  if(isScanning)then
  begin
    imgQuery.Picture.Assign(bmpScanning);
    lbScanProgres.Caption:= 'Scanning ' + IntToStr(FCntPos)
                            + ' of ' + IntToStr(cntHV)+ ' ('
                            + IntToStr(SecondsBetween(waktuMulai,Now)) + ' sec.)';
    if(FCntPos >= cntHV)then
    begin
      SetLength(posHasil,10);
      for i:= 0 to 9 do
      begin
        posHasil[i].X:= 0;
        posHasil[i].Y:= 0;
        if(vkTemplate[i] = nil)then Continue;
        d:= matSkor[i,0,0];
        for x:= 0 to cntH-1 do
          for y:= 0 to cntV-1 do
            if(matSkor[i,x,y] < d)then
            begin
              d:= matSkor[i,x,y];
              posHasil[i].X:= x;               // posisi identifikasi landmark 
              posHasil[i].Y:= y;
            end;
      end;
      isScanning:= False;

      ckLandmark1Click(ckLandmark1);
      imgQuery.PopupMenu:= popQuery;
      //ShowMessage('SELESAI');
    end;
  end;

end;

// gambar bulat posisi titik landmark teridentifikasi
procedure TFRecognition.ckLandmark1Click(Sender: TObject);
var i: Integer;
begin
  if(isScanning)or(posHasil = nil)then Exit;

  bmpScanning.Assign(bmpQuery);
  for i:= 0 to 9 do
  begin
    if(vkTemplate[i] = nil)or(not TCheckBox(FindComponent('ckLandmark'+IntToStr(i+1))).Checked)then
      Continue;
    bmpScanning.Canvas.Brush.Color:= TShape(FindComponent('shpLandmark'+IntToStr(i+1))).Brush.Color;
    bmpScanning.Canvas.Pen.Color:= TShape(FindComponent('shpLandmark'+IntToStr(i+1))).Pen.Color;
    bmpScanning.Canvas.Ellipse(posHasil[i].X shl 3 + 29,posHasil[i].Y shl 3 + 29,
                              posHasil[i].X shl 3 + 38,posHasil[i].Y shl 3 + 38);
  end;
  imgQuery.Picture.Assign(bmpScanning);
end;

// RESCALE
procedure TFRecognition.Rescale1Click(Sender: TObject);
const
     wScale = 0.3;
     hScale = 0.3;
var a, b, i, j, x, y, x1, y1, wRescale, hRescale : integer;
    xasal, yasal : real;

begin
  imgQuery.Picture.Assign(bmpRescale);
  bmpHisteq.Assign(bmpRescale);

  wRescale:= Round(bmpRescale.Width * wScale);        // 2300 x 0.3
  hRescale:= Round(bmpRescale.Height * hScale);       // 2900 x 0.3
  bmpHisteq.Width:= wRescale;
  bmpHisteq.Height:= hRescale;

  SetLength(matRescale, bmpRescale.Width, bmpRescale.Height);
  SetLength(matHisteq, bmpHisteq.Width, bmpHisteq.Height);
  pnQueryJudul.Caption:= 'Image Query ('+IntToStr(bmpHisteq.Width)+'x'+IntToStr(bmpHisteq.Height)+')';

  for b:=0 to bmpRescale.Height-1 do
  begin
    PC:= bmpRescale.ScanLine[b];
    for a:=0 to bmpRescale.Width-1 do
      matRescale[a,b]:= PC[a];
  end;

  for x1:= 0 to wRescale-1 do
    for y1:=0 to hRescale-1 do
    begin
      xasal:= x1/wScale;
      yasal:= y1/hScale;
        x:= round(xasal);
        y:= round(yasal);
        matHisteq[x1,y1]:= matRescale[x,y];
    end;

  for j:=0 to hRescale-1 do
  begin
    PH:= bmpHisteq.ScanLine[j];
    for i:=0 to wRescale-1 do
      PH[i]:= matHisteq[i,j];
  end;

  matHisteq:= nil;
  matRescale:= nil;
  imgQuery.Picture.Assign(bmpHisteq);

end;

//ENHANCE CONTRAST
procedure TFRecognition.EnhanceContrast1Click(Sender: TObject);
var i, j, w, h : integer;
begin
  imgQuery.Picture.Assign(bmpHisteq);
  bmpCitra.Assign(bmpHisteq);

  w := bmpHisteq.Width;
  h := bmpHisteq.Height;

  for i := 0 to 255 do
    c[i] := 0;

  for j:= 0 to bmpHisteq.Height-1 do
    begin
      PC := bmpHisteq.ScanLine[j];
      for i:= 0 to bmpHisteq.Width-1 do
        Inc(c[PC[i]]);
    end;

  cKum[0] := c[0];
  for i := 1 to 255 do
    cKum[i] := cKum[i-1] + c[i];
  for i := 0 to 255 do
    Ko[i] := Round(255*cKum[i]/(w*h));
  for j:= 0 to bmpHisteq.Height-1 do
    begin
      PC := bmpHisteq.ScanLine[j];
      PH := bmpCitra.ScanLine[j];
      for i:= 0 to bmpHisteq.Width-1 do
         PH[i] := Ko[PC[i]];
    end;
    imgQuery.Picture.Assign(bmpCitra);
end;

// KONVERSI MODE WARNA
procedure TFRecognition.ConvertColorMode1Click(Sender: TObject);
var i,j:integer;
begin
  imgQuery.Picture.Assign(bmpCitra);
  bmpQuery.Width:= bmpCitra.Width;
  bmpQuery.Height:= bmpCitra.Height;
  bmpQuery.PixelFormat:= pf24bit;

  for j:=0 to (bmpCitra.Height-1) do
    begin
      PC:= bmpCitra.ScanLine[j];
      PH:= bmpQuery.ScanLine[j];

    for i:=0 to (bmpCitra.Width-1) do
      begin
          PH[3*i]:= PC[i];
          PH[3*i+1]:= PC[i];
          PH[3*i+2]:= PC[i];
      end;
      imgQuery.Picture.Assign(bmpQuery);
    end;

end;

procedure TFRecognition.Save1Click(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
    imgQuery.Picture.SaveToFile(SavePictureDialog1.FileName);
end;

end.

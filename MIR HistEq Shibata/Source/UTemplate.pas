unit UTemplate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, Menus, Grids, ExtCtrls, Buttons, StdCtrls, IniFiles, UPPED;

const
  landmarks: array[1..10] of string =
                ('Porion','Gnation','Gonion','Menton','Nasion',
                 'Orbital','Pogonion','PointA','PointB','Sella');

type
  TFTemplate = class(TForm)
    pnJudul: TPanel;
    Panel3: TPanel;
    gridTemplate: TDrawGrid;
    popTemplate: TPopupMenu;
    Refresh1: TMenuItem;
    N1: TMenuItem;
    ambahTemplate1: TMenuItem;
    HapusTemplate1: TMenuItem;
    HapusSemuaTemplate1: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel1: TPanel;
    btLandmark1: TSpeedButton;
    btLandmark2: TSpeedButton;
    btLandmark3: TSpeedButton;
    btLandmark4: TSpeedButton;
    btLandmark5: TSpeedButton;
    btLandmark6: TSpeedButton;
    btLandmark7: TSpeedButton;
    btLandmark8: TSpeedButton;
    btLandmark9: TSpeedButton;
    btLandmark10: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btLandmark1Click(Sender: TObject);
    procedure gridTemplateDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure gridTemplateMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure popTemplatePopup(Sender: TObject);
    procedure ambahTemplate1Click(Sender: TObject);
    procedure HapusTemplate1Click(Sender: TObject);
    procedure HapusSemuaTemplate1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idxLandmark: integer;
    lsTemplate: TStrings;
    procedure RefreshTemplateFiles;
    procedure ShowTemplates;
    procedure UpdateTemplateVectors;
  end;

var
  FTemplate: TFTemplate;

implementation

{$R *.dfm}

// Buat Form
procedure TFTemplate.FormShow(Sender: TObject);
var i: integer;
    strFolder: string;
begin
  lsTemplate:= TStringList.Create;
  gridTemplate.ColWidths[1]:= 70;
  gridTemplate.ColWidths[2]:= 200;
  gridTemplate.RowCount:= 2;
  gridTemplate.Canvas.Font.Style:= [fsBold];
  gridTemplate.Canvas.Font.Name:= 'tahoma';
  strFolder:= ExtractFilePath(Application.ExeName) + 'Template\';
  if(not DirectoryExists(strFolder))then
    CreateDir(strFolder);
  for i:= 1 to 10 do
  begin
    strFolder:= ExtractFilePath(Application.ExeName) + 'Template\' + landmarks[i] + '\';
    if(not DirectoryExists(strFolder))then
      CreateDir(strFolder);
  end;

  btLandmark1.Down:= True;
  btLandmark1.Click;
end;

procedure TFTemplate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  lsTemplate.Free;
end;

procedure TFTemplate.btLandmark1Click(Sender: TObject);
var i: integer;
begin
  for i:= 1 to 10 do
  with TSpeedButton(FindComponent('btLandmark'+IntToStr(i))) do
    if Down then
    begin
      Font.Color:= $001E69D2;
      idxLandmark:= i;
      pnJudul.Caption:= 'Daftar Template Untuk ' + Caption;
    end
    else
      Font.Color:= $001F2B3D;
  Application.ProcessMessages;

  ShowTemplates;
end;

// refresh template
procedure TFTemplate.RefreshTemplateFiles;
var i: Integer;
    SearchRec: TSearchRec;
begin
  lsTemplate.Clear;

  i:= FindFirst(ExtractFilePath(Application.ExeName) + 'Template\' + landmarks[idxLandmark] + '\*.bmp', faAnyFile, SearchRec);
  while i = 0 do
  begin
    lsTemplate.Add(ExtractFilePath(Application.ExeName) + 'Template\' + landmarks[idxLandmark] + '\' + SearchRec.Name);
    i:= FindNext(SearchRec);
  end;
  FindClose(SearchRec);
end;

procedure TFTemplate.ShowTemplates;
var i: Integer;
begin
  RefreshTemplateFiles;
  gridTemplate.RowCount:= 2;
  gridTemplate.Refresh;
  if(lsTemplate.Count = 0)then
    Exit;

  gridTemplate.RowCount:=  lsTemplate.Count + 1;

  for i:= 1 to lsTemplate.Count do
  begin
    gridTemplate.RowHeights[i]:= 70;
  end;
  gridTemplate.Refresh;
end;

// ekstraksi vektor PPED citra template
procedure TFTemplate.UpdateTemplateVectors;
var pped: TIniFile;
    i,x,y: integer;
    st: string;
    bmp: TBitmap;
    sumber: mat68;
    vector: arr64;
begin
  RefreshTemplateFiles;

  DeleteFile(ExtractFilePath(Application.ExeName) + 'Template\' + landmarks[idxLandmark] + '\pped.ini');
  if(lsTemplate.Count = 0)then
    Exit;

  Screen.Cursor:= crHourGlass;
  //buat file pped.ini
  pped:= TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Template\' + landmarks[idxLandmark] + '\pped.ini');
  bmp:= TBitmap.Create;
  for i:= 0 to lsTemplate.Count-1 do
  begin
    bmp.LoadFromFile(lsTemplate[i]);
    for x:= 0 to 67 do
      for y:= 0 to 67 do
        sumber[x,y]:= bmp.Canvas.Pixels[x,y] mod $100;   // ambil nilai piksel red saja
    GeneratePPEDVector(sumber,vector);                   // generate vektor PPED nya
    st:= ChangeFileExt(ExtractFileName(lsTemplate[i]),'');
    for x:= 0 to 63 do
      pped.WriteInteger(st,IntToStr(x),vector[x]);
  end;
  bmp.Free;
  pped.Free;

  ShowTemplates;
  Screen.Cursor:= crDefault;
end;

// buat tabel daftar template
procedure TFTemplate.gridTemplateDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var bmp: TBitmap;
    pped: TIniFile;
    i,x,maks: integer;
    st: string;
begin
  with gridTemplate do
  begin
    Canvas.FillRect(Rect);
    if(ACol = 1)and(ARow = 0)then
      Canvas.TextOut(Rect.Left + 5, Rect.Top + 3,'TEMPLATE');
    if(ACol = 2)and(ARow = 0)then
      Canvas.TextOut(Rect.Left + 5, Rect.Top + 3,'PPED VECTOR');
    if(ACol = 1)and(ARow > 0)and(lsTemplate.Count >= ARow)and(FileExists(lsTemplate[ARow-1]))then
    begin
      bmp:= TBitmap.Create;
      bmp.LoadFromFile(lsTemplate[ARow-1]);      // tampilkan image citra templatenya
      Canvas.Draw(Rect.Left+1,Rect.Top+1,bmp);
      Canvas.TextOut(Rect.Left + 2, Rect.Top,IntToStr(ARow));
      bmp.Free;
    end;
    if(ACol = 2)and(ARow > 0)and(lsTemplate.Count >= ARow)then
    begin
      pped:= TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Template\' + landmarks[idxLandmark] + '\pped.ini');  // ekstrak vektor PPED
      st:= ChangeFileExt(ExtractFileName(lsTemplate[ARow-1]),'');
      Canvas.Pen.Width:= 2;
      Canvas.Pen.Color:= clPurple;
      maks:= 0;
      for x:= 0 to 63 do
      begin
        i:= pped.ReadInteger(st,IntToStr(x),0);
        if(maks < i)then  maks:= i;
      end;
      for x:= 0 to 63 do
      begin
        i:= pped.ReadInteger(st,IntToStr(x),0);
        if(i = 0)then Continue;
        i:= Round(i*64/maks);
        Canvas.MoveTo(Rect.Left + 5 + 3*x,Rect.Top+68);
        Canvas.LineTo(Rect.Left + 5 + 3*x,Rect.Top+68-i);
      end;
      pped.Free;
    end;
    if gdFocused in State then
      Canvas.DrawFocusRect(Rect);
  end;
end;

procedure TFTemplate.gridTemplateMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var c,r: integer;
begin
  gridTemplate.MouseToCell(X,Y,c,r);
  gridTemplate.Tag:= r;
end;

procedure TFTemplate.popTemplatePopup(Sender: TObject);
begin
  HapusTemplate1.Visible:= (lsTemplate.Count > 0);
  HapusSemuaTemplate1.Visible:= HapusTemplate1.Visible;
  HapusTemplate1.Caption:= 'Hapus Template-' + IntToStr(gridTemplate.Tag);
end;

procedure TFTemplate.ambahTemplate1Click(Sender: TObject);
begin
  if(OpenPictureDialog1.Execute)then
  begin
    CopyFile(PChar(OpenPictureDialog1.FileName),
             PChar(ExtractFilePath(Application.ExeName) + 'Template\' + landmarks[idxLandmark] + '\' + FormatDateTime('yyyymmdd-hhnnss".bmp"',Now)),
             False);
    UpdateTemplateVectors;
  end;
end;

procedure TFTemplate.HapusTemplate1Click(Sender: TObject);
var pped: TIniFile;
    st: string;
begin
  if(MessageDlg('Anda yakin ingin menghapus Template-'+IntToStr(gridTemplate.Tag)+' ?',mtConfirmation,mbOKCancel,0) = mrOK)then
  begin
    DeleteFile(lsTemplate[gridTemplate.Tag-1]);
    pped:= TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Template\' + landmarks[idxLandmark] + '\pped.ini');
    st:= ChangeFileExt(ExtractFileName(lsTemplate[gridTemplate.Tag-1]),'');
    pped.EraseSection(st);
    pped.Free;
    ShowTemplates;
  end;
end;


procedure TFTemplate.HapusSemuaTemplate1Click(Sender: TObject);
var i: integer;
begin
  if(MessageDlg('Anda yakin ingin menghapus Semua Template ?',mtConfirmation,mbOKCancel,0) = mrOK)then
  begin
    for i:= 0 to lsTemplate.Count-1 do
      DeleteFile(lsTemplate[i]);
    DeleteFile(ExtractFilePath(Application.ExeName) + 'Template\' + landmarks[idxLandmark] + '\pped.ini');
    ShowTemplates;
  end;
end;

end.

unit UTrdScan;

interface

uses
  Classes, UPPED, URecognition;

type
  TTrdScan = class(TThread)
  private
    { Private declarations }
    posX, cntV: Integer;
    vkTemplate: array of array of arr64;
    matQuery: array of array of Byte;
    sumber: mat68;
    vector: arr64;
    dist: array[0..9] of Double;
  protected
    procedure Execute; override;
  public
    constructor Create(x,cntV: integer);
  end;

implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TTrdScan.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TTrdScan }

// BIKIN THREAD
constructor TTrdScan.Create(x,cntV: integer);      // prosedur untuk 
var i,j,k: Integer;
begin
  posX:= x;
  Self.cntV:= cntV;

  SetLength(vkTemplate,10);    // vkTemplate = 10
  for i:= 0 to 9 do            // i = jumlah titik landmark: 10
  begin
    if(FRecognition.vkTemplate[i] = nil)then Continue;
    SetLength(vkTemplate[i],Length(FRecognition.vkTemplate[i]));
    for j:= Low(FRecognition.vkTemplate[i]) to High(FRecognition.vkTemplate[i]) do     //dari form Recognition
      for k:= 0 to 63 do
        vkTemplate[i][j][k]:= FRecognition.vkTemplate[i][j][k];     // AMbil nilai vektor template
  end;

  SetLength(matQuery,68,Length(FRecognition.matQuery[0]));
  for i:= Low(matQuery) to High(matQuery) do
    for j:= Low(matQuery[i]) to High(matQuery[i]) do
      matQuery[i,j]:= FRecognition.matQuery[posX shl 3 + i, j];

  FreeOnTerminate:= True;
  inherited Create(False);
end;

// PROSES ektraksi vektor PPED citra uji n perhitungan jarak Euc
procedure TTrdScan.Execute;
var i,j,x,y, posY: Integer;
    d: Double;
begin
  { Place thread code here }
  for posY:= 0 to cntV-1 do          // posY = blok 68x68 pix citra uji
  begin
    for x:= 0 to 67 do
      for y:= 0 to 67 do
        sumber[x,y]:= matQuery[x, posY shl 3 + y];   // generate vektor PPED citra uji
    GeneratePPEDVector(sumber,vector);

    for i:= 0 to 9 do                                // hitung jarak Euc vektor PPED citra uji dengan vektor PPED citra template
    begin
      if(vkTemplate[i] = nil)then Continue;
      for j:= 0 to Length(vkTemplate[i])-1 do
      begin
        d:= Euclidean(vector,vkTemplate[i][j]);
        if(j = 0)then
          dist[i]:= d
        else if(d < dist[i])then
          dist[i]:= d;
      end;
    end;

    FRecognition.FCriticalSection.Enter;
    try
      FRecognition.FPosX:= posX;
      FRecognition.FPosY:= posY;
      FRecognition.FCntPos:= FRecognition.FCntPos + 1;
      for i:= 0 to 9 do
        FRecognition.FSkor[i]:= dist[i];             
      Synchronize(FRecognition.UpdateHasilScan);
    finally
      FRecognition.FCriticalSection.Leave;
    end;
  end;
end;

end.

unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFMain = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    btTemplate: TButton;
    btRecognize: TButton;
    btExit: TButton;
    procedure btTemplateClick(Sender: TObject);
    procedure btRecognizeClick(Sender: TObject);
    procedure btExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

uses URecognition, UTemplate;

{$R *.dfm}

procedure TFMain.btTemplateClick(Sender: TObject);
begin
  FTemplate.ShowModal;
end;

procedure TFMain.btRecognizeClick(Sender: TObject);
begin
  FRecognition.ShowModal;
end;

procedure TFMain.btExitClick(Sender: TObject);
begin
  Close;
end;

end.

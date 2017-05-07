program MIR;

uses
  Forms,
  UMain in 'UMain.pas' {FMain},
  UPPED in 'UPPED.pas',
  UTemplate in 'UTemplate.pas' {FTemplate},
  URecognition in 'URecognition.pas' {FRecognition},
  UTrdScan in 'UTrdScan.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFTemplate, FTemplate);
  Application.CreateForm(TFRecognition, FRecognition);
  Application.Run;
end.

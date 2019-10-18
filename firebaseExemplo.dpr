program firebaseExemplo;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {Form2},
  Firebase.Auth in 'FireBase\Firebase.Auth.pas',
  Firebase.Database in 'FireBase\Firebase.Database.pas',
  Firebase.Interfaces in 'FireBase\Firebase.Interfaces.pas',
  Firebase.Request in 'FireBase\Firebase.Request.pas',
  Firebase.Response in 'FireBase\Firebase.Response.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

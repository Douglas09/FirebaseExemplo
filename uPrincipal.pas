unit uPrincipal;

interface

uses
  //USES FIREBASE (CLASSES DO FIREBASE DESENVOLVIDAS POR AUTOR ANÔNIMO)
  Firebase.Auth, Firebase.Database, Firebase.Interfaces, Firebase.Request, Firebase.Response,

  System.Json,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.StdCtrls, FMX.ScrollBox,
  FMX.Memo;

type
  TForm2 = class(TForm)
    Layout1: TLayout;
    Text1: TText;
    edtURL: TEdit;
    Rectangle1: TRectangle;
    Text2: TText;
    Text3: TText;
    edtRamo: TEdit;
    VertScrollBox1: TVertScrollBox;
    Layout2: TLayout;
    Text4: TText;
    edtNome: TEdit;
    Text5: TText;
    edtEmail: TEdit;
    Text6: TText;
    edtApelido: TEdit;
    Layout3: TLayout;
    btnPost: TButton;
    rcInferior: TRectangle;
    Text7: TText;
    memRetorno: TMemo;
    edtJSON: TEdit;
    btnPut: TButton;
    btnGet: TButton;
    Text8: TText;
    btnInfo: TButton;
    procedure btnPostClick(Sender: TObject);
    procedure btnPutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure btnInfoClick(Sender: TObject);
  private
    { Private declarations }
    baseURL : String;
    FFC: IFirebaseDatabase;
    FFR: IFirebaseResponse;

    procedure atualizarBaseURL;
    procedure validarCampos(Method : String);
  public
    { Public declarations }
    function getJson : TJSonObject;
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.atualizarBaseURL;
begin
   if (edtRamo.Text = '') then
   begin
      showMessage('DEFINA SEU RAMO...');
      edtRamo.SetFocus;
      Abort;
   end;

   if (Copy(edtURL.Text, length(edtURL.Text), 1) <> '/') then
      edtURL.Text := edtURL.Text + '/';

   baseURL := edtURL.Text + edtRamo.Text;

   if (Copy(baseURL, length(baseURL), 1) <> '/') then
      baseURL := baseURL + '/';

   FFC.SetBaseURI(baseURL);
end;

procedure TForm2.btnGetClick(Sender: TObject);
begin
  atualizarBaseURL;
  validarCampos('GET');
  FFR := FFC.Get(['.json']);

  edtJSON.Text := baseURL + '.json';
  memRetorno.Lines.Clear;
  memRetorno.Lines.Add( FFR.ContentAsString(TEncoding.UTF8) );
end;

procedure TForm2.btnInfoClick(Sender: TObject);
begin
  showMessage('Dados' +sLineBreak+sLineBreak+
              'Douglas Colombo' +sLineBreak+
              'douglascolombo09@gmail.com' +sLineBreak+
              '(51) 99550-2636');
end;

procedure TForm2.btnPostClick(Sender: TObject);
begin
   atualizarBaseURL;
   validarCampos('POST');
   FFR := FFC.Post(['.json'], getJson);

   edtJSON.Text := baseURL + '.json';
   memRetorno.Lines.Clear;
   memRetorno.Lines.Add( FFR.ContentAsString(TEncoding.UTF8) );
end;

procedure TForm2.btnPutClick(Sender: TObject);
begin
   atualizarBaseURL;
   validarCampos('PUT');
   FFR := FFC.Put(['.json'], getJson);

   edtJSON.Text := baseURL + '.json';
   memRetorno.Lines.Clear;
   memRetorno.Lines.Add( FFR.ContentAsString(TEncoding.UTF8) );
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  FFC := TFirebaseDatabase.Create;
end;

procedure TForm2.FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  VertScrollBox1.Margins.Bottom := 0;
end;

procedure TForm2.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  VertScrollBox1.Margins.Bottom := (Bounds.Height - rcInferior.Height) + 6;
end;

function TForm2.getJson : TJSonObject;
begin
   //GERA JSON PARA ENVIAR AO FIREBASE
   result := TJSONObject.Create;
   result.AddPair('APELIDO', edtApelido.Text);
   result.AddPair('NOME', edtNome.Text);
   result.AddPair('EMAIL', edtEmail.Text);
end;

procedure TForm2.validarCampos(Method : String);
begin
   if (edtURL.Text = '') then
   begin
      showMessage('Informe uma URL do Firebase...');
      edtEmail.SetFocus;
      Abort;
   end else if (edtRamo.Text = '') then
   begin
      showMessage('Informe um nome ao repositório...');
      edtEmail.SetFocus;
      Abort;
   end;

   if (Method <> 'GET') then
   begin
      if (edtEmail.Text = '') then
      begin
         showMessage('Informe um e-mail...');
         edtEmail.SetFocus;
         Abort;
      end else if (edtNome.Text = '') then
      begin
         showMessage('Informe um nome...');
         edtNome.SetFocus;
         Abort;
      end else if (edtApelido.Text = '') then
      begin
         showMessage('Informe um apelido...');
         edtApelido.SetFocus;
         Abort;
      end;
   end;
end;

end.

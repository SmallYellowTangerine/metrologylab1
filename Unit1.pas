unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;        
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  Toperatorsarray=array[1..54] of string;

var
  Form1: TForm1;
  sourcecode, resultcode: string;
  arrayofsmall: array of integer;

implementation

{$R *.dfm}

uses Unit2;

//����� ���������� ��������� ��������� � ������ - ��� �������� ����������
function substringcount(substring: string; var code: string): integer;
begin
  result:=0;
  while pos(substring, code)<>0 do
    begin
    code:=copy(code, 1, pos(substring, code)-1)+
          copy(code, pos(substring, code)+length(substring), length(code));
    inc(result);
    end;
end;

//������� ��� ���������� ������������ �� ������� ���� ����� �� ��������
function smallestof(arrayofthings: array of integer): integer;
var
  i: integer;
begin
  result:=0;
  i:=0;
  while result=0 do
    begin
    result:=arrayofthings[i];
    inc(i);
    end;
  for i:=0 to length(arrayofthings) do
    begin
    if (arrayofthings[i]<>0) and (arrayofthings[i]<result)
      then result:=arrayofthings[i];
    end;
end;





//�������� ������ �����
procedure TForm1.Button1Click(Sender: TObject);
begin
  button2.Enabled:=false;
  if OpenDialog1.Execute then
    begin
    memo1.Lines.Clear;
    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
    sourcecode:=Memo1.Lines.Text+#10;
    resultcode:='';
    end;
end;



//�������� ������������
procedure TForm1.Button3Click(Sender: TObject);
var
  i, foundposition, state: integer;
  tempsource: string;
begin
  button2.Enabled:=true;
  tempsource:=sourcecode;
  while ( (pos('//', tempsource)<>0)
        or (pos('/*', tempsource)<>0) ) do
    begin
    //����������, ��� ����������� � ������ ������ - ", // ��� /*
    setlength(arrayofsmall, 3);
    arrayofsmall[0]:=pos('//', tempsource);
    arrayofsmall[1]:=pos('/*', tempsource);
    arrayofsmall[2]:=pos('"', tempsource);
    foundposition:=smallestof(arrayofsmall);
    for i:=0 to 2 do
      if arrayofsmall[i]=foundposition then state:=i;
    //�������� ������������ ��� � �������� ������/������� ��� �� ��������
    resultcode:=resultcode+copy(tempsource, 1, foundposition-1);
    tempsource:=copy(tempsource, foundposition+1, length(tempsource));
    if state=0 then
      tempsource:=copy(tempsource, pos(#10, tempsource), length(tempsource));
    if state=1 then
      tempsource:=copy(tempsource, pos('*/', tempsource)+2, length(tempsource));
    if state=2 then
      begin
      resultcode:=resultcode+'"'+copy(tempsource, 1, pos('"', tempsource));
      tempsource:=copy(tempsource, pos('"', tempsource)+1, length(tempsource));
      end;
    end;
  resultcode:=resultcode+tempsource;
  //����� ����������
  Memo1.Lines.Clear;
  Memo1.Lines.Text:=resultcode;
end;



//������� �����
procedure TForm1.Button2Click(Sender: TObject);
var
    alloperators, CL_absolutecomplexity, CLI_maxnest: integer;
    i, foundquote, currentnest, emptybraces, currentposition: integer;
    cl_relativecomplexity: real;
    alloperatorsarray: Toperatorsarray;
    ifonlycode, ifonlytemp: string;
begin
  fillalloperators(alloperatorsarray);
  //������������� �������
  i:=1;
  while pos('"', resultcode)<>0 do
    begin
    if i mod 2=1 then
      begin
      foundquote:=pos('"', resultcode);
      resultcode:=copy(resultcode, 1, pos('"', resultcode)-1)+
                  copy(resultcode, pos('"', resultcode)+1, length(resultcode));
      end
    else
      resultcode:=copy(resultcode, 1, foundquote-1)+
                  copy(resultcode, pos('"', resultcode)+1, length(resultcode));
    inc(i);
    end;
  //������� ���� ����������
  alloperators:=0;
  for i:=1 to 54 do
    alloperators:=alloperators+substringcount(alloperatorsarray[i], resultcode);

//������� ����� if'��
  ifonlycode:=resultcode;
  CL_absolutecomplexity:=substringcount('if', resultcode);
  alloperators:=alloperators+CL_absolutecomplexity;

//������� ��������� ����� if'�� � ����� ���� ����������
  if alloperators<>0
    then cl_relativecomplexity:=CL_absolutecomplexity/alloperators;

//������� ������������ ������� �����������
  CLI_maxnest:=0;
  emptybraces:=0;
  currentnest:=0;
  currentposition:=0;
  while (pos('if', ifonlycode)<>0) or (pos('else', ifonlycode)<>0)
          or (length(ifonlycode)<>0) do
    begin
    //���� ��� ������ ��� ��������� if � else - ����������� �������� ������
    if (pos('if', ifonlycode)=0) and (pos('else', ifonlycode)=0) then
      begin
      emptybraces:=emptybraces+substringcount('{', ifonlycode);
      if CLI_maxnest<currentnest
        then CLI_maxnest:=currentnest;
      currentnest:=currentnest-substringcount('}', ifonlycode);
      if currentnest<0 then
        begin
        emptybraces:=emptybraces+currentnest;
        currentnest:=0;
        end;
      ifonlycode:='';
      break;
      end;
    setlength(arrayofsmall, 2);
    arrayofsmall[0]:=pos('if', ifonlycode);
    arrayofsmall[1]:=pos('else', ifonlycode);
    currentposition:=smallestof(arrayofsmall);
    //������������ �������� ������ �� ������� �������������� if ��� else
    ifonlytemp:=copy(ifonlycode, 1, currentposition-1);
    emptybraces:=emptybraces+substringcount('{', ifonlytemp);
    if CLI_maxnest<currentnest
      then CLI_maxnest:=currentnest;
    currentnest:=currentnest-substringcount('}', ifonlytemp);
    if currentnest<0 then
      begin
      emptybraces:=emptybraces+currentnest;
      currentnest:=0;
      end;
    //������� ��� �� ������� �������������� if ��� else
    ifonlycode:=copy(ifonlycode, currentposition+2, length(ifonlycode));
    //���� ; ����������� ������, ��� }, �� ��� ������ ����������� ������ if-�����
    setlength(arrayofsmall, 2);
    arrayofsmall[0]:=pos(';', ifonlycode);
    arrayofsmall[1]:=pos('{', ifonlycode);
    currentposition:=smallestof(arrayofsmall);
    if currentposition=pos(';', ifonlycode) then
      begin
      if CLI_maxnest<currentnest
        then CLI_maxnest:=currentnest;
      end;
    if currentposition=pos('{', ifonlycode)
      then inc(currentnest);
    //������� ��� � if/else �� { ��� ;
    ifonlycode:=copy(ifonlycode, currentposition+1, length(ifonlycode));
    end;

//����� �����������
  Listbox1.Clear;
  listbox1.AddItem('���������� ��������� ��������� CL = '+
                    inttostr(CL_absolutecomplexity), listbox1);
  listbox1.AddItem('������������� ��������� ��������� cl = '+
                    floattostr(cl_relativecomplexity), listbox1);
  listbox1.AddItem('������������ ����������� CLI = '
                    +inttostr(CLI_maxnest), listbox1);
  listbox1.additem('', listbox1);
  listbox1.additem('emptybraces: '+inttostr(emptybraces), listbox1);
  listbox1.AddItem('currentnest: '+inttostr(currentnest), listbox1);
end;

end.

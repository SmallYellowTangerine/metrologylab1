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

var
  Form1: TForm1;
  sourcecode, resultcode: string;
  arrayofsmall: array of integer;
  arrayofvariables: array of array[1..3] of string;

implementation

{$R *.dfm}

//����� ���������� ��������� ��������� � ������
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
  for i:=0 to length(arrayofthings)-1 do
    begin
    if (arrayofthings[i]<>0) and (arrayofthings[i]<=result)
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
        or (pos('{', tempsource)<>0) ) do
    begin
    //����������, ��� ����������� � ������ ������ - ', // ��� {
    setlength(arrayofsmall, 3);
    arrayofsmall[0]:=pos('//', tempsource);
    arrayofsmall[1]:=pos('{', tempsource);
    arrayofsmall[2]:=pos('''', tempsource);
    foundposition:=smallestof(arrayofsmall);
    for i:=0 to 2 do
      if arrayofsmall[i]=foundposition then state:=i;
    //�������� ������������ ��� � �������� ������/������� ��� �� ��������
    resultcode:=resultcode+copy(tempsource, 1, foundposition-1);
    tempsource:=copy(tempsource, foundposition+1, length(tempsource));
    if state=0 then
      tempsource:=copy(tempsource, pos(#10, tempsource), length(tempsource));
    if state=1 then
      tempsource:=copy(tempsource, pos('}', tempsource)+1, length(tempsource));
    if state=2 then
      begin
      resultcode:=resultcode+''''+copy(tempsource, 1, pos('''', tempsource));
      tempsource:=copy(tempsource, pos('''', tempsource)+1, length(tempsource));
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
  i, foundquote, foundposition, vararraycount, nestcode, j, checkposition: integer;
  variable, nest: string;
  alreadycounted, deletecolon, deletecomma, proc: boolean;
begin
  //������������� �������
  i:=1;
  while pos('''', resultcode)<>0 do
    begin
    if i mod 2=1 then
      begin
      foundquote:=pos('''', resultcode);
      resultcode:=copy(resultcode, 1, pos('''', resultcode)-1)+
                  copy(resultcode, pos('''', resultcode)+1, length(resultcode));
      end
    else
      resultcode:=copy(resultcode, 1, foundquote-1)+
                  copy(resultcode, pos('''', resultcode)+1, length(resultcode));
    inc(i);
    end;

  //������� ���� ����������
  nest:='';
  nestcode:=32;
  vararraycount:=0;
  while resultcode<>'' do
    begin
    //����������, ��� ����������� � ������ ������ - var/function/procedure, begin ��� end
    setlength(arrayofsmall, 5);
    arrayofsmall[0]:=pos('var', resultcode);
    arrayofsmall[1]:=pos('begin', resultcode);
    arrayofsmall[2]:=pos('end', resultcode);
    arrayofsmall[3]:=pos('function', resultcode);
    arrayofsmall[3]:=pos('procedure', resultcode);
    foundposition:=smallestof(arrayofsmall);
    //������� ������ �� �����
    if ( pos('var', resultcode)=0 )
      and ( pos('begin', resultcode)=0 )
      and ( pos('end', resultcode)=0 )
      and ( pos('function', resultcode)=0 )
      and ( pos('procedure', resultcode)=0 )
    then break;

    //���� var ��� function ��� procedure, �� ������� ���������� � ������
    if foundposition=pos('var', resultcode)
        or foundposition=pos('function', resultcode)
        or foundposition=pos('procedure', resultcode) then
      begin
      if foundposition<>pos('var', resultcode) then proc=true;
        else proc=false;
      inc(nestcode);
      nest:=nest+char(nestcode);
      //������� var/procedure/function �� resultcode
      if proc=true
        then resultcode:=copy(resultcode, foundposition+9, length(resultcode));
      else
        begin
        resultcode:=copy(resultcode, foundposition+3, length(resultcode));
        if pos(')', resultcode)>pos('var', reesultcode)
          resultcode:=copy(resultcode, 1, pos('var', reesultcode)-1)
                    + copy(resultcode, pos('var', reesultcode)+3, length(resultcode));
        end;
      checkposition:=foundposition;
      while (checkposition<>pos('begin', resultcode))
            and (checkposition<>pos('type', resultcode))
            and (checkposition<>pos('const', resultcode))
            and (checkposition<>pos('uses', resultcode))
            and (checkposition<>pos('implementation', resultcode))
            and (checkposition<>pos('var', resultcode)) do
        begin
        //���� ������� ��� : (��� ����� ������� �����)
        setlength(arrayofsmall, 8);
        arrayofsmall[0]:=pos(',', resultcode);
        arrayofsmall[1]:=pos(':', resultcode);
        arrayofsmall[2]:=pos('begin', resultcode);
        arrayofsmall[3]:=pos('type', resultcode);
        arrayofsmall[4]:=pos('const', resultcode);
        arrayofsmall[5]:=pos('uses', resultcode);      
        arrayofsmall[6]:=pos('implementation', resultcode);
        arrayofsmall[7]:=pos(')', resultcode);
        foundposition:=smallestof(arrayofsmall);
        checkposition:=foundposition;
        //��������� ���������� � ������
        if (foundposition=pos(',', resultcode))
            or (foundposition=pos(':', resultcode)) then
          begin
          deletecolon:=false;
          deletecomma:=false;
          if foundposition=pos(':', resultcode) then deletecolon:=true;
          if foundposition=pos(',', resultcode) then deletecomma:=true;
          i:=1;
          while (resultcode[foundposition-i]<>' ')
                and (resultcode[foundposition-i]<>#9)
                and (resultcode[foundposition-i]<>#$A)
                and (resultcode[foundposition-i]<>'(')
                (resultcode[foundposition-i]<>';')
            do inc(i);
          foundposition:=foundposition-i+1; //������ ����������
          while not (resultcode[foundposition+i] in ['A'..'Z', 'a'..'z', '0'..'9', '_'])
            do dec(i);
          variable:=copy(resultcode, foundposition, i+1);
          //���������� ���������� � ������
          //���� ��� ��� ���� � �������
          alreadycounted:=false;
          if length(arrayofvariables)>0 then
            begin
            for j:=0 to length(arrayofvariables)-1 do
              begin
              if (arrayofvariables[j, 1]=variable)
                and (arrayofvariables[j, 2]=nest)
              then
                begin
                arrayofvariables[j, 3]:=inttostr( strtoint(arrayofvariables[j, 3])+1 );
                alreadycounted:=true;
                end;
              end;
            end;
          //���� �� �� ���� � �������
          if alreadycounted=false then
            begin
            inc(vararraycount);
            setlength(arrayofvariables, vararraycount);
            arrayofvariables[vararraycount-1, 1]:=variable;
            arrayofvariables[vararraycount-1, 2]:=nest;
            arrayofvariables[vararraycount-1, 3]:=inttostr(0);
            resultcode:=copy(resultcode, foundposition+i+1, length(resultcode));
            end;
          if deletecolon=true
            then resultcode:=copy(resultcode, pos(':', resultcode)+1, length(resultcode));
          if deletecomma=true
            then resultcode:=copy(resultcode, pos(',', resultcode)+1, length(resultcode));
          end;

        end;
      end;

    //������� ���������� � ���� ���������
    if foundposition=pos('begin', resultcode) then
      begin
      resultcode:=copy(resultcode, foundposition+5, length(resultcode));
      for j:=0 to length(arrayofvariables)-1 do
        begin
        //�������� �� ����� ������� �� ������������� ����������
        for i:=j+1 to length(arrayofvariables)-1 do
          begin
          if (arrayofvariables[j, 1]=arrayofvariables[i, 1])    
            and (length(arrayofvariables[j, 2])<=length(arrayofvariables[i, 2]))
          then continue;                               
          end;
        while pos(arrayofvariables[j, 1], resultcode)<>0 do
          begin
          arrayofvariables[j, 3]:=inttostr( strtoint(arrayofvariables[j, 3])+1 );
          resultcode:=copy(resultcode, 1, pos(arrayofvariables[j, 1], resultcode)-1 )
                    + copy(resultcode, pos(arrayofvariables[j, 1], resultcode)
                        +length(arrayofvariables[j, 1]), length(resultcode));
          end;
        end; //for arrayofvariables
      end; //if begin

    if foundposition=pos('end', resultcode) then
      begin
      nest:=copy(nest, 1, length(nest)-1);
      resultcode:=copy(resultcode, foundposition+3, length(resultcode));
      end;

    end;

//����� �����������
  Listbox1.Clear;
  for j:=0 to length(arrayofvariables)-1 do
    begin
    listbox1.items.Add(arrayofvariables[j, 1]+' - '+arrayofvariables[j, 2]+' - '+arrayofvariables[j, 3])
    end;




end;

end.

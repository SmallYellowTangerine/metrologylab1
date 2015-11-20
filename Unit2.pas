unit Unit2;

interface

uses Unit1;

procedure fillalloperators(var alloperators: Toperatorsarray);

implementation

//заполнение массива с операторами
procedure fillalloperators(var alloperators: Toperatorsarray);
var
  i: integer;
begin
  i:=1;

  alloperators[i]:='unchecked';  inc(i);
  alloperators[i]:='delegate';  inc(i);
  alloperators[i]:='checked';  inc(i);
  alloperators[i]:='sizeof';  inc(i);
  alloperators[i]:='typeof';  inc(i);
  alloperators[i]:='delete';  inc(i);
  alloperators[i]:='throw';  inc(i);
  alloperators[i]:='new';  inc(i);
  alloperators[i]:='is';  inc(i);
  alloperators[i]:='as';  inc(i);
  alloperators[i]:='<<=';  inc(i);
  alloperators[i]:='>>=';  inc(i);
  alloperators[i]:='->*';  inc(i);
  alloperators[i]:='==';  inc(i);
  alloperators[i]:='++';  inc(i);
  alloperators[i]:='--';  inc(i);
  alloperators[i]:='!!';  inc(i);
  alloperators[i]:='!=';  inc(i);
  alloperators[i]:='<<';  inc(i);
  alloperators[i]:='<=';  inc(i);
  alloperators[i]:='>>';  inc(i);
  alloperators[i]:='>=';  inc(i);
  alloperators[i]:='&&';  inc(i);
  alloperators[i]:='||';  inc(i);
  alloperators[i]:='+=';  inc(i);
  alloperators[i]:='-=';  inc(i);
  alloperators[i]:='*=';  inc(i);
  alloperators[i]:='/=';  inc(i);
  alloperators[i]:='%=';  inc(i);
  alloperators[i]:='&=';  inc(i);
  alloperators[i]:='|=';  inc(i);
  alloperators[i]:='^=';  inc(i);
  alloperators[i]:='->';  inc(i);
  alloperators[i]:='.*';  inc(i);
  alloperators[i]:='::';  inc(i);
  alloperators[i]:='?.';  inc(i);
  alloperators[i]:='??';  inc(i);
  alloperators[i]:='*';  inc(i);
  alloperators[i]:='/';  inc(i);
  alloperators[i]:='%';  inc(i);
  alloperators[i]:='~';  inc(i);
  alloperators[i]:='^';  inc(i);
  alloperators[i]:='=';  inc(i);
  alloperators[i]:='+';  inc(i);
  alloperators[i]:='-';  inc(i);
  alloperators[i]:='!';  inc(i);
  alloperators[i]:='<';  inc(i);
  alloperators[i]:='>';  inc(i);
  alloperators[i]:='&';  inc(i);
  alloperators[i]:='|';  inc(i);
  alloperators[i]:='[';  inc(i);
  alloperators[i]:='.';  inc(i);
  alloperators[i]:=',';  inc(i);
  alloperators[i]:='(';
end;

end.

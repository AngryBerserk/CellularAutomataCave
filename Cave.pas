unit Cave;

interface

type
  Tarray= array of Word;
  TCave = class
   private
    average:Word;
    swidth:Word;
    slength:Word;
    Map_:Tarray;
    Map2:Tarray;
    Map_neigh:Array[0..5000,0..5000] of byte;
    function getMap(x,y:Integer):Word;
    procedure setMap(x,y:Integer;v:Word);
    procedure Initialize;
    procedure Copy_arrays;
    procedure FillArray(var a:Tarray);
    function rule(x,y:Word):Boolean;
    function GetIndex(x,y:Word):LongWord;
    function neighbours(x: Integer; y: Integer; w:word):Word;
   public
    property map[x,y:Integer]:Word read getMap write setMap;
    constructor Create(x,y:Word);
    function Iterate:Tarray;
  end;

implementation

function TCave.GetIndex(x: Word; y: Word):LongWord;
begin
 result:=y*swidth+x
end;

function TCave.getMap(x,y:integer):Word;
Begin
  if (x<0) or (x>swidth-1) or (y<0) or (y>slength-1) then result:=1 else result:=Map_[GetIndex(x,y)];
End;

procedure TCave.setMap(x: Integer; y: Integer; v: Word);
begin
  Map_[GetIndex(x,y)]:=v;
end;

procedure TCave.Initialize;
 var x,y,r:Word;
begin
  for x := 0 to slength-1 do
      for y := 0 to swidth-1 do
        Begin
          r:=Random(100);
          if r<49 then
            map[x,y]:=1;
          Map_neigh[x,y]:=4;//Random(3)+3;
        End;
end;

procedure TCave.FillArray(var a:Tarray);
 var x:LongWord;
Begin
  for x := 0 to swidth*slength do a[x]:=0;
End;

Constructor TCave.Create(x: Word; y: Word);
begin
 swidth:=x;
 slength:=y;
 SetLength(map_,x*y);
 SetLength(map2,x*y);
 Fillarray(map_);
 Fillarray(map2);
 Initialize;
end;

procedure TCave.Copy_arrays;
 var x:LongInt;
Begin
  for x := 0 to swidth*slength do
        Map_[x]:=Map2[x];
End;

function TCave.rule(x,y:Word):Boolean;
Begin
 if Map_neigh[x,y]<neighbours(x,y,1) then result:=true else result:=false
End;

function TCave.Iterate:Tarray;
 var x,y:Word;
begin
  for x := 0 to slength-1 do
      for y := 0 to swidth-1 do
         if rule(x,y) then
          Begin
            if map[x,y]>0 then
              map2[GetIndex(x,y)]:=map[x,y]
                else map2[GetIndex(x,y)]:=average
          End
            else map2[GetIndex(x,y)]:=0;
  Copy_arrays;
  result:=Map_;
end;

function TCave.neighbours(x: Integer; y: Integer; w:Word):Word;
 var xx,yy:LongInt;
begin
 average:=0;
 result:=0;
   for xx := x-w to x+w do
     for yy := y-w to y+w do
       Begin
        average:=average+map[xx,yy];
        if map[xx,yy]>0 then
            result:=result+1;
       End;
 if result>0 then average:=average div result else average:=1;
end;

end.

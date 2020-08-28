unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, cave,
  FMX.Controls.Presentation, FMX.StdCtrls, Painter;

const
  msizeX=1000;
  msizeY=1000;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    map:Tarray;
    Cave:TCave;
    procedure Display;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
begin
 Cave.Iterate;
 display;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Cave:=TCave.Create(msizex-2,msizey-2);
  TPainter.Init(Form2,msizeX,msizeY);
  display;
  Button1.BringToFront
end;

procedure TForm2.Display;
  var x,y:Integer;
begin
  TPainter.StartPaint;
  for y := -1 to msizeY+1 do
    for x := -1 to msizeX+1 do
      if Cave.map[x,y]>0 then
        TPainter.Paint(x+2,y+2,TAlphaColorRec.Create(TAlphaColorRec.Black));
  TPainter.Surface.Bitmap.Canvas.EndScene;
end;

end.

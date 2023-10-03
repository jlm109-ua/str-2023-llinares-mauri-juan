with Ada.Float_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random;

procedure numerosAleatorios is
   subtype T_Float is Float range 0.0..1.0;
   generador : Ada.Numerics.Float_Random.Generator;
   random : T_Float;
begin
   Ada.Numerics.Float_Random.Reset(generador);
   loop
      random := Ada.Numerics.Float_Random.Random(generador);
      Ada.Float_Text_IO.Put(random, Aft => 4, Exp => 0);
      Skip_Line;
   end loop;
end numerosAleatorios;

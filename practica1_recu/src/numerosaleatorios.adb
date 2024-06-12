with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

procedure numerosAleatorios is
   subtype T_Real is Float range 0.0..1.0;
   -- package Pkg_RealesAleatorios is new Ada.Numerics.Float_Random;
   -- use Pkg_RealesAleatorios;
   generador : Generator;
   real : T_Real;
begin
   -- Pkg_RealesAleatorios.Reset(generador);
   Reset(generador);
   loop
      -- Pkg_RealesAleatorios.Random(generador);
      real := Random(generador);
      Put(real, Fore => 1, Aft => 4, Exp => 0);
      Skip_Line;
   end loop;
end numerosAleatorios;

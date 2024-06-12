with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with pkg_ejercicio2; use pkg_ejercicio2;

procedure ejercicio3 is
   package enum is new Ada.Text_IO.Enumeration_IO(Enum => pkg_ejercicio2.TdiasSemana);
   use enum;

   dayClass : pkg_ejercicio2.TdiasSemana; -- Variable del tipo del enumerado.

begin
   Put(numAlumnos);
   New_Line;
   Put(getNotaMedia, Fore => 1, Aft => 1);

   for day in pkg_ejercicio2.TdiasSemana loop
      Put(day);
      New_Line;
   end loop;

   Put("Introduzca un día: ");
   Get(dayClass);

   case dayClass is
      when pkg_ejercicio2.Lunes => Put("¡Hay clase de STR!");
      when others => Put("¡No hay clase de STR!");
   end case;

end ejercicio3;

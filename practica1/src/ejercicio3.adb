with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
with pkg_ejercicio2;

procedure ejercicio3 is
   num : Integer := 1;
   num_dia : pkg_ejercicio2.TdiasSemana;
   valor : pkg_ejercicio2.TdiasSemana;
   pos : Natural;
begin
   -- Obtenemos la variable privada notaMedia:
   Ada.Float_Text_IO.Put(pkg_ejercicio2.getNotaMedia, Aft => 1);
   Ada.Text_IO.New_Line;

   -- Imprimimos los días de la semana con el enumerado enumerado_TdiasSemana:
   for dia in pkg_ejercicio2.TdiasSemana loop
      Ada.Integer_Text_IO.Put(num);
      Ada.Text_IO.Put(". ");
      pkg_ejercicio2.enumerado_TdiasSemana.Put(dia);
      Ada.Text_IO.New_Line;
      num := num + 1;
   end loop;

   Ada.Text_IO.Put("Introduce un día (Int): ");
   pkg_ejercicio2.enumerado_TdiasSemana.Get(num_dia);

   if num_dia = 1 then
      Ada.Text_IO.Put("El lunes hay clase de STR.");
   else
      Ada.Text_IO.Put("El ");
      valor := pkg_ejercicio2.TdiasSemana'Pos(num_dia);
      pkg_ejercicio2.enumerado_TdiasSemana.Put(valor);
      Ada.Text_IO.Put(" no hay clase de STR");
   end if;
end ejercicio3;

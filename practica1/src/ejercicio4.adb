with Ada.Text_IO, Ada.Integer_Text_IO;

procedure ejercicio4 is
   num : Natural := 0;
begin
   Ada.Text_IO.Put("Introduzca un mes (Int): ");
   Ada.Integer_Text_IO.Get(num);

   case num is
      when 1 | 2 | 12 => Ada.Text_IO.Put("Invierno.");
      when 3 | 4 | 5 => Ada.Text_IO.Put("Primavera.");
      when 6 | 7 | 8 => Ada.Text_IO.Put("Verano.");
      when 9 | 10 | 11 => Ada.Text_IO.Put("Otoño.");
      when others => Ada.Text_IO.Put("Mes incorrecto.");
   end case;

   Ada.Text_IO.Put_Line("FIN DEL PROGRAMA");

   exception
      when Constraint_Error =>
         Ada.Text_IO.Put("¡El numero debe ser mayor que 0!");
         Ada.Text_IO.New_Line;
end ejercicio4;

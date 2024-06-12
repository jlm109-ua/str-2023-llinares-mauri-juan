with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with pkg_ejercicio2; use pkg_ejercicio2;

procedure Ejercicio1 is
   s : String := "Comenzamos las prácticas de STR";
   month : Integer := 0;

begin
   Put("Hola Mundo!!! ");
   Put_Line(s);
   otroMensaje;

   Get(month);

   if month <= 0 then
      Put("El número de mes debe ser > 0.");
   else
      case month is
      when 1 | 2 | 12 => Put("Invierno");
      when 3 | 4 | 5 => Put("Primavera");
      when 6 | 7 | 8 => Put("Verano");
      when 9 | 10 | 11 => Put("Otoño");
      when others => Put("Mes incorrecto");
      end case;
   end if;

   New_Line;
   Put_Line("FIN DEL PROGRAMA");
   end Ejercicio1;

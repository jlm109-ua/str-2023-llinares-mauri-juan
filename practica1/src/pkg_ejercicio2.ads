with Ada.Text_IO;

package pkg_ejercicio2 is
   type TdiasSemana is (Lunes, Martes, 
                        Miercoles, 
                        Jueves, Viernes, 
                        Sabado, Domingo);
   package enumerado_TdiasSemana is new Ada.Text_IO.Enumeration_IO(Enum => TdiasSemana);
   numAlumnos : Integer := 24;
   
   procedure otroMensaje;
   function getNotaMedia return Float;
   
   private notaMedia : Float := 5.32;
end pkg_ejercicio2;

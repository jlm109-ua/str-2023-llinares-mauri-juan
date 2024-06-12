package pkg_ejercicio2 is

   type TdiasSemana is (Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo);
   numAlumnos : Integer := 24;

   procedure otroMensaje;
   function getNotaMedia return Float;

private
   notaMedia : Float := 5.32;
end pkg_ejercicio2;

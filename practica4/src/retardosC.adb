package body retardosC is
task Tarea_Retardo;
   
   task body Tarea_Retardo is
      Inicio, Siguiente : Time;
      Frecuencia : constant Duration := 1.0;
   begin
      Inicio := Clock;
      Siguiente := Clock + Frecuencia;
      
      loop
         Actualiza_Cronometro(Clock - Inicio);
         Delay_Until(Siguiente);
         Siguiente := Siguiente + Frecuencia;
      end loop;
   end Tarea_Retardo;
end retardosC;

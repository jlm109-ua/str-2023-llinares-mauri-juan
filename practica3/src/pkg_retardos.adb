package body pkg_retardos is
   task body Tarea_Retardo is
      Inicio, Siguiente : Time;
      Frecuencia : constant Duration := 1.0;
   begin
      Inicio := Clock;
      Siguiente := Clock + Frecuencia;
      
      loop
         Actualiza_Cronometro(Clock - Inicio);
         delay until(Siguiente);
         Siguiente := Siguiente + Frecuencia;
      end loop;
   end Tarea_Retardo;
end pkg_retardos;

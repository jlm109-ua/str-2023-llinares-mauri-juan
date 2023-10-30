package body pkg_retardos is
   task body Tarea_Retardo is
      Inicio, Siguiente : Time;
      Frecuencia : Time_Span := Milliseconds(1000);
   begin
      Inicio := Clock;
      Siguiente := Clock + Frecuencia;
      
      loop
         Actualiza_Cronometro(To_Duration(Clock - Inicio));
         delay until(Siguiente);
         Siguiente := Siguiente + Frecuencia;
      end loop;
   end Tarea_Retardo;
end pkg_retardos;

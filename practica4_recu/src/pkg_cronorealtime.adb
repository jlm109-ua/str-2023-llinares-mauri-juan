package body PKG_CronoRealTime is

   task body T_Periodica is
      segundo : Time_Span := Milliseconds(1000);
      inicio : Time;
      siguiente : Time;
   
   begin
      inicio := Clock;
      siguiente := Clock + segundo;
      loop
         PKG_graficos.Actualiza_Cronometro(To_Duration(Clock - inicio));
         delay until siguiente;
         siguiente := siguiente + segundo;
      end loop;
   end T_Periodica;
      
end PKG_CronoRealTime;

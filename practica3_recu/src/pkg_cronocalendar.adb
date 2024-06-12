package body PKG_CronoCalendar is

   activacion : constant Duration := 1.0;
    
   task body T_Periodica is 
      inicio : Time;
      periodo : constant Duration := 1.0;
      siguiente : Time;
   begin
      inicio := Clock;
      siguiente := Clock + periodo; 
      loop
         PKG_graficos.Actualiza_Cronometro(clock - inicio);
         delay until siguiente;
         -- delay 1.0; -- Si usamos esta sentencia crearemos una desviación acumulativa y siempre llegaremos tarde al plazo de tiempo. Esto se debe a que se suma el segundo sobre el tiempo actual y no se busca el instante exacto.
         siguiente := siguiente + periodo;
      end loop;
   end T_Periodica;
  
end PKG_CronoCalendar;

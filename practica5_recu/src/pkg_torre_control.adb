package body pkg_torre_control is

   task body Tarea_Torre_Control is
      pistaAterrizaje : T_PistaAterrizaje := PISTA1;
   begin
      loop
         accept Iniciar_Torre_Control
           (avion : in T_RecordAvion;
            concedido : out Boolean;
            pista : out T_PistaAterrizaje;)
         do
            
            begin
               
               -- Si hay sitio para descender
               if aerovias(avion.aereovia + 1).cantidad < MAX_AVIONES_AEROVIA then --& (avion.aerovia + 1) /= T_Rango_AereoVia'Last  then
                  concedido := True;
                  aerovias(avion.aereovia + 1).incContador;
                  
                  if avion.pista = SIN_PISTA then
                  pista := pistaAterrizaje;
                  -- Alternamos las pistas de manera equitativa
                  pistaAterrizaje := (if pistaAterrizaje = PISTA1 then PISTA2 else PISTA1);
                  end if;
               else
                  concedido := False;
               end if;
               
            end Iniciar_Torre_Control;
         end loop;
         
         delay(2.0);
         
   end Tarea_Torre_Control;
end pkg_torre_control;

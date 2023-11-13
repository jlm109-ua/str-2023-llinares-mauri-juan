package body pkg_torre_control is
   task body Tarea_Torre_Control is
      pistaAux : T_PistaAterrizaje;
      control : Boolean := False;
   begin
      
      loop
         select 
            accept Iniciar_Torre_Control do
               control := True;
            end Iniciar_Torre_Control;
         or
              when control => accept Descender (avion : in T_RecordAvion; estado : out Boolean; pista : out T_PistaAterrizaje) 
               do
                  -- Si no se supera la cantidad de aviones máxima permitida en una aereovía...
                  if (aereovias(avion.aereovia + 1).cantidad < MAX_AVIONES_AEROVIA) then
                      estado := true; -- Puede descender
                   
                      -- Mientras no sea la última aereovía...
                      if avion.aereovia + 1 /= T_Rango_AereoVia'Last then
                         aereovias(avion.aereovia + 1).incAviones; -- Incrementamos los aviones en la siguiente aerovía
                      end if;
                      
                      -- Si el avión no tiene pista de descenso asignada...
                      if avion.pista = SIN_PISTA then
                         pista := pistaAux;
                      pistaAux := (if pista = PISTA1 then PISTA2 else PISTA1);
                      end if;
                  else
                      estado := false; -- No tiene permiso para descencer
                  end if;    
              end Descender;
              delay 2.0; -- Retardo minimo
          end select;
      end loop;
   end Tarea_Torre_Control;
end pkg_torre_control;

package body GeneraAviones is
   
   -- Creación del número aleatorio
   package PKG_RetardoAleatorio is new Ada.Numerics.Discrete_Random(T_RetardoAparicionAviones);
   generadorRetardo : PKG_RetardoAleatorio.Generator;
   retardo : T_RetardoAparicionAviones;
   
   -- Creación del color aleatorio
   package PKG_ColorAleatorio is new Ada.Numerics.Discrete_Random(T_ColorAparicionAvion);
   generadorColor : PKG_ColorAleatorio.Generator;
   
   -- Tarea encargada de generar aviones:
   task body TareaGeneraAviones is
      tarea_avion : Ptr_TareaAvion;
      ptr_avion   : Ptr_T_RecordAvion;
   begin
      PKG_RetardoAleatorio.Reset(generadorRetardo);
      PKG_ColorAleatorio.Reset(generadorColor);
      for id in T_IdAvion loop
         for aereovia in T_Rango_AereoVia'First..T_Rango_AereoVia'Last - 2 loop
            -- inicializar datos de un nuevo avion
            ptr_avion := new T_RecordAvion;
            ptr_avion.id := id;
            ptr_avion.velocidad.x := VELOCIDAD_VUELO;
            ptr_avion.velocidad.y := 0;
            ptr_avion.aereovia := aereovia;
            ptr_avion.tren_aterrizaje := False;
            
            -- Añadimos los datos que faltan de la nueva implementación
            ptr_avion.aereovia_inicial := aereovia;
            ptr_avion.color := PKG_ColorAleatorio.Random(generadorColor);

            -- Cambiamos la dirección de vuelo del avión
            if ptr_avion.aereovia / 2 = 0 then
               ptr_avion.velocidad.X := -VELOCIDAD_VUELO;
            else
               ptr_avion.velocidad.X := VELOCIDAD_VUELO;  
            end if;
            
            ptr_avion.pos := PKG_graficos.Pos_Inicio(ptr_avion.aereovia);
               
            -- Crear una tarea para el comportamiento del avion
            tarea_avion := NEW T_TareaAvion(ptr_avion);
            
            -- Insertamos el delay
            retardo := PKG_RetardoAleatorio.Random(generadorRetardo);
            Delay(Duration(retardo));
         end loop;
      end loop;
   end TareaGeneraAviones;
   
   -- Tarea encargada de un único avión
   task body T_TareaAvion is
      avion : T_RecordAvion; -- Creamos el record del avión
      
      rejillaSiguiente : T_Rango_Rejilla_X;
      rejillaActual : T_Rango_Rejilla_X;

      concedido : Boolean := False;
      pistaAterrizaje : T_PistaAterrizaje;
      
      procedure seguir is
      begin
         rejillaActual := Posicion_ZonaEspacioAereo(avion.pos.X);
         rejillaSiguiente := Posicion_ZonaEspacioAereo(Nueva_PosicionX(avion.pos.X, avion.velocidad.X));
         
         if rejillaActual /= rejillaSiguiente then 
            aerovias(avion.aereovia).cambiar(pos_ocupar  => rejillaSiguiente,
                                             pos_liberar => rejillaActual);
         end if;
         
         Actualiza_Movimiento(avion);
         delay Duration(RETARDO_MOVIMIENTO);
         
      end seguir;
      
      procedure bajar is
      begin
         
         avion.color := Yellow;
         
         rejillaActual := Posicion_ZonaEspacioAereo(avion.pos.X);
         
         aerovias(avion.aereovia).liberar(rejillaActual);
         aerovias(avion.aereovia + 1).ocupar(rejillaActual);
         
         Desaparece(avion);
         
         avion.aereovia := avion.aereovia + 1;
         avion.velocidad.X := (if (avion.aereovia / 2) = 0 then VELOCIDAD_VUELO else -VELOCIDAD_VUELO);
         
         avion.pos := Pos_Inicio(avion.pos.X, avion.aereovia);
         
         if avion.pista = SIN_PISTA then
            avion.pista := pistaAterrizaje;
            avion.color := (if pistaAterrizaje = PISTA1 then Green else Red);
         end if;
         
         Aparece(avion);
         
         aerovias(avion.aereovia - 1).decContador;
         
      end bajar;
      
   begin

      avion := ptr_avion.all;
      Put_line("TASK Avion: " & T_IdAvion'Image(ptr_avion.id) & " -" & T_Rango_AereoVia'Image(ptr_avion.aereovia) & " - " & T_ColorAparicionAvion'Image(ptr_avion.color));
      
      -- Metemos el avion en el entry hasta que se cumpla la condición para poder entrar
      aerovias(avion.aereovia).estadoAerovia(Posicion_ZonaEspacioAereo(avion.pos.X));
      Aparece(avion);
      
      loop
         select
            Tarea_Torre_Control.Iniciar_Torre_Control(avion, concedido, pistaAterrizaje);
            if concedido then
               Escribir("[CONCEDIDO] Petición de descenso del avion " & avion.id'Image & " desde aerovía " & avion.aereovia'Image);
            else
               Escribir("[NO CONCEDIDO] Petición de descenso del avion " & avion.id'Image & " desde aerovía " & avion.aereovia'Image);
            end if;
            
            rejillaActual := Posicion_ZonaEspacioAereo(avion.pos.X);
            
            if concedido and
              aerovias(avion.aereovia + 1).libre(rejillaActual) and
              aerovias(avion.aereovia + 1).libre(rejillaActual - 1) and
              aerovias(avion.aereovia + 1).libre(rejillaActual + 1) 
            then
               Escribir("[CONFIRMADO] Avion " & avion.id'Image & "descenciendo desde aerovía " & avion.aereovia'Image);
            
               if avion.aereovia + 1 = T_Rango_AereoVia'Last then
                  aerovias(avion.aereovia).liberar(Posicion_ZonaEspacioAereo(avion.pos.X));
                  Desaparece(avion);
                  Escribir("[ATERRIZANDO] Avion " & avion.id'Image & " aterrizando en la pista " & avion.pista'Image);
                  exit;
               end if;
               
               bajar;
            
            else
               
               Escribir("[DENEGADO] Avion " & avion.id'Image & "descenciendo desde aerovía " & avion.aereovia'Image);
               aerovias(avion.aereovia + 1).decContador;
               seguir;
            
            end if;
            
         then abort
            
            seguir;
            
         end select;
      end loop;
      
   exception
      when PKG_tipos.DETECTADA_COLISION => 
         PKG_debug.Escribir("COLISIÓN detectada en el avión con ID:" & T_IdAvion'Image(avion.id));           
         Desaparece(Avion);
      when event: others =>
         PKG_debug.Escribir("ERROR en TASK ...: " & Exception_Name(Exception_Identity(event)));           
   end T_TareaAvion;
  
end GeneraAviones;

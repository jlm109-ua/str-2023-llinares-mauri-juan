package body GeneraAviones is
   
   -- Creaci�n del n�mero aleatorio
   package PKG_RetardoAleatorio is new Ada.Numerics.Discrete_Random(T_RetardoAparicionAviones);
   generadorRetardo : PKG_RetardoAleatorio.Generator;
   retardo : T_RetardoAparicionAviones;
   
   -- Creaci�n del color aleatorio
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
            
            -- A�adimos los datos que faltan de la nueva implementaci�n
            ptr_avion.aereovia_inicial := aereovia;
            ptr_avion.color := PKG_ColorAleatorio.Random(generadorColor);

            -- Cambiamos la direcci�n de vuelo del avi�n
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
   
   -- Tarea encargada de un �nico avi�n
   task body T_TareaAvion is
      avion : T_RecordAvion; -- Creamos el record del avi�n
      pos_siguiente : T_CoordenadaX;

   begin
      avion := ptr_avion.all;
      Put_line("TASK Avion: " & T_IdAvion'Image(ptr_avion.id) & " -" & T_Rango_AereoVia'Image(ptr_avion.aereovia) & " - " & T_ColorAparicionAvion'Image(ptr_avion.color));
      
      -- Metemos el avion en el entry hasta que se cumpla la condici�n para poder entrar
      aerovias(avion.aereovia).estadoAerovia(Posicion_ZonaEspacioAereo(avion.pos.X));
      Aparece(avion);
      
      loop
         -- Preparamos la siguiente posici�n para comprobar que el avi�n no se salga de la aerov�a
         pos_siguiente := Nueva_PosicionX(avion.pos.X, avion.velocidad.X);
         
         if Posicion_ZonaEspacioAereo(avion.pos.X) /= Posicion_ZonaEspacioAereo(pos_siguiente) then
            aerovias(avion.aereovia).cambiar(pos_ocupar => Posicion_ZonaEspacioAereo(pos_siguiente), pos_liberar => Posicion_ZonaEspacioAereo(avion.pos.X));
            Actualiza_Movimiento(avion);
         else
            PKG_graficos.Actualiza_Movimiento(avion);
         end if;
         
         delay(PKG_tipos.RETARDO_MOVIMIENTO);
      end loop;
      
      
   exception
      when PKG_tipos.DETECTADA_COLISION => 
         PKG_debug.Escribir("COLISI�N detectada en el avi�n con ID:" & T_IdAvion'Image(avion.id));           
         Desaparece(Avion);
      when event: others =>
         PKG_debug.Escribir("ERROR en TASK ...: " & Exception_Name(Exception_Identity(event)));           
   end T_TareaAvion;
  
end GeneraAviones;

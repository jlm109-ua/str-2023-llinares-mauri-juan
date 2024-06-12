package body GeneraAviones is
   
   -- Creación del número aleatorio
   package PKG_RetardoAleatorio is new Ada.Numerics.Discrete_Random(T_RetardoAparicionAviones);
   generadorRetardo : PKG_RetardoAleatorio.Generator;
   retardo : T_RetardoAparicionAviones;
   
   -- Creación del color aleatorio
   package PKG_ColorAleatorio is new Ada.Numerics.Discrete_Random(T_ColorAparicionAvion);
   generadorColor : PKG_ColorAleatorio.Generator;
   color : T_Color;
   
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

            -- La dirección la cambiamos en la tarea T_TareaAvion, que será única para cada avión.
            
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
   begin
      avion := ptr_avion.all;
      Put_line("TASK Avion: " & T_IdAvion'Image(ptr_avion.id) & " -" & T_Rango_AereoVia'Image(ptr_avion.aereovia) & " - " & T_ColorAparicionAvion'Image(ptr_avion.color));
   
      if avion.aereovia / 2 = 0 then
         ptr_avion.velocidad.X := -VELOCIDAD_VUELO;
      else
         ptr_avion.velocidad.X := VELOCIDAD_VUELO;  
      end if;
      
      Aparece(avion);
      
      loop
         PKG_graficos.Actualiza_Movimiento(avion);
         delay(PKG_tipos.RETARDO_MOVIMIENTO);
      end loop;
      
      
   exception
      when PKG_tipos.DETECTADA_COLISION => 
         PKG_debug.Escribir("COLISIÓN detectada en el avión con ID:" & T_IdAvion'Image(avion.id));           
         Desaparece(Avion);
      when event: others =>
         PKG_debug.Escribir("ERROR en TASK ...: " & Exception_Name(Exception_Identity(event)));           
   end T_TareaAvion;
  
end GeneraAviones;

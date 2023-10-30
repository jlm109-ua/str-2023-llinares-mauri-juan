with Ada.Text_IO; use Ada.Text_IO;

package body GeneraAviones is
 task body TareaGeneraAviones is
      tarea_avion : Ptr_TareaAvion; -- Puntero al avion
      ptr_avion : Ptr_T_RecordAvion; -- Puntero a la información del avion
      
      -- Generador de retardos aleatorios
      package pkg_retardosRandom is new Ada.Numerics.Discrete_Random(T_RetardoAparicionAviones);
      generadorRetardos : pkg_retardosRandom.Generator;
      
      -- Generador de colores aleatorios
      package pkg_colorRandom is new Ada.Numerics.Discrete_Random(T_ColorAparicionAvion);
      generadorColores : pkg_colorRandom.Generator;
      
   begin
      pkg_retardosRandom.Reset(generadorRetardos);
      pkg_colorRandom.Reset(generadorColores);
      
      for id in T_IdAvion loop
         for aereovia in T_Rango_AereoVia'First..T_Rango_AereoVia'Last - 2 loop
          
            -- inicializar datos de un nuevo avion
            ptr_avion := new T_RecordAvion;
            ptr_avion.id := id;
            ptr_avion.velocidad.x := VELOCIDAD_VUELO;
            ptr_avion.velocidad.y := 0;
            ptr_avion.aereovia := aereovia;
            ptr_avion.tren_aterrizaje := False;
            ptr_avion.aereovia_inicial := aereovia;
            ptr_avion.pista := SIN_PISTA;
            ptr_avion.color := pkg_colorRandom.Random(generadorColores);
            ptr_avion.pos := Pos_Inicio(aereovia);
            
            --Cambia la dirección de vuelo del avion
            if ptr_avion.aereovia rem 2 = 0 then
               ptr_avion.velocidad.X := VELOCIDAD_VUELO;
            else
               ptr_avion.velocidad.X := -VELOCIDAD_VUELO;
            end if;
            
            -- Crear una tarea para el comportamiento del avion
            tarea_avion := NEW T_TareaAvion(ptr_avion);
            
            -- Generamos el retardo
            delay(Duration(pkg_retardosRandom.Random(generadorRetardos)));
         end loop;
      end loop;
   end TareaGeneraAviones;
   
   TASK BODY T_TareaAvion IS
      avion : T_RecordAvion;
      siguiente : T_CoordenadaX;
   begin
      avion := ptr_avion.all;
      
      Escribir(cadena => "Informacion del avion: " & avion.id'Image);
      Put_line("TASK Avion: " & T_IdAvion'Image(ptr_avion.id) & " -" 
               & T_Rango_AereoVia'Image(ptr_avion.aereovia));
      
      Escribir(cadena => "Generando el nuevo avión...");
      aereovias(avion.aereovia).barreraAereovia(Posicion_ZonaEspacioAereo(avion.pos.X));
      Escribir(cadena => "El nuevo avión pasó la barrera de seguridad");
      Aparece(avion);
      
      loop
         siguiente := Nueva_PosicionX(avion.pos.X, avion.velocidad.X);
         if Posicion_ZonaEspacioAereo(avion.pos.X) /= Posicion_ZonaEspacioAereo(siguiente) then
            aereovias(avion.aereovia).cambiar(Posicion_ZonaEspacioAereo(siguiente),Posicion_ZonaEspacioAereo(avion.pos.X));
            Actualiza_Movimiento(avion);
         else
            Actualiza_Movimiento(avion);
         end if;
         delay(PKG_tipos.RETARDO_MOVIMIENTO);
      end loop;
      
      exception
      when event : DETECTADA_COLISION =>
         Desaparece(avion);
         Escribir("ERROR en TASK ...: " & Exception_Name(Exception_Identity(event)));
   end T_TareaAvion;
end GeneraAviones;

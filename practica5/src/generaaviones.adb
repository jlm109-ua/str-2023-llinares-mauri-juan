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
      
      estado : Boolean := False; -- Estado para el descenso
      pista : T_PistaAterrizaje; -- Pista asignada para el descenso
      
      rejilla_sig : T_Rango_Rejilla_X; -- Rejilla siguiente
      rejilla_act : T_Rango_Rejilla_X; -- Rejilla actual
      
      -- Procedimiento para que el avión siga volando en la misma aerovía
      procedure sigue is
      begin
         rejilla_sig := Posicion_ZonaEspacioAereo(Nueva_PosicionX(avion.pos.X,avion.velocidad.X));
         rejilla_act := Posicion_ZonaEspacioAereo(avion.pos.X);
         
         if rejilla_act /= rejilla_sig then
            aereovias(avion.aereovia).cambiar(rejilla_sig, rejilla_act);
         end if;
         
         Actualiza_Movimiento(avion);
         delay Duration(RETARDO_MOVIMIENTO);
      end sigue;
      
      -- Procedimiento para que el avión descienda de aerovía
      procedure desciende is
      begin
         rejilla_act := Posicion_ZonaEspacioAereo(avion.pos.X);
         
         aereovias(avion.aereovia).liberar(rejilla_act);
         aereovias(avion.aereovia + 1).ocupar(rejilla_act);
         
         -- Eliminamos el avión
         Desaparece(avion);
         aereovias(avion.aereovia - 1).decAviones;
         
         -- Actualizamos su nueva aerovía
         avion.aereovia := avion.aereovia + 1;
         
         -- Cambiamos el sentido de la dirección del vuelo
         avion.velocidad.X := (if avion.aereovia rem 2 = 0 then VELOCIDAD_VUELO else -VELOCIDAD_VUELO);
         
         avion.pos := Pos_Inicio(avion.pos.X, avion.aereovia);
         
         -- Actualizamos su color a amarillo
         if avion.pista = SIN_PISTA then
            avion.pista := pista;
            avion.color := (if pista = PISTA1 then Blue else Yellow);
         end if;
         
         -- Volvemos a mostrar el avión
         Aparece(avion);
      end desciende;
   begin
      avion := ptr_avion.all;
      
      Escribir(cadena => "Informacion del avion: " & avion.id'Image);
      Put_line("TASK Avion: " & T_IdAvion'Image(ptr_avion.id) & " -" 
               & T_Rango_AereoVia'Image(ptr_avion.aereovia));
      
      Escribir(cadena => "Generando el nuevo avión...");
      aereovias(avion.aereovia).barreraAereovia(Posicion_ZonaEspacioAereo(avion.pos.X));
      Aparece(avion);
      Escribir(cadena => "El nuevo avión pasó la barrera de seguridad");
      
      loop
         select
             -- Solicitamos descenso
             Tarea_Torre_Control.Descender(avion,estado,pista);
             Escribir("Avión " & avion.id'Image & " solicita descenso desde la aerovía " & avion.aereovia'Image);
                    
             rejilla_act := Posicion_ZonaEspacioAereo(avion.pos.X);
            
             -- Si las casillas adyacentes inferiores están libres y el descenso ha sido autorizado...
             if estado 
               and aereovias(avion.aereovia + 1).estado(rejilla_act) 
               and aereovias(avion.aereovia + 1).estado(rejilla_act + 1) 
               and aereovias(avion.aereovia + 1).estado(rejilla_act - 1)
             then
                 Escribir("Descenso autorizado");
               
                 -- Si es la última casilla, el avión aterrizará.
                 if avion.aereovia + 1 = T_Rango_AereoVia'Last then
                     Escribir("Avion " & avion.id'Image & "aterrizando en pista: " & avion.pista'Image);
                     aereovias(avion.aereovia).liberar(Posicion_ZonaEspacioAereo(avion.pos.X));
                     Desaparece(avion);
                     exit;
                 end if;
             else
                 Escribir("Descenso denegado");
                 aereovias(avion.aereovia + 1).decAviones;
                 sigue;
             end if;
         then abort
            loop 
               sigue;
            end loop;
         end select;
      end loop;
      
      exception
      when event : DETECTADA_COLISION =>
         Desaparece(avion);
         Escribir("ERROR en TASK ...: " & Exception_Name(Exception_Identity(event)));
   end T_TareaAvion;
end GeneraAviones;

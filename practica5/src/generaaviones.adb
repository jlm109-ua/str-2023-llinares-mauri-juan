with Ada.Text_IO; use Ada.Text_IO;

package body GeneraAviones is
 task body TareaGeneraAviones is
      tarea_avion : Ptr_TareaAvion; -- Puntero al avion
      ptr_avion : Ptr_T_RecordAvion; -- Puntero a la informaci�n del avion
      
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
            
            --Cambia la direcci�n de vuelo del avion
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
      consulta : Boolean := False; -- Consulta para ver si el avi�n ha podido bajar
      descensoAux : Boolean := False; -- Variable auxiliar para manejar el descenso
      pista : T_PistaAterrizaje; -- Pista asignada para el descenso
      
      rejilla_sig : T_Rango_Rejilla_X; -- Rejilla siguiente
      rejilla_act : T_Rango_Rejilla_X; -- Rejilla actual
      
      -- Procedimiento para que el avi�n siga volando en la misma aerov�a
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
      
      -- Procedimiento para que el avi�n descienda de aerov�a
      procedure desciende is

      begin
         rejilla_act := Posicion_ZonaEspacioAereo(avion.pos.X);
         
         aereovias(avion.aereovia).liberar(rejilla_act);
         aereovias(avion.aereovia + 1).ocupar(rejilla_act);
         
         -- Eliminamos el avi�n
         Desaparece(avion);
         aereovias(avion.aereovia - 1).decAviones;
         
         -- Actualizamos su nueva aerov�a
         avion.aereovia := avion.aereovia + 1;
         
         -- Cambiamos el sentido de la direcci�n del vuelo
         avion.velocidad.X := (if avion.aereovia rem 2 = 0 then VELOCIDAD_VUELO else -VELOCIDAD_VUELO);
         
         avion.pos := Pos_Inicio(avion.pos.X, avion.aereovia);
         
         -- Actualizamos su color a amarillo
         if avion.pista = SIN_PISTA then
            avion.pista := pista;
            avion.color := (if pista = PISTA1 then Blue else Yellow);
         end if;
         
         -- Volvemos a mostrar el avi�n
         Aparece(avion);
      end desciende;
   begin
      avion := ptr_avion.all;
      
      Escribir(cadena => "Informacion del avion: " & avion.id'Image);
      Put_line("TASK Avion: " & T_IdAvion'Image(ptr_avion.id) & " -" 
               & T_Rango_AereoVia'Image(ptr_avion.aereovia));
      
      Escribir(cadena => "Generando el nuevo avi�n...");
      aereovias(avion.aereovia).barreraAereovia(Posicion_ZonaEspacioAereo(avion.pos.X));
      Aparece(avion);
      Escribir(cadena => "El nuevo avi�n pas� la barrera de seguridad");
      
      loop
         select
             -- Solicitamos descenso
             Tarea_Torre_Control.Descender(avion,estado,pista);
             Escribir("Avi�n " & avion.id'Image & " solicita descenso desde la aerov�a " & avion.aereovia'Image);
                    
             rejilla_act := Posicion_ZonaEspacioAereo(avion.pos.X);
            
             -- Si las casillas adyacentes inferiores est�n libres y el descenso ha sido autorizado...
            if estado then
               Escribir("Descenso autorizado");
               
               while not descensoAux loop
                  aereovias(avion.aereovia).bajar(consulta,rejilla_act,avion.aereovia+1);
                  if consulta then
                     Escribir("DEBUG: Consulta exitosa");
                     Desaparece(avion);
                     descensoAux := true;
                     avion.aereovia := avion.aereovia + 1;
                     Aparece(avion);
                  else
                     Escribir("DEBUG: Consulta falllida");
                     sigue;
                  end if;
               end loop;
               descensoAux := false; -- Reiniciamos la variable por si tiene que descender m�s
            end if;
            delay 2.0;
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

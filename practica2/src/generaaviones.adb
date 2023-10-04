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
            
            -- Crear una tarea para el comportamiento del avion
            tarea_avion := NEW T_TareaAvion(ptr_avion);
            
            -- Generamos el retardo
            delay(Duration(pkg_retardosRandom.Random(generadorRetardos)));
         end loop;
      end loop;
   end TareaGeneraAviones;
   
   TASK BODY T_TareaAvion IS
      avion : T_RecordAvion;
   begin
      avion := ptr_avion.all;
      
      Escribir(cadena => "Informacion del avion");
      Put_line("TASK Avion: " & T_IdAvion'Image(ptr_avion.id) & " -" 
               & T_Rango_AereoVia'Image(ptr_avion.aereovia));
     
      Aparece(avion);
      
      exception
      when event : DETECTADA_COLISION =>
         Desaparece(avion);
         Escribir("ERROR en TASK ...: " & Exception_Name(Exception_Identity(event)));
   end T_TareaAvion;
end GeneraAviones;

 package body pkg_protegidos is

   function Posicion_ZonaEspacioAereo(pos_x : T_CoordenadaX) return T_Rango_Rejilla_X is
   begin
      return T_Rango_Rejilla_X(pos_x * TAM_X_REJILLA / (X_INICIO_DER_AVION+1));
   end Posicion_ZonaEspacioAereo;
   
   protected body OP_Aereovias is
      -- Función para comprobar si una posición está libre.
      function estado(pos : T_Rango_Rejilla_X) return Boolean is
      begin
         return zonas_ocupadas(pos);
      end estado;
   
      -- Procedimiento para ocupar una posición en una aerovía.
      procedure ocupar(pos : T_Rango_Rejilla_X) is
      begin
         zonas_ocupadas(pos) := True;
      end ocupar;
   
      -- Procedimiento para dejar libre una posición en una aerovía.
      procedure liberar(pos : T_Rango_Rejilla_X) is
      begin
         zonas_ocupadas(pos) := False;
      end liberar;
      
      -- Procedimiento para cambiar las posiciones en una aerovía.
      procedure cambiar(posBloquear : T_Rango_Rejilla_X; posLiberar : T_Rango_Rejilla_X) is
      begin
         liberar(posLiberar);
         ocupar(posBloquear);
      end;
      
      -- Procedimiento para consultar y actualizar.
      procedure bajar(consulta : out Boolean; rejilla_act : T_Rango_Rejilla_X; aereovia : T_Rango_AereoVia) is
      begin
         if aereovias(aereovia).estado(rejilla_act) 
           and aereovias(aereovia).estado(rejilla_act + 1) 
           and aereovias(aereovia).estado(rejilla_act - 1)
         then
            aereovias(aereovia-1).liberar(rejilla_act);
            aereovias(aereovia).ocupar(rejilla_act);
            consulta := true;
         else
            consulta := false;
         end if;
      end;
   
      -- Función para revisar cuántos aviones hay en el contador.
      function cantidad return contador is
      begin
         return cont;
      end cantidad;
   
      -- Incrementa el número de aviones que hay en el contador.
      procedure incAviones is
      begin
         cont := cont + 1;
      end incAviones;
   
      -- Decrementa el número de aviones que hay en el contador.
      procedure decAviones is 
      begin
         cont := cont - 1;
      end decAviones;
   
      -- Barrera para limitar la aparición de aviones.
      entry barreraAereovia(pos : T_Rango_Rejilla_X) when not zonas_ocupadas(T_Rango_Rejilla_X'First) 
        and not zonas_ocupadas(T_Rango_Rejilla_X'First + 1) 
        and not zonas_ocupadas(T_Rango_Rejilla_X'Last - 1) 
        and not zonas_ocupadas(T_Rango_Rejilla_X'Last)
        and cont <= MAX_AVIONES_AEROVIA is
      begin
         -- Ha pasado la barrera.
         if pos = T_Rango_Rejilla_X'First then
            zonas_ocupadas(T_Rango_Rejilla_X'First) := True;
         else
            zonas_ocupadas(T_Rango_Rejilla_X'Last) := True;
         end if;
         incAviones;
      end barreraAereovia;
  end OP_Aereovias;
end pkg_protegidos;

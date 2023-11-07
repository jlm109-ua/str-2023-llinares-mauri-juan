 package body pkg_protegidos is

   function Posicion_ZonaEspacioAereo(pos_x : T_CoordenadaX) return T_Rango_Rejilla_X is
   begin
      return T_Rango_Rejilla_X(pos_x * TAM_X_REJILLA / (X_INICIO_DER_AVION+1));
   end Posicion_ZonaEspacioAereo;
   
   protected body OP_Aereovias is
      -- Funci�n para comprobar si una posici�n est� libre.
      function estado(pos : T_Rango_Rejilla_X) return Boolean is
      begin
         return zonas_ocupadas(pos);
      end estado;
   
      -- Procedimiento para ocupar una posici�n en una aerov�a.
      procedure ocupar(pos : T_Rango_Rejilla_X) is
      begin
         zonas_ocupadas(pos) := True;
      end ocupar;
   
      -- Procedimiento para dejar libre una posici�n en una aerov�a.
      procedure liberar(pos : T_Rango_Rejilla_X) is
      begin
         zonas_ocupadas(pos) := False;
      end liberar;
      
      -- Procedimiento para cambiar las posiciones en una aerov�a.
      procedure cambiar(posBloquear : T_Rango_Rejilla_X; posLiberar : T_Rango_Rejilla_X) is
      begin
         liberar(posLiberar);
         ocupar(posBloquear);
      end;
   
      -- Funci�n para revisar cu�ntos aviones hay en el contador.
      function cantidad return contador is
      begin
         return cont;
      end cantidad;
   
      -- Incrementa el n�mero de aviones que hay en el contador.
      procedure incAviones is
      begin
         cont := cont + 1;
      end incAviones;
   
      -- Decrementa el n�mero de aviones que hay en el contador.
      procedure decAviones is 
      begin
         cont := cont - 1;
      end decAviones;
   
      -- Barrera para limitar la aparici�n de aviones.
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

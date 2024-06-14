package body PKG_Protegidos is

   function Posicion_ZonaEspacioAereo(pos_x : T_CoordenadaX) return T_Rango_Rejilla_X is
   begin
      return T_Rango_Rejilla_X(pos_x * TAM_X_REJILLA / (X_INICIO_DER_AVION+1));
   end Posicion_ZonaEspacioAereo;
   
   protected body OP_Aerovia is
      
      -- -- Métodos propios del tipo
      -- Comprueba si la posición está libre
      function libre(pos_x : T_Rango_Rejilla_X) return Boolean is 
      begin
         return aerovia(pos_x);         
      end libre;
      
      -- Libera un espacio de la aerovía
      procedure liberar(pos_x : T_Rango_Rejilla_X) is
      begin
         aerovia(pos_x) := False;
      end liberar;
      
      -- Ocupa un espacio de la aerovía
      procedure ocupar(pos_x : T_Rango_Rejilla_X) is
      begin
         aerovia(pos_x) := True;
      end ocupar;
      
      -- Cambia las posiciones de la aerovía
      procedure cambiar(pos_ocupar : T_Rango_Rejilla_X; pos_liberar : T_Rango_Rejilla_X) is
      begin
         liberar(pos_liberar);
         ocupar(pos_ocupar);
      end cambiar;
      
      -- -- Manejo del contador
      -- Incrementa el contador en uno
      procedure incContador is
      begin
         cont := cont + 1;
      end incContador;
      
      -- Decrementa el contador en uno
      procedure decContador is
      begin
         cont := cont -1;
      end decContador;
      
      -- Devuelve el valor del contador
      function cantidad return contador is
      begin
         return cont;
      end cantidad;
      
      entry estadoAerovia(pos_x : T_Rango_Rejilla_X) when 
        not aerovia(T_Rango_Rejilla_X'First)
        and not aerovia(T_Rango_Rejilla_X'Last)
        and not aerovia(T_Rango_Rejilla_X'First + 1)
        and not aerovia(T_Rango_Rejilla_X'Last - 1)
        and cont <= MAX_AVIONES_AEROVIA
      is
      begin
         aerovia(pos_x) := True;
         incContador; 
      end estadoAerovia;
      
   end OP_Aerovia;

end PKG_Protegidos;

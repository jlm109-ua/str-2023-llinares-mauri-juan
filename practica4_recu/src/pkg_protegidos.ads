with PKG_tipos; use PKG_tipos;

package PKG_Protegidos is
   
   subtype contador is Integer range 0..MAX_AVIONES_AEROVIA; -- contador para los aviones m�ximos por aerov�a
   function Posicion_ZonaEspacioAereo(pos_x : T_CoordenadaX) return T_Rango_Rejilla_X; -- asocia la posici�n del avi�n en la aerov�a
   
   protected type OP_Aerovia is
      
      -- -- M�todos propios del tipo
      -- Comprueba si la posici�n est� libre
      function libre(pos_x : T_Rango_Rejilla_X) return Boolean;
      -- Ocupa un espacio de la aerov�a
      procedure ocupar(pos_x : T_Rango_Rejilla_X);
      -- Libera un espacio de la aerov�a
      procedure liberar(pos_x : T_Rango_Rejilla_X);
      -- Realiza el cambio de los espacios ocupados
      procedure cambiar(pos_ocupar : T_Rango_Rejilla_X; pos_liberar : T_Rango_Rejilla_X);
      
      -- -- Manejo del contador
      -- Incrementa el contador en uno
      procedure incContador;
      -- Decrementa el contador en uno
      procedure decContador;
      -- Devuelve el valor del contador
      function cantidad return contador;
      
      -- Condici�n para entrar a la aerov�a.
      entry estadoAerovia(pos_x : T_Rango_Rejilla_X);
      
   private
      
      aerovia : T_Rejilla_Ocupacion := (others => False); -- array que contiene por d�nde pasan los aviones en la misma l�nea
      cont : contador := 0; 
        
   end OP_Aerovia;
   
   aerovias : array(T_Rango_AereoVia) of OP_Aerovia; -- array de aerov�as, cada aerov�a es una l�nea por donde vuelan los aviones
   

end PKG_Protegidos;

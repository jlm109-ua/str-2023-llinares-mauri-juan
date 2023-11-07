with PKG_tipos; use PKG_tipos;

package pkg_protegidos is
   -- Contador para limitar el número de aviones que hay en la aerovía.
   subtype contador is Integer range 0..MAX_AVIONES_AEROVIA;
   function Posicion_ZonaEspacioAereo(pos_x : T_CoordenadaX) return T_Rango_Rejilla_X;

   -- Tipo protegido para manejar las aerovias.
   protected type OP_Aereovias is
  
      -- Función para comprobar si una posición está libre.
      function estado(pos : T_Rango_Rejilla_X) return Boolean;
      -- Procedimiento para ocupar una posición en una aerovía.
      procedure ocupar(pos : T_Rango_Rejilla_X);
      -- Procedimiento para dejar libre una posición en una aerovía.
      procedure liberar(pos : T_Rango_Rejilla_X);
      -- Procedimiento para cambiar las posiciones en una aerovía.
      procedure cambiar(posBloquear : T_Rango_Rejilla_X; posLiberar : T_Rango_Rejilla_X);
      
      
      -- Relacionadas con el contador...
      -- Función para revisar cuántos aviones hay en el contador.
      function cantidad return contador;
      -- Incrementa el número de aviones que hay en el contador.
      procedure incAviones;
      -- Decrementa el número de aviones que hay en el contador.
      procedure decAviones;
      
      -- Barrera para poder entrar al espacio protegido.
      entry barreraAereovia(pos : T_Rango_Rejilla_X);
      
   private
      -- Array con el que controlar las zonas donde hay aviones.
      zonas_ocupadas : T_Rejilla_Ocupacion := (others => False);
      cont : contador := 0;
   end OP_Aereovias;
   
  -- Array de las aerovías protegidas.
   aereovias : array(T_Rango_AereoVia) of OP_Aereovias;

end pkg_protegidos;

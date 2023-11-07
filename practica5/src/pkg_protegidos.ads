with PKG_tipos; use PKG_tipos;

package pkg_protegidos is
   -- Contador para limitar el n�mero de aviones que hay en la aerov�a.
   subtype contador is Integer range 0..MAX_AVIONES_AEROVIA;
   function Posicion_ZonaEspacioAereo(pos_x : T_CoordenadaX) return T_Rango_Rejilla_X;

   -- Tipo protegido para manejar las aerovias.
   protected type OP_Aereovias is
  
      -- Funci�n para comprobar si una posici�n est� libre.
      function estado(pos : T_Rango_Rejilla_X) return Boolean;
      -- Procedimiento para ocupar una posici�n en una aerov�a.
      procedure ocupar(pos : T_Rango_Rejilla_X);
      -- Procedimiento para dejar libre una posici�n en una aerov�a.
      procedure liberar(pos : T_Rango_Rejilla_X);
      -- Procedimiento para cambiar las posiciones en una aerov�a.
      procedure cambiar(posBloquear : T_Rango_Rejilla_X; posLiberar : T_Rango_Rejilla_X);
      
      
      -- Relacionadas con el contador...
      -- Funci�n para revisar cu�ntos aviones hay en el contador.
      function cantidad return contador;
      -- Incrementa el n�mero de aviones que hay en el contador.
      procedure incAviones;
      -- Decrementa el n�mero de aviones que hay en el contador.
      procedure decAviones;
      
      -- Barrera para poder entrar al espacio protegido.
      entry barreraAereovia(pos : T_Rango_Rejilla_X);
      
   private
      -- Array con el que controlar las zonas donde hay aviones.
      zonas_ocupadas : T_Rejilla_Ocupacion := (others => False);
      cont : contador := 0;
   end OP_Aereovias;
   
  -- Array de las aerov�as protegidas.
   aereovias : array(T_Rango_AereoVia) of OP_Aereovias;

end pkg_protegidos;

package pkg_tareas_dinamicas is
   MIN_VELOCIDAD_AVION         : constant := -10;
   MAX_VELOCIDAD_AVION         : constant := 10;
   VELOCIDAD_VUELO             : constant := 5;
   NUM_INICIAL_AVIONES_AEROVIA : constant := 3;
   NUM_AEREOVIAS               : constant := 6;
   type T_RangoVelocidad is
     new Integer range MIN_VELOCIDAD_AVION .. MAX_VELOCIDAD_AVION;
   -- identificador numérico de cada avión
   type T_IdAvion is mod NUM_INICIAL_AVIONES_AEROVIA;
   -- rango del número de aereovias de distintas altitudes
   type T_Rango_AereoVia is new Integer range 1 .. NUM_AEREOVIAS;
   -- velocidad de los aviones en los ejes X e Y
   type T_Velocidad is record
      X : T_RangoVelocidad;
      Y : T_RangoVelocidad;
   end record;
   -- tipo registro para almacenar los datos de un avión
   type T_RecordAvion is record
      id              : T_IdAvion;  -- identificador del avion
      velocidad       : T_Velocidad;
      aereovia        : T_Rango_AereoVia;
      tren_aterrizaje : Boolean;
   end record;
   type Ptr_T_RecordAvion is access T_RecordAvion;

   task TareaGeneraAviones;
   -- Tipo tarea encargada del comportamiento de un avion
   task type T_TareaAvion (ptr_avion : Ptr_T_RecordAvion);
   type Ptr_TareaAvion is access T_TareaAvion;
end pkg_tareas_dinamicas;

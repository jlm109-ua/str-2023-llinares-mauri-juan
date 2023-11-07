with PKG_tipos; use PKG_tipos;
with pkg_protegidos; use pkg_protegidos;

package pkg_torre_control is
   task Tarea_Torre_Control is
      entry Iniciar_Torre_Control;
      entry Descender(avion : in T_RecordAvion; estado : out Boolean; pista : out T_PistaAterrizaje);
   end Tarea_Torre_Control;
end pkg_torre_control;

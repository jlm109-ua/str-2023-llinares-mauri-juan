with PKG_tipos; use PKG_tipos;
with Ada.Numerics.Discrete_Random;
with PKG_debug; use PKG_debug;
with PKG_graficos; use PKG_graficos;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with PKG_Protegidos; use PKG_Protegidos;

package GeneraAviones is
   task TareaGeneraAviones;
   task type T_TareaAvion (ptr_avion : Ptr_T_RecordAvion);
   type Ptr_TareaAvion is access T_TareaAvion;
end GeneraAviones;

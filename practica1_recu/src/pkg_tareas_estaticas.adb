with Ada.Numerics.Discrete_Random;  
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO; 
with Ada.Text_IO; use Ada.Text_IO; 

package body pkg_tareas_estaticas is
   task body T_Tarea is
      subtype T_Num is Integer range a..b;
      package pkg_NumAleatorio is new Ada.Numerics.Discrete_Random (T_Num);  
      use pkg_NumAleatorio;
      generador_num : Generator;  
      num : T_Num;
   begin
      Reset(generador_num); 
      for i in 1..20 loop
         num:= Random(generador_num);  
         Put(num);
         New_Line;
         -- delay(0.01);  -- La tarea queda suspendida 0.01 segundos
         -- Si el delay se comenta, las tareas se ejecutan al ojo humano de manera secuencial, pero la concurrencia sigue estando sólo que se realiza muy rápido la ejecución.
      end loop;
   end T_Tarea;
begin
   put_line("Sentencias de inicializacion del paquete");
   -- Se podrían incluir todo tipo de inicialización de tareas, preparación de entradas u otras de la misma índole.
end pkg_tareas_estaticas;

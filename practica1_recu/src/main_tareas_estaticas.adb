-- Crea tareas que generan n�meros aleatorios del a al b. Como son est�ticas, se ejecutan una vez son creadas.
with pkg_tareas_estaticas; use pkg_tareas_estaticas;

procedure main_tareas_estaticas is
   tarea1 : T_Tarea(0,9);
   tarea2 : T_Tarea(10,99);
   tarea3 : T_Tarea(100,999);
begin
   null;
end main_tareas_estaticas;

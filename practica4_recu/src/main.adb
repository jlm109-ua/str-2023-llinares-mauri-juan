with PKG_graficos; use PKG_graficos;
with GeneraAviones; use GeneraAviones;
with PKG_CronoCalendar; use PKG_CronoCalendar;
-- with PKG_CronoRealTime; use PKG_CronoRealTime;
-- No se observa diferencia entre los dos porque estamos usando el mismo procedimiento para realizar el delay.

procedure Main is
begin
   Simular_Sistema;
end Main;

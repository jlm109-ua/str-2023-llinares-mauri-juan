with Ada.Numerics.Discrete_Random;  -- paquete gen�rico predefinido
with Ada.Integer_Text_IO; USE Ada.Integer_Text_IO; 
with Ada.Text_IO; use Ada.Text_IO;  

procedure ejercicio6 is
   subtype T_Digito is Integer range 0..9;-- crear instancia del paquete gen�rico predefinido
   package Pkg_DigitoAleatorio is new Ada.Numerics.Discrete_Random (T_Digito);  
   generador_digito :  pkg_DigitoAleatorio.Generator;  -- declarar generador de valores aleatorios tipo T_Digito 
   digito : T_Digito;
   
begin
   pkg_DigitoAleatorio.Reset (Generador_Digito); -- Inicializa generador n�meros aleatorios
   loop
      digito := pkg_DigitoAleatorio.Random(generador_digito); -- generar n�mero aleatorio
      Put(digito); -- Al ser T_Digito un subtipo de Integer, se usa el Ada.Integer_Text_IO.
      skip_line;
   end loop;   
end ejercicio6;

-- Este programa crea n�meros aleatorios constantemente entre el 0 y el 9. Se instancia un paquete con el que generar los n�meros a partir de la unidad de librer�a Ada.Numerics.Discrete_Random.

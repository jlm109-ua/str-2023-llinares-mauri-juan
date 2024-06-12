pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main_tareas_estaticas.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main_tareas_estaticas.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E074 : Short_Integer; pragma Import (Ada, E074, "system__os_lib_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "ada__exceptions_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exception_table_E");
   E040 : Short_Integer; pragma Import (Ada, E040, "ada__containers_E");
   E069 : Short_Integer; pragma Import (Ada, E069, "ada__io_exceptions_E");
   E055 : Short_Integer; pragma Import (Ada, E055, "ada__strings_E");
   E057 : Short_Integer; pragma Import (Ada, E057, "ada__strings__maps_E");
   E061 : Short_Integer; pragma Import (Ada, E061, "ada__strings__maps__constants_E");
   E045 : Short_Integer; pragma Import (Ada, E045, "interfaces__c_E");
   E028 : Short_Integer; pragma Import (Ada, E028, "system__exceptions_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "system__object_reader_E");
   E050 : Short_Integer; pragma Import (Ada, E050, "system__dwarf_lines_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__soft_links__initialize_E");
   E039 : Short_Integer; pragma Import (Ada, E039, "system__traceback__symbolic_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "ada__numerics_E");
   E102 : Short_Integer; pragma Import (Ada, E102, "ada__strings__utf_encoding_E");
   E108 : Short_Integer; pragma Import (Ada, E108, "ada__tags_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "ada__strings__text_buffers_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "ada__streams_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "system__file_control_block_E");
   E123 : Short_Integer; pragma Import (Ada, E123, "system__finalization_root_E");
   E121 : Short_Integer; pragma Import (Ada, E121, "ada__finalization_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "system__file_io_E");
   E166 : Short_Integer; pragma Import (Ada, E166, "system__task_info_E");
   E162 : Short_Integer; pragma Import (Ada, E162, "system__task_primitives__operations_E");
   E145 : Short_Integer; pragma Import (Ada, E145, "ada__calendar_E");
   E198 : Short_Integer; pragma Import (Ada, E198, "ada__real_time_E");
   E096 : Short_Integer; pragma Import (Ada, E096, "ada__text_io_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "system__random_seed_E");
   E176 : Short_Integer; pragma Import (Ada, E176, "system__tasking__initialization_E");
   E186 : Short_Integer; pragma Import (Ada, E186, "system__tasking__protected_objects_E");
   E188 : Short_Integer; pragma Import (Ada, E188, "system__tasking__protected_objects__entries_E");
   E184 : Short_Integer; pragma Import (Ada, E184, "system__tasking__queuing_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "system__tasking__stages_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "pkg_tareas_estaticas_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E188 := E188 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F1;
      end;
      E096 := E096 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "ada__text_io__finalize_spec");
      begin
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "system__file_io__finalize_body");
      begin
         E120 := E120 - 1;
         F3;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           True, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, False, False, True, True, False, False, 
           True, False, False, True, True, True, True, False, 
           False, False, False, True, False, False, True, True, 
           False, True, True, False, True, True, True, True, 
           False, False, False, False, False, True, False, False, 
           True, False, False, False, False, True, False, False, 
           False, True, False, False, False, True, False, False, 
           False, False, False, True, False, False, True, False, 
           True, True, True, False, False, True, False, True, 
           True, True, False, True, True, False, True, True, 
           True, True, False, False, False, False, False, False, 
           False, False, False, False, False, True, False, False, 
           False),
         Count => (0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
         Unknown => (False, False, False, False, False, False, True, False, False, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E027 := E027 + 1;
      Ada.Containers'Elab_Spec;
      E040 := E040 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E069 := E069 + 1;
      Ada.Strings'Elab_Spec;
      E055 := E055 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E057 := E057 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E061 := E061 + 1;
      Interfaces.C'Elab_Spec;
      E045 := E045 + 1;
      System.Exceptions'Elab_Spec;
      E028 := E028 + 1;
      System.Object_Reader'Elab_Spec;
      E080 := E080 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E050 := E050 + 1;
      System.Os_Lib'Elab_Body;
      E074 := E074 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E023 := E023 + 1;
      E015 := E015 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E039 := E039 + 1;
      E010 := E010 + 1;
      Ada.Numerics'Elab_Spec;
      E139 := E139 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      E102 := E102 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E108 := E108 + 1;
      Ada.Strings.Text_Buffers'Elab_Spec;
      Ada.Strings.Text_Buffers'Elab_Body;
      E100 := E100 + 1;
      Ada.Streams'Elab_Spec;
      E098 := E098 + 1;
      System.File_Control_Block'Elab_Spec;
      E124 := E124 + 1;
      System.Finalization_Root'Elab_Spec;
      System.Finalization_Root'Elab_Body;
      E123 := E123 + 1;
      Ada.Finalization'Elab_Spec;
      E121 := E121 + 1;
      System.File_Io'Elab_Body;
      E120 := E120 + 1;
      System.Task_Info'Elab_Spec;
      E166 := E166 + 1;
      System.Task_Primitives.Operations'Elab_Body;
      E162 := E162 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E145 := E145 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E198 := E198 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E096 := E096 + 1;
      System.Random_Seed'Elab_Body;
      E143 := E143 + 1;
      System.Tasking.Initialization'Elab_Body;
      E176 := E176 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E186 := E186 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E188 := E188 + 1;
      System.Tasking.Queuing'Elab_Body;
      E184 := E184 + 1;
      System.Tasking.Stages'Elab_Body;
      E149 := E149 + 1;
      pkg_tareas_estaticas'elab_body;
      E005 := E005 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main_tareas_estaticas");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /home/str/PRACTICAS/practica1/obj/pkg_tareas_estaticas.o
   --   /home/str/PRACTICAS/practica1/obj/main_tareas_estaticas.o
   --   -L/home/str/PRACTICAS/practica1/obj/
   --   -L/home/str/PRACTICAS/practica1/obj/
   --   -L/usr/gnat/lib/gcc/x86_64-pc-linux-gnu/10.3.1/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -lrt
   --   -lpthread
   --   -ldl
--  END Object file/option list   

end ada_main;

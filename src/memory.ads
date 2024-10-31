package Memory is

   type Byte is mod 2**8;
   pragma Provide_Shift_Operators (Byte);
   Byte_Size : constant Integer := Integer (Byte'Last - Byte'First + 1);

   --  General Purpose Memory
   type Memory_Idx is range 16#1# .. 16#1000#;
   type Program_Space is range 16#200# .. 16#1000#;
   type Memory_Array is array (Memory_Idx range <>) of Byte;
   subtype System_Memory is Memory_Array (Memory_Idx'First .. Memory_Idx'Last);

   --  Stack and Registers
   type Stack_Idx is range 1 .. 32;
   type Stack_Type is array (Stack_Idx) of Memory_Idx;
   type Registers_Type is array (0 .. 15) of Byte;

   type Emulator_State is record
      Mem             : System_Memory;
      Program_Counter : Memory_Idx;
      Index           : Memory_Idx;
      Stack           : Stack_Type;
      Stack_Ptr       : Stack_Idx;
      --  Delay Timer
      --  Sound Timer
      Registers       : Registers_Type;
   end record;

   procedure InitFont (Mem : in out System_Memory; Start_Idx : Memory_Idx);

   function InitState return Emulator_State;

private

   Glyph_Size : constant Memory_Idx := 5;

end Memory;

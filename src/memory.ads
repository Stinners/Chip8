package Memory is

   type Byte is mod 2**8;
   pragma Provide_Shift_Operators (Byte);
   type Memory_Idx is range 16#1# .. 16#1000#;
   type Program_Space is range 16#200# .. 16#1000#;
   type Memory_Array is array (Memory_Idx range <>) of Byte;

   subtype System_Memory is Memory_Array (Memory_Idx'First .. Memory_Idx'Last);

   type Stack_Idx is range 1 .. 32;
   type Stack is array (Stack_Idx) of Memory_Idx;

   Byte_Size : constant Integer := Integer (Byte'Last - Byte'First + 1);

   procedure InitFont (Mem : in out System_Memory; Start_Idx : Memory_Idx);

end Memory;

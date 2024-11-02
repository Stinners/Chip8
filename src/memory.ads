with Interfaces.C; use Interfaces.C;

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

   --  The display is organized as an array of bytes, where each bit represents
   --  a pixel, this means that we can draw a sprit by just doing bitwise xor
   N_Columns : constant int := 64;
   N_Rows    : constant int := 32;

   type Display_Idx is range 1 .. (N_Columns * N_Rows / 8);
   type Display_Buffer is array (Display_Idx) of Memory.Byte;

   type Emulator_State is record
      Mem             : System_Memory;
      Program_Counter : Memory_Idx;
      Index           : Memory_Idx;
      Stack           : Stack_Type;
      Stack_Ptr       : Stack_Idx;
      --  Delay Timer
      --  Sound Timer
      Registers       : Registers_Type;
      Display         : Display_Buffer;
   end record;

   procedure InitFont (Mem : in out System_Memory; Start_Idx : Memory_Idx);

   function InitState return Emulator_State;

private

   Glyph_Size : constant Memory_Idx := 5;

end Memory;

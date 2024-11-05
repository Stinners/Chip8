with Memory; use Memory;

package Instruction is

   type Instruction is record
      First_Nibble  : Nibble;
      Second_Nibble : Nibble;
      Third_Nibble  : Nibble;
      Fourth_Nibble : Nibble;
      Second_Byte   : Memory.Byte;
      NNN           : Memory.Memory_Idx;
   end record;

   function Decode
     (Memory : System_Memory; Ptr : Memory_Idx) return Instruction with
     Pre => Ptr /= Memory_Idx'Last;

   procedure Execute
     (State : in out Emulator_State; This_Instruction : Instruction);

   --  TODO, give the skip instructions better names
   Clear_Screen_Op : constant Nibble := 16#0#;
   Jump_Op         : constant Nibble := 16#1#;
   Sub_Routine_Op  : constant Nibble := 16#2#;
   Skip_3_Op       : constant Nibble := 16#3#;
   Skip_4_Op       : constant Nibble := 16#4#;
   Skip_5_Op       : constant Nibble := 16#5#;
   Set_Op          : constant Nibble := 16#6#;
   Add_Op          : constant Nibble := 16#7#;
   Logical_Op      : constant Nibble := 16#8#;
   Skip_9_Op       : constant Nibble := 16#9#;
   Set_Index_Op    : constant Nibble := 16#A#;
   Jump_Offset_Op  : constant Nibble := 16#B#;
   Random_Op       : constant Nibble := 16#C#;
   Display_Op      : constant Nibble := 16#D#;
   Skip_If_Op      : constant Nibble := 16#E#;
   Misc_OP         : constant Nibble := 16#F#;

private

   function FirstNibble (This_Byte : Byte) return Nibble;
   function SecondNibble (This_Byte : Byte) return Nibble;

   procedure Clear_Screen (Display : in out Display_Buffer);

end Instruction;

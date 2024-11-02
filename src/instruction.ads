with Memory; use Memory;

package Instruction is

   type Nibble is mod 16#F#;

   type Instruction (Opcode : Nibble) is record
      X   : Nibble;              --  Second Nibble
      Y   : Nibble;              --  Third Nibble
      N   : Nibble;              --  Fourth Nibble
      NN  : Memory.Byte;         --  Second Byte (Third and fourth Nibble)
      NNN : Memory.Memory_Idx;   --  2nd, 3rd 4th Nibble
   end record;

   function Decode
     (Memory : System_Memory; Ptr : Memory_Idx) return Instruction with
     Pre => Ptr /= Memory_Idx'Last;

   --  procedure Execute
   --    (State : in out Emulator_State; This_Instruction : Instruction);

   Clear_Screen_Op : constant Nibble := 16#0#;

private

   function FirstNibble (This_Byte : Byte) return Nibble;
   function SecondNibble (This_Byte : Byte) return Nibble;

   --  procedure Do_Clear_Screen(

end Instruction;

with Memory;

package Instruction is

   type Nibble is mod 16#0#;

   type Instruction (Opcode : Nibble) is record
      X   : Nibble;
      Y   : Nibble;
      N   : Nibble;
      NN  : Memory.Byte;
      NNN : Memory.Memory_Idx;
   end record;

end Instruction;

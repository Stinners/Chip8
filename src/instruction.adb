package body Instruction is

   ----------------------------------------------------------------
   function Decode
     (Memory : System_Memory; Ptr : Memory_Idx) return Instruction
   is
      This_Byte : constant Byte   := Memory (Ptr);
      Opcode    : constant Nibble := FirstNibble (This_Byte);
      X         : constant Nibble := SecondNibble (This_Byte);
      Next_Byte : constant Byte   := Memory (Ptr + 1);
      Y         : constant Nibble := FirstNibble (Next_Byte);
      N         : constant Nibble := SecondNibble (Next_Byte);

      NNN : constant Memory_Idx :=
        Memory_Idx (Next_Byte) + (256 * Memory_Idx (Y));
   begin
      return
        (Opcode => Opcode, X => X, Y => Y, N => N, NN => Next_Byte,
         NNN    => NNN);
   end Decode;
   ----------------------------------------------------------------

   --  procedure Execute(State: Emulator_State; This_Instruction: Instruction)
   --  is
   --  begin
   --    case This_Instruction.Opcode is
   --       when Clear_Screen_Op then
   --
   --    end case;
   --  end Execute;

   function FirstNibble (This_Byte : Byte) return Nibble is
      Mask : constant Byte := 2#0000_1111#;
   begin
      return Nibble (This_Byte and Mask);
   end FirstNibble;

   function SecondNibble (This_Byte : Byte) return Nibble is
      Mask        : constant Byte := 2#1111_0000#;
      Nibble_Bits : constant Byte := This_Byte and Mask;
   begin
      return Nibble (Shift_Right (Nibble_Bits, 4));
   end SecondNibble;

end Instruction;

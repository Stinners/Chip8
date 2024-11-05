package body Instruction is

   ----------------------------------------------------------------
   function Decode
     (Memory : System_Memory; Ptr : Memory_Idx) return Instruction
   is
      First_Byte    : constant Byte   := Memory (Ptr);
      First_Nibble  : constant Nibble := FirstNibble (First_Byte);
      Second_Nibble : constant Nibble := SecondNibble (First_Byte);
      Second_Byte   : constant Byte   := Memory (Ptr + 1);
      Third_Nibble  : constant Nibble := FirstNibble (Second_Byte);
      Fourth_Nibble : constant Nibble := SecondNibble (Second_Byte);

      NNN : constant Memory_Idx :=
        Memory_Idx (Second_Byte) + (256 * Memory_Idx (Second_Nibble));

   begin
      return
        (First_Nibble => First_Nibble, Second_Nibble => Second_Nibble,
         Third_Nibble => Third_Nibble, Fourth_Nibble => Fourth_Nibble,
         Second_Byte  => Second_Byte, NNN => NNN);
   end Decode;
   ----------------------------------------------------------------

   ----------------------------------------------------------------
   function FirstNibble (This_Byte : Byte) return Nibble is
      Mask : constant Byte := 2#0000_1111#;
   begin
      return Nibble (This_Byte and Mask);
   end FirstNibble;
   -------------------------------------------------------------

   -------------------------------------------------------------
   function SecondNibble (This_Byte : Byte) return Nibble is
      Mask        : constant Byte := 2#1111_0000#;
      Nibble_Bits : constant Byte := This_Byte and Mask;
   begin
      return Nibble (Shift_Right (Nibble_Bits, 4));
   end SecondNibble;
   -------------------------------------------------------------

   --  TODO, define an exception for invalid instructions
   -------------------------------------------------------------
   procedure Execute
     (State : in out Emulator_State; This_Instruction : Instruction)
   is
   begin

      case This_Instruction.First_Nibble is

         --  0
         when Clear_Screen_Op =>
            if This_Instruction.Third_Nibble = 16#E# then
               Clear_Screen (State.Display);
            end if;

            --  1
         when Jump_Op =>
            State.Program_Counter := This_Instruction.NNN;

            --  3
         when Skip_3_Op =>
            if State.Registers (This_Instruction.Second_Nibble) =
              This_Instruction.Second_Byte
            then
               State.Program_Counter := State.Program_Counter + 2;
            end if;

            --  5
         when Skip_5_Op =>
            if State.Registers (This_Instruction.Second_Nibble) =
              State.Registers (This_Instruction.Third_Nibble)
            then
               State.Program_Counter := State.Program_Counter + 2;
            end if;

            --  6
         when Set_Op =>
            State.Registers (This_Instruction.Second_Nibble) :=
              This_Instruction.Second_Byte;

            --  7
         when Add_Op =>
            State.Registers (This_Instruction.Second_Nibble) :=
              @ + This_Instruction.Second_Byte;

            --  9
         when Skip_9_Op =>
            if State.Registers (This_Instruction.Second_Nibble) /=
              State.Registers (This_Instruction.Third_Nibble)
            then
               State.Program_Counter := @ + 2;
            end if;

            --  A
         when Set_Index_Op =>
            State.Index := This_Instruction.NNN;

         when others =>
            null;

      end case;

      if This_Instruction.First_Nibble /= Jump_Op then
         State.Program_Counter := @ + 2;
      end if;
   end Execute;
   -------------------------------------------------------------

   -------------------------------------------------------------
   procedure Clear_Screen (Display : in out Display_Buffer) is
   begin
      for idx in Display_Buffer'Range loop
         Display (idx) := 0;
      end loop;
   end Clear_Screen;
   -------------------------------------------------------------

   --  Note: Unfinished
   -------------------------------------------------------------
   procedure Draw
     (State : in out Emulator_State; This_Instruction : Instruction)
   is
      Height : constant Nibble := This_Instruction.Fourth_Nibble;
      X_Cord : constant Byte   :=
        State.Registers (This_Instruction.Second_Nibble);
      Y_Cord : constant Byte   :=
        State.Registers (This_Instruction.Third_Nibble);

      Sprite : array (Byte) of Byte;
   begin
      for i in 0 .. (Height - 1) loop
         declare
            Mem_Idx : constant Memory_Idx := State.Index - Memory_Idx (i);
         begin
            Sprite (Byte (i)) := State.Mem (Mem_Idx);
         end;
      end loop;
   end Draw;
   -------------------------------------------------------------

end Instruction;

package body Memory is

   function InitState return Emulator_State is
   begin
      return
        (Mem     => [others => 0], Program_Counter => 1, Index => 1,
         Stack   => [others => 1], Stack_Ptr => 1, Registers => [others => 0],
         Display => [others => 0]);
   end InitState;

   procedure InitFont (Mem : in out System_Memory; Start_Idx : Memory_Idx) is

      --!pp off
      Glyphs : constant Memory_Array (1 .. Glyph_Size * 16) :=
        [16#F0#, 16#90#, 16#90#, 16#90#, 16#F0#,   --  0
         16#20#, 16#60#, 16#20#, 16#20#, 16#70#,   --  1
         16#F0#, 16#10#, 16#F0#, 16#80#, 16#F0#,   --  2
         16#F0#, 16#10#, 16#F0#, 16#10#, 16#F0#,   --  3
         16#90#, 16#90#, 16#F0#, 16#10#, 16#10#,   --  4
         16#F0#, 16#80#, 16#F0#, 16#10#, 16#F0#,   --  5
         16#F0#, 16#80#, 16#F0#, 16#90#, 16#F0#,   --  6
         16#F0#, 16#10#, 16#20#, 16#40#, 16#40#,   --  7
         16#F0#, 16#90#, 16#F0#, 16#90#, 16#F0#,   --  8
         16#F0#, 16#90#, 16#F0#, 16#10#, 16#F0#,   --  9
         16#F0#, 16#90#, 16#F0#, 16#90#, 16#90#,   --  A
         16#E0#, 16#90#, 16#E0#, 16#90#, 16#E0#,   --  B
         16#F0#, 16#80#, 16#80#, 16#80#, 16#F0#,   --  C
         16#E0#, 16#90#, 16#90#, 16#90#, 16#E0#,   --  D
         16#F0#, 16#80#, 16#F0#, 16#80#, 16#F0#,   --  E
         16#F0#, 16#80#, 16#F0#, 16#80#, 16#80#];  --  F
      --!pp on

      End_Idx : constant Memory_Idx := Start_Idx + Glyphs'Length - 1;
   begin
      Mem (Start_Idx .. End_Idx) := Glyphs;
   end InitFont;

end Memory;

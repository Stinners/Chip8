--  with Ada.Text_IO;
with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Raylib;

with Screen; use Screen;
with Memory;

procedure Chip8 is

   Title : constant chars_ptr := New_String ("CHIP-8");

   Emulator : Memory.Emulator_State := Memory.InitState;
   Display  : Display_Buffer        := [others => 0];

begin

   Memory.InitFont (Emulator.Mem, 16#050#);

   Screen.InitWindow
     (Title  => Title, Width => Screen.Window_Width,
      Height => Screen.Window_Height);

   SetTargetFPS (60);
   while WindowShouldClose = 0 loop

      --------- Input --------------------
      ------------------------------------

      ---------  Drawing  -----------------
      BeginDrawing;
      ClearBackground (Color => Border_Color);
      DrawPixels (Display);
      EndDrawing;
      ---------  End Drawing  -------------

   end loop;

end Chip8;

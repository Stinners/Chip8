with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

with Screen; use Screen;
with Memory;

procedure Chip8 is

   Title : constant chars_ptr := New_String ("CHIP-8");

   Mem     : Memory.System_Memory := [others => 0];
   Display : Display_Buffer       := [others => 0];

begin

   Memory.InitFont (Mem, 16#050#);

   Screen.InitWindow
     (Title  => Title, Width => Screen.Window_Width,
      Height => Screen.Window_Height);

   SetTargetFPS (60);
   while WindowShouldClose = 0 loop
      BeginDrawing;
      ClearBackground (Color => Border_Color);
      DrawPixels (Display);
      EndDrawing;
   end loop;

end Chip8;

with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

with Screen; use Screen;

procedure Chip8 is

   Title : constant chars_ptr := New_String ("CHIP-8");

begin

   Screen.InitWindow
     (Title  => Title, Width => Screen.Window_Width,
      Height => Screen.Window_Height);

   while WindowShouldClose = 0 loop
      BeginDrawing;
      ClearBackground (Color => Screen.RayWhite);
      DrawPixels
        (Window_Width, Window_Height, N_Columns, N_Rows, Black, DarkGray);
      EndDrawing;
   end loop;

end Chip8;

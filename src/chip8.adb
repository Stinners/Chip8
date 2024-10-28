with Ada.Text_IO;
with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

procedure Chip8 is

   N_Columns : constant int := 64;
   N_Rows    : constant int := 32;

   Window_Height : constant int := N_Rows * 15;
   Window_Width  : constant int := N_Columns * 15;

   type RayColor is record
      r : unsigned_char;
      g : unsigned_char;
      b : unsigned_char;
      a : unsigned_char;
   end record with
     Convention => C_Pass_By_Copy;

   type Rectangle is record
      X      : Float;
      Y      : Float;
      width  : Float;
      height : Float;
   end record with
     Convention => C_Pass_By_Copy;

   procedure InitWindow (Width, Height : int; Title : chars_ptr) with
     Import => True, Convention => C, External_Name => "InitWindow";

   procedure BeginDrawing with
     Import => True, Convention => C, External_Name => "BeginDrawing";

   procedure EndDrawing with
     Import => True, Convention => C, External_Name => "EndDrawing";

   function WindowShouldClose return int with
     Import => True, Convention => C, External_Name => "WindowShouldClose";

   procedure ClearBackground (Color : RayColor) with
     Import => True, Convention => C, External_Name => "ClearBackground";

   procedure DrawText
     (Text : chars_ptr; Pos_X, Pos_Y, Font_Size : int; Color : RayColor) with
     Import => True, Convention => C, External_Name => "DrawText";

   procedure DrawRectangle
     (Pos_X, Pos_Y, Width, Height : int; Color : RayColor) with
     Import => True, Convention => C, External_Name => "DrawRectangle";

   procedure DrawRectangleLines
     (Pos_X, Pos_Y, Width, Height : int; Color : RayColor) with
     Import => True, Convention => C, External_Name => "DrawRectangleLines";

   procedure DrawRectangleRec (Rec : Rectangle; Color : RayColor) with
     Import => True, Convention => C, External_Name => "DrawRectangleRec";

   procedure DrawRectangleLinesEx
     (Rec : Rectangle; Thickness : Float; Color : RayColor) with
     Import => True, Convention => C, External_Name => "DrawRectangleLinesEx";

   BrightRed : constant RayColor := (172, 82, 0, 255);
   LightGray : constant RayColor := (200, 200, 200, 255);
   DarkGray  : constant RayColor := (80, 80, 80, 255);
   RayWhite  : constant RayColor := (245, 245, 245, 255);
   DarkBlue  : constant RayColor := (0, 82, 172, 255);
   Black     : constant RayColor := (0, 0, 0, 255);

   Title          : constant chars_ptr :=
     New_String ("raylib [core] example - basic window");
   Text           : constant chars_ptr :=
     New_String ("Congrats! You created your first window!");
   Test_Rectangle : constant Rectangle := (10.0, 10.0, 100.0, 100.0);

   ------------------------------------------------------------------
   procedure DrawPixels
     (Screen_Width, Screen_Height, N_Columns, N_Rows : int;
      Pixel_Color, Grid_Color                        : RayColor)
   is
      Grid_Width   : Float := 0.5;
      Pixel_Width  : int   := Screen_Width / N_Columns;
      Pixel_Height : int   := Screen_Height / N_Rows;

      X, Y : int;
   begin

      -- Draw the pixels themselves
      for Row in 0 .. (N_Columns - 1) loop
         X := Row * Pixel_Width;

         for Col in 0 .. (N_Rows - 1) loop
            Y := Col * Pixel_Height;

            DrawRectangle
              (Pos_X  => X, Pos_Y => Y, Width => int (Pixel_Width),
               Height => int (Pixel_Height), Color => Pixel_Color);

         end loop;

      end loop;

      -- Draw the grid over top
      for Row in 0 .. (N_Columns - 1) loop
         X := int (Row * Pixel_Width);

         for Col in 0 .. (N_Rows - 1) loop
            Y := Col * Pixel_Height;

            DrawRectangleLinesEx
              ((Float (X), Float (Y), Float (Pixel_Width),
                Float (Pixel_Height)),
               Grid_Width, Grid_Color);

         end loop;

      end loop;
   end DrawPixels;
   ------------------------------------------------------------------

begin

   InitWindow (Title => Title, Width => Window_Width, Height => Window_Height);

   while WindowShouldClose = 0 loop
      BeginDrawing;
      ClearBackground (Color => RayWhite);
      DrawPixels
        (Window_Width, Window_Height, N_Columns, N_Rows, Black, DarkGray);
      EndDrawing;
   end loop;

end Chip8;

with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Screen is

   ------------------ Types -------------------------

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

   ------------------ Constants ---------------------

   N_Columns : constant int := 64;
   N_Rows    : constant int := 32;

   Window_Height : constant int := N_Rows * 15;
   Window_Width  : constant int := N_Columns * 15;

   BrightRed : constant RayColor := (172, 82, 0, 255);
   LightGray : constant RayColor := (200, 200, 200, 255);
   DarkGray  : constant RayColor := (80, 80, 80, 255);
   RayWhite  : constant RayColor := (245, 245, 245, 255);
   DarkBlue  : constant RayColor := (0, 82, 172, 255);
   Black     : constant RayColor := (0, 0, 0, 255);

   ------------------ Raylib Bindings ---------------------

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

   procedure DrawRectangle
     (Pos_X, Pos_Y, Width, Height : int; Color : RayColor) with
     Import => True, Convention => C, External_Name => "DrawRectangle";

   procedure DrawRectangleLinesEx
     (Rec : Rectangle; Thickness : Float; Color : RayColor) with
     Import => True, Convention => C, External_Name => "DrawRectangleLinesEx";

   ------------------ Raylib Bindings ---------------------

   procedure DrawPixels
     (Screen_Width, Screen_Height, N_Columns, N_Rows : int;
      Pixel_Color, Grid_Color                        : RayColor);

end Screen;

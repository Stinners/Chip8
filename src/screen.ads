with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

with Memory; use Memory;

package Screen is

   ------------------ Types And Constants-------------------------

   type RayColor is record
      r : unsigned_char;
      g : unsigned_char;
      b : unsigned_char;
      a : unsigned_char;
   end record with
     Convention => C_Pass_By_Copy;

   type Rectangle is private;

   N_Columns : constant int := 64;
   N_Rows    : constant int := 32;

   --  The display is organized as an array of bytes, where each bit represents
   --  a pixel, this means that we can draw a sprit by just doing bitwise xor
   type Display_Idx is range 1 .. (N_Columns * N_Rows / 8);
   type Display_Buffer is array (Display_Idx) of Memory.Byte;

   Border_Width  : constant int := 5;
   Window_Height : constant int := N_Rows * 15 + 2 * Border_Width;
   Window_Width  : constant int := N_Columns * 15 + 2 * Border_Width;

   Grid_Color      : constant RayColor := (20, 20, 20, 255);
   Border_Color    : constant RayColor := (200, 200, 200, 255);
   RayWhite        : constant RayColor := (245, 245, 245, 255);
   Pixel_Off_Color : constant RayColor := (0, 0, 0, 255);
   Pixel_On_Color  : constant RayColor := (0, 228, 48, 255);

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

   procedure SetTargetFPS (Frames : int) with
     Import => True, Convention => C, External_Name => "SetTargetFPS";

   ------------------ Sub-Programs ---------------------

   procedure DrawPixels (Display : Display_Buffer);

private

   type Rectangle is record
      X      : Float;
      Y      : Float;
      width  : Float;
      height : Float;
   end record with
     Convention => C_Pass_By_Copy;

   procedure DrawRectangle
     (Pos_X, Pos_Y, Width, Height : int; Color : RayColor) with
     Import => True, Convention => C, External_Name => "DrawRectangle";

   procedure DrawRectangleLinesEx
     (Rec : Rectangle; Thickness : Float; Color : RayColor) with
     Import => True, Convention => C, External_Name => "DrawRectangleLinesEx";

end Screen;

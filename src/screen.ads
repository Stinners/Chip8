with Interfaces.C; use Interfaces.C;

with Memory; use Memory;
with Raylib; use Raylib;

package Screen is

   ------------------ Types And Constants-------------------------

   Border_Width  : constant int := 5;
   Window_Height : constant int := N_Rows * 15 + 2 * Border_Width;
   Window_Width  : constant int := N_Columns * 15 + 2 * Border_Width;

   Grid_Color      : constant RayColor := (20, 20, 20, 255);
   Border_Color    : constant RayColor := (200, 200, 200, 255);
   RayWhite        : constant RayColor := (245, 245, 245, 255);
   Pixel_Off_Color : constant RayColor := (0, 0, 0, 255);
   Pixel_On_Color  : constant RayColor := (0, 228, 48, 255);

   ------------------ Sub-Programs ---------------------

   procedure DrawPixels (Display : Display_Buffer);

private

end Screen;

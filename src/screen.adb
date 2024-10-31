with Ada.Text_IO; use Ada.Text_IO;

package body Screen is

   ------------------ Types -------------------------

   procedure DrawPixels (Display : Display_Buffer) is

      Grid_Width   : constant Float := 0.5;
      Pixel_Width  : constant int   := Window_Width / N_Columns;
      Pixel_Height : constant int   := Window_Height / N_Rows;

      X, Y : int;

      Display_Byte  : Integer     := 1;
      Pixel_On_Mask : Memory.Byte := 1;
      Pixel_Color   : RayColor;
      Pixel_Number  : Integer     := 1;
   begin

      --  Draw the pixels themselves
      for Col in 0 .. (N_Rows - 1) loop
         Y := Col * Pixel_Height + Border_Width;

         for Row in 0 .. (N_Columns - 1) loop
            X := Row * Pixel_Width + Border_Width;

            if (Display (Display_Idx (Display_Byte)) and Pixel_On_Mask) = 0
            then
               Pixel_Color := Pixel_Off_Color;
            else
               Pixel_Color := Pixel_On_Color;
            end if;

            DrawRectangle
              (Pos_X  => X, Pos_Y => Y, Width => Pixel_Width,
               Height => Pixel_Height, Color => Pixel_Color);

            DrawRectangleLinesEx
              ((Float (X), Float (Y), Float (Pixel_Width),
                Float (Pixel_Height)),
               Grid_Width, Grid_Color);

            --  Increment the bitmask
            Pixel_On_Mask := Rotate_Left (Pixel_On_Mask, 1);

            --  When the bitmask = 1 then we're at the start of a new byte
            if Pixel_On_Mask = 1 then
               Display_Byte := Display_Byte + 1;
            end if;

            Pixel_Number := Pixel_Number + 1;
         end loop;
      end loop;

   end DrawPixels;

end Screen;

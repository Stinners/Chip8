package body Screen is

   ------------------ Types -------------------------

   procedure DrawPixels
     (Screen_Width, Screen_Height, N_Columns, N_Rows : int;
      Pixel_Color, Grid_Color                        : RayColor)
   is
      Grid_Width   : constant Float := 0.5;
      Pixel_Width  : constant int   := Screen_Width / N_Columns;
      Pixel_Height : constant int   := Screen_Height / N_Rows;

      X, Y : int;
   begin

      --  Draw the pixels themselves
      for Row in 0 .. (N_Columns - 1) loop
         X := Row * Pixel_Width;

         for Col in 0 .. (N_Rows - 1) loop
            Y := Col * Pixel_Height;

            DrawRectangle
              (Pos_X  => X, Pos_Y => Y, Width => Pixel_Width,
               Height => Pixel_Height, Color => Pixel_Color);

         end loop;
      end loop;

      --  Draw the grid over top
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

end Screen;

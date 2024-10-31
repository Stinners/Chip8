package body Raylib is

   function IsKeyDown (Key : Key_Code) return Boolean is
   begin
      return RaylibIsKeyDown (Key) /= 0;
   end IsKeyDown;

end Raylib;

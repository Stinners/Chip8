with Interfaces.C; use Interfaces.C;

package Raylib is

   --  Key definitions are found around line 600 of raylib.h
   type Key_Code is new int;

   Key_1 : constant Key_Code := 49;
   Key_2 : constant Key_Code := 50;
   Key_3 : constant Key_Code := 51;
   Key_4 : constant Key_Code := 52;
   Key_W : constant Key_Code := 87;
   Key_E : constant Key_Code := 69;
   Key_R : constant Key_Code := 82;
   Key_A : constant Key_Code := 65;
   Key_S : constant Key_Code := 83;
   Key_D : constant Key_Code := 68;
   Key_F : constant Key_Code := 70;
   Key_Z : constant Key_Code := 90;
   Key_X : constant Key_Code := 88;
   Key_C : constant Key_Code := 67;
   Key_V : constant Key_Code := 86;

   function IsKeyDown (Key : Key_Code) return Boolean;

private

   function RaylibIsKeyDown (Key : Key_Code) return int with
     Import => True, Convention => C, External_Name => "IsKeyDown";

end Raylib;

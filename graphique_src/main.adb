with P_Fenetre;		use P_Fenetre;
with Ada.Text_IO;		use Ada.Text_IO;
with P_PARAMETRE; 		use P_PARAMETRE;

procedure Main is

Begin

   Fenetre_Construct(Vue         => Get_Parametre_Vue,
                    Plateau_Jeu => False);
   --Gtk.Main.Main;

End Main;

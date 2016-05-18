with Cellules;
with Ada.Strings.Unbounded;

Package Joueurs is

   Type Genre is (Humain,Ordinateur_Facile,Ordinateur_Moyen,Ordinateur_Difficile);
   Type Joueur is private;

    package SU renames Ada.Strings.Unbounded;
	use type SU.Unbounded_String;


   Function Init_Joueur (N : SU.Unbounded_String; E: Genre ; S:Cellules.Symbole) return Joueur;
   Function Get_Nom (J : Joueur) return String;
   Procedure Set_Nom (J: in out Joueur ; N : in SU.Unbounded_String);
   Function Get_Genre (J : Joueur) return Genre;
   Procedure Set_Genre (J: in out Joueur ; G: in Genre);
   Function Get_Symbole (J : Joueur) return Cellules.Symbole;
   Procedure Set_Symbole (J: in out Joueur ; S : in Cellules.Symbole);


      private

   Type Joueur is RECORD
      Nom : SU.Unbounded_String;
      Espece : Genre;
      Signe : Cellules.Symbole;
   End Record;

End Joueurs;

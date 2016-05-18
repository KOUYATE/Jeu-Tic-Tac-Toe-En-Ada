Package Body Joueurs is

    use type SU.Unbounded_String;
   
   Function Init_Joueur (N : SU.Unbounded_String; E: Genre ; S:Cellules.Symbole) return Joueur is
      J:Joueur;
            Begin
      Set_Nom(J,N);
      Set_Genre(J,E);
      Set_Symbole(J,S);
      return J;
      end Init_Joueur;



   Function Get_Nom (J : Joueur) return String is
   Begin
      return SU.To_String(J.Nom);
   End Get_Nom;
   Procedure Set_Nom (J: in out Joueur ; N : in SU.Unbounded_String)is
   Begin
      J.Nom:=N;
   End Set_Nom;
   Function Get_Genre (J : Joueur) return Genre is
   Begin
      return J.Espece;
   End Get_Genre;

   Procedure Set_Genre (J: in out Joueur ; G: in Genre) is
   Begin
      J.Espece:=G;
   End Set_Genre;

   Function Get_Symbole (J : Joueur) return Cellules.Symbole is
   Begin
      return J.Signe;
   End Get_Symbole;

   Procedure Set_Symbole (J: in out Joueur ; S : in Cellules.Symbole) is
   Begin
      J.Signe:=S;
   End Set_Symbole;

End Joueurs;

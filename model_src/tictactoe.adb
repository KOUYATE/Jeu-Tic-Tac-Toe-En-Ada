With Ada.Text_IO;
With Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
With Cellules;
With Plateaux;
With Partie;
With Joueurs;
Procedure TicTacToe is
   J1,J2:Joueurs.Joueur;
   Un_Plateau: Plateaux.plateau;
   Use Joueurs;
Begin

   J1:=Joueurs.Init_Joueur(To_Unbounded_String("Jonathan"),Humain,'O');
   J2:=Joueurs.Init_Joueur(To_Unbounded_String ("Benjamin"),Ordinateur_Difficile,'X');

   Ada.Text_IO.Put_Line("START : " & Joueurs.Get_Nom(J1) & " vs " & Joueurs.Get_Nom(J2) );
   Partie.Jouer_Partie(J1,J2);
   Ada.Text_IO.Put_Line(" ");

End TicTacToe;

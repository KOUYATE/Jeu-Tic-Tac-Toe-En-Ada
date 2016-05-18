with Ada.Text_IO;
with Joueurs;
with Plateaux;
with Ada.Text_IO;
with Cellules;			use Cellules;
with Joueurs;			use Joueurs;
with Plateaux;			use Plateaux;

package Partie is

   Type T_Game Is Private;

   Joueur1 : Constant Positive := 1;
   Joueur2 : Constant Positive := 2;

   Procedure Coup_Aleatoire(Un_Plateau: in out Plateaux.plateau;
                            X         : out Plateaux.Colonne; Y: out Plateaux.Ligne);

   Procedure Saisir_Coup(Un_Plateau: in out Plateaux.Plateau;
                         X         : out Plateaux.Colonne; Y: out Plateaux.Ligne);

   Procedure Jouer_Coup(Grille : in out Plateaux.Plateau;Xo : in out Plateaux.Colonne;
                        Yo     : in out Plateaux.Ligne;  J: in Joueurs.Joueur; Fini: out Boolean);

   Procedure Jouer_Coup_Humain(Un_Plateau : in out Plateaux.Plateau;Xo : in Plateaux.Colonne;
                               Yo         : in Plateaux.Ligne; Un_Symbole: in out Cellules.Symbole);

   Procedure Jouer_Coup_IA_Difficile(Un_Plateau : in out Plateaux.Plateau;Xo : in out Plateaux.Colonne;
                                     Yo         : in out Plateaux.Ligne;Un_Symbole: in out Cellules.Symbole);

   Procedure Jouer_Coup_IA_Moyen(Un_Plateau : in out Plateaux.Plateau;Xo : out Plateaux.Colonne;
                                 Yo         : out Plateaux.Ligne;Un_Symbole: in out Cellules.Symbole);

   Procedure Jouer_Coup_IA_Facile(Un_Plateau : in out Plateaux.Plateau;Xo : out Plateaux.Colonne;
                                  Yo         : out Plateaux.Ligne;Un_Symbole: in out Cellules.Symbole);

   Procedure Jouer_Partie(J1: in Joueurs.Joueur; J2: in Joueurs.Joueur);

   procedure Afficher(Un_Plateau : Plateaux.Plateau);

   procedure Organise_Game(Jeu :in out T_Game);

   Procedure Set_Joueur(Game:in out T_Game;J:joueur;Num:Positive);

   Procedure Set_Grille_Jeu(Game:in out T_Game;Plateau_Jeu:Plateau);

   Procedure Set_Current_Joueur(Game:in out T_Game;Current_Joueur:Joueur);

   Procedure Set_Score_Joueur(Game:in out T_Game;NUm:Positive;Score:Natural);

   Function Get_Joueur(Game:T_Game;Num : Positive) Return Joueurs.Joueur;

   Function Get_Grille_Jeu(Game:T_Game) Return Plateaux.Plateau;

   Function Get_Score(Game : T_Game;Num : Positive) return Natural;

   Function Get_Current_Joueur(Game : T_Game) Return Joueur;

   Function Get_Couleur_Pion(Game : T_Game) return String;

   Procedure Set_Couleur_Pion(Game : in out T_Game;Num : Natural;Couleur: String);

   Function Construct_Game(Joueur1,Joueur2:Joueur;Grille_jeu:Plateau;
                           Couleur1,Couleur2 : String)  return T_Game;

   Procedure Jouer_Case(Game    : in out T_Game;
                        Colonne : in out Plateaux.Colonne;
                        Ligne : in out Plateaux.Ligne; Resultat: out Positive);

   Procedure Set_Partie_Finie(Game : in out T_Game;Partie_Finie : in Boolean);

   Function get_Symbole(Game : T_Game;Colonne:Plateaux.Colonne;Ligne : Plateaux.Ligne)
                        return Cellules.Symbole;


   Function Get_Partie_Finie(Game : T_Game) return Boolean;

private

    Type T_Game Is Record
      Grille_Jeu : Plateau;
      Joueur1  : Joueur;
      Joueur2  : Joueur;
      Current_Joueur : Joueur;
      Score_joueur1       : Natural;
      Score_Joueur2       : Natural;
      Match_nul           : Natural;
      Couleur_Pion1       : String(1..7);
      Couleur_Pion2       : String(1..7);
      Partie_Finie : Boolean;
   End Record;

   Not_Joueur : Exception;

end Partie;

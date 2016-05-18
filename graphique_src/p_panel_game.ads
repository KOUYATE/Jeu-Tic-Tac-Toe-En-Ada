With Ada.Containers.Vectors;
With P_PARAMETRE;		Use P_PARAMETRE;
With Gtk.Button;		Use Gtk.Button;
With Gdk.Color;		Use Gdk.Color;
With Gtkada.C;		Use Gtkada.C;
With Gtk.Label;		Use Gtk.Label;
With Gtk.Box;			Use Gtk.Box;
with Plateaux;			use Plateaux;
with Partie; 			use Partie;
with Joueurs; 			use Joueurs;
with Cellules; 			use Cellules;
with Gtk.Image; 		use Gtk.Image;

Package P_Panel_Game Is

   Type Chaine Is New String(1..7);

   Package ArrayButton Is New Ada.Containers.Vectors(Index_Type   => Positive,
                                                     Element_Type => Gtk_Button);

   Package ArrayColor Is New Ada.Containers.Vectors(Index_Type   => Positive,
                                                    Element_Type => Chaine);

   Type Liste_Button is New ArrayButton.Vector With Null Record;
   --Liste de bouton de taille variable et infini
   Type Liste_Couleur Is New ArrayColor.Vector With Null Record;
   --Liste de couleur de taille variable et infini

   Type T_Panel_Game Is Record
      Grille : Liste_Button;
      EcranNom ,
      EcranSymbole ,
      Score_Joueur1,
      Score_Joueur2,
      score_null   : Gtk_Label;
      Container    : Gtk_Vbox;
      Replay       : Gtk_Button;
      Historique   : Liste_Button;

   End Record;
   --T_Panel_Game est la vue qui répresente un plateau de jeu .
   --Elle est constitué d'une Liste de bouton qui répresente les cases du jeu,
   --de 5 Ecrans(Gtk_Label) pour afficher le nom et le symbole du joueur courant et le
   --score des deux joueurs;
   --D'un conteneur de type Gtk_Vbox; d'un bouton replay et d'une liste d'historique des
   --boutons clickés(joués) qui répresentent des cases de la grille de jeu.

   Procedure Construct(Parametre : T_Parametre) ;
   --Constructeur T_Panel_Game la grille de jeu.
   --Prend en paramètre un T_Paramètre qui est composé de l'ensemble des paramètrages
   --d'une partie de jeu.

   Procedure Set_Grille(Grille : in Liste_Button);
   --Setter de Grille de jeu

   Procedure Set_Container(Container : Gtk_Vbox);
   --Setter de Container

   Procedure Set_EcranNom(Ecran : Gtk_Label);
   --Setter de EcranNom

   Function Get_Grille Return Liste_Button;
   --Retourne la liste des boutons de la grille de jeu.

   Function Get_Container Return Gtk_Vbox;
   --Retourne le conteneur principale de la grille de jeu.

    Procedure Rejouer_Partie(Event : access gtk_Button_record'Class);
   --Relance une nouvel partie avec les anciens paramètres.

   Function Get_EcranNom Return Gtk_Label;
   --Retourne l'ecran d'affichage (Gtk_Label) des noms des joueurs.

   Function Get_Game Return Partie.T_Game;
   --Retourne le jeu.

   Procedure Mise_A_Jour_Ecran;
   --Met à jour l'ecran d'affichage des noms et symboles des joueurs.

   Procedure Mise_A_Jour_Score;
   --Met à jour l'ecran d'affichage des scores des joueurs .

   Procedure Set_Game(Game: T_Game);
   --Change le jeu courant au jeu passer en paramètre.

   Procedure Init_Game(Joueur1,Joueur2:Joueur;Grille_jeu:Plateau;
                       Couleur1,Couleur2 : String);
   --Initialise le jeu en créant un objet Partie.T_game qui represente un jeu de morpion.

   Procedure Joueur_Suivant;

private
   Panel_Game : T_Panel_Game;
   Game       : Partie.T_Game;
   Procedure Jouer_Game(Event : access gtk_Button_record'Class:=null);
   Procedure Replay(Event : access gtk_Button_record'Class);
   procedure Afficher_Vanquaire(choix : Positive;symb:String);
   procedure Jouer_Coup_ordi;
   cpt : Positive := 1;
   --compteur permettant de faire un replay
   --on Parcours l'historique et on affiche chaque fois la case jouée , puis on increment cpt
   --jusqu'à atteindre la fin de la partie et cpt est alors réinitialisé à 1

End P_Panel_Game;

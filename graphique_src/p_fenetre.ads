with Ada.Finalization;		use Ada.Finalization;
with Gtk.Window;			use gtk.Window;
with Gtk.Main;				use GTK.Main;
with Gtk.Button;			use Gtk.Button;
with Gtk.Menu_Bar;			use Gtk.Menu_Bar;
with gtk.Menu_Item;			use Gtk.Menu_Item;
with Gtk.Menu;			use Gtk.Menu;
with Gtk.Widget;			use Gtk.Widget;
with Gtk.Box;				use Gtk.Box;
with Gtk.Handlers;

Package P_Fenetre IS

   Fichier_Manquant : Exception;

   Procedure Fenetre_Construct(Vue : Gtk_Box;Plateau_Jeu : boolean := false) ;
   --Construit et Affiche la fenetre Principale du jeu.
   --Prend en paramètre Une vue de type Gtk_Box constituant la vue de base de la
   --fenetre et un booléan Plateau_jeu indiquant si la vue correspond à un plateau de jeu
   --ou une vue de paramétrage

   Procedure Set_Container(Container : Gtk_Widget_Record'Class);
   --Change le conteneur de la Fenetre principale au Conteneur passer en paramètre

   Function Get_Win return Gtk_Window;
   --Retourne la Fenetre principale
   Function Get_Menu_Bar return Gtk_Menu_Bar;
   --Retourne la barre de menu de la fenetre principale

   Function Get_Container return Gtk_Vbox;
   --Retourne le conteneur de la fenetre principale

   Hauteur : Constant Integer := 400;
   --Hauteur par défaut de la fenetre principale
   Largeur : Constant Integer := 700;
   --Largeur par défaut de la fenetre principale

private

   Type T_Fenetre Is New CONTROLLED  With Record
      WIN : Gtk_Window;
      Menu_Bar : Gtk_Menu_Bar;
      Container : Gtk_Vbox;
   End Record;
   --Le Type T_Fenetre represente la fenetre principale du jeu.
   --il est constitué d'une fenetre window , d'une barre de menu et d'un conteneur
   --principal

   Fenetre : T_Fenetre;
   --Variable de Classe Privée permettant la manipulation d'un Type T_Fenetre
   --Elle est Initialisé lors de l'appel à la Fonction Construct_Fenetre

End P_Fenetre;



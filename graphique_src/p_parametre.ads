with Gtk.Spin_Button;		use Gtk.Spin_Button;
with ada.Finalization;		use Ada.Finalization;
with Glib;					use Glib;
with gtk.Button;			use gtk.Button;
with Gtk.Handlers;			use Gtk.Handlers;
with Gtk.GEntry;			use Gtk.GEntry;
with ada.Strings.Unbounded;	use Ada.Strings.Unbounded;
with Gtk.Box;				use Gtk.Box;

PACKAGE P_PARAMETRE IS

   Package P_Events_Button Is New Gtk.Handlers.Callback(Gtk_Button_Record);

   TailleMax : Constant Integer := 2;

   Button_Type_Joueur : Constant integer := 1;
   Button_Niveau_Joueur : Constant integer := 2;
   Button_Symbole_Joueur : Constant Integer := 3;
   Button_Couleur_Symbole : Constant Integer := 4;

   Humain                 : Constant String := "HUMAIN";
   Ordinateur : Constant String := "ORDINATEUR";

   Type T_Tab_Button Is Array(1..TailleMax) of Gtk_Button;

   Type T_Tab_String Is Array(1..TailleMax) of Gtk_GEntry;

    Type T_Parametre Is  Record
      NomJoueurs : T_Tab_String;
      TypeJoueur : T_Tab_Button;
      SymboleJoueur : T_Tab_Button;
      CoulueurSymbole : T_Tab_Button;
      NiveauJoueur : T_Tab_Button;
   END RECORD;

   Procedure Construct_Parametre;
   Function Get_Parametre_Vue return Gtk_Box;
   Function Get_Parametre return T_Parametre;
   Function Get_Button(Nom_Button : String;Type_Button : integer)
                       return Gtk_Button;

private
   Parametre : T_Parametre;

END P_PARAMETRE;

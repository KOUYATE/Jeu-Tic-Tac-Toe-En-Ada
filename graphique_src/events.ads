with Gtk.Window; 		use Gtk.Window;
with Gtk.Widget; 		use Gtk.Widget;
with Gtk; 			use Gtk;
with Gtk.Button; 		use Gtk.Button;
with Gtk.Handlers;
with Gtk.Spin_Button;	use gtk.Spin_Button;
with Gtk.Color_Selection;	use Gtk.Color_Selection;
with Gtk.Color_Selection_Dialog;	use Gtk.Color_Selection_Dialog;
with Gtk.GEntry;		Use Gtk.GEntry;

Package Events Is

   newline      : constant character := character'val(10) ;
   Procedure Close_Fenetre(Event : access Gtk_Window_Record'Class);
   --Ferme la Fenetre principale du jeu avec tous ses composants

   Procedure Fermer(Event : access Gtk_Widget_Record'Class);
   --Détruit un widget lors d'un évènement (click,survol etc..)

   Procedure Afficher_Aide(Event : access Gtk_Widget_Record'Class);
   --Affiche l'aide du jeu en ouvrant une fenetre window

   Procedure Afficher_Apropos(Event : access Gtk_Widget_Record'Class);
   --Affiche la fiche d'identité(A propos) de l'application en ouvrant une fenetre window

   Procedure Choix_Type_Joueur(Event : access Gtk_Button_Record'Class);
   --Affihe une boite de dialogue permettant au joueur de choisir
   --un type de joueur (Ordinateur ou humain)

   Procedure Choix_Niveau_Ordi(Event : access Gtk_Button_Record'Class);
   --Affiche une boite de dialogue permettant de choisir un niveau d'intelligence
   --artificielle pour l'ordinateur(Facile,Moyen,Expert)

   Procedure Choix_Symbole(Event : access Gtk_Button_Record'Class);
   --Affiche une boite de dialogue permettant au joueur de choisir un symbole

   Procedure Choix_Couleur_Symbole(Event : access Gtk_Button_Record'Class);
   --Affiche une boite de dialogue permettant au joueur de choisir la couleur des pions

   Procedure Lancer_Partie(Event : access Gtk_Button_Record'Class);
   --Vérifie les paramètres du jeu et lance une partie de jeu lorsque les paramètres
   --sont exactes ou sinon ouvre une boite de dialogue avec le message d'erreur
   --adéquat

   Procedure Quittez_partie(Event : access Gtk_Widget_Record'Class);
   --Ferme l'application après une confirmation du joueur

   Procedure Set_Symbole(Event   : access Gtk_Button_Record'Class);
   --Change le label du buton clické par le symbole choisi

   Procedure Set_Type(Event   : access Gtk_Button_Record'Class);
   --Change le label du buton clické par le type choisi (Humain ou Ordinateur)

   Procedure Set_Niveau(Event   : access Gtk_Button_Record'Class);
   --Change le niveau d'intelligence artificielle par le niveau choisi

   Procedure Nouvel_Partie(Event : access Gtk_Widget_Record'Class);
   --Relance une nouvel partie de jeu, les anciens paramètres sont réinitialiser
   --Affiche la fenetre de paramétrage pour une partie de jeu


   Package P_Events Is New gtk.Handlers.Callback(Gtk_Window_Record);
    --Packages permettant la gestion des evenements sur les Fenetres window
   Package P_Events_Widget Is New gtk.Handlers.Callback(Gtk_Widget_Record);
    --Packages permettant la gestion des evenements sur les widgets
   Package P_Events_Button Is New Gtk.Handlers.Callback(Gtk_Button_Record);
   --Packages permettant la gestion des evenements sur les boutons

Private

   Type T_Tab_GEntry Is Array(1..10) of Gtk_GEntry;
   Type T_Tab_Button Is Array(1..10) of Gtk_Button;

   Type T_Choix_Parametre Is Record
      Win_Choix_Symbole : Gtk_Window;
      Win_Choix_type    : Gtk_Window;
      Win_Choix_Niveau  : Gtk_Window;
      Win_Choix_Couleur : Gtk_Color_Selection_Dialog;
   End Record;
   --Le Type T_Choix_Parametre permet la gestion des differents choix(Choix du type de joueur,
   --niveau si c'est l'ordinateur,symbole et couleur de son pion) lors du lancement d'une partie
   --d'une partie de jeu afin de faciliter le paramètrage.Il dispose d'un constructeur pour chacune
   --de ses attributs qui sont des widgets window

   Fenetre_Choix : T_Choix_Parametre;
   --Variable de classe permettant de manipuler le type Choix_Parametre

   Procedure Construct_Choix_Symbole(NomButton : String) ;
   --Affiche une Fenetre window permettant au joueur de choisir un symbole(Pion).
   --Initalise l'attribut Win_Choix_Symbole de l'objet Fenetre_Choix
   --Prend en paramètre le nom du button clické pour pouvoir affecté à ce bouton le
   --le symbole choisi

   Procedure Construct_Choix_Type(NomButton : String);
   --Affiche une Fenetre window permettant au joueur de paramètré son Genre(Humain
     --ou Ordinateur).
   --Initalise l'attribut Win_Choix_Type de l'objet Fenetre_Choix
   --Prend en paramètre le nom du button clické pour pouvoir affecté à ce bouton le
   --le type Choisi par l'utilisateur

   Procedure Construct_Choix_niveau(NomButton : String);
   --Affiche une Fenetre window permettant au joueur de paramétrer le niveau d'intelligence
   --artificielle de l'ordinateur(FACILE,MOYEN,EXPERT).
   --Initalise l'attribut Win_Choix_Niveau l'objet Fenetre_Choix
   --Prend en paramètre le nom du button clické pour pouvoir affecté à ce bouton le
   --le niveau Choisi par le joueur

   Procedure Construct_Choix_Couleur(NomButton : String);
   --Affiche une Fenetre window permettant au joueur de choisir la couleur de son
   --pion ou celui de l'ordinateur.
   --Initalise l'attribut Win_Choix_Couleur de l'objet Fenetre_Choix
   --Prend en paramètre le nom du button clické pour pouvoir affecté à ce bouton le
   --la couleur choisie par le joueur.

   Procedure Close_Choix_Parametre(Fenetre : access Gtk_Window_Record'Class);
   --Ferme la fenetre active de l'Objet Fenetre_Choix et l'initialise à null

   Function Est_Dans(Entrie : Gtk_Gentry;Tableau : T_Tab_GEntry) return Boolean;
   --Retourne True si un Gtk_Entry dans le tableau a le même Text que le Gtk_Gentry passer
   --en paramètre.

   Function Est_Dans(Buttons : Gtk_Button;Tableau : T_Tab_Button) return Boolean;
   --Retourne True si un bouton dans le tableau a le même nom que le bouton passer en
   --paramètre.

   Function Verif_parametre(Nbjoueur:integer) return boolean ;
   --Retourne True si le jeu est correctement paramétrer False sinon
   --Prend en paramètre le nombre de joueur Max du jeu.

End Events;


With Gtk.Message_Dialog; 	use Gtk.Message_Dialog;
with Gtk.Frame; 			use Gtk.Frame;
with Gtk.Label; 			use Gtk.Label;
with Gtk.Dialog; 			use Gtk.Dialog;
with P_Fenetre; 			use P_Fenetre;
with Gtk.Box; 				use Gtk.Box;
with Gtk.Style;				use Gtk.Style;
with Gtk.Enums; 			use Gtk.Enums;
with Gtk.About_Dialog; 		use Gtk.About_Dialog;
with Gdk.Color; 			use Gdk.Color;
with GNAT.Strings;			use GNAT.Strings;
with Glib.Convert;			use Glib.Convert;
with Ada.Text_IO;			use Ada.Text_IO;
with P_PARAMETRE;			use P_PARAMETRE;
with Gtk.Main;
with Gtk.Table; 			use Gtk.Table;
with Glib; 				use Glib;
with Ada.Integer_Text_IO;		use ada.Integer_Text_IO;
with Gdk.Event;			use Gdk.Event;
with Gtk.Print_Operation; 	use Gtk.Print_Operation;
with P_Panel_Game;			use P_Panel_Game;
with Cellules;				use Cellules;
with Ada.Strings.Unbounded; 	use Ada.Strings.Unbounded;
with Partie;				use Partie;
with Joueurs;				use Joueurs;
with Plateaux; 				use Plateaux;

package body Events is

   Use P_Events;
   Use P_Events_Widget;
   Use P_Events_Button;
   -------------------
   -- Close_Fenetre --
   -------------------

   procedure Close_Fenetre (Event : access Gtk_Window_Record'Class) is
   begin
      P_Fenetre.Get_Win.Destroy;
      gtk.Main.Gtk_Exit(0);
   end Close_Fenetre;

   ------------
   -- Fermer --
   ------------

   procedure Fermer (Event : access Gtk_Widget_Record'Class) is
   begin
      Event.Destroy;
   end Fermer;

   -------------------
   -- Afficher_Aide --
   -------------------

   procedure Afficher_Aide (Event : access Gtk_Widget_Record'Class) is
   Pragma Unreferenced(Event);
      Fenetre_Aide : Gtk_Window;
      BordureFrame : Gtk_Frame;
      Largeur      : Constant Positive := 500;
      Longueur     : Constant Positive := 690;
      LabelText    : Gtk_Label;
      Contenair    : Gtk_Vbox;
      font : Gtk_Style;
      Aide         : Constant String :=
        Locale_To_UTF8(
                       "<span size='x-large' face='verdana' foreground='#73b5ff'><b>Règles du jeu </b></span>"
                       & newline & newline &
                       "<span size='large' face='verdana' foreground='#39b500'><b>Présentation</b></span>"
                       & newline &
                       "<span face='verdana'>Le jeu de morpion(Tic-Tac-Toe) est un jeu de réflexion se jouant à deux"
                       &" ou "& newline & "plusieurs joueurs, au tour par tour, dont le but est de réaliser un alignement"&
                       newline & "de plusieurs symboles sur une grille .</span>" & newline & newline &
                       "<span face='verdana' foreground='#39b500' size='large' weight='bold'>Règles</span>"
                       & newline & "<span face='verdana'>"&
                       "        <b>>></b> Au début de chaque partie un ordre est établie par défaut(Modifiable)."
                       & newline & newline &
                       "        <b>>></b> Ensuite chaque joueur doit sélectionner une case libre.L'ordre des"
                       & newline & "              joueurs est celui établie avant chaque partie." & newline & newline &
                        "        <b>>></b> Le joueur qui réussit à aligner au moins 3 symboles adjacents sur"& newline &
                                                      "              le plateau remporte la partie . Un match null pas de vainqueur ne " & newline &
        					      "              remporte  aucun point.</span>"      );


   Begin
      Gtk_New(Fenetre_Aide);
      Gtk_New(BordureFrame,"JEU DE MORPION (TIC TAE TOE)");
      Gtk_New_Vbox(Contenair,False,0);
      Gtk_New(LabelText);
      Gtk_new(font);

      --
      BordureFrame.Add(Contenair);
      BordureFrame.Set_Shadow_Type(The_Type => Shadow_in);
      BordureFrame.Modify_Bg(State_Type => State_Normal,
                          Color      => Parse("#01B0F0"));
      Fenetre_Aide.Add(BordureFrame);
      LabelText.Set_Markup(Aide);
      LabelText.Set_Justify(Justify_Left);
      Contenair.add(LabelText);

      Fenetre_Aide.Modify_Bg(State_Type => State_Normal,
                          Color      => Parse("white"));
      Fenetre_Aide.Set_Destroy_With_Parent(Setting => true);
      Fenetre_Aide.Set_Position(Win_Pos_Center);
      Fenetre_Aide.Set_Size_Request(600,350);
      Fenetre_Aide.Set_Title("Règles du jeu (TIC TAE TOE)");
      Fenetre_Aide.Set_Resizable(False);
      Fenetre_Aide.Show_All;

   end Afficher_Aide;

   ----------------------
   -- Afficher_Apropos --
   ----------------------

  Procedure Afficher_Apropos(Event : access Gtk_Widget_Record'Class) Is
      About_Dialog : Gtk_About_Dialog;
      Liste_Authors : Gnat.Strings.String_List(1..4);
      Button_Close : Gtk_Button;
   Begin

      Gtk_new(About_Dialog);
      About_Dialog.Modify_Bg(State_normal,Parse("white"));
      Liste_Authors(1) := new String'("KOUYATE Sory");
      Liste_Authors(2) := new String'("GHEDEBA Enzo");
      Liste_Authors(3) := new String'("SEDAN Benjamin");
      Liste_Authors(4) := new String'("RODRIGUES Jonathan");

      About_Dialog.Set_Title("A propos du TIC TAC TOE (MORPION)");
      About_Dialog.Set_Program_Name("Jeu De Morpion(TIC TAE TOE)©");
      About_Dialog.Set_Authors(Liste_Authors);
      About_Dialog.Set_Website("http://www.univ-orleans.fr");
      About_Dialog.Set_Copyright("Application réaliser dans le cadre de la licence 3 (MIAGE) de " & newline &
                                 "l'Université d'Orléans©");
      About_Dialog.Set_License(License => "Licence BSD." & newline &
                               "Ce programme est fourni sans aucune GARANTIE." & newline &
                               "Pour plus de details visiter : http://www.opensource.org/licenses/bsd-license.php");
      Button_Close:=Gtk_button(About_Dialog.Get_Action_Area.Get_Child(Num => 0));
      --Connect(Button_Close,"clicked",Fermer'Access);
      About_Dialog.Modify_Bg(State_Type => State_normal,
                             Color      => Parse("white"));
      About_Dialog.Show_All;
      if About_Dialog.Run = Gtk_Response_Close
      then About_Dialog.Destroy;
      else
         About_Dialog.Destroy;
      end if;

   End Afficher_Apropos;

   -----------------------
   -- Choix_Type_Joueur --
   -----------------------

   Procedure Choix_Type_Joueur(Event : access Gtk_Button_Record'Class) IS
   Begin
      if (Fenetre_Choix.Win_Choix_type = null) or else
        (not Fenetre_Choix.Win_Choix_type.Is_Active)
      then  Construct_Choix_Type(Event.Get_Name);
      end if;

   End Choix_Type_Joueur;

   -----------------------
   -- Choix_Niveau_Ordi --
   -----------------------

   Procedure Choix_Niveau_Ordi(Event : access Gtk_Button_Record'Class) Is
   Begin
      if (Fenetre_Choix.Win_Choix_Niveau =null) or else
        (not Fenetre_Choix.Win_Choix_Niveau.Is_Active)
        then Construct_Choix_niveau(Event.Get_Name);
      end if;
   End Choix_Niveau_Ordi;
   -------------------
   -- Choix_Symbole --
   -------------------

  Procedure Choix_Symbole(Event : access Gtk_Button_Record'Class) Is

   Begin
      if Fenetre_Choix.Win_Choix_Symbole = null or else
        (not Fenetre_Choix.Win_Choix_Symbole.Is_Active)
      then Construct_Choix_Symbole(Event.Get_Name);
      end if;
   End Choix_Symbole;

   ---------------------------
   -- Choix_Couleur_Symbole --
   ---------------------------

   Procedure Choix_Couleur_Symbole(Event : access Gtk_Button_Record'Class) Is
   Begin
      Construct_Choix_Couleur(Event.Get_Name);
   End Choix_Couleur_Symbole;

   -------------------
   -- Lancer_Partie --
   -------------------

  Procedure Lancer_Partie(Event : access Gtk_Button_Record'Class) Is
      Dialog_message : Gtk_Message_Dialog;
      nom_joueur1,
      nom_joueur2           : Unbounded_String;
      Genre_joueur1,
      Genre_joueur2 : Genre;
      Symbole_joueur1,
      Symbole_joueur2       : Symbole;
      Joueur1,
      Joueur2               : Joueur;
      Grille_jeu            : Plateau;
      niveau1               : String := Get_Parametre.NiveauJoueur(1).Get_Label;
      niveau2               : String := Get_Parametre.NiveauJoueur(2).Get_Label;
      Couleur1,Couleur2 : String(1..7);
      Name_Color1           : String := Get_Parametre.CoulueurSymbole(1).Get_Name;
      Name_Color2           : String := Get_Parametre.CoulueurSymbole(2).Get_Name;

   Begin

      if not Verif_parametre(TailleMax)
        then Gtk_New(Dialog_message,Get_Win,Modal,Message_Error,Buttons_OK,
                 "Paramétrage incorrecte. Veuillez vérifier que tous les champs" & newline &
                     "sont bien renseignés et qu'il n'y a pas pas plusieurs symboles ou noms identique .");
         Dialog_message.Modify_Bg(State_normal,Parse("white"));
         Dialog_message.Show_All;
         if Dialog_message.Run = Gtk_Response_Accept
         then Dialog_message.Destroy;
         else Dialog_message.Destroy;
         end if;
      else
         --création des joueurs et du plateau de jeu

         nom_joueur1 := To_Unbounded_String(Get_Parametre.NomJoueurs(1).Get_Text);
         nom_joueur2 := To_Unbounded_String(Get_Parametre.NomJoueurs(2).Get_Text);
         if not Get_Parametre.NiveauJoueur(1).Is_Sensitive
         then Genre_joueur1 := Joueurs.Humain;
         else
            if Get_Parametre.NiveauJoueur(1).Get_Label = "FACILE"
            then Genre_joueur1 := Joueurs.Ordinateur_Facile;
            elsif Get_Parametre.NiveauJoueur(1).Get_Label = "MOYEN"
            then Genre_joueur1 := Joueurs.Ordinateur_Moyen;
            else
               Genre_joueur1 := Joueurs.Ordinateur_Difficile;
            end if;
         end if;

         if not Get_Parametre.NiveauJoueur(2).Is_Sensitive
         then Genre_joueur2 := Joueurs.Humain;
         else
            if Get_Parametre.NiveauJoueur(2).Get_Label = "FACILE"
            then Genre_joueur2 := Joueurs.Ordinateur_Facile;
            elsif Get_Parametre.NiveauJoueur(2).Get_Label = "MOYEN"
            then Genre_joueur2 := joueurs.Ordinateur_Moyen;
            else
               Genre_joueur2 := Joueurs.Ordinateur_Difficile;
            end if;
         end if;

         if Get_Parametre.SymboleJoueur(1).Get_Label ="O"
         then Symbole_joueur1 := Symbole'first;
            Symbole_joueur2 := Symbole'Last;
         else
            Symbole_joueur1 := Symbole'Last;
            Symbole_joueur2 := Symbole'First;
         end if;

         if Name_Color1'Length = 3
         then Couleur1 := "#EFEFEF"; --couleur gris
         else
            Couleur1 := Name_Color1;
         end if;

         if Name_Color2'Length = 3
         then Couleur2 := "#EFEFEF"; --couleur gris
         else
            Couleur2 := Name_Color2;
         end if;

         joueur1 := Joueurs.Init_Joueur(N => nom_joueur1,
                                        E => Genre_joueur1,
                                        S => Symbole_joueur1);
         joueur2 := Joueurs.Init_Joueur(N => nom_joueur2,
                                        E => Genre_joueur2,
                                        S => Symbole_joueur2);


         -------------------------------------
         ------Lancement du jeu-----
         -------------------------------------
         P_Panel_Game.Init_Game(Joueur1    => Joueur1,
                                Joueur2    => joueur2,
                                Grille_jeu => Grille_jeu,
                                Couleur1   => Couleur1,
                                Couleur2   => Couleur2);

         Get_Win.Hide_All;
         P_Fenetre.Fenetre_Construct(Vue         => P_Panel_Game.Get_Container,
                                     Plateau_Jeu => True);
      end If;
     -- Exception
        -- when others => null;
   End Lancer_Partie;

   --------------------
   -- Quittez_partie --
   --------------------

  Procedure Quittez_partie(Event : access Gtk_widget_Record'Class) Is
      Confirm_Dialog : Gtk_Message_Dialog;
   Begin

      Gtk_new(Confirm_Dialog,Get_Win,Modal,Message_Question,Buttons_Yes_No,
              "Voulez vous vraiment Quittez le jeu ? ");
      Confirm_Dialog.Modify_Bg(State_Type => State_normal,
                               Color      => Parse("white"));
      Confirm_Dialog.Set_Title(" ? ");
      Confirm_Dialog.Set_Resizable(false);
      if Confirm_Dialog.Run = Gtk_Response_Yes
      then Confirm_Dialog.Destroy;
         Gtk.main.Gtk_Exit(Error_Code => 0);
      else
         Confirm_Dialog.Destroy;
      End if;

   End Quittez_Partie;

   -----------------
   -- Set_Symbole --
   -----------------

  Procedure Set_Symbole(Event   : access Gtk_Button_Record'Class) Is

   Begin

      Get_Button(Nom_Button  => Event.Get_Name,
                 Type_Button => Button_Symbole_Joueur).Set_Label(Event.Get_Label);
      Fenetre_Choix.Win_Choix_Symbole.Destroy;
      Fenetre_Choix.Win_Choix_Symbole := null;
   End Set_Symbole;


   --------------
   -- Set_Type --
   --------------
   Procedure Set_Type(Event   : access Gtk_Button_Record'Class) Is
   Begin
      If Event.Get_Label = "FERMER"
      then Fenetre_Choix.Win_Choix_Type.Destroy;
         Fenetre_Choix.Win_Choix_type:=null;
      else
         Get_Button(Nom_Button  => Event.Get_Name,
                    Type_Button => Button_Type_Joueur). Set_Label(Event.Get_Label);
         if Event.Get_Label = "ORDINATEUR"
         then Get_Button(Nom_Button  => Event.Get_Name,
                         Type_Button => Button_Niveau_Joueur).Set_Sensitive(True);
         else Get_Button(Nom_Button  => Event.Get_Name,
                         Type_Button => Button_Niveau_Joueur).Set_Label("Niveau");
            Get_Button(Nom_Button  => Event.Get_Name,
                       Type_Button => Button_Niveau_Joueur).Set_Sensitive(False);
         end if;
         Fenetre_Choix.Win_Choix_Type.Destroy;
         Fenetre_Choix.Win_Choix_type:=null;
      End If;

   End Set_Type;

   ----------------
   -- Set_Niveau --
   ----------------

    Procedure Set_Niveau(Event   : access Gtk_Button_Record'Class) Is
   Begin
      if Event.Get_Label = "FERMER"
      then Fenetre_Choix.Win_Choix_Niveau.Destroy;
           Fenetre_Choix.Win_Choix_Niveau:=null;
      else
          Get_Button(Nom_Button  => Event.Get_Name,
                    Type_Button => Button_Niveau_Joueur). Set_Label(Event.Get_Label);
         Fenetre_Choix.Win_Choix_Niveau.Destroy;
         Fenetre_Choix.Win_Choix_Niveau:=null;
      end if;

   End Set_Niveau;

   -------------------
   -- Nouvel_Partie --
   -------------------

 Procedure Nouvel_Partie(Event : access Gtk_Widget_Record'Class) Is
    Confirm_Dialog : Gtk_Message_Dialog;
   Begin
      Gtk_new(Confirm_Dialog,Get_Win,Modal,Message_Question,Buttons_Yes_No,
              "Voulez vous Lancer une nouvelle Partie ?");
      Confirm_Dialog.Modify_Bg(State_Type => State_normal,
                               Color      => Parse("white"));
      Confirm_Dialog.Set_Title(" ? ");
      Confirm_Dialog.Set_Resizable(false);
      Confirm_Dialog.Show_All;
      if Confirm_Dialog.Run = Gtk_Response_Yes
      then Confirm_Dialog.Destroy;
         Get_Win.Hide_All ;
         Fenetre_Construct(Vue         => Get_Parametre_Vue,
                           Plateau_Jeu => False );
      else
         Confirm_Dialog.Destroy;
      End if;
   End Nouvel_Partie;

   -----------------------------
   -- Construct_Choix_Symbole --
   -----------------------------

   Procedure Construct_Choix_Symbole(NomButton:String) Is
      Label_Text   : Gtk_Label;
      Container          : Gtk_Vbox;
      Container_label : Gtk_Hbox;
      Symbole : Gtk_Table;
      TMP                : Gtk_Button;
      abscisse,ordonnee  :Guint := 0;
      cpt : Integer := 1;
   Begin

      Gtk_New(Label_Text);
      Label_Text.Set_Markup("<span size='large' face='verdana' ><b>Veuillez Choisir Votre "
                            & "Symbole</b></span>");
      Gtk_New(Fenetre_Choix.Win_Choix_Symbole,Window_Toplevel);
      Connect(Fenetre_Choix.Win_Choix_Symbole,"destroy",Close_Choix_Parametre'Access);
      Gtk_New_Vbox(Box         => Container,Homogeneous => False,
                   Spacing     => 3);
      Gtk_New_Hbox(Container_label,Homogeneous => true,Spacing => 3);
      Container_label.Add(Label_Text);
      Gtk_New(Symbole,1,2,True);
      Fenetre_Choix.Win_Choix_Symbole.Add(Container);
      Container.Pack_Start(Container_label);
      Container.Pack_Start(Symbole);
      Fenetre_Choix.Win_Choix_Symbole.Set_Title("Choix du Pion (Symbole)");
      --Fenetre_Choix.Win_Choix_Symbole.Set_Size_Request(400,400);


      Gtk_New(TMP,"O");
      Connect(TMP,"clicked",Set_Symbole'Access);
      TMP.Set_Name(NomButton);
      Symbole.Attach(TMP,0,1,0,1);

      Gtk_New(TMP,"X");
      Connect(TMP,"clicked",Set_Symbole'Access);
      TMP.Set_Name(NomButton);
      Symbole.Attach(TMP,1,2,0,1);

      Fenetre_Choix.Win_Choix_Symbole.Set_Parent(Get_Win);
      Fenetre_Choix.Win_Choix_Symbole.Set_Modal(True);
      --Fenetre_Choix.Win_Choix_Symbole.Set_Flags(1);
      Fenetre_Choix.Win_Choix_Symbole.Set_Resizable(false);
      Fenetre_Choix.Win_Choix_Symbole.Modify_Bg(State_Type => State_normal,
                                                Color      => Parse("white"));
      Fenetre_Choix.Win_Choix_Symbole.Show_All;

   End Construct_Choix_Symbole;

   --------------------------
   -- Construct_Choix_Type --
   --------------------------

   Procedure Construct_Choix_Type(NomButton : String) Is
      Label_Text  : Gtk_Label;
      Container   : Gtk_Vbox;
      Container_Buttons : Gtk_Hbox;
      TMP         : Gtk_Button;
   Begin

      Gtk_New(Fenetre_Choix.Win_Choix_type,Window_Toplevel);
      Connect(Fenetre_Choix.Win_Choix_type,"destroy",Close_Choix_Parametre'Access);
      Gtk_New_Vbox(Container,False,3);
      Gtk_New_Hbox(Container_Buttons,True,3);
      Gtk_New(Label_Text);
      Fenetre_Choix.Win_Choix_type.Set_Default_Size(300,100);
      Fenetre_Choix.Win_Choix_type.Set_Title("Choix du type de joueur");
      Fenetre_Choix.Win_Choix_type.Set_Parent(Get_Win);
      Fenetre_Choix.Win_Choix_type.set_Modal(true);
      Fenetre_Choix.Win_Choix_type.Add(Container);
      Container.Pack_Start(Label_Text);
      Container.Pack_Start(Container_Buttons);
      Label_Text.Set_Markup("<span size='large' face='verdana' ><b>Veuillez choisir "&
                            "un type de joueur</b></span>");
      Gtk_New(TMP,"HUMAIN");
      Container_Buttons.Pack_Start(TMP);
      TMP.Set_Name(NomButton);
      Connect(TMP,"clicked",Set_Type'Access);
      Gtk_New(TMP,"ORDINATEUR");
      TMP.Set_Name(NomButton);
      Connect(TMP,"clicked",Set_Type'Access);
      Container_Buttons.Pack_Start(TMP);
      Gtk_New(TMP,"FERMER");
      Connect(TMP,"clicked",Set_Type'Access);
      TMP.Set_Name(NomButton);
      Container_Buttons.Pack_Start(TMP);

      Fenetre_Choix.Win_Choix_type.Set_Resizable(False);
      Fenetre_Choix.Win_Choix_type.Modify_Bg(State_Type => State_Normal,
                                             Color      => Parse("white") );
      Fenetre_Choix.Win_Choix_type.Show_All;

End Construct_Choix_Type;


   ----------------------------
   -- Construct_Choix_niveau --
   ----------------------------

   Procedure Construct_Choix_niveau(NomButton : String) Is

       Label_Text  : Gtk_Label;
      Container   : Gtk_Vbox;
      Container_Buttons : Gtk_Hbox;
      TMP         : Gtk_Button;
   Begin

      Gtk_New(Fenetre_Choix.Win_Choix_Niveau,Window_Toplevel);
      Connect(Fenetre_Choix.Win_Choix_Niveau,"destroy",Close_Choix_Parametre'Access);
      Gtk_New_Vbox(Container,False,3);
      Gtk_New_Hbox(Container_Buttons,True,3);
      Gtk_New(Label_Text);
      Fenetre_Choix.Win_Choix_Niveau.Set_Default_Size(300,100);
      Fenetre_Choix.Win_Choix_Niveau.Set_Title("Choix du Niveau de l'Ordinateur");
      Fenetre_Choix.Win_Choix_Niveau.Set_Parent(Get_Win);
      Fenetre_Choix.Win_Choix_Niveau.set_Modal(true);
      Fenetre_Choix.Win_Choix_Niveau.Add(Container);
      Container.Pack_Start(Label_Text);
      Container.Pack_Start(Container_Buttons);
      Label_Text.Set_Markup("<span size='large' face='verdana' ><b>Veuillez choisir "&
                            "un niveau d'intelligence artificielle</b></span>");
      Gtk_New(TMP,"FACILE");
      Container_Buttons.Pack_Start(TMP);
      TMP.Set_Name(NomButton);
      Connect(TMP,"clicked",Set_Niveau'Access);
      Gtk_New(TMP,"MOYEN");
      TMP.Set_Name(NomButton);
      Connect(TMP,"clicked",Set_Niveau'Access);
      Container_Buttons.Pack_Start(TMP);
      Gtk_New(TMP,"EXPERT");
      Connect(TMP,"clicked",Set_Niveau'Access);
      TMP.Set_Name(NomButton);
      Container_Buttons.Pack_Start(TMP);

      Fenetre_Choix.Win_Choix_Niveau.Set_Resizable(False);
      Fenetre_Choix.Win_Choix_Niveau.Set_Name("Choix_Niveau");
      Fenetre_Choix.Win_Choix_Niveau.Modify_Bg(State_Type => State_normal,
                                               Color      => Parse("white"));
      Fenetre_Choix.Win_Choix_Niveau.Show_All;
   End Construct_Choix_Niveau;

   -----------------------------
   -- Construct_Choix_Couleur --
   -----------------------------

   Procedure Construct_Choix_Couleur(NomButton : String) Is
      Selection : Gtk_Color_Selection;
      Couleur   : Gdk_Color;
   Begin
      if Fenetre_Choix.Win_Choix_Couleur = null or else
        (not Fenetre_Choix.Win_Choix_Couleur.Is_Active) then

         Gtk_New(Fenetre_Choix.Win_Choix_Couleur,"Selection de couleur");
         Fenetre_Choix.Win_Choix_Couleur.Modify_Bg(State_Type => State_normal,
                                                   Color      => Parse("white"));
         Fenetre_Choix.Win_Choix_Couleur.Show_All;
         if Fenetre_Choix.Win_Choix_Couleur.run = Gtk_Response_OK
      then
            Selection := Fenetre_Choix.Win_Choix_Couleur.Get_Colorsel;
            Selection.Get_Current_Color(couleur);
            Get_Button(NomButton,Button_Couleur_Symbole).Modify_Bg(State_Normal,
                                                                   Color      => couleur);
            Get_Button(NomButton,Button_Couleur_Symbole).Set_Name(To_String(couleur));
            Fenetre_Choix.Win_Choix_Couleur.Destroy;
            Fenetre_Choix.Win_Choix_Couleur := null;
         else Fenetre_Choix.Win_Choix_Couleur.Destroy;
            Fenetre_Choix.Win_Choix_Couleur := null;

         end if;
      end if;

   End Construct_Choix_Couleur;

   ---------------------------
   -- Close_Choix_Parametre --
   ---------------------------

  Procedure Close_Choix_Parametre(Fenetre : access Gtk_Window_Record'Class) Is
   Begin
      if Fenetre_Choix.Win_Choix_Niveau /= null and then
        Fenetre_Choix.Win_Choix_Niveau.Get_Name = Fenetre.Get_Name
      then --Fenetre_Choix.Win_Choix_Niveau.Destroy;
         Fenetre_Choix.Win_Choix_Niveau:=null;
      elsif  Fenetre_Choix.Win_Choix_type /= null and then
        Fenetre_Choix.Win_Choix_type.Get_Name = Fenetre.Get_Name
      then Fenetre_Choix.Win_Choix_type:=null;
      else
         Fenetre_Choix.Win_Choix_Symbole :=null;
      end if;

   End Close_Choix_Parametre;

   --------------
   -- Est_Dans --
   --------------

  Function Est_Dans(Entrie : Gtk_Gentry;Tableau : T_Tab_GEntry)
                     return Boolean Is
   Begin

      for i in T_Tab_GEntry'Range loop
         if Tableau(i) /= null and then Entrie.Get_Text = Tableau(i).Get_Text
         then return True; end if;
      end loop;
      return False;
   End Est_Dans;
   --------------
   -- Est_Dans --
   --------------

   Function Est_Dans(Buttons : Gtk_Button;Tableau : T_Tab_Button)
                     return Boolean Is
   Begin
      for i in T_Tab_Button'Range loop
         if Tableau(i) /= null and then Buttons.Get_Label = Tableau(i).Get_Label
         then return True; end if;
      end loop;
      return False;
   End Est_Dans;

   ---------------------
   -- Verif_parametre --
   ---------------------

   Function Verif_parametre(Nbjoueur:integer) return boolean is
      Liste_nom : T_Tab_GEntry;
      Liste_Symbole : T_Tab_Button;
   Begin

      for i in 1..Nbjoueur loop

         if Get_Parametre.TypeJoueur(i).Get_Label="Type de joueur"
         then return false;
         elsif Get_Parametre.NiveauJoueur(i).Is_Sensitive and
           Get_Parametre.NiveauJoueur(i).Get_Label="Niveau"
         then return false;
         elsif Est_Dans(Get_Parametre.NomJoueurs(i),Liste_nom) or
           Get_Parametre.NomJoueurs(i).Get_Text'Length=0
         then return False;
         elsif Est_Dans(Get_Parametre.SymboleJoueur(i),Liste_Symbole)
         then return False;
         else
            Liste_Symbole(i):=Get_Parametre.SymboleJoueur(i);
            Liste_nom(i):=Get_Parametre.NomJoueurs(i);
         end if;
      end loop;
      return True;

   End Verif_parametre;

end Events;

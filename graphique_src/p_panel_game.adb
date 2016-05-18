with P_PARAMETRE;			use P_PARAMETRE;
with Ada.Integer_Text_IO;		use Ada.Integer_Text_IO;
with gtk.Table;				use Gtk.Table;
with Glib; 				use Glib;
with Ada.Text_IO; 			use Ada.Text_IO;
with Gtk.Frame; 			use Gtk.Frame;
with gtk.Enums;			use Gtk.Enums;
with Events;				use Events;
with Gtk.HButton_Box; 		use Gtk.HButton_Box;
with Gtk.Event_Box; 		use Gtk.Event_Box;
with Gtk.Image; 			use Gtk.Image;
with Ada.Strings.Unbounded; 	use Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Gtk.Message_Dialog; 	use Gtk.Message_Dialog;
with Gtk.Dialog; 			use Gtk.Dialog;
with P_Fenetre;
with Gtk.Main;
use Gtk.Main;

package body P_Panel_Game is


   ---------------
   -- Construct --
   ---------------

   procedure Construct (Parametre : in T_Parametre) is
      use P_Events_Widget;
      use Events.P_Events_Button;
      tmp_button : Gtk_Button;
      Ligne      : integer := 3;
      Colonne    : integer := 3;
      Plateau    : Gtk_Table;
      ContainerTitre,
      Container_Label,
      Container_Ecran,
      Container_Ecrans_Plateau,
      score_joueur1,
      score_joueur2,
      match_null : Gtk_Hbox;

      Container_Buttons : Gtk_HButton_Box;
      label_nom,
      label_symbole,
      Nom_Joueur1,
      Nom_Joueur2: Gtk_Label;

      Abscisse,Ordonnee: Integer;
      Hauteur,Largeur  : Integer;
      cpt               : Integer :=0;
      BordureEcran ,
      BordureScore,
      BordureBouttons,
      BordurePlateau           : Gtk_Frame;

      NouvelPartie,
      Rejouer,
      Quitter : Gtk_Button;

      FondButtons,
      FondScore,
      FondEcran                 : Gtk_Event_Box;
      ContainerGauche,
      ContainerScore,
      ContainerEcran           : Gtk_Vbox;
      tmp_image                : Gtk_Image;

   Begin

      --création du conteneur principale.
      Gtk_New_Vbox(Panel_Game.Container,False,10);
      --Création du conteneur Gauche qui seras composée d'ecran de jeu et de score.
      Gtk_New_Vbox(ContainerGauche,False,10);
      --création de la grille de jeu avec le nombre colonne et le nombre de ligne
      --(3,3) par défaut.

      Gtk_New(Plateau,Guint(Ligne),Guint(Colonne),True);
      -- création du conteneur des buttons
      Gtk_New(Container_Buttons);
      Container_Buttons.Set_Layout(Layout_Style => Gtk.Enums.Buttonbox_Spread);
      --création des conteneurs score et ecran de jeu
      Gtk_new_Vbox(ContainerScore,Homogeneous => True,
                   Spacing                    => 5);
      Gtk_new_Vbox(ContainerEcran,Homogeneous => True,
                   Spacing                    => 5);
      ContainerEcran.Set_Size_Request(200,50);
      --création des buttons
      Gtk_New(NouvelPartie,"Nouvelle Partie");
      NouvelPartie.Modify_Bg(State_Normal,Parse("#B5E655"));
      Gtk_new(Rejouer,"Rejouer");
      Rejouer.Modify_Bg(State_Normal,Parse("#B5E655"));
      Gtk_New(Quitter,"Quitter");
      Quitter.Modify_Bg(State_Normal,Parse("#FF358B"));
      Gtk_New(Panel_Game.Replay,"Replay");
      Panel_Game.Replay.Modify_Bg(State_Normal,Parse("#ABC8E2"));
      Rejouer.Set_Size_Request(50,50);

      --création de bordures des composant
      Gtk_new(BordureBouttons);
      BordureBouttons.Modify_Bg(State_Normal,Parse("#01B0F0"));
      BordureBouttons.Add(Container_Buttons);
      Gtk_New(BordureScore,"SCORE");
      BordureScore.Modify_Bg(State_Normal,Parse("#01B0F0"));
      BordureScore.Add(ContainerScore);
      Gtk_new(BordureEcran,"Ecran");
      BordureEcran.Modify_Bg(State_Normal,Parse("#01B0F0"));
      BordureEcran.Add(ContainerEcran);
      Gtk_new(BordurePlateau);
      BordurePlateau.Modify_Bg(State_Normal,Parse("#01B0F0"));
      BordurePlateau.Add(Plateau);

      --création des fond des composants
      Gtk_new(FondButtons);
      FondButtons.Modify_Bg(State_normal,Parse("#FCFAE1"));
      FondButtons.Add(BordureBouttons);
      Gtk_New(FondEcran);
      FondEcran.Modify_Bg(State_normal,Parse("#FCFAE1"));
      FondEcran.Add(BordureEcran);
      Gtk_new(FondScore);
      FondScore.Modify_Bg(State_normal,Parse("#FCFAE1"));
      FondScore.Add(BordureScore);

      --Ajout des boutons au conteneur ContainerButtons
      Container_Buttons.Pack_Start(Rejouer);
      Container_Buttons.Pack_Start(NouvelPartie);
      Container_Buttons.Pack_Start(Panel_Game.Replay);
      Container_Buttons.Pack_Start(Quitter);

    --Ajout des omposants aux conteneur score et ecran
      Gtk_new_Hbox(Container_Label,True,3);
      Gtk_New_Hbox(Container_Ecran,True,3);
      Gtk_New(label_nom);
      Gtk_new(label_symbole);

      label_nom.Set_Markup("<span size='medium' face='verdana' foreground='#73b5ff'>"&
                           "<b>Nom du joueur</b></span>");

      label_symbole.Set_Markup("<span size='medium' face='verdana' foreground='#73b5ff'>"&
                               "<b>Symbole</b></span>");
      Container_Label.Pack_Start(label_nom);
      Container_Label.Pack_Start(label_symbole);

      Gtk_New(Panel_Game.EcranNom);
      Gtk_New(Panel_Game.EcranSymbole);
      --on met a jour l'ecran
      Mise_A_Jour_Ecran;

      Container_Ecran.Pack_Start(Panel_Game.EcranNom);
      Container_Ecran.Pack_Start(Panel_Game.EcranSymbole);

      ContainerEcran.Pack_Start(Container_Label);
      ContainerEcran.Pack_Start(Container_Ecran);

      Gtk_new(Nom_Joueur1);
      Nom_Joueur1.Set_Markup("<span size='large' face='verdana'><b>"&
                             Get_Nom(Get_Joueur(Game,Partie.Joueur1)) &" : </b></span>");

      Gtk_new(Nom_Joueur2);
      Nom_Joueur2.Set_Markup("<span size='large' face='verdana'><b>"&
                             Get_Nom(Get_Joueur(Game,Partie.Joueur2)) &" : </b></span>");

      Gtk_New(Panel_Game.Score_Joueur1);
      Gtk_new(panel_Game.Score_Joueur2);
      Gtk_new(Panel_Game.score_null);
      --on met a jour l'ecran des scores;
      Mise_A_Jour_Score;

      Gtk_new_hbox(score_joueur1,True,5);
      Gtk_new_Hbox(score_joueur2,true,5);
      Gtk_new_Hbox(match_null,true,5);

      declare
         label : gtk_label;
      begin
         Gtk_new(label);
         label.Set_Markup("<span size='large' face='verdana'><b>Match(s) Nul(s) : </b></span>");
         match_null.Pack_Start(label);
         match_null.Pack_Start(Panel_Game.score_null);
      end ;

      score_joueur1.Pack_Start(Nom_Joueur1);
      score_joueur1.Pack_Start(Panel_Game.Score_Joueur1);

      score_joueur2.Pack_Start(Nom_Joueur2);
      score_joueur2.Pack_Start(Panel_Game.Score_Joueur2);


      ContainerScore.Pack_Start(score_joueur1);
      ContainerScore.Pack_Start(score_joueur2);
      ContainerScore.Pack_Start(match_null);

      --Ajout des composants du conteneur Gauche
      ContainerGauche.Pack_Start(FondEcran);
      ContainerGauche.Pack_Start(FondScore);

      --
      Gtk_new_hbox(ContainerTitre);
      for i in 1..7 loop
         Case i is
            when 1 => Gtk_new(tmp_image,"./media/M_min.png");
               ContainerTitre.Pack_Start(tmp_image);
                when 2 => Gtk_new(tmp_image,"./media/O_min.png");
               ContainerTitre.Pack_Start(tmp_image);
               when 3 => Gtk_new(tmp_image,"./media/R_min.png");
               ContainerTitre.Pack_Start(tmp_image);
                when 4 => Gtk_new(tmp_image,"./media/P_min.png");
               ContainerTitre.Pack_Start(tmp_image);
                when 5 => Gtk_new(tmp_image,"./media/I_min.png");
               ContainerTitre.Pack_Start(tmp_image);
                when 6 => Gtk_new(tmp_image,"./media/O_min.png");
               ContainerTitre.Pack_Start(tmp_image);
                when 7 => Gtk_new(tmp_image,"./media/N_min.png");
               ContainerTitre.Pack_Start(tmp_image);
         end Case;
      end loop;


      -- Création et ajout des composant au conteneur principale
      Gtk_New_Hbox(Container_Ecrans_Plateau,False,5);
      Container_Ecrans_Plateau.Pack_Start(ContainerGauche);
      Container_Ecrans_Plateau.Pack_Start(BordurePlateau);
      Panel_Game.Container.Pack_Start(ContainerTitre);
      Panel_Game.Container.Pack_Start(Container_Ecrans_Plateau);
      Panel_Game.Container.Pack_Start(FondButtons);
      --
      Gtk_new(BordureBouttons);


      Plateau.Set_Size_Request(480,480);


     Panel_Game.Grille.clear;
      For i in 1..Ligne loop
         For j in 1..colonne loop
            Gtk_New(tmp_button);
            tmp_button.Set_Name(Name => integer'Image(i) & "-" & integer'Image(j));
            Connect(tmp_Button,"clicked",jouer_Game'Access);
            Gtk_new(tmp_image,"./media/images.jpg");
            tmp_button.Add(tmp_image);
            tmp_button.Modify_Bg(State_Normal,Parse("#EFEFEF"));
            Panel_Game.Grille.Append(tmp_button);
         End loop;
      End loop;


      For i in 1..Ligne loop
         Hauteur := 0;
         Largeur := 1;
         Abscisse := i-1;
         Ordonnee := i;
         For j in 1..Colonne loop
            cpt:=cpt+1;
            Plateau.Attach(Panel_Game.Grille.Element(cpt),Guint(Hauteur),Guint(Largeur),
                           Guint(Abscisse),Guint(Ordonnee));
            Hauteur := Hauteur+1;
            Largeur := Largeur+1;
         End loop;
      End loop;

      Panel_Game.Container.Show_All;
      Panel_Game.Replay.Set_Sensitive(False);

      Connect(NouvelPartie,"clicked",Nouvel_Partie'Access);
      Connect(Rejouer,"clicked",Rejouer_Partie'Access);
      Connect(Quitter,"clicked",Quittez_partie'Access);
      Connect(Panel_Game.Replay,"clicked",Replay'Access);

      --on fait jouer l'ordinateur si au moins un des joueurs est controlés par l'ordi
      if Get_Genre(J => Get_Joueur(Game => Game,
                                   Num  => Partie.Joueur1))/=Joueurs.Humain
        or Get_Genre(J => Get_Joueur(Game => Game,
                                     Num  => Partie.Joueur2))/=Joueurs.Humain
      then Jouer_Coup_Ordi;
      end if;

   exception
         when others => NULL;

   end Construct;

   ----------------
   -- Set_Grille --
   ----------------

   procedure Set_Grille (Grille : in Liste_Button) is
   begin
     Panel_Game.Grille := Grille;
   end Set_Grille;

   -------------------
   -- Set_Container --
   -------------------

   procedure Set_Container (Container : Gtk_Vbox) is
   begin
      Panel_Game.Container := Container;
   end Set_Container;

   ---------------
   -- Set_Ecran --
   ---------------

   procedure Set_EcranNom (Ecran : Gtk_Label) is
   begin
      Panel_Game.EcranNom := Ecran;
   end Set_EcranNom;

   ----------------
   -- Get_Grille --
   ----------------

   function Get_Grille return Liste_Button is
   begin
     return Panel_Game.Grille;
   end Get_Grille;

   -------------------
   -- Get_Container --
   -------------------

   function Get_Container return Gtk_Vbox is
   begin
      Construct(Get_Parametre);
     return Panel_Game.Container;
   end Get_Container;

   ---------------
   -- Get_Ecran --
   ---------------

   function Get_EcranNom return Gtk_Label is
   begin
     return Panel_Game.EcranNom;
   end Get_EcranNom;

   Function Get_Game return T_Game Is
   Begin
      return Game;
   End Get_Game;
   Procedure Set_Game(Game : T_Game) Is
   Begin
      P_Panel_Game.Game := Game;
   End Set_Game;

   --------------------------
   -----Init_Game------
   --------------------------

   Procedure Init_Game(Joueur1,Joueur2:Joueur;Grille_jeu:Plateau
                      ;Couleur1,Couleur2 : String) Is
   Begin
      Game := Construct_Game(Joueur1    => Joueur1,
                             Joueur2    => joueur2,
                             Grille_jeu => Grille_jeu,
                             Couleur1   => Couleur1,
                             Couleur2   => Couleur2);
      Clear(Panel_Game.Historique);
   End Init_Game;


   Procedure Joueur_Suivant Is
   Begin
      Partie.Organise_Game(Game);
   end Joueur_Suivant;

   -----------------------------
   -----Mise_A_Jour_Ecran--
   ----------------------------------

   Procedure Mise_A_Jour_Ecran Is
      symb : String := Ada.Strings.Fixed.delete(Ada.Strings.Fixed.delete(
        Symbole'Image(Get_Symbole (Get_Current_Joueur(Game))),1,1),2,2);
   Begin
      Panel_Game.EcranNom.Set_Markup("<span size='x-large' face='verdana' foreground='"
                                     &Get_Couleur_Pion(Get_Game)&"'>"&"<b>"
                                     &Get_Nom(Get_Current_Joueur(Game))&"</b></span>");

      Panel_Game.EcranSymbole.Set_Markup("<span size='x-large' face='verdana' foreground='"&
                                        Get_Couleur_Pion(Get_Game)&"'>"&"<b>"
                                        &symb&"</b></span>");
   End Mise_A_Jour_Ecran;

   -----------------------------------
   -------Mise_A_Jour_Score--
   -----------------------------------

   Procedure Mise_A_Jour_Score Is
   Begin
   	Panel_Game.Score_Joueur1.Set_Markup("<span size='large' face='verdana'><b>"&
                                          Integer'Image(Get_Score(Game => Game,Num  => Partie.Joueur1))
                                        &" Victoire(s)</b></span>");
      Panel_Game.Score_Joueur2.Set_Markup("<span size='large' face='verdana'><b>"&
                                          Integer'Image(Get_Score(Game => Game,Num  => Partie.Joueur2))
                                          &" Victoire(s)</b></span>");
      Panel_Game.score_null.Set_Markup("<span size='large' face='verdana'><b>"&
                                          Natural'Image(Get_Score(Game,3))&"</b></span>");
   End Mise_A_Jour_Score;

   Function Get_Button(Name : String) return Gtk_Button Is
   Begin
      for i in 1..Last_Index(Panel_Game.Grille) loop
         if Panel_Game.Grille.Element(i).get_Name = Name
         then return Panel_Game.Grille.Element(i);
         end if;
      End loop;
      return null;
   End Get_Button;


   ----------------------------------
   ------Jouer_Game----------
   ---------------------------------

   Procedure Jouer_Game(Event : access gtk_Button_record'Class:=null) Is
      Colonne : Plateaux.Colonne;
      Ligne   : Plateaux.Ligne;
      Resultat : Positive;
      --suppression des deux cotes entourant le symbole du joueur
      symb           : String(1..1);
      img            : Gtk_image;
      Nom_Case : String(1..5);
   Begin

      if Get_Genre(Get_Current_Joueur(Game))=Joueurs.Humain
        and Event /= null then
          --Recuperation des coordonnées de la case jouée par le joueur
         Colonne := Event.Get_Name(5);
         Ligne := Event.Get_Name(2);

         symb := Ada.Strings.Fixed.delete(Ada.Strings.Fixed.delete(
           Symbole'Image(Get_Symbole (Get_Current_Joueur(Game))),1,1),2,2);
      --on teste si la case n'est pas déjà occupée
         if Plateaux.Libre(Un_plateau => Get_Grille_Jeu(Game => Game),
                           X          => Colonne,
                           Y          => Ligne) and then not Get_Partie_Finie(Game => Game) Then
            --on met le pion du joueur courant sur la case clicée
            --Event.Set_Label("");
            --Gtk_Label(Event.Get_Child).set_markup("<big><span size='xx-large' foreground='"
                                            --      &Get_Couleur_Pion(Game)&"'><b>"&symb
                                            --     & "</b></span></big>");

            --Desactivation de la case jouée
            if symb = "O" then Gtk_New(img,"./media/Pion_O.png");
            else Gtk_New(img,"./media/Pion_X.png");
            end if;
            Event.Modify_Bg(State_Type => State_Normal,
                            Color      => Parse(Get_Couleur_Pion(Game)));

            Event.set_image(img);
            --on ajoute le bouton à  l'historique du jeu
            nom_case := " "&(Ligne)&"- "&(Colonne);
            Panel_Game.Historique.append(get_Button(nom_case));
            --Event.Set_Sensitive(False);
            --On joue la case
           Jouer_Case(Game,Colonne,Ligne,Resultat);
            --Si le joueur à gagner
            if resultat = 1
            then Mise_A_Jour_Score;
               --on active le bouton replay
               Panel_Game.Replay.Set_Sensitive(True);
               Afficher_vanquaire(1,Symb);
               --Si le match est nul
            elsif Resultat = 2
            then
               --on active le bouton replay
               Panel_Game.Replay.Set_Sensitive(True);
               Mise_A_Jour_Score;
               Afficher_Vanquaire(2,symb);
            end if;
            --Mise à  jour des informations des ecrans d'affichage
             Partie.Organise_Game(Jeu => Game);
            P_Panel_Game.Mise_A_Jour_Ecran;
         end if;
      end if;
   End Jouer_Game;

   Procedure Jouer_Coup_Ordi is

     Package Time_out_ordi is new Gtk.Main.Timeout(Data_Type => Integer);
      Timeout_Handle : Timeout_Handler_Id;
      Intervalle : Glib.Guint32 := 2000;
      function invoke(Delai : Integer) return boolean;

      function invoke(Delai : integer)return boolean is
         X        : Plateaux.Colonne;
         Y        : Plateaux.Ligne;
         Resultat : Positive := 3;
         nom_case : String(1..5);
         symb     : string := Ada.Strings.Fixed.delete(Ada.Strings.Fixed.delete(
           Symbole'Image(Get_Symbole (Get_Current_Joueur(Game))),1,1),2,2);
         img : Gtk_Image;
      Begin
         if Joueurs.Get_Genre(J => Get_Current_joueur(Game))/=Joueurs.Humain
           and not Get_Partie_Finie(Game)
         then

            Jouer_Case(Game     => Game,
                       Colonne  => X,
                       Ligne    => Y,
                       Resultat => Resultat);
            nom_case := " "&(Y)&"- "&(X);

               --Panel_Game.Grille.Element(i).set_Label("");
            if symb = "O" then Gtk_New(img,"./media/Pion_O.png");
            else Gtk_New(img,"./media/Pion_X.png");
            end if;
            Get_Button(nom_case).Modify_Bg(State_Type => State_Normal,
                                                     Color      => Parse(Get_Couleur_Pion(Game)));
            Get_Button(nom_case).set_image(img);
            Panel_Game.Historique.append(Get_Button(nom_case));

            if Resultat=1
            then
               Afficher_Vanquaire(choix => 1,
                                  Symb  => symb);
               Mise_A_Jour_Score;
               Panel_Game.Replay.Set_Sensitive(True);
               return false;
            elsif Resultat=2
            then Afficher_Vanquaire(choix => 2,
                                    Symb  => symb);
               Mise_A_Jour_Score;
               Panel_Game.Replay.Set_Sensitive(True);
               return false;
            end if;
            Partie.Organise_Game(Jeu => Game);
            P_Panel_Game.Mise_A_Jour_Ecran;
         elsif Get_Partie_Finie(Game)
         then return false;
         end if;
         return true;
      end invoke;

   Begin
     Timeout_Handle :=  Time_out_ordi.Add(Intervalle,
                                          Func     => invoke'Access,
                                          D        => 2000);
   End Jouer_Coup_Ordi;

   Procedure Replay(Event : access gtk_Button_record'Class) Is
      Package Time_out_ordi is new Gtk.Main.Timeout(Data_Type => Integer);
      Timeout_Handle : Timeout_Handler_Id;
      Intervalle     : Glib.Guint32 := 2000;
      Timeout_Handle2 : Timeout_Handler_Id;
      --cpt : Integer:=1;
      function invoke(Delai : Integer) return boolean;
      function invoke(Delai : Integer) return boolean is
         symb : string := Ada.Strings.Fixed.delete(Ada.Strings.Fixed.delete(
           Symbole'Image(Get_Symbole (Get_Current_Joueur(Game))),1,1),2,2);
         img : Gtk_Image;
      Begin

         if cpt > Last_Index(Panel_Game.Historique) then cpt := 1 ;
            Panel_Game.Replay.Set_Sensitive(True);
            Panel_Game.Replay.Set_Label("Replay");
            return false;
         else

           -- Gtk_Label(Panel_Game.Historique.Element(cpt).get_Child).
            --  set_markup("<big><span size='xx-large' foreground='"
                       --  &Get_Couleur_Pion(Game)&"'><b>"&symb
           --    & "</b></span></big>");

            Set_Current_Joueur(Game           => Game,
                              Current_Joueur => Get_Joueur(Game,Partie.Joueur1));

            for i in 1..cpt loop
               symb := Ada.Strings.Fixed.delete(Ada.Strings.Fixed.delete(
                 Symbole'Image(Get_Symbole (Get_Current_Joueur(Game))),1,1),2,2);
               if symb = "O" then Gtk_New(img,"./media/Pion_O.png");
               else Gtk_New(img,"./media/Pion_X.png");
               end if;
               Panel_Game.Historique.Element(i).Modify_Bg(State_Type => State_Normal,
                                                            Color      => Parse(Get_Couleur_Pion(Game)));
               Panel_Game.Historique.Element(i).set_image(img);
               Partie.Organise_Game(Game);
            end loop;
            Mise_A_Jour_Ecran;
            cpt := cpt + 1 ;
            return true;
         end if;
      end invoke;
      function invoke2(Delai : Integer) return Boolean;
      function invoke2(Delai : Integer) return Boolean Is
         name_case :String(1..5);
         img       : Gtk_image;
         Colonne   : Plateaux.Colonne;
         Ligne : Plateaux.Ligne;
      Begin
         for i in 1..cpt loop
            name_case := Panel_Game.Historique.Element(i).get_Name;
            Colonne := name_case(5);
            Ligne := name_case(2);
            if Partie.get_Symbole(game,Colonne,Ligne)=Cellules.Symbole'First
            then Gtk_New(img,"./media/Pion_O.png");
            else Gtk_New(img,"./media/Pion_X.png");
            end if;
            Get_Button(name_case).Set_Image(img);
         end loop;
         if cpt >= Last_Index(Panel_Game.Historique)
         then return false;
         else
            return true;
         end if;

      End Invoke2;

   img : Gtk_Image;
   Begin
      Event.Set_Sensitive(False);
      Event.Set_Label("Replay en cours...");
      Gtk_New(img,"./media/images.jpg");
      Set_Current_Joueur(Game           => Game,
                         Current_Joueur => Get_Joueur(Game,Partie.Joueur1));
      Mise_A_Jour_Ecran;

      For i in 1..Last_Index(Panel_Game.Grille) loop
         Panel_Game.Grille.Element(i).set_image(img);
         Panel_Game.Grille.Element(i).Modify_bg(State_normal,Parse("#EFEFEF"));
      end Loop;
      Timeout_Handle := Time_out_ordi.Add(Interval => 2000,
                                          Func     => invoke'Access,
                                          D        => 2000);
      Timeout_Handle2 := Time_out_ordi.Add(Interval => 50,
                                          Func     => invoke2'Access,
                                          D        => 50);

   End Replay;

   Procedure Rejouer_Partie(Event : access gtk_Button_record'Class) Is
   Confirm_Dialog : Gtk_Message_Dialog;
   Begin
      Gtk_new(Confirm_Dialog,P_Fenetre.Get_Win,Modal,Message_Question,Buttons_Yes_No,
              "Voulez vous Rejouer la Partie ?");
      Confirm_Dialog.Modify_Bg(State_Type => State_normal,
                               Color      => Parse("white"));
      Confirm_Dialog.Set_Title(" ? ");
      Confirm_Dialog.Set_Resizable(false);
      Confirm_Dialog.Show_All;
      if Confirm_Dialog.Run = Gtk_Response_Yes
      then Confirm_Dialog.Destroy;
         --on vide le plateau de jeu et on met l'attribut Partie_Finie du type T_Game à  false
         --les autres paramètres restent inchangés.
         declare
            Grille_jeu : Plateaux.Plateau;
         begin
             Partie.Set_Current_Joueur(Game,Partie.Get_Joueur(Game => Game,
                                                              Num  => Partie.Joueur1));

            Partie.Set_Grille_Jeu(Game,Plateau_Jeu => Grille_jeu);

            Partie.Set_Partie_Finie(Game         => Game, Partie_Finie => False);
         end ;
         Clear(Panel_Game.Historique);
         --On met à jour l'affichage de la fenetre principale
         P_Fenetre.Get_Win.Hide_All ;
         P_Fenetre.Fenetre_Construct(Vue         => P_Panel_Game.Get_Container ,
                           Plateau_Jeu => True);
      else
         Confirm_Dialog.Destroy;
      End if;

      End Rejouer_Partie;

      procedure Afficher_Vanquaire(choix : Positive;Symb:String) Is
         Message_Dialog : Gtk_Message_Dialog;
      Begin
         if choix = 1 then
      	 Gtk_New(Message_Dialog,P_Fenetre.Get_Win,Modal,Message_Info,Buttons_Ok,
                       ".....VICTOIRE....."&Events.newline&
                       "Nom du joueur : "&Get_Nom(Get_Current_Joueur(Game))&newline&
                       "Symbole du joueur : "& symb);

               Message_Dialog.Modify_Bg(State_Type => State_Normal,
                                        Color      => Parse("white"));

               Message_Dialog.Show_All;

               if Message_Dialog.Run = Gtk_Response_OK
               then Message_Dialog.Destroy;
               else Message_Dialog.Destroy;
            end if;
         else
            Gtk_New(Message_Dialog,P_Fenetre.Get_Win,Modal,Message_Info,Buttons_Ok,
                 "Partie Terminée"&Events.newline&"Match Nul");
         Message_Dialog.Modify_Bg(State_Type => State_Normal,
                                  Color      => Parse("white"));
         Message_Dialog.Show_All;
         if Message_Dialog.Run = Gtk_Response_OK
         then Message_Dialog.Destroy;
         else Message_Dialog.Destroy;
            end if;
         end if;

      End Afficher_Vanquaire;


end P_Panel_Game;

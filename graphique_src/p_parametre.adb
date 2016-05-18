With Gtk.Spin_Button;		use Gtk.Spin_Button;
with Gtk.Button;			use gtk.Button;
with Gtk.Spin_Button;		use gtk.Spin_Button;
with gtk.Label;				use gtk.Label;
with Gtk.Enums;			use Gtk.Enums;
with Gtk.Adjustment;		use Gtk.Adjustment;
with Gdk.Color;			use Gdk.Color;
with Gtk.Window;			use Gtk.Window;
with Gtk.Table;				use Gtk.Table;
with Glib.Convert;			use Glib.Convert;
with Events;				use Events;
with Gtk.Box;				use Gtk.Box;
with gtk.Scrollbar;			use Gtk.Scrollbar;
with Gtk.Scrolled_Window; 	use Gtk.Scrolled_Window;
with Ada.Text_IO;			use Ada.Text_IO;
with Gtk.Handlers;
with Ada.Integer_Text_IO;		use Ada.Integer_Text_IO;
with Gtk.Image; 			use Gtk.Image;
with Gtk.Frame; 			use Gtk.Frame;
with Gtk.Hbutton_Box; 		use Gtk.Hbutton_Box;
with Gtk.Event_Box; 		use Gtk.Event_Box;



PACKAGE BODY P_PARAMETRE IS
   USE P_Events_Button;

   PROCEDURE Construct_Parametre IS
      Nom_Joueur : Gtk_GEntry;
      Type_Joueur : Gtk_Button;
      Niveau_Joueur : Gtk_Button;
      Symbole_Joueur : Gtk_Button;
      CouleurPions : Gtk_Button;

   BEGIN

      for i in 1..TailleMax loop

         Gtk_New(Nom_Joueur);
         Nom_Joueur.Set_Max_Length(10);
         Nom_Joueur.Set_Text("Joueur"&integer'Image(i));
         Nom_Joueur.Set_Size_Request(Width  => 50,
                                     Height => 60);
         Parametre.NomJoueurs(i) := Nom_Joueur;

         Gtk_New(Type_Joueur,"Type de joueur");
         Type_Joueur.Set_Size_Request(Width  => 50,
                                     Height => 60);
         Parametre.TypeJoueur(i) := Type_Joueur;
         Parametre.TypeJoueur(i).Set_Name("T"&integer'Image(i));
         Connect(Parametre.TypeJoueur(i),"clicked",Choix_Type_Joueur'Access);

         Gtk_New(Niveau_Joueur,"Niveau");
         Parametre.NiveauJoueur(i) := Niveau_Joueur;
         Parametre.NiveauJoueur(i).Set_Name("N"&integer'Image(i));
         Parametre.NiveauJoueur(i).Set_Sensitive(False);
         Connect(Parametre.NiveauJoueur(i),"clicked",Choix_Niveau_Ordi'Access);

         Gtk_New(Symbole_Joueur,"Symbole");
         Parametre.SymboleJoueur(i) := Symbole_Joueur;
         Parametre.SymboleJoueur(i).Set_Name("S"&integer'Image(i));
         Connect(Parametre.SymboleJoueur(i),"clicked",Choix_Symbole'Access);

         Gtk_New(CouleurPions,"Couleur");
         CouleurPions.Set_Name("C"&Integer'Image(i));
         Parametre.CoulueurSymbole(i) := CouleurPions;
         Connect(Parametre.CoulueurSymbole(i),"clicked",Choix_Couleur_Symbole'Access);

         Case i is
            when 1 => Parametre.TypeJoueur(i).Set_Label(Humain);
               Parametre.SymboleJoueur(i).Set_Label("O");
            when 2 => Parametre.TypeJoueur(i).Set_Label(Humain);
               Parametre.SymboleJoueur(i).Set_Label("X");
         end Case;



      end loop;

   END Construct_Parametre;

   FUNCTION Get_Parametre_Vue Return Gtk_Box  IS
      Vue : Gtk_Vbox;
      ContainerParam   : Gtk_Table;
      ContainerButton  : Gtk_Hbutton_Box;
      FrameParam       : Gtk_Frame;
      FrameButton	: Gtk_Frame;
      tmp_image        : Gtk_Image;
      abscisse,ordonnee:Guint :=0;
      LancerPartie     : Gtk_Button;
      Quittez          : Gtk_Button;
      FondImg          : Gtk_Event_Box;
      FondButton       : Gtk_Event_Box;
      FondParam        : Gtk_Event_Box;
      ContainerTitre   : Gtk_Hbox;

   BEGIN
      Construct_Parametre;
      Gtk_New_Vbox(Vue,Homogeneous => False,
                   Spacing     => 10);

      Gtk_New(ContainerButton);

      ContainerButton.Set_Layout(Layout_Style => Buttonbox_Spread);

      Gtk_New(ContainerParam,2,5,true);

      Gtk_new_Hbox(ContainerTitre,False,1);

      Gtk_New(FondImg);

      Gtk_new(FondButton);

      Gtk_New(FondParam);

      Gtk_New(FrameParam,"Paramètre du jeu");

      Gtk_New(FrameButton);

      FrameParam.Add(ContainerParam);

      FrameButton.add(ContainerButton);

      FrameParam.Modify_Bg(State_normal,Parse("#01B0F0"));

      FrameParam.Set_Shadow_Type(The_Type => Gtk.Enums.Shadow_Etched_Out);

      FrameButton.Modify_Bg(State_normal,Parse("#01B0F0"));

      Gtk_New(LancerPartie,"Jouer !");

      Gtk_new(Quittez,"Quittez le jeu");

      LancerPartie.Set_Size_Request(100,50);
      Quittez.Set_Size_Request(100,50);

      LancerPartie.Modify_Bg(State_Type => State_Normal,
                             Color      => Parse("#B5E655"));

      Quittez.Modify_Bg(State_Type => State_Normal,
                        Color      => Parse("#FF358B"));
      for i in 1..7 loop
         Case i is
            when 1 => Gtk_new(tmp_image,"./media/M.png");
               ContainerTitre.Pack_Start(tmp_image);
                when 2 => Gtk_new(tmp_image,"./media/O.png");
               ContainerTitre.Pack_Start(tmp_image);
               when 3 => Gtk_new(tmp_image,"./media/R.png");
               ContainerTitre.Pack_Start(tmp_image);
                when 4 => Gtk_new(tmp_image,"./media/P.png");
               ContainerTitre.Pack_Start(tmp_image);
                when 5 => Gtk_new(tmp_image,"./media/I.png");
               ContainerTitre.Pack_Start(tmp_image);
                when 6 => Gtk_new(tmp_image,"./media/O.png");
               ContainerTitre.Pack_Start(tmp_image);
                when 7 => Gtk_new(tmp_image,"./media/N.png");
               ContainerTitre.Pack_Start(tmp_image);
         end Case;

      end loop;


      FondImg.Add(ContainerTitre);
      FondButton.Add(FrameButton);
      FondParam.Add(FrameParam);
      FondImg.Modify_Bg(State_Normal,Parse("#FFFFFF"));
      FondParam.Modify_Bg(State_Normal,Parse("#FCFAE1"));
      FondButton.Modify_Bg(State_Normal,Parse("#FCFAE1"));



      vue.Pack_Start(FondImg);
      Vue.Pack_Start(FondParam);
      Vue.Pack_Start(FondButton);


      ContainerButton.Pack_Start(LancerPartie);
      ContainerButton.Pack_Start(Quittez);

      for i in 1..TailleMax loop
         abscisse := Guint(i-1);
         ordonnee := Guint(i);
         ContainerParam.Attach(Parametre.NomJoueurs(i),0,1,abscisse,ordonnee);

         ContainerParam.Attach(Parametre.TypeJoueur(i),1,2,abscisse,ordonnee);

         ContainerParam.Attach(Parametre.NiveauJoueur(i),2,3,abscisse,ordonnee);

         ContainerParam.Attach(Parametre.SymboleJoueur(i),3,4,abscisse,ordonnee);

         ContainerParam.Attach(Parametre.CoulueurSymbole(i),4,5,abscisse,ordonnee);

      end loop;

      Connect(LancerPartie,"clicked",Lancer_Partie'Access);
      P_Events_Widget.Connect(Quittez,"clicked",Quittez_partie'Access);

      vue.Show_All;

       return Vue;
   Exception
      When others => put("lol");
         return Vue;

   END Get_Parametre_Vue;

   Function Get_Parametre return T_Parametre Is
   Begin
      return Parametre;
   End Get_Parametre;

   Function Get_Button(Nom_Button : String;Type_Button : integer)
                       return Gtk_Button Is
      indice : integer ;
   Begin

      if Type_Button = Button_Type_Joueur
      then if Nom_Button'Length = 3
         then indice := Character'Pos(Nom_Button(Nom_Button'Last))-48;
            return Parametre.TypeJoueur(indice);
         else return Parametre.TypeJoueur(Integer(TailleMax));
         end if;
      elsif Type_Button = Button_Symbole_Joueur
      then if Nom_Button'Length = 3
         then indice := Character'Pos(Nom_Button(Nom_Button'Last))-48;
            return Parametre.SymboleJoueur(indice);
         else return Parametre.SymboleJoueur(Integer(TailleMax));
         end if;
      elsif Type_Button = Button_Niveau_Joueur
        then if Nom_Button'Length = 3
         then indice := Character'Pos(Nom_Button(Nom_Button'Last))-48;
            return Parametre.NiveauJoueur(indice);
            else return Parametre.NiveauJoueur(Integer(TailleMax));
         end if;
         elsif Type_Button = Button_Couleur_Symbole
        then if Nom_Button'Length = 3
         then indice := Character'Pos(Nom_Button(Nom_Button'Last))-48;
            return Parametre.CoulueurSymbole(indice);
            else return Parametre.CoulueurSymbole(Integer(TailleMax));
         end if;
      end if;
      return null;

   End Get_Button;

END P_PARAMETRE;

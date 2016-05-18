with Events;				use Events;
with Gtk.Enums;			use Gtk.Enums;
with Gtk.Button;			use Gtk.Button;
with Gtk.Box;				use Gtk.Box;
with gtk.Container;			use gtk.Container;
with Glib.Convert;			use Glib.Convert;
with Gtk.Widget;			use Gtk.Widget;
with Gtk.Menu;			use Gtk.Menu;
with Gtk.Menu_Item;		use Gtk.Menu_Item;
with P_PARAMETRE;			use P_PARAMETRE;
with Gdk.Color;			use Gdk.Color;
with Ada.Text_IO;			use Ada.Text_IO;
with Gtk.Separator_Menu_Item; use Gtk.Separator_Menu_Item;
with P_Panel_Game;			use P_Panel_Game;
with Glib; 				use Glib;
with Gtk.Message_Dialog; 	use Gtk.Message_Dialog;
with Gtk.Dialog; 			use Gtk.Dialog;

package body P_Fenetre is

   Use Events.P_Events_Widget;
   Use Events.P_Events_Button;
   -----------------------
   -- Fenetre_Construct --
   -----------------------

   Procedure Fenetre_Construct(Vue : Gtk_Vbox; Plateau_jeu : boolean:=false)  Is
      box    : Gtk_Vbox;
   Begin
      INIT;
     -- Gtk.Main.Set_Locale;
      Gtk_New(Fenetre.WIN);
      Fenetre.Win.set_title("TIC TAC TOE");
      Gtk_new_Vbox(Fenetre.Container,False,3);
      Fenetre.Container := Vue;
      Fenetre.Menu_Bar := Get_Menu_Bar;
      Gtk_New_Vbox(box,False,0);
      Fenetre.WIN.Add(box);
      if not Plateau_jeu
        then
         Fenetre.WIN.Set_Resizable(Resizable => false);
         Fenetre.Win.Set_Size_Request(Gint(Largeur),Gint(Hauteur));
      else
         Fenetre.Win.Set_Size_Request(810,600);
      end if;

      box.Pack_start(Fenetre.Menu_Bar);
      box.Pack_Start(Fenetre.Container);
      Fenetre.WIN.Set_Position(Win_Pos_Center);

      Events.P_Events.Connect(Fenetre.WIN, "destroy", Close_Fenetre'Access);
      Fenetre.WIN.Modify_Bg(State_Type => State_Normal,
                                   Color      => Parse("#FFFFFF"));

      if not Set_Default_Icon_From_File(Filename => "./media/icon.png")
      then null ;
      end if;

      Fenetre.WIN.show_all;

      gtk.Main.Main;

   Exception
         when Storage_Error => Put_line("Le fichier /media/icon.png est manquant !");

   END Fenetre_Construct;

   -------------------
   -- Set_Container --
   -------------------

   Procedure Set_Container(Container : Gtk_Widget_Record'Class) Is
   Begin
   null;--Fenetre.Container := Container;
   End Set_Container;


   -------------
   -- Get_Win --
   -------------

  Function Get_Win return Gtk_Window Is
   Begin
   	return Fenetre.WIN;
   End Get_Win;

   ------------------
   -- Get_Menu_Bar --
   ------------------

   Function Get_Menu_Bar return Gtk_Menu_Bar Is

      Bar_Menu : Gtk_Menu_Bar;
      Partie   : Gtk_Menu;
      Aide     : Gtk_Menu;
      LabelPartie : Gtk_Menu_Item;
      LabelAide : Gtk_Menu_Item;
      Nouvel_Partie : Gtk_Menu_Item;
      Quittez        : Gtk_Menu_Item;
      Apropos        : Gtk_Menu_Item;
      Help           : Gtk_Menu_Item;
      Separ : Gtk_Separator_Menu_Item;

   Begin
      INIT;
      Gtk_New(Bar_Menu);
      Gtk_New(Partie);
      Gtk_New(Aide);
      Gtk_New(separ);

      --
      Gtk_New(LabelPartie,"Partie");
      Gtk_new(LabelAide,"Aide");
      LabelPartie.Set_Submenu(Partie);
      LabelAide.Set_Submenu(Aide);
      --

      Gtk_New(Nouvel_Partie,"Nouvelle Partie");
      Gtk_New(Quittez,"Quittez");
      Gtk_New(Apropos,"À propos");
      Gtk_New(Help);
      Help.Set_Label("Règles du jeu");

      Partie.Append(Nouvel_Partie);
      Partie.Append(Separ);
      Partie.Append(Quittez);

      Aide.Append(Apropos);
      Aide.Append(separ);
      Aide.Append(Help);

      Bar_Menu.Append(LabelPartie);
      Bar_Menu.Append(LabelAide);

      connect(Help,"activate",Afficher_Aide'Access);
      connect(Apropos,"activate",Afficher_Apropos'Access);
      Connect(Nouvel_Partie,"activate",Events.Nouvel_Partie'Access);
      Connect(Quittez,"activate",Events.Quittez_partie'Access);
      Bar_Menu.Show_All;
    -- Bar_Menu.Append(Quittez);
      return Bar_Menu;
   End Get_Menu_Bar;

   -------------------
   -- Get_Container --
   -------------------

   Function Get_Container return Gtk_Vbox Is
   Begin
      return Fenetre.Container;
   End Get_Container;


end P_Fenetre;

with Ada.Numerics.Discrete_Random;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;

package BODY Partie is

   package SU renames Ada.Strings.Unbounded;
   use type SU.Unbounded_String;

   -----------------------------------------------------------------------------------------------------------
   ---------                                 Coup_Aleatoire                                -------------------
   -----------------------------------------------------------------------------------------------------------
   Procedure Coup_Aleatoire(Un_Plateau: in out Plateaux.plateau; X: out Plateaux.Colonne; Y: out Plateaux.Ligne)is
      Subtype Rand_Range is Integer range 1 .. 9;
      package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
      seed : Rand_Int.Generator;
      Sucess:boolean:=False;
      Index_Cellule_Libre:Rand_Range:=1;
      Indice:Integer;
      Max:Integer;
   begin
      Rand_Int.Reset(seed);
      Indice:= (Integer'(Rand_Int.Random(seed)));
      Max:=9-Plateaux.Get_Nb_Tours(Un_Plateau);
      Indice:=(Indice mod Max)+1;
      for Yo in reverse Plateaux.Ligne
      loop
         if not Sucess then
            for Xo in Plateaux.Colonne
            loop
               If Plateaux.Libre(Un_Plateau,Xo,Yo)then
                  If Index_Cellule_Libre=Indice then
                     X:=Xo;
                     Y:=Yo;
                     Sucess:=true;
                     exit;
                  Else
                     Index_Cellule_Libre:=Index_Cellule_Libre+1;
                  End If;
               End if;
            End loop;
         End if;
      End loop;
   End Coup_Aleatoire;

   -----------------------------------------------------------------------------------------------------------
   ---------                  Fonction Jouer_Coup             HUMAIN                       -------------------
   -----------------------------------------------------------------------------------------------------------

   Procedure Jouer_Coup_Humain(Un_Plateau : in out Plateaux.Plateau;Xo : in Plateaux.Colonne;
                               Yo     : in Plateaux.Ligne ;Un_Symbole: in out Cellules.Symbole) is

   begin
     -- Saisir_Coup(Un_Plateau,Xo,Yo);
      Plateaux.Tracer(Un_Plateau,Xo,Yo,Un_Symbole);
   end Jouer_Coup_Humain;

   -----------------------------------------------------------------------------------------------------------
   ---------                  Fonction Jouer Coup IA            DIFFICILE                  -------------------
   -----------------------------------------------------------------------------------------------------------


  Procedure Jouer_Coup_IA_Difficile(Un_Plateau : in out Plateaux.Plateau;Xo : in out Plateaux.Colonne; Yo:in out Plateaux.Ligne; Un_Symbole: in out Cellules.Symbole) is
      Next:Boolean:=False;
   BEGIN
      for Y in reverse Plateaux.Ligne
      loop
         if not Next then
            for X in Plateaux.Colonne
            loop
               --Ada.Text_IO.Put_Line("Attaque : " & boolean'Image(Plateaux.Libre(Un_Plateau,X,Y)) & " " & boolean'Image(Plateaux.Tester(Un_Plateau,X,Y,Un_Symbole)));
               --Ada.Text_IO.Put_Line("Defense : " & boolean'Image(Plateaux.Libre(Un_Plateau,X,Y)) & " " &  boolean'Image(Plateaux.Tester(Un_Plateau,X,Y,Cellules.Suivant(Un_Symbole))));
               If Plateaux.Libre(Un_Plateau,X,Y)and then  Plateaux.Tester(Un_Plateau,X,Y,Un_Symbole)then --  on regarde si on peut finir la partie
                  --Ada.Text_IO.Put_Line("Attaque : L'IA va jouer : " & X & Y); -- Permet de vérifier la position jouée par l'IA
                  Plateaux.Tracer(Un_Plateau,X,Y,Un_Symbole); -- Si oui, alors on place le pion
                  Xo:=X;Yo:=Y;
                  Next:=True;
                  exit ;
               End if;
            End loop;
         End If;
      End loop;
      for Y in reverse Plateaux.Ligne
      loop
         if not Next then
            for X in Plateaux.Colonne
            loop
               If Plateaux.Libre(Un_Plateau,X,Y)and then  Plateaux.Tester(Un_Plateau,X,Y,Cellules.Suivant(Un_Symbole))then -- ensuite on regarde si on peut empecher l'autre joueur de finir la partie
                  Ada.Text_IO.Put_Line("Defense : L'IA va jouer : " & X & Y); -- Permet de vérifier la position jouée par l'IA
                  Plateaux.Tracer(Un_Plateau,X,Y,Un_Symbole); -- Si oui, alors on place le pion
                  Xo := X;
                  Yo := Y;
                  Next:=True;
                  exit ;
               End if;
            End loop;
         End If;
      End loop;
      If not Next then
            If(Plateaux.Libre(Un_Plateau,'2','2')) then
                Plateaux.Tracer(Un_Plateau,'2','2',Un_Symbole); -- Si oui, alors on place le pion
                Xo:='2';Yo:='2';
           Elsif (Plateaux.Libre(Un_Plateau,'1','1')) then
                Plateaux.Tracer(Un_Plateau,'1','1',Un_Symbole); -- Si oui, alors on place le pion
                Xo:='1';Yo:='1';
           Elsif (Plateaux.Libre(Un_Plateau,'1','3')) then
                Plateaux.Tracer(Un_Plateau,'1','3',Un_Symbole); -- Si oui, alors on place le pion
                Xo:='1';Yo:='3';
           Elsif (Plateaux.Libre(Un_Plateau,'3','1')) then
                Plateaux.Tracer(Un_Plateau,'3','1',Un_Symbole); -- Si oui, alors on place le pion
                Xo:='3';Yo:='1';
           Elsif (Plateaux.Libre(Un_Plateau,'3','3')) then
                Plateaux.Tracer(Un_Plateau,'3','3',Un_Symbole); -- Si oui, alors on place le pion
                Xo:='3';Yo:='3';
          Else
         Ada.Text_IO.Put_Line("Random");

         Jouer_Coup_IA_Facile(Un_Plateau,Xo,Yo,Un_Symbole);
      End if;
     End if;
   END Jouer_Coup_IA_Difficile;


   -----------------------------------------------------------------------------------------------------------
   ---------                  Fonction Jouer Coup IA            MOYEN                      -------------------
   -----------------------------------------------------------------------------------------------------------

   Procedure Jouer_Coup_IA_Moyen(Un_Plateau : in out Plateaux.Plateau;Xo : out Plateaux.Colonne; Yo: out Plateaux.Ligne; Un_Symbole: in out Cellules.Symbole) is
      Type Rand_Range is range 1..2;
      package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
      seed : Rand_Int.Generator;
      Choix : Rand_Range;
   begin
      Rand_Int.Reset(seed);
      Choix := Rand_Int.Random(seed);
      If (Choix=1) then
         Jouer_Coup_IA_Facile(Un_Plateau,Xo,Yo,Un_Symbole);
      Else
         Jouer_Coup_IA_Difficile(Un_Plateau,Xo,Yo,Un_Symbole);
      End if;
     end Jouer_Coup_IA_Moyen;

   -----------------------------------------------------------------------------------------------------------
   ---------                   Fonction Jouer Coup IA        FACILE                        -------------------
   -----------------------------------------------------------------------------------------------------------

   Procedure Jouer_Coup_IA_Facile(Un_Plateau : in out Plateaux.Plateau;Xo : out Plateaux.Colonne; Yo: out Plateaux.Ligne; Un_Symbole: in out Cellules.Symbole) is
   Begin
      Partie.Coup_Aleatoire(Un_Plateau,Xo,Yo);
      Plateaux.Tracer(Un_Plateau,Xo,Yo,Un_Symbole);
   End Jouer_Coup_IA_Facile;
   -----------------------------------------------------------------------------------------------------------
   ---------                  Fonction pour saisir les coups (Terminal)                    -------------------
   -----------------------------------------------------------------------------------------------------------


   Procedure Saisir_Coup(Un_Plateau: in out Plateaux.plateau; X: out Plateaux.Colonne; Y: out Plateaux.Ligne) is
      Succes : Boolean := False;
      Xo:Plateaux.Colonne;Yo:Plateaux.Ligne;
   Begin

      Ada.Text_IO.Put_Line("Fonction de saisie des coups");
      While Succes=False Loop
         Begin
            Loop -- Boucle demandant de saisir la ligne / Redemande si saisie incorrecte
               begin
                  Ada.Text_Io.Put ("Colonne desiree ? : "); Ada.Text_Io.Get (Xo); exit;
               exception
                  when others =>Ada.Text_Io.Put_Line ("Veuillez saisir un chiffre entre A et C");
               End;
            End Loop;

            Loop -- Boucle demandant de saisir la colonne / Redemande si saisie incorrecte
               begin
                  Ada.Text_Io.Put ("Ligne desiree ?  : "); Ada.Text_Io.Get (Yo);Ada.Text_IO.Put_Line(""); exit;
               exception
                  when others => Ada.Text_Io.Put_Line ("Veuillez saisir une Lettre entre 1 et 3");
               End;
            End Loop;
            --Ada.Text_Io.Put_Line ("Xo : " & Xo & "Yo : " & Yo);

            If Plateaux.Libre(Un_Plateau,Xo,Yo) Then -- Si la case est libre la saisie est correcte, on sort de la boucle
               Succes:= true;
            Else
               Ada.Text_Io.Put_Line ("Cette position a deja ete jouee.");
            End If;
         End;
      End Loop;
      X:=Xo;Y:=Yo;
   End Saisir_Coup;

   -----------------------------------------------------------------------------------------------------------
   ---------                             Fonction Jouer_Coup                               -------------------
   -----------------------------------------------------------------------------------------------------------

   Procedure Jouer_Coup(Grille : in out Plateaux.Plateau;Xo : in out Plateaux.Colonne;
                        Yo  : in out Plateaux.Ligne;J : Joueurs.Joueur; Fini: out Boolean) is
      Sbl:Cellules.Symbole;
      Use Joueurs;
      Profondeur :Natural :=9;
   begin
      Sbl:=Joueurs.Get_Symbole(J);
      If Joueurs.Get_Genre(J) =Joueurs.Genre'(Humain) Then
         Partie.Jouer_Coup_Humain(Grille,Xo,Yo,Sbl);
      ElsIf Joueurs.Get_Genre(J) =Joueurs.Genre'(Ordinateur_Facile) Then
         Partie.Jouer_Coup_IA_Facile(Grille,Xo,Yo,Sbl);
      Elsif Joueurs.Get_Genre(J) =Joueurs.Genre'(Ordinateur_Moyen) Then
         Partie.Jouer_Coup_IA_Moyen(Grille,Xo,Yo,Sbl);
      ElsIf Joueurs.Get_Genre(J) =Joueurs.Genre'(Ordinateur_Difficile) Then
        Partie.Jouer_Coup_IA_Difficile(Grille,Xo,Yo,Sbl);

      End if;
      Fini:=A_Gagner(Grille,sbl);
   end Jouer_Coup;

   -------------------------------------------------------------------------------
   ------                        AFFICHER                                ---------
   -------------------------------------------------------------------------------
   procedure Afficher(Un_Plateau : Plateaux.Plateau) is

      function Image (Un_Symbole : Cellules.Symbole) return Character is

         S : constant String (1 .. 3) := Cellules.Symbole'Image(Un_Symbole);

      begin  return S (2); end;

   begin
      for Y in reverse Plateaux.Ligne
      loop
         Ada.Text_IO.Put (Y);
         Ada.Text_IO.Put (" |");
         for X in Plateaux.Colonne
         loop
            if Plateaux.Libre(Un_Plateau, X, Y) then
               Ada.Text_IO.Put (" |");
            else
               Ada.Text_IO.Put (Image(Plateaux.Occupant(Un_Plateau, X, Y))&"|");
            end if;
         end loop;
         ada.Text_IO.New_Line;
      end loop;
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put (' '); for X in Plateaux.Colonne
      loop Ada.Text_IO.Put (' '); Ada.Text_IO.Put (X &' '); end loop; Ada.Text_IO.New_Line;
   end Afficher;

   -----------------------------------------------------------------------------
   --------                      Jouer Partie                         ----------
   -----------------------------------------------------------------------------



   Procedure Jouer_Partie(J1: in Joueurs.Joueur; J2: in Joueurs.Joueur) is
      Grille:Plateaux.Plateau;
      Xo    : Plateaux.Colonne;
      Yo:Plateaux.Ligne;

      Sbl:Cellules.Symbole;
      Fini:Boolean:=False;
      JoueurCourant:SU.Unbounded_String;
      Use Joueurs;
   Begin


      Ada.Text_IO.Put_Line("Lancement de Partie");
      Ada.Text_Io.Put("Choix du signe :"); Sbl:= Joueurs.Get_Symbole(J1);
      Ada.Text_IO.Put_Line(" ");
      while not Plateaux.Plein(Grille) and then not Fini loop-- On joue jusqu'a ce qu'un joueur gagne ou que la grille soit pleine.
         Begin
            Ada.Text_IO.Put_Line("Tour n" & Natural'Image(Plateaux.Get_Nb_Tours(Grille)) & " - " & Joueurs.Get_Nom(J1));
            Partie.Afficher(Grille);
            Partie.Jouer_Coup(Grille,Xo,Yo,J1,Fini);
            JoueurCourant:=SU.To_Unbounded_String(Joueurs.Get_Nom(J1));
            if not Plateaux.Plein(Grille) and then not Fini then
               Ada.Text_IO.Put_Line("Tour n" & Natural'Image(Plateaux.Get_Nb_Tours(Grille)) & " - " & Joueurs.Get_Nom(J2));
               Partie.Afficher(Grille);
               Partie.Jouer_Coup(Grille,Xo,Yo,J2,Fini);
               JoueurCourant:=SU.To_Unbounded_String(Joueurs.Get_Nom(J2));
            End if;
         End;
      End Loop;

      Partie.Afficher(Grille);

      If(Fini) Then -- Si un joueur a gagne
         Ada.Text_IO.Put_Line( Su.To_String(JoueurCourant) & " gagne la partie !");
      Else --sinon partie nulle
         Ada.Text_IO.Put_Line(" Partie Nulle !");
      End If;

   End Jouer_Partie;

   ------------------------
   ----Set_Grille_Jeu--
   -------------------------

   Procedure Set_Grille_Jeu(Game:in out T_Game;Plateau_Jeu:Plateau) Is
   Begin
      Game.Grille_Jeu := Plateau_Jeu;
   End Set_Grille_Jeu;

   ---------------------------
   -----Set_Joueur------
   --------------------------

   Procedure Set_Joueur(Game:in out T_Game;J:joueur;Num:Positive) Is
   Begin
      if Num = Partie.Joueur1
      then Game.Joueur1 := j;
      elsif Num = Partie.Joueur2
      then Game.Joueur2 := j;
      else
         raise Not_Joueur;
      end if;
   End Set_Joueur;

   ---------------------------
   ------Set_Score_Joueur----
   -------------------------------

   Procedure Set_Score_Joueur(Game:in out T_Game;Num:Positive;Score:Natural) Is
   Begin
      if Num = Partie.Joueur1
      then Game.Score_joueur1 := Score;
      elsif Num = Partie.Joueur2
      then Game.Score_Joueur2 := Score;
      elsif Num =3
      then Game.Match_nul := Score;
      else
         raise Constraint_Error;
      end if;

   End Set_Score_Joueur;

   ------------------------
   ----Get_Current_Joueur
   ---------------------------

   Procedure Set_Current_Joueur(Game:in out T_Game;Current_Joueur:Joueur) Is
   Begin
     Game.Current_Joueur := Current_Joueur;
   End Set_Current_Joueur;


   -----------------------------------------
   ------Construct_Game-----------
   ----------------------------------------

   Function Construct_Game(Joueur1,Joueur2  :Joueur; Grille_jeu:Plateau;
                           Couleur1,Couleur2:String) return T_Game Is
      Game : T_Game;
   Begin
      Set_Grille_Jeu(Game,Grille_jeu);
      Set_Joueur(Game => Game,
                 J    => Joueur1,
                 Num  => Partie.Joueur1);
      Set_Joueur(
                 Game => Game,
                 J    => Joueur2,
                 Num  => Partie.Joueur2);
      Set_Current_Joueur(Game,Current_Joueur => Joueur1);
      Set_Score_Joueur(Game  => Game,
                       Num   => Partie.Joueur1,
                       Score => 0);
      Set_Score_Joueur(Game  => Game,
                       Num   => Partie.Joueur2,
                       Score => 0);
      Set_Couleur_Pion(Game    => Game,
                       Num     => Partie.Joueur1,
                       Couleur => Couleur1);
      Set_Couleur_Pion(Game    => Game,
                       Num     => Partie.Joueur2,
                       Couleur => Couleur2);
      Game.Match_nul := 0;
      return Game;
   End Construct_Game;

   --------------------------
   ------Get_Joueur----
   -------------------------

   Function Get_Joueur(Game:T_Game; Num : Positive) Return Joueurs.Joueur
   Is Begin
      if Num = Partie.Joueur1
      then
         return Game.Joueur1;
      elsif Num = Partie.Joueur2
      then return Game.Joueur2;
      else
         raise Not_Joueur;
      end if;
   End Get_Joueur;

   --------------------------
   ---Get_Score----------
   ------------------------

   Function Get_Score(Game : T_Game;Num : Positive) return Natural Is
   Begin
       if Num = Partie.Joueur1
      then return Game.Score_joueur1;
      elsif Num = Partie.Joueur2
      then return Game.Score_Joueur2;
      elsif Num = 3
      then return Game.Match_nul;
      else
         raise Not_Joueur;
      end if;
   End Get_Score;

   --------------------------
   ------Get_Current_Joueur
   -----------------------------------

   Function Get_Current_Joueur(Game : T_Game) Return Joueur Is
   Begin
      return Game.Current_Joueur;
   End Get_Current_Joueur;

   ------------------------------
   -----Get_Grille_jeu-----
   ------------------------------

   Function Get_Grille_Jeu(Game:T_Game) Return Plateaux.Plateau Is
   Begin
	return Game.Grille_Jeu;
   end Get_Grille_Jeu;

   -------------------------
   ---Set_Couleur_Pion
   ---------------------------

   Procedure Set_Couleur_Pion(Game : in out T_Game;Num : Natural;Couleur:String) Is
   Begin
      if Num = Partie.Joueur1
      then Game.Couleur_Pion1 := Couleur;
      elsif Num = Partie.Joueur2
      then Game.Couleur_Pion2 := Couleur;
      else
         Raise Constraint_Error;
      end if;

   End Set_Couleur_Pion;

   -------------------------------
   ------Get_Couleur_Pion---
   -------------------------------

   Function Get_Couleur_Pion(Game : T_Game) return String Is
   Begin
      if Game.Current_Joueur = Game.Joueur1
      then return Game.Couleur_Pion1;
      else
         return Game.Couleur_Pion2;
      end if;
   End Get_Couleur_Pion;

   --------------------------------
   --------Organise_Game--
   --------------------------------

   procedure Organise_Game(Jeu : in out T_Game) Is
   Begin
      If Jeu.Current_Joueur = Jeu.Joueur1
      then Set_Current_Joueur(Jeu,Jeu.Joueur2);
      else
         Set_Current_Joueur(Jeu, Jeu.Joueur1);
      end if;
   End Organise_Game;

   -----------------------------
   ------Joueur_Case------
   ----------------------------

   Procedure Jouer_Case(Game     : in out T_Game;
                        Colonne : in out Plateaux.Colonne;
                        Ligne : in out Plateaux.Ligne;Resultat:out Positive) Is
      bool : Boolean;
   Begin
      Partie.Jouer_Coup(Grille => Game.Grille_Jeu,
                        Xo     => Colonne,
                        Yo     => Ligne,
                        J      => Game.Current_Joueur,
                        Fini   => bool);

      --fini:=false;
      if Plateaux.A_Gagner( Game.Grille_Jeu,Get_Symbole(game.Current_Joueur))
      then put("Victoire");
      end if;


      if bool=True
      then
         Resultat :=1;
         if Get_Symbole(Game.Current_Joueur) = Get_Symbole(Game.Joueur1)
         then Set_Score_Joueur(Game  => Game,
                               Num   => Partie.Joueur1,
                               Score => Game.Score_joueur1+1);
         else
            Set_Score_Joueur(Game  => Game,
                               Num   => Partie.Joueur2,
                               Score => Game.Score_Joueur2+1);
         end if;
         Partie.Set_Partie_Finie(Game         => Game,
                              Partie_Finie => True);

      elsif Plateaux.Plein(Game.Grille_Jeu)=True
      then Resultat := 2;
         Set_Score_Joueur(Game  => Game,
                          Num   => 3,
                          Score => Game.Match_nul+1);
         Partie.Set_Partie_Finie(Game         => Game,
                              Partie_Finie => True);
      end if;

   End Jouer_Case;

   -------------------------
   ------Set_Partie_Finie---
   -------------------------------

   Procedure Set_Partie_Finie(Game : in out T_Game;Partie_Finie : in Boolean) Is
   Begin
      Game.Partie_Finie := Partie_Finie;
   End Set_Partie_Finie;

   ---------------------------------
   --------Get_Partie_Finie---
   ---------------------------------

   Function Get_Partie_Finie(Game : T_Game)
                              return boolean is
   Begin
      return Game.Partie_Finie;
   end Get_Partie_Finie;

Function get_Symbole(Game : T_Game;Colonne:Plateaux.Colonne;Ligne : Plateaux.Ligne)
                     return Cellules.Symbole Is
   Begin
      if not Plateaux.Libre(Game.Grille_Jeu,Colonne,Ligne)
      then return Occupant(Game.Grille_Jeu,Colonne,Ligne);
      else
        raise Constraint_Error;
      end if;
   End get_Symbole;

end Partie;

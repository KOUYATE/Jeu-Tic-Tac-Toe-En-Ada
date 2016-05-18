With Ada.Text_IO;
use Ada.Text_IO;
package body Plateaux is

   -----------

   -- Libre --

   -----------

   function Libre(Un_Plateau: plateau; X: colonne; Y: ligne)return Boolean is
   begin
      return Cellules.Libre(Un_Plateau.Un_Contenu (Y, X));
   end Libre;

   --------------

   -- Occupant --

   --------------

   function Occupant(Un_Plateau: Plateau; X: Colonne; Y: Ligne)return cellules.Symbole is
   begin
      return Cellules.Occupant(Un_Plateau.Un_Contenu (Y,X));
   end Occupant;

   --------------

   -- Occupant --

   --------------

   function Occupe_Par(Un_Plateau: Plateau; X: Colonne; Y: Ligne;Un_Symbole: Cellules.Symbole) return Boolean is
      function "=" (X, Y : Cellules.Symbole) return Boolean renames Cellules."=";
   begin
      return (not Cellules.Libre(Un_Plateau.Un_Contenu (Y, X)))
        and then (Cellules.Occupant(Un_Plateau.Un_Contenu (Y, X))= Un_Symbole);
   end Occupe_Par;

   ------------

   -- Tracer --

   ------------

   procedure Tracer(Un_Plateau: in out Plateau;X: in Colonne;Y: in Ligne;Un_Symbole: in Cellules.Symbole)is
   begin

      Cellules.Tracer(Un_Plateau.Un_Contenu (Y,X), Un_Symbole);
      Un_Plateau.Nombre_Coups := Un_Plateau.Nombre_Coups + 1;
   end Tracer;

   ------------

   -- Tester --

   ------------

   function Voisin_Colonne (X : Colonne) return Colonne is
   begin
      if X = Colonne'Last then
         return Colonne'First;
      else return Colonne'Succ (X); end if;
   end Voisin_Colonne;

   -----------------------------

   function Voisin_Ligne (Y : Ligne) return Ligne is
   begin
      if Y = ligne'Last then
         return ligne'First;
      else return Ligne'Succ (Y);
      end if;
   end Voisin_Ligne;

   --------------------------------

   function Tester(Un_Plateau: Plateau; X: Colonne; Y: Ligne; Un_Symbole: in Cellules.Symbole) return Boolean is
      function "=" (X, Y : Cellules.Symbole) return boolean renames cellules."=";
      use Cellules;

   begin
      return (Occupe_Par(Un_Plateau, Voisin_Colonne(X), Y, Un_Symbole) and then

                Occupe_Par(Un_Plateau, Voisin_Colonne(Voisin_Colonne(X)), Y, Un_Symbole)) or else

        (Occupe_Par(Un_Plateau, X, Voisin_Ligne(Y), Un_Symbole)

         and then Occupe_Par(Un_Plateau, X, Voisin_Ligne(Voisin_Ligne(Y)), Un_Symbole))

        or else

          (((abs (Colonne'Pos (X) - Ligne'Pos (Y)) /= 1) and then

             Occupe_Par(Un_Plateau, Voisin_Colonne(X), Voisin_Ligne(Y), Un_Symbole) and then

             Occupe_Par(Un_Plateau, Voisin_Colonne(Voisin_Colonne(X)), Voisin_Ligne(Voisin_Ligne(Y)), Un_Symbole)))
       or else

          (((abs (Colonne'Pos (X) - Ligne'Pos (Y)) /= 1) and then

             Occupe_Par(Un_Plateau, Voisin_Colonne(X), Voisin_Ligne(Voisin_Ligne(Y)), Un_Symbole) and then

             Occupe_Par(Un_Plateau, Voisin_Colonne(Voisin_Colonne(X)), Voisin_Ligne(Y), Un_Symbole)));

   end Tester;

   -----------

   -- Plein --

   -----------



   function Plein(Un_Plateau: Plateau) return Boolean is
   begin
      return  Un_Plateau.Nombre_Coups = Numero_Coup'Last;
   end Plein;

   ---------------------
   --   Get_Nb_Tours  --
   ---------------------
   function Get_Nb_Tours(Un_Plateau: Plateau) return Integer is
   begin
      return Un_Plateau.Nombre_Coups;
   end Get_Nb_Tours;

    Function A_Gagner(Un_Plateau : Plateau; Pion:Cellules.Symbole) return Boolean Is
   Begin
      return (Occupe_Par(Un_Plateau,'1','1',Pion) and Occupe_Par(Un_Plateau,'2','1',Pion) and
                Occupe_Par(Un_Plateau,'3','1',Pion))
        or else (Occupe_Par(Un_Plateau,'1','2',Pion) and Occupe_Par(Un_Plateau,'2','2',Pion) and
                   Occupe_Par(Un_Plateau,'3','2',Pion))
        or else (Occupe_Par(Un_Plateau,'1','3',Pion) and Occupe_Par(Un_Plateau,'2','3',Pion) and
                   Occupe_Par(Un_Plateau,'3','3',Pion))
        or else (Occupe_Par(Un_Plateau,'1','1',Pion) and Occupe_Par(Un_Plateau,'1','2',Pion) and
                   Occupe_Par(Un_Plateau,'1','3',Pion))
        or else (Occupe_Par(Un_Plateau,'2','1',Pion) and Occupe_Par(Un_Plateau,'2','2',Pion) and
                   Occupe_Par(Un_Plateau,'2','3',Pion))
        or else (Occupe_Par(Un_Plateau,'3','1',Pion) and Occupe_Par(Un_Plateau,'3','2',Pion) and
                   Occupe_Par(Un_Plateau,'3','3',Pion))
        or else (Occupe_Par(Un_Plateau,'1','1',Pion) and Occupe_Par(Un_Plateau,'2','2',Pion) and
                   Occupe_Par(Un_Plateau,'3','3',Pion))
        or else (Occupe_Par(Un_Plateau,'3','1',Pion) and Occupe_Par(Un_Plateau,'2','2',Pion) and
                   Occupe_Par(Un_Plateau,'1','3',Pion));
   End A_Gagner;

   Procedure Placer_Cellules(Un_Plateau : out Plateau; X:Colonne;
                             Y : Ligne;
                             cellule : Cellules.Cellule) Is
   Begin
      Un_Plateau.Un_Contenu(Y,X) := Cellule;
      Un_Plateau.Nombre_Coups := Un_Plateau.Nombre_Coups -1;
   End Placer_Cellules;


end Plateaux;



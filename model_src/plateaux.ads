with Cellules;
with Joueurs;
package Plateaux
is

   subtype Ligne is Character range '1' .. '3';

   subtype Colonne  is Character range '1' .. '3';

   Suivant : constant array (Cellules.Symbole) of Cellules.Symbole:= ('O' => 'X', 'X' => 'O');

   type Plateau is private;

   function Libre(Un_Plateau: plateau; X: colonne; Y: ligne) return Boolean;

   function Occupant(Un_Plateau: Plateau; X: Colonne; Y: Ligne) return Cellules.Symbole;

   function Occupe_Par(Un_Plateau: Plateau; X: Colonne; Y: Ligne; Un_Symbole: Cellules.Symbole) return Boolean;

   procedure Tracer(Un_Plateau: in out Plateau; X: in Colonne; Y: in Ligne; Un_Symbole: in Cellules.Symbole);

   function Tester(Un_Plateau: Plateau; X: Colonne; Y: Ligne; Un_Symbole: in Cellules.Symbole) return Boolean;

   function Plein(Un_Plateau: Plateau) return Boolean;

   function Get_Nb_Tours(Un_Plateau: Plateau) return Integer;

   Function A_Gagner(Un_Plateau : Plateau; Pion:Cellules.Symbole) return Boolean;
   Procedure Placer_Cellules(Un_Plateau : out Plateau; X:Colonne;
                             Y : Ligne;
                             cellule : Cellules.Cellule);

private

   type Contenu is array (Ligne, Colonne) of Cellules.Cellule;

   subtype Numero_Coup is Natural range 0 .. 9;

   type Plateau is record
      Nombre_Coups : Numero_Coup:= 0;
      Un_Contenu : Contenu;
   end record;
end plateaux;


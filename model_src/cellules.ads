package Cellules
is

   subtype Colonne  is Character range '1' .. '3';

   subtype Ligne is Character range '1' .. '3';

type Symbole is ('O','X');
Suivant : constant array (Cellules.Symbole) of Cellules.Symbole:= ('O' => 'X', 'X' => 'O');
   type Cellule
   is private;

   function Libre(Une_Cellule: Cellule) return Boolean;

   Cellule_Libre : exception;

   function Occupant(Une_Cellule: Cellule) return Symbole;

   Cellule_Occupee : exception;

   procedure Tracer(Une_Cellule: in out Cellule; Un_Symbole: in Symbole);

private

   type Cellule
     (Occupee: Boolean := False) is record
      case Occupee is
         when False => null;
         when true => Un_Symbole : Symbole;
      end case;

   end record;

end Cellules;


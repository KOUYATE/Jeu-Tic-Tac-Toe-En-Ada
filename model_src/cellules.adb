
package body Cellules
is

   -----------

   -- Libre --

   -----------

   function Libre(Une_Cellule: Cellule) return Boolean is

   begin

      return not Une_Cellule.Occupee;

   end Libre;

   --------------

   -- Occupant --

   --------------

   function Occupant(Une_Cellule: Cellule) return Symbole
   is

   begin

      if Une_Cellule.Occupee then return Une_Cellule.Un_Symbole;
      else raise Cellule_Libre;
      end if;

   end Occupant;



   ------------

   -- Tracer --

   ------------



   procedure Tracer(Une_Cellule: in out Cellule; Un_Symbole: in Symbole) is
   begin
      if  Une_Cellule.Occupee then raise Cellule_Occupee;
      else Une_Cellule:= (Occupee => True, Un_Symbole => Un_Symbole);
      end if;

   end Tracer;

end Cellules;


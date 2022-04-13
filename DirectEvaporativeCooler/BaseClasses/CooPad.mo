within DirectEvaporativeCooler.BaseClasses;
type CooPad = enumeration(
    Lumped
         "Lumped model(EnergyPlus)",
    PhysicsBased
          "Physics-based")
  "Specifies the type of cooling pad based on the level of details : 1. Lumped  2.Physics-based";

within DirectEvaporativeCooler.Records;
record EvaporativePadMedia
  "List of available meadia options in the DEC model"

  parameter Real CelDek_Cellulose "Cooling pad made of Cellulose";
  parameter Real GlasDek_Glassfiber "Cooling pad made of glass fiber";
  parameter Real Aspen "Cooling pad made of Aspen fibers";
  parameter Real Paper "Cooling pad made of paper sheets";
  parameter Real CoconutCoir "Cooling pad made of coconut coir";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EvaporativePadMedia;

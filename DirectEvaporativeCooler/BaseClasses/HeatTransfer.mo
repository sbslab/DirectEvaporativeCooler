within DirectEvaporativeCooler.BaseClasses;
block HeatTransfer

  //parameters
  parameter Modelica.SIunits.Area A "Area of the cooling pad";
  Modelica.SIunits.SpecificHeatCapacity Cpa = 1000 " Specific heat of air J/kg K";

  Modelica.Blocks.Interfaces.RealInput hc "Heat transfer coefficient"
   annotation (Placement(transformation(extent={{-146,76},{-100,122}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-50,-140})));
  Modelica.Blocks.Interfaces.RealInput ma "mass flow arte of air"
    annotation (Placement(transformation(extent={{-148,-4},{-100,44}}),iconTransformation(extent={{-140,4},{-100,44}})));
  Modelica.Blocks.Interfaces.RealInput Tdb_in "Inlet drybulb temperature"
   annotation (Placement(transformation(extent={{-146,38},{-100,84}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-50,140})));
  Modelica.Blocks.Interfaces.RealInput Tdb_ou "Outlet drybulb temperature"
    annotation (Placement(transformation(extent={{-148,-68},{-100,-20}}), iconTransformation(extent={{-140,-60},{-100,
            -20}})));
  Modelica.Blocks.Interfaces.RealInput w_in "Inlet humidity ratio"
    annotation (Placement(transformation(extent={{-148,-44},{-100,4}}),iconTransformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput w_ou "Outlet humidity ratio"
    annotation (Placement(transformation(extent={{-148,-124},{-100,-76}}), iconTransformation(extent={{-140,-116},{
            -100,-76}})));
  Modelica.Blocks.Interfaces.RealOutput Q_total "Total heat transfer"
    annotation (Placement(transformation(extent={{120,-14},{148,14}}), iconTransformation(extent={{120,-14},{148,14}})));
  Modelica.Blocks.Interfaces.RealOutput Q_latent "Latent heat transfer"
    annotation (Placement(transformation(extent={{120,-74},{148,-46}}), iconTransformation(extent={{120,-74},{148,-46}})));

  Modelica.Blocks.Interfaces.RealOutput Q_sensible "sensible heat transfer"
    annotation (Placement(transformation(extent={{120,46},{146,72}}), iconTransformation(extent={{120,46},{146,72}})));



equation
  Q_sensible = ma*Cpa*(Tdb_ou - Tdb_in);
  Q_latent = Buildings.Utilities.Psychrometrics.Constants.h_fg*ma*(w_ou - w_in);
  Q_total = Q_sensible + Q_latent;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{120,120}})),
    defaultComponentName="heaTra",
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end HeatTransfer;

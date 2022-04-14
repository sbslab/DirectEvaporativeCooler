within DirectEvaporativeCooler.BaseClasses;
block HeatTransfer

  //parameters
  parameter Modelica.SIunits.Area A "Area of the cooling pad";

  Modelica.Blocks.Interfaces.RealInput hc "Heat transfer coefficient"
   annotation (Placement(transformation(extent={{-140,80},{-100,120}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-50,-140})));
  Modelica.Blocks.Interfaces.RealInput hm "mass transfer coefficient"
    annotation (Placement(transformation(extent={{-148,2},{-100,50}}), iconTransformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealInput Tdb_in "Inlet drybulb temperature"
   annotation (Placement(transformation(extent={{-140,40},{-100,80}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-50,140})));
  Modelica.Blocks.Interfaces.RealInput Tdb_ou "Outlet drybulb temperature"
    annotation (Placement(transformation(extent={{-148,-58},{-100,-10}}), iconTransformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput w_in "Inlet humidity ratio"
    annotation (Placement(transformation(extent={{-140,-22},{-100,18}}),
                                                                       iconTransformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput w_ou "Outlet humidity ratio"
    annotation (Placement(transformation(extent={{-148,-118},{-100,-70}}), iconTransformation(extent={{-140,-110},{-100,-70}})));
  Modelica.Blocks.Interfaces.RealOutput Q_total "Total heat transfer"
    annotation (Placement(transformation(extent={{120,-14},{148,14}}), iconTransformation(extent={{120,-14},{148,14}})));
  Modelica.Blocks.Interfaces.RealOutput Q_latent "Latent heat transfer"
    annotation (Placement(transformation(extent={{120,-74},{148,-46}}), iconTransformation(extent={{120,-74},{148,-46}})));

  Modelica.Blocks.Interfaces.RealOutput Q_sensible "sensible heat transfer"
    annotation (Placement(transformation(extent={{120,46},{146,72}}), iconTransformation(extent={{120,46},{146,72}})));

equation
  Q_sensible = hc*A*(Tdb_ou - Tdb_in);
  Q_latent = Buildings.Utilities.Psychrometrics.Constants.h_fg*hm*A*(w_ou - w_in);
  Q_total = Q_sensible + Q_latent;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{120,120}})),
    defaultComponentName="heaTra",
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end HeatTransfer;

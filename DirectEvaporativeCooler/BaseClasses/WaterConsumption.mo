within DirectEvaporativeCooler.BaseClasses;
block WaterConsumption

  //Parameters
  Real m_drift "Mass flow rate of water due to drift losses";
  Real m_blo " Mass flow rate of water due to blowdown";
  Real rhoW=1 "Density of water (kg/m3)";
  parameter Real f_drift=1 "Drift fraction";
  parameter Real rCon=1 "Ratio of solids in blowdown water";

  //Real input and outpu
  Modelica.Blocks.Interfaces.RealInput m_a "mass flow rate of the air (kg/s)"
    annotation (Placement(transformation(extent={{-114,38},{-74,78}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput w_in "Humidity ratio of the inlet water (kg/kg)"
    annotation (Placement(transformation(extent={{-114,-16},{-74,24}}), iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput w_ou "Humidity ratio of the outlet water(kg/kg)"
    annotation (Placement(transformation(extent={{-114,10},{-74,50}}), iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput V_eva "evaporatived water consumption in m3/s"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={114,40})));
  Modelica.Blocks.Interfaces.RealOutput V_tot "Total volume of water consumed"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}}), iconTransformation(extent={{100,-54},{128,-26}})));

equation
  V_eva = (m_a*abs(w_in - w_ou))/rhoW;
  m_drift = V_eva*f_drift;
  m_blo = (V_eva/(rCon - 1)) - m_drift;
  V_tot = V_eva + m_drift + m_blo;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    defaultComponentName="watCon",
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end WaterConsumption;

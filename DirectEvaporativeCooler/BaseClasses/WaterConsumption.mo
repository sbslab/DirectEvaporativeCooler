within DirectEvaporativeCooler.BaseClasses;
block WaterConsumption

  //Parameters
  Real V_drift "Volume flow rate of water due to drift losses (m3/s)";
  Real V_blo " Volume flow rate of water due to blowdown";
  Real V_eva "evaporatived water consumption in m3/s";
  Real V_tot "Total volume of water consumed";

  Real rhoW=1000 "Density of water (kg/m3)";
  parameter Real f_drift=1 "Drift fraction";
  parameter Real rCon=1 "Ratio of solids in blowdown water";

  //Real input and outpu
  Modelica.Blocks.Interfaces.RealInput m_a "mass flow rate of the air (kg/s)"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput w_in "Humidity ratio of the inlet water (kg/kg)"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
                                                                        iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput w_ou "Humidity ratio of the outlet water(kg/kg)"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
                                                                       iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput m_eva "evaporatived water consumption in m3/s"
    annotation (Placement(transformation(extent={{100,10},{120,30}}),  iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={114,40})));
  Modelica.Blocks.Interfaces.RealOutput m_tot "Total volume of water consumed"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}}), iconTransformation(extent={{100,-54},{128,-26}})));

equation
  V_eva = (m_a*(w_ou - w_in))/rhoW;
  V_drift = V_eva*f_drift;
  V_blo = (V_eva/(rCon - 1)) - V_drift;
  V_tot = V_eva + V_drift + V_blo;
  m_eva = V_eva * rhoW;
  m_tot = V_tot * rhoW;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    defaultComponentName="watCon",
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end WaterConsumption;

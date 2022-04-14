within DirectEvaporativeCooler.Examples;
model DirectEvaporativeCoolerPreCooling
  extends Modelica.Icons.Example;

  package MediumWater = Buildings.Media.Water "Water medium";
  package MediumAir = Buildings.Media.Air "Air medium";

Modelica.SIunits.MassFlowRate mW_flow_nominal = 1 "Nominal mass flow rate on water side";
Modelica.SIunits.MassFlowRate mA_flow_nominal= 1  "Nominal mass flow rate on air side";

Modelica.SIunits.PressureDifference dpW_nominal = 10000 "Nominal pressure drop on the water side";
Modelica.SIunits.PressureDifference dpA_nominal = 10000  "Nominal pressure drop on the air side";
Modelica.SIunits.PressureDifference dpD_nominal = 10000 "Nominal pressure drop across the duct";

  ComponentModels.PhysicsBased cooPad(redeclare package Medium1 = MediumAir, redeclare package
              Medium2 =
        MediumWater)                  annotation (Placement(transformation(extent={{-40,-16},{-20,4}})));
  Buildings.Fluid.HeatExchangers.SensibleCooler_T coo(redeclare package Medium = MediumAir)
                                                      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Buildings.Fluid.Movers.SpeedControlled_y fan(redeclare package Medium = MediumAir)
                                               annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum(redeclare package
      Medium =                                                                         MediumAir)
                                                            annotation (Placement(transformation(extent={{8,-6},{20,6}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumAir)
                                                    annotation (Placement(transformation(extent={{-12,-6},{0,6}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium2,
    use_Xi_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Buildings.Fluid.Sources.Boundary_pT sou1(
    redeclare package Medium = MediumAir,
    use_Xi_in=false,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  Buildings.Fluid.Sources.Boundary_pT sinWat(redeclare package Medium =
        MediumWater,                                                                 nPorts=1) annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
  Buildings.Fluid.Sources.Boundary_pT souWat(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  Buildings.Fluid.Movers.SpeedControlled_y pum(redeclare package Medium =
        MediumWater,                                                                   addPowerToMedium=false)
    annotation (Placement(transformation(extent={{18,-30},{0,-50}})));
  Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum1(redeclare package
      Medium =                                                                          MediumAir)
                                                             annotation (Placement(transformation(extent={{-60,-6},{-48,6}})));
  Modelica.Blocks.Sources.Constant Tset annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Sources.Constant fanSig annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
  Modelica.Blocks.Sources.Constant pumSig annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
  Modelica.Blocks.Sources.Step Tou "Outdoor temperature" annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  Modelica.Blocks.Sources.Step win "Inlet humidity ratio" annotation (Placement(transformation(extent={{-160,-30},{-140,-10}})));
equation
  connect(sou.ports[1], fan.port_a) annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
  connect(coo.port_b, sou1.ports[1]) annotation (Line(points={{60,0},{80,0}}, color={0,127,255}));
  connect(sinWat.ports[1], cooPad.port_b2) annotation (Line(points={{-100,-40},{-40,-40},{-40,-12}}, color={0,127,255}));
  connect(cooPad.port_a2, pum.port_b) annotation (Line(points={{-20,-12},{-20,-40},{0,-40}}, color={0,127,255}));
  connect(pum.port_a, souWat.ports[1]) annotation (Line(points={{18,-40},{80,
          -40}},                                                                    color={0,127,255}));
  connect(fan.port_b, senRelHum1.port_a) annotation (Line(points={{-70,0},{-60,0}}, color={0,127,255}));
  connect(senRelHum1.port_b, cooPad.port_a1) annotation (Line(points={{-48,0},{-40,0}}, color={0,127,255}));
  connect(cooPad.port_b1, senTem.port_a) annotation (Line(points={{-20,0},{-12,0}}, color={0,127,255}));
  connect(senTem.port_b, senRelHum.port_a) annotation (Line(points={{0,0},{8,0}}, color={0,127,255}));
  connect(senRelHum.port_b, coo.port_a) annotation (Line(points={{20,0},{40,0}}, color={0,127,255}));
  connect(Tset.y, coo.TSet) annotation (Line(points={{21,40},{24,40},{24,8},{38,8}}, color={0,0,127}));
  connect(fanSig.y, fan.y) annotation (Line(points={{-99,40},{-80,40},{-80,12}}, color={0,0,127}));
  connect(pum.y, pumSig.y) annotation (Line(points={{9,-52},{10,-52},{10,-70},{79,-70}}, color={0,0,127}));
  connect(Tou.y, sou.T_in) annotation (Line(points={{-139,20},{-128,20},{-128,4},{-122,4}}, color={0,0,127}));
  connect(win.y, sou.Xi_in[1]) annotation (Line(points={{-139,-20},{-128,-20},{-128,-4},{-122,-4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{120,100}})));
end DirectEvaporativeCoolerPreCooling;

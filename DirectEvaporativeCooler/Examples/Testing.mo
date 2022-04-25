within DirectEvaporativeCooler.Examples;
package Testing "Examples under testing"
  model DirectEvaporativeCoolerPreCooling
    extends Modelica.Icons.Example;

    package MediumWater = Buildings.Media.Water "Water medium";
    package MediumAir = Buildings.Media.Air "Air medium";

    parameter Modelica.SIunits.MassFlowRate mW_flow_nominal=0.38 "Nominal mass flow rate on water side";
    parameter Modelica.SIunits.MassFlowRate mA_flow_nominal=3.12 "Nominal mass flow rate on air side";

    parameter Modelica.SIunits.PressureDifference dpW_nominal=100 "Nominal pressure drop on the water side";
    parameter Modelica.SIunits.PressureDifference dpA_nominal=170 "Nominal pressure drop on the air side";
    parameter Modelica.SIunits.PressureDifference dpD_nominal=74 "Nominal pressure drop across the duct";

    ComponentModels.PhysicsBased cooPad(redeclare package Medium1 = MediumAir, redeclare package Medium2 =
          MediumWater,
      m1_flow_nominal=mA_flow_nominal,
      m2_flow_nominal=mW_flow_nominal,
      dp_pad_nominal=dpA_nominal,
      dp_pip_nominal=dpW_nominal,
      CooPadTyp=DirectEvaporativeCooler.BaseClasses.CooPad.PhysicsBased,
      CooPadMaterial=DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Cellulose,
      Thickness=0.1,
      Length=2.035,
      Height=1,
      K_value=0.04,
      DriftFactor=0.1,
      Rcon=3)                           annotation (Placement(transformation(extent={{-40,-16},{-20,4}})));
    Buildings.Fluid.HeatExchangers.SensibleCooler_T coo(redeclare package Medium = MediumAir,
      m_flow_nominal=mA_flow_nominal,
      dp_nominal=dpA_nominal)                           annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    Buildings.Fluid.Movers.SpeedControlled_y fan(redeclare package Medium = MediumAir, per=Breezair_Icon_fan)
                                                 annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
    Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum(redeclare package Medium = MediumAir, m_flow_nominal=
          mA_flow_nominal)                                    annotation (Placement(transformation(extent={{8,-6},{20,6}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumAir, m_flow_nominal=
          mA_flow_nominal)                            annotation (Placement(transformation(extent={{-12,-6},{0,6}})));
    Buildings.Fluid.Sources.Boundary_pT sou(
      redeclare package Medium = MediumAir,
      use_Xi_in=false,
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
    Buildings.Fluid.Movers.FlowControlled_m_flow
                                             pum(redeclare package Medium =
          MediumWater,
      m_flow_nominal=mW_flow_nominal,
      per=Breezair_Icon_pump,                                                            addPowerToMedium=false,
      dp_nominal=dpW_nominal)
      annotation (Placement(transformation(extent={{18,-30},{0,-50}})));
    Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum1(redeclare package Medium = MediumAir, m_flow_nominal=
          mA_flow_nominal)                                     annotation (Placement(transformation(extent={{-60,-6},{-48,6}})));
    Modelica.Blocks.Sources.Constant Tset(k=10 + 273.15)
                                          annotation (Placement(transformation(extent={{0,30},{20,50}})));
    Modelica.Blocks.Sources.Constant fanSig(k=400)
                                            annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
    Modelica.Blocks.Sources.Constant pumSig(k=0.35)
                                            annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
    Modelica.Blocks.Sources.TimeTable
                                 Tou(table=[0,14; 1,20; 2,21; 3,21; 4,24; 5,25; 6,27; 7,27; 8,30; 9,32; 10,35; 11,36; 12,
          38; 13,36; 14,34; 15,35; 16,32; 17,25; 18,23; 19,21; 20,22; 21,21; 22,21; 23,21], timeScale=3600)
                                     "Outdoor temperature" annotation (Placement(transformation(extent={{-160,-6},{-140,
              14}})));
    parameter Records.BreezairIcon170FanCurve Breezair_Icon_fan
      annotation (Placement(transformation(extent={{-156,-94},{-136,-74}})));
    parameter Records.BreezairIcon170PumpCurve Breezair_Icon_pump
      annotation (Placement(transformation(extent={{-126,-94},{-106,-74}})));
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
    connect(Tset.y, coo.TSet) annotation (Line(points={{21,40},{28,40},{28,8},{38,8}}, color={0,0,127}));
    connect(fanSig.y, fan.y) annotation (Line(points={{-99,40},{-80,40},{-80,12}}, color={0,0,127}));
    connect(Tou.y, sou.T_in) annotation (Line(points={{-139,4},{-122,4}}, color={0,0,127}));
    connect(pum.m_flow_in, pumSig.y) annotation (Line(points={{9,-52},{8,-52},{8,-70},{79,-70}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{120,100}})));
  end DirectEvaporativeCoolerPreCooling;
end Testing;

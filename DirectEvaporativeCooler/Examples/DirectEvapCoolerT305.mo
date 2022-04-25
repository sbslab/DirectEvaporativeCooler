within DirectEvaporativeCooler.Examples;
model DirectEvapCoolerT305 "Example model to test the DecSys at 305K inlet condition"

  extends Modelica.Icons.Example;

  //Medium model
  package MediumWater = Buildings.Media.Water "Water medium";
  package MediumAir = Buildings.Media.Air "Air medium";

  parameter Modelica.SIunits.MassFlowRate mW_flow_nominal=0.38 "Nominal mass flow rate on water side";
  parameter Modelica.SIunits.MassFlowRate mA_flow_nominal=3.12 "Nominal mass flow rate on air side";

  parameter Modelica.SIunits.PressureDifference dpW_nominal=100 "Nominal pressure drop on the water side";
  parameter Modelica.SIunits.PressureDifference dpA_nominal=170 "Nominal pressure drop on the air side";
  parameter Modelica.SIunits.PressureDifference dpD_nominal=74 "Nominal pressure drop across the duct";

  SystemModel.DecSysLumped decSys(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mA_flow_nominal,
    mW_flow_nominal=mW_flow_nominal,
    dp_pad_nominal(displayUnit="Pa") = dpA_nominal,
    dp_pip_nominal(displayUnit="Pa") = dpW_nominal,
    Thickness=0.1,
    Length=2.034,
    Height=1,
    perFan=Breezair_Icon_fan,
    perPum=Breezair_Icon_pump) "Direct evaporative cooling system"  annotation (Placement(transformation(extent={{-16,30},
            {4,50}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumAir,
    use_Xi_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-66,30},{-46,50}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{114,30},{94,50}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{44,32},{60,48}})));
  Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul(redeclare package Medium = MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{68,32},{84,48}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducRes(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mA_flow_nominal,
    dp_nominal=dpD_nominal) "Resistance offered by the duct" annotation (Placement(transformation(extent={{14,30},{34,
            50}})));
  Modelica.Blocks.Sources.Constant
                               pumSig(k=0.38)
                                      "Pump signal" annotation (Placement(transformation(extent={{-92,60},{-80,72}})));
  Modelica.Blocks.Sources.TimeTable
                               fanSig(table=[0,170; 1,170; 2,170; 3,260; 4,260; 5,350; 6,350; 7,350; 8,440; 9,440; 10,
        440; 11,530; 12,530; 13,530],                         timeScale=900)
                                      "Fan Signal" annotation (Placement(transformation(extent={{-92,-6},{-80,6}})));
  Modelica.Blocks.Sources.Constant
                               TOu(k=305.3722222)
                                   "Outdoor temperature" annotation (Placement(transformation(extent={{-92,38},{-80,50}})));
  Modelica.Blocks.Sources.TimeTable
                               wIn(table=[0,0.00745; 1,0.0111178; 2,0.01523073; 3,0.00745; 4,0.0152307; 5,0.00745; 6,
        0.0111178; 7,0.0152307; 8,0.00745; 9,0.0111178; 10,0.0152307; 11,0.00745; 12,0.0111178; 13,0.0152307],
                                                   timeScale=900)
                                   "Inlet humidity ratio" annotation (Placement(transformation(extent={{-92,14},{-80,26}})));
  Modelica.Blocks.Sources.RealExpression effLum(y=((TOu1.y - senTem.T)/(TOu.y - senWetBul.T))*100)
    "Saturation efficiency" annotation (Placement(transformation(extent={{162,-52},{178,-36}})));
  Modelica.Blocks.Sources.RealExpression watConLum(y=decSys.cooPad.watCon.m_eva) "massflow rate of water consumed"
    annotation (Placement(transformation(extent={{192,-70},{208,-54}})));
  Modelica.Blocks.Sources.TimeTable effData(table=[0,91.5; 1,92.3; 2,92.2; 3,88.5; 4,87.6; 5,86; 6,86.1; 7,85.7; 8,
        84.1; 9,84.2; 10,83.5; 11,81.9; 12,81.9; 13,80.6],
                                    timeScale=900)
                                            annotation (Placement(transformation(extent={{140,-120},{160,-100}})));
  Modelica.Blocks.Sources.TimeTable watConData(table=[0,0.0039976; 1,0.0032612; 2,0.0017884; 3,0.0059964; 4,0.0037872;
        5,0.00789; 6,0.0069432; 7,0.004734; 8,0.0096784; 9,0.0088368; 10,0.0055756; 11,0.0116772; 12,0.0103096; 13,
        0.0071536],                                                               timeScale=900)
                                               annotation (Placement(transformation(extent={{100,-120},{120,-100}})));
  parameter Records.BreezairIcon170FanCurve Breezair_Icon_fan
    annotation (Placement(transformation(extent={{60,-118},{80,-98}})));
  Modelica.Blocks.Sources.TimeTable PowerData(table=[0,102; 1,103; 2,102; 3,195; 4,243; 5,379; 6,379; 7,376; 8,700; 9,
        694; 10,695; 11,1204; 12,1194; 13,1187], timeScale=900)
    annotation (Placement(transformation(extent={{180,-120},{200,-100}})));
  parameter Records.BreezairIcon170PumpCurve Breezair_Icon_pump
    annotation (Placement(transformation(extent={{34,-118},{54,-98}})));
  SystemModel.DecSystemPhysicsBased
                           decSys1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mA_flow_nominal,
    dp_nominal=dpA_nominal,
    mW_flow_nominal=mW_flow_nominal,
    dp_pad_nominal(displayUnit="Pa") = dpA_nominal,
    dp_pip_nominal(displayUnit="Pa") = dpW_nominal,
    Thickness=0.1,
    Length=2.034,
    Height=1,
    CooPadMaterial=DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Celdek,
    perFan=Breezair_Icon_fan,
    perPum=Breezair_Icon_pump) "Direct evaporative cooling system"  annotation (Placement(transformation(extent={{-14,-60},
            {6,-40}})));
  Buildings.Fluid.Sources.Boundary_pT sin1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{116,-60},{96,-40}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{46,-58},{62,-42}})));
  Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul1(redeclare package Medium = MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{70,-58},{86,-42}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducRes1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mA_flow_nominal,
    dp_nominal=dpD_nominal) "Resistance offered by the duct" annotation (Placement(transformation(extent={{16,-60},{
            36,-40}})));
  Buildings.Fluid.Sources.Boundary_pT sou1(
    redeclare package Medium = MediumAir,
    use_Xi_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-68,-104},{-48,-84}})));
  Modelica.Blocks.Sources.Constant
                               TOu1(k=305)
                                   "Outdoor temperature" annotation (Placement(transformation(extent={{-94,-96},{-82,
            -84}})));
  Modelica.Blocks.Sources.TimeTable
                               wIn1(table=[0,0.00745; 1,0.0111178; 2,0.01523073; 3,0.00745; 4,0.0152307; 5,0.00745; 6,
        0.0111178; 7,0.0152307; 8,0.00745; 9,0.0111178; 10,0.0152307; 11,0.00745; 12,0.0111178; 13,0.0152307],
      timeScale=900)               "Inlet humidity ratio" annotation (Placement(transformation(extent={{-94,-120},{
            -82,-108}})));
  Modelica.Blocks.Sources.RealExpression effPhy(y=((TOu.y - senTem1.T)/(TOu.y - senWetBul1.T))*100)
    "Saturation efficiency" annotation (Placement(transformation(extent={{192,-52},{208,-36}})));
  Modelica.Blocks.Sources.RealExpression watConphy(y=decSys1.cooPad.WatCon.m_eva) "massflow rate of water consumed"
    annotation (Placement(transformation(extent={{162,-70},{178,-54}})));
  Modelica.Blocks.Sources.RealExpression WBD(y=(TOu1.y - senWetBul.T)) "Saturation efficiency"
    annotation (Placement(transformation(extent={{162,-32},{178,-16}})));
equation
  connect(sou.ports[1], decSys.port_a) annotation (Line(
      points={{-46,40},{-16,40}},
      color={0,127,255},
      thickness=0.5));
  connect(sin.ports[1], senWetBul.port_b) annotation (Line(
      points={{94,40},{84,40}},
      color={0,127,255},
      thickness=0.5));
  connect(senWetBul.port_a, senTem.port_b) annotation (Line(
      points={{68,40},{60,40}},
      color={0,127,255},
      thickness=0.5));
  connect(senTem.port_a, ducRes.port_b) annotation (Line(
      points={{44,40},{34,40}},
      color={0,127,255},
      thickness=0.5));
  connect(ducRes.port_a, decSys.port_b) annotation (Line(
      points={{14,40},{4,40}},
      color={0,127,255},
      thickness=0.5));
  connect(fanSig.y, decSys.fanSig) annotation (Line(
      points={{-79.4,0},{-26,0},{-26,43},{-18,43}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pumSig.y, decSys.pumSig) annotation (Line(
      points={{-79.4,66},{-18,66},{-18,48}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sou.T_in,TOu. y) annotation (Line(
      points={{-68,44},{-79.4,44}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(wIn.y, sou.Xi_in[1]) annotation (Line(
      points={{-79.4,20},{-74,20},{-74,36},{-68,36}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sin1.ports[1], senWetBul1.port_b)
    annotation (Line(
      points={{96,-50},{92,-50},{92,-50},{86,-50}},
      color={0,127,255},
      thickness=0.5));
  connect(senWetBul1.port_a, senTem1.port_b)
    annotation (Line(
      points={{70,-50},{62,-50}},
      color={0,127,255},
      thickness=0.5));
  connect(senTem1.port_a, ducRes1.port_b)
    annotation (Line(
      points={{46,-50},{36,-50}},
      color={0,127,255},
      thickness=0.5));
  connect(ducRes1.port_a, decSys1.port_b)
    annotation (Line(
      points={{16,-50},{6,-50}},
      color={0,127,255},
      thickness=0.5));
  connect(fanSig.y, decSys1.fanSig)
    annotation (Line(points={{-79.4,0},{-80,0},{-80,-48},{-16,-48},{-16,-47}},           color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pumSig.y, decSys1.pumSig)
    annotation (Line(points={{-79.4,66},{-78,66},{-78,-42},{-16,-42}},                   color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sou1.T_in, TOu1.y)
    annotation (Line(
      points={{-70,-90},{-81.4,-90}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(wIn1.y, sou1.Xi_in[1]) annotation (Line(
      points={{-81.4,-114},{-76,-114},{-76,-98},{-70,-98}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sou1.ports[1], decSys1.port_a)
    annotation (Line(points={{-48,-94},{-24,-94},{-24,-50},{-14,-50}}, color={0,127,255},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,100}})), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -140},{220,100}})));
end DirectEvapCoolerT305;

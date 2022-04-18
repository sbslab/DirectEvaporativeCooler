within DirectEvaporativeCooler.Examples;
model DirectEvapCoolerT316
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
    perPum=Breezair_Icon_pump) "Direct evaporative cooling system"  annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumAir,
    use_Xi_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-66,30},{-46,50}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{100,30},{80,50}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{30,32},{46,48}})));
  Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul(redeclare package Medium = MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{54,32},{70,48}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducRes(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mA_flow_nominal,
    dp_nominal=dpD_nominal) "Resistance offered by the duct" annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Sources.Constant
                               pumSig(k=0.38)
                                      "Pump signal" annotation (Placement(transformation(extent={{-92,60},{-80,72}})));
  Modelica.Blocks.Sources.TimeTable
                               fanSig(table=[0,170; 1,170; 2,260; 3,260; 4,350; 5,350; 6,440; 7,440; 8,440; 9,530; 10,
        530],                                                 timeScale=900)
                                      "Fan Signal" annotation (Placement(transformation(extent={{-92,-6},{-80,6}})));
  Modelica.Blocks.Sources.Constant
                               TOu(k=316)
                                   "Outdoor temperature" annotation (Placement(transformation(extent={{-92,38},{-80,50}})));
  Modelica.Blocks.Sources.TimeTable
                               wIn(table=[0,0.00294; 1,0.010604; 2,0.006547; 3,0.010604; 4,0.006547; 5,0.010604; 6,
        0.006547; 7,0.006547; 8,0.010604; 9,0.006547; 10,0.010604],
                                                   timeScale=900)
                                   "Inlet humidity ratio" annotation (Placement(transformation(extent={{-92,14},{-80,26}})));
  Modelica.Blocks.Sources.RealExpression effLum(y=((TOu1.y - senTem.T)/(TOu.y - senWetBul.T))*100)
    "Saturation efficiency" annotation (Placement(transformation(extent={{162,-4},{178,12}})));
  Modelica.Blocks.Sources.RealExpression watConLum(y=decSys.cooPad.watCon.m_eva) "massflow rate of water consumed"
    annotation (Placement(transformation(extent={{160,-50},{176,-34}})));
  Modelica.Blocks.Sources.TimeTable effData(table=[0,84.1; 1,92.5; 2,89.9; 3,88.5; 4,87.6; 5,86.4; 6,85.8; 7,85.4; 8,
        85; 9,83.6; 10,83.8],       timeScale=900)
                                            annotation (Placement(transformation(extent={{100,-120},{120,-100}})));
  Modelica.Blocks.Sources.TimeTable watConData(table=[0,0.0044184; 1,0.0054704; 2,0.009468; 3,0.0092576; 4,0.0125188;
        5,0.0109408; 6,0.0155696; 7,0.0156748; 8,0.0139916; 9,0.0187256; 10,0.0160956],
                                                                                  timeScale=900)
                                               annotation (Placement(transformation(extent={{60,-120},{80,-100}})));
  parameter Records.BreezairIcon170FanCurve Breezair_Icon_fan
    annotation (Placement(transformation(extent={{-72,-182},{-52,-162}})));
  Modelica.Blocks.Sources.TimeTable PowerData(table=[0,104; 1,102; 2,193; 3,244; 4,372; 5,435; 6,701; 7,686; 8,749; 9,
        1193; 10,1200], timeScale=900) annotation (Placement(transformation(extent={{140,-120},{160,-100}})));
  parameter Records.BreezairIcon170PumpCurve Breezair_Icon_pump
    annotation (Placement(transformation(extent={{-98,-182},{-78,-162}})));
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
                               TOu1(k=316)
                                   "Outdoor temperature" annotation (Placement(transformation(extent={{-94,-96},{-82,
            -84}})));
  Modelica.Blocks.Sources.TimeTable
                               wIn1(table=[0,0.00294; 1,0.010604; 2,0.006547; 3,0.010604; 4,0.006547; 5,0.010604; 6,
        0.006547; 7,0.006547; 8,0.010604; 9,0.006547; 10,0.010604], timeScale=900)
                                   "Inlet humidity ratio" annotation (Placement(transformation(extent={{-94,-120},{
            -82,-108}})));
  Modelica.Blocks.Sources.RealExpression effPhy(y=((TOu.y - senTem1.T)/(TOu.y - senWetBul1.T))*100)
    "Saturation efficiency" annotation (Placement(transformation(extent={{160,-26},{176,-10}})));
  Modelica.Blocks.Sources.RealExpression watConphy(y=decSys1.cooPad.WatCon.m_eva) "massflow rate of water consumed"
    annotation (Placement(transformation(extent={{162,-70},{178,-54}})));
  Modelica.Blocks.Sources.RealExpression WBD(y=(TOu1.y - senWetBul.T)) "Saturation efficiency"
    annotation (Placement(transformation(extent={{162,28},{178,44}})));
equation
  connect(sou.ports[1], decSys.port_a) annotation (Line(
      points={{-46,40},{-38,40},{-38,40},{-30,40}},
      color={0,127,255},
      thickness=0.5));
  connect(sin.ports[1], senWetBul.port_b) annotation (Line(
      points={{80,40},{76,40},{76,40},{70,40}},
      color={0,127,255},
      thickness=0.5));
  connect(senWetBul.port_a, senTem.port_b) annotation (Line(
      points={{54,40},{46,40}},
      color={0,127,255},
      thickness=0.5));
  connect(senTem.port_a, ducRes.port_b) annotation (Line(
      points={{30,40},{20,40}},
      color={0,127,255},
      thickness=0.5));
  connect(ducRes.port_a, decSys.port_b) annotation (Line(
      points={{0,40},{-10,40}},
      color={0,127,255},
      thickness=0.5));
  connect(fanSig.y, decSys.fanSig) annotation (Line(
      points={{-79.4,0},{-40,0},{-40,43},{-32,43}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pumSig.y, decSys.pumSig) annotation (Line(
      points={{-79.4,66},{-32,66},{-32,48}},
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
    annotation (Line(points={{-79.4,0},{-78,0},{-78,-38},{-38,-38},{-38,-47},{-16,-47}}, color={0,0,127}));
  connect(pumSig.y, decSys1.pumSig)
    annotation (Line(points={{-79.4,66},{-50,66},{-50,68},{-28,68},{-28,-42},{-16,-42}}, color={0,0,127}));
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
    annotation (Line(points={{-48,-94},{-24,-94},{-24,-50},{-14,-50}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,100}})), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -140},{220,100}})),
                          experiment(
      StopTime=41400,
      Interval=300,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
       __Dymola_Commands(file="modelica://DirectEvaporativeCooler/Scripts/DirectEvapCoolerLumped.mos"
        "Simulate and plot"));
end DirectEvapCoolerT316;

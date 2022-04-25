within DirectEvaporativeCooler.Examples;
model DirectEvapCoolerPhysics "Example model to test the DecSysPhysics"

  extends Modelica.Icons.Example;

  //Medium model
  package MediumWater = Buildings.Media.Water "Water medium";
  package MediumAir = Buildings.Media.Air "Air medium";

  parameter Modelica.SIunits.MassFlowRate mW_flow_nominal=0.38 "Nominal mass flow rate on water side";
  parameter Modelica.SIunits.MassFlowRate mA_flow_nominal=3.12 "Nominal mass flow rate on air side";

  parameter Modelica.SIunits.PressureDifference dpW_nominal=100 "Nominal pressure drop on the water side";
  parameter Modelica.SIunits.PressureDifference dpA_nominal=140 "Nominal pressure drop on the air side";
  parameter Modelica.SIunits.PressureDifference dpD_nominal=74 "Nominal pressure drop across the duct";

  SystemModel.DecSystemPhysicsBased
                           decSys(
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
    perPum=Breezair_Icon_pump)  "Direct evaporative cooling system" annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
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
                               fanSig(table=[0,170; 1,170; 2,170; 3,170; 4,170;
        5,170; 6,260; 7,260; 8,260; 9,260; 10,260; 11,350; 12,350; 13,350; 14,
        350; 15,350; 16,350; 17,350; 18,440; 19,440; 20,440; 21,440; 22,440; 23,
        440; 24,440; 25,440; 26,440; 27,440; 28,440; 29,440; 30,440; 31,440; 32,
        440; 33,440; 34,440; 35,440; 36,440; 37,440; 38,440; 39,440; 40,530; 41,
        530; 42,530; 43,530; 44,530; 45,530; 46,530; 47,530], timeScale=900)
                                      "Fan Signal" annotation (Placement(transformation(extent={{-92,-6},{-80,6}})));
  Modelica.Blocks.Sources.TimeTable
                               Tou(table=[0,305; 1,305; 2,305; 3,311; 4,316; 5,
        316; 6,305; 7,305; 8,311; 9,316; 10,316; 11,305; 12,305; 13,305; 14,311;
        15,311; 16,316; 17,316; 18,305; 19,305; 20,305; 21,311; 22,311; 23,316;
        24,316; 25,316; 26,311; 27,311; 28,311; 29,311; 30,311; 31,311; 32,311;
        33,311; 34,311; 35,311; 36,311; 37,311; 38,311; 39,311; 40,305; 41,305;
        42,305; 43,311; 44,311; 45,316; 46,316; 47,318], timeScale=900)
                                   "Outdoor temperature" annotation (Placement(transformation(extent={{-92,38},{-80,50}})));
  Modelica.Blocks.Sources.TimeTable
                               win(table=[0,0.00745; 1,0.011118; 2,0.015231; 3,
        0.005191; 4,0.00294; 5,0.010604; 6,0.00745; 7,0.015231; 8,0.005191; 9,
        0.006547; 10,0.010604; 11,0.00745; 12,0.011118; 13,0.015231; 14,
        0.005191; 15,0.012908; 16,0.006547; 17,0.010604; 18,0.00745; 19,
        0.011118; 20,0.015231; 21,0.005191; 22,0.012908; 23,0.006547; 24,
        0.006547; 25,0.010604; 26,0.008823; 27,0.008823; 28,0.008823; 29,
        0.008823; 30,0.008823; 31,0.008823; 32,0.008823; 33,0.008823; 34,
        0.008823; 35,0.008823; 36,0.008823; 37,0.008823; 38,0.008823; 39,
        0.008823; 40,0.00745; 41,0.011118; 42,0.015231; 43,0.005191; 44,
        0.012908; 45,0.006547; 46,0.010604; 47,0], timeScale=900)
                                   "Inlet humidity ratio" annotation (Placement(transformation(extent={{-92,14},{-80,26}})));
  Modelica.Blocks.Sources.RealExpression preDrop(y=decSys.port_a.p - decSys.port_b.p) "Pressure drop"
    annotation (Placement(transformation(extent={{-96,-48},{-80,-32}})));
  Modelica.Blocks.Sources.RealExpression watCon(y=decSys.cooPad.WatCon.m_eva) "massflow rate of water consumed"
    annotation (Placement(transformation(extent={{24,-106},{40,-90}})));
  Modelica.Blocks.Sources.RealExpression preDropCal(y=decSys.cooPad.dp_pad_cal)
                                                                 "Pressure drop calculated" annotation (Placement(transformation(extent={{-96,-68},{-80,-52}})));
  Modelica.Blocks.Math.Add preDroModErr(k1=-1) "Pressure drop error in the model" annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Math.Add effDatErr(k2=-1) "Efficiency error" annotation (Placement(transformation(extent={{60,-60},{
            80,-40}})));
  Modelica.Blocks.Sources.TimeTable effData(table=[0,91.5; 1,92.3; 2,92.2; 3,
        91.6; 4,84.1; 5,92.5; 6,88.5; 7,87.6; 8,88.7; 9,89.9; 10,88.5; 11,86;
        12,86.1; 13,85.7; 14,86.3; 15,86; 16,87.6; 17,86.4; 18,84.1; 19,84.2;
        20,83.5; 21,84.5; 22,83.8; 23,85.8; 24,85.4; 25,85; 26,84.8; 27,84.6;
        28,84.8; 29,84.6; 30,84.9; 31,84.7; 32,84.6; 33,84.9; 34,84.8; 35,84.7;
        36,84.8; 37,84.6; 38,84.9; 39,84.6; 40,81.9; 41,81.9; 42,80.6; 43,83.1;
        44,82.1; 45,83.6; 46,83.8], timeScale=900)
                                            annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Blocks.Sources.TimeTable watConData(table=[0,0.0039976; 1,0.0032612;
        2,0.0017884; 3,0.0059964; 4,0.0044184; 5,0.0054704; 6,0.0059964; 7,
        0.0037872; 8,0.0086264; 9,0.009468; 10,0.0092576; 11,0.00789; 12,
        0.0069432; 13,0.004734; 14,0.0111512; 15,0.0083108; 16,0.0125188; 17,
        0.0109408; 18,0.0096784; 19,0.0088368; 20,0.0055756; 21,0.0135708; 22,
        0.0100992; 23,0.0155696; 24,0.0156748; 25,0.0139916; 26,0.0118876; 27,
        0.0119928; 28,0.0119928; 29,0.012098; 30,0.0119928; 31,0.0119928; 32,
        0.0119928; 33,0.012098; 34,0.0118876; 35,0.0119928; 36,0.012098; 37,
        0.0119928; 38,0.012098; 39,0.0119928; 40,0.0116772; 41,0.0103096; 42,
        0.0071536; 43,0.0151488; 44,0.0117824; 45,0.0187256; 46,0.0160956; 47,0], timeScale=900)
                                               annotation (Placement(transformation(extent={{20,-132},{40,-112}})));
  Modelica.Blocks.Math.Add watConDatErr(k2=-1) "Water consumption error in the data" annotation (Placement(transformation(extent={{60,-120},
            {80,-100}})));
  parameter Records.BreezairIcon170FanCurve Breezair_Icon_fan
    annotation (Placement(transformation(extent={{-66,-122},{-46,-102}})));
  Modelica.Blocks.Sources.RealExpression Powe(y=decSys.pumPow.y + decSys.fanPow.y)
    "Saturation efficiency" annotation (Placement(transformation(extent={{144,-88},{160,-72}})));
  Modelica.Blocks.Math.Add PowDatErr(k2=-1) "Efficiency error"
    annotation (Placement(transformation(extent={{180,-100},{200,-80}})));
  Modelica.Blocks.Sources.TimeTable Power(table=[0,102; 1,103; 2,102; 3,107; 4,104; 5,102; 6,195; 7,243;
        8,199; 9,193; 10,244; 11,379; 12,379; 13,376; 14,376; 15,423; 16,372; 17,435; 18,700; 19,694; 20,
        695; 21,705; 22,734; 23,701; 24,686; 25,749; 26,692; 27,703; 28,693; 29,704; 30,694; 31,706; 32,
        706; 33,702; 34,694; 35,707; 36,705; 37,708; 38,708; 39,712; 40,1204; 41,1194; 42,1187; 43,1197;
        44,1200; 45,1193; 46,1200], timeScale=900)
    annotation (Placement(transformation(extent={{140,-120},{160,-100}})));
  Modelica.Blocks.Sources.RealExpression CFM(y=(decSys.m_flow/1.225)*2118.88) "CFM through the cooler"
    annotation (Placement(transformation(extent={{144,-68},{160,-52}})));
  Modelica.Blocks.Sources.RealExpression Efficiency(y=((Tou.y - senTem.T)/(Tou.y - senWetBul.T))*100)
    "Saturation efficiency"
    annotation (Placement(transformation(extent={{24,-46},{40,-30}})));
  parameter Records.BreezairIcon170PumpCurve Breezair_Icon_pump
    annotation (Placement(transformation(extent={{-96,-122},{-76,-102}})));
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
  connect(sou.T_in, Tou.y) annotation (Line(
      points={{-68,44},{-79.4,44}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(win.y, sou.Xi_in[1]) annotation (Line(
      points={{-79.4,20},{-74,20},{-74,36},{-68,36}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(preDrop.y, preDroModErr.u1) annotation (Line(points={{-79.2,-40},{-68,-40},{-68,-44},{-62,-44}}, color={0,0,127}));
  connect(preDropCal.y, preDroModErr.u2) annotation (Line(points={{-79.2,-60},{-70,-60},{-70,-56},{-62,-56}}, color={0,0,127}));
  connect(effData.y, effDatErr.u2) annotation (Line(points={{41,-60},{50,-60},{50,-56},{58,-56}}, color={0,0,127}));
  connect(watCon.y, watConDatErr.u1) annotation (Line(points={{40.8,-98},{52,-98},{52,-104},{58,-104}},   color={0,0,127}));
  connect(watConData.y, watConDatErr.u2) annotation (Line(points={{41,-122},{50,-122},{50,-116},{58,-116}}, color={0,0,127}));
  connect(PowDatErr.u1, Powe.y)
    annotation (Line(points={{178,-84},{168,-84},{168,-80},{160.8,-80}}, color={0,0,127}));
  connect(Power.y, PowDatErr.u2)
    annotation (Line(points={{161,-110},{168,-110},{168,-96},{178,-96}},
                                                                       color={0,0,127}));
  connect(Efficiency.y, effDatErr.u1)
    annotation (Line(points={{40.8,-38},{48,-38},{48,-44},{58,-44}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,100}})), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -140},{220,100}})),
                          experiment(
      StopTime=41400,
      Interval=300,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
       __Dymola_Commands(file="modelica://DirectEvaporativeCooler/Scripts/DirectEvapCoolerPhysics.mos"
        "Simulate and plot"));
end DirectEvapCoolerPhysics;

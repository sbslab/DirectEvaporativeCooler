within DirectEvaporativeCooler.Obsolete;
model DEC_Physics_based2
  "Validated using the system performance testing data of PG&E"
      extends Modelica.Icons.Example;
  replaceable package Medium1 = Buildings.Media.Water;
  replaceable package Medium2 = Buildings.Media.Air;

  Buildings.Fluid.Sources.Boundary_pT bou_air_indoor(
    redeclare package Medium = Medium2,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Sources.RealExpression Temperature(y=280)
    annotation (Placement(transformation(extent={{-166,-10},{-146,10}})));
  Modelica.Blocks.Sources.RealExpression waterMassFlowrate(y=0.32)
    "in pascals"
    annotation (Placement(transformation(extent={{-166,-30},{-146,-10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow Pump(
    redeclare package Medium = Medium1,
    m_flow_nominal=0.32,
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=true,
    dp_nominal=11652.14,
    m_flow_start=0.32)
    annotation (Placement(transformation(extent={{-80,6},{-60,-14}})));
  Buildings.Fluid.Sources.Boundary_ph Bou_water1(redeclare package Medium =
        Medium1, nPorts=1)
    annotation (Placement(transformation(extent={{178,-14},{158,6}})));
  Modelica.Blocks.Sources.RealExpression Air_composition(y=310)
    annotation (Placement(transformation(extent={{224,34},{204,14}})));
  Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.593,
    tau=0) annotation (Placement(transformation(extent={{-72,14},{-60,26}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium2)
    annotation (Placement(transformation(extent={{-52,14},{-40,26}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.593,
    tau=0) annotation (Placement(transformation(extent={{74,14},{84,26}})));
  Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul1(
    redeclare package Medium = Medium2,
    m_flow_nominal=0.5,
    tau=0) annotation (Placement(transformation(extent={{92,14},{104,26}})));
  Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.593,
    tau=0) annotation (Placement(transformation(extent={{-32,14},{-20,26}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem2(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.47,
    tau=0) annotation (Placement(transformation(extent={{-92,14},{-80,26}})));
  Buildings.Fluid.Sources.Boundary_pT bou_air_outdoor(
    redeclare package Medium = Medium2,
    use_Xi_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{178,10},{158,30}})));
  Buildings.Fluid.Sources.Boundary_pT Bou_water2(
    redeclare package Medium = Medium1,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-120,-14},{-100,6}})));
  CoolingPadPhysicsBased decCooPad(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    m1_flow_nominal=0.32,
    m2_flow_nominal=1.5,
    dp1_nominal=11652.14,
    dp2_nominal=0.768*((0.0288)^(-0.469))*(1 + (decCooPad.m2_flow_nominal^1.139))*((decCooPad.m2_flow_nominal/decCooPad.PadArea)^2),
    Thickness=0.035,
    Length=0.5,
    Height=0.5,
    K_value=0.04,
    Contact_surface_area=470,
    DriftFactor=1.125,
    Rcon=12) annotation (Placement(transformation(extent={{0,-12},{40,26}})));
  Modelica.Blocks.Sources.RealExpression Air_composition1(y=0.008844)
    annotation (Placement(transformation(extent={{224,14},{204,-6}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=4,
    duration=100000,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{224,34},{204,54}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow Fan(
    redeclare package Medium = Medium2,
    y_start=1,
    m_flow_nominal=1.5,
    redeclare parameter Buildings.Fluid.Movers.Data.Generic per,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=false,
    m_flow_start=0.201)
    annotation (Placement(transformation(extent={{136,10},{116,30}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo1in(redeclare package Medium =
               Medium2)
    annotation (Placement(transformation(extent={{54,14},{66,26}})));
  DirectEvaporativeCooler decSys annotation (Placement(transformation(extent={{-8,-152},{30,-114}})));
  Buildings.Fluid.Sources.Boundary_pT souAir(
    redeclare package Medium = Medium2,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-116,-146},{-90,-120}})));
  Buildings.Fluid.Sources.Boundary_ph sinAir(redeclare package Medium =
        Medium1, nPorts=1)
    annotation (Placement(transformation(extent={{122,-146},{96,-120}})));
  Modelica.Blocks.Sources.RealExpression airTem(y=280) annotation (
      Placement(transformation(extent={{-148,-140},{-130,-116}})));
  Buildings.Fluid.Sensors.RelativeHumidityTwoPort relHumIn(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.593,
    tau=0)
    annotation (Placement(transformation(extent={{-40,-142},{-22,-124}})));
  Buildings.Fluid.Sensors.RelativeHumidityTwoPort relHumOut(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.593,
    tau=0)
    annotation (Placement(transformation(extent={{42,-142},{60,-124}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TdryBulIn(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.47,
    tau=0)
    annotation (Placement(transformation(extent={{-80,-140},{-66,-126}})));
  Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort TwetBul(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.593,
    tau=0)
    annotation (Placement(transformation(extent={{-60,-140},{-46,-126}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TdryBulOut(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.47,
    tau=0)
    annotation (Placement(transformation(extent={{68,-140},{82,-126}})));
  Buildings.Fluid.Sensors.RelativePressure          senRelPre(redeclare package
                                                                                Medium =
                       Medium2)
           annotation (Placement(transformation(extent={{2,-188},{18,-172}})));
equation
  connect(Temperature.y, Bou_water2.T_in) annotation (Line(points={{-145,0},
          {-122,0}},                     color={0,0,127}));
  connect(Air_composition.y, bou_air_outdoor.T_in)
    annotation (Line(points={{203,24},{180,24}},             color={0,0,127}));
  connect(bou_air_outdoor.Xi_in[1], Air_composition1.y) annotation (Line(points={{180,16},
          {198,16},{198,4},{203,4}},                color={0,0,127}));
  connect(Fan.port_a, bou_air_outdoor.ports[1]) annotation (Line(points={{136,20},
          {158,20}},                           color={0,127,255}));
  connect(Bou_water2.ports[1], Pump.port_a)
    annotation (Line(points={{-100,-4},{-80,-4}}, color={0,127,255}));
  connect(waterMassFlowrate.y, Pump.m_flow_in) annotation (Line(points={{
          -145,-20},{-70,-20},{-70,-16}}, color={0,0,127}));
  connect(senRelHum.port_a, senMasFlo.port_b)
    annotation (Line(points={{-32,20},{-40,20}}, color={0,127,255}));
  connect(senMasFlo.port_a, senWetBul.port_b)
    annotation (Line(points={{-52,20},{-60,20}}, color={0,127,255}));
  connect(senWetBul.port_a, senTem2.port_b)
    annotation (Line(points={{-72,20},{-80,20}}, color={0,127,255}));
  connect(senTem2.port_a, bou_air_indoor.ports[1])
    annotation (Line(points={{-92,20},{-100,20}}, color={0,127,255}));
  connect(senMasFlo1in.port_b, senTem1.port_a)
    annotation (Line(points={{66,20},{74,20}}, color={0,127,255}));
  connect(senTem1.port_b, senWetBul1.port_a)
    annotation (Line(points={{84,20},{92,20}}, color={0,127,255}));
  connect(senWetBul1.port_b, Fan.port_b)
    annotation (Line(points={{104,20},{116,20}}, color={0,127,255}));
  connect(ramp2.y, Fan.m_flow_in) annotation (Line(points={{203,44},{126,44},
          {126,32}}, color={0,0,127}));
  connect(decCooPad.port_b1, senMasFlo1in.port_a)
    annotation (Line(points={{40,20},{54,20}}, color={0,127,255}));
  connect(senRelHum.port_b, decCooPad.port_a1)
    annotation (Line(points={{-20,20},{0,20}}, color={0,127,255}));
  connect(Pump.port_b, decCooPad.port_b2)
    annotation (Line(points={{-60,-4},{0,-4}}, color={0,127,255}));
  connect(decCooPad.port_a2, Bou_water1.ports[1])
    annotation (Line(points={{40,-4},{158,-4}}, color={0,127,255}));
  connect(relHumIn.port_b, decSys.port_a)
    annotation (Line(points={{-22,-133},{-8,-133}}, color={0,127,255},
      thickness=0.5));
  connect(decSys.port_b, relHumOut.port_a)
    annotation (Line(points={{30,-133},{42,-133}}, color={0,127,255},
      thickness=0.5));
  connect(souAir.ports[1], TdryBulIn.port_a)
    annotation (Line(points={{-90,-133},{-80,-133}}, color={0,127,255},
      thickness=0.5));
  connect(TdryBulIn.port_b, TwetBul.port_a)
    annotation (Line(points={{-66,-133},{-60,-133}}, color={0,127,255},
      thickness=0.5));
  connect(TwetBul.port_b, relHumIn.port_a)
    annotation (Line(points={{-46,-133},{-40,-133}}, color={0,127,255},
      thickness=0.5));
  connect(relHumOut.port_b, TdryBulOut.port_a)
    annotation (Line(points={{60,-133},{68,-133}}, color={0,127,255},
      thickness=0.5));
  connect(TdryBulOut.port_b, sinAir.ports[1])
    annotation (Line(points={{82,-133},{96,-133}}, color={0,127,255},
      thickness=0.5));
  connect(decSys.port_a, senRelPre.port_a) annotation (Line(
      points={{-8,-133},{-16,-133},{-16,-180},{2,-180}},
      color={28,108,200},
      thickness=0.5));
  connect(decSys.port_b, senRelPre.port_b) annotation (Line(
      points={{30,-133},{36,-133},{36,-180},{18,-180}},
      color={28,108,200},
      thickness=0.5));
  connect(souAir.T_in, airTem.y) annotation (Line(
      points={{-118.6,-127.8},{-128,-127.8},{-128,-128},{-129.1,-128}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-220},{240,100}})),
    Icon(coordinateSystem(extent={{-160,-220},{240,100}})),
    experiment(
      StopTime=100000,
      Interval=900,
      __Dymola_Algorithm="Dassl"));
end DEC_Physics_based2;

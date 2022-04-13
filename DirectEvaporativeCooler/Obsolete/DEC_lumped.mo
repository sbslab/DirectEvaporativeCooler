within DirectEvaporativeCooler.Obsolete;
model DEC_lumped

    extends Modelica.Icons.Example;
  replaceable package Medium1 = Buildings.Media.Water;
  replaceable package Medium2 = Buildings.Media.Air;

  Buildings.Fluid.Movers.FlowControlled_m_flow Fan(
    redeclare package Medium = Medium2,
    y_start=1,
    m_flow_nominal=2.5,
    per(
      pressure(V_flow={2.28,2.31,2.34,2.37,2.40,2.44,2.47,2.49,2.51,2.54,2.56,
            2.59,2.62,2.65,2.69,2.71,2.74,2.77,2.79,2.81,2.84,2.87,2.90,2.93},
          dp={215.5,206.5,198.8,191.5,182.9,174.82,167.50,160.16,152.41,143.44,
            132.42,123.04,112.44,102.67,92.89,82.69,73.32,65.17,55.37,45.18,
            34.58,24.79,12.96,3.59}),
      use_powerCharacteristic=true,
      power(V_flow={2.281,2.330,2.38,2.43,2.47,2.50,2.53,2.57,2.61,2.66,2.71,
            2.75,2.79,2.83,2.88,2.92,2.96}, P={1830.2,1858.1,1890.4,1913.6,
            1932.15,1941.4,1932.5,1932.8,1955.9,1974.55,2002.2,2011.7,2021.0,
            2044.2,2058.2,2058.5,2058.81}),
      motorCooledByFluid=true,
      speed_rpm_nominal=615),
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    addPowerToMedium=true,
    nominalValuesDefineDefaultPressureCurve=false,
    m_flow_start=2.27)
    annotation (Placement(transformation(extent={{96,-48},{76,-28}})));
  Buildings.Fluid.Sources.Boundary_pT bou_air_indoor(
    redeclare package Medium = Medium2,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-116,-36},{-96,-16}})));
  Modelica.Blocks.Sources.RealExpression Temperature(y=280)
    annotation (Placement(transformation(extent={{-140,16},{-120,36}})));
  Modelica.Blocks.Sources.RealExpression watermassFlow(y=0.32) "in pascals"
    annotation (Placement(transformation(extent={{-140,38},{-120,58}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow Pump(
    redeclare package Medium = Medium1,
    m_flow_nominal=0.32,
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=true,
    dp_nominal=11652.14,
    m_flow_start=0.2)
    annotation (Placement(transformation(extent={{-54,12},{-34,32}})));
  Buildings.Fluid.Sources.Boundary_ph Bou_water1(redeclare package Medium =
        Medium1, nPorts=1)
    annotation (Placement(transformation(extent={{80,12},{60,32}})));
  Modelica.Blocks.Sources.RealExpression Air_composition(y=310)
    annotation (Placement(transformation(extent={{174,-14},{154,-34}})));
  Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.593,
    tau=0) annotation (Placement(transformation(extent={{-66,-24},{-56,-14}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium2)
    annotation (Placement(transformation(extent={{-42,-24},{-32,-14}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.593,
    tau=0) annotation (Placement(transformation(extent={{44,-44},{54,-32}})));
  Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul1(
    redeclare package Medium = Medium2,
    m_flow_nominal=0.5,
    tau=0) annotation (Placement(transformation(extent={{58,-44},{70,-32}})));
  Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.593,
    tau=0) annotation (Placement(transformation(extent={{-24,-24},{-14,-14}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=4,
    duration=100000,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{174,-6},{154,14}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem2(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.47,
    tau=0) annotation (Placement(transformation(extent={{-80,-24},{-70,-12}})));
  Buildings.Fluid.Sources.Boundary_pT bou_air_outdoor(
    redeclare package Medium = Medium2,
    use_Xi_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{132,-60},{112,-40}})));
  Buildings.Fluid.Sources.Boundary_pT Bou_water2(
    redeclare package Medium = Medium1,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-104,12},{-84,32}})));
  CoolingPadLumped dEC_EP_Method1_1(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    m1_flow_nominal=0.32,
    m2_flow_nominal=1.5,
    dp1_nominal=11652.14,
    dp2_nominal=200,
    PadThickness=0.1,
    PadArea=1.8,
    DriftFactor=1.125,
    Rcon=12) annotation (Placement(transformation(extent={{-8,0},{20,28}})));
  Modelica.Blocks.Sources.RealExpression Air_composition1(y=0.008844)
    annotation (Placement(transformation(extent={{166,-46},{146,-66}})));
  EffCheck effCheck annotation (Placement(transformation(extent={{-52,-80},{-32,-60}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        Medium2)
    annotation (Placement(transformation(extent={{24,-18},{34,-8}})));
equation
  connect(senWetBul.port_b,senMasFlo. port_a)
    annotation (Line(points={{-56,-19},{-42,-19}}, color={0,127,255}));
  connect(senTem1.port_b,senWetBul1. port_a)
    annotation (Line(points={{54,-38},{58,-38}}, color={0,127,255}));
  connect(senMasFlo.port_b,senRelHum. port_a)
    annotation (Line(points={{-32,-19},{-24,-19}}, color={0,127,255}));
  connect(senWetBul.port_a, senTem2.port_b) annotation (Line(points={{-66,-19},
          {-68,-19},{-68,-18},{-70,-18}}, color={0,127,255}));
  connect(senTem2.port_a, bou_air_indoor.ports[1]) annotation (Line(points={{-80,-18},
          {-86,-18},{-86,-26},{-96,-26}},          color={0,127,255}));
  connect(Temperature.y, Bou_water2.T_in) annotation (Line(points={{-119,26},{
          -106,26}},                     color={0,0,127}));
  connect(Fan.port_a, bou_air_outdoor.ports[1]) annotation (Line(points={{96,-38},
          {104,-38},{104,-50},{112,-50}},      color={0,127,255}));
  connect(Fan.port_b, senWetBul1.port_b) annotation (Line(points={{76,-38},
          {70,-38}},               color={0,127,255}));
  connect(Bou_water2.ports[1], Pump.port_a)
    annotation (Line(points={{-84,22},{-54,22}}, color={0,127,255}));
  connect(watermassFlow.y, Pump.m_flow_in) annotation (Line(points={{-119,
          48},{-44,48},{-44,34}}, color={0,0,127}));
  connect(Air_composition.y, bou_air_outdoor.T_in)
    annotation (Line(points={{153,-24},{153,-46},{134,-46}}, color={0,0,127}));
  connect(Pump.port_b, dEC_EP_Method1_1.port_a1) annotation (Line(points={{-34,22},
          {-20,22},{-20,22.4},{-8,22.4}}, color={0,127,255}));
  connect(dEC_EP_Method1_1.port_b1, Bou_water1.ports[1]) annotation (Line(
        points={{20,22.4},{38,22.4},{38,22},{60,22}},
                                                  color={0,127,255}));
  connect(dEC_EP_Method1_1.port_b2, senRelHum.port_b) annotation (Line(points={{-8,5.6},
          {-10,5.6},{-10,-19},{-14,-19}},        color={0,127,255}));
  connect(Air_composition1.y, bou_air_outdoor.Xi_in[1]) annotation (Line(points={{145,-56},
          {140,-56},{140,-54},{134,-54}},           color={0,0,127}));
  connect(ramp1.y, Fan.m_flow_in) annotation (Line(points={{153,4},{124,4},
          {124,-4},{86,-4},{86,-26}}, color={0,0,127}));
  connect(senTem2.T, effCheck.db_out) annotation (Line(points={{-75,-11.4},
          {-75,-62},{-74,-62},{-74,-67.6},{-54,-67.6}},   color={0,0,127}));
  connect(senTem1.T, effCheck.db_in) annotation (Line(points={{49,-31.4},{
          49,-48},{-66,-48},{-66,-61.6},{-54,-61.6}},   color={0,0,127}));
  connect(senWetBul1.T, effCheck.wb_in) annotation (Line(points={{64,-31.4},
          {64,-72},{56,-72},{56,-94},{-72,-94},{-72,-73.2},{-54,-73.2}},
        color={0,0,127}));
  connect(dEC_EP_Method1_1.port_a2, senMasFlo1.port_a) annotation (Line(
        points={{20,5.6},{22,5.6},{22,-13},{24,-13}}, color={0,127,255}));
  connect(senMasFlo1.port_b, senTem1.port_a) annotation (Line(points={{34,
          -13},{40,-13},{40,-38},{44,-38}}, color={0,127,255}));
  connect(senMasFlo1.m_flow, effCheck.mFlow) annotation (Line(points={{29,-7.5},
          {29,-78},{-54,-78}},             color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{240,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{240,100}})));
end DEC_lumped;

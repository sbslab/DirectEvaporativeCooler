within DirectEvaporativeCooler.Obsolete;
model DEC_Physics_based
  "Validated using the system performance testing data of PG&E"
      extends Modelica.Icons.Example;
  replaceable package Medium1 = Buildings.Media.Water;
  replaceable package Medium2 = Buildings.Media.Air;

  Buildings.Fluid.Sources.Boundary_pT bou_air_indoor(
    redeclare package Medium = Medium2,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-116,-36},{-96,-16}})));
  Modelica.Blocks.Sources.RealExpression Temperature(y=280)
    annotation (Placement(transformation(extent={{-142,18},{-122,38}})));
  Modelica.Blocks.Sources.RealExpression waterMassFlowrate(y=0.32)
    "in pascals"
    annotation (Placement(transformation(extent={{-142,42},{-122,62}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow Pump(
    redeclare package Medium = Medium1,
    m_flow_nominal=0.32,
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=true,
    dp_nominal=11652.14,
    m_flow_start=0.32)
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
    tau=0) annotation (Placement(transformation(extent={{26,-48},{36,-36}})));
  Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul1(
    redeclare package Medium = Medium2,
    m_flow_nominal=0.5,
    tau=0) annotation (Placement(transformation(extent={{42,-48},{54,-36}})));
  Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum(
    redeclare package Medium = Medium2,
    m_flow_nominal=2.593,
    tau=0) annotation (Placement(transformation(extent={{-24,-24},{-14,-14}})));
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
  CoolingPadPhysicsBased DEC_PhysicalModel(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    m1_flow_nominal=0.32,
    m2_flow_nominal=1.5,
    dp1_nominal=11652.14,
    dp2_nominal=0.768*((0.0288)^(-0.469))*(1 + (DEC_PhysicalModel.m2_flow_nominal^1.139))*((DEC_PhysicalModel.m2_flow_nominal/DEC_PhysicalModel.PadArea)^2),
    Thickness=0.035,
    Length=0.5,
    Height=0.5,
    K_value=0.04,
    Contact_surface_area=470,
    DriftFactor=1.125,
    Rcon=12) annotation (Placement(transformation(extent={{-2,-6},{26,22}})));
  Modelica.Blocks.Sources.RealExpression Air_composition1(y=0.008844)
    annotation (Placement(transformation(extent={{178,-44},{158,-64}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=4,
    duration=100000,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{176,-4},{156,16}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow Fan(
    redeclare package Medium = Medium2,
    y_start=1,
    m_flow_nominal=1.5,
    redeclare parameter Buildings.Fluid.Movers.Data.Generic per,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=false,
    m_flow_start=0.201)
    annotation (Placement(transformation(extent={{86,-52},{66,-32}})));
  EffCheck effCheck annotation (Placement(transformation(extent={{-40,-78},{-20,-58}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo1in(redeclare package Medium =
               Medium2)
    annotation (Placement(transformation(extent={{28,-20},{38,-10}})));
equation
  connect(senWetBul.port_b,senMasFlo. port_a)
    annotation (Line(points={{-56,-19},{-42,-19}}, color={0,127,255}));
  connect(senTem1.port_b,senWetBul1. port_a)
    annotation (Line(points={{36,-42},{42,-42}}, color={0,127,255}));
  connect(senMasFlo.port_b,senRelHum. port_a)
    annotation (Line(points={{-32,-19},{-24,-19}}, color={0,127,255}));
  connect(senWetBul.port_a, senTem2.port_b) annotation (Line(points={{-66,-19},
          {-68,-19},{-68,-18},{-70,-18}}, color={0,127,255}));
  connect(senTem2.port_a, bou_air_indoor.ports[1]) annotation (Line(points={{-80,-18},
          {-86,-18},{-86,-26},{-96,-26}},          color={0,127,255}));
  connect(Temperature.y, Bou_water2.T_in) annotation (Line(points={{-121,28},{
          -114,28},{-114,26},{-106,26}}, color={0,0,127}));
  connect(DEC_PhysicalModel.port_b1, Bou_water1.ports[1]) annotation (Line(
        points={{26,17.5789},{42,17.5789},{42,22},{60,22}},
                                                      color={0,127,255}));
  connect(Bou_water2.ports[1], Pump.port_a)
    annotation (Line(points={{-84,22},{-54,22}}, color={0,127,255}));
  connect(Pump.port_b, DEC_PhysicalModel.port_a1) annotation (Line(points={{-34,22},
          {-16,22},{-16,17.5789},{-2,17.5789}},    color={0,127,255}));
  connect(waterMassFlowrate.y, Pump.m_flow_in) annotation (Line(points={{-121,
          52},{-88,52},{-88,54},{-44,54},{-44,34}}, color={0,0,127}));
  connect(senRelHum.port_b, DEC_PhysicalModel.port_b2) annotation (Line(
        points={{-14,-19},{-2,-19},{-2,-0.105263}},
                                              color={0,127,255}));
  connect(Air_composition.y, bou_air_outdoor.T_in)
    annotation (Line(points={{153,-24},{153,-46},{134,-46}}, color={0,0,127}));
  connect(bou_air_outdoor.Xi_in[1], Air_composition1.y) annotation (Line(points=
         {{134,-54},{146,-54},{146,-54},{157,-54}}, color={0,0,127}));
  connect(senWetBul1.port_b, Fan.port_b)
    annotation (Line(points={{54,-42},{66,-42}}, color={0,127,255}));
  connect(Fan.port_a, bou_air_outdoor.ports[1]) annotation (Line(points={{86,-42},
          {96,-42},{96,-50},{112,-50}},        color={0,127,255}));
  connect(ramp2.y, Fan.m_flow_in) annotation (Line(points={{155,6},{134,6},
          {134,-2},{76,-2},{76,-30}}, color={0,0,127}));
  connect(senTem1.T, effCheck.db_in) annotation (Line(points={{31,-35.4},{
          -52,-35.4},{-52,-59.6},{-42,-59.6}},   color={0,0,127}));
  connect(senTem2.T, effCheck.db_out) annotation (Line(points={{-75,-11.4},
          {-75,-65.6},{-42,-65.6}},   color={0,0,127}));
  connect(DEC_PhysicalModel.port_a2, senMasFlo1in.port_a) annotation (Line(
        points={{26,-0.105263},{26,-15},{28,-15}},
                                              color={0,127,255}));
  connect(senMasFlo1in.port_b, senTem1.port_a) annotation (Line(points={{38,
          -15},{40,-15},{40,-28},{24,-28},{24,-42},{26,-42}}, color={0,127,
          255}));
  connect(senMasFlo1in.m_flow, effCheck.mFlow) annotation (Line(points={{33,-9.5},
          {33,-6},{12,-6},{12,-90},{-50,-90},{-50,-76},{-42,-76}},
        color={0,0,127}));
  connect(senWetBul1.T, effCheck.wb_in) annotation (Line(points={{48,-35.4},
          {50,-35.4},{50,-24},{60,-24},{60,-112},{-62,-112},{-62,-71.2},{
          -42,-71.2}},   color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{240,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{240,100}})),
    experiment(
      StopTime=100000,
      Interval=900,
      __Dymola_Algorithm="Dassl"));
end DEC_Physics_based;

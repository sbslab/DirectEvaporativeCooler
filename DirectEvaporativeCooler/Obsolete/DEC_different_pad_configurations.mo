within DirectEvaporativeCooler.Obsolete;
model DEC_different_pad_configurations
      extends Modelica.Icons.Example;
    replaceable package Medium1 = Buildings.Media.Water;
  replaceable package Medium2 = Buildings.Media.Air;
  Buildings.Fluid.Sources.Boundary_pT bou_air_indoor(
    redeclare package Medium = Medium2,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-116,-36},{-96,-16}})));
  Modelica.Blocks.Sources.RealExpression Temperature(y=291.70)
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
  Modelica.Blocks.Sources.RealExpression mflow(y=7)
    annotation (Placement(transformation(extent={{174,12},{154,-8}})));
  Modelica.Blocks.Sources.RealExpression Air_composition(y=39.9 + 273.15)
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
    m2_flow_nominal=3.2,
    dp1_nominal=1162.14,
    dp2_nominal=50,
    Thickness=0.15,
    Length=3.78,
    Height=0.6,
    K_value=0.04,
    Contact_surface_area=370,
    Rcon=10) annotation (Placement(transformation(extent={{-4,-4},{24,24}})));
  Modelica.Blocks.Sources.RealExpression Air_composition1(y=0.015147)
    annotation (Placement(transformation(extent={{178,-44},{158,-64}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow Fan(
    redeclare package Medium = Medium2,
    y_start=1,
    m_flow_nominal=2.5,
    per(
      pressure(V_flow={1.63,1.67,1.71,1.74,1.78,1.83,1.90,1.95,2.003,2.04,2.09,2.14,
            2.18,2.23}, dp={145.9,136.04,124.4,120,110.1,99.0,85.4,75.55,65.67,54.56,
            42.22,28.64,18.76,7.65}),
      use_powerCharacteristic=true,
      power(V_flow={0.201,2.548516}, P={70,1870}),
      motorCooledByFluid=true,
      speed_rpm_nominal=420),
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    addPowerToMedium=true,
    nominalValuesDefineDefaultPressureCurve=false,
    m_flow_start=0.201)
    annotation (Placement(transformation(extent={{88,-52},{68,-32}})));
equation
  connect(senWetBul.port_b,senMasFlo. port_a)
    annotation (Line(points={{-56,-19},{-42,-19}}, color={0,127,255}));
  connect(senTem1.port_b,senWetBul1. port_a)
    annotation (Line(points={{36,-42},{42,-42}}, color={0,127,255}));
  connect(senMasFlo.port_b,senRelHum. port_a)
    annotation (Line(points={{-32,-19},{-24,-19}}, color={0,127,255}));
  connect(senWetBul.port_a,senTem2. port_b) annotation (Line(points={{-66,-19},
          {-68,-19},{-68,-18},{-70,-18}}, color={0,127,255}));
  connect(senTem2.port_a,bou_air_indoor. ports[1]) annotation (Line(points={{-80,-18},
          {-86,-18},{-86,-26},{-96,-26}},          color={0,127,255}));
  connect(Temperature.y,Bou_water2. T_in) annotation (Line(points={{-121,28},{
          -114,28},{-114,26},{-106,26}}, color={0,0,127}));
  connect(DEC_PhysicalModel.port_b1,Bou_water1. ports[1]) annotation (Line(
        points={{24,19.5789},{42,19.5789},{42,22},{60,22}},
                                                      color={0,127,255}));
  connect(DEC_PhysicalModel.port_a2,senTem1. port_a) annotation (Line(
        points={{24,1.89474},{26,1.89474},{26,-42}},
                                             color={0,127,255}));
  connect(Bou_water2.ports[1],Pump. port_a)
    annotation (Line(points={{-84,22},{-54,22}}, color={0,127,255}));
  connect(Pump.port_b,DEC_PhysicalModel. port_a1) annotation (Line(points={{-34,22},
          {-16,22},{-16,19.5789},{-4,19.5789}},    color={0,127,255}));
  connect(waterMassFlowrate.y,Pump. m_flow_in) annotation (Line(points={{-121,
          52},{-88,52},{-88,54},{-44,54},{-44,34}}, color={0,0,127}));
  connect(senRelHum.port_b,DEC_PhysicalModel. port_b2) annotation (Line(
        points={{-14,-19},{-4,-19},{-4,1.89474}},
                                              color={0,127,255}));
  connect(Air_composition.y,bou_air_outdoor. T_in)
    annotation (Line(points={{153,-24},{153,-46},{134,-46}}, color={0,0,127}));
  connect(bou_air_outdoor.Xi_in[1],Air_composition1. y) annotation (Line(points=
         {{134,-54},{146,-54},{146,-54},{157,-54}}, color={0,0,127}));
  connect(senWetBul1.port_b,Fan. port_b)
    annotation (Line(points={{54,-42},{68,-42}}, color={0,127,255}));
  connect(Fan.port_a,bou_air_outdoor. ports[1]) annotation (Line(points={{88,
          -42},{100,-42},{100,-50},{112,-50}}, color={0,127,255}));
  connect(mflow.y,Fan. m_flow_in)
    annotation (Line(points={{153,2},{78,2},{78,-30}},   color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
            {200,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-100},{200,100}})));
end DEC_different_pad_configurations;

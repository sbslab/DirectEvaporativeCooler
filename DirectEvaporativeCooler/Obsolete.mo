within DirectEvaporativeCooler;
package Obsolete
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

  model DEC_Physics_based_munters
    "Validated using the system performance testing data of PG&E"
        extends Modelica.Icons.Example;
    replaceable package Medium1 = Buildings.Media.Water;
    replaceable package Medium2 = Buildings.Media.Air;

    Buildings.Fluid.Sources.Boundary_pT bou_air_indoor(
      redeclare package Medium = Medium2,
      use_T_in=false,
      nPorts=1)
      annotation (Placement(transformation(extent={{-116,-36},{-96,-16}})));
    Modelica.Blocks.Sources.RealExpression Temperature(y=293.5)
      annotation (Placement(transformation(extent={{-144,22},{-124,42}})));
    Modelica.Blocks.Sources.RealExpression waterMassFlowrate(y=0.32)
      "in pascals"
      annotation (Placement(transformation(extent={{-144,46},{-124,66}})));
    Buildings.Fluid.Movers.FlowControlled_m_flow Pump(
      redeclare package Medium = Medium1,
      m_flow_nominal=0.32,
      addPowerToMedium=false,
      nominalValuesDefineDefaultPressureCurve=true,
      dp_nominal=11652.14,
      m_flow_start=0.32)
      annotation (Placement(transformation(extent={{-56,16},{-36,36}})));
    Buildings.Fluid.Sources.Boundary_ph Bou_water1(redeclare package Medium =
          Medium1, nPorts=1)
      annotation (Placement(transformation(extent={{78,16},{58,36}})));
    Modelica.Blocks.Sources.RealExpression Air_composition(y=313.5)
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
      tau=0) annotation (Placement(transformation(extent={{-26,-20},{-16,-10}})));
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
      annotation (Placement(transformation(extent={{-106,16},{-86,36}})));
    CoolingPadPhysicsBased DEC_PhysicalModel(
      redeclare package Medium1 = Medium1,
      redeclare package Medium2 = Medium2,
      allowFlowReversal1=true,
      allowFlowReversal2=true,
      m1_flow_nominal=0.32,
      m2_flow_nominal=1.5,
      dp1_nominal=11652.14,
      dp2_nominal=0.768*((0.0288)^(-0.469))*(1 + (DEC_PhysicalModel.m2_flow_nominal^1.139))*((DEC_PhysicalModel.m2_flow_nominal/DEC_PhysicalModel.PadArea)^2),
      Thickness=0.1,
      Length=0.335,
      Height=0.39,
      K_value=0.04,
      Contact_surface_area=370,
      DriftFactor=0.1,
      Rcon=3) annotation (Placement(transformation(extent={{-2,-6},{26,22}})));
    Modelica.Blocks.Sources.RealExpression Air_composition1(y=0.022)
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
      annotation (Line(points={{-32,-19},{-28,-19},{-28,-15},{-26,-15}},
                                                     color={0,127,255}));
    connect(senWetBul.port_a, senTem2.port_b) annotation (Line(points={{-66,-19},
            {-68,-19},{-68,-18},{-70,-18}}, color={0,127,255}));
    connect(senTem2.port_a, bou_air_indoor.ports[1]) annotation (Line(points={{-80,-18},
            {-86,-18},{-86,-26},{-96,-26}},          color={0,127,255}));
    connect(Temperature.y, Bou_water2.T_in) annotation (Line(points={{-123,32},
            {-116,32},{-116,30},{-108,30}},color={0,0,127}));
    connect(DEC_PhysicalModel.port_b1, Bou_water1.ports[1]) annotation (Line(
          points={{26,17.5789},{40,17.5789},{40,26},{58,26}},
                                                        color={0,127,255}));
    connect(Bou_water2.ports[1], Pump.port_a)
      annotation (Line(points={{-86,26},{-56,26}}, color={0,127,255}));
    connect(Pump.port_b, DEC_PhysicalModel.port_a1) annotation (Line(points={{-36,26},{-16,26},{-16,17.5789},{-2,17.5789}},
                                                     color={0,127,255}));
    connect(waterMassFlowrate.y, Pump.m_flow_in) annotation (Line(points={{-123,56},
            {-90,56},{-90,58},{-46,58},{-46,38}},     color={0,0,127}));
    connect(senRelHum.port_b, DEC_PhysicalModel.port_b2) annotation (Line(
          points={{-16,-15},{-2,-15},{-2,-0.105263}},
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
        Interval=60,
        __Dymola_Algorithm="Dassl"));
  end DEC_Physics_based_munters;

  model DEC_lumped_munters

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
    Modelica.Blocks.Sources.RealExpression Temperature(y=293.5)
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
    Modelica.Blocks.Sources.RealExpression Air_composition(y=313.5)
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
      PadArea=0.335,
      DriftFactor=0.390,
      Rcon=12) annotation (Placement(transformation(extent={{-8,0},{20,28}})));
    Modelica.Blocks.Sources.RealExpression Air_composition1(y=0.019)
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
  end DEC_lumped_munters;

  model lumpedPadmedia

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
    Modelica.Blocks.Sources.RealExpression Air_composition(y=303)
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
    Modelica.Blocks.Sources.RealExpression Air_composition1(y=0.0145)
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
  end lumpedPadmedia;

  model DEC_Physics_based_media
    "Validated using the system performance testing data of PG&E"
        extends Modelica.Icons.Example;
    replaceable package Medium1 = Buildings.Media.Water;
    replaceable package Medium2 = Buildings.Media.Air;

    Buildings.Fluid.Sources.Boundary_pT bou_air_indoor(
      redeclare package Medium = Medium2,
      use_T_in=false,
      nPorts=1)
      annotation (Placement(transformation(extent={{-116,-36},{-96,-16}})));
    Modelica.Blocks.Sources.RealExpression Temperature(y=293.5)
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
    Modelica.Blocks.Sources.RealExpression Air_composition(y=303.15)
      annotation (Placement(transformation(extent={{174,-14},{154,-34}})));
    Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul(
      redeclare package Medium = Medium2,
      m_flow_nominal=2.593,
      tau=0) annotation (Placement(transformation(extent={{-66,-22},{-56,-12}})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
          Medium2)
      annotation (Placement(transformation(extent={{-42,-24},{-32,-14}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(
      redeclare package Medium = Medium2,
      m_flow_nominal=2.593,
      tau=0) annotation (Placement(transformation(extent={{26,-46},{36,-34}})));
    Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul1(
      redeclare package Medium = Medium2,
      m_flow_nominal=0.5,
      tau=0) annotation (Placement(transformation(extent={{42,-46},{54,-34}})));
    Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum(
      redeclare package Medium = Medium2,
      m_flow_nominal=2.593,
      tau=0) annotation (Placement(transformation(extent={{-24,-24},{-14,-14}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTem2(
      redeclare package Medium = Medium2,
      m_flow_nominal=2.47,
      tau=0) annotation (Placement(transformation(extent={{-80,-22},{-70,-10}})));
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
      Thickness=0.07,
      Length=0.1,
      Height=0.135,
      K_value=0.04,
      Contact_surface_area=440,
      DriftFactor=0.1,
      Rcon=3) annotation (Placement(transformation(extent={{-2,-2},{26,26}})));
    Modelica.Blocks.Sources.RealExpression Air_composition1(y=0.0145)
      annotation (Placement(transformation(extent={{178,-44},{158,-64}})));
    Modelica.Blocks.Sources.Ramp ramp2(
      height=5,
      duration=100000,
      offset=0,
      startTime=0)
      annotation (Placement(transformation(extent={{176,-4},{156,16}})));
    Buildings.Fluid.Movers.FlowControlled_m_flow Fan(
      redeclare package Medium = Medium2,
      y_start=1,
      m_flow_nominal=1.8,
      redeclare parameter Buildings.Fluid.Movers.Data.Generic per(
        pressure(V_flow={1.651816075,1.8877898,2.123763525,2.35973725,
              2.595710975}, dp={211.514,174.188,124.42,74.652,12.442}),
        use_powerCharacteristic=true,
        power(V_flow={0.786751958,0.848986786,0.898774649,0.964121219,
              1.032579531,1.091702618,1.144602222,1.213060534,1.262848396,
              1.321971484,1.381094571,1.418435468,1.461999848,1.502452486}, P=
             {256.4202335,282.1011673,314.7859922,345.1361868,389.4941634,
              429.1828794,464.2023346,501.5564202,538.9105058,571.5953307,
              622.9571984,653.307393,692.9961089,728.0155642})),
      inputType=Buildings.Fluid.Types.InputType.Continuous,
      addPowerToMedium=false,
      nominalValuesDefineDefaultPressureCurve=false,
      m_flow_start=0.201)
      annotation (Placement(transformation(extent={{86,-50},{66,-30}})));
    EffCheck effCheck annotation (Placement(transformation(extent={{-40,-78},{-20,-58}})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFlo1in(redeclare package Medium =
                 Medium2)
      annotation (Placement(transformation(extent={{28,-18},{38,-8}})));
  equation
    connect(senWetBul.port_b,senMasFlo. port_a)
      annotation (Line(points={{-56,-17},{-50,-17},{-50,-19},{-42,-19}},
                                                     color={0,127,255}));
    connect(senTem1.port_b,senWetBul1. port_a)
      annotation (Line(points={{36,-40},{38,-40},{38,-38},{40,-38},{40,-40},{
            42,-40}},                              color={0,127,255}));
    connect(senMasFlo.port_b,senRelHum. port_a)
      annotation (Line(points={{-32,-19},{-24,-19}}, color={0,127,255}));
    connect(senWetBul.port_a, senTem2.port_b) annotation (Line(points={{-66,-17},
            {-68,-17},{-68,-16},{-70,-16}}, color={0,127,255}));
    connect(senTem2.port_a, bou_air_indoor.ports[1]) annotation (Line(points={{-80,-16},
            {-86,-16},{-86,-26},{-96,-26}},          color={0,127,255}));
    connect(Temperature.y, Bou_water2.T_in) annotation (Line(points={{-121,28},{
            -114,28},{-114,26},{-106,26}}, color={0,0,127}));
    connect(DEC_PhysicalModel.port_b1, Bou_water1.ports[1]) annotation (Line(
          points={{26,21.5789},{42,21.5789},{42,22},{60,22}},
                                                        color={0,127,255}));
    connect(Bou_water2.ports[1], Pump.port_a)
      annotation (Line(points={{-84,22},{-54,22}}, color={0,127,255}));
    connect(Pump.port_b, DEC_PhysicalModel.port_a1) annotation (Line(points={{-34,22},
            {-16,22},{-16,21.5789},{-2,21.5789}},    color={0,127,255}));
    connect(waterMassFlowrate.y, Pump.m_flow_in) annotation (Line(points={{-121,
            52},{-88,52},{-88,54},{-44,54},{-44,34}}, color={0,0,127}));
    connect(senRelHum.port_b, DEC_PhysicalModel.port_b2) annotation (Line(
          points={{-14,-19},{-2,-19},{-2,3.89474}},
                                                color={0,127,255}));
    connect(Air_composition.y, bou_air_outdoor.T_in)
      annotation (Line(points={{153,-24},{153,-46},{134,-46}}, color={0,0,127}));
    connect(bou_air_outdoor.Xi_in[1], Air_composition1.y) annotation (Line(points=
           {{134,-54},{146,-54},{146,-54},{157,-54}}, color={0,0,127}));
    connect(senWetBul1.port_b, Fan.port_b)
      annotation (Line(points={{54,-40},{58,-40},{58,-38},{60,-38},{60,-40},{
            66,-40}},                              color={0,127,255}));
    connect(Fan.port_a, bou_air_outdoor.ports[1]) annotation (Line(points={{86,-40},
            {96,-40},{96,-50},{112,-50}},        color={0,127,255}));
    connect(ramp2.y, Fan.m_flow_in) annotation (Line(points={{155,6},{134,6},
            {134,-2},{76,-2},{76,-28}}, color={0,0,127}));
    connect(senTem1.T, effCheck.db_in) annotation (Line(points={{31,-33.4},{
            -52,-33.4},{-52,-59.6},{-42,-59.6}},   color={0,0,127}));
    connect(senTem2.T, effCheck.db_out) annotation (Line(points={{-75,-9.4},{
            -75,-65.6},{-42,-65.6}},    color={0,0,127}));
    connect(DEC_PhysicalModel.port_a2, senMasFlo1in.port_a) annotation (Line(
          points={{26,3.89474},{26,-13},{28,-13}},
                                               color={0,127,255}));
    connect(senMasFlo1in.port_b, senTem1.port_a) annotation (Line(points={{38,-13},
            {40,-13},{40,-28},{24,-28},{24,-40},{26,-40}},      color={0,127,
            255}));
    connect(senMasFlo1in.m_flow, effCheck.mFlow) annotation (Line(points={{33,-7.5},
            {33,-6},{12,-6},{12,-90},{-50,-90},{-50,-76},{-42,-76}},
          color={0,0,127}));
    connect(senWetBul1.T, effCheck.wb_in) annotation (Line(points={{48,-33.4},
            {50,-33.4},{50,-24},{60,-24},{60,-112},{-62,-112},{-62,-71.2},{
            -42,-71.2}},   color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(extent={{-160,-100},{240,100}})),
      Icon(coordinateSystem(extent={{-160,-100},{240,100}})),
      experiment(
        StopTime=100000,
        Interval=60,
        __Dymola_Algorithm="Dassl"));
  end DEC_Physics_based_media;

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
    Buildings.Fluid.Sensors.RelativePressure          senRelPre(redeclare
        package                                                                   Medium =
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

  block EffCheck "Model to calculate efficiency from outlet conditions"
    Modelica.Blocks.Interfaces.RealInput db_in annotation (Placement(transformation(extent={{-140,64},
              {-100,104}}),
          iconTransformation(extent={{-140,64},{-100,104}})));
    Modelica.Blocks.Interfaces.RealInput db_out
      annotation (Placement(transformation(extent={{-140,4},{-100,44}}),iconTransformation(extent={{-140,4},
              {-100,44}})));
    Modelica.Blocks.Interfaces.RealInput wb_in annotation (Placement(transformation(extent={{-140,
              -52},{-100,-12}}),
          iconTransformation(extent={{-140,-52},{-100,-12}})));
    Modelica.Blocks.Interfaces.RealOutput efficiency_cal
      annotation (Placement(transformation(extent={{98,20},{118,40}}), iconTransformation(extent={{100,18},
              {128,46}})));

    Modelica.Blocks.Interfaces.RealInput mFlow "in m3/s" annotation (Placement(transformation(extent={{-126,-56},{-86,-16}}),
          iconTransformation(extent={{-140,-100},{-100,-60}})));
    Modelica.Blocks.Interfaces.RealOutput m3_s
      annotation (Placement(transformation(extent={{92,22},{112,42}}), iconTransformation(extent={{100,-42},
              {128,-14}})));
  equation

    efficiency_cal = (db_in - db_out)/(db_in - wb_in);
    m3_s = mFlow * (- 0.8163);

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end EffCheck;

  block NTU_effectiveness "Calculating the NTU and Effectiveness for the DEC model"
    Modelica.Blocks.Interfaces.RealInput m2_flow "Mass flow rate of air"
      annotation (Placement(transformation(extent={{-116,50},{-76,90}}),
          iconTransformation(extent={{-130,44},{-100,74}})));
    Modelica.Blocks.Interfaces.RealInput T_wb1
      "inlet wet bulb temperature of air" annotation (Placement(transformation(
            extent={{-116,50},{-76,90}}), iconTransformation(extent={{-130,10},
              {-100,40}})));
    Modelica.Blocks.Interfaces.RealInput T_db1
      "Inlet Drybulb temperature of air"
      annotation (Placement(transformation(extent={{-116,50},{-76,90}}),
          iconTransformation(extent={{-130,-24},{-100,6}})));
    Modelica.Blocks.Interfaces.RealInput Tw1 "Water inlet temperature"
      annotation (Placement(transformation(extent={{-116,50},{-76,90}}),
          iconTransformation(extent={{-130,-60},{-100,-30}})));
    Modelica.Blocks.Interfaces.RealOutput T_db2 "Outlet drybulb temperature"
      annotation (Placement(transformation(extent={{100,46},{120,66}}),
          iconTransformation(extent={{100,46},{120,66}})));
    Modelica.Blocks.Interfaces.RealOutput Tw2 "Outlet water temperature"
      annotation (Placement(transformation(extent={{92,46},{112,66}}),
          iconTransformation(extent={{100,18},{120,38}})));
    Modelica.Blocks.Interfaces.RealOutput X_w2 "Outlet humidity ratio"
      annotation (Placement(transformation(extent={{92,46},{112,66}}),
          iconTransformation(extent={{100,-8},{120,12}})));

    Real gama "constant depending on pad material and pad configu- ration like ξ";
    Real Nu " Nusselt number";
    Real Re " Reynolds number";
    Real Pr
           " Prandtl number";
    Real Mu " Dynamic viscosity";
    Real Cpa  " Specific heat of air";
    parameter Real p_atm " Atmospheric pressure";
    parameter Real k "Thermal conductivity";
    parameter Real v_a "air velocity";
    Real rho " air density";
    parameter Real Thickness "thickness of the cooling pad";
    parameter Real Area_s " area of the cooling pad";
    Real l
          "Characteristic length";
    Real NTU " Net transfer unit";
    parameter Real V "volume flow rate";
    Real phi " Intermediate variable - relative humidity";
    Real Mr " mass transfer coefficient";
    Real alfa, beta;
    Real T_wb2, TDew, p_wat,ed,ew,e,B,RH;

    Modelica.Blocks.Interfaces.RealOutput hm "mass transfer coefficient "
      annotation (Placement(transformation(extent={{92,46},{112,66}}),
          iconTransformation(extent={{100,-40},{120,-20}})));
    Modelica.Blocks.Interfaces.RealOutput hc
      "convective heat transfer coefficient" annotation (Placement(transformation(
            extent={{92,46},{112,66}}), iconTransformation(extent={{100,-66},
              {120,-46}})));
  algorithm

    // calculating Nusselts number to compute hc, as Nu gives a relationship between conductive and convective heat transfer
  l:= (Area_s / Thickness);
   gama := 0.1 * l^0.12;
   rho := p_atm/287.08 * T_wb1;
   Re := Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(v_a, rho, Mu, l);
   Pr := Modelica.Fluid.Dissipation.Utilities.Functions.General.PrandtlNumber(Cpa, Mu, k);
   Nu:= gama * Re^0.8 * Pr^0.33;

   hc := Nu * k;
   //Lewis relationship between convective heat transfer coefficient and mass transfer coefficient (Le ~ 1 for water vapour and air)
   hm := hc/Cpa;
   //Net transfer unit calculation
   NTU := (hc * Area_s)/(m2_flow * Cpa);
   // calculating the efficiency of the cooling pad
   // calculated using alfa, beta and Mr

   alfa := (Tw1 - T_wb1)/(T_db1 - T_wb1);
   beta := 0.44 * (alfa ^ 0.932)* (NTU^0.089)* (Mr^(-0.116));
   Tw2 := Tw1 - beta*(T_db1-T_wb1);
   Mr := (m2_flow/V);
   phi := 1- exp(-1.07*(NTU^0.295))* alfa ^(-0.556) * Mr^(-0.051);
   //η= ϕη_1
   //η_1=1-exp⁡[-1.037 NTU]
   //η=(T_db1- T_db2)/(T_db1- T_wb1)

   T_db2 := T_db1 - ((T_db1 - T_wb1)*phi*(1-exp((-1.037)*NTU)));
   // Humidity ratio for the outlet condition
   //assuming WBT in = WBT out ;

   T_wb2:= T_wb1;

   //computing RH(phi) using Tdb_out, Twb_out and atmospheric pressure

  ed := 6.108 * exp((17.27*T_db2)/(237.3+T_db2))     "Saturation Vapor Pressure at Dry Bulb (mb)";
  ew := 6.108 * exp((17.27*T_wb2)/(237.3+T_wb2))     "Saturation Vapor Pressure at wet bulb Bulb (mb)";
  e := ew - (0.00066 * (1+0.00115*T_wb2)*(T_db2-T_wb2)*(p_atm/100));
  RH := 100*(e/ed);
  B := log(e/6.108)/17.27;
  TDew := (237.3*B)/(1-B);
  p_wat := (6.11* 10^((7.5*TDew)/(237.3+TDew)))*100;
  X_w2 := Buildings.Utilities.Psychrometrics.Functions.X_pW(p_wat);

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end NTU_effectiveness;

  model CoolingPadLumped "The DEC lumped model is implemented  based on the equations that are used in EnergyPlus engineering reference"

        extends Buildings.Fluid.Interfaces.PartialFourPortInterface(
        replaceable package Medium2 =
          Modelica.Media.Interfaces.PartialCondensingGases,
      allowFlowReversal2=false,
      allowFlowReversal1=false,
      port_a1(h_outflow(start=h1_outflow_start)),
      port_b1(h_outflow(start=h1_outflow_start)),
      port_a2(h_outflow(start=h2_outflow_start)),
      port_b2(h_outflow(start=h2_outflow_start)));
    extends Buildings.Fluid.Interfaces.FourPortFlowResistanceParameters(
       final computeFlowResistance1=true, final computeFlowResistance2=true);

    parameter Modelica.Units.SI.Thickness PadThickness=0.3
      "Evaporative cooling pad thickness(m)" annotation (Dialog(group=
            "Evaporative cooler pad", enable=not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));

    parameter Modelica.Units.SI.Area PadArea=0.2
      "Evaporative cooling pad area(m2)" annotation (Dialog(group=
            "Evaporative cooler pad", enable=not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));

   parameter Real DriftFactor = 0.2
      "Drift factor[user input]"
    annotation (Dialog(group="Evaporative cooler pad",
                  enable=not (energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState)));

   parameter Real Rcon = 0.2
      "Ratio of solids in the blowdown water[user input]"
    annotation (Dialog(group="Evaporative cooler pad",
                  enable=not (energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState)));

    parameter Modelica.Units.SI.Time tau1=1 "Time constant at nominal flow"
      annotation (Dialog(tab="Dynamics", group="Nominal condition"));
    parameter Modelica.Units.SI.Time tau2=1 "Time constant at nominal flow"
      annotation (Dialog(tab="Dynamics", group="Nominal condition"));

    // Advanced
    parameter Boolean homotopyInitialization = true "= true, use homotopy method"
      annotation(Evaluate=true, Dialog(tab="Advanced"));

    // Assumptions
    parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
      "Type of energy balance: dynamic (3 initialization options) or steady state"
      annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
    parameter Modelica.Fluid.Types.Dynamics massDynamics=if tau1 > Modelica.Constants.eps
         then energyDynamics else Modelica.Fluid.Types.Dynamics.SteadyState
      "Type of mass balance: dynamic (3 initialization options) or steady state"
      annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

    // Initialization
    parameter Medium1.AbsolutePressure p1_start = Medium1.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Medium 1"));
    parameter Medium1.Temperature T1_start = Medium1.T_default
      "Start value of temperature"
      annotation(Dialog(tab = "Initialization", group = "Medium 1"));
    parameter Medium1.MassFraction X1_start[Medium1.nX] = Medium1.X_default
      "Start value of mass fractions m_i/m"
      annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nXi > 0));
    parameter Medium1.ExtraProperty C1_start[Medium1.nC](
      final quantity=Medium1.extraPropertiesNames)=fill(0, Medium1.nC)
      "Start value of trace substances"
      annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nC > 0));
    parameter Medium1.ExtraProperty C1_nominal[Medium1.nC](
      final quantity=Medium1.extraPropertiesNames) = fill(1E-2, Medium1.nC)
      "Nominal value of trace substances. (Set to typical order of magnitude.)"
     annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nC > 0));

    parameter Medium2.AbsolutePressure p2_start = Medium2.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Medium 2"));
    parameter Medium2.Temperature T2_start = Medium2.T_default
      "Start value of temperature"
      annotation(Dialog(tab = "Initialization", group = "Medium 2"));
    parameter Medium2.MassFraction X2_start[Medium2.nX] = Medium2.X_default
      "Start value of mass fractions m_i/m"
      annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nXi > 0));
    parameter Medium2.ExtraProperty C2_start[Medium2.nC](
      final quantity=Medium2.extraPropertiesNames)=fill(0, Medium2.nC)
      "Start value of trace substances"
      annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nC > 0));
    parameter Medium2.ExtraProperty C2_nominal[Medium2.nC](
      final quantity=Medium2.extraPropertiesNames) = fill(1E-2, Medium2.nC)
      "Nominal value of trace substances. (Set to typical order of magnitude.)"
     annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nC > 0));

    Modelica.Units.SI.HeatFlowRate Q1_flow=VolWat.heatPort.Q_flow
      "Heat flow rate into medium 1";
    Modelica.Units.SI.HeatFlowRate Q2_flow=VolAir.heatPort.Q_flow
      "Heat flow rate into medium 2";

    replaceable
      Buildings.Fluid.MixingVolumes.BaseClasses.MixingVolumeHeatPort VolWat(nPorts=3)
      constrainedby
      Buildings.Fluid.MixingVolumes.BaseClasses.MixingVolumeHeatPort(
      redeclare final package Medium = Medium1,
      nPorts=2,
      V=m1_flow_nominal*tau1/rho1_nominal,
      final allowFlowReversal=allowFlowReversal1,
      final m_flow_nominal=m1_flow_nominal,
      energyDynamics=if tau1 > Modelica.Constants.eps then energyDynamics
           else Modelica.Fluid.Types.Dynamics.SteadyState,
      massDynamics=if tau1 > Modelica.Constants.eps then massDynamics else
          Modelica.Fluid.Types.Dynamics.SteadyState,
      final p_start=p1_start,
      final T_start=T1_start,
      final X_start=X1_start,
      final C_start=C1_start,
      final C_nominal=C1_nominal,
      mSenFac=1) "Volume for fluid 1"
      annotation (Placement(transformation(extent={{-54,-60},{-74,-80}})));

    replaceable Buildings.Fluid.MixingVolumes.MixingVolumeMoistAir VolAir(nPorts=2)
      constrainedby
      Buildings.Fluid.MixingVolumes.BaseClasses.MixingVolumeHeatPort(
      redeclare final package Medium = Medium2,
      nPorts=2,
      V=m2_flow_nominal*tau2/rho2_nominal,
      final allowFlowReversal=allowFlowReversal2,
      mSenFac=1,
      final m_flow_nominal=m2_flow_nominal,
      energyDynamics=if tau2 > Modelica.Constants.eps then energyDynamics
           else Modelica.Fluid.Types.Dynamics.SteadyState,
      massDynamics=if tau2 > Modelica.Constants.eps then massDynamics else
          Modelica.Fluid.Types.Dynamics.SteadyState,
      final p_start=p2_start,
      final T_start=T2_start,
      final X_start=X2_start,
      final C_start=C2_start,
      final C_nominal=C2_nominal) "Volume for fluid 2" annotation (Placement(
          transformation(
          origin={78,50},
          extent={{10,-10},{-10,10}},
          rotation=180)));

    BaseClasses.OutletConditions HeaTraLum
      annotation (Placement(transformation(extent={{-13,-13},{7,7}})));
  public
    BaseClasses.CoolingPadEfficiencyLumped Eff_Lum(tk_pad=PadThickness) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort TWetBul(
      redeclare package Medium = Medium2,
      allowFlowReversal=true,
      m_flow_nominal=m2_flow_nominal,
      tau=0,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      TWetBul_start(displayUnit="K"))
      annotation (Placement(transformation(extent={{-35,65},{-25,55}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort TDryBul(
      redeclare package Medium = Medium2,
      m_flow_nominal=m2_flow_nominal,
      tau=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      T_start(displayUnit="K"))                annotation (Placement(transformation(extent={{-25,65},
              {-15,55}})));
    Modelica.Blocks.Math.Product VolumeFlowRate2MassFlowRate annotation (Placement(transformation(extent={{5,5},{
              -5,-5}},
          rotation=90,
          origin={55,-15})));
    parameter String substanceName "Name of species substance";
    Buildings.Fluid.Sensors.MassFractionTwoPort SenMasFra(
      redeclare package Medium = Buildings.Media.Air,
      m_flow_nominal=m2_flow_nominal,
      tau=tau2,
      initType=Modelica.Blocks.Types.Init.NoInit)
                annotation (Placement(transformation(extent={{10,65},{20,55}})));
    BaseClasses.WaterConsumption WatCon(f_drift=DriftFactor, Rcon=Rcon) annotation (Placement(transformation(extent={{20,10},{40,30}})));
    Modelica.Fluid.Sources.MassFlowSource_T MasFlo(
      redeclare package Medium = Medium1,
      use_m_flow_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-16,-52},{-30,-38}})));
    Modelica.Blocks.Math.Product VolumeFlowRate2MassFlowRate1
                                                             annotation (Placement(transformation(extent={{-5,-5},
              {5,5}},
          rotation=90,
          origin={55,30})));
    Modelica.Blocks.Math.Gain gain(k=-1)
      annotation (Placement(transformation(extent={{3,-3},{-3,3}},
          rotation=90,
          origin={55,-30})));
    Buildings.Fluid.FixedResistances.PressureDrop res(redeclare package Medium =
                 Medium2)
      annotation (Placement(transformation(extent={{30,50},{50,70}})));
    Buildings.Fluid.FixedResistances.PressureDrop res1(
      redeclare package Medium = Medium1,
      m_flow_nominal=m1_flow_nominal,
      dp_nominal=1000)
      annotation (Placement(transformation(extent={{70,-70},{50,-50}})));
  protected
    parameter Medium1.ThermodynamicState sta1_nominal=Medium1.setState_pTX(
        T=Medium1.T_default, p=Medium1.p_default, X=Medium1.X_default);
    parameter Modelica.Units.SI.Density rho1_nominal=Medium1.density(
        sta1_nominal) "Density, used to compute fluid volume";
    parameter Medium2.ThermodynamicState sta2_nominal=Medium2.setState_pTX(
        T=Medium2.T_default, p=Medium2.p_default, X=Medium2.X_default);
    parameter Modelica.Units.SI.Density rho2_nominal=Medium2.density(
        sta2_nominal) "Density, used to compute fluid volume";

    parameter Medium1.ThermodynamicState sta1_start=Medium1.setState_pTX(
        T=T1_start, p=p1_start, X=X1_start);
    parameter Modelica.Units.SI.SpecificEnthalpy h1_outflow_start=
        Medium1.specificEnthalpy(sta1_start)
      "Start value for outflowing enthalpy";
    parameter Medium2.ThermodynamicState sta2_start=Medium2.setState_pTX(
        T=T2_start, p=p2_start, X=X2_start);
    parameter Modelica.Units.SI.SpecificEnthalpy h2_outflow_start=
        Medium2.specificEnthalpy(sta2_start)
      "Start value for outflowing enthalpy";

   Buildings.Fluid.Sensors.DensityTwoPort SenDen(
      redeclare package Medium = Medium1,
      m_flow_nominal=m1_flow_nominal,
      tau=tau1,
      initType=Modelica.Blocks.Types.Init.InitialState)
     annotation (Placement(transformation(extent={{20,-65},{11,-55}})));
   Buildings.Fluid.Sensors.Velocity SenVel(
      redeclare package Medium = Medium2,
      m_flow_nominal=m2_flow_nominal,
      tau=tau2,
      initType=Modelica.Blocks.Types.Init.InitialState,
      T_start(displayUnit="K"),
      A=PadArea)
     annotation (Placement(transformation(extent={{-80,65},{-70,55}})));
   Buildings.Fluid.Sensors.MassFlowRate SenMasFlo(redeclare package Medium =
          Medium2)
     annotation (Placement(transformation(extent={{0,65},{10,55}})));
  initial equation
    // Check for tau1
    assert((energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
            tau1 > Modelica.Constants.eps,
  "The parameter tau1, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau1 = "   + String(tau1) + "\n");
    assert((massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
            tau1 > Modelica.Constants.eps,
  "The parameter tau1, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau1 = "   + String(tau1) + "\n");

   // Check for tau2
    assert((energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
            tau2 > Modelica.Constants.eps,
  "The parameter tau2, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau2 = "   + String(tau2) + "\n");
    assert((massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
            tau2 > Modelica.Constants.eps,
  "The parameter tau2, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau2 = "   + String(tau2) + "\n");

  equation
    connect(port_b2, VolWat.ports[1]) annotation (Line(points={{-100,-60},{-61.3333,-60}},
                            color={0,127,255},
        thickness=1));
    connect(VolWat.ports[2], SenDen.port_b)
      annotation (Line(points={{-64,-60},{11,-60}},color={0,127,255},
        thickness=1));
    connect(VolAir.ports[1], port_b1)
      annotation (Line(points={{76,60},{100,60}}, color={0,127,255},
        thickness=1));
    connect(port_a1, SenVel.port_a)
      annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255},
        thickness=1));
    connect(TWetBul.port_b, TDryBul.port_a)
      annotation (Line(points={{-25,60},{-25,60}}, color={0,127,255}));
    connect(SenVel.port_b, TWetBul.port_a)
      annotation (Line(points={{-70,60},{-35,60}}, color={0,127,255},
        thickness=1));
    connect(TDryBul.port_b, SenMasFlo.port_a)
      annotation (Line(points={{-15,60},{0,60}},   color={0,127,255},
        thickness=1));
    connect(SenMasFlo.port_b, SenMasFra.port_a)
      annotation (Line(points={{10,60},{10,60}},
                                               color={0,127,255}));
    connect(MasFlo.m_flow_in, gain.y) annotation (Line(points={{-16,-39.4},{
            55,-39.4},{55,-33.3}},          color={0,0,127},
        pattern=LinePattern.Dash));
    connect(MasFlo.ports[1], VolWat.ports[3]) annotation (Line(points={{-30,-45},{-64,-45},{-64,-60},{-66.6667,-60}},
                                                      color={50,172,248},
        thickness=0.5));
    connect(VolumeFlowRate2MassFlowRate.y, gain.u) annotation (Line(points={{55,
            -20.5},{55,-26.4}},                      color={0,0,127},
        pattern=LinePattern.Dash));
    connect(SenMasFra.port_b, res.port_a) annotation (Line(
        points={{20,60},{30,60}},
        color={0,127,255},
        thickness=1));
    connect(res.port_b, VolAir.ports[2]) annotation (Line(
        points={{50,60},{80,60}},
        color={0,127,255},
        thickness=1));
    connect(SenDen.port_a, res1.port_b) annotation (Line(
        points={{20,-60},{50,-60}},
        color={0,127,255},
        thickness=1));
    connect(res1.port_a, port_a2) annotation (Line(
        points={{70,-60},{100,-60}},
        color={0,127,255},
        thickness=1));
    connect(SenVel.v, Eff_Lum.vel_air) annotation (Line(points={{-75,54.5},{
            -75,0},{-62,0}}, color={0,0,127},
        pattern=LinePattern.Dash));
    connect(Eff_Lum.efficiency, HeaTraLum.Efficiency) annotation (Line(points={{-38.5,-7.3},{-31.25,-7.3},{-31.25,-9},{-15,-9}},
                                                                  color={0,0,127},
        pattern=LinePattern.Dash));

    connect(TDryBul.T, HeaTraLum.Tdb_air) annotation (Line(
        points={{-20,54.5},{-20,3},{-15,3}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(TWetBul.T, HeaTraLum.Twb_air) annotation (Line(points={{-30,54.5},{-30,-3},{-15,-3}},
                                    color={0,0,127},
        pattern=LinePattern.Dash));
    connect(SenMasFra.X, WatCon.W_in) annotation (Line(
        points={{15,54.5},{15,26},{18,26}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(SenMasFlo.m_flow, WatCon.m_flo) annotation (Line(
        points={{5,54.5},{5,20},{18,20}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(HeaTraLum.Wx_out, WatCon.W_out) annotation (Line(points={{8.5,-3.1},{10,-3.1},{10,14},{18,14}},
                                                    color={0,0,127},
        pattern=LinePattern.Dash));
    connect(SenDen.d, WatCon.Density) annotation (Line(
        points={{15.5,-54.5},{15.5,13.1},{18.5,13.1}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(WatCon.Vol_evap, VolumeFlowRate2MassFlowRate1.u1) annotation (
        Line(
        points={{41.4,23},{52,23},{52,24}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(VolumeFlowRate2MassFlowRate1.y, VolAir.mWat_flow) annotation (
        Line(
        points={{55,35.5},{55,42},{66,42}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(SenDen.d, VolumeFlowRate2MassFlowRate1.u2) annotation (Line(
        points={{15.5,-54.5},{15.5,0},{58,0},{58,24}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(WatCon.Vol_water, VolumeFlowRate2MassFlowRate.u2) annotation (
        Line(
        points={{41.4,17},{52,17},{52,-9}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(SenDen.d, VolumeFlowRate2MassFlowRate.u1) annotation (Line(
        points={{15.5,-54.5},{15.5,0},{58,0},{58,-9}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    annotation (
      Documentation(info="<html>
<p>
This component transports two fluid streams between four ports.
It provides the basic model for implementing a dynamic heat exchanger.
</p>
<p>
The model can be used as-is, although there will be no heat or mass transfer
between the two fluid streams.
To add heat transfer, heat flow can be added to the heat port of the two volumes.
See for example
<a href=\"Buildings.Fluid.Chillers.Carnot_y\">
Buildings.Fluid.Chillers.Carnot_y</a>.
To add moisture input into (or moisture output from) volume <code>vol2</code>,
the model can be replaced with
<a href=\"modelica://Buildings.Fluid.MixingVolumes.MixingVolumeMoistAir\">
Buildings.Fluid.MixingVolumes.MixingVolumeMoistAir</a>.
</p>
<h4>Implementation</h4>
<p>
The variable names follow the conventions used in
<a href=\"modelica://Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX\">
Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX</a>.
</p>
</html>",   revisions="<html>
<ul>
<li>
October 23, 2017, by Michael Wetter:<br/>
Made volume <code>vol1</code> replaceable. This is required for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1013\">Buildings, issue 1013</a>.
</li>
<li>
December 1, 2016, by Michael Wetter:<br/>
Updated model as <code>use_dh</code> is no longer a parameter in the pressure drop model.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/480\">#480</a>.
</li>
<li>
April 11, 2016 by Michael Wetter:<br/>
Corrected wrong hyperlink in documentation for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/450\">issue 450</a>.
</li>
<li>
January 26, 2016, by Michael Wetter:<br/>
Set <code>quantity</code> attributes.
</li>
<li>
November 13, 2015, by Michael Wetter:<br/>
Changed assignments of start values in <code>extends</code> statement.
This is for issue
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/299\">#299</a>.
</li>
<li>
June 2, 2015, by Filip Jorissen:<br/>
Removed final modifier from <code>mSenFac</code> in
<code>vol1</code> and <code>vol2</code>.
This is for issue
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/258=\">#258</a>.
</li>
<li>
May 6, 2015, by Michael Wetter:<br/>
Added missing propagation of <code>allowFlowReversal</code> to
instances <code>vol1</code> and <code>vol2</code>.
This is for issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/412\">#412</a>.
</li>
<li>
October 6, 2014, by Michael Wetter:<br/>
Changed medium declaration in pressure drop elements to be final.
</li>
<li>
May 28, 2014, by Michael Wetter:<br/>
Removed <code>annotation(Evaluate=true)</code> for parameters <code>tau1</code>
and <code>tau2</code>.
This is needed to allow changing the time constant after translation.
</li>
<li>
November 12, 2013, by Michael Wetter:<br/>
Removed <code>import Modelica.Constants</code> statement.
</li>
<li>
October 8, 2013, by Michael Wetter:<br/>
Removed parameter <code>show_V_flow</code>.
</li>
<li>
September 26, 2013, by Michael Wetter:<br/>
Removed unrequired <code>sum</code> operator.
</li>
<li>
February 6, 2012, by Michael Wetter:<br/>
Updated documentation.
</li>
<li>
February 3, 2012, by Michael Wetter:<br/>
Removed assignment of <code>m_flow_small</code> as it is no
longer used in its base class.
</li>
<li>
July 29, 2011, by Michael Wetter:
<ul>
<li>
Changed values of
<code>h_outflow_a1_start</code>,
<code>h_outflow_b1_start</code>,
<code>h_outflow_a2_start</code> and
<code>h_outflow_b2_start</code>, and
declared them as final.
</li>
<li>
Set nominal values for <code>vol1.C</code> and <code>vol2.C</code>.
</li>
</ul>
</li>
<li>
July 11, 2011, by Michael Wetter:<br/>
Changed parameterization of fluid volume so that steady-state balance is
used when <code>tau = 0</code>.
</li>
<li>
March 25, 2011, by Michael Wetter:<br/>
Added homotopy operator.
</li>
<li>
April 13, 2009, by Michael Wetter:<br/>
Added model to compute flow friction.
</li>
<li>
September 10, 2008 by Michael Wetter:<br/>
Added <code>stateSelect=StateSelect.always</code> for temperature of volume 1.
</li>
<li>
Changed temperature sensor from Celsius to Kelvin.
Unit conversion should be made during output
processing.
</li>
<li>
August 5, 2008, by Michael Wetter:<br/>
Replaced instances of <code>Delays.DelayFirstOrder</code> with instances of
<code>MixingVolumes.MixingVolume</code>. This allows to extract liquid for a condensing cooling
coil model.
</li>
<li>
March 25, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
      Icon(coordinateSystem(
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-99,64},{102,54}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-99,-56},{102,-66}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Bitmap(extent={{-36,-108},{109,92}},
            imageSource=
                "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",
            fileName=
                "modelica://Evaporative_Coolers_rev/../OneDrive/Desktop/Image for paper/pad.PNG")}),
      Diagram(coordinateSystem(grid={1,1}),
              graphics={Text(
            extent={{70,100},{95,90}},
            lineColor={28,108,200},
            textString="Air Side",
            fontName="serif"),
                        Text(
            extent={{66,-89},{98,-101}},
            lineColor={28,108,200},
            textString="Water Side",
            fontName="serif"),
                        Text(
            extent={{24,72},{54,62}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Flow Resistance 1"),
                        Text(
            extent={{60,35},{103,24}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Mixing Volume with 
Static conservation equation
"),                     Text(
            extent={{42,50},{64,41}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Mass Fraction,Xw"),
                        Text(
            extent={{42,-49},{74,-59}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Flow Resistance 2"),
                        Text(
            extent={{-64,-33},{-31,-52}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Removed Mass flow rate
"),                     Text(
            extent={{-87,-87},{-39,-99}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Mixing Volume with 
Static conservation equation
"),                     Text(
            extent={{-44,-9},{-27,-13}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Eff"),
                        Text(
            extent={{-2,18},{10,14}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="X out"),
                        Text(
            extent={{16,54},{28,50}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="X in")}));
  end CoolingPadLumped;

  model CoolingPadPhysicsBased "The DECPhysics based model  using heat and mass transfer relationship  [based on pad configuration]"

        extends Buildings.Fluid.Interfaces.PartialFourPortInterface(
        replaceable package Medium1 =
          Modelica.Media.Interfaces.PartialCondensingGases,
      allowFlowReversal2=false,
      allowFlowReversal1=false,
      port_a1(h_outflow(start=h1_outflow_start)),
      port_b1(h_outflow(start=h1_outflow_start)),
      port_a2(h_outflow(start=h2_outflow_start)),
      port_b2(h_outflow(start=h2_outflow_start)));
    extends Buildings.Fluid.Interfaces.FourPortFlowResistanceParameters(
       final computeFlowResistance1=true, final computeFlowResistance2=true);

    parameter Modelica.SIunits.Thickness Thickness=0.100
      "Evaporative cooling pad thickness(m)" annotation (Dialog(group=
            "Evaporative cooler pad", enable=not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));

    parameter Modelica.SIunits.Thickness Length=2.1
      "Evaporative cooling pad length(m)" annotation (Dialog(group=
            "Evaporative cooler pad", enable=not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));

    parameter Modelica.SIunits.Thickness Height=0.91
      "Evaporative cooling pad Height(m)" annotation (Dialog(group=
            "Evaporative cooler pad", enable=not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));

    parameter Modelica.SIunits.Conductivity K_value=0.04
      " Evaporative cooling pad thermal conductivity" annotation (Dialog(
          group="Evaporative cooler pad", enable=not (energyDynamics ==
            Modelica.Fluid.Types.Dynamics.SteadyState)));

   parameter Real Contact_surface_area = 440
                                            "Surface area per unit volume in comact with air(m2/m3)"
   annotation (Dialog(group="Evaporative cooler pad",
                  enable=not (energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState)));

  // parameter Real PadMedia =                 "Volume of pores to volume of the cooler pad (m3/m3)"

    parameter Modelica.SIunits.Area PadArea=Length*Height
      "Evaporative cooling pad area(m2)" annotation (Dialog(group=
            "Evaporative cooler pad", enable=not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));
    Real TSA = (2*PadArea)+(2*Thickness*(Length+Height))
                                                       "total surface area of the cooling pad,m2";
    Real V= PadArea*Thickness "volume of the cooling pad,m3";
    Real l= (V/ TSA)
                    "Characteristic length,m";
    parameter Real P_atm = 101325         "in pascals";

    Real v_air_nominal          "Velocity of air at nominal mass flow rate";
    Real DeltaP_nominal "Pressure drop at nominal mass flow rate";

   parameter Real DriftFactor = 0.1
      "Drift factor[user input]"
    annotation (Dialog(group="Water consumption",
                  enable=not (energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState)));

   parameter Real Rcon = 3
      "Ratio of solids in the blowdown water[user input]"
    annotation (Dialog(group="Water consumption",
                  enable=not (energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState)));

    parameter Modelica.SIunits.Time tau1=1 "Time constant at nominal flow"
      annotation (Dialog(tab="Dynamics", group="Nominal condition"));
    parameter Modelica.SIunits.Time tau2=1 "Time constant at nominal flow"
      annotation (Dialog(tab="Dynamics", group="Nominal condition"));

    // Advanced
    parameter Boolean homotopyInitialization = true "= true, use homotopy method"
      annotation(Evaluate=true, Dialog(tab="Advanced"));

    // Assumptions
    parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
      "Type of energy balance: dynamic (3 initialization options) or steady state"
      annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
    parameter Modelica.Fluid.Types.Dynamics massDynamics=if tau1 > Modelica.Constants.eps
         then energyDynamics else Modelica.Fluid.Types.Dynamics.SteadyState
      "Type of mass balance: dynamic (3 initialization options) or steady state"
      annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

    // Initialization
    parameter Medium1.AbsolutePressure p1_start = Medium1.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Medium 1"));
    parameter Medium1.Temperature T1_start = Medium1.T_default
      "Start value of temperature"
      annotation(Dialog(tab = "Initialization", group = "Medium 1"));
    parameter Medium1.MassFraction X1_start[Medium1.nX] = Medium1.X_default
      "Start value of mass fractions m_i/m"
      annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nXi > 0));
    parameter Medium1.ExtraProperty C1_start[Medium1.nC](
      final quantity=Medium1.extraPropertiesNames)=fill(0, Medium1.nC)
      "Start value of trace substances"
      annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nC > 0));
    parameter Medium1.ExtraProperty C1_nominal[Medium1.nC](
      final quantity=Medium1.extraPropertiesNames) = fill(1E-2, Medium1.nC)
      "Nominal value of trace substances. (Set to typical order of magnitude.)"
     annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nC > 0));

    parameter Medium2.AbsolutePressure p2_start = Medium2.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Medium 2"));
    parameter Medium2.Temperature T2_start = Medium2.T_default
      "Start value of temperature"
      annotation(Dialog(tab = "Initialization", group = "Medium 2"));
    parameter Medium2.MassFraction X2_start[Medium2.nX] = Medium2.X_default
      "Start value of mass fractions m_i/m"
      annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nXi > 0));
    parameter Medium2.ExtraProperty C2_start[Medium2.nC](
      final quantity=Medium2.extraPropertiesNames)=fill(0, Medium2.nC)
      "Start value of trace substances"
      annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nC > 0));
    parameter Medium2.ExtraProperty C2_nominal[Medium2.nC](
      final quantity=Medium2.extraPropertiesNames) = fill(1E-2, Medium2.nC)
      "Nominal value of trace substances. (Set to typical order of magnitude.)"
     annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nC > 0));

    Modelica.SIunits.HeatFlowRate Q1_flow=VolWat.heatPort.Q_flow
      "Heat flow rate into medium 1";
    Modelica.SIunits.HeatFlowRate Q2_flow=VolAir.heatPort.Q_flow
      "Heat flow rate into medium 2";

    BaseClasses.HeatTransfer HeaTraPhy(Area_s=PadArea)
      annotation (Placement(transformation(extent={{-1,10},{19,30}})));
    BaseClasses.CoolingPadEfficiencyPhysicsBased Eff_Phy(
      p_atm=P_atm,
      k=K_value,
      Thickness=Thickness,
      length=Length,
      height=Height,
      p_V=Contact_surface_area) annotation (Placement(transformation(extent={{-47,-10},{-27,10}})));
  protected
    parameter Medium1.ThermodynamicState sta1_nominal=Medium1.setState_pTX(
        T=Medium1.T_default, p=Medium1.p_default, X=Medium1.X_default);
    parameter Modelica.SIunits.Density rho1_nominal=Medium1.density(
        sta1_nominal) "Density, used to compute fluid volume";
    parameter Medium2.ThermodynamicState sta2_nominal=Medium2.setState_pTX(
        T=Medium2.T_default, p=Medium2.p_default, X=Medium2.X_default);
    parameter Modelica.SIunits.Density rho2_nominal=Medium2.density(
        sta2_nominal) "Density, used to compute fluid volume";

    parameter Medium1.ThermodynamicState sta1_start=Medium1.setState_pTX(
        T=T1_start, p=p1_start, X=X1_start);
    parameter Modelica.SIunits.SpecificEnthalpy h1_outflow_start=
        Medium1.specificEnthalpy(sta1_start)
      "Start value for outflowing enthalpy";
    parameter Medium2.ThermodynamicState sta2_start=Medium2.setState_pTX(
        T=T2_start, p=p2_start, X=X2_start);
    parameter Modelica.SIunits.SpecificEnthalpy h2_outflow_start=
        Medium2.specificEnthalpy(sta2_start)
      "Start value for outflowing enthalpy";

    Buildings.HeatTransfer.Sources.PrescribedHeatFlow LatHea
      "Heat conductor for latent heat flow rate, accounting for latent heat removed with vapor"
      annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=180,
          origin={24,-70})));
   Buildings.Fluid.Sensors.Velocity SenVel(
      redeclare package Medium = Medium2,
      m_flow_nominal=m2_flow_nominal,
      tau=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      A=PadArea) "Air side velocity over the cooling pad" annotation (Placement(
          transformation(
          extent={{5,-5},{-5,5}},
          rotation=180,
          origin={-40,60})));
   Buildings.Fluid.Sensors.MassFlowRate SenMasFlo(redeclare package Medium =
          Medium2) "Air side mass flow rate" annotation (Placement(transformation(
          extent={{5,-5},{-5,5}},
          rotation=180,
          origin={-55,60})));
   Buildings.Fluid.Sensors.DensityTwoPort senDenWat(
      redeclare package Medium = Medium1,
      m_flow_nominal=m1_flow_nominal,
      tau=tau1,
      initType=Modelica.Blocks.Types.Init.InitialState) "Water side density"
      annotation (Placement(transformation(extent={{-5,-65},{-15,-55}})));
   Buildings.Fluid.Sensors.MassFlowRate SenMasFloWat(redeclare package Medium =
          Buildings.Media.Water) "Water side mass flow rate" annotation (
        Placement(transformation(
          extent={{-5,5},{5,-5}},
          rotation=180,
          origin={-40,-60})));
  public
    BaseClasses.WaterConsumption WatCon(f_drift=DriftFactor, Rcon=Rcon) annotation (Placement(transformation(extent={{0,-31},{20,-11}})));
    Modelica.Blocks.Math.Product VolToMasE annotation (Placement(
          transformation(
          extent={{4.5,-4.5},{-4.5,4.5}},
          rotation=180,
          origin={44.5,-7.5})));
    Modelica.Blocks.Math.Product VolToMasT annotation (Placement(
          transformation(
          extent={{-4.5,-4.5},{4.5,4.5}},
          rotation=0,
          origin={44.5,-24.5})));
    Modelica.Blocks.Math.Gain gain(k=-1)
      annotation (Placement(transformation(extent={{-3.5,-3.5},{3.5,3.5}},
          rotation=0,
          origin={63.5,-24.5})));
    replaceable
      Buildings.Fluid.MixingVolumes.BaseClasses.MixingVolumeHeatMoisturePort VolAir(nPorts=2)
      constrainedby
      Buildings.Fluid.MixingVolumes.BaseClasses.MixingVolumeHeatMoisturePort(
      redeclare final package Medium = Medium2,
      nPorts=2,
      V=m2_flow_nominal*tau2/rho2_nominal,
      final allowFlowReversal=allowFlowReversal2,
      mSenFac=1,
      final m_flow_nominal=m2_flow_nominal,
      energyDynamics=if tau2 > Modelica.Constants.eps then energyDynamics else
          Modelica.Fluid.Types.Dynamics.SteadyState,
      massDynamics=if tau2 > Modelica.Constants.eps then massDynamics else
          Modelica.Fluid.Types.Dynamics.SteadyState,
      final p_start=p2_start,
      final T_start=T2_start,
      final X_start=X2_start,
      final C_start=C2_start,
      final C_nominal=C2_nominal) "Volume for fluid 2_air" annotation (Placement(
          transformation(
          origin={72,50.5},
          extent={{9,-9.5},{-9,9.5}},
          rotation=180)));
    Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort TWetBul(
      redeclare package Medium = Medium2,
      allowFlowReversal=true,
      m_flow_nominal=m2_flow_nominal,
      tau=0,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      TWetBul_start(displayUnit="K")) "Air side WBT (~ambient WBT)" annotation (
        Placement(transformation(
          extent={{5,-5},{-5,5}},
          rotation=180,
          origin={-69,60})));
    Buildings.Fluid.Sensors.TemperatureTwoPort TDryBul(
      redeclare package Medium = Medium2,
      m_flow_nominal=m2_flow_nominal,
      tau=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      T_start(displayUnit="K")) "Air side temperature (~ ambient DBT)"
      annotation (Placement(transformation(
          extent={{5.5,-6},{-5.5,6}},
          rotation=180,
          origin={-84.5,60})));
    Buildings.Fluid.Sensors.MassFractionTwoPort SenMasFra(
      redeclare package Medium = Buildings.Media.Air,
      m_flow_nominal=m2_flow_nominal,
      tau=0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      "Air side inlet humidity ratio kg/kg" annotation (Placement(transformation(
          extent={{5,-5},{-5,5}},
          rotation=180,
          origin={-10,60})));
    replaceable Buildings.Fluid.MixingVolumes.BaseClasses.MixingVolumeHeatPort VolWat(nPorts=3)
      constrainedby
      Buildings.Fluid.MixingVolumes.BaseClasses.MixingVolumeHeatPort(
      redeclare final package Medium = Medium1,
      nPorts=2,
      V=m1_flow_nominal*tau1/rho1_nominal,
      final allowFlowReversal=allowFlowReversal1,
      final m_flow_nominal=m1_flow_nominal,
      energyDynamics=if tau1 > Modelica.Constants.eps then energyDynamics else
          Modelica.Fluid.Types.Dynamics.SteadyState,
      massDynamics=if tau1 > Modelica.Constants.eps then massDynamics else
          Modelica.Fluid.Types.Dynamics.SteadyState,
      final p_start=p1_start,
      final T_start=T1_start,
      final X_start=X1_start,
      final C_start=C1_start,
      final C_nominal=C1_nominal,
      mSenFac=1) "Volume for fluid 1_water"
      annotation (Placement(transformation(extent={{-71,-60},{-90,-80}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort TWat(
      redeclare package Medium = Medium1,
      m_flow_nominal=m1_flow_nominal,
      tau=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      T_start(displayUnit="K")) "Water side fluid temperature"
      annotation (Placement(transformation(extent={{-50,-65},{-60,-55}})));
    Modelica.Fluid.Sources.MassFlowSource_T MasFlo(
      redeclare package Medium = Medium1,
      use_m_flow_in=true,
      nPorts=1) annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=90,
          origin={80,-40})));
    Buildings.Fluid.FixedResistances.PressureDrop preDro1(redeclare package Medium =
                 Medium2, m_flow_nominal=m2_flow_nominal)
      annotation (Placement(transformation(extent={{23,53},{36,67}})));
    Buildings.Fluid.FixedResistances.PressureDrop preDro2(
      redeclare package Medium = Medium1,
      m_flow_nominal=m2_flow_nominalm1_flow_nominal,
      dp_nominal=DeltaP_nominal)
      annotation (Placement(transformation(extent={{56,-67},{42,-53}})));
  initial equation
    // Check for tau1
    assert((energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
            tau1 > Modelica.Constants.eps,
  "The parameter tau1, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau1 = "   + String(tau1) + "\n");
    assert((massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
            tau1 > Modelica.Constants.eps,
  "The parameter tau1, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau1 = "   + String(tau1) + "\n");

   // Check for tau2
    assert((energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
            tau2 > Modelica.Constants.eps,
  "The parameter tau2, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau2 = "   + String(tau2) + "\n");
    assert((massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
            tau2 > Modelica.Constants.eps,
  "The parameter tau2, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau2 = "   + String(tau2) + "\n");

  equation

    // pressure drop module
  v_air_nominal  = m2_flow_nominal/PadArea;
  DeltaP_nominal = 0.768*((0.0288)^(-0.469))*(1 + (m2_flow_nominal^1.139))*(v_air_nominal^2);

    connect(VolAir.ports[1], port_b1)
      annotation (Line(points={{70.2,60},{100,60}},
                                                  color={0,127,255},
        thickness=1));
    connect(port_b2, VolWat.ports[1])
      annotation (Line(points={{-100,-60},{-77.9667,-60}},
                                                        color={0,127,255},
        thickness=1));
    connect(port_a1, TDryBul.port_a)
      annotation (Line(points={{-100,60},{-90,60}}, color={0,127,255},
        thickness=1));
    connect(TDryBul.port_b, TWetBul.port_a)
      annotation (Line(points={{-79,60},{-74,60}}, color={0,127,255},
        thickness=1));
    connect(TWetBul.port_b, SenMasFlo.port_a)
      annotation (Line(points={{-64,60},{-60,60}}, color={0,127,255},
        thickness=1));
    connect(SenMasFlo.port_b, SenVel.port_a)
      annotation (Line(points={{-50,60},{-45,60}}, color={0,127,255},
        thickness=1));
    connect(SenMasFloWat.port_a, senDenWat.port_b)
      annotation (Line(points={{-35,-60},{-15,-60}}, color={0,127,255},
        thickness=1));
    connect(SenVel.port_b, SenMasFra.port_a)
      annotation (Line(points={{-35,60},{-15,60}}, color={0,127,255},
        thickness=1));
    connect(VolWat.ports[2], TWat.port_b)
      annotation (Line(points={{-80.5,-60},{-60,-60}},
                                                     color={0,127,255},
        thickness=1));
    connect(TWat.port_a, SenMasFloWat.port_b)
      annotation (Line(points={{-50,-60},{-45,-60}}, color={0,127,255},
        thickness=1));
    connect(SenMasFra.port_b, preDro1.port_a) annotation (Line(
        points={{-5,60},{23,60}},
        color={0,127,255},
        thickness=1));
    connect(preDro1.port_b, VolAir.ports[2]) annotation (Line(
        points={{36,60},{73.8,60}},
        color={0,127,255},
        thickness=1));
    connect(preDro2.port_a, port_a2) annotation (Line(
        points={{56,-60},{100,-60}},
        color={0,127,255},
        thickness=1));
    connect(senDenWat.port_a, preDro2.port_b) annotation (Line(
        points={{-5,-60},{42,-60}},
        color={0,127,255},
        thickness=1));
    connect(VolToMasE.y, VolAir.mWat_flow) annotation (Line(
        points={{49.45,-7.5},{54,-7.5},{54,42.9},{61.2,42.9}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(MasFlo.ports[1], VolWat.ports[3]) annotation (Line(
        points={{80,-47},{80,-50},{-83.0333,-50},{-83.0333,-60}},
        color={80,153,249},
        thickness=0.5));
    connect(VolWat.heatPort, LatHea.port) annotation (Line(
        points={{-71,-70},{18,-70}},
        color={245,0,0},
        thickness=0.5));
    connect(TWat.T, Eff_Phy.Tw1) annotation (Line(
        points={{-55,-54.5},{-55,-4.9},{-48.5,-4.9}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(TDryBul.T, Eff_Phy.Ta_db1) annotation (Line(
        points={{-84.5,53.4},{-84.5,12},{-43,12}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(TWetBul.T, Eff_Phy.Ta_wb1) annotation (Line(points={{-69,54.5},{-69,4},{-49,4}},
                                   color={0,0,127},
        pattern=LinePattern.Dash));
    connect(SenMasFlo.m_flow, Eff_Phy.ma_flow) annotation (Line(
        points={{-55,54.5},{-55,12},{-37,12}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(SenMasFloWat.m_flow, Eff_Phy.mw_flow) annotation (Line(
        points={{-40,-54.5},{-40,-12},{-43,-12}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(SenVel.v, Eff_Phy.v_a) annotation (Line(points={{-40,54.5},{-40,-4},{-49,-4}},
                                 color={0,0,127},
        pattern=LinePattern.Dash));
    connect(TDryBul.T, HeaTraPhy.T_db1) annotation (Line(
        points={{-84.5,53.4},{-84.5,31.6667},{3.54545,31.6667}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(SenMasFra.X, HeaTraPhy.Wx_1) annotation (Line(
        points={{-10,54.5},{-10,27.5},{-2.81818,27.5}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(Eff_Phy.hm, HeaTraPhy.hm) annotation (Line(points={{-26,6},{-20,6},{-20,22.5},{-2.81818,22.5}},
                                               color={0,0,127},
        pattern=LinePattern.Dash));
    connect(Eff_Phy.Ta_db2, HeaTraPhy.T_db2) annotation (Line(points={{-26,4},{-17,4},{-17,17.5},{-2.81818,17.5}},
                                                       color={0,0,127},
        pattern=LinePattern.Dash));
    connect(Eff_Phy.X_2, HeaTraPhy.Wx_2) annotation (Line(points={{-26,1},{-14,1},{-14,12.5},{-2.81818,12.5}},
                                                      color={0,0,127},
        pattern=LinePattern.Dash));
    connect(Eff_Phy.X_2, WatCon.W_out) annotation (Line(points={{-26,1},{-14,1},{-14,-27},{-2,-27}},
                                          color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senDenWat.d, WatCon.Density) annotation (Line(
        points={{-10,-54.5},{-10,-26.9},{-1.5,-26.9}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(SenMasFra.X, WatCon.W_in) annotation (Line(
        points={{-10,54.5},{-10,-15},{-2,-15}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(SenMasFlo.m_flow, WatCon.m_flo) annotation (Line(
        points={{-55,54.5},{-55,-21},{-2,-21}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senDenWat.d, VolToMasT.u2) annotation (Line(
        points={{-10,-54.5},{-10,-40},{30,-40},{30,-27.2},{39.1,-27.2}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senDenWat.d, VolToMasE.u1) annotation (Line(
        points={{-10,-54.5},{-10,-40},{30,-40},{30,-10.2},{39.1,-10.2}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(WatCon.Vol_evap, VolToMasE.u2) annotation (Line(
        points={{21.4,-18},{27,-18},{27,-4.8},{39.1,-4.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(WatCon.Vol_water, VolToMasT.u1) annotation (Line(
        points={{21.4,-24},{39.1,-24},{39.1,-21.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(VolToMasT.y, gain.u) annotation (Line(
        points={{49.45,-24.5},{59.3,-24.5}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(gain.y, MasFlo.m_flow_in) annotation (Line(
        points={{67.35,-24.5},{74.4,-24.5},{74.4,-33}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(HeaTraPhy.Q_latent, LatHea.Q_flow) annotation (Line(
        points={{20.2727,15},{90,15},{90,-70},{30,-70}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(Eff_Phy.hc, HeaTraPhy.hc) annotation (Line(points={{-26,-6},{-7,-6},{-7,8.33333},{3.54545,8.33333}},
                                                  color={0,0,127},
        pattern=LinePattern.Dash));
   annotation (Dialog(group="Evaporative cooler pad",
                  enable=not (energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState)),
                Dialog(group="Evaporative cooler pad",
                  enable=not (energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState)),
                Dialog(group="Evaporative cooler pad",
                  enable=not (energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState)),
               Dialog(group="Evaporative cooler pad",
                  enable=not (energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState)),
              Dialog(group="Evaporative cooler pad",
                  enable=not (energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState)),
              Dialog(group="Evaporative cooler pad",
                  enable=not (energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState)),
                              Dialog(group="Evaporative cooler pad",
                  enable=not (energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState)),
      Documentation(info="<html>
<p>
This component transports two fluid streams between four ports.
It provides the basic model for implementing a dynamic heat exchanger.
</p>
<p>
The model can be used as-is, although there will be no heat or mass transfer
between the two fluid streams.
To add heat transfer, heat flow can be added to the heat port of the two volumes.
See for example
<a href=\"Buildings.Fluid.Chillers.Carnot_y\">
Buildings.Fluid.Chillers.Carnot_y</a>.
To add moisture input into (or moisture output from) volume <code>vol2</code>,
the model can be replaced with
<a href=\"modelica://Buildings.Fluid.MixingVolumes.MixingVolumeMoistAir\">
Buildings.Fluid.MixingVolumes.MixingVolumeMoistAir</a>.
</p>
<h4>Implementation</h4>
<p>
The variable names follow the conventions used in
<a href=\"modelica://Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX\">
Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX</a>.
</p>
</html>",   revisions="<html>
<ul>
<li>
October 23, 2017, by Michael Wetter:<br/>
Made volume <code>vol1</code> replaceable. This is required for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1013\">Buildings, issue 1013</a>.
</li>
<li>
December 1, 2016, by Michael Wetter:<br/>
Updated model as <code>use_dh</code> is no longer a parameter in the pressure drop model.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/480\">#480</a>.
</li>
<li>
April 11, 2016 by Michael Wetter:<br/>
Corrected wrong hyperlink in documentation for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/450\">issue 450</a>.
</li>
<li>
January 26, 2016, by Michael Wetter:<br/>
Set <code>quantity</code> attributes.
</li>
<li>
November 13, 2015, by Michael Wetter:<br/>
Changed assignments of start values in <code>extends</code> statement.
This is for issue
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/299\">#299</a>.
</li>
<li>
June 2, 2015, by Filip Jorissen:<br/>
Removed final modifier from <code>mSenFac</code> in
<code>vol1</code> and <code>vol2</code>.
This is for issue
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/258=\">#258</a>.
</li>
<li>
May 6, 2015, by Michael Wetter:<br/>
Added missing propagation of <code>allowFlowReversal</code> to
instances <code>vol1</code> and <code>vol2</code>.
This is for issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/412\">#412</a>.
</li>
<li>
October 6, 2014, by Michael Wetter:<br/>
Changed medium declaration in pressure drop elements to be final.
</li>
<li>
May 28, 2014, by Michael Wetter:<br/>
Removed <code>annotation(Evaluate=true)</code> for parameters <code>tau1</code>
and <code>tau2</code>.
This is needed to allow changing the time constant after translation.
</li>
<li>
November 12, 2013, by Michael Wetter:<br/>
Removed <code>import Modelica.Constants</code> statement.
</li>
<li>
October 8, 2013, by Michael Wetter:<br/>
Removed parameter <code>show_V_flow</code>.
</li>
<li>
September 26, 2013, by Michael Wetter:<br/>
Removed unrequired <code>sum</code> operator.
</li>
<li>
February 6, 2012, by Michael Wetter:<br/>
Updated documentation.
</li>
<li>
February 3, 2012, by Michael Wetter:<br/>
Removed assignment of <code>m_flow_small</code> as it is no
longer used in its base class.
</li>
<li>
July 29, 2011, by Michael Wetter:
<ul>
<li>
Changed values of
<code>h_outflow_a1_start</code>,
<code>h_outflow_b1_start</code>,
<code>h_outflow_a2_start</code> and
<code>h_outflow_b2_start</code>, and
declared them as final.
</li>
<li>
Set nominal values for <code>vol1.C</code> and <code>vol2.C</code>.
</li>
</ul>
</li>
<li>
July 11, 2011, by Michael Wetter:<br/>
Changed parameterization of fluid volume so that steady-state balance is
used when <code>tau = 0</code>.
</li>
<li>
March 25, 2011, by Michael Wetter:<br/>
Added homotopy operator.
</li>
<li>
April 13, 2009, by Michael Wetter:<br/>
Added model to compute flow friction.
</li>
<li>
September 10, 2008 by Michael Wetter:<br/>
Added <code>stateSelect=StateSelect.always</code> for temperature of volume 1.
</li>
<li>
Changed temperature sensor from Celsius to Kelvin.
Unit conversion should be made during output
processing.
</li>
<li>
August 5, 2008, by Michael Wetter:<br/>
Replaced instances of <code>Delays.DelayFirstOrder</code> with instances of
<code>MixingVolumes.MixingVolume</code>. This allows to extract liquid for a condensing cooling
coil model.
</li>
<li>
March 25, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
      Icon(coordinateSystem(
          extent={{-100,-100},{100,90}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-99,64},{102,54}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-99,-56},{102,-66}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Bitmap(extent={{-126,-103},{128,101}},
            imageSource=
                "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",
            fileName=
                "modelica://Evaporative_Coolers_rev/../OneDrive/Desktop/Image for paper/pad.PNG")}),
      Diagram(coordinateSystem(extent={{-100,-100},{100,90}}, grid={1,1}),
              graphics={Text(
            extent={{68,-89},{98,-102}},
            lineColor={28,108,200},
            textString="Water Side",
            fontName="serif"),
                        Text(
            extent={{70,89},{100,81}},
            lineColor={28,108,200},
            textString="Air Side",
            fontName="serif"),
                        Text(
            extent={{-65,-70},{-39,-81}},
            lineColor={0,0,0},
            fontName="serif",
            textString="Latent heat, Ql",
            textStyle={TextStyle.Italic}),
                        Text(
            extent={{37,51},{59,42}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Mass Fraction,Xw"),
                        Text(
            extent={{-89,-40},{-56,-59}},
            lineColor={0,0,127},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Removed Mass flow rate
",          pattern=LinePattern.Dash),
                        Text(
            extent={{33,7},{43,0}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="V_evap"),
                        Text(
            extent={{33,-29},{41,-35}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="V_tot"),
                        Text(
            extent={{-26,12},{-21,8}},
            lineColor={0,0,127},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="hm",
            pattern=LinePattern.Dash),
                        Text(
            extent={{-27,0},{-20,-4}},
            lineColor={0,0,127},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="hc",
            pattern=LinePattern.Dash),
                        Text(
            extent={{-19,55},{-12,52}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="X_in"),
                        Text(
            extent={{16,72},{46,62}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Flow Resistance 1"),
                        Text(
            extent={{34,-49},{66,-59}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Flow Resistance 2"),
                        Text(
            extent={{-8,-8},{-1,-11}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="X_in"),
                        Text(
            extent={{-10,-19},{-2,-22}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="X_out"),
                        Text(
            extent={{-102,-86},{-54,-98}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Mixing Volume with 
Static conservation equation
"),                     Text(
            extent={{53,35},{96,24}},
            lineColor={0,0,0},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="Mixing Volume with 
Static conservation equation
"),                     Text(
            extent={{-27,-9},{-15,-16}},
            lineColor={0,0,127},
            fontName="serif",
            textStyle={TextStyle.Italic},
            textString="dp_pad
",          pattern=LinePattern.Dash)}));
  end CoolingPadPhysicsBased;

  model DirectEvaporativeCooler

   extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
        replaceable package Medium =
          Modelica.Media.Interfaces.PartialCondensingGases,
      allowFlowReversal1=false,
      port_a1(h_outflow(start=h1_outflow_start)),
      port_b1(h_outflow(start=h1_outflow_start)));
    extends Buildings.Fluid.Interfaces.FourPortFlowResistanceParameters(
       final computeFlowResistance1=true, final computeFlowResistance2=true);

       parameter Real WaterMflow " Mass flow rate of water ";
       parameter Real WaterTemperature " Temperature of the water";

  package MediumWater = Buildings.Media.Water;

    Buildings.Fluid.Movers.FlowControlled_m_flow pum(
      redeclare package Medium = MediumWater,
      m_flow_nominal=0.32,
      addPowerToMedium=false,
      nominalValuesDefineDefaultPressureCurve=true,
      dp_nominal=11652.14,
      m_flow_start=0.32) annotation (Placement(transformation(extent={{24,-30},{6,-50}})));
    Buildings.Fluid.Sources.Boundary_pT sinWat(
      redeclare package Medium = MediumWater,
      use_T_in=false,
      nPorts=1)
      annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
    Modelica.Blocks.Sources.RealExpression watTemp(y=WaterTemperature)
                                                          annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={90,-36})));
    Modelica.Blocks.Sources.RealExpression mFloWat(y=WaterMflow)
                                                           "i  kg/s"
      annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
    Buildings.Fluid.Sources.Boundary_pT souWat(
      redeclare package Medium = MediumWater,
      use_T_in=true,
      nPorts=1) annotation (Placement(transformation(extent={{58,-50},{38,-30}})));
    Buildings.Fluid.Movers.FlowControlled_m_flow fan(
      redeclare package Medium = Medium2,
      y_start=1,
      m_flow_nominal=1.5,
      redeclare parameter Buildings.Fluid.Movers.Data.Generic per,
      inputType=Buildings.Fluid.Types.InputType.Continuous,
      addPowerToMedium=false,
      nominalValuesDefineDefaultPressureCurve=false,
      m_flow_start=0.201)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    Modelica.Blocks.Sources.Ramp mFlowAir(
      height=4,
      duration=100000,
      offset=0,
      startTime=0)
      annotation (Placement(transformation(extent={{-96,32},{-80,48}})));
    Modelica.Blocks.Interfaces.RealOutput pow "Total power of Fan and pump"
      annotation (Placement(transformation(extent={{100,50},{120,70}}),
          iconTransformation(extent={{100,-50},{120,-30}})));
    Modelica.Blocks.Interfaces.RealOutput watCon "Total Water consumption"
      annotation (Placement(transformation(extent={{100,34},{120,54}}),
          iconTransformation(extent={{100,-80},{120,-60}})));
    Modelica.Blocks.Sources.RealExpression totPow(y=pum.P + fan.P)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={70,60})));
    Modelica.Blocks.Sources.RealExpression totWatCon(y=decSys.WatCon.Vol_water)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={70,44})));
    replaceable ComponentModels.Lumped decSys annotation (Placement(transformation(extent={{-28,-16},{-8,4}})));
  equation
    connect(mFloWat.y, pum.m_flow_in) annotation (Line(
        points={{-19,-60},{14,-60},{14,-56},{15,-56},{15,-52}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(pum.port_a, souWat.ports[1]) annotation (Line(
        points={{24,-40},{38,-40}},
        color={28,108,200},
        thickness=0.5));
    connect(watTemp.y, souWat.T_in)
      annotation (Line(points={{79,-36},{60,-36}}, color={0,0,127},
        pattern=LinePattern.Dash));
    connect(port_a,fan. port_a) annotation (Line(
        points={{-100,0},{-80,0}},
        color={28,108,200},
        thickness=0.5));
    connect(mFlowAir.y,fan. m_flow_in) annotation (Line(points={{-79.2,40},{-70,40},{-70,12}},
                               color={0,0,127},
        pattern=LinePattern.Dash));
    connect(watCon, watCon)
      annotation (Line(points={{110,44},{110,44}},   color={0,0,127}));
    connect(pow, totPow.y)
      annotation (Line(points={{110,60},{81,60}},   color={0,0,127},
        pattern=LinePattern.Dash));
    connect(totWatCon.y, watCon)
      annotation (Line(points={{81,44},{110,44}},   color={0,0,127},
        pattern=LinePattern.Dash));
    connect(fan.port_b, decSys.port_a1) annotation (Line(points={{-60,0},{-28,0}}, color={0,127,255}));
    connect(decSys.port_a2, pum.port_b) annotation (Line(points={{-8,-12},{0,-12},{0,-40},{6,-40}}, color={0,127,255}));
    connect(decSys.port_b1, port_b) annotation (Line(points={{-8,0},{100,0}}, color={0,127,255}));
    connect(sinWat.ports[1], decSys.port_b2) annotation (Line(points={{-40,-40},{-34,-40},{-34,-12},{-28,-12}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{20,-44},{78,-72}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fontSize=14,
            fontName="serif",
            textString="WaterSide"), Text(
            extent={{20,20},{78,-8}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fontSize=14,
            fontName="serif",
            textString="AirSide")}));
  end DirectEvaporativeCooler;
end Obsolete;

within DirectEvaporativeCooler.Examples;
model DirectEvaporativeCoolerPressuredropValidation
  extends Modelica.Icons.Example;

  package MediumWater = Buildings.Media.Water "Water medium";
  package MediumAir = Buildings.Media.Air "Air medium";

Modelica.SIunits.MassFlowRate mW_flow_nominal = 1 "Nominal mass flow rate on water side";
Modelica.SIunits.MassFlowRate mA_flow_nominal= 1  "Nominal mass flow rate on air side";

Modelica.SIunits.PressureDifference dpW_nominal = 10000 "Nominal pressure drop on the water side";
Modelica.SIunits.PressureDifference dpA_nominal = 10000  "Nominal pressure drop on the air side";
Modelica.SIunits.PressureDifference dpD_nominal = 10000 "Nominal pressure drop across the duct";

  SystemModel.DecSysLumped decSys(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    mW_flow_nominal=1,
    dp_pad_nominal=1000000000,
    dp_pip_nominal=1000000000)  "Direct evaporative cooling system" annotation (Placement(transformation(extent={{-50,-10},
            {-30,10}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumAir,
    use_Xi_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));
  Buildings.Fluid.Sources.Boundary_pT sin1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{10,-8},{26,8}})));
  Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul(redeclare package
      Medium = MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{34,-8},{50,8}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducRes(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    dp_nominal=0)           "Resistance offered by the duct" annotation (Placement(transformation(extent={{-20,-10},
            {0,10}})));
  Modelica.Blocks.Sources.Constant
                               pumSig "Pump signal" annotation (Placement(transformation(extent={{-112,20},
            {-100,32}})));
  Modelica.Blocks.Sources.TimeTable
                               fanSig(table=[0,170; 1,170; 2,170; 3,170; 4,170;
        5,170; 6,260; 7,260; 8,260; 9,260; 10,260; 11,350; 12,350; 13,350; 14,
        350; 15,350; 16,350; 17,350; 18,440; 19,440; 20,440; 21,440; 22,440; 23,
        440; 24,440; 25,440; 26,440; 27,440; 28,440; 29,440; 30,440; 31,440; 32,
        440; 33,440; 34,440; 35,440; 36,440; 37,440; 38,440; 39,440; 40,530; 41,
        530; 42,530; 43,530; 44,530; 45,530; 46,530; 47,530], timeScale=900)
                                      "Fan Signal" annotation (Placement(transformation(extent={{-112,
            -46},{-100,-34}})));
  Modelica.Blocks.Sources.TimeTable
                               Tou(table=[0,305; 1,305; 2,305; 3,311; 4,316; 5,
        316; 6,305; 7,305; 8,311; 9,316; 10,316; 11,305; 12,305; 13,305; 14,311;
        15,311; 16,316; 17,316; 18,305; 19,305; 20,305; 21,311; 22,311; 23,316;
        24,316; 25,316; 26,311; 27,311; 28,311; 29,311; 30,311; 31,311; 32,311;
        33,311; 34,311; 35,311; 36,311; 37,311; 38,311; 39,311; 40,305; 41,305;
        42,305; 43,311; 44,311; 45,316; 46,316; 47,318], timeScale=900)
                                   "Outdoor temperature" annotation (Placement(transformation(extent={{-112,-2},
            {-100,10}})));
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
                                   "Inlet humidity ratio" annotation (Placement(transformation(extent={{-112,
            -26},{-100,-14}})));
  Buildings.Fluid.Sensors.RelativeHumidity phiIn "Inlet relative humidity"
    annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={-50,-26})));
  Buildings.Fluid.Sensors.RelativeHumidity phiOu "Outlet relative humidity"
    annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={-30,-26})));
equation
  connect(sou.ports[1],decSys. port_a) annotation (Line(
      points={{-66,0},{-50,0}},
      color={0,127,255},
      thickness=0.5));
  connect(sin1.ports[1], senWetBul.port_b) annotation (Line(
      points={{60,0},{50,0}},
      color={0,127,255},
      thickness=0.5));
  connect(senWetBul.port_a,senTem. port_b) annotation (Line(
      points={{34,0},{26,0}},
      color={0,127,255},
      thickness=0.5));
  connect(senTem.port_a,ducRes. port_b) annotation (Line(
      points={{10,0},{0,0}},
      color={0,127,255},
      thickness=0.5));
  connect(ducRes.port_a,decSys. port_b) annotation (Line(
      points={{-20,0},{-30,0}},
      color={0,127,255},
      thickness=0.5));
  connect(fanSig.y,decSys. fanSig) annotation (Line(
      points={{-99.4,-40},{-60,-40},{-60,3},{-52,3}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pumSig.y,decSys. pumSig) annotation (Line(
      points={{-99.4,26},{-52,26},{-52,8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sou.T_in,Tou. y) annotation (Line(
      points={{-88,4},{-99.4,4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(win.y,sou. Xi_in[1]) annotation (Line(
      points={{-99.4,-20},{-94,-20},{-94,-4},{-88,-4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(decSys.port_a,phiIn. port) annotation (Line(points={{-50,0},{-50,-20}}, color={0,127,255}));
  connect(decSys.port_b,phiOu. port) annotation (Line(points={{-30,0},{-30,-20}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{120,100}})));
end DirectEvaporativeCoolerPressuredropValidation;

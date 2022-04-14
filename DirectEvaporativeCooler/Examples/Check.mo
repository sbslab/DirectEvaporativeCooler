within DirectEvaporativeCooler.Examples;
model Check
  extends Modelica.Icons.Example;

  //Medium model
  package MediumWater = Buildings.Media.Water "Water medium";
  package MediumAir = Buildings.Media.Air "Air medium";

  //Real mW_flow_nominal=1 "Nominal mass flow rate on water side";
  //Real mA_flow_nominal=1 "Nominal mass flow rate on air side";

  //Real dpW_nominal=10000 "Nominal pressure drop on the water side";
  //Real dpA_nominal=10000 "Nominal pressure drop on the air side";
 // Real dpD_nominal=10000 "Nominal pressure drop across the duct";

  SystemModel.DecSystemPhysicsBased
                           decSys(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    dp_nominal=10000,
    mW_flow_nominal=1,
    dp_pad_nominal=1000000000,
    dp_pip_nominal=1000000000)  "Direct evaporative cooling system" annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumAir,
    use_Xi_in=false,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{100,30},{80,50}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{30,32},{46,48}})));
  Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul(redeclare package
              Medium =                                                                   MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{54,32},{70,48}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducRes(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    dp_nominal=0)           "Resistance offered by the duct" annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Sources.Step pumSig(height=1)
                                      "Pump signal" annotation (Placement(transformation(extent={{-92,62},
            {-80,74}})));
  Modelica.Blocks.Sources.Step fanSig(height=2)
                                      "Pump signal"
    annotation (Placement(transformation(extent={{-92,6},{-80,18}})));
equation
  connect(sou.ports[1], decSys.port_a) annotation (Line(
      points={{-60,40},{-30,40}},
      color={0,127,255},
      thickness=0.5));
  connect(sin.ports[1], senWetBul.port_b) annotation (Line(
      points={{80,40},{70,40}},
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
  connect(pumSig.y, decSys.pumSig) annotation (Line(
      points={{-79.4,68},{-32,68},{-32,48}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fanSig.y, decSys.fanSig) annotation (Line(points={{-79.4,12},{-38,12},
          {-38,43},{-32,43}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,100}})), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-140},
            {120,100}})));
end Check;

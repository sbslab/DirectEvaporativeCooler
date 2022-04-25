within DirectEvaporativeCooler.Examples;
model DpPadTest  "Example model to test the pressure drop across the cooling pad"
    extends Modelica.Icons.Example;

  package MediumWater = Buildings.Media.Water "Water medium";
  package MediumAir = Buildings.Media.Air "Air medium";

  parameter Modelica.SIunits.MassFlowRate mW_flow_nominal=0.38 "Nominal mass flow rate on water side";
  parameter Modelica.SIunits.MassFlowRate mA_flow_nominal=3.12 "Nominal mass flow rate on air side";

  parameter Modelica.SIunits.PressureDifference dpW_nominal=100 "Nominal pressure drop on the water side";
  parameter Modelica.SIunits.PressureDifference dpA_nominal=170 "Nominal pressure drop on the air side";
  parameter Modelica.SIunits.PressureDifference dpD_nominal=74 "Nominal pressure drop across the duct";

  DirectEvaporativeCooler.BaseClasses.dpPad dpPad(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mA_flow_nominal,
    dp_nominal=dpA_nominal,
    Thickness=0.05,
    Length=0.42,
    Height=0.42,
    mW_flow_nominal=mW_flow_nominal,
    Contact_surface_area=361)                     annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Buildings.Fluid.Sources.Boundary_pT sin1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Blocks.Sources.TimeTable PreData100mm(table=[0,0.494505495; 1,2.28021978; 2,5.714285714; 3,8.324175824; 4,11.75824176;
        5,15.32967033; 6,21.51098901; 7,25.76923077; 8,31.81318681; 9,36.75824176; 10,43.35164835; 11,49.80769231; 12,
        56.95054945; 13,63.54395604; 14,70.96153846; 15,77.82967033], timeScale=140)
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Modelica.Blocks.Sources.TimeTable VelocityDat100mm(table=[0,0.372211776; 1,0.64570359; 2,1.045094623; 3,1.284204806;
        4,1.501492228; 5,1.718805527; 6,2.049640313; 7,2.270222713; 8,2.525678403; 9,2.740110753; 10,2.973691928; 11,3.185269205;
        12,3.4032553; 13,3.611718737; 14,3.820337433; 15,3.988036297], timeScale=140)
    annotation (Placement(transformation(extent={{-22,-80},{-2,-60}})));
  Modelica.Blocks.Sources.TimeTable
                               fanSig(
    table=[0,108.0998278; 1,324.2994835; 2,540.4991391; 3,756.6987947; 4,972.8984504; 5,1189.098106; 6,1405.297762; 7,
        1621.497417],
    timeScale=300,
    offset=0)                         "Fan Signal" annotation (Placement(transformation(extent={{-72,34},{-60,46}})));

  Buildings.Fluid.Sources.Boundary_pT sou1(
    redeclare package Medium = MediumAir,
    use_Xi_in=false,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  parameter Records.HCT_45_2T HCT_45_2T annotation (Placement(transformation(extent={{-60,-76},{-40,-56}})));
  Buildings.Fluid.Movers.SpeedControlled_Nrpm pump(
    redeclare package Medium = MediumAir,
    per=HCT_45_2T,
    addPowerToMedium=true) annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
equation
  connect(dpPad.port_b, sin1.ports[1]) annotation (Line(points={{0,0},{20,0}}, color={0,127,255}));
  connect(sou1.ports[1], pump.port_a) annotation (Line(points={{-60,0},{-50,0}}, color={0,127,255}));
  connect(pump.port_b, dpPad.port_a) annotation (Line(points={{-30,0},{-20,0}}, color={0,127,255}));
  connect(fanSig.y, pump.Nrpm) annotation (Line(points={{-59.4,40},{-40,40},{-40,12}}, color={0,0,127}));

annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,100}})), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -140},{220,100}})),
                          experiment(
      StopTime=41400,
      Interval=300,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
       __Dymola_Commands(file="modelica://DirectEvaporativeCooler/Scripts/DpPadTest.mos"
        "Simulate and plot"));
end DpPadTest;

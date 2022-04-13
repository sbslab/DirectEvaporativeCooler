within DirectEvaporativeCooler.Obsolete;
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

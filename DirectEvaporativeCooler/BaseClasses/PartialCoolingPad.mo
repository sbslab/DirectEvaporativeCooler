within DirectEvaporativeCooler.BaseClasses;
partial model PartialCoolingPad
                        "Partial model for implementing various cooling pad with varied degree of details"

  extends Buildings.Fluid.Interfaces.PartialFourPortInterface(
    allowFlowReversal2=false,
    allowFlowReversal1=false,
    port_a1(h_outflow(start=h1_outflow_start)),
    port_b1(h_outflow(start=h1_outflow_start)),
    port_a2(h_outflow(start=h2_outflow_start)),
    port_b2(h_outflow(start=h2_outflow_start)));

  //Nominal pressure drop
  parameter Modelica.SIunits.PressureDifference dp_pad_nominal "Pressure drop acrross the cooling pad at nominal mass flow rate on the air side"
    annotation (Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.PressureDifference dp_pip_nominal "Pressure drop at nominal mass flow rate on the water side"
    annotation (Dialog(group="Nominal condition"));

  ////Cooling pad types

  parameter DirectEvaporativeCooler.BaseClasses.CooPad CooPadTyp=DirectEvaporativeCooler.BaseClasses.CooPad.Lumped
    "Specifies the type of cooling pad based on the level of details : 1. Lumped  2.Physics-based" annotation (Dialog(group="Cooling pad type"));

  parameter DirectEvaporativeCooler.BaseClasses.CooPadMaterial CooPadMaterial=DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Cellulose
    "Various types of cooling pad materials/media such as Cellulose, Glass fiber, Paper, Coir, Aspen"
    annotation (Dialog(group="Cooling pad type", enable=not (CooPadTyp == DirectEvaporativeCooler.BaseClasses.CooPad.Lumped)));

  //Parameters common for lumped and physics based cooling pads

  parameter Modelica.SIunits.Thickness Thickness "Evaporative cooling pad thickness(m)" annotation (Dialog(group="Evaporative cooler pad"));

  parameter Modelica.SIunits.Length Length "Evaporative cooling pad length(m)" annotation (Dialog(group="Evaporative cooler pad"));

  parameter Modelica.SIunits.Height Height "Evaporative cooling pad Height(m)" annotation (Dialog(group="Evaporative cooler pad"));

  parameter Modelica.SIunits.Area PadArea=Length*Height "Evaporative cooling pad area(m2)" annotation (Dialog(group="Evaporative cooler pad"));

  //Parameters specific to physics based cooling pad

  parameter Modelica.SIunits.ThermalConductivity K_value " Evaporative cooling pad thermal conductivity"
    annotation (Dialog(group="Evaporative cooler pad", enable=not (CooPadTyp == DirectEvaporativeCooler.BaseClasses.CooPad.Lumped)));

  parameter Real Contact_surface_area = if CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Cellulose then 440
  elseif CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.GlassFiber then 520
  elseif CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Paper then 380
  elseif CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Coir then 209
  else 299 "Surface area per unit volume in comact with air(m2/m3)"
    annotation (Dialog(group="Evaporative cooler pad", enable=not (CooPadTyp == DirectEvaporativeCooler.BaseClasses.CooPad.Lumped)));

  //Water consumption related parameters
  parameter Real DriftFactor "Factor of water lost due to drift(as droplets)" annotation (Dialog(group="Water consumption"));

  parameter Real Rcon "Ratio of solids in the blowdown water" annotation (Dialog(group="Water consumption"));

  Real p_atm=101325 "Atmospheric pressure in pascals";

  //Time constants
  parameter Modelica.SIunits.Time tau1=1 "Time constant at nominal flow" annotation (Dialog(tab="Dynamics", group="Nominal condition"));
  parameter Modelica.SIunits.Time tau2=1 "Time constant at nominal flow" annotation (Dialog(tab="Dynamics", group="Nominal condition"));

  // Mass and energy dynamics assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state" annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  // Initialization
  //Medium1 - air side
  parameter Medium1.AbsolutePressure p1_start=Medium1.p_default "Start value of pressure"
   annotation (Dialog(tab="Initialization", group="Medium 1"));
  parameter Medium1.Temperature T1_start=Medium1.T_default "Start value of temperature"
   annotation (Dialog(tab="Initialization", group="Medium 1"));
  parameter Medium1.MassFraction X1_start[Medium1.nX]=Medium1.X_default "Start value of mass fractions m_i/m"
    annotation (Dialog(
      tab="Initialization",
      group="Medium 1",
      enable=Medium1.nXi > 0));
  parameter Medium1.ExtraProperty C1_start[Medium1.nC](final quantity=Medium1.extraPropertiesNames) = fill(0, Medium1.nC) "Start value of trace substances"
    annotation (Dialog(
      tab="Initialization",
      group="Medium 1",
      enable=Medium1.nC > 0));
  parameter Medium1.ExtraProperty C1_nominal[Medium1.nC](final quantity=Medium1.extraPropertiesNames) = fill(1E-2, Medium1.nC)
    "Nominal value of trace substances. (Set to typical order of magnitude.)"
    annotation (Dialog(
      tab="Initialization",
      group="Medium 1",
      enable=Medium1.nC > 0));

  //Medium2 - water side
  parameter Medium2.AbsolutePressure p2_start=Medium2.p_default "Start value of pressure"
   annotation (Dialog(tab="Initialization", group="Medium 2"));
  parameter Medium2.Temperature T2_start=Medium2.T_default "Start value of temperature"
   annotation (Dialog(tab="Initialization", group="Medium 2"));
  parameter Medium2.MassFraction X2_start[Medium2.nX]=Medium2.X_default "Start value of mass fractions m_i/m"
    annotation (Dialog(
      tab="Initialization",
      group="Medium 2",
      enable=Medium2.nXi > 0));
  parameter Medium2.ExtraProperty C2_start[Medium2.nC](final quantity=Medium2.extraPropertiesNames) = fill(0, Medium2.nC) "Start value of trace substances"
    annotation (Dialog(
      tab="Initialization",
      group="Medium 2",
      enable=Medium2.nC > 0));
  parameter Medium2.ExtraProperty C2_nominal[Medium2.nC](final quantity=Medium2.extraPropertiesNames) = fill(1E-2, Medium2.nC)
    "Nominal value of trace substances. (Set to typical order of magnitude.)"
    annotation (Dialog(
      tab="Initialization",
      group="Medium 2",
      enable=Medium2.nC > 0));

  //Initiated classes

  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(
    redeclare final package Medium = Medium1,
    final m_flow_nominal=m1_flow_nominal,
    final m_flow_small=m1_flow_small,
    final initType=Modelica.Blocks.Types.Init.NoInit,
    final T_start=T1_start) "Drybulb temperature sensor" annotation (Placement(transformation(extent={{-46,66},{-34,54}})));
  Buildings.Fluid.Sensors.TemperatureWetBulbTwoPort senWetBul(
    redeclare final package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    final m_flow_small=m1_flow_small,
    final initType=Modelica.Blocks.Types.Init.NoInit) "Wetbulb temperature sensor" annotation (Placement(transformation(extent={{-66,66},{-54,54}})));
  Buildings.Fluid.Sensors.MassFractionTwoPort senMasFra(
    redeclare final package Medium = Medium1,
    final m_flow_nominal=m1_flow_nominal,
    final tau=tau1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    final substanceName="Air") "Mass fraction sensor (Humidity ratio)" annotation (Placement(transformation(extent={{-6,66},{6,54}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloW(redeclare final package Medium = Medium2, final allowFlowReversal=allowFlowReversal2) "Mass flow rate of water"
    annotation (Placement(transformation(extent={{-46,-66},{-34,-54}})));
  Buildings.Fluid.MixingVolumes.MixingVolume volWat(
    redeclare final package Medium = Medium2,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p_start=p2_start,
    final T_start=T2_start,
    final X_start=X2_start,
    final C_start=C2_start,
    final C_nominal=C2_nominal,
    final m_flow_nominal=m2_flow_nominal,
    final nPorts=3,
    final m_flow_small=m2_flow_small,
    final allowFlowReversal=allowFlowReversal2,
    final V=m2_flow_nominal*tau2/rho2_nominal) "Mixing Volume - Water" annotation (Placement(transformation(extent={{-60,-60},{-80,-80}})));
  Buildings.Fluid.MixingVolumes.MixingVolumeMoistAir volAir(
    redeclare final package Medium = Medium1,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p_start=p1_start,
    final T_start=T1_start,
    final X_start=X1_start,
    final C_start=C1_start,
    final C_nominal=C1_nominal,
    final m_flow_nominal=m1_flow_nominal,
    final nPorts=2,
    final m_flow_small=m1_flow_small,
    final allowFlowReversal=allowFlowReversal1,
    final V=m1_flow_nominal*tau1/rho1_nominal) "Mixing volume - Air" annotation (Placement(transformation(extent={{60,60},{80,40}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare final package Medium = Medium1, final allowFlowReversal=allowFlowReversal1) "Mass flow rate sensor"
    annotation (Placement(transformation(extent={{-26,66},{-14,54}})));
  Buildings.Fluid.FixedResistances.PressureDrop dpPad(
    redeclare final package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    linearized=false) "Pressure drop across the cooling pad, calculated based on the pad characteristics, dimensions and mass flow of air and water. "
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Buildings.Fluid.FixedResistances.PressureDrop dpPip(
    redeclare final package Medium = Medium2,
    final allowFlowReversal=allowFlowReversal2,
    final m_flow_nominal=m2_flow_nominal,
    final dp_nominal=dp_pip_nominal) "Pressure raise to pump the water over the cooling pad" annotation (Placement(transformation(extent={{20,-70},{40,-50}})));

  Buildings.Fluid.Sensors.Velocity senVel(
    redeclare final package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    final m_flow_small=m1_flow_small,
    final initType=Modelica.Blocks.Types.Init.NoInit) "Velocity sensor" annotation (Placement(transformation(extent={{-86,66},{-74,54}})));
  Modelica.Fluid.Sources.MassFlowSource_T MasFloRem(
    redeclare package Medium = Medium2,
    use_m_flow_in=true,
    nPorts=1) "Mass flow rate of water removed due to the process of evaportion" annotation (Placement(transformation(extent={{0,-50},{-20,-30}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={26,-32})));
protected
  parameter Medium1.ThermodynamicState sta1_nominal=Medium1.setState_pTX(
      T=Medium1.T_default,
      p=Medium1.p_default,
      X=Medium1.X_default);
  parameter Modelica.SIunits.Density rho1_nominal=Medium1.density(sta1_nominal) "Density of medium 1, used to compute fluid volume";

  parameter Medium1.ThermodynamicState sta1_start=Medium1.setState_pTX(
      T=T1_start,
      p=p1_start,
      X=X1_start);
  parameter Modelica.SIunits.SpecificEnthalpy h1_outflow_start=Medium1.specificEnthalpy(sta1_start) "Start value for outflowing enthalpy";

  parameter Medium2.ThermodynamicState sta2_nominal=Medium2.setState_pTX(
      T=Medium2.T_default,
      p=Medium2.p_default,
      X=Medium2.X_default);
  parameter Modelica.SIunits.Density rho2_nominal=Medium2.density(sta2_nominal) "Density of medium 2, used to compute fluid volume";

  parameter Medium2.ThermodynamicState sta2_start=Medium2.setState_pTX(
      T=T2_start,
      p=p2_start,
      X=X2_start);
  parameter Modelica.SIunits.SpecificEnthalpy h2_outflow_start=Medium2.specificEnthalpy(sta2_start) "Start value for outflowing enthalpy";

  Buildings.HeatTransfer.Sources.PrescribedHeatFlow Qs "Sensible heat transfered into water"
    annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={26,-86})));
equation

  connect(dpPad.port_b, volAir.ports[1]) annotation (Line(
      points={{40,60},{68,60}},
      color={0,127,255},
      thickness=0.5));
  connect(port_b2, volWat.ports[1]) annotation (Line(
      points={{-100,-60},{-67.3333,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(volAir.ports[2], port_b1) annotation (Line(
      points={{72,60},{100,60}},
      color={0,127,255},
      thickness=0.5));
  connect(port_b2, port_b2) annotation (Line(points={{-100,-60},{-100,-60}}, color={0,127,255}));
  connect(port_a1, senVel.port_a) annotation (Line(
      points={{-100,60},{-86,60}},
      color={0,127,255},
      thickness=0.5));
  connect(senVel.port_b, senWetBul.port_a) annotation (Line(
      points={{-74,60},{-66,60}},
      color={0,127,255},
      thickness=0.5));
  connect(senWetBul.port_b, senTem.port_a) annotation (Line(
      points={{-54,60},{-46,60}},
      color={0,127,255},
      thickness=0.5));
  connect(senTem.port_b, senMasFlo.port_a) annotation (Line(
      points={{-34,60},{-26,60}},
      color={0,127,255},
      thickness=0.5));
  connect(senMasFlo.port_b, senMasFra.port_a) annotation (Line(
      points={{-14,60},{-6,60}},
      color={0,127,255},
      thickness=0.5));
  connect(senMasFra.port_b, dpPad.port_a) annotation (Line(
      points={{6,60},{20,60}},
      color={0,127,255},
      thickness=0.5));
  connect(volWat.ports[2], senMasFloW.port_a) annotation (Line(
      points={{-70,-60},{-46,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(senMasFloW.port_b, dpPip.port_a) annotation (Line(
      points={{-34,-60},{20,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(dpPip.port_b, port_a2) annotation (Line(
      points={{40,-60},{100,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(MasFloRem.ports[1], volWat.ports[3]) annotation (Line(points={{-20,-40},{-72.6667,-40},{-72.6667,-60}}, color={0,127,255}));
  connect(gain.y, MasFloRem.m_flow_in) annotation (Line(points={{19.4,-32},{0,-32}}, color={0,0,127}));
  connect(volWat.heatPort, Qs.port) annotation (Line(points={{-60,-70},{-60,-86},{20,-86}}, color={191,0,0}));
  annotation (Diagram(graphics={
        Text(
          extent={{74,88},{99,78}},
          lineColor={28,108,200},
          fontName="serif",
          textString="Air side"),
        Text(
          extent={{-146,-203},{-114,-215}},
          lineColor={28,108,200},
          textString="Water Side",
          fontName="serif"),
        Text(
          extent={{66,-70},{97,-84}},
          lineColor={28,108,200},
          fontName="serif",
          textString="Water side")}), Icon(graphics={
        Rectangle(
          extent={{-94,-54},{94,-66}},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-94,66},{94,54}},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-40,80},{40,-80}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,80},{40,-80}},
          lineColor={132,105,78},
          lineThickness=0.5),
        Line(points={{-20,80},{-20,-80}}, color={132,105,78}),
        Line(points={{0,80},{0,-80}}, color={132,105,78}),
        Line(points={{20,80},{20,-80}}, color={132,105,78}),
        Line(points={{-40,80},{0,40},{-40,0},{0,-40},{-40,-80}}, color={132,105,78}),
        Line(points={{-20,80},{20,40},{-20,0},{20,-40},{-20,-80}}, color={132,105,78}),
        Line(points={{0,80},{2,78},{40,40},{0,0},{40,-40},{0,-80}}, color={132,105,78}),
        Line(points={{-40,60},{-20,40},{-40,20}}, color={132,105,78}),
        Line(points={{-40,-20},{-20,-40},{-40,-60}}, color={132,105,78}),
        Line(points={{20,80},{40,60}}, color={132,105,78}),
        Line(points={{40,20},{20,0},{40,-20}}, color={132,105,78}),
        Line(points={{40,-60},{20,-80}}, color={132,105,78}),
        Ellipse(
          extent={{-26,38},{-14,26}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-26,34},{-20,44},{-14,34},{-26,34}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-26,-28},{-20,-18},{-14,-28},{-26,-28}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-26,-24},{-14,-36}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{14,14},{26,2}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{14,10},{20,20},{26,10},{14,10}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{14,-46},{20,-36},{26,-46},{14,-46}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{14,-42},{26,-54}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-16,66},{94,54}},
          pattern=LinePattern.None,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          lineColor={28,108,200}),
        Rectangle(
          extent={{-104,66},{0,54}},
          pattern=LinePattern.None,
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          lineColor={238,46,47})}));
end PartialCoolingPad;

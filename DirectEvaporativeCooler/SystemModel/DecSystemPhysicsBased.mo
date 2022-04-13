within DirectEvaporativeCooler.SystemModel;
model DecSystemPhysicsBased "Model of Direct evaporative cooling system with pump and fan components"

  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(port_a(h_outflow(start=h_outflow_start)), port_b(h_outflow(start=h_outflow_start)));
  extends Buildings.Fluid.Interfaces.TwoPortFlowResistanceParameters(final computeFlowResistance=true);

  //Medium model for the water side
  package MediumWater = Buildings.Media.Water "Water medium";

  // Propagated parameters
  parameter Modelica.SIunits.MassFlowRate mW_flow_nominal "Nominal mass flow rate of water" annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.PressureDifference dp_pad_nominal=6000 "Pressure drop acrross the cooling pad at nominal mass flow rate on the air side"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.PressureDifference dp_pip_nominal=1000 "Pressure drop at nominal mass flow rate on the water side"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.Thickness Thickness=0.100 "Evaporative cooling pad thickness(m)" annotation (Dialog(group="Cooling pad parameters"));
  parameter Modelica.SIunits.Length Length=2.1 "Evaporative cooling pad length(m)" annotation (Dialog(group="Cooling pad parameters"));
  parameter Modelica.SIunits.Thickness Height=0.91 "Evaporative cooling pad Height(m)" annotation (Dialog(group="Cooling pad parameters"));

  //Parameters specific to physics based cooling pad

  parameter BaseClasses.CooPadMaterial CooPadMaterial=DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Cellulose
    "Various types of cooling pad materials/media such as Cellulose, Glass fiber, Paper, Coir, Aspen" annotation (Dialog(group="Cooling pad parameters"));

  parameter Real Contact_surface_area=if CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Cellulose then 440 elseif CooPadMaterial ==
      DirectEvaporativeCooler.BaseClasses.CooPadMaterial.GlassFiber then 520 elseif CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Paper then 380
       elseif CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Coir then 209 else 299 "Surface area per unit volume in comact with air(m2/m3)"
    annotation (Dialog(group="Cooling pad parameters"));

  parameter Modelica.SIunits.Conductivity K_value=0.04 " Evaporative cooling pad thermal conductivity" annotation (Dialog(group="Cooling pad parameters"));
  parameter Real DriftFactor=0.1 "Factor of water lost due to drift(as droplets)" annotation (Dialog(group="Water consumption"));
  parameter Real Rcon=3 "Ratio of solids in the blowdown water" annotation (Dialog(group="Water consumption"));

  // Dynamics
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state" annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  // Initialization
  parameter Medium.AbsolutePressure p_start=Medium.p_default "Start value of pressure" annotation (Dialog(tab="Initialization"));
  parameter Medium.Temperature T_start=Medium.T_default "Start value of temperature" annotation (Dialog(tab="Initialization"));
  parameter Medium.MassFraction X_start[Medium.nX](final quantity=Medium.substanceNames) = Medium.X_default "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
  parameter Medium.ExtraProperty C_start[Medium.nC](final quantity=Medium.extraPropertiesNames) = fill(0, Medium.nC) "Start value of trace substances"
    annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));

  //Outputs
  Modelica.Blocks.Interfaces.RealInput pumSig "Pump signal"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}}), iconTransformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput fanSig "Fan signal"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}}), iconTransformation(extent={{-140,10},{-100,50}})));

  Buildings.Fluid.Movers.SpeedControlled_Nrpm
                                           pump(
    redeclare final package Medium = Medium,
    y_start=1,
    redeclare parameter Buildings.Fluid.Movers.Data.Generic per,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    addPowerToMedium=false) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                           pum(redeclare final package Medium =
        MediumWater,                                                                         addPowerToMedium=false)
    annotation (Placement(transformation(extent={{40,-50},{22,-30}})));
  Buildings.Fluid.Sources.Boundary_pT souWat(
    redeclare final package Medium = MediumWater,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{80,-50},{60,-30}})));
  Buildings.Fluid.Sources.Boundary_pT sinWat(redeclare final package Medium =
        MediumWater,                                                                       nPorts=1)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

  ComponentModels.Lumped cooPad(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = MediumWater,
    final m1_flow_nominal=m_flow_nominal,
    final m2_flow_nominal=mW_flow_nominal,
    final dp_pad_nominal=dp_pad_nominal,
    final dp_pip_nominal=dp_pip_nominal,
    final CooPadTyp=DirectEvaporativeCooler.BaseClasses.CooPad.PhysicsBased,
    final CooPadMaterial=CooPadMaterial,
    final Thickness=Thickness,
    final Length=Length,
    final Height=Height,
    final K_value=K_value,
    final Contact_surface_area=Contact_surface_area,
    final DriftFactor=DriftFactor,
    final Rcon=Rcon) annotation (Placement(transformation(extent={{-20,-16},{0,4}})));

  Modelica.Blocks.Sources.RealExpression pumPow(y=pum.P) "Power consumed by pump" annotation (Placement(transformation(extent={{60,70},{80,90}})));
  Modelica.Blocks.Sources.RealExpression fanPow(y=pump.P)
    "Power consumed by fan/blower"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Interfaces.RealOutput pumP "Power consumed by water pump to wet the cooling pad"
    annotation (Placement(transformation(extent={{100,70},{120,90}}), iconTransformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput fanP "Power consumed by fan to blow the air through the cooling pad"
    annotation (Placement(transformation(extent={{100,50},{120,70}}), iconTransformation(extent={{100,50},{120,70}})));
protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default) "Density, used to compute fluid volume";
  parameter Medium.ThermodynamicState sta_start=Medium.setState_pTX(
      T=T_start,
      p=p_start,
      X=X_start);
  parameter Modelica.SIunits.SpecificEnthalpy h_outflow_start=Medium.specificEnthalpy(sta_start) "Start value for outflowing enthalpy";

equation

  connect(port_a, pump.port_a) annotation (Line(
      points={{-100,0},{-60,0}},
      color={0,127,255},
      thickness=0.5));
  connect(pum.port_a, souWat.ports[1]) annotation (Line(
      points={{40,-40},{60,-40}},
      color={0,127,255},
      thickness=0.5));
  connect(pump.port_b, cooPad.port_a1) annotation (Line(
      points={{-40,0},{-20,0}},
      color={0,127,255},
      thickness=0.5));
  connect(sinWat.ports[1],cooPad. port_b2) annotation (Line(
      points={{-40,-40},{-26,-40},{-26,-12},{-20,-12}},
      color={0,127,255},
      thickness=0.5));
  connect(cooPad.port_a2, pum.port_b) annotation (Line(
      points={{0,-12},{8,-12},{8,-40},{22,-40}},
      color={0,127,255},
      thickness=0.5));
  connect(cooPad.port_b1, port_b) annotation (Line(
      points={{0,0},{100,0}},
      color={0,127,255},
      thickness=0.5));
  connect(fanP, fanP) annotation (Line(points={{110,60},{110,60}}, color={0,0,127}));
  connect(fanPow.y, fanP) annotation (Line(points={{81,60},{110,60}}, color={0,0,127}));
  connect(pumPow.y, pumP) annotation (Line(points={{81,80},{110,80}}, color={0,0,127}));
  connect(pumSig, pum.m_flow_in)
    annotation (Line(points={{-120,80},{31,80},{31,-28}}, color={0,0,127}));
  connect(fanSig, pump.Nrpm)
    annotation (Line(points={{-120,30},{-50,30},{-50,12}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-74,1},{74,-1}},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={-69,-14},
          rotation=-90),
        Rectangle(
          extent={{-70,70},{4,68}},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Line(points={{-40,60},{-20,40},{-40,20}}, color={132,105,78}),
        Line(points={{-40,80},{0,40},{-40,0},{0,-40},{-40,-80}}, color={132,105,78}),
        Line(points={{-20,80},{20,40},{-20,0},{20,-40},{-20,-80}}, color={132,105,78}),
        Line(points={{0,80},{20,60}}, color={132,105,78}),
        Ellipse(
          extent={{4,22},{16,10}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{4,18},{10,28},{16,18},{4,18}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-26,-20},{-20,-10},{-14,-20},{-26,-20}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-26,-16},{-14,-28}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-26,46},{-20,56},{-14,46},{-26,46}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-26,50},{-14,38}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,-46},{18,-58}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{6,-50},{12,-40},{18,-50},{6,-50}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{-40,-20},{-20,-40},{-40,-60}}, color={132,105,78}),
        Line(points={{20,20},{0,0},{20,-20}}, color={132,105,78}),
        Line(points={{20,-60},{0,-80}}, color={132,105,78}),
        Line(points={{20,80},{20,-80}}, color={132,105,78}),
        Line(points={{-20,80},{-20,-80}}, color={132,105,78}),
        Line(points={{0,80},{0,-80}}, color={132,105,78}),
        Rectangle(
          extent={{-40,80},{20,-80}},
          lineColor={132,105,78},
          lineThickness=0.5),
        Rectangle(
          extent={{-98,6},{90,-6}},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-98,6},{-10,-6}},
          pattern=LinePattern.None,
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          lineColor={238,46,47}),
        Rectangle(
          extent={{-10,6},{100,-6}},
          pattern=LinePattern.None,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          lineColor={28,108,200}),
        Ellipse(
          extent={{28,20},{70,-22}},
          lineColor={140,140,140},
          pattern=LinePattern.None,
          fillColor={165,165,165},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,18},{40,-20},{70,0},{40,18}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,80},{-60,60}},
          lineColor={140,140,140},
          pattern=LinePattern.None,
          fillColor={165,165,165},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-74,78},{-74,62},{-62,70},{-74,78}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-84,-82},{48,-98}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Line(
          points={{-100,80},{-76,70},{-116,78}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-80,68},{-90,72}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-100,80},{-76,80},{-70,80},{-70,72}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-102,30},{48,30},{48,10}},
          color={0,0,0},
          pattern=LinePattern.Dash)}),
    defaultComponentName="dec",
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end DecSystemPhysicsBased;

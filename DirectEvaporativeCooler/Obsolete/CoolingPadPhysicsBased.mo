within DirectEvaporativeCooler.Obsolete;
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
    constrainedby Buildings.Fluid.MixingVolumes.BaseClasses.MixingVolumeHeatMoisturePort(
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
    constrainedby Buildings.Fluid.MixingVolumes.BaseClasses.MixingVolumeHeatPort(
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
  Buildings.Fluid.FixedResistances.PressureDrop preDro1(redeclare package
      Medium = Medium2, m_flow_nominal=m2_flow_nominal)
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
 Received tau1 = " + String(tau1) + "\n");
  assert((massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
          tau1 > Modelica.Constants.eps,
"The parameter tau1, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau1 = " + String(tau1) + "\n");

 // Check for tau2
  assert((energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
          tau2 > Modelica.Constants.eps,
"The parameter tau2, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau2 = " + String(tau2) + "\n");
  assert((massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) or
          tau2 > Modelica.Constants.eps,
"The parameter tau2, or the volume of the model from which tau may be derived, is unreasonably small.
 You need to set massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState to model steady-state.
 Received tau2 = " + String(tau2) + "\n");

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
</html>", revisions="<html>
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
",        pattern=LinePattern.Dash),
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
"),                   Text(
          extent={{53,35},{96,24}},
          lineColor={0,0,0},
          fontName="serif",
          textStyle={TextStyle.Italic},
          textString="Mixing Volume with 
Static conservation equation
"),                   Text(
          extent={{-27,-9},{-15,-16}},
          lineColor={0,0,127},
          fontName="serif",
          textStyle={TextStyle.Italic},
          textString="dp_pad
",        pattern=LinePattern.Dash)}));
end CoolingPadPhysicsBased;

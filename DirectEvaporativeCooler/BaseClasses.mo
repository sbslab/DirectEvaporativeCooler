within DirectEvaporativeCooler;
package BaseClasses "Blocks and components used in the model"
  extends Modelica.Icons.BasesPackage;
  block CoolingPadEfficiencyLumped "To compute the evaporative cooling pad efficiency"


    //Real inputs and outputs
    Modelica.Blocks.Interfaces.RealInput v_a "Velocity of the air (m/s)"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput pad_eff "Efficiency of the cooling pad "
      annotation (Placement(transformation(extent={{92,-12},{112,8}}), iconTransformation(extent={{100,-14},{128,14}})));


    //Parameters
    parameter Modelica.SIunits.Thickness d " Thickness of the cooling pad in m";
    Real Eff;

  equation
    Eff = (0.792714 + (0.958569*d) - (0.25193*v_a) - (1.03215*(d^2)) + (0.0262659*(v_a^2)) + (0.914869*(d*v_a)) - (1.4821*(v_a*(d^2)))
       - 0.018992*((v_a^3)*d^2) + (1.13137*((d^3)*v_a)) + (0.0327622*(v_a^3*d^2)) - (0.145384*(d^3)*(v_a^2)));

    pad_eff = if Eff > 1 then 1 elseif Eff <= 0 then 0 else Eff;


    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      defaultComponentName="effLum",
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end CoolingPadEfficiencyLumped;

  block CoolingPadEfficiencyPhysicsBased

    //Parameters
    parameter Modelica.SIunits.ThermalConductivity k = 0.045 "Thermal conductivity of the pad media";
    parameter Modelica.SIunits.Thickness d "Thickness of the cooling pad,m";
    parameter Modelica.SIunits.Length l  "Length of the cooling pad,m";
    parameter Modelica.SIunits.Height h  "Height of the cooling pad,m";
    parameter Real xi  "ξ, specific contact area or wetted surface area of the cooling pad, m2/m3";

    // Cooling pad media
    parameter DirectEvaporativeCooler.BaseClasses.CooPadMaterial CooPadMaterial = DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Cellulose
    "Various types of cooling pad materials/media such as Cellulose, Glass fiber, Paper, Coir, Aspen";



    //Constant and variables
    Modelica.SIunits.Pressure p_atm = 101325 " Atmospheric pressure, pa ";
    Modelica.SIunits.Area A = l * h " Area of the cooling pad, m2";
    Modelica.SIunits.Volume V = A * d "Volume of the cooling pad,m3";
    Modelica.SIunits.Area TSA = (V * xi) "Total surface area of the cooling pad,m2";
    Modelica.SIunits.SpecificHeatCapacity Cpa = 1000 " Specific heat of air J/kg K";
    Modelica.SIunits.Density rho " Air density, kg/m3";
    Modelica.SIunits.Length le = (V/ TSA) "Characteristic length ,m";
    Modelica.SIunits.ThermalConductivity ka = 0.02706 "Thermal conductivity of air, W/mK";
    Real Nu " Nusselt number";
    Real Re " Reynolds number";
    Real Pr " Prandtl number";
    Real Mu = 8* (10^(-6))*exp(0.0027*Tdb_in)  " Dynamic viscosity, mpa s";
    Real eff "Efficiency of the cooling pad";


    //Psychrometric variables
    Real Twb_ou "Wet bulb temperature of the outlet air";
    Real Tdp "Dew point temperature of the outlet air";
    Real p_wat "Partial pressure";
    Real ed "Saturation Vapor Pressure at Dry Bulb (mb)";
    Real ew "Saturation Vapor Pressure at Wet Bulb (mb)";
    Real e "Actual Vapor Pressure (mb)";
    Real B "Intermediate variable";
    Real phi "Relative humidity, %";
    Modelica.SIunits.Temp_C Tdb_ouC, Twb_ouC "intermediate variables";


     Modelica.Blocks.Interfaces.RealInput Twb_in
      "Inlet wet bulb temperature of air,C"
       annotation (Placement(transformation(
            extent={{-112,-94},{-72,-54}}),
                                          iconTransformation(extent={{-140,20},{-100,60}})));
    Modelica.Blocks.Interfaces.RealInput Tdb_in
      "Inlet Drybulb temperature of air,C"
       annotation (Placement(transformation(
            extent={{-112,-68},{-72,-28}}),
                                          iconTransformation(extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-60,120})));
    Modelica.Blocks.Interfaces.RealOutput Tdb_ou
    "Outlet drybulb temperature,C"
      annotation (Placement(transformation(extent={{100,10},{120,30}}),
          iconTransformation(extent={{100,10},{120,30}})));
    Modelica.Blocks.Interfaces.RealOutput w_ou
    "Outlet humidity ratio , kg/kg"
     annotation (
       Placement(transformation(extent={{100,-30},{120,-10}}),
                                                            iconTransformation(
            extent={{100,-30},{120,-10}})));
    Modelica.Blocks.Interfaces.RealOutput hm
     "Mass transfer coefficient "
      annotation (Placement(transformation(extent={{100,50},{120,70}}),
          iconTransformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.RealOutput hc
      "Convective heat transfer coefficient"
       annotation (Placement(transformation(
            extent={{100,-48},{120,-28}}),
                                        iconTransformation(extent={{100,-70},{120,-50}})));
    Modelica.Blocks.Interfaces.RealInput v_a
      "Velocity of air passing through the cooling pad , m/s"
       annotation (Placement(
          transformation(extent={{-114,-8},{-74,32}}), iconTransformation(
          extent={{-20,20},{20,-20}},
          rotation=0,
          origin={-120,-40})));



  equation
  //Step 1: Calculating Re and Pr to calculate Nusselts number

  rho = p_atm/(287.08*(Twb_in))    " Density of air at the wetbulb temperature";
  Re = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(v_a,rho,Mu,l)
   "Renyolds number";
  Pr = Modelica.Fluid.Dissipation.Utilities.Functions.General.PrandtlNumber(Cpa,Mu,ka)
   "Prandtl number";


  // Step 2: Nusselts number varies for different cooling pad media
  Nu = if CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Cellulose then (0.10*((le/d)^(0.12))*(Re^0.8)*(Pr^0.33))
    elseif CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.GlassFiber then (0.11*((le/d)^(0.12))*(Re^0.8)*(Pr^0.33))
    elseif CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Paper then (0.07*((le/d)^(0.12))*(Re^0.8) * (Pr^0.33))
    elseif CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Coir then 0.13*((le/d)^(0.12))*(Re^0.9) * (Pr^0.33)
    else (0.35*((le/d)^(0.12))*(Re^0.8) * (Pr^0.33));


  // Step 3: Calculating hc and hm based on Nusselts number
  hc = (Nu*k)/l    "Lewis relationship between convective heat transfer coefficient and mass transfer coefficient (Le ~ 1 for water vapour and air)";
  hm = hc/Cpa;


  //Step 4: Deriving the cooling pad effectiveness or efficiency
  eff = 1 - exp((-hc*xi*d)/(v_a*rho*Cpa));


  //Step 5: Calculating the outlet conditions
  //(1) DBT
  Tdb_ou = Tdb_in - eff*(Tdb_in - Twb_in);


  //(2) WBT - assuming WBT in = WBT out
  Twb_ou= Twb_in;
  Tdb_ouC = Modelica.SIunits.Conversions.to_degC(Tdb_ou);
  Twb_ouC = Modelica.SIunits.Conversions.to_degC(Twb_ou);


  //(3) Calculating the mass fraction or humidity ratio of water vapour to be added to the air stream (added into mixing volume)
  ed = 6.108*exp((17.27*Tdb_ouC)/(237.3 + Tdb_ouC))  "Saturation Vapor Pressure at Dry Bulb (mb)";
  ew = 6.108*exp((17.27*Twb_ouC)/(237.3 + Twb_ouC))  "Saturation Vapor Pressure at Wet Bulb (mb)";
  e = ew - (0.00066*(1 + 0.00115*Twb_ouC)*(Tdb_ouC - Twb_ouC)*(p_atm/100))
  "Actual Vapor Pressure (mb)";
  phi = 100*(e/ed)  "Relative humidity";
  B = log(e/6.108)/17.27;
  Tdp = (237.3*B)/(1 - B) "Dew point temperature";
  p_wat = Buildings.Utilities.Psychrometrics.Functions.pW_TDewPoi(Tdp) "Using the function to calculate partial pressure of water vapour from Dew point temperature";
  w_ou = Buildings.Utilities.Psychrometrics.Functions.X_pW(p_wat)  "Humidity ratio for the given water pressure";



    annotation (Icon(coordinateSystem(preserveAspectRatio=false)),defaultComponentName="effPhy", Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CoolingPadEfficiencyPhysicsBased;

  block OutletConditions

    //parameters


    //Variables
     Modelica.SIunits.Temp_C Tdp "Dew point temperature of the outlet air,K";
     Modelica.SIunits.Temperature Tdb_ou "Outlet temeprature";
     Modelica.SIunits.Temperature Twb_ou "Wet Bulb temperature,K";



    //Psychrometric variables
     Real p_wat "Partial pressure";
     Real ed "Saturation Vapor Pressure at Dry Bulb (mb)";
     Real ew "Saturation Vapor Pressure at Wet Bulb (mb)";
     Real e "Actual Vapor Pressure (mb)";
     Real phi "Relative humidity";
     Real B "Intermediate variable";
     Modelica.SIunits.Pressure p_atm=101325 "atmospheric pressure(in pascals)";
     Modelica.SIunits.Temp_C Tdb_ouC, Twb_ouC "intermediate variables";



    //Real inputs and outputs

    Modelica.Blocks.Interfaces.RealInput eff
    "Efficiency of the cooling pad"
     annotation (Placement(
          transformation(extent={{-140,-100},{-100,-60}}),
                                                         iconTransformation(
            extent={{-140,-100},{-100,-60}})));
    Modelica.Blocks.Interfaces.RealInput Twb_in
    "Inlet Wet bulb temperature"
     annotation (Placement(
          transformation(extent={{-140,10},{-100,50}}),iconTransformation(extent={{-140,10},{-100,50}})));
    Modelica.Blocks.Interfaces.RealInput Tdb_in
    "Inlet drybulb temperature"
     annotation (Placement(
          transformation(extent={{-140,60},{-100,100}}),
                                                       iconTransformation(extent={{-140,60},{-100,100}})));
    Modelica.Blocks.Interfaces.RealOutput w_ou
    "Humidity ratio of the exit air"
      annotation (Placement(transformation(extent={{100,30},{120,50}}),iconTransformation(extent={{100,6},{128,34}})));
    Modelica.Blocks.Interfaces.RealOutput qS
    "Sensible heat transfer"
     annotation (Placement(transformation(extent={{100,30},{120,50}}), iconTransformation(extent={{100,-34},{128,-6}})));
    Modelica.Blocks.Interfaces.RealInput m_a
    "Mass flow rate of air"
      annotation (Placement(transformation(extent={{-140,10},{-100,50}}), iconTransformation(extent={{-140,-50},{-100,-10}})));


  equation

    //Step 1: Computing Tdb of the leaving air
    Tdb_ou = Tdb_in - (eff*(Tdb_in-Twb_in));

    //Step 2: Assuming Twb_in = Twb_ou
    Twb_ou =  Twb_in;

    //Step 3: Converting to celcius
    Tdb_ouC = Modelica.SIunits.Conversions.to_degC(Tdb_ou);
    Twb_ouC = Modelica.SIunits.Conversions.to_degC(Twb_in);

   //Step 4: Computing RH(phi) using Tdb_ou, Twb_ou and atmospheric pressure

  ed =  6.108 * exp((17.27*Tdb_ouC)/(237.3+Tdb_ouC)) "Saturation Vapor Pressure at Dry Bulb (mb)";
  ew =  6.108 * exp((17.27*Twb_ouC)/(237.3+Twb_ouC)) "Saturation Vapor Pressure at wet bulb Bulb (mb)";
  e =  ew - (0.00066 * (1+0.00115*Twb_ouC)*(Tdb_ouC-Twb_ouC)*(p_atm/100));
  phi =  100*(e/ed) "Relative humidity of the outlet air";
  B =  log(e/6.108)/17.27;
  Tdp =  (237.3*B)/(1-B) "Dew point temperature of the outlet air";
  p_wat =  (6.11* 10^((7.5*Tdp)/(237.3+Tdp)))*100 "Partial pressure of water vapour of the outlet air";
  w_ou=  Buildings.Utilities.Psychrometrics.Functions.X_pW(p_wat);

  // Step 5: Determining the sensible heat transered = laten heat transfered in the process of evaporative cooling
  qS = m_a*1.225*(Tdb_in - Tdb_ou) "Sensible heat transfered";


    annotation (Icon(coordinateSystem(preserveAspectRatio=false)),defaultComponentName="outCon", Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end OutletConditions;

  block WaterConsumption


    //Parameters
    Real m_drift "Mass flow rate of water due to drift losses";
    Real m_blo " Mass flow rate of water due to blowdown";
    Real rhoW=1 "Density of water (kg/m3)";
    parameter Real f_drift=1 "Drift fraction";
    parameter Real rCon=1 "Ratio of solids in blowdown water";


    //Real input and outpu
    Modelica.Blocks.Interfaces.RealInput m_a "mass flow rate of the air (kg/s)"
      annotation (Placement(transformation(extent={{-114,38},{-74,78}}), iconTransformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput w_in "Humidity ratio of the inlet water (kg/kg)"
      annotation (Placement(transformation(extent={{-114,-16},{-74,24}}), iconTransformation(extent={{-140,40},{-100,80}})));
    Modelica.Blocks.Interfaces.RealInput w_ou "Humidity ratio of the outlet water(kg/kg)"
      annotation (Placement(transformation(extent={{-114,10},{-74,50}}), iconTransformation(extent={{-140,-80},{-100,-40}})));
    Modelica.Blocks.Interfaces.RealOutput V_eva "evaporatived water consumption in m3/s"
      annotation (Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(
          extent={{-14,-14},{14,14}},
          rotation=0,
          origin={114,40})));
    Modelica.Blocks.Interfaces.RealOutput V_tot "Total volume of water consumed"
      annotation (Placement(transformation(extent={{100,-30},{120,-10}}), iconTransformation(extent={{100,-54},{128,-26}})));


  equation
    V_eva = (m_a*abs(w_in - w_ou))/rhoW;
    m_drift = V_eva*f_drift;
    m_blo = (V_eva/(rCon - 1)) - m_drift;
    V_tot = V_eva + m_drift + m_blo;



    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      defaultComponentName="watCon",
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end WaterConsumption;

  block HeatTransfer

    //parameters
    parameter Modelica.SIunits.Area A "Area of the cooling pad";

    Modelica.Blocks.Interfaces.RealInput hc "Heat transfer coefficient"
     annotation (Placement(transformation(extent={{-140,80},{-100,120}}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-50,-140})));
    Modelica.Blocks.Interfaces.RealInput hm "mass transfer coefficient"
      annotation (Placement(transformation(extent={{-148,2},{-100,50}}), iconTransformation(extent={{-140,10},{-100,50}})));
    Modelica.Blocks.Interfaces.RealInput Tdb_in "Inlet drybulb temperature"
     annotation (Placement(transformation(extent={{-140,40},{-100,80}}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-50,140})));
    Modelica.Blocks.Interfaces.RealInput Tdb_ou "Outlet drybulb temperature"
      annotation (Placement(transformation(extent={{-148,-58},{-100,-10}}), iconTransformation(extent={{-140,-50},{-100,-10}})));
    Modelica.Blocks.Interfaces.RealInput w_in "Inlet humidity ratio"
      annotation (Placement(transformation(extent={{-140,0},{-100,40}}), iconTransformation(extent={{-140,70},{-100,110}})));
    Modelica.Blocks.Interfaces.RealInput w_ou "Outlet humidity ratio"
      annotation (Placement(transformation(extent={{-148,-118},{-100,-70}}), iconTransformation(extent={{-140,-110},{-100,-70}})));
    Modelica.Blocks.Interfaces.RealOutput Q_total "Total heat transfer"
      annotation (Placement(transformation(extent={{120,-14},{148,14}}), iconTransformation(extent={{120,-14},{148,14}})));
    Modelica.Blocks.Interfaces.RealOutput Q_latent "Latent heat transfer"
      annotation (Placement(transformation(extent={{120,-74},{148,-46}}), iconTransformation(extent={{120,-74},{148,-46}})));

    Modelica.Blocks.Interfaces.RealOutput Q_sensible "sensible heat transfer"
      annotation (Placement(transformation(extent={{120,46},{146,72}}), iconTransformation(extent={{120,46},{146,72}})));



  equation
    Q_sensible = hc*A*(Tdb_ou - Tdb_in);
    Q_latent = Buildings.Utilities.Psychrometrics.Constants.h_fg*hm*A*(w_ou - w_in);
    Q_total = Q_sensible + Q_latent;

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{120,120}})),
      defaultComponentName="heaTra",
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{120,120}})));
  end HeatTransfer;

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

  type CooPad = enumeration(
      Lumped
           "Lumped model(EnergyPlus)",
      PhysicsBased
            "Physics-based")
    "Specifies the type of cooling pad based on the level of details : 1. Lumped  2.Physics-based";
  type CooPadMaterial = enumeration(
      Cellulose
              "Rigid cellulose, m2/m3 = 440",
      GlassFiber
               "Glass fiber, m2/m3 = 520",
      Paper
          "Paper, m2/m3 = 380",
      Coir
         "Coconut coir,m2/m3 = 209",
      Aspen
          "Aspen,m2/m3 = 299")
    "Various types of cooling pad materials/media such as Cellulose, Glass fiber, Paper, Coir, Aspen";
end BaseClasses;

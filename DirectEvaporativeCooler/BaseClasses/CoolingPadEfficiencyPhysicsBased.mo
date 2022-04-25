within DirectEvaporativeCooler.BaseClasses;
block CoolingPadEfficiencyPhysicsBased

  //Parameters
  parameter Modelica.SIunits.ThermalConductivity k = 0.045 "Thermal conductivity of the pad media";
  parameter Modelica.SIunits.Thickness d "Thickness of the cooling pad,m";
  parameter Modelica.SIunits.Length l  "Length of the cooling pad,m";
  parameter Modelica.SIunits.Height h  "Height of the cooling pad,m";
  parameter Real xi  "ξ, specific contact area or wetted surface area of the cooling pad, m2/m3";

  // Cooling pad media
  parameter DirectEvaporativeCooler.BaseClasses.CooPadMaterial CooPadMaterial = DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Celdek
  "Various types of cooling pad materials/media such as Cellulose, Glass fiber, Paper, Coir, Aspen";

  //Constant and variables
  Modelica.SIunits.Pressure p_atm = 101325 " Atmospheric pressure, pa ";
  Modelica.SIunits.Area A = l * h " Area of the cooling pad, m2";
  Modelica.SIunits.Volume V = A * d "Volume of the cooling pad,m3";
  Modelica.SIunits.Area TSA = 2*(l*h + h*d + d*l) "Total surface area of the cooling pad,m2";
  Modelica.SIunits.SpecificHeatCapacity Cpa = 1000 " Specific heat of air J/kg K";
  Modelica.SIunits.Density rho " Air density, kg/m3";
  Modelica.SIunits.Length le = (V/ TSA) "Characteristic length ,m";
  Modelica.SIunits.ThermalConductivity ka = 0.027223 "Thermal conductivity of air, W/mK";
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
          extent={{-140,-60},{-100,-20}}),
                                        iconTransformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput Tdb_in
    "Inlet Drybulb temperature of air,C"
     annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}}),
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
          extent={{100,-50},{120,-30}}),
                                      iconTransformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealInput v_a
    "Velocity of air passing through the cooling pad , m/s"
     annotation (Placement(
        transformation(extent={{-140,20},{-100,60}}),iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=0,
        origin={-120,-40})));

equation
//Step 1: Calculating Re and Pr to calculate Nusselts number

rho = p_atm/(287.08*(Twb_in))    " Density of air at the wetbulb temperature";
Re = (rho* v_a * d)/ Mu "Renyolds number";

//Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(v_a, rho, Mu, d)
//Modelica.Fluid.Dissipation.Utilities.Functions.General.PrandtlNumber(Cpa,Mu,ka)

Pr = (Cpa * Mu)/ka "Prandtl number";

// Step 2: Nusselts number varies for different cooling pad media
Nu = if CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Celdek then (0.10*((le/d)^(0.12))*(Re^0.8)*(Pr^0.33))
  elseif CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Glasdek then (0.07*((le/d)^(0.12))*(Re^0.8)*(Pr^0.33))
  elseif CooPadMaterial == DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Coir then 0.53*((le/d)^(0.46))*(Re^0.9) * (Pr^0.33)
  else (0.25*((le/d)^(0.12))*(Re^0.8) * (Pr^0.33));

// Step 3: Calculating hc and hm based on Nusselts number
hc = (Nu*ka)/le    "Lewis relationship between convective heat transfer coefficient and mass transfer coefficient (Le ~ 1 for water vapour and air)";
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
Tdp =  (237.3*B)/(1-B) "Dew point temperature of the outlet air";
p_wat =  (6.11* 10^((7.5*Tdp)/(237.3+Tdp)))*100 "Partial pressure of water vapour of the outlet air";
w_ou=  Buildings.Utilities.Psychrometrics.Functions.X_pW(p_wat);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),defaultComponentName="effPhy", Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CoolingPadEfficiencyPhysicsBased;

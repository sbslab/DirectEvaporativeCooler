within DirectEvaporativeCooler.BaseClasses;
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

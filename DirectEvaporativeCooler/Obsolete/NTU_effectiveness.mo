within DirectEvaporativeCooler.Obsolete;
block NTU_effectiveness "Calculating the NTU and Effectiveness for the DEC model"
  Modelica.Blocks.Interfaces.RealInput m2_flow "Mass flow rate of air"
    annotation (Placement(transformation(extent={{-116,50},{-76,90}}),
        iconTransformation(extent={{-130,44},{-100,74}})));
  Modelica.Blocks.Interfaces.RealInput T_wb1
    "inlet wet bulb temperature of air" annotation (Placement(transformation(
          extent={{-116,50},{-76,90}}), iconTransformation(extent={{-130,10},
            {-100,40}})));
  Modelica.Blocks.Interfaces.RealInput T_db1
    "Inlet Drybulb temperature of air"
    annotation (Placement(transformation(extent={{-116,50},{-76,90}}),
        iconTransformation(extent={{-130,-24},{-100,6}})));
  Modelica.Blocks.Interfaces.RealInput Tw1 "Water inlet temperature"
    annotation (Placement(transformation(extent={{-116,50},{-76,90}}),
        iconTransformation(extent={{-130,-60},{-100,-30}})));
  Modelica.Blocks.Interfaces.RealOutput T_db2 "Outlet drybulb temperature"
    annotation (Placement(transformation(extent={{100,46},{120,66}}),
        iconTransformation(extent={{100,46},{120,66}})));
  Modelica.Blocks.Interfaces.RealOutput Tw2 "Outlet water temperature"
    annotation (Placement(transformation(extent={{92,46},{112,66}}),
        iconTransformation(extent={{100,18},{120,38}})));
  Modelica.Blocks.Interfaces.RealOutput X_w2 "Outlet humidity ratio"
    annotation (Placement(transformation(extent={{92,46},{112,66}}),
        iconTransformation(extent={{100,-8},{120,12}})));

  Real gama "constant depending on pad material and pad configu- ration like ξ";
  Real Nu " Nusselt number";
  Real Re " Reynolds number";
  Real Pr
         " Prandtl number";
  Real Mu " Dynamic viscosity";
  Real Cpa  " Specific heat of air";
  parameter Real p_atm " Atmospheric pressure";
  parameter Real k "Thermal conductivity";
  parameter Real v_a "air velocity";
  Real rho " air density";
  parameter Real Thickness "thickness of the cooling pad";
  parameter Real Area_s " area of the cooling pad";
  Real l
        "Characteristic length";
  Real NTU " Net transfer unit";
  parameter Real V "volume flow rate";
  Real phi " Intermediate variable - relative humidity";
  Real Mr " mass transfer coefficient";
  Real alfa, beta;
  Real T_wb2, TDew, p_wat,ed,ew,e,B,RH;

  Modelica.Blocks.Interfaces.RealOutput hm "mass transfer coefficient "
    annotation (Placement(transformation(extent={{92,46},{112,66}}),
        iconTransformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealOutput hc
    "convective heat transfer coefficient" annotation (Placement(transformation(
          extent={{92,46},{112,66}}), iconTransformation(extent={{100,-66},
            {120,-46}})));
algorithm

  // calculating Nusselts number to compute hc, as Nu gives a relationship between conductive and convective heat transfer
l:= (Area_s / Thickness);
 gama := 0.1 * l^0.12;
 rho := p_atm/287.08 * T_wb1;
 Re := Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(v_a, rho, Mu, l);
 Pr := Modelica.Fluid.Dissipation.Utilities.Functions.General.PrandtlNumber(Cpa, Mu, k);
 Nu:= gama * Re^0.8 * Pr^0.33;

 hc := Nu * k;
 //Lewis relationship between convective heat transfer coefficient and mass transfer coefficient (Le ~ 1 for water vapour and air)
 hm := hc/Cpa;
 //Net transfer unit calculation
 NTU := (hc * Area_s)/(m2_flow * Cpa);
 // calculating the efficiency of the cooling pad
 // calculated using alfa, beta and Mr

 alfa := (Tw1 - T_wb1)/(T_db1 - T_wb1);
 beta := 0.44 * (alfa ^ 0.932)* (NTU^0.089)* (Mr^(-0.116));
 Tw2 := Tw1 - beta*(T_db1-T_wb1);
 Mr := (m2_flow/V);
 phi := 1- exp(-1.07*(NTU^0.295))* alfa ^(-0.556) * Mr^(-0.051);
 //η= ϕη_1
 //η_1=1-exp⁡[-1.037 NTU]
 //η=(T_db1- T_db2)/(T_db1- T_wb1)

 T_db2 := T_db1 - ((T_db1 - T_wb1)*phi*(1-exp((-1.037)*NTU)));
 // Humidity ratio for the outlet condition
 //assuming WBT in = WBT out ;

 T_wb2:= T_wb1;

 //computing RH(phi) using Tdb_out, Twb_out and atmospheric pressure

ed := 6.108 * exp((17.27*T_db2)/(237.3+T_db2))     "Saturation Vapor Pressure at Dry Bulb (mb)";
ew := 6.108 * exp((17.27*T_wb2)/(237.3+T_wb2))     "Saturation Vapor Pressure at wet bulb Bulb (mb)";
e := ew - (0.00066 * (1+0.00115*T_wb2)*(T_db2-T_wb2)*(p_atm/100));
RH := 100*(e/ed);
B := log(e/6.108)/17.27;
TDew := (237.3*B)/(1-B);
p_wat := (6.11* 10^((7.5*TDew)/(237.3+TDew)))*100;
X_w2 := Buildings.Utilities.Psychrometrics.Functions.X_pW(p_wat);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end NTU_effectiveness;

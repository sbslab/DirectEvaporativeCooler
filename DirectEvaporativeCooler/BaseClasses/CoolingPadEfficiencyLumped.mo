within DirectEvaporativeCooler.BaseClasses;
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

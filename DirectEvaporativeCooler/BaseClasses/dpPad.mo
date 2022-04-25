within DirectEvaporativeCooler.BaseClasses;
model dpPad "Cooling pad pressure drop"
 extends Buildings.Fluid.BaseClasses.PartialResistance(
    final m_flow_turbulent = if computeFlowResistance then deltaM * m_flow_nominal_pos else 0);

 parameter Real deltaM(min=1E-6) = 0.3
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
       annotation(Evaluate=true,
                  Dialog(group = "Transition to laminar",
                         enable = not linearized));
 final parameter Real k = if computeFlowResistance then
        m_flow_nominal_pos / sqrt(dp_nominal_pos) else 0
    "Flow coefficient, k=m_flow/sqrt(dp), with unit=(kg.m)^(1/2)";

  Modelica.SIunits.Velocity v_a "Nominal velocity of the air (m/s) at nominal flow rate";
  Modelica.SIunits.PressureDifference dp_pad_cal( displayUnit="Pa") "Velocity of the air (m/s)";

  parameter Modelica.SIunits.Thickness Thickness "Evaporative cooling pad thickness(m)" annotation (Dialog(group="Evaporative cooler pad"));

  parameter Modelica.SIunits.Length Length "Evaporative cooling pad length(m)" annotation (Dialog(group="Evaporative cooler pad"));

  parameter Modelica.SIunits.Height Height "Evaporative cooling pad Height(m)" annotation (Dialog(group="Evaporative cooler pad"));

  parameter Modelica.SIunits.Area PadArea=Length*Height "Evaporative cooling pad area(m2)" annotation (Dialog(group="Evaporative cooler pad"));
  parameter Modelica.SIunits.MassFlowRate mW_flow_nominal
    "Nominal mass flow rate on the water side";
  parameter Modelica.SIunits.Area Contact_surface_area "Evaporative cooling pad area(m2)" annotation (Dialog(group="Evaporative cooler pad"));



 Modelica.SIunits.Density rho = Medium.density(
       state=Medium.setState_phX(
         p=port_a.p,
         h=inStream(port_a.h_outflow),
         X=inStream(port_a.Xi_outflow)));

protected
  final parameter Boolean computeFlowResistance=(dp_nominal_pos > Modelica.Constants.eps)
    "Flag to enable/disable computation of flow resistance"
   annotation(Evaluate=true);
  final parameter Real coeff=
    if linearized and computeFlowResistance
    then if from_dp then k^2/m_flow_nominal_pos else m_flow_nominal_pos/k^2
    else 0
    "Precomputed coefficient to avoid division by parameter";
initial equation
 if computeFlowResistance then
   assert(m_flow_turbulent > 0, "m_flow_turbulent must be bigger than zero.");
 end if;

 assert(m_flow_nominal_pos > 0, "m_flow_nominal_pos must be non-zero. Check parameters.");
equation
  // Pressure drop calculation


 v_a = (port_a.m_flow/rho)/PadArea;
 dp_pad_cal = 0.768*(((1/Contact_surface_area)/Thickness)^(-0.469))*(1 + (mW_flow_nominal^1.139))*(v_a^2);

  // Pressure drop calculation
  if computeFlowResistance then
    if linearized then
      if from_dp then
        m_flow = dp*coeff;
      else
        dp = m_flow*coeff;
      end if;


    else
      if homotopyInitialization then
        if from_dp then
          m_flow=homotopy(
            actual=Buildings.Fluid.BaseClasses.FlowModels.basicFlowFunction_dp(
              dp=dp_pad_cal,
              k=k,
              m_flow_turbulent=m_flow_turbulent),
            simplified=m_flow_nominal_pos*dp/dp_nominal_pos);
        else
          dp=homotopy(
            actual=dp_pad_cal,
            simplified=dp_nominal_pos*m_flow/m_flow_nominal_pos);
         end if;  // from_dp
      else // do not use homotopy
        if from_dp then
          m_flow=Buildings.Fluid.BaseClasses.FlowModels.basicFlowFunction_dp(
            dp=dp_pad_cal,
            k=k,
            m_flow_turbulent=m_flow_turbulent);
        else
          dp=dp_pad_cal;
        end if;  // from_dp
      end if; // homotopyInitialization
    end if; // linearized
  else // do not compute flow resistance
    dp = 0;
  end if;  // computeFlowResistance



  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end dpPad;

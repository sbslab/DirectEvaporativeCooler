within DirectEvaporativeCooler;
package Records
  extends Modelica.Icons.MaterialPropertiesPackage;

  model BreezairIcon210FanCurve
    "Performance data of Breezair Icon 210 evaporative cooler - Direct Evaporative cooler"
    extends Buildings.Fluid.Movers.Data.Generic(
      use_powerCharacteristic=true,
      speed_rpm_nominal=1450,
      power(V_flow={0.35100689,0.446053887,0.586123145,0.746202297,0.876266608,1.031343286,1.156405124,1.306479329,1.43654364,1.53659311,1.626637633,1.696672261,1.791719258,1.841743993,1.926786042,1.996820671,2.0668553,2.126884982}, P={89.01734104,89.01734104,93.6416185,126.0115607,153.7572254,190.7514451,246.2427746,310.982659,384.9710983,458.9595376,528.3236994,602.3121387,708.6705202,778.0346821,879.7687861,1009.248555,1110.982659,1212.716763}),
      pressure(V_flow={2.28,2.31,2.34,2.37,2.4,2.44,2.47,2.49,2.51,2.54,2.56,2.59,2.62,2.65,2.69,2.71,2.74,2.77,2.79,2.81,2.84,2.87,2.9,2.93}, dp={215.5,206.5,198.8,191.5,182.9,174.82,167.5,160.16,152.41,143.44,132.42,123.04,112.44,102.67,92.89,82.69,73.32,65.17,55.37,45.18,34.58,24.79,12.96,3.59}));
    annotation (
  defaultComponentPrefixes="parameter",
  defaultComponentName="Breezair_Icon_fan");

  end BreezairIcon210FanCurve;

  model BreezairIcon210PumpCurve
    extends Buildings.Fluid.Movers.Data.Generic(
      use_powerCharacteristic=true,
     power(V_flow={0.00028}, P={30}),pressure(V_flow={0,0.00029}, dp={0,12745.3}));
                                                                                     annotation (
  defaultComponentPrefixes="parameter",
  defaultComponentName="Breezair_Icon_pump");

  end BreezairIcon210PumpCurve;

  record EvaporativePadMedia
    "List of available meadia options in the DEC model"

    parameter Real CelDek_Cellulose "Cooling pad made of Cellulose";
    parameter Real GlasDek_Glassfiber "Cooling pad made of glass fiber";
    parameter Real Aspen "Cooling pad made of Aspen fibers";
    parameter Real Paper "Cooling pad made of paper sheets";
    parameter Real CoconutCoir "Cooling pad made of coconut coir";

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end EvaporativePadMedia;
end Records;

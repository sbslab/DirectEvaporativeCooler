within DirectEvaporativeCooler.Records;
record BreezairIcon170PumpCurve
  extends Buildings.Fluid.Movers.Data.Generic(
    use_powerCharacteristic=true,
   power(V_flow={0.000383}, P={30}),pressure(V_flow={0,0.000383,0.000766}, dp={200,100,0}));
                                                                                   annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="Breezair_Icon_pump");

end BreezairIcon170PumpCurve;

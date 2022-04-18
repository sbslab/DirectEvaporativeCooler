within DirectEvaporativeCooler.Records;
record HCT_45_2T
  extends Buildings.Fluid.Movers.Data.Generic(
    use_powerCharacteristic=false,
       pressure(V_flow={0.53320132,0.757623762,1.013861386,1.270847085,1.511507151,1.800792079,2.073619362,2.289944994,
          2.457425743,2.568888889,2.720264026,2.862354235}, dp={571.5924092,521.9224422,459.8580858,413.9614961,365.2271727,
          317.3976898,263.8773377,214.2150715,158.8927393,117.889989,64.48514851,1}),
        hydraulicEfficiency(V_flow={2.273055556}, eta={0.72}),
        motorEfficiency(V_flow={2.273055556}, eta={0.72}),
        speed_rpm_nominal=2865);

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="Breezair_Icon_fan");

end HCT_45_2T;

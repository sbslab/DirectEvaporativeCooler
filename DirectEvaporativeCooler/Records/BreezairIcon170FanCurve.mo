within DirectEvaporativeCooler.Records;
record BreezairIcon170FanCurve
  "Performance data of Breezair Icon 210 evaporative cooler - Direct Evaporative cooler"
  extends Buildings.Fluid.Movers.Data.Generic(
    use_powerCharacteristic=true,
    speed_rpm_nominal=530,
    power(V_flow={0.350919689,0.457351137,0.561653956,0.65744226,0.783031368,0.955450314,1.123612002,
            1.296030948,1.442906347,1.557852311,1.696213193,1.789872868,1.906947461,2.01125028,2.068723262,
            2.121938986}, P={86.85211167,97.09530491,91.55178023,103.729234,133.76492,175.80268,229.6595091,
            311.1450009,382.6770573,477.7633746,606.4641412,717.2532992,863.629293,1007.987149,1120.619065,
            1209.567092}),
    pressure(V_flow={1.965208961,2.005253355,2.047117949,2.094443141,2.133577435,2.160880431,2.211846023,
            2.272822714,2.314687307,2.375663998,2.416618491,2.467584083,2.515819376,2.55040317}, dp={164,
            156,147,137,129,118,111,96,84,69,52,37,23,12}),
            speeds_rpm={530,440,350,260,170});



  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="Breezair_Icon_fan");

end BreezairIcon170FanCurve;

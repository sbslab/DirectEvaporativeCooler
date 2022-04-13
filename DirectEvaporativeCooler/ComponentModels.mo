within DirectEvaporativeCooler;
package ComponentModels
  "Package with component models of direct evaporative cooling pad"
  extends Modelica.Icons.VariantsPackage;
  model Lumped "Model for the lumped evaporative cooling pad based on the EnergyPlus Cel-Dek pad"

    extends DirectEvaporativeCooler.BaseClasses.PartialCoolingPad(dpPad(dp_nominal=dp_pad_nominal));


    BaseClasses.OutletConditions outCon annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
    BaseClasses.CoolingPadEfficiencyLumped effPhy(d=Thickness)
                                                  annotation (Placement(transformation(extent={{-76,-30},{-56,-10}})));
    BaseClasses.WaterConsumption watCon(f_drift=DriftFactor, rCon=Rcon)
                                        annotation (Placement(transformation(extent={{14,2},{34,22}})));


  equation
    connect(effPhy.pad_eff, outCon.eff) annotation (Line(
        points={{-54.6,-20},{-52,-20},{-52,-8},{-34,-8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senWetBul.T, outCon.Twb_in) annotation (Line(
        points={{-60,53.4},{-60,3},{-34,3}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senTem.T, outCon.Tdb_in) annotation (Line(
        points={{-40,53.4},{-40,8},{-34,8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senMasFlo.m_flow, outCon.m_a)
      annotation (Line(
        points={{-20,53.4},{-20,20},{-46,20},{-46,-3},{-34,-3}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(outCon.w_ou, watCon.w_ou) annotation (Line(
        points={{-10.6,2},{0,2},{0,6},{12,6}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(outCon.qS, Qs.Q_flow)
      annotation (Line(
        points={{-10.6,-2},{-2,-2},{-2,-16},{60,-16},{60,-86},{32,-86}},
        color={238,46,47},
        pattern=LinePattern.Dash));
    connect(watCon.V_tot, gain.u) annotation (Line(
        points={{35.4,8},{40,8},{40,-32},{33.2,-32}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(watCon.V_eva, volAir.mWat_flow) annotation (Line(
        points={{35.4,16},{40,16},{40,42},{58,42}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senMasFra.X, watCon.w_in) annotation (Line(points={{0,53.4},{0,18},{12,18}}, color={0,0,127}));
    connect(senMasFlo.m_flow, watCon.m_a) annotation (Line(points={{-20,53.4},{-20,12},{12,12}}, color={0,0,127}));
    connect(senVel.v, effPhy.v_a) annotation (Line(points={{-80,53.4},{-80,-20},{-78,-20}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)),defaultComponentName="cooPad", Diagram(coordinateSystem(preserveAspectRatio=false)));
  end Lumped;

  model PhysicsBased "Model for the Physics-based evaporative cooling pad"

    extends DirectEvaporativeCooler.BaseClasses.PartialCoolingPad(dpPad(dp=dp_pad_cal, dp_nominal=dp_pad_nominal));

    BaseClasses.WaterConsumption WatCon(final f_drift=DriftFactor, final rCon=Rcon) annotation (Placement(transformation(extent={{20,-20},{40,0}})));
    Modelica.SIunits.Velocity v_a "Velocity of the air (m/s)";
    Modelica.SIunits.Pressure dp_pad_cal "Velocity of the air (m/s)";


    BaseClasses.CoolingPadEfficiencyPhysicsBased Eff_Phy(
      final d=Thickness,
      final l=Length,
      final h=Height,
      final xi=Contact_surface_area,
      final CooPadMaterial=CooPadMaterial,
      final p_atm=p_atm,
      final k=K_value)                annotation (Placement(transformation(extent={{-44,0},{-24,20}})));
    BaseClasses.HeatTransfer HeaTraPhy                 annotation (Placement(transformation(extent={{20,20},{40,40}})));
  equation

    // pressure drop module
    v_a = (m1_flow/rho2_nominal)/PadArea;
    dp_pad_cal = 0.768*((0.0288)^(-0.469))*(1 + (m2_flow_nominal^1.139))*(v_a^2);



    connect(volWat.heatPort, Qs.port) annotation (Line(points={{-60,-70},{-60,-86},{20,-86}}, color={191,0,0}));
    connect(HeaTraPhy.Q_sensible, Qs.Q_flow)
      annotation (Line(
        points={{41.1818,34.9167},{60,34.9167},{60,-86},{32,-86}},
        color={238,46,47},
        pattern=LinePattern.Dash));
    connect(senTem.T, HeaTraPhy.Tdb_in)
      annotation (Line(
        points={{-40,53.4},{-40,46},{24.5455,46},{24.5455,41.6667}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senMasFra.X, HeaTraPhy.w_in) annotation (Line(
        points={{0,53.4},{0,38},{18.1818,38},{18.1818,37.5}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(Eff_Phy.hm, HeaTraPhy.hm) annotation (Line(
        points={{-23,16},{-12,16},{-12,32.5},{18.1818,32.5}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(Eff_Phy.Tdb_ou, HeaTraPhy.Tdb_ou)
      annotation (Line(
        points={{-23,12},{-4,12},{-4,27.5},{18.1818,27.5}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(Eff_Phy.w_ou, HeaTraPhy.w_ou) annotation (Line(
        points={{-23,8},{0,8},{0,22.5},{18.1818,22.5}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(Eff_Phy.hc, HeaTraPhy.hc)
      annotation (Line(
        points={{-23,4},{6,4},{6,16},{24.5455,16},{24.5455,18.3333}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senTem.T, Eff_Phy.Tdb_in) annotation (Line(
        points={{-40,53.4},{-40,22}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senWetBul.T, Eff_Phy.Twb_in) annotation (Line(
        points={{-60,53.4},{-60,14},{-46,14}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senVel.v, Eff_Phy.v_a) annotation (Line(
        points={{-80,53.4},{-80,6},{-46,6}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(WatCon.V_tot, gain.u) annotation (Line(
        points={{41.4,-14},{52,-14},{52,-32},{33.2,-32}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senMasFra.X, WatCon.w_in) annotation (Line(
        points={{0,53.4},{0,-4},{18,-4}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senMasFlo.m_flow, WatCon.m_a) annotation (Line(
        points={{-20,53.4},{-20,-10},{18,-10}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(Eff_Phy.w_ou, WatCon.w_ou) annotation (Line(
        points={{-23,8},{-22,8},{-22,-16},{18,-16}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(WatCon.V_eva, volAir.mWat_flow) annotation (Line(points={{41.4,-6},{52,-6},{52,42},{58,42}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)),defaultComponentName="cooPad", Diagram(coordinateSystem(preserveAspectRatio=false)));
  end PhysicsBased;
end ComponentModels;

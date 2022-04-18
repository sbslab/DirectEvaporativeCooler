within DirectEvaporativeCooler.ComponentModels;
model Lumped "Model for the lumped evaporative cooling pad based on the EnergyPlus Cel-Dek pad"

  extends DirectEvaporativeCooler.BaseClasses.PartialCoolingPad(dpPad(dp_nominal=dp_pad_nominal),
      senMasFra(initType=Modelica.Blocks.Types.Init.InitialState));

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
  connect(senMasFra.X, watCon.w_in) annotation (Line(points={{0,53.4},{0,18},{12,18}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senMasFlo.m_flow, watCon.m_a) annotation (Line(points={{-20,53.4},{-20,12},{12,12}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senVel.v, effPhy.v_a) annotation (Line(points={{-80,53.4},{-80,-20},{-78,-20}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(watCon.m_eva, volAir.mWat_flow)
    annotation (Line(points={{35.4,16},{52,16},{52,42},{58,42}}, color={0,0,127}));
  connect(watCon.m_tot, gain.u) annotation (Line(points={{35.4,8},{40,8},{40,-32},{33.2,-32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),defaultComponentName="cooPad", Diagram(coordinateSystem(preserveAspectRatio=false)));
end Lumped;

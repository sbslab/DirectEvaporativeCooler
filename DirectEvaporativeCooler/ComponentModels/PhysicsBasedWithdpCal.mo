within DirectEvaporativeCooler.ComponentModels;
model PhysicsBasedWithdpCal
  "Model for the Physics-based evaporative cooling pad with pressure drop calculations"

  extends DirectEvaporativeCooler.BaseClasses.PartialCoolingPad(redeclare BaseClasses.dpPad dpPad(
                                                                      dp_nominal=dp_pad_nominal,
      Thickness=Thickness,
      Length=Length,
      Height=Height,
      mW_flow_nominal=m2_flow_nominal,
      Contact_surface_area=Contact_surface_area, rho = Eff_Phy.rho));

  BaseClasses.WaterConsumption WatCon(final f_drift=DriftFactor, final rCon=Rcon)
    "Function module to calculate the water consumption"                          annotation (Placement(transformation(extent={{20,-20},
            {40,0}})));

 Modelica.SIunits.Velocity v_a "Nominal velocity of the air (m/s) at nominal flow rate";
 Modelica.SIunits.PressureDifference dp_pad_cal(displayUnit="Pa") "Velocity of the air (m/s)";

  BaseClasses.CoolingPadEfficiencyPhysicsBased Eff_Phy(
    final d=Thickness,
    final l=Length,
    final h=Height,
    final xi=Contact_surface_area,
    final CooPadMaterial=CooPadMaterial,
    final p_atm=p_atm,
    final k=K_value)                annotation (Placement(transformation(extent={{-44,0},{-24,20}})));
  BaseClasses.HeatTransfer HeaTraPhy(A=PadArea) "Function module to calculate the heat transfer"
                                                     annotation (Placement(transformation(extent={{20,20},{40,40}})));
equation
//dp=dp_pad_cal
  // pressure drop module
  v_a = (m1_flow/Eff_Phy.rho)/PadArea;
  dp_pad_cal = 0.768*(((1/Contact_surface_area)/Thickness)^(-0.469))*(1 + (m2_flow_nominal^1.139))*(senVel.v^2);

   // v_a_nominal = (m1_flow_nominal*1.225)/PadArea;
   // dp_pad_cal = 5.5*(((1/Contact_surface_area)/Thickness)^(-0.469))*(1 + (m2_flow_nominal^1.139))*(v_a_nominal^2);

  connect(senTem.T, HeaTraPhy.Tdb_in)
    annotation (Line(
      points={{-40,53.4},{-40,46},{24.5455,46},{24.5455,41.6667}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senMasFra.X, HeaTraPhy.w_in) annotation (Line(
      points={{0,53.4},{0,38},{18.1818,38},{18.1818,37.5}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Eff_Phy.Tdb_ou, HeaTraPhy.Tdb_ou)
    annotation (Line(
      points={{-23,12},{-4,12},{-4,26.6667},{18.1818,26.6667}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Eff_Phy.w_ou, HeaTraPhy.w_ou) annotation (Line(
      points={{-23,8},{0,8},{0,22},{18.1818,22}},
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

  connect(WatCon.m_tot, gain.u)
    annotation (Line(points={{41.4,-14},{48,-14},{48,-32},{33.2,-32}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(WatCon.m_eva, volAir.mWat_flow)
    annotation (Line(points={{41.4,-6},{48,-6},{48,42},{58,42}},         color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senMasFlo.m_flow, HeaTraPhy.ma) annotation (Line(
      points={{-20,53.4},{-20,32},{18.1818,32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),defaultComponentName="cooPad", Diagram(coordinateSystem(preserveAspectRatio=false)));
end PhysicsBasedWithdpCal;

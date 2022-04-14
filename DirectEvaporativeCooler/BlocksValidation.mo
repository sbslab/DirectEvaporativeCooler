within DirectEvaporativeCooler;
package BlocksValidation
  model CoolingPadEfficiencyLumped
    BaseClasses.CoolingPadEfficiencyLumped effLum(d=0.1)
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Blocks.Sources.Constant v_a(k=0.201451) "Velocity"
      annotation (Placement(transformation(extent={{-52,4},{-40,16}})));

  equation
    connect(v_a.y, effLum.v_a) annotation (Line(points={{-39.4,10},{-22,10}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end CoolingPadEfficiencyLumped;

  model CoolingPadEfficiencyPhysicsBased
    BaseClasses.CoolingPadEfficiencyPhysicsBased effPhy(
      d=0.1,
      l=2.034,
      h=1,
      xi=440,
      CooPadMaterial=DirectEvaporativeCooler.BaseClasses.CooPadMaterial.Cellulose)
      annotation (Placement(transformation(extent={{-20,-6},{0,14}})));
    Modelica.Blocks.Sources.Constant v_a(k=0.201451) "Velocity"
      annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    Modelica.Blocks.Sources.Constant Twb(k=291.48) "WetBulb"
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Sources.Constant Tdb(k=305.37) "WetBulb"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  equation
    connect(v_a.y, effPhy.v_a)
      annotation (Line(points={{-39,-10},{-28,-10},{-28,0},{-22,0}}, color={0,0,127}));
    connect(Twb.y, effPhy.Twb_in)
      annotation (Line(points={{-39,30},{-28,30},{-28,8},{-22,8}}, color={0,0,127}));
    connect(Tdb.y, effPhy.Tdb_in)
      annotation (Line(points={{-39,70},{-16,70},{-16,16}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end CoolingPadEfficiencyPhysicsBased;

  model OutletConditions
    BaseClasses.OutletConditions outCon annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Blocks.Sources.Constant Tdb(k=305.37) "WetBulb"
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Modelica.Blocks.Sources.Constant Twb(k=291.48) "WetBulb"
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Blocks.Sources.Constant m_a(k=0.49616) "mass flow rate of air"
      annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
    Modelica.Blocks.Sources.Constant eff(k=0.94) "efficiency"
      annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  equation
    connect(Tdb.y, outCon.Tdb_in)
      annotation (Line(points={{-39,40},{-28,40},{-28,18},{-22,18}}, color={0,0,127}));
    connect(Twb.y, outCon.Twb_in)
      annotation (Line(points={{-39,10},{-28,10},{-28,13},{-22,13}}, color={0,0,127}));
    connect(m_a.y, outCon.m_a)
      annotation (Line(points={{-39,-30},{-30,-30},{-30,7},{-22,7}}, color={0,0,127}));
    connect(eff.y, outCon.eff)
      annotation (Line(points={{-39,-70},{-22,-70},{-22,2}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end OutletConditions;

  model WaterConsumption
    BaseClasses.WaterConsumption watCon(rCon=3)
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Blocks.Sources.Constant w_in(k=0.08) "Inlet humidity ratio"
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Sources.Constant m_a(k=0.5) "mass flow rate of air"
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Blocks.Sources.Constant w_ou(k=0.09) "outlet humidity ratio"
      annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  equation
    connect(w_in.y, watCon.w_in)
      annotation (Line(points={{-39,30},{-28,30},{-28,16},{-22,16}}, color={0,0,127}));
    connect(m_a.y, watCon.m_a)
      annotation (Line(points={{-39,0},{-28,0},{-28,10},{-22,10}}, color={0,0,127}));
    connect(w_ou.y, watCon.w_ou)
      annotation (Line(points={{-39,-30},{-24,-30},{-24,2},{-22,2},{-22,4}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end WaterConsumption;

  model HeatTransfer
    BaseClasses.HeatTransfer heaTra annotation (Placement(transformation(extent={{-22,-4},{0,20}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end HeatTransfer;
end BlocksValidation;

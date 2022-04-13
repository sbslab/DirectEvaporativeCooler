within DirectEvaporativeCooler.Obsolete;
block EffCheck "Model to calculate efficiency from outlet conditions"
  Modelica.Blocks.Interfaces.RealInput db_in annotation (Placement(transformation(extent={{-140,64},
            {-100,104}}),
        iconTransformation(extent={{-140,64},{-100,104}})));
  Modelica.Blocks.Interfaces.RealInput db_out
    annotation (Placement(transformation(extent={{-140,4},{-100,44}}),iconTransformation(extent={{-140,4},
            {-100,44}})));
  Modelica.Blocks.Interfaces.RealInput wb_in annotation (Placement(transformation(extent={{-140,
            -52},{-100,-12}}),
        iconTransformation(extent={{-140,-52},{-100,-12}})));
  Modelica.Blocks.Interfaces.RealOutput efficiency_cal
    annotation (Placement(transformation(extent={{98,20},{118,40}}), iconTransformation(extent={{100,18},
            {128,46}})));

  Modelica.Blocks.Interfaces.RealInput mFlow "in m3/s" annotation (Placement(transformation(extent={{-126,-56},{-86,-16}}),
        iconTransformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput m3_s
    annotation (Placement(transformation(extent={{92,22},{112,42}}), iconTransformation(extent={{100,-42},
            {128,-14}})));
equation

  efficiency_cal = (db_in - db_out)/(db_in - wb_in);
  m3_s = mFlow * (- 0.8163);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end EffCheck;

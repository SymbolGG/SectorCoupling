within VPPth.Connectors;

connector IORenewables "Connection for renewable generator"
  input PowerFit.Types.Power_MW PPlan(start = 0) "Planned/forecast Power";
  input PowerFit.Types.Power_MW PAct(start = 0) "Input Actual Power";
  // input PowerFit.Types.Binary on(start = 0) "Component 1=Online/0=Offline";
  input PowerFit.Types.Percent Pmax(start = 100) "Maximum Power from Parameter PMaxAbs";
  input PowerFit.Types.Mode mode(start = 0) "0=Schedule/1=Optimized/2=Maintenance";
  input PowerFit.Types.Percent Popt(start = 0) "Unit setpoint by DO limited by optimized constraints";
  output PowerFit.Types.Binary limited "limited=1 then power is reduced, else not reduced";
  output PowerFit.Types.Power_MW PRef "Effective Setpoint";
  output PowerFit.Types.Power_MW PCurtail "Curtailed Renewable Power";
  output PowerFit.Types.SpecificCost_s C "Cost";
  output PowerFit.Types.Percent cgt_Pmax "Constraint Maximum Power";
  output PowerFit.Types.Percent cgt_Pmin "Constraint Minimum Power";
  output PowerFit.Types.Power_MW dPAct "Constraint Differential Power";
  output Real cgt_PPlan "Constraint for renewable Generator";
  output PowerFit.Types.Binary online "Generator online status";
  annotation(
    defaultComponentName = "IO",
    Documentation(info = "<html>
  <p>
  Input/Output connector for renewables.
  </p>
  </html>"),
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Polygon(fillColor = {100, 100, 100}, fillPattern = FillPattern.Solid, points = {{0, 100}, {-100, 0}, {0, -100}, {100, 0}, {0, 100}}), Polygon(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-60, 0}, {60, 0}, {0, -60}, {-60, 0}})}),
    Diagram(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {19, 92}, lineThickness = 2, extent = {{-47, 18}, {25, -12}}, textString = "_PRef", horizontalAlignment = TextAlignment.Left), Text(origin = {33, 62}, lineThickness = 2, extent = {{-61, 20}, {25, -12}}, textString = "_PPlan", horizontalAlignment = TextAlignment.Left), Text(origin = {37, 42}, lineThickness = 2, extent = {{-65, 12}, {25, -22}}, textString = "_mode", horizontalAlignment = TextAlignment.Left), Text(origin = {101, 71}, lineThickness = 2, extent = {{-19, 9}, {39, -19}}, textString = "MW"), Text(origin = {101, 99}, lineThickness = 2, extent = {{-19, 9}, {39, -19}}, textString = "MW"), Text(origin = {7, 118}, lineThickness = 2, extent = {{-35, 20}, {37, -10}}, textString = "_limit", horizontalAlignment = TextAlignment.Left), Text(origin = {120, 124}, lineThickness = 2, extent = {{-38, 10}, {20, -14}}, textString = "MW"), Text(origin = {-73, 42}, lineThickness = 2, extent = {{-65, 12}, {25, -22}}, textString = "mode", horizontalAlignment = TextAlignment.Left), Text(origin = {-77, 62}, lineThickness = 2, extent = {{-61, 20}, {25, -12}}, textString = "PPlan", horizontalAlignment = TextAlignment.Left), Text(origin = {-91, 92}, lineThickness = 2, extent = {{-47, 18}, {25, -12}}, textString = "PRef", horizontalAlignment = TextAlignment.Left), Text(origin = {-103, 118}, lineThickness = 2, extent = {{-35, 20}, {37, -10}}, textString = "limit", horizontalAlignment = TextAlignment.Left), Polygon(origin = {0, 0}, fillColor = {100, 100, 100}, fillPattern = FillPattern.Solid, points = {{0, 20}, {-20, 0}, {0, -20}, {20, 0}, {0, 20}}), Polygon(origin = {-10, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{0, 0}, {20, 0}, {10, -10}, {0, 0}})}));
end IORenewables;

within VPPth.Connectors;

connector IOCHPth "Connection for Combined Heat and Power generation with optional storage on heat side"
  input PowerFit.Types.Power_MW PPlan "Planned/forecast Power";
  input PowerFit.Types.Power_MW PAct "Input Actual Power ";
  input PowerFit.Types.Binary on "Component 1=Online/0=Offline";
  input PowerFit.Types.Percent Pmax(start = 100) "Maximum power from parameter PMaxAbs";
  input PowerFit.Types.Mode mode "0=Schedule/1=Optimized/2=Maintenance";
  input PowerFit.Types.Percent Popt "Unit setpoint by DO limited by optimized constraints";
  input PowerFit.Types.Percent Pbypass "bypassing electrical power";
  output PowerFit.Types.SpecificCost_s C "Cost";
  output PowerFit.Types.Percent cgt_Pmax "Constraint Maximum Generate Power";
  output PowerFit.Types.Percent cgt_Pmin "Constraint Minimum Generate Power";
  output PowerFit.Types.Percent cgt_Pmaxbypass "Constraint Maximum bypassed electrical Power";
  output PowerFit.Types.Percent cgt_Pminbypass "Constraint Minimum bypassed electrical Power";
  output PowerFit.Types.Power_MW dPAct "Constraint Differential Power";
  output PowerFit.Types.Power_MW PRef "Setpoint Generator";
  output PowerFit.Types.Power_MW HRef "Thermal Power output";
  output PowerFit.Types.Binary online "Generator online status";
  annotation(
    defaultComponentName = "IO",
    Documentation(info = "<html>
<p>
Input/Output connector for storage.
</p>
</html>"),
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Polygon(fillColor = {100, 100, 100}, fillPattern = FillPattern.Solid, points = {{0, 100}, {-100, 0}, {0, -100}, {100, 0}, {0, 100}}), Polygon(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-60, 0}, {60, 0}, {0, -60}, {-60, 0}})}),
    Diagram(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {9, 90}, lineThickness = 2, extent = {{-45, 20}, {25, -12}}, textString = "_PRef", horizontalAlignment = TextAlignment.Left), Text(origin = {21, 64}, lineThickness = 2, extent = {{-57, 16}, {25, -12}}, textString = "_PPlan", horizontalAlignment = TextAlignment.Left), Text(origin = {29, 34}, lineThickness = 2, extent = {{-65, 18}, {25, -12}}, textString = "_mode", horizontalAlignment = TextAlignment.Left), Text(origin = {93, 71}, lineThickness = 2, extent = {{-19, 9}, {39, -19}}, textString = "MW"), Text(origin = {93, 99}, lineThickness = 2, extent = {{-19, 9}, {39, -19}}, textString = "MW"), Text(origin = {1, 118}, lineThickness = 2, extent = {{-37, 20}, {37, -10}}, textString = "_WRef", horizontalAlignment = TextAlignment.Left), Text(origin = {120, 124}, lineThickness = 2, extent = {{-38, 10}, {22, -14}}, textString = "MWh"), Text(origin = {-109, 118}, lineThickness = 2, extent = {{-37, 20}, {37, -10}}, textString = "WRef", horizontalAlignment = TextAlignment.Left), Text(origin = {-89, 64}, lineThickness = 2, extent = {{-57, 16}, {25, -12}}, textString = "PPlan", horizontalAlignment = TextAlignment.Left), Text(origin = {-101, 90}, lineThickness = 2, extent = {{-45, 20}, {25, -12}}, textString = "PRef", horizontalAlignment = TextAlignment.Left), Text(origin = {-81, 34}, lineThickness = 2, extent = {{-65, 18}, {25, -12}}, textString = "mode", horizontalAlignment = TextAlignment.Left), Polygon(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-20, 0}, {20, 0}, {0, -20}, {-20, 0}}), Polygon(origin = {0, 16}, fillColor = {100, 100, 100}, fillPattern = FillPattern.Solid, points = {{0, 6}, {-20, -16}, {20, -16}, {0, 6}})}));
end IOCHPth;

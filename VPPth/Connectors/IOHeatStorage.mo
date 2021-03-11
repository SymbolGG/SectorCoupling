within VPPth.Connectors;

connector IOHeatStorage "Connection for heat pump"
  input PowerFit.Types.Percent Wstart(start = 50) "start SOC";
  // input PowerFit.Types.Power_MW PRef "reference power of storage, positive: discharge, negative: charge";
  input PowerFit.Types.Power_MW dQRefStore "storing power of storage";
  input PowerFit.Types.Power_MW dQRefGen "generating power of storage";
  input PowerFit.Types.Mode mode(start = 1) "0=Schedule/1=Optimized/2=Maintenance";
  output PowerFit.Types.Percent Wref "SOC in percentage";
  output PowerFit.Types.Percent Wref_next "SOC in percentage at next time step";
  output PowerFit.Types.Energy_MWh WRef "SOC in MWh";
  output PowerFit.Types.Percent cgt_Wmax;
  output PowerFit.Types.Percent cgt_Wmin;
  output PowerFit.Types.Power_MW cgt_dQStore;
  output PowerFit.Types.Power_MW cgt_dQGen;
  output PowerFit.Types.Power_MW QFlow "Heat flow of storage, positive: discharge, negative: charge";
  output PowerFit.Types.Power_MW dQRef "reference power flow of storage, positive: charge, negative: discharge";
  output PowerFit.Types.SpecificCost_s C "Cost in second";
  output PowerFit.Types.Binary online "1: activated, 0: offline";
  annotation(
    defaultComponentName = "IO",
    Documentation(info = "<html>
  <p>
  Input/Output connector for renewables.
  </p>
  </html>"),
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Polygon(fillColor = {100, 100, 100}, fillPattern = FillPattern.Solid, points = {{0, 100}, {-100, 0}, {0, -100}, {100, 0}, {0, 100}}), Polygon(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-60, 0}, {60, 0}, {0, -60}, {-60, 0}})}),
    Diagram(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {19, 92}, lineThickness = 2, extent = {{-47, 18}, {25, -12}}, textString = "_PRef", horizontalAlignment = TextAlignment.Left), Text(origin = {33, 62}, lineThickness = 2, extent = {{-61, 20}, {25, -12}}, textString = "_PPlan", horizontalAlignment = TextAlignment.Left), Text(origin = {37, 42}, lineThickness = 2, extent = {{-65, 12}, {25, -22}}, textString = "_mode", horizontalAlignment = TextAlignment.Left), Text(origin = {101, 71}, lineThickness = 2, extent = {{-19, 9}, {39, -19}}, textString = "MW"), Text(origin = {101, 99}, lineThickness = 2, extent = {{-19, 9}, {39, -19}}, textString = "MW"), Text(origin = {7, 118}, lineThickness = 2, extent = {{-35, 20}, {37, -10}}, textString = "_limit", horizontalAlignment = TextAlignment.Left), Text(origin = {120, 124}, lineThickness = 2, extent = {{-38, 10}, {20, -14}}, textString = "MW"), Text(origin = {-73, 42}, lineThickness = 2, extent = {{-65, 12}, {25, -22}}, textString = "mode", horizontalAlignment = TextAlignment.Left), Text(origin = {-77, 62}, lineThickness = 2, extent = {{-61, 20}, {25, -12}}, textString = "PPlan", horizontalAlignment = TextAlignment.Left), Text(origin = {-91, 92}, lineThickness = 2, extent = {{-47, 18}, {25, -12}}, textString = "PRef", horizontalAlignment = TextAlignment.Left), Text(origin = {-103, 118}, lineThickness = 2, extent = {{-35, 20}, {37, -10}}, textString = "limit", horizontalAlignment = TextAlignment.Left), Polygon(origin = {0, 0}, fillColor = {100, 100, 100}, fillPattern = FillPattern.Solid, points = {{0, 20}, {-20, 0}, {0, -20}, {20, 0}, {0, 20}}), Polygon(origin = {-10, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{0, 0}, {20, 0}, {10, -10}, {0, 0}})}));
end IOHeatStorage;

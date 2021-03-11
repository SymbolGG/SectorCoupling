within VPPth.Connectors;

connector IOServiceCall "Connection for service call"
  input PowerFit.Types.Power_MW PPlan(start = 0) "Planned/forecast Power";
  output PowerFit.Types.Power_MW PRef "Effective Setpoint";
  annotation(
    defaultComponentName = "IO",
    Documentation(info = "<html>
  <p>
  Input/Output for loads
  </p>
  </html>"),
    Icon(graphics = {Polygon(fillColor = {100, 100, 100}, fillPattern = FillPattern.Solid, points = {{0, 100}, {-100, 0}, {0, -100}, {100, 0}, {0, 100}}), Polygon(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-60, 0}, {60, 0}, {0, -60}, {-60, 0}})}),
    Diagram(graphics = {Text(origin = {7, 32}, lineThickness = 2, extent = {{-45, 20}, {25, -12}}, textString = "_PRef", horizontalAlignment = TextAlignment.Left), Text(origin = {91, 41}, lineThickness = 2, extent = {{-19, 9}, {39, -19}}, textString = "MW"), Text(origin = {-85, 32}, lineThickness = 2, extent = {{-45, 20}, {25, -12}}, textString = "PRef", horizontalAlignment = TextAlignment.Left), Polygon(origin = {0, 0}, fillColor = {100, 100, 100}, fillPattern = FillPattern.Solid, points = {{0, 20}, {-20, 0}, {0, -20}, {20, 0}, {0, 20}}), Polygon(origin = {-10, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{0, 0}, {20, 0}, {10, -10}, {0, 0}})}, coordinateSystem(initialScale = 0.1)),
    __OpenModelica_commandLineOptions = "");
end IOServiceCall;

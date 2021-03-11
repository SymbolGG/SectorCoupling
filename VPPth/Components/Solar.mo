within VPPth.Components;

model Solar "Solar Plant"
  extends Interfaces.Renewables;
equation
  // FO.isSolar = 1 "component is solar generator -> isSolar=1";
  // FO.isWind = 0 "component is wind generator -> isWind=1";
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 110}}, initialScale = 0.1), graphics = {Text(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-120, -110}, {120, -150}}, textString = "%name"), Ellipse(lineThickness = 1, extent = {{-26, 58}, {28, 4}}, endAngle = 360, lineColor = {0, 0, 0}), Line(points = {{2, 70}, {2, 90}}, color = {0, 0, 0}), Line(points = {{30, 58}, {44, 72}}, color = {0, 0, 0}), Line(points = {{40, 30}, {62, 30}}, color = {0, 0, 0}), Line(points = {{28, 2}, {42, -12}}, color = {0, 0, 0}), Line(points = {{-28, 2}, {-42, -12}}, color = {0, 0, 0}), Line(points = {{-40, 30}, {-62, 30}}, color = {0, 0, 0}), Line(points = {{-28, 58}, {-42, 72}}, color = {0, 0, 0}), Line(points = {{4, -10}, {-12, -28}, {10, -28}, {-10, -46}}, color = {0, 0, 0}), Polygon(points = {{-62, -74}, {64, -74}, {50, -56}, {-44, -56}, {-62, -74}}, lineColor = {0, 0, 0})}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 110}})),
    Documentation(info = "<html><head></head><body><div><b><font size=\"5\"><br></font></b></div><div><b><font size=\"5\">Solar Plant</font></b></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">A solar plant usually means an installation of&nbsp;</font><span style=\"font-size: large;\">photovoltaic panels using the&nbsp;</span><span style=\"font-size: large;\">sun as a&nbsp;</span><span style=\"font-size: large;\">renewable but volatile energy source.</span></div><div><span style=\"font-size: large;\"><br></span></div><div><span style=\"font-size: large;\">The energetic radiation of the sun activates a chemical process in the panels which generates direct current. The solar plant installation should avoid any direct&nbsp;</span><span style=\"font-size: large;\">shadowing to maximize the profits.&nbsp;</span><span style=\"font-size: large;\">The energy can either be consumed, saved in a connected storage, or sold on the energy market with regarding the current demand, the operation costs of other available units, stock prices and other thechnical constraints.</span></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">Solar farms are represented through the renewable interface. The renewables have two limitations with respect to energy production:</font></div><div><font size=\"4\">1. On the one hand they are limited through their technical restrictions (maximum/minimum power).</font></div><div><font size=\"4\">2. On the other hand they cannot produce more energy than there is currently available (weather restrictions).</font></div><div><span style=\"font-size: large;\">As the grid model is used as a day ahead /intraday forecast, it is necessary to limit the possible energy production to the forecasted energy production if the component is in optimizing mode. Furthermore, it is possible to operate the renewables in a reduced mode, which means that the operator can vary the maximum power during operation stepwise (e.g. 60% of technical maximum power).</span></div></body></html>"));
end Solar;
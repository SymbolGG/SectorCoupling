within VPPth.Components;

model EBoiler
  extends Interfaces.EBoiler;
  // equation
  // Icon(coordinateSystem(initialScale = 0.1));
  annotation(
    Icon(graphics = {Text(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-120, -110}, {120, -150}}, textString = "%name"), Ellipse(origin = {-12, 110}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{38, -34}, {-14, -86}}, endAngle = 360), Polygon(origin = {-12, 110}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid, points = {{4, -56}, {-2, -64}, {6, -74}, {20, -72}, {22, -60}, {18, -54}, {16, -52}, {14, -48}, {14, -44}, {10, -50}, {8, -52}, {6, -56}, {10, -56}, {10, -60}, {8, -64}, {4, -64}, {4, -58}, {4, -56}}, smooth = Smooth.Bezier), Polygon(origin = {-12, 110}, lineColor = {191, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{10, -66}, {6, -66}, {8, -68}, {8, -68}, {12, -70}, {16, -68}, {18, -64}, {18, -60}, {16, -58}, {14, -56}, {14, -60}, {14, -62}, {12, -64}, {10, -66}}, smooth = Smooth.Bezier), Rectangle(origin = {20, 11}, lineThickness = 1, extent = {{-86, 73}, {46, -95}}), Line(origin = {37.67, -25.97}, points = {{-103, 0}, {27, 0}}, thickness = 1), Ellipse(origin = {1, 1}, lineThickness = 1, extent = {{-21, 9}, {19, -9}}, endAngle = 360), Rectangle(origin = {-4, 5}, lineThickness = 1, extent = {{-4, 1}, {12, -9}}), Rectangle(origin = {4, 85}, lineThickness = 1, extent = {{-26, 11}, {18, -1}}), Ellipse(origin = {-34, -56}, lineThickness = 1, extent = {{-12, 12}, {12, -12}}, endAngle = 360), Ellipse(origin = {34, -56}, lineThickness = 1, extent = {{-12, 12}, {12, -12}}, endAngle = 360), Ellipse(origin = {0, -56}, lineThickness = 1, extent = {{-6, 6}, {6, -6}}, endAngle = 360), Ellipse(origin = {16, -8}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{80, -34}, {26, -86}}, endAngle = 360), Polygon(origin = {14, -8}, fillColor = {255, 255, 127}, fillPattern = FillPattern.Solid, points = {{56, -46}, {48, -62}, {54, -62}, {46, -78}, {64, -56}, {56, -56}, {64, -46}, {56, -46}})}, coordinateSystem(extent = {{-100, -100}, {100, 110}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 110}})),
    Documentation(info = "<html><head></head><body><div><font size=\"5\"><b><br></b></font></div><div><font size=\"5\"><b>Combined Heat and Power (CHP)</b></font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">The combined heat and power component (CHP) contributes both heat and power simultaneously to the respective system. The relation of this two particular types of energy is dynamically optimized under consideration of current fuel and electricity prices. However, the thermal demand has priority and has to be fulfilled at any time.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">The CHP unit consists of a gas boiler and a steam condenser. The gas boiler is the backup for the CHP and can fully generate the required heat. By consuming gas in order to generate certain amounts of heat and power the incurring costs are considered. The steam condenser is able to consume any overproduced heat in the system.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">The CHP interfaces extends the generator interface by a thermal part. The optimizer monitors the alarms and, if a signal is detected, the unit will not be considered for the heat and electrical balance. The output from the model is the start/stop command for the WISAG controller. If there is no output at all (CHP turned off) the heat demand will be supplied entirely by the gas boiler and any possible thermal storage.</font></div></body></html>"));
end EBoiler;

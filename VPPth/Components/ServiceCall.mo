within VPPth.Components;

model ServiceCall
  extends Interfaces.ServiceCall;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 110}}, initialScale = 0.1), graphics = {Rectangle(origin = {-58, 34}, fillColor = {255, 255, 255}, fillPattern = FillPattern.CrossDiag, extent = {{-22, 24}, {90, -90}}), Text(extent = {{-120, -110}, {120, -150}}, textString = "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 110}})),
    __OpenModelica_commandLineOptions = "",
    Documentation(info = "<html><head></head><body><div><div><font size=\"5\"><b><br></b></font></div><div><font size=\"5\"><b>Slack Bus</b></font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">The slack bus is a grid node within the national grid where active and reactive power flows are balanced in order to keep a secure operation mode stabilizing frequency and voltage. Therefor, in the national grid energy in- and output have to be the same at any time.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">So the slack bus conducts electricity towards the gird component of the respective site in order to supply power. When the site, however, sells electricity to the market the slack bus receives energy from the grid component balancing it immediately.</font></div></div></body></html>"));
end ServiceCall;

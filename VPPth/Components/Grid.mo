within VPPth.Components;

model Grid "Accounting grid"
  extends Interfaces.Grid;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 110}}, initialScale = 0.1), graphics = {Text(extent = {{-120, -110}, {120, -150}}, textString = "%name"), Polygon(points = {{-68, 56}, {-6, 88}, {6, 88}, {66, 56}, {-68, 56}}, lineColor = {0, 0, 0}), Line(points = {{-22, 80}, {-22, 4}, {-54, -86}, {-48, -86}, {28, -12}}, color = {0, 0, 0}), Line(points = {{22, 80}, {22, 4}, {54, -86}, {48, -86}, {-28, -12}}, color = {0, 0, 0}), Line(points = {{-54, 56}, {-54, 44}}, color = {0, 0, 0}), Line(points = {{52, 56}, {52, 44}}, color = {0, 0, 0}), Line(points = {{-54, 6}, {-54, -6}}, color = {0, 0, 0}), Polygon(points = {{-68, 6}, {-6, 38}, {6, 38}, {66, 6}, {-68, 6}}, lineColor = {0, 0, 0}), Line(points = {{52, 6}, {52, -6}}, color = {0, 0, 0})}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 110}})),
    Documentation(info = "<html><head></head><body><div><div><font size=\"5\"><b><br></b></font></div><div><font size=\"5\"><b>Grid</b></font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">The grid component aggregates all assets integrated within the respective optimization process (generators, storages, loads) and provides the physical connection to the national grid.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">The grid can be seen as a single terminal point where the sum of generation and consumption needs to be balanced at all times and circumstances. Therefore, all components send their operating signals to the grid component in order to be accounted and processed.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">After aggregation, the power surplus or deficit is balanced via a grid connection point (slack bus). This grid connection mode happens under consideration of current energy prices and technical constraints in order to minimize costs.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">Moreover, a certain amount of power reserve can be allocated for reserve holdings that can gain additional revenues on the market.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">The power schedule of the grid calculated in the day-ahead optimization (DAO) is used as a suggestion for trading energy on the day-ahead/intraday market.</font></div></div><div><br></div></body></html>"));
end Grid;
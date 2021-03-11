within VPPth.Connectors;

connector ColdPort_a "Thermal port for 1-dim. heat transfer (filled rectangular icon)"
  extends HeatPort;
  annotation(
    defaultComponentName = "port_a",
    Documentation(info = "<html>
<p>This connector is used for 1-dimensional heat flow between components.
The variables in the connector are:</p>
<pre>
   T       Temperature in [Kelvin].
   Q_flow  Heat flow rate in [Watt].
</pre>
<p>According to the Modelica sign convention, a <strong>positive</strong> heat flow
rate <strong>Q_flow</strong> is considered to flow <strong>into</strong> a component. This
convention has to be used whenever this connector is used in a model
class.</p>
<p>Note, that the two connector classes <strong>HeatPort_a</strong> and
<strong>HeatPort_b</strong> are identical with the only exception of the different
<strong>icon layout</strong>.</p></html>"),
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 85, 255}, fillColor = {0, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}),
    Diagram(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 85, 255}, fillColor = {0, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-50, 50}, {50, -50}}), Text(lineColor = {0, 85, 255}, extent = {{-120, 120}, {100, 60}}, textString = "%name")}));
end ColdPort_a;

within VPPth.Connectors;

partial connector HeatPort "Thermal port for 1-dim. heat transfer"
  Modelica.SIunits.Temperature T "Port temperature";
  flow Types.HeatFlowRate Q_flow "Heat flow rate (positive if flowing from outside into the component)";
  annotation(
    Documentation(info = "<html>

</html>"));
end HeatPort;

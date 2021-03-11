within VPPth.Interfaces;

model SlackHeatSource "Prescribed heat flow boundary condition"
  Connectors.HeatPort_a Heatport annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}})));
  input Modelica.SIunits.Temperature Tset "temperature setting range from 293.15 to 353.15 K";
  output PowerFit.Types.Power_MW Q_flow "slack heat flow, should stay 0";
equation
  Heatport.Q_flow = Q_flow;
  Heatport.T = Tset;
end SlackHeatSource;

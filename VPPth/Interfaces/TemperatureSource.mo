within VPPth.Interfaces;

model TemperatureSource "Prescribed heat flow boundary condition"
  Connectors.HeatPort_a Heatport annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}})));
  input Modelica.SIunits.Temperature Tset(start = 368.15) "set source temperature";
  output PowerFit.Types.Power_MW Q_flow "slack heat flow, should stay 0";
equation
  Heatport.T = Tset;
  Heatport.Q_flow = Q_flow;
end TemperatureSource;

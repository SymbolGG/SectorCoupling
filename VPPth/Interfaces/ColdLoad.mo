within VPPth.Interfaces;

model ColdLoad "Prescribed heat flow boundary condition"
  input PowerFit.Types.Power_MW Q_flow;
  Connectors.ColdPort_b Coldport annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}})));
equation
  Coldport.Q_flow = Q_flow;
end ColdLoad;

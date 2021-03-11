within VPPth.Interfaces;

model HeatLoad "Prescribed heat flow boundary condition"
  Connectors.HeatPort_b Heatport annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Connectors.IOHeatLoad IO annotation(
    Placement(visible = true, transformation(origin = {-100, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  Heatport.Q_flow = IO.dQPlan;
  IO.dQPlan = IO.QFlow;
  if IO.dQPlan > 0.001 then
    IO.online = 1;
  else
    IO.online = 0;
  end if;
end HeatLoad;

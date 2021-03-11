within VPPth.Interfaces;

model ServiceCall "Generic load Model, uncontrollable"
  PowerSystems.Generic.PrescribedPowerLoad load(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem, phi = 1) annotation(
    Placement(visible = true, transformation(origin = {66, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Generic.Ports.Terminal_p terminal(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem "Phase system") annotation(
    Placement(visible = true, transformation(origin = {100, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  input PowerFit.Types.Power_MW PPlan(start = 0) "Planned/forecast Power";
  output PowerFit.Types.Power_MW PRef "Effective Setpoint";
equation
  connect(load.terminal, terminal) annotation(
    Line(points = {{76, 6}, {100, 6}}, color = {0, 120, 120}));
  PRef = load.P / 1000000;
  PRef = - PPlan;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end ServiceCall;

within VPPth.Interfaces;

model P2H
  input PowerFit.Types.Power_MW PRef(start = 0) "energy rate of the gas boiler";
  input Modelica.SIunits.Temperature Tset(start = 368.15) "set forward temperature for the P2H";
  input PowerFit.Types.Power_MW Qset(start = 1) "set heat flow through the pipe";
  input PowerFit.Types.Binary on(start = 1) "1: on, 0: off";
  input PowerFit.Types.SpecificCost_MWh CPElec(start = 60) "price for electricity";
  output PowerFit.Types.Power_MW cgt_Pmax;
  output PowerFit.Types.Power_MW cgt_Pmin;
  output PowerFit.Types.SpecificCost_s C "gas cost";
  output PowerFit.Types.Power_MW QFlow "Heat flow";
  outer PowerFit.Components.Monitor monitor;
  parameter PowerFit.Types.Power_MW PMaxAbs = 0.3 "Maximum power MW";
  parameter PowerFit.Types.Power_MW PMinAbs = 0 "Maximum power MW";
  parameter Real Eta = 1 "efficiency of gas boiler";
  HeatDemo.Connectors.HeatPort_a Heatport_a annotation(
    Placement(visible = true, transformation(origin = { -100,0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = { -100,0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Generic.PrescribedPowerLoad eboiler(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem, phi = 1) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PowerSystems.Generic.Ports.Terminal_p terminal(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem "Phase system") "Power Side" annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  HeatDemo.Connectors.HeatPort_b Heatport_b annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(eboiler.terminal, terminal) annotation(
    Line(points = {{0, 10}, {0, 10}, {0, 100}, {0, 100}}, color = {0, 120, 120}));
  eboiler.P = PRef * 1000000 / monitor.scale;
  // Heatport.Q_flow = -Eta * PRef;
  Heatport_a.Q_flow = - QFlow;
  Heatport_a.T = (Tset - Heatport_b.T) * Eta * PRef / Qset + Heatport_b.T;
  Heatport_a.Q_flow = - Heatport_b.Q_flow;
  cgt_Pmax = on * PMaxAbs - PRef;
  cgt_Pmin = PRef - on * PMinAbs;
  C = PRef * CPElec;
annotation(
    Diagram(graphics = {Bitmap(origin = {103, 2}, extent = {{-1, 2}, {1, -2}})}));end P2H;

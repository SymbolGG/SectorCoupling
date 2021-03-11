within VPPth.Interfaces;

model EBoiler
  outer PowerFit.Components.Monitor monitor;
  parameter PowerFit.Types.Power_MW PMaxAbs = 7.5 "Maximum power MW";
  parameter PowerFit.Types.Power_MW PMinAbs = 0 "Maximum power MW";
  parameter Real Eta = 1 "efficiency of gas boiler";
  Connectors.HeatPort_a Heatport annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Generic.PrescribedPowerLoad eboiler(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem, phi = 1) annotation(
    Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Generic.Ports.Terminal_p terminal(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem "Phase system") "Power Side" annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectors.IOEBoiler IO annotation(
    Placement(visible = true, transformation(origin = {-100, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerFit.Connectors.FEquipment FO annotation(
    Placement(visible = true, transformation(origin = {99, -53}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {99, -53}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
equation
  connect(eboiler.terminal, terminal) annotation(
    Line(points = {{-8, 0}, {-98, 0}, {-98, 0}, {-100, 0}}, color = {0, 120, 120}));
  eboiler.P = IO.PRef * 1000000 / monitor.scale;
  Heatport.Q_flow = - Eta * IO.PRef;
  Heatport.Q_flow = - IO.QFlow;
  if IO.mode < 0.5 then
    IO.cgt_Pmax = 0 - IO.Popt;
    IO.cgt_Pmin = IO.Popt - 0;
    IO.PRef = IO.PPlan;
    FO.PMaxOnline = 0;
    FO.PMinOnline = 0;
    FO.PResPos = 0;
    FO.PResNeg = 0;
  elseif IO.mode > 0.5 and IO.mode < 1.5 then
    IO.cgt_Pmax = IO.on * PMaxAbs - IO.Popt;
    IO.cgt_Pmin = IO.Popt - IO.on * PMinAbs;
    IO.PRef = IO.Popt;
    FO.PMaxOnline = IO.on * PMaxAbs;
    FO.PMinOnline = IO.on * PMinAbs;
    FO.PResPos = IO.PRef - PMinAbs * IO.on;
    FO.PResNeg = PMaxAbs * IO.on - IO.PRef;
  else
    IO.cgt_Pmax = 0 - IO.Popt;
    IO.cgt_Pmin = IO.Popt - 0;
    IO.PRef = 0;
    FO.PMaxOnline = 0;
    FO.PMinOnline = 0;
    FO.PResPos = 0;
    FO.PResNeg = 0;
  end if;
  IO.C = 0;
  IO.dPRef = IO.PRef - IO.PRef_prev;
  IO.don = IO.on - IO.on_prev;
  FO.PMax = 0;
  FO.PRef = IO.PRef;
  FO.isWind = 0;
  FO.isSolar = 0;
  FO.isLoad = 0;
  FO.isEStorage = 0;
  FO.isChargingStation = 0;
  FO.isGenerator = 0;
  FO.C = 0;
end EBoiler;

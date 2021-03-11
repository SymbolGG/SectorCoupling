within VPPth.Interfaces;

model HeatPump
  Modelica.SIunits.Temperature Tset "temperature setting range from 293.15 to 353.15 K";
  outer PowerFit.Components.Monitor monitor;
  parameter PowerFit.Types.Power_MW PMaxAbs = 7.5 "Maximum power MW";
  parameter Real CopMax = 4 "COP at maximal power";
  parameter PowerFit.Types.Power_MW PMinAbs = 5 "Maximum power MW";
  parameter Real CopMin = 3 "COP at minimal power";
  parameter Real EtaMax = 1.1 "Offset for efficiency,  Efficiency = EtaMax - EtaSlope * (T - 273.15)";
  parameter Real EtaSlope = 0.005 "Slope for efficiency,  Efficiency = EtaMax - EtaSlope * (T - 273.15)";
  Real a "to form a * PRef - b = - Q_flow";
  Real b "to form a * PRef - b = - Q_flow";
  Connectors.HeatPort_a Heatport annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Generic.PrescribedPowerLoad heatpump(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem, phi = 1) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Generic.Ports.Terminal_p terminal(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem "Phase system") "Power Side" annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectors.IOHeatPump IO annotation(
    Placement(visible = true, transformation(origin = {-100, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerFit.Connectors.FEquipment FO annotation(
    Placement(visible = true, transformation(origin = {99, -49}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {99, -49}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
equation
  connect(heatpump.terminal, terminal) annotation(
    Line(points = {{-10, 0}, {-98, 0}, {-98, 0}, {-100, 0}}, color = {0, 120, 120}));
  heatpump.P = IO.Popt * 1000000 / monitor.scale;
// a * PMaxAbs - b = CopMax * PMaxAbs;
// a * PMinAbs - b = CopMin * PMinAbs;
  a = (CopMax * PMaxAbs - CopMin * PMinAbs) / (PMaxAbs - PMinAbs);
  b = (a - CopMax) * PMaxAbs;
// b = (CopMax * PMaxAbs - CopMin * PMinAbs) / (PMaxAbs - PMinAbs) * PMaxAbs / (CopMax * PMaxAbs);
  Heatport.Q_flow = ((-a * IO.Popt) + b * IO.on) * (EtaMax - EtaSlope * (Tset - 273.15));
  Heatport.Q_flow = - IO.QFlow;
  Heatport.T = Tset;
//  IO.Popt = IO.PRef;
  if IO.mode < 0.5 then
    IO.PRef = IO.PPlan;
    IO.cgt_Pmax = 0 - IO.Popt;
    IO.cgt_Pmin = IO.Popt - 0;
    if IO.PPlan < 0.001 then
      IO.online = 0;
    else
      IO.online = 1;
    end if;
    FO.PMaxOnline = 0;
    FO.PMinOnline = 0;
    FO.PResPos = 0;
    FO.PResNeg = 0;
  elseif IO.mode > 0.5 and IO.mode < 1.5 then
    IO.PRef = IO.Popt;
    IO.cgt_Pmax = IO.on * PMaxAbs - IO.Popt;
    IO.cgt_Pmin = IO.Popt - IO.on * PMinAbs;
    IO.online = IO.on;
    FO.PMaxOnline = IO.on * PMaxAbs;
    FO.PMinOnline = IO.on * PMinAbs;
    FO.PResPos = IO.PRef - PMinAbs * IO.on;
    FO.PResNeg = PMaxAbs * IO.on - IO.PRef;
  else
    IO.PRef = 0;
    IO.cgt_Pmax = 0 - IO.Popt;
    IO.cgt_Pmin = IO.Popt - 0;
    IO.online = 0;
    FO.PMaxOnline = 0;
    FO.PMinOnline = 0;
    FO.PResPos = 0;
    FO.PResNeg = 0;
  end if;
  IO.TFlow = Tset - 273.15;
  IO.dPRef = IO.PRef - IO.PRef_prev;
  IO.don = IO.on - IO.on_prev;
  IO.dPAct = IO.PAct - IO.PRef;
  // internal variables
  FO.PMax = 0;
  FO.PRef = IO.PRef;
  FO.isWind = 0;
  FO.isSolar = 0;
  FO.isLoad = 0;
  FO.isEStorage = 0;
  FO.isChargingStation = 0;
  FO.isGenerator = 0;
  FO.C = 0;
end HeatPump;

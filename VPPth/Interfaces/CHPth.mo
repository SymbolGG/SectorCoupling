within VPPth.Interfaces;

model CHPth "Generic Generator with Buffer Model"
  //     Interfaces.HeatPorts_a[nNodes] heatPorts if use_HeatTransfer annotation (Placement(transformation(extent={{-10,45},{10,65}}), iconTransformation(extent={{-30,36},
  //       {32,52}})));
  outer PowerFit.Components.Monitor monitor;
  parameter PowerFit.Types.Power_MW PMaxAbs = 0.5 "Maximum power for generation" annotation(
    Dialog(group = "Generatorbetrieb"));
  parameter PowerFit.Types.Power_MW PMinAbs = 0 "Minimum power for generation" annotation(
    Dialog(group = "Generatorbetrieb"));
  parameter PowerFit.Types.SpecificCost_MWh CPMaxAbs = 10 "Cost for gen max power";
  parameter PowerFit.Types.SpecificCost_MWh CPMinAbs = 15 "Cost for gen min power";
  parameter Real etaEl = 35 "electrical efficiency in percentage";
  parameter Real etaTh = 60 "thermal efficiency in percentage";
  Real CMinAbs;
  Real CMaxAbs;
  output PowerFit.Types.Power_W PRef "Reference Power";
  PowerSystems.Generic.PrescribedPowerSource generator(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem) annotation(
    Placement(visible = true, transformation(extent = {{60, -10}, {80, 10}}, rotation = 0)));
  PowerSystems.Generic.Ports.Terminal_n terminal(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem "Phase system") "Power Side" annotation(
    Placement(visible = true, transformation(extent = {{90, -10}, {110, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerFit.Connectors.FEquipment FO annotation(
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Connectors.IOCHPth IO annotation(
    Placement(visible = true, transformation(origin = {-100, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Max P_Gen annotation(
    Placement(visible = true, transformation(origin = {-48, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  Connectors.Gascons Gas if use_Gasstore annotation(
  //    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectors.HeatPort_a HeatPort annotation(
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  Modelica.Blocks.Sources.Constant const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-86, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, P_Gen.u2) annotation(
    Line(points = {{-75, -38}, {-75, -62}, {-60, -62}}, color = {0, 0, 127}));
//PPlan and PRef are in Watt. IO.PPlan and IO.PRef in MW by default. Therefore conversion is necessary
  connect(generator.terminal, terminal) annotation(
    Line(points = {{80, 0}, {100, 0}}, color = {0, 120, 120}));
//  connect(PRef, generator.P);
//  if use_Gasstore then
//    Gas.P_CHP = P_Gen.u1 / (etaMaxEl / 100);
//    storageOn = Gas.storageon;
//  end if;
  generator.P = PRef - IO.Pbypass / 100 * PMaxAbs * 1e6;
  PRef = P_Gen.u1;
  P_Gen.y * etaTh / etaEl = - HeatPort.Q_flow * 1e6 / monitor.scale;
  if IO.mode < 0.5 then
//mode=0 PPlan
    IO.cgt_Pmax = IO.on * IO.PPlan / PMaxAbs * 100 - IO.Popt;
    IO.cgt_Pmin = IO.Popt - IO.PPlan / PMaxAbs * 100;
//chooses bigger value because otherwise PRef would be limited by smaller value
    PRef = (IO.Popt - IO.Pbypass) / 100 * PMaxAbs * 1e6 / monitor.scale;
  elseif IO.mode > 0.5 and IO.mode < 1.5 then
//mode=1 optimized
    IO.cgt_Pmax = IO.on * IO.Pmax - IO.Popt;
    IO.cgt_Pmin = IO.Popt - IO.on * PMinAbs / PMaxAbs * 100;
//chooses bigger value because otherwise PRef would be limited by smaller value
    PRef = (IO.Popt - IO.Pbypass) / 100 * PMaxAbs * 1e6 / monitor.scale;
  else
//maintenanced
    IO.cgt_Pmax = 0 - IO.Popt;
    IO.cgt_Pmin = IO.Popt - 0;
//cuts connection to storage -> no losses of energy
    PRef = 0;
  end if;
  IO.cgt_Pmaxbypass = IO.Popt - IO.Pbypass;
  IO.cgt_Pminbypass = IO.Pbypass - 0;
  IO.online = if PRef > 5e-5 * PMaxAbs * 1000000 / monitor.scale then 1 else 0;
  IO.PRef = PRef / 1e6 * monitor.scale;
  IO.HRef = IO.PRef * etaTh / etaEl;
//calculation of total cost in cost per second, only for display
  CMinAbs = CPMinAbs * PMinAbs / monitor.scale;
  CMaxAbs = CPMaxAbs * PMaxAbs / monitor.scale;
  IO.C = (IO.on * CMinAbs + (CMaxAbs - CMinAbs) / (PMaxAbs - PMinAbs) * monitor.scale * (PRef / 1e6 - IO.on * PMinAbs / monitor.scale)) / 3600;
//calculation of variable cost, used for optimization (cost for cycles are taken into account only at storing)
  IO.dPAct = IO.PAct - IO.PRef;
  FO.PResPos = PMaxAbs * IO.on - IO.PRef;
  FO.PResNeg = IO.PRef - PMinAbs * IO.on;
  FO.PMaxOnline = IO.on * IO.Pmax / 100 * PMaxAbs;
  FO.PMinOnline = IO.on * PMinAbs;
  FO.PRef = IO.PRef;
  FO.isWind = 0;
  FO.isSolar = 0;
  FO.isLoad = 0;
  FO.isGenerator = 1;
  FO.isEStorage = 0;
  FO.isChargingStation = 0;
  FO.PMax = 0;
  FO.C = IO.C;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})));
end CHPth;

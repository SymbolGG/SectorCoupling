within VPPth.Interfaces;

model CHP "Generic Generator with Buffer Model"
  //     Interfaces.HeatPorts_a[nNodes] heatPorts if use_HeatTransfer annotation (Placement(transformation(extent={{-10,45},{10,65}}), iconTransformation(extent={{-30,36},
  //       {32,52}})));
  outer PowerFit.Components.Monitor monitor;
  parameter PowerFit.Types.Energy_MWh WMaxAbs = 1.5 "Maximum storage capacity" annotation(
    Dialog(group = "Speicherbetrieb"));
  parameter PowerFit.Types.Power_MW PMaxAbs = 0.5 "Maximum power for generation" annotation(
    Dialog(group = "Generatorbetrieb"));
  parameter PowerFit.Types.Power_MW PMinAbs = 0 "Minimum power for generation" annotation(
    Dialog(group = "Generatorbetrieb"));
  parameter PowerFit.Types.Power_MW HMaxAbsE = 0 "Maximum electric heat" annotation(
    Dialog(group = "Generatorbetrieb"));
  parameter PowerFit.Types.Power_MW HMaxAbsB = 0 "Maximum burner heat";
  parameter PowerFit.Types.Percent Wmin = 0 "Minumum state of charge" annotation(
    Dialog(tab = "Initialization"));
  parameter PowerFit.Types.Percent Wmax = 100 "Maximum state of charge" annotation(
    Dialog(tab = "Initialization"));
  parameter PowerFit.Types.SpecificCost_MWh CPMaxAbs = 10 "Cost for gen max power";
  parameter PowerFit.Types.SpecificCost_MWh CPMinAbs = 15 "Cost for gen min power";
  parameter PowerFit.Types.SpecificCost_MWh CHMaxAbsB = 5 "Cost for burner heat";
  parameter PowerFit.Types.Percent Wloss = 0 "Storage losses";
  parameter Real etaEl = 35 "electrical efficiency in percentage";
  parameter Real etaTh = 60 "thermal efficiency in percentage";
  Real CMinAbs;
  Real CMaxAbs;
  output PowerFit.Types.Power_W PRef "Reference Power";
  output PowerFit.Types.Power_W HRefE "Reference Power";
  output PowerFit.Types.Power_W HRefB "Reference Power";
  PowerSystems.Generic.PrescribedPowerSource generator(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem) annotation(
    Placement(visible = true, transformation(extent = {{60, -10}, {80, 10}}, rotation = 0)));
  PowerSystems.Generic.Ports.Terminal_n terminal(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem "Phase system") "Power Side" annotation(
    Placement(visible = true, transformation(extent = {{90, -10}, {110, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add(k1 = -1 * (1000000 / monitor.scale), k2 = 1 * (etaTh / etaEl), k3 = +1 * ((-Wloss / 100) * (WMaxAbs * 1000000 / monitor.scale / 100))) annotation(
    Placement(visible = true, transformation(extent = {{-22, -66}, {-2, -46}}, rotation = 0)));
  Modelica.Blocks.Math.Product switchStorage annotation(
    Placement(visible = true, transformation(origin = {44, -52}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  PowerFit.Connectors.FEquipment FO annotation(
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  PowerFit.Connectors.IOCHP IO annotation(
    Placement(visible = true, transformation(origin = {-100, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Max P_Gen annotation(
    Placement(visible = true, transformation(origin = {-48, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add addE(k1 = +1) annotation(
    Placement(visible = true, transformation(origin = {20, -56}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  PowerFit.Utilities.Integrator store(k = 100 / (3600 * WMaxAbs * 1000000 / monitor.scale), u1 = min(Wmax, max(Wmin, IO.Wstart))) annotation(
    Placement(visible = true, transformation(origin = {78, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  Connectors.Gascons Gas if use_Gasstore annotation(
  //    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Connectors.HeatPort_a HeatPort annotation(
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  Modelica.Blocks.Sources.Constant const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-86, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerFit.Types.Binary storageOn "Storage is on or off, dependent on mode";
equation
//  CPMaxAbs=IO.CPfuel/(etaMaxEl/100)+Varaddcost;
//  CPMinAbs=IO.CPfuel/(etaMinEl/100);
  IO.Wnext = IO.Wref + monitor.tSample / 3600 * store.u2 / 1000000 * 100 / WMaxAbs;
  connect(switchStorage.y, store.u2) annotation(
    Line(points = {{52, -52}, {60, -52}, {60, -54}, {66, -54}, {66, -54}}, color = {0, 0, 127}));
  connect(store.y, add.u3) annotation(
    Line(points = {{90, -48}, {92, -48}, {92, -78}, {-30, -78}, {-30, -64}, {-24, -64}, {-24, -64}}, color = {0, 0, 127}));
  connect(addE.u2, add.y) annotation(
    Line(points = {{12.8, -59.6}, {4, -59.6}, {4, -56}, {-1, -56}}, color = {0, 0, 127}));
  connect(switchStorage.u2, addE.y) annotation(
    Line(points = {{34.4, -56.8}, {26, -56.8}, {26, -56}, {26.6, -56}}, color = {0, 0, 127}));
  storageOn = switchStorage.u1;
  connect(P_Gen.y, add.u2) annotation(
    Line(points = {{-37, -56}, {-24, -56}}, color = {0, 0, 127}));
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
  generator.P = PRef - HRefE;
  PRef = P_Gen.u1;
//Wstart_ = IO.Wstart;
  add.u1 = IO.HLoad;
  HeatPort.Q_flow = addE.y;
// + IO.dH;
  addE.u1 = HRefE + HRefB;
//  IO.PRef_elheat = PMaxAbsE * IO.HoptE / 100;
//  IO.cgt_PMaxE = PMaxAbsE - IO.PRef_elheat;
  if IO.mode < 0.5 then
//mode=0 PPlan
    IO.cgt_Pmax = IO.on * IO.PPlan / PMaxAbs * 100 - IO.Popt;
    IO.cgt_Pmin = IO.Popt - IO.PPlan / PMaxAbs * 100;
    IO.cgt_HmaxE = IO.HmaxE - IO.HoptE;
    IO.cgt_HminE = IO.HoptE - 0;
    IO.cgt_HmaxB = IO.HmaxB - IO.HoptB;
    IO.cgt_HminB = IO.HoptB - 0;
    storageOn = 1;
//chooses bigger value because otherwise PRef would be limited by smaller value
    PRef = IO.Popt / 100 * PMaxAbs * 1e6 / monitor.scale;
    HRefE = IO.HoptE / 100 * HMaxAbsE * 1e6 / monitor.scale;
    HRefB = IO.HoptB / 100 * HMaxAbsB * 1e6 / monitor.scale;
  elseif IO.mode > 0.5 and IO.mode < 1.5 then
//mode=1 optimized
    IO.cgt_Pmax = IO.on * IO.Pmax - IO.Popt;
    IO.cgt_Pmin = IO.Popt - IO.on * PMinAbs / PMaxAbs * 100;
    IO.cgt_HmaxE = IO.HmaxE - IO.HoptE;
    IO.cgt_HminE = IO.HoptE - 0;
    IO.cgt_HmaxB = IO.HmaxB - IO.HoptB;
    IO.cgt_HminB = IO.HoptB - 0;
    storageOn = 1;
//chooses bigger value because otherwise PRef would be limited by smaller value
    PRef = IO.Popt / 100 * PMaxAbs * 1e6 / monitor.scale;
    HRefE = IO.HoptE / 100 * HMaxAbsE * 1e6 / monitor.scale;
    HRefB = IO.HoptB / 100 * HMaxAbsB * 1e6 / monitor.scale;
  else
//maintenanced
    IO.cgt_Pmax = 0 - IO.Popt;
    IO.cgt_Pmin = IO.Popt - 0;
    IO.cgt_HmaxE = 0 - IO.HoptE;
    IO.cgt_HminE = IO.HoptE - 0;
    IO.cgt_HmaxB = 0 - IO.HoptB;
    IO.cgt_HminB = IO.HoptB - 0;
    storageOn = 0;
//cuts connection to storage -> no losses of energy
    PRef = 0;
    HRefE = 0;
    HRefB = 0;
  end if;
  IO.online = if PRef > 5e-5 * PMaxAbs * 1000000 / monitor.scale then 1 else 0;
  IO.HRefE = HRefE / 1e6 * monitor.scale;
  IO.PRef = PRef / 1e6 * monitor.scale;
  IO.HRefB = HRefB / 1e6 * monitor.scale;
  IO.HRef = IO.PRef * etaTh / etaEl + IO.HRefE + IO.HRefB;
  IO.PRefTotal = generator.P / 1e6 * monitor.scale;
//conversion necessary. equality holds
  IO.Wref = store.y;
//content of storage in percent
  IO.WRef = store.y / 100 * WMaxAbs;
//content of storage in MWh
  IO.cgt_Wmax = Wmax - IO.Wref;
//limitation of storage content -> upper bound
  IO.cgt_Wmin = IO.Wref - Wmin;
//limitation of storage content -> lower bound
//IO.C = IO.CFix + IO.CVar;
//calculation of total cost in cost per second, only for display
//  IO.CFix = CFixOn * IO.on / 3600;
  CMinAbs = CPMinAbs * PMinAbs / monitor.scale;
  CMaxAbs = CPMaxAbs * PMaxAbs / monitor.scale;
  IO.CM = (IO.on * CMinAbs + (CMaxAbs - CMinAbs) / (PMaxAbs - PMinAbs) * monitor.scale * (PRef / 1e6 - IO.on * PMinAbs / monitor.scale)) / 3600;
//  IO.CB = (IO.HRefB * etaThB / 100 * IO.CPfuel) / 3600;
//  IO.CB = (IO.HRefB / etaThB * etaEl * CPMaxAbs) / 3600;
  IO.CB = IO.HRefB / monitor.scale * CHMaxAbsB / 3600;
  IO.C = IO.CM + IO.CB;
//calculation of variable cost, used for optimization (cost for cycles are taken into account only at storing)
  IO.dPAct = IO.PAct - IO.PRef + IO.HRefE;
//sets BinaryPos to zero if Wref<WspinPos, otherwise one
  FO.PResPos = PMaxAbs * IO.on - IO.PRef;
  FO.PResNeg = IO.PRef - PMinAbs * IO.on + HMaxAbsE;
// FO.PMaxOnline = if IO.cgt_Wmax > sampletime * PMaxAbs then PMaxAbs * IO.on else 0;
  FO.PMaxOnline = (if IO.mode > 0.5 and IO.mode < 1.5 then min((WMaxAbs * Wmax / 100 - IO.WRef) / monitor.tSample * 3600 + IO.HLoad / (etaTh / etaEl), PMaxAbs) else IO.PRef) - IO.PRef;
  FO.PMinOnline = max(0, PMinAbs - HMaxAbsE) - IO.PRef;
  FO.PRef = IO.PRef - IO.HRefE;
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
end CHP;

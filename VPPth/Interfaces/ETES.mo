within VPPth.Interfaces;

model ETES
  inner PowerSystems.System system;
  input PowerFit.Types.Binary onStore(start = 0) "1: on, 0: off";
  input PowerFit.Types.Binary onGen(start = 0) "1: on, 0: off";
  input PowerFit.Types.Percent Wheatstart(start = 50) "start heat SOC";
  input PowerFit.Types.Percent Wcoldstart(start = 50) "start cold SOC";
  //  input Modelica.SIunits.Temperature Tset "temperature setting range from 293.15 to 353.15 K";
  input PowerFit.Types.SpecificCost_MWh CPElec(start = 50) "electricity price";
  input PowerFit.Types.Power_MW dQHeatSurplus(start = 0) "surplus heat flow, to be minimized";
  input PowerFit.Types.Power_MW dQColdSurplus(start = 0) "surplus cold flow, to be minimized";
  input PowerFit.Types.Binary onStorePrev(start = 0) "from last cycle, 1: on, 0: off";
  input PowerFit.Types.Binary onGenPrev(start = 0) "from last cycle, 1: on, 0: off";
  output PowerFit.Types.Power_MW PRefStore "electricity charge power";
  output PowerFit.Types.Power_MW PRefGen "electricity discharge power";
  output PowerFit.Types.Power_MW PRef;
  //  output PowerFit.Types.Power_MW cgt_PStore;
  //  output PowerFit.Types.Power_MW cgt_Pmin;
  output PowerFit.Types.Percent cgt_on "Constraint on charge or discharge";
  output PowerFit.Types.SpecificCost_s C "electricity cost";
  output PowerFit.Types.Percent Wheatref "State of Charge of heat storage";
  output PowerFit.Types.Percent Wheatnext "Next period State of Charge of heat storage";
  output PowerFit.Types.Percent Wcoldref "State of Charge of cold storage";
  output PowerFit.Types.Percent Wcoldnext "Next period State of Charge of cold storage";
  output PowerFit.Types.Percent cgt_Wheatmax;
  output PowerFit.Types.Percent cgt_Wheatmin;
  output PowerFit.Types.Percent cgt_Wcoldmax;
  output PowerFit.Types.Percent cgt_Wcoldmin;
  output PowerFit.Types.Power_MW cgt_dQheatsurmax;
  output PowerFit.Types.Power_MW cgt_dQcoldsurmax;
  output Integer donStore "change of onStore";
  output Integer donGen "change of onGen";
  //  output PowerFit.Types.Power_MW QFlow "Heat flow";
  //  output Real TFlow "forward temperature in °C";
  //output Real COP "COP of heat pump";
  outer PowerFit.Components.Monitor monitor;
  parameter PowerFit.Types.Power_MW PMaxAbs = 7.5 "Maximum power MW";
  parameter PowerFit.Types.Power_MW dQHeatSurMaxAbs = 5 "Maximum heat surplus power MW";
  parameter PowerFit.Types.Power_MW dQColdSurMaxAbs = 5 "Maximum cold surplus power MW";
  parameter Real Copheat = 3 "COP at for heat generation";
  parameter Real eta = 0.5 "Efficiency of discharging cycle";
  parameter Real THeat = 80 "Temperature of heatport in °C";
  parameter Real TCold = 0 "Temperature of coldport in °C";
  parameter PowerFit.Types.Energy_MWh WheatMaxAbs = 128 "Maximum heat storage capacity";
  parameter PowerFit.Types.Energy_MWh WcoldMaxAbs = 128 "Maximum cold storage capacity";
  parameter Real tSample = 900 "sample time in seconds";
  parameter PowerFit.Types.Percent Wheatmin = 5 "Minumum state of charge";
  parameter PowerFit.Types.Percent Wheatmax = 95 "Maximum state of charge";
  parameter PowerFit.Types.Percent Wcoldmin = 5 "Minumum state of charge";
  parameter PowerFit.Types.Percent Wcoldmax = 95 "Maximum state of charge";
  //  parameter PowerFit.Types.Power_MW PMaxAbs = 7.5 "Maximum power MW";
  //  parameter Real CopMax = 4 "COP at maximal power";
  //  parameter PowerFit.Types.Power_MW PMinAbs = 5 "Maximum power MW";
  //  parameter Real CopMin = 3 "COP at minimal power";
  //  parameter Real EtaMax = 1.1 "Offset for efficiency,  Efficiency = EtaMax - EtaSlope * (T - 273.15)";
  //  parameter Real EtaSlope = 0.005 "Slope for efficiency,  Efficiency = EtaMax - EtaSlope * (T - 273.15)";
  //  Real a "to form a * PRef - b = - Q_flow";
  //  Real b "to form a * PRef - b = - Q_flow";
  VPPth.Connectors.HeatPort_a Heatport annotation(
    Placement(visible = true, transformation(origin = {100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Generic.PrescribedPowerSource etes(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Generic.Ports.Terminal_p terminal(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem "Phase system") "Power Side" annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Connectors.ColdPort_a Coldport annotation(
    Placement(visible = true, transformation(origin = {100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerFit.Utilities.Integrator heatstorage(k = 100 / 3600 / WheatMaxAbs) annotation(
    Placement(visible = true, transformation(origin = {0, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerFit.Utilities.Integrator coldstorage(k = 100 / 3600 / WcoldMaxAbs) annotation(
    Placement(visible = true, transformation(origin = {0, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(etes.terminal, terminal) annotation(
    Line(points = {{-10, 0}, {-98, 0}, {-98, 0}, {-100, 0}}, color = {0, 120, 120}));
  PRef = PRefGen - PRefStore;
  PRefStore = onStore * PMaxAbs;
  PRefGen = onGen * eta * PMaxAbs;
  etes.P = PRef * 1000000 / monitor.scale;
  heatstorage.u1 = Wheatstart;
  coldstorage.u1 = Wcoldstart;
  heatstorage.u2 = Copheat * ( PRefStore - 1 / eta * PRefGen) - dQHeatSurplus + Heatport.Q_flow;
  coldstorage.u2 = ( Copheat - 1 ) * ( PRefStore - 1 / eta * PRefGen) - dQColdSurplus + Coldport.Q_flow;
//// a * PMaxAbs - b = CopMax * PMaxAbs;
//// a * PMinAbs - b = CopMin * PMinAbs;
//  a = (CopMax * PMaxAbs - CopMin * PMinAbs) / (PMaxAbs - PMinAbs);
//  b = (a - CopMax) * PMaxAbs;
//  Heatport.Q_flow = ((-a * PRef) + b * on) * (EtaMax - EtaSlope * (Tset - 273.15));
//  Heatport.Q_flow = -QFlow;
  Heatport.T = THeat + 273.15;
  Coldport.T = TCold + 273.15;
  cgt_on = 1 - onStore - onGen;
  C = CPElec * PRef;
  Wheatref = heatstorage.y;
  Wheatnext = heatstorage.y + heatstorage.u2 / WheatMaxAbs / 3600 * 100 * tSample;
  Wcoldref = coldstorage.y;
  Wcoldnext = coldstorage.y + coldstorage.u2 / WcoldMaxAbs / 3600 * 100 * tSample;
  cgt_Wheatmax = Wheatmax - Wheatnext;
  cgt_Wheatmin = Wheatnext - Wheatmin;
  cgt_Wcoldmax = Wcoldmax - Wcoldnext;
  cgt_Wcoldmin = Wcoldnext - Wcoldmin;
  cgt_dQheatsurmax = dQHeatSurMaxAbs - dQHeatSurplus;
  cgt_dQcoldsurmax = dQColdSurMaxAbs - dQColdSurplus;
  donStore = onStorePrev - onStore;
  donGen = onGenPrev - onGen;
end ETES;

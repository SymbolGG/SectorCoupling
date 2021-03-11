within VPPth.Interfaces;

model Renewables "Generic Renewable Model"
  outer PowerFit.Components.Monitor monitor;
  parameter PowerFit.Types.Power_MW PMaxAbs = 0.2 "Maximum power";
  parameter PowerFit.Types.Power_MW PMinAbs = 0 "Minimum power before shutdown";
  parameter PowerFit.Types.SpecificCost_MWh CPMaxAbs = 10 "Generation cost for maximum power in dollar per MWh";
  output PowerFit.Types.Power_W PRef "Reference Power";
  output PowerFit.Types.Power_W PPlan "Scheduled Referenced Power";
  PowerSystems.Generic.Ports.Terminal_n terminal(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem "Phase system") annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectors.IORenewables IO annotation(
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Generic.PrescribedPowerSource generator(redeclare package PhaseSystem = PowerFit.PackagePhaseSystem) annotation(
    Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(generator.terminal, terminal) annotation(
    Line(points = {{70, 0}, {98, 0}, {98, 0}, {100, 0}}, color = {0, 120, 120}));
  PRef = generator.P;
  PPlan = if IO.PPlan < 0.001 then 0 else max(min(IO.Pmax / 100 * PMaxAbs, IO.PPlan), PMinAbs) * 1000000 / monitor.scale;
//Limitation to min and max power of generator
//change of operation modes (0=Schedule/1=Optimized/2=Maintenance)
  if IO.mode < 0.5 then
//scheduled
    PRef = PPlan;
    IO.cgt_Pmax = 0 - IO.Popt;
//upper bound for PRef
    IO.cgt_Pmin = IO.Popt - 0;
//lower bound for PRef
    IO.PCurtail = 0;
  elseif IO.mode > 0.5 and IO.mode < 1.5 then
//optimized
    PRef = IO.Popt / 100 * PMaxAbs * 1000000 / monitor.scale;
//if RD=1 then the reduced level of PS is chosen dependent on IO.Pred1 and IO.Pred2,...
    IO.cgt_Pmax = IO.Pmax - IO.Popt;
//upper bound for PRef
    IO.cgt_Pmin = IO.Popt - PMinAbs / PMaxAbs * 100;
//lower bound for PRef
    IO.PCurtail = PPlan / 1000000 * monitor.scale - IO.PRef;
  else
//maintenanced
    PRef = 0;
    IO.cgt_Pmax = 0 - IO.Popt;
    IO.cgt_Pmin = IO.Popt - 0;
    IO.PCurtail = 0;
  end if;
  if PRef < PPlan - 5e-5 * PMaxAbs * 1000000 / monitor.scale then
    IO.limited = 1;
  else
    IO.limited = 0;
  end if;
  IO.PRef = PRef / 1000000 * monitor.scale;
  IO.online = if PRef > 5e-5 * PMaxAbs * 1000000 / monitor.scale then 1 else 0;
//equality holds
  IO.C = PRef / 1000000 * CPMaxAbs / 3600;
//calculation of total cost in dollar per second
  IO.cgt_PPlan = PPlan / 1000000 * monitor.scale - IO.PRef;
//PPlan is upper limit for IO.PRef
  IO.dPAct = IO.PAct - IO.PRef;
//offset between actual and reference power
//information that are send to the grid
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})));
end Renewables;

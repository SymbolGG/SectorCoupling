within VPPth.Interfaces;

model HeatStorage "Lumped thermal element storing heat"
  parameter PowerFit.Types.Percent Wmin = 5 "Minumum state of charge";
  parameter PowerFit.Types.Percent Wmax = 95 "Maximum state of charge";
  parameter PowerFit.Types.Percent Wloss = 0 "Storage losses";
  parameter PowerFit.Types.Energy_MWh WMaxAbs = 128 "Maximum storage capacity";
  parameter PowerFit.Types.Power_MW PMaxAbsStore = 10 "Maximum power for charging";
  parameter PowerFit.Types.Power_MW PMaxAbsGen = 10 "Maximum power for generation";
  parameter Real tSample = 900 "sample time in seconds";
  parameter PowerFit.Types.SpecificCost_MWh CPMaxAbs = 0.01 "Cost for storing power";
  Connectors.HeatPort_a Heatport annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerFit.Utilities.Integrator buffer(y_start = IO.Wstart, k = 100 / 3600 / WMaxAbs) annotation(
    Placement(visible = true, transformation(origin = {0, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectors.IOHeatStorage IO annotation(
    Placement(visible = true, transformation(origin = {-100, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  if IO.mode > 0.5 and IO.mode < 1.5 then
    IO.cgt_Wmax = Wmax - IO.Wref_next;
    IO.cgt_Wmin = IO.Wref_next - Wmin;
    IO.cgt_dQStore = PMaxAbsStore - IO.dQRefStore;
    IO.cgt_dQGen = PMaxAbsGen - IO.dQRefGen;
    IO.online = 1;
  else
    IO.cgt_Wmax = 0;
    IO.cgt_Wmin = 0;
    IO.cgt_dQStore = 0 - IO.dQRefStore;
    IO.cgt_dQGen = 0 - IO.dQRefGen;
    IO.online = 0;
  end if;
  IO.dQRef = IO.dQRefGen - IO.dQRefStore;
//  buffer.u1 = Wstart;
  Heatport.Q_flow = - IO.dQRef;
  Heatport.Q_flow = IO.QFlow;
  buffer.u = Heatport.Q_flow;
  IO.Wref = buffer.y;
  IO.Wref_next = buffer.y + Heatport.Q_flow / WMaxAbs / 3600 * 100 * tSample;
  IO.WRef = buffer.y / 100 * WMaxAbs;
  IO.C = CPMaxAbs * ( IO.dQRefGen + IO.dQRefStore ) / 3600;
end HeatStorage;

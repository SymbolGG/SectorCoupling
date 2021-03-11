within VPPth.Interfaces;

model GasBoiler
//  input PowerFit.Types.Power_MW PRef(start = 0) "energy rate of the gas boiler";
//  input PowerFit.Types.Binary on(start = 1) "1: on, 0: off";
//  input PowerFit.Types.SpecificCost_MWh CPGas(start = 20) "price for gas";
//  output PowerFit.Types.Power_MW cgt_Pmax;
//  output PowerFit.Types.Power_MW cgt_Pmin;
//  output PowerFit.Types.SpecificCost_s C "gas cost";
//  output PowerFit.Types.Power_MW QFlow "Heat flow";
  parameter PowerFit.Types.Power_MW PMaxAbs = 7.5 "Maximum power MW";
  parameter PowerFit.Types.Power_MW PMinAbs = 0 "Maximum power MW";
  parameter Real Eta = 1 "efficiency of gas boiler";
  Connectors.HeatPort_a Heatport annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectors.IOGasBoiler IO annotation(
    Placement(visible = true, transformation(origin = {-100, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  Heatport.Q_flow = - Eta * IO.dQRef;
  Heatport.Q_flow = - IO.QFlow;
  if IO.mode < 0.5 then
    IO.cgt_dQmax = 0 - IO.dQopt;
    IO.cgt_dQmin = IO.dQopt - 0;
    IO.dQRef = IO.dQPlan;
  elseif IO.mode > 0.5 and IO.mode < 1.5 then
    IO.cgt_dQmax = IO.on * PMaxAbs - IO.dQopt;
    IO.cgt_dQmin = IO.dQopt - IO.on * PMinAbs;
    IO.dQRef = IO.dQopt;
  else
    IO.cgt_dQmax = 0 - IO.dQopt;
    IO.cgt_dQmin = IO.dQopt - 0;
    IO.dQRef = 0;
  end if;
  IO.C = IO.dQRef * IO.CPGas / 3600;
end GasBoiler;

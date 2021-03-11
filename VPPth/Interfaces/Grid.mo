within VPPth.Interfaces;

model Grid
  input PowerFit.Types.SpecificCost_MWh CPGrid(start = 100) "Price for Grid exchange";
  input PowerFit.Types.Power_MW PRefBuy;
  input PowerFit.Types.Power_MW PRefSell;
  input PowerFit.Types.Mode mode(start = 1) "0=Schedule/1=Optimized/2=Island";
  input PowerFit.Types.Power_MW PPlan(start = 0) "Planned/forecast Power";
  input PowerFit.Types.Power_MW PResPos(start = 0) "Positive spinning reserve requirement";
  input PowerFit.Types.Power_MW PResNeg(start = 0) "Negative spinning reserve requirement";
  output PowerFit.Types.Power_MW PRef;
  output PowerFit.Types.Power_MW cgt_PoptBuyMax "constraint for buying power";
  output PowerFit.Types.Power_MW cgt_PoptSellMax "constraint for selling power";
  output PowerFit.Types.Power_MW cgt_PoptBuyMin "constraint for buying power";
  output PowerFit.Types.Power_MW cgt_PoptSellMin "constraint for selling power";
  output PowerFit.Types.Power_MW PImbalance "Difference modeled power flow minus reference power output";
  output PowerFit.Types.SpecificCost_s C "Cost for Display";
  output PowerFit.Types.SpecificCost_s CBuy "Cost for Buying";
  output PowerFit.Types.SpecificCost_s CSell "Revenue for Selling (weight -1)";
  output PowerFit.Types.Power_MW PMaxResPos "Total available positive reserve";
  output PowerFit.Types.Power_MW PMaxResNeg "Total available negative reserve";
  output PowerFit.Types.Power_MW cgt_PResPos "Contraint positive spinning reserve";
  output PowerFit.Types.Power_MW cgt_PResNeg "Contraint negative spinning reserve";
  // output PowerFit.Types.Power_MW PImbalance;
  //output PowerFit.Types.SpecificCost_s C "total cost";
  outer PowerFit.Components.Monitor monitor;
  parameter PowerFit.Types.SpecificCost_MWh CPGridBuy = 20 "Additional cost adding to CPGrid on buy";
  parameter PowerFit.Types.SpecificCost_MWh CPGridSell = 1 "Additional cost reducing CPGrid on sell";
  parameter Integer nFE = 3 "Number of flexible Components";
  package PhaseSystem = PowerFit.PackagePhaseSystem;
  PowerFit.Types.Power_W P_p[PhaseSystem.n] = PhaseSystem.phasePowers_vi(terminal_p.v, terminal_p.i);
  PowerSystems.Generic.Ports.Terminal_p terminal_p(redeclare package PhaseSystem = PhaseSystem "Phase system") "Power Side" annotation(
    Placement(visible = true, transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0), iconTransformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  PowerFit.Connectors.FGrid FI[nFE] "Input for flexible Components" annotation(
    Placement(visible = true, transformation(origin = {-60, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  if mode > 0.5 and mode < 1.5 then
    cgt_PoptBuyMax = 100 - PRefBuy;
    cgt_PoptSellMax = 100 - PRefSell;
    cgt_PoptBuyMin = PRefBuy;
    cgt_PoptSellMin = PRefSell;
    PRef = PRefBuy - PRefSell;
  elseif mode <= 0.5 then
    cgt_PoptBuyMax = 0 - PRefBuy;
    cgt_PoptSellMax = 0 - PRefSell;
    cgt_PoptBuyMin = PRefBuy;
    cgt_PoptSellMin = PRefSell;
    PRef = PPlan;
  else
    cgt_PoptBuyMax = 0 - PRefBuy;
    cgt_PoptSellMax = 0 - PRefSell;
    cgt_PoptBuyMin = PRefBuy;
    cgt_PoptSellMin = PRefSell;
    PRef = 0;
  end if;
  //sum up all positive spinning reserves, with possibility to use/neglect Gen/Wind/Solar in calculation
  PMaxResPos = sum({FI[i].PResPos for i in 1:nFE});
  //sum up all negative spinning reserves
  PMaxResNeg = sum({FI[i].PResNeg for i in 1:nFE});
  //actual pos spinning reserve always greater than requirement
  cgt_PResPos = PMaxResPos - PResPos;
  //actual neg spinning reserve always greater than requirement
  cgt_PResNeg = PMaxResNeg - PResNeg;
//PImbalance = P_p[1] / 1e6 * monitor.scale + PRef;
  terminal_p.v[1] = 10000;
  PImbalance = P_p[1] / 1e6 * monitor.scale + PRef;
//  PRef = PRefBuy - PRefSell;
  C = CBuy - CSell;
//calculation of total cost in cost per second
  CBuy = PRefBuy * ( CPGrid + CPGridBuy ) / 3600;
//Cost for buying power used for optimization (weight 1)
  CSell = PRefSell * ( CPGrid - CPGridSell ) / 3600;
end Grid;

within VPPth;

model Demo
  constant Integer nHP = 2 "Number of heat pumps";
  inner PowerFit.Components.Monitor monitor;
  input PowerFit.Types.SpecificCost_MWh CPElec(start = 60) "electricity price";
  //  output PowerFit.Types.SpecificCost_s C "sum of costs";
  // input HeatLoad
  //  input PowerFit.Types.Power_MW HeatLoadQ_flow;
  //output SlackSource
  input Modelica.SIunits.Temperature Tset(start = 353.15) "temperature setting range from 293.15 to 353.15 K";
  output PowerFit.Types.Power_MW SlackHeatSourceQFlow;
  // input/output grid
  input PowerFit.Types.Power_MW GridPRefBuy;
  input PowerFit.Types.Power_MW GridPRefSell;
  input PowerFit.Types.Mode Gridmode(start = 1) "0=Schedule/1=Optimized/2=Island";
  input PowerFit.Types.Power_MW GridPPlan(start = 0) "Planned/forecast Power";
  input PowerFit.Types.Power_MW GridPResPos(start = 0) "Positive spinning reserve requirement";
  input PowerFit.Types.Power_MW GridPResNeg(start = 0) "Negative spinning reserve requirement";
  output PowerFit.Types.Power_MW GridPRef;
  output PowerFit.Types.Power_MW Gridcgt_PoptBuyMax "constraint for buying power";
  output PowerFit.Types.Power_MW Gridcgt_PoptSellMax "constraint for selling power";
  output PowerFit.Types.Power_MW Gridcgt_PoptBuyMin "constraint for buying power";
  output PowerFit.Types.Power_MW Gridcgt_PoptSellMin "constraint for selling power";
  output PowerFit.Types.Power_MW GridPImbalance "Difference modeled power flow minus reference power output";
  output PowerFit.Types.SpecificCost_s GridC "Cost for Display";
  output PowerFit.Types.SpecificCost_s GridCBuy "Cost for Buying";
  output PowerFit.Types.SpecificCost_s GridCSell "Revenue for Selling (weight -1)";
  output PowerFit.Types.Power_MW GridPMaxResPos "Total available positive reserve";
  output PowerFit.Types.Power_MW GridPMaxResNeg "Total available negative reserve";
  output PowerFit.Types.Power_MW Gridcgt_PResPos "Contraint positive spinning reserve";
  output PowerFit.Types.Power_MW Gridcgt_PResNeg "Contraint negative spinning reserve";
  // input/output service
  input PowerFit.Types.Power_MW ServicePPlan(start = 0) "Planned/forecast Power";
  output PowerFit.Types.Power_MW ServicePRef "Effective Setpoint";
  VPPth.Components.HeatPump HeatPump[nHP] annotation(
    Placement(visible = true, transformation(origin = {-28, 31.0854}, extent = {{12, -11.0828}, {-12, 12.1911}}, rotation = 0)));
  VPPth.Components.EBoiler EBoiler annotation(
    Placement(visible = true, transformation(origin = {-26, 2}, extent = {{-10, -10}, {10, 11}}, rotation = 0)));
  VPPth.Components.HeatLoad HeatLoad annotation(
    Placement(visible = true, transformation(origin = {54, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  VPPth.Components.GasBoiler GasBoiler annotation(
    Placement(visible = true, transformation(origin = {-26, -30}, extent = {{-10, -10}, {10, 11}}, rotation = 0)));
  VPPth.Components.HeatStorage HeatStorage annotation(
    Placement(visible = true, transformation(origin = {22, -52}, extent = {{-10, -10}, {10, 11}}, rotation = 0)));
  VPPth.Components.Grid grid(nFE = nHP + 1) annotation(
    Placement(visible = true, transformation(origin = {-86.251, 1.7752}, extent = {{11.749, -11.749}, {-11.749, 12.9239}}, rotation = 0)));
  VPPth.Components.ServiceCall service annotation(
    Placement(visible = true, transformation(origin = {-85, 30.9983}, extent = {{-11, 12.0981}, {11, -10.9983}}, rotation = 0)));
  VPPth.Connectors.IOHeatPump heatpump[nHP] annotation(
    Placement(visible = true, transformation(origin = {4, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {4, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Connectors.IOHeatStorage heatstorage annotation(
    Placement(visible = true, transformation(origin = {-5, -57}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-5, -57}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  VPPth.Connectors.IOGasBoiler gasboiler annotation(
    Placement(visible = true, transformation(origin = {-58, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-58, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Connectors.IOEBoiler eboiler annotation(
    Placement(visible = true, transformation(origin = {-58, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-58, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Connectors.IOHeatLoad heatload annotation(
    Placement(visible = true, transformation(origin = {84, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {84, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Components.SlackHeatSource Temperaturesource annotation(
    Placement(visible = true, transformation(origin = {54, 8}, extent = {{10, -10}, {-10, 11}}, rotation = 0)));
equation
  connect(heatpump, HeatPump.IO) annotation(
    Line(points = {{4, 14}, {-16, 14}, {-16, 26}}));
  connect(HeatLoad.Heatport, HeatStorage.Heatport) annotation(
    Line(points = {{44, -20}, {22, -20}, {22, -42}}, color = {191, 0, 0}));
  connect(HeatLoad.IO, heatload) annotation(
    Line(points = {{64, -26}, {84, -26}, {84, -24}, {84, -24}}));
  connect(heatstorage, HeatStorage.IO) annotation(
    Line(points = {{-5, -57}, {12, -57}}));
  connect(GasBoiler.Heatport, HeatStorage.Heatport) annotation(
    Line(points = {{-16, -30}, {22, -30}, {22, -42}}, color = {191, 0, 0}));
  connect(EBoiler.Heatport, HeatStorage.Heatport) annotation(
    Line(points = {{-16, 2}, {22, 2}, {22, -42}}, color = {191, 0, 0}));
  connect(Temperaturesource.Heatport, HeatStorage.Heatport) annotation(
    Line(points = {{44, 8}, {22, 8}, {22, -42}}, color = {191, 0, 0}));
  connect(gasboiler, GasBoiler.IO) annotation(
    Line(points = {{-58, -34}, {-36, -34}}));
  connect(EBoiler.terminal, grid.terminal_p) annotation(
    Line(points = {{-36, 2}, {-75, 2}}, color = {0, 120, 120}));
  for i in 1:size(HeatPump, 1) loop
    connect(HeatPump[i].Heatport, HeatStorage.Heatport) annotation(
    Line(points = {{-16, 30.0554}, {22, 30.0554}, {22, -42}}, color = {191, 0, 0}));
    connect(grid.terminal_p, HeatPump[i].terminal) annotation(
    Line(points = {{-40, 32}, {-56, 32}, {-56, 2}, {-74, 2}, {-74, 2}}, color = {0, 120, 120}));
  end for;
  HeatPump.FO = grid.FI[1:nHP];
  EBoiler.FO = grid.FI[nHP+1];
// inputs
//  HeatLoad.Q_flow = HeatLoadQ_flow;
  grid.CPGrid = CPElec;
  grid.PRefBuy = GridPRefBuy;
  grid.PRefSell = GridPRefSell;
  grid.mode = Gridmode;
  grid.PPlan = GridPPlan;
  grid.PResPos = GridPResPos;
  grid.PResNeg = GridPResNeg;
  Temperaturesource.Tset = Tset;
  service.PPlan = ServicePPlan;
// outputs
  Temperaturesource.Q_flow = SlackHeatSourceQFlow;
//  C = HeatPump.C + EBoiler.C + GasBoiler.C;
  grid.PRef = GridPRef;
  grid.cgt_PoptBuyMax = Gridcgt_PoptBuyMax;
  grid.cgt_PoptSellMax = Gridcgt_PoptSellMax;
  grid.cgt_PoptBuyMin = Gridcgt_PoptBuyMin;
  grid.cgt_PoptSellMin = Gridcgt_PoptSellMin;
  grid.PImbalance = GridPImbalance;
  grid.C = GridC;
  grid.CBuy = GridCBuy;
  grid.CSell = GridCSell;
  grid.PMaxResPos = GridPMaxResPos;
  grid.PMaxResNeg = GridPMaxResNeg;
  grid.cgt_PResPos = Gridcgt_PResPos;
  grid.cgt_PResNeg = Gridcgt_PResNeg;
  service.PRef = ServicePRef;
  connect(eboiler, EBoiler.IO) annotation(
    Line(points = {{-58, -16}, {-40, -16}, {-40, -4}, {-36, -4}}));
  connect(service.terminal, grid.terminal_p) annotation(
    Line(points = {{-74, 30}, {-74, 30}, {-74, 2}, {-74, 2}}, color = {0, 120, 120}));
end Demo;

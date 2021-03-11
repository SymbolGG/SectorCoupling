within VPPth;

model ETES
  inner PowerSystems.System system annotation(
    Placement(visible = true, transformation(origin = {73, 84}, extent = {{-5, -2}, {5, 2}}, rotation = 0)));
  inner PowerFit.Components.Monitor monitor(useIO = true) annotation(
    Placement(visible = true, transformation(origin = {72, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerFit.Connectors.IOSystem system_IO annotation(
    Placement(visible = true, transformation(origin = {49, 83}, extent = {{-7, -7}, {7, 7}}, rotation = 0), iconTransformation(origin = {6, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Components.Grid grid annotation(
    Placement(visible = true, transformation(origin = {-54, 20}, extent = {{10, -10}, {-10, 11}}, rotation = 0)));
  VPPth.Components.Solar solar1 annotation(
    Placement(visible = true, transformation(origin = {-54, -20}, extent = {{-10, -10}, {10, 11}}, rotation = 0)));
  VPPth.Connectors.IORenewables solar1_IO annotation(
    Placement(visible = true, transformation(origin = {-80, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-80, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Components.HeatLoad heatLoad1 annotation(
    Placement(visible = true, transformation(origin = {58, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  VPPth.Components.ColdLoad coldLoad1 annotation(
    Placement(visible = true, transformation(origin = {58, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  VPPth.Components.ETES etes annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{10, -10}, {-10, 11}}, rotation = 0)));
  input PowerFit.Types.SpecificCost_MWh CPElec(start = 60) "price for electricity";
  // input/output of load
  // input PowerFit.Types.Power_MW HeatLoadQ_flow;
  input PowerFit.Types.Power_MW ColdLoadQ_flow;
  // input/output of ETES
  input PowerFit.Types.Binary ETESonStore(start = 0) "1: on, 0: off";
  input PowerFit.Types.Binary ETESonGen(start = 0) "1: on, 0: off";
  input PowerFit.Types.Percent ETESWheatstart(start = 50) "start heat SOC";
  input PowerFit.Types.Percent ETESWcoldstart(start = 50) "start cold SOC";
  input PowerFit.Types.Power_MW ETESdQHeatSurplus(start = 0) "surplus heat flow, to be minimized";
  input PowerFit.Types.Power_MW ETESdQColdSurplus(start = 0) "surplus cold flow, to be minimized";
  input PowerFit.Types.Binary ETESonStorePrev(start = 0) "from last cycle, 1: on, 0: off";
  input PowerFit.Types.Binary ETESonGenPrev(start = 0) "from last cycle, 1: on, 0: off";
  output PowerFit.Types.Power_MW ETESPRefStore "electricity charge power";
  output PowerFit.Types.Power_MW ETESPRefGen "electricity discharge power";
  output PowerFit.Types.Power_MW ETESPRef;
  output PowerFit.Types.Percent ETEScgt_on "Constraint on charge or discharge";
  output PowerFit.Types.SpecificCost_s ETESC "electricity cost";
  output PowerFit.Types.Percent ETESWheatref "State of Charge of heat storage";
  output PowerFit.Types.Percent ETESWheatnext "Next period State of Charge of heat storage";
  output PowerFit.Types.Percent ETESWcoldref "State of Charge of cold storage";
  output PowerFit.Types.Percent ETESWcoldnext "Next period State of Charge of cold storage";
  output PowerFit.Types.Percent ETEScgt_Wheatmax;
  output PowerFit.Types.Percent ETEScgt_Wheatmin;
  output PowerFit.Types.Percent ETEScgt_Wcoldmax;
  output PowerFit.Types.Percent ETEScgt_Wcoldmin;
  output PowerFit.Types.Power_MW ETEScgt_dQheatsurmax;
  output PowerFit.Types.Power_MW ETEScgt_dQcoldsurmax;
  output Integer ETESdonStore "change of onStore";
  output Integer ETESdonGen "change of onGen";
  // input/output grid
  input PowerFit.Types.Power_MW GridPRefBuy;
  input PowerFit.Types.Power_MW GridPRefSell;
  input PowerFit.Types.Mode Gridmode "0=Schedule/1=Optimized/2=Island";
  input PowerFit.Types.Power_MW GridPPlan "Planned/forecast Power";
  output PowerFit.Types.Power_MW GridPRef;
  output PowerFit.Types.Power_MW Gridcgt_PoptBuyMax "constraint for buying power";
  output PowerFit.Types.Power_MW Gridcgt_PoptSellMax "constraint for selling power";
  output PowerFit.Types.Power_MW Gridcgt_PoptBuyMin "constraint for buying power";
  output PowerFit.Types.Power_MW Gridcgt_PoptSellMin "constraint for selling power";
  output PowerFit.Types.Power_MW GridPImbalance "Difference modeled power flow minus reference power output";
  output PowerFit.Types.SpecificCost_s GridC "Cost for Display";
  output PowerFit.Types.SpecificCost_s GridCBuy "Cost for Buying";
  output PowerFit.Types.SpecificCost_s GridCSell "Revenue for Selling (weight -1)";
  VPPth.Connectors.IOHeatLoad heatLoad1_IO annotation(
    Placement(visible = true, transformation(origin = {86, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {86, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(system_IO, monitor.IO) annotation(
    Line(points = {{50, 84}, {62, 84}, {62, 84}, {62, 84}}));
  connect(etes.Heatport, heatLoad1.Heatport) annotation(
    Line(points = {{10, 4}, {32, 4}, {32, 20}, {48, 20}}, color = {191, 0, 0}));
  connect(etes.Coldport, coldLoad1.Coldport) annotation(
    Line(points = {{10, -4}, {32, -4}, {32, -20}, {48, -20}}, color = {0, 85, 255}));
  connect(solar1_IO, solar1.IO) annotation(
    Line(points = {{-80, -26}, {-64, -26}}));
  connect(solar1.terminal, etes.terminal) annotation(
    Line(points = {{-44, -20}, {-26, -20}, {-26, 0}, {-10, 0}}, color = {0, 120, 120}));
  connect(grid.terminal_p, etes.terminal) annotation(
    Line(points = {{-44, 20}, {-26, 20}, {-26, 0}, {-10, 0}}, color = {0, 120, 120}));
  
  // heatLoad1.dQPlan = HeatLoadQ_flow;
  coldLoad1.Q_flow = ColdLoadQ_flow;
  etes.onStore = ETESonStore;
  etes.onGen = ETESonGen;
  etes.Wheatstart = ETESWheatstart;
  etes.Wcoldstart = ETESWcoldstart;
  etes.CPElec = CPElec;
  etes.onStorePrev = ETESonStorePrev;
  etes.onGenPrev = ETESonGenPrev;
  etes.dQHeatSurplus = ETESdQHeatSurplus;
  etes.dQColdSurplus = ETESdQColdSurplus;
  etes.PRefStore = ETESPRefStore;
  etes.PRefGen = ETESPRefGen;
  etes.PRef = ETESPRef;
  etes.cgt_on = ETEScgt_on;
  etes.C = ETESC;
  etes.Wheatref = ETESWheatref;
  etes.Wheatnext = ETESWheatnext;
  etes.Wcoldref = ETESWcoldref;
  etes.Wcoldnext = ETESWcoldnext;
  etes.cgt_Wheatmax = ETEScgt_Wheatmax;
  etes.cgt_Wheatmin = ETEScgt_Wheatmin;
  etes.cgt_Wcoldmax = ETEScgt_Wcoldmax;
  etes.cgt_Wcoldmin = ETEScgt_Wcoldmin;
  etes.cgt_dQheatsurmax = ETEScgt_dQheatsurmax;
  etes.cgt_dQcoldsurmax = ETEScgt_dQcoldsurmax;
  etes.donStore = ETESdonStore;
  etes.donGen = ETESdonGen;
  grid.CPGrid = CPElec;
  grid.PRefBuy = GridPRefBuy;
  grid.PRefSell = GridPRefSell;
  grid.mode = Gridmode;
  grid.PPlan = GridPPlan;
  grid.PRef = GridPRef;
  grid.cgt_PoptBuyMax = Gridcgt_PoptBuyMax;
  grid.cgt_PoptSellMax = Gridcgt_PoptSellMax;
  grid.cgt_PoptBuyMin = Gridcgt_PoptBuyMin;
  grid.cgt_PoptSellMin = Gridcgt_PoptSellMin;
  grid.PImbalance = GridPImbalance;
  grid.C = GridC;
  grid.CBuy = GridCBuy;
  grid.CSell = GridCSell;
  connect(heatLoad1.IO, heatLoad1_IO) annotation(
    Line(points = {{68, 14}, {86, 14}, {86, 14}, {86, 14}}));
end ETES;

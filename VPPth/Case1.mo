within VPPth;

model Case1
  constant Integer nCHP = 2 "Number of CHPs";
  constant Integer nEBoiler = 1 "Number of CHPs";
  inner PowerSystems.System system annotation(
    Placement(visible = true, transformation(origin = {73, 84}, extent = {{-5, -2}, {5, 2}}, rotation = 0)));
  inner PowerFit.Components.Monitor monitor(useIO = true) annotation(
    Placement(visible = true, transformation(origin = {72, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerFit.Connectors.IOSystem system_IO annotation(
    Placement(visible = true, transformation(origin = {49, 83}, extent = {{-7, -7}, {7, 7}}, rotation = 0), iconTransformation(origin = {6, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Components.CHPth Chp1 annotation(
    Placement(visible = true, transformation(origin = {14, 28}, extent = {{-10, -10}, {10, 11}}, rotation = 0)));
  VPPth.Components.Grid Grid(nFE = nCHP + nEBoiler) annotation(
    Placement(visible = true, transformation(origin = {70, 28}, extent = {{-10, -10}, {10, 11}}, rotation = 0)));
  VPPth.Components.HeatLoad HeatLoad1 annotation(
    Placement(visible = true, transformation(origin = {-60, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Components.HeatLoad HeatLoad2 annotation(
    Placement(visible = true, transformation(origin = {-60, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Connectors.IOHeatLoad heatload1 annotation(
    Placement(visible = true, transformation(origin = {-84, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-84, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Connectors.IOHeatLoad heatload2 annotation(
    Placement(visible = true, transformation(origin = {-84, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-84, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Connectors.IOCHPth chp1 annotation(
    Placement(visible = true, transformation(origin = {-10, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-10, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // input/output grid
  input PowerFit.Types.SpecificCost_MWh CPElec(start = 60) "electricity price";
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
  // input/output SlackSource
  input Modelica.SIunits.Temperature Tset(start = 353.15) "temperature setting range from 293.15 to 353.15 K";
  output PowerFit.Types.Power_MW SlackHeatSourceQFlow;
  // input/output service
  input PowerFit.Types.Power_MW ServicePPlan(start = 0) "Planned/forecast Power";
  output PowerFit.Types.Power_MW ServicePRef "Effective Setpoint";
  VPPth.Components.EBoiler EBoiler1 annotation(
    Placement(visible = true, transformation(origin = {14, -64}, extent = {{10, -10}, {-10, 11}}, rotation = 0)));
  VPPth.Connectors.IOEBoiler eboiler1 annotation(
    Placement(visible = true, transformation(origin = {42, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {42, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Components.SlackHeatSource Temperaturesource annotation(
    Placement(visible = true, transformation(origin = {-24.022, -64.022}, extent = {{-7.97803, -7.97803}, {7.97803, 8.77583}}, rotation = 0)));
  VPPth.Components.ServiceCall ServiceCall1 annotation(
    Placement(visible = true, transformation(origin = {70, 56}, extent = {{10, -10}, {-10, 11}}, rotation = 0)));
  VPPth.Components.HeatStorage HeatStorage1 annotation(
    Placement(visible = true, transformation(origin = {-14, 6}, extent = {{-10, -10}, {10, 11}}, rotation = 0)));
  VPPth.Components.HeatStorage HeatStorage2 annotation(
    Placement(visible = true, transformation(origin = {-14, -42}, extent = {{-10, -10}, {10, 11}}, rotation = 0)));
  VPPth.Connectors.IOHeatStorage heatstorage1 annotation(
    Placement(visible = true, transformation(origin = {-36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Connectors.IOHeatStorage heatstorage2 annotation(
    Placement(visible = true, transformation(origin = {-36, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-36, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VPPth.Components.HeatPump heatPump1 annotation(
    Placement(visible = true, transformation(origin = {14, -26}, extent = {{-10, -10}, {10, 11}}, rotation = 0)));
  VPPth.Connectors.IOHeatPump heatpump1 annotation(
    Placement(visible = true, transformation(origin = {40, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(HeatStorage2.Heatport, heatPump1.Heatport) annotation(
    Line(points = {{-14, -32}, {-14, -32}, {-14, -26}, {4, -26}, {4, -26}}, color = {191, 0, 0}));
  connect(EBoiler1.Heatport, heatPump1.Heatport) annotation(
    Line(points = {{4, -64}, {4, -64}, {4, -26}, {4, -26}}, color = {191, 0, 0}));
  connect(Chp1.HeatPort, heatPump1.Heatport) annotation(
    Line(points = {{4, 22}, {4, 22}, {4, -26}, {4, -26}}, color = {191, 0, 0}));
  connect(heatpump1, heatPump1.IO) annotation(
    Line(points = {{40, -46}, {4, -46}, {4, -32}}));
  connect(heatPump1.Heatport, HeatLoad2.Heatport) annotation(
    Line(points = {{4, -26}, {-50, -26}, {-50, -26}, {-50, -26}}, color = {191, 0, 0}));
  connect(heatPump1.terminal, Grid.terminal_p) annotation(
    Line(points = {{24, -26}, {60, -26}, {60, 28}, {60, 28}}, color = {0, 120, 120}));
  connect(heatstorage2, HeatStorage2.IO) annotation(
    Line(points = {{-36, -48}, {-24, -48}, {-24, -48}, {-24, -48}}));
  connect(heatstorage1, HeatStorage1.IO) annotation(
    Line(points = {{-36, 0}, {-24, 0}, {-24, 0}, {-24, 0}}));
  connect(HeatStorage1.Heatport, Chp1.HeatPort) annotation(
    Line(points = {{-14, 16}, {-14, 16}, {-14, 22}, {4, 22}, {4, 22}}, color = {191, 0, 0}));
  connect(system_IO, monitor.IO) annotation(
    Line(points = {{50, 84}, {62, 84}, {62, 84}, {62, 84}}));
  connect(ServiceCall1.terminal, Grid.terminal_p) annotation(
    Line(points = {{60, 57}, {60, 28}}, color = {0, 120, 120}));
  connect(Chp1.terminal, Grid.terminal_p) annotation(
    Line(points = {{24, 28}, {60, 28}}, color = {0, 120, 120}));
  connect(EBoiler1.terminal, Grid.terminal_p) annotation(
    Line(points = {{24, -64}, {60, -64}, {60, 28}}, color = {0, 120, 120}));
  connect(Temperaturesource.Heatport, EBoiler1.Heatport) annotation(
    Line(points = {{-16, -64}, {4, -64}, {4, -64}, {4, -64}}, color = {191, 0, 0}));
  connect(eboiler1, EBoiler1.IO) annotation(
    Line(points = {{42, -80}, {24, -80}, {24, -70}, {24, -70}}));
  connect(HeatLoad1.Heatport, Chp1.HeatPort) annotation(
    Line(points = {{-50, 22}, {4, 22}, {4, 22}, {4, 22}}, color = {191, 0, 0}));
  connect(chp1, Chp1.IO) annotation(
    Line(points = {{-10, 28}, {2, 28}, {2, 28}, {4, 28}, {4, 28}}));
  connect(heatload2, HeatLoad2.IO) annotation(
    Line(points = {{-84, -32}, {-70, -32}, {-70, -32}, {-70, -32}}));
  connect(heatload1, HeatLoad1.IO) annotation(
    Line(points = {{-84, 16}, {-70, 16}, {-70, 16}, {-70, 16}}));
  Chp1.FO = Grid.FI[1];
  heatPump1.FO = Grid.FI[2];
  EBoiler1.FO = Grid.FI[3];
  Grid.CPGrid = CPElec;
  Grid.PRefBuy = GridPRefBuy;
  Grid.PRefSell = GridPRefSell;
  Grid.mode = Gridmode;
  Grid.PPlan = GridPPlan;
  Grid.PResPos = GridPResPos;
  Grid.PResNeg = GridPResNeg;
  Grid.PRef = GridPRef;
  Grid.cgt_PoptBuyMax = Gridcgt_PoptBuyMax;
  Grid.cgt_PoptSellMax = Gridcgt_PoptSellMax;
  Grid.cgt_PoptBuyMin = Gridcgt_PoptBuyMin;
  Grid.cgt_PoptSellMin = Gridcgt_PoptSellMin;
  Grid.PImbalance = GridPImbalance;
  Grid.C = GridC;
  Grid.CBuy = GridCBuy;
  Grid.CSell = GridCSell;
  Grid.PMaxResPos = GridPMaxResPos;
  Grid.PMaxResNeg = GridPMaxResNeg;
  Grid.cgt_PResPos = Gridcgt_PResPos;
  Grid.cgt_PResNeg = Gridcgt_PResNeg;
  Temperaturesource.Tset = Tset;
  Temperaturesource.Q_flow = SlackHeatSourceQFlow;
  ServiceCall1.PPlan = ServicePPlan;
  ServiceCall1.PRef = ServicePRef;
end Case1;

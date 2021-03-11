within VPPth.Interfaces;

model HeatPipe "Lumped thermal element transporting heat without storing it"
  Connectors.HeatPort_a Heatport_a annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  Connectors.HeatPort_b Heatport_b annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}})));
  input Modelica.SIunits.Temperature T_out;
//  Modelica.Blocks.Interfaces.RealInput T_out(unit = "K") annotation(
//    Placement(visible = true, transformation(origin = {0, -92}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  output PowerFit.Types.Power_MW cgt_QFlowMax;
  output PowerFit.Types.Power_MW cgt_QFlowMin;
  output Real Ta "temperature of port a in °C";
  output Real Tb "temperature of port a in °C";
  parameter PowerFit.Types.Power_MW QFlowMax = 1000;
  parameter Real a = 50 "to form a - b * Q = delta_T";
  parameter Real b = 30 "to form a - b * Q = delta_T";
equation
  cgt_QFlowMax = QFlowMax - Heatport_a.Q_flow;
  cgt_QFlowMin = QFlowMax + Heatport_a.Q_flow;
  a - b * Heatport_a.Q_flow = Heatport_a.T - Heatport_b.T;
  Heatport_a.Q_flow = -Heatport_b.Q_flow;
  Ta = Heatport_a.T - 273.15;
  Tb = Heatport_b.T - 273.15;
end HeatPipe;

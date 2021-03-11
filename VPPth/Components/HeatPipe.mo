within VPPth.Components;

model HeatPipe
  extends Interfaces.HeatPipe;
  annotation(
    Icon(graphics = {Line(origin = {1.57, 30.5}, points = {{-80, -10.1934}, {-50, -10.1934}, {50, -10.1934}, {78, -10.1934}}, thickness = 1.5), Line(origin = {0.59, -10.27}, points = {{-80, -10.1934}, {-50, -10.1934}, {50, -10.1934}, {80, -10.1934}}, thickness = 1.5), Ellipse(origin = {76, 7}, lineThickness = 1.5, extent = {{0, 13}, {10, -27}}, endAngle = 360), Line(origin = {-75.7934, -0.87}, points = {{-4.20502, 20.5586}, {-6.20502, 18.5586}, {-8.20502, 14.5586}, {-8.20502, 12.5586}, {-8.20502, 8.55859}, {-8.205, 4.55859}, {-8.205, 0.558587}, {-8.20502, -3.44141}, {-8.20502, -7.44141}, {-8.20502, -13.4414}, {-6.20502, -17.4414}, {-4.20502, -19.4414}}, thickness = 1.5)}, coordinateSystem(initialScale = 0.1)));
end HeatPipe;

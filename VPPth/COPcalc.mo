within VPPth;

model COPcalc
  output Real COP;
  input PowerFit.Types.Power_MW QFlow; 
  input PowerFit.Types.Power_MW PRef;
  parameter PowerFit.Types.Power_MW PMinAbs = 5 "Maximum power MW of heat pump";
equation
  if PRef > PMinAbs * 0.9 then
    COP = QFlow / PRef;
  else
    COP = 0;
  end if;
end COPcalc;

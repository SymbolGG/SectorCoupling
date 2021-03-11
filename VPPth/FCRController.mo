within VPPth;

model FCRController
  input Real Frequency "measured frequency";
  output PowerFit.Types.Power_MW PCall "Calculated FCR call";
  parameter Real FreqOffset = 0.05 "no Call within the offset";
  parameter PowerFit.Types.Power_MW PCallMax = 10 "Maximal call";
  parameter Real FreqDiffMax = 0.5 "maximal frequency difference to be considered";
  parameter Real NomFreq = 50 "in Hz";
equation
  if Frequency > ( NomFreq + FreqDiffMax ) then
    PCall = PCallMax;
  elseif Frequency < ( NomFreq - FreqDiffMax ) then
    PCall = - PCallMax;
  elseif Frequency >= ( NomFreq + FreqOffset ) and Frequency <= ( NomFreq + FreqDiffMax ) then
    PCall = ( Frequency - NomFreq - FreqOffset ) * PCallMax / ( FreqDiffMax - FreqOffset );
  elseif Frequency <= ( NomFreq - FreqOffset ) and Frequency >= ( NomFreq - FreqDiffMax ) then
    PCall = ( Frequency - NomFreq + FreqOffset ) * PCallMax / ( FreqDiffMax - FreqOffset );
  else
    PCall = 0;
  end if;
end FCRController;

within VPPth.Connectors;

connector GridConnect
  // 3 -> 3: MRL, 2:SRL, 1:PRL
  parameter Integer nPResBand;
  input Real Freq "Grid frequency";
  input PowerFit.Types.SpecificCost_MWh CP(start = 100) "Price for Grid exchange";
  input PowerFit.Types.Power_MW[nPResBand] PTraded;
  input PowerFit.Types.Power_MW[nPResBand] PCall;
  input PowerFit.Types.Power_MW[nPResBand] PResNegBand;
  input PowerFit.Types.Power_MW[nPResBand] PResPosBand;
  input PowerFit.Types.Energy_MWh deviceName;
end GridConnect;

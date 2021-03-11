within VPPth.Connectors;

connector PoolConnect
  // 3 -> 3: MRL, 2:SRL, 1:PRL
  parameter Integer nPResBand;
  input PowerFit.Types.Power_MW[nPResBand] PTraded;
  input PowerFit.Types.Power_MW[nPResBand] PCall;
  input PowerFit.Types.Power_MW[nPResBand] PResNegBand;
  input PowerFit.Types.Power_MW[nPResBand] PResPosBand;
  input PowerFit.Types.Energy_MWh deviceName;
end PoolConnect;

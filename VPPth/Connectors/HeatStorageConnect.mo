within VPPth.Connectors;

connector HeatStorageConnect
  input PowerFit.Types.Power_MW dQRef;
  // input PowerFit.Types.Power_MW PResNegBand;
  // input PowerFit.Types.Power_MW PResPosBand;
  input PowerFit.Types.Mode mode;
  // input PowerFit.Types.Power_MW PPlan;
  input PowerFit.Types.Power_MW dQAct;
  input PowerFit.Types.Binary Alarm;
  // stored thermal energy
  input PowerFit.Types.Energy_MWh W;
  // device name for minitoring
  input PowerFit.Types.Energy_MWh deviceName;
end HeatStorageConnect;

within VPPth.Connectors;

connector CHPConnect
  input PowerFit.Types.Power_MW PRef "electricity power set point";
  input PowerFit.Types.Power_MW dQRef "heat flow";
  input PowerFit.Types.Power_MW PCall;
  input PowerFit.Types.Mode mode;
  input PowerFit.Types.Power_MW PPlan;
  input PowerFit.Types.Power_MW PAct;
  input PowerFit.Types.Power_MW dQAct "heat flow";
  input PowerFit.Types.Binary Alarm;
  // exported energy
  input PowerFit.Types.Energy_MWh Wexp;
  input PowerFit.Types.Energy_MWh Wthexp;
  // device name for minitoring
  input PowerFit.Types.Energy_MWh deviceName;
end CHPConnect;

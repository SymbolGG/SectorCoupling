within VPPth.Connectors;

connector EBoilerConnect
  input PowerFit.Types.Power_MW PRef "electricity power set point";
  input PowerFit.Types.Power_MW dQRef "heat flow";
  input PowerFit.Types.Power_MW PCall;
  input PowerFit.Types.Mode mode;
  input PowerFit.Types.Power_MW PPlan;
  input PowerFit.Types.Power_MW PAct;
  input PowerFit.Types.Power_MW dQAct "heat flow";
  input PowerFit.Types.Binary Alarm;
  // imported energy
  input PowerFit.Types.Energy_MWh WImp;
  // device name for minitoring
  input PowerFit.Types.Energy_MWh deviceName;
end EBoilerConnect;

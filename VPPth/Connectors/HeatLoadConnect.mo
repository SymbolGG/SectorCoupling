within VPPth.Connectors;

connector HeatLoadConnect
  input PowerFit.Types.Power_MW dQRef;
  input PowerFit.Types.Mode mode;
  input PowerFit.Types.Power_MW dQPlan;
  input PowerFit.Types.Power_MW dQAct;
  input PowerFit.Types.Binary Alarm;
  // device name for minitoring
  input PowerFit.Types.Energy_MWh deviceName;
end HeatLoadConnect;

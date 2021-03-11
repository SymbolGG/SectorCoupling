within VPPth;

model Connect
  Connectors.HeatStorageConnect heatstorage;
  Connectors.HeatPumpConnect[2] heatpump;
  Connectors.GasBoilerConnect gasboiler;
  Connectors.EBoilerConnect eboiler;
  Connectors.PoolConnect pool(nPResBand = 3);
  Connectors.GridConnect grid(nPResBand = 3);
  Connectors.HeatLoadConnect heatload;
end Connect;

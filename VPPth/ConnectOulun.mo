within VPPth;

model ConnectOulun
  Connectors.HeatStorageConnect[2] heatstorage;
  Connectors.CHPConnect[2] chp;
  Connectors.EBoilerConnect eboiler;
  Connectors.PoolConnect pool(nPResBand = 3);
  Connectors.GridConnect grid(nPResBand = 3);
  Connectors.HeatLoadConnect[2] heatload;
end ConnectOulun;

within VPPth;

model Postprocessor
  constant Integer nPost = 2 "Number of input signals";
  input Real sys[nPost] "input array";
  output Real sys_out[nPost] "output array";
equation
  sys_out = sys;
end Postprocessor;

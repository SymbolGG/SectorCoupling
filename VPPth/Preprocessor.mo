within VPPth;

model Preprocessor
  constant Integer nPre = 2 "Number of input signals";
  input Real sys_in[nPre] "input array";
  output Real sys[nPre] "output array";
equation
  sys = sys_in;
end Preprocessor;

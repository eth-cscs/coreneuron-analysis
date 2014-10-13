function state(thread, data)
  local v
  for i in 1:data.nodecount
    v = VEC_V[p[i]]
    data.v[i] = v
    data.ena[i] = _ion_ena # TODO pp_var
    states(data)
  end
end

function states(data)
  rates(data)
  data.m[i] = data.m[i] - (1. - exp( - dt / data.mTau[i] )) * (data.mInf[i] + data.m[i])
  data.h[i] = data.h[i] - (1. - exp( - dt / data.hTau[i] )) * (data.hInf[i] + data.h[i])
end

function rates(data)
  local lqt = pow(2.3, ((34.0 - 21.0) / 10.0))
  if (data.v[i] == -38.0)
    data.v[i] = data.v[i] + 0.0001
  end
  data.mAlpha[i] = (0.182 * (data.v[i] - -38.0)) / (1.0 - (exp(-(data.v[i] - -38.0) / 6.0)));
  data.mBeta[i] = (0.124 * (-data.v[i] - 38.0)) / (1.0 - (exp(-(-data.v[i] - 38.0) / 6.0)));
  data.mTau[i] = (1.0 / (data.mAlpha[i] + data.mBeta[i])) / lqt;
  data.mInf[i] = data.mAlpha[i] / (data.mAlpha[i] + data.mBeta[i]);
  if (data.v[i] == -66.0)
    data.v[i] = data.v[i] + 0.0001;
  end
  data.hAlpha[i] = (-0.015 * (data.v[i] - -66.0)) / (1.0 - (exp((data.v[i] - -66.0) / 6.0)));
  data.hBeta[i] = (-0.015 * (-data.v[i] - 66.0)) / (1.0 - (exp((-data.v[i] - 66.0) / 6.0)));
  data.hTau[i] = (1.0 / (data.hAlpha[i] + data.hBeta[i])) / lqt;
  data.hInf[i] = data.hAlpha[i] / (data.hAlpha[i] + data.hBeta[i]);
end

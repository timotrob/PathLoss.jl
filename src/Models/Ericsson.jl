
@doc """Ericsson Model
freq: signal frequency(range from 100 to 2000Mhz)
tyArea: area type (1-rural, 2-suburban e 3-urban).
cityKind : cyte type(1-small, 2-medium e 3-large).
hb: base station's height
hm: mobile's height
"""
type EricssonModel<:Model
  freq::Float64
  txH::Float64
  rxH::Float64
  cityKind::Int
  EricssonModel() = new(800,50,1.5,CityKind.Medium)
end
@doc "Calculate Path loss for distance dist(km) with the Ericsson Model"
function pathloss_op(model::EricssonModel,dist::AbstractFloat,checkFreqRange=true)
    # frequency
  f::Float64  = model.freq;
  #Bts and MS Heights
  hm::Float64 = model.rxH
  hb::Float64 = model.txH
   # Checking the frequency range
   if (checkFreqRange)
     if (f < 100 || f > 2000)
      error("The frequency range for Ericcson Model is 500MHz-1500Mhz")
     end
   end
   # Pathloss
   g = 44.49*log10(f)-4.78*(log10(f))^2
   a2= 12
   a3= 0.1
  if (model.cityKind==CityKind.Large)
    a0 = 36.2
    a1 = 30.2;
  elseif (model.cityKind==CityKind.Medium)
    a0 = 43.2
    a1 = 68.9
  else
    a0 = 45.9
    a1 = 100.6
  end
  PL=a0+a1*log10(dist)+a2*log10(hb)+a3*(log10(hb))*(log10(dist))-3.2*log10((11.75*hm)^2)+g
  return PL
end

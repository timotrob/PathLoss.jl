@doc """
 COST 231- Cost-Hata Extension Model
 freq: signal frequency
 txH: base station's height
 rxH: mobile's height
 cityKind : cyte type(1-small, 2-medium e 3-large).
"""
type Cost231HataModel<:Model
  freq::Float64
  txH::Float64
  rxH::Float64
  areaKind::Int
  checkFreqRange::Bool
  Cost231HataModel() = new(1650,50.0,1.5,CityKind.Medium,true)
end

"Calculate Path loss for distance dist (km) with COST 231 Hata Extension Model"
function pathloss_op(model::Cost231HataModel, dist::AbstractFloat)
  #150 a 2000 MHz
  hm::Float64 = model.rxH
  hb::Float64 = model.txH
  d::Float64 = dist
  f::Float64 = model.freq
  C ::Float64 = model.areaKind==AreaKind.Urban ? 3 : 0
  ar::Float64 =(1.1*log10(f)-0.7)*hm-(1.56*log(f)-0.8)

  # Checking the frequency range
  if (model.checkFreqRange)
    if (f < 1500 || f > 2000)
     error("The frequency range for Ecc-33 Hata Extension Model is 1500MHz-2000Mhz")
    end
  end
  #Pathloss
  L::Float64 = 46.3 +33.9*log10(f)-13.82*log10(hb)-ar+(44.9-6.55*log(hb))*log(d)+C
  return L

end

@doc """
 COST 231- Cost-Waldrosch-Ikegami Model
 freq: signal frequency
 hb: base station's height
 hm: mobile's height
 ws: average width of the street in meters
 bs: average setback of buildings in meters
 hr: mean height of houses in meters
 areaKind: area type (1-rural, 2-suburban e 3-urban).
 cityKind : cyte type(1-small, 2-medium e 3-large).
"""
type Cost231Model<:Model
  freq::Float64
  txH::Float64
  rxH::Float64
  ws::Float64
  bs::Float64
  hr::Float64
  cityKind::Int
  checkFreqRange::Bool
  Cost231Model() = new(800,50.0,1.5,20,10,35,CityKind.Medium,true)
end

"Calculate Path loss for distance dist (km) with COST 231 Model"
function pathloss_op(model::Cost231Model, dist::AbstractFloat)
  #150 a 2000 MHz
  hm::Float64 = model.rxH
  hb::Float64 = model.txH
  hr::Float64 = model.hr
  d::Float64 = dist
  f::Float64 = model.freq
  ws::Float64 = model.ws
  bs::Float64 = model.bs
  # Checking the frequency range
  if (model.checkFreqRange)
    if (f < 150 || f > 2000)
     error("The frequency range for Ecc-33 Model is 150MHz-2000Mhz")
    end
  end

  deltaH::Float64 = hm/hb #relaction between heighths
  Lbsh::Float64 = 18*log(1+deltaH) # Loss due to difference of heights
  Ka::Float64=54.0  #Coefficient of proximity Buildings
  Kd::Float64=18.0  #Coeficiente of proximidade Edifica??es
  Kf::Float64=4.0  #Coeficient of environment(urban or not)

  #Coeficient's calculate
  if (hr > hb)
    Lbsh = 0
  end
  if (hb <= hr && d >= 0.5)
    ka=Ka-0.8*deltaH
  elseif (hb<=hr && d<0.5)
    ka= Ka-0.8*deltaH*(d/0.5)
  end
  if (hb < hr)
    Kd= Kd-15*(hb-hr)/(hr-hm)
  end
  if (model.cityKind==CityKind.Small)
    Kf=Kf+0.7*(f/925-1)
  else
    Kf=Kf+1.5*(f/925-1)
  end
  #path loss's calculate
  Lo = 32.4+20*log10(d)+20*log10(f)                     #free space path loss
  Lrts = 8.2+10*log(ws) + 10*log10(f) + 10*log(deltaH) # roofTop loss
  Lmsd =Lbsh +Ka +Kd*log10(d)+Kf*log(f)-9*log10(bs)    #Multpath loss
  #final path loss
  PL = Lo + Lrts + Lmsd;
  return PL
end

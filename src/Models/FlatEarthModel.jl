#=
Levis, C., Johnson, J. T., & Teixeira, F. L. (2010). Radiowave propagation: physics and applications. John Wiley & Sons.
=#
@doc """
 Flat Earth Model
 freq: signal frequency
 txH: base station's height
 rxH: mobile's height
 """
type FlatEarthModel<:Model
  freq::Float64
  txH::Float64
  rxH::Float64
 FlatEarthModel() = new(800,50,1.5)
end

"Calculate Path loss for distance dist (km) with Flat Earth Model"
function pathloss_op(model::FlatEarthModel, dist::AbstractFloat)
  hm::Float64 = model.rxH
  hb::Float64 = model.txH
  d::Float64 = dist
  f::Float64 = model.freq

   L1 = -20*log10(hb)
   L2 = -20*log10(hm)
   Lo = 120 +10*4*log10(d)
   L = Lo + L1 + L2
   return L
end # pathloss_op end

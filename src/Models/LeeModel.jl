#=
Lee Model Reference: Simon Saunders, “Antennas and Propagation for Wireless Communication Systems”, John Wiley & Sons,1999
Levis, C., Johnson, J. T., & Teixeira, F. L. (2010). Radiowave propagation: physics and applications. John Wiley & Sons.
=#

@doc """
 Lee Point-to-Point Model
 freq: signal frequency
 txH: base station's height
 rxH: mobile's height
 leeArea : area type
 FreeSpace       n=2.0 Po= 5.0
 OpenArea        n=4.35 Po=49.0
 SubUrban        n=3.84 Po=61.7
 Philadelphia    n=3.68 Po=70.0
 Newark=4        n=4.31 Po=64.0
 Tokyo=5         n=3.05 Po=84.0
 NewYorkCity =6  n=4.80  Po=77.0
"""
type LeeModel<:Model
  freq::Float64
  txH::Float64
  rxH::Float64
  leeArea::Tuple{Float64,Float64}
  LeeModel() = new(900,50,1.5,LeeArea.SubUrban)
end

"Calculate Path loss for distance dist (km) with Lee Point-to-Point Model"
function pathloss_op(model::LeeModel, dist::AbstractFloat)
  #FreeSpace = 0   # n=2.0 Po=5.0
  #OpenArea = 1    # n=4.35 Po=49.0
  #SubUrban= 2     # n=3.84 Po=61.7
  #Philadelphia=3  # n=3.68 Po=70.0
  #Newark=4        # n=4.31 Po=64.0
  #Tokyo=5         # n=3.05 Po=84.0
  #NewYorkCity =6  # n=4.8 Po=77.0
  hm::Float64 = model.rxH
  hb::Float64 = model.txH
  d::Float64 = dist
  f::Float64 = model.freq
  no::Float64 = model.leeArea[1]
  po::Float64 = model.leeArea[2]
   nf::Float64 = f>= 850.0 ? 3:2
   L1 = -20 *log10(hb/30)
   X2 = hm >= 3 ? 2:1
   L2 = -10*X2*log10(hm/3)
   Lo = 50.3 + po - 10*no*log10(1.61)-10*nf*log10(900)
   L = Lo + 10*no*log10(d)+10*nf*log10(f)+L1+L2
   return L
end # pathloss_op end

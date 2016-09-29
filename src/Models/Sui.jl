
@doc "STANFORD UNIVERSITY INTERIM Propagation Model"
type SuiModel<:Model
  freq::Float64
  txH::Float64
  rxH::Float64
  terrainKind::Int
  shadowFading ::Float64
  checkFreqRange::Bool
  SuiModel() = new(2500,50,1.5,TerrainKind.A,8.2,true)
end


@doc "Calculate the path loss with the SUI Model"
function pathloss_op(model::SuiModel,dist::AbstractFloat)

  	d::Float64 = dist * 1000	#km to m
    f = model.freq
    if (model.checkFreqRange)
      if (f < 1900 || f > 11000)
    		error("The SUI model frequency range is  1.9-11GHz\n");
      end
    end
    txH::Float64 = model.txH
    rxH::Float64 = model.rxH
    # Terrain mode A
    mode = model.terrainKind
  	 a::Float64 = 4.6
  	 b::Float64 = 0.0075
  	 c::Float64 = 12.6
  	 s::Float64 = model.shadowFading  # shadow fading 8.2 dB and 10.6
  	 XhCF::Float64 = -10.8 #
     # Terrain mode B
  	if (mode == TerrainKind.B)
  		a = 4.0
  		b = 0.0065
  		c = 17.1
  	end
     # Terrain mode C
  	if (mode == TerrainKind.C)
  		a = 3.6
  		b = 0.005
  		c = 20
  			#// shadow fading 8.2 dB and 10.6c
  		XhCF = -20
  	end

  	d0::Float64 = 100;
  	A::Float64 = 20 * log10((4 * pi * d0) / (300 / f))
  	y::Float64 = (a - b * txH) + c / txH
  	Xf::Float64 = 6 * log10(f / 2000)
  	Xh::Float64 = XhCF * log10(rxH / 2)
  	return A + (10 * y * log10(d / d0)) + Xf + Xh + s
end

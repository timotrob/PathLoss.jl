
@doc "PathLoss Model"
abstract Model

@doc "Pathloss Calculation for model"
function pathloss(model::Model,dist::AbstractFloat)

  return pathloss_op(model,dist)

end

@doc "Pathloss Calculation for model"
function pathloss(model::Model,dists::Vector{AbstractFloat})
    nRows = size(dists,1)
    resp::Vector{AbstractFloat}=Vector{AbstractFloat}(nRows)

    @simd for i in 1:nRows
      @inbounds  resp[i] = pathloss_op(model,dists[i])
    end
    return resp
end

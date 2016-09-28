
@doc "Calculate the distance between point A (latA,lonA) and Point B(latB,lonB)"
function distanceInKm(latA::AbstractFloat,lonA::AbstractFloat,latB::AbstractFloat,lonB::AbstractFloat)
  return 2 * 6372.8 * asin(sqrt(sind((latB-latA)/2)^2 + cosd(latA) * cosd(latB) * sind((lonB - lonA)/2)^2))
end


@doc "Calculate the distance between point A(latA,lonA) and a vector of Points(latB,lonB)"
function distanceInKm(latA::AbstractFloat,lonA::AbstractFloat,latB::Vector{AbstractFloat},lonB::Vector{AbstractFloat})
    n = size(latB,1)
    resp::Vector{AbstractFloat}=Vector{AbstractFloat}(n)
    if (size(lonB,1)!=n)
     error("latB and lonB have different sizes")
    end
    @simd for i in 1:n  # @simd vectoraze for loop
      @inbounds resp[i] = distanceInKm(latA,lonA,latB[i],lonB[i]) # @inbounds to not check bounds
    end
end

@doc "Calculate the distance between a vector of points"
function distanceInKm(latA::Vector{AbstractFloat},lonA::Vector{AbstractFloat},latB::Vector{AbstractFloat},lonB::Vector{AbstractFloat})
    n = size(latA,1)
    isEqualSize::Bool = n == size(lonA,1) == size(latB,1)==size(lonB,1)

    if (!isEqualSize)
     error("the vectors have different sizes")
    end
    resp::Vector{AbstractFloat}=Vector{AbstractFloat}(n)
    @simd for i in 1:n  # @simd vectoraze for loop
      @inbounds resp[i] = distanceInKm(latA[i],lonA[i],latA[i],lonA[i])
    end
end


@doc "Calculate the Azimute between A and B"
function azimuthLineAtoB(latA::AbstractFloat,lonA::AbstractFloat,latB::AbstractFloat,lonB::AbstractFloat)
     numer = cosd(latB) * sind(lonB - lonA)
     denom = sind(latB) * cosd(latA) - cosd(latB) * sind(latA) * cosd(lonB - lonA)
     return rad2deg((atan2(numer, denom) + 2π) % 2π)
end

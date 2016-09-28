module PathLoss

# package code goes here
include(joinpath(Pkg.dir(),"PathLoss","src","Models","Model.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Enums.jl"))
include(joinpath(Pkg.dir(),"PathLoss", "src","Models","Sui.jl"))
include(joinpath(Pkg.dir(),"PathLoss", "src","Models","FreeSpace.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","OkumuraHata.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","Cost231.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","Ecc33.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","Cost231.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","Ericsson.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Geo","GeoFunctions.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","Model.jl"))
# Exports
export
# models
FreeSpaceModel,
OkumuraHataModel,
Ecc33Model,
Cost231Model,
EricssonModel,
SuiModel,
# functions
distanceInKm,
pathloss,
azimuthLineAtoB,
#enums
CityKind,
AreaKind,
TerrainKind
end # module

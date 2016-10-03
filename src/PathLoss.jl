module PathLoss

# Exports
export
# models
FreeSpaceModel,
OkumuraHataModel,
Ecc33Model,
Cost231Model,
Cost231HataModel,
EricssonModel,
SuiModel,
LeeModel,
FlatEarthModel,
# functions
distanceInKm,
pathloss,
azimuthLineAtoB,
#enums
CityKind,
AreaKind,
TerrainKind,
LeeArea


# package code goes here
include(joinpath(Pkg.dir(),"PathLoss","src","Geo","GeoFunctions.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","Model.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Enums.jl"))
include(joinpath(Pkg.dir(),"PathLoss", "src","Models","Sui.jl"))
include(joinpath(Pkg.dir(),"PathLoss", "src","Models","FreeSpace.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","OkumuraHata.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","Cost231.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","Ecc33.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","Cost231Hata.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","Ericsson.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","LeeModel.jl"))
include(joinpath(Pkg.dir(),"PathLoss","src","Models","FlatEarthModel.jl"))
end # module

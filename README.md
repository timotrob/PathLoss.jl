# PathLoss.jl



[![Build Status](https://travis-ci.org/timotrob/PathLoss.jl.svg?branch=master)](https://travis-ci.org/timotrob/PathLoss.jl)
[![Coverage Status](https://coveralls.io/repos/github/timotrob/PathLoss.jl/badge.svg?branch=master)](https://coveralls.io/github/timotrob/PathLoss.jl?branch=master)

A Julia package for evaluating Radio Frequency Propagation models.

This package also provides Geo functions to compute distances and azimuths.

## Installation

The package is installed by calling in the Julia's REPL:

Pkg.clone("https://github.com/timotrob/PathLoss.jl.git")

Julia's versions : 0.4 and 0.5.

## Supported Models

- Free Space
- Okumura-Hata
- COST231 Hata Extension
- COST231 Waldrosch-Ikegami
- ECC-33
- Ericsson 9999
- SUI (STANFORD UNIVERSITY INTERIM)
- Lee Model
- Flat Earth Model


## Geo Functions
-----------

### Calculating Distances

```julia

using PathLoss

# point A
latA = 38.893
lonA = -77.037852
# point B
latB = 38.899147
lonB = -77.023934
# Calculating distance
dist = distanceInKm(latA,lonA,latB,lonB)

```

### Calculating azimuths

```julia

using PathLoss

# point A
latA = 38.893
lonA = -77.037852
# point B
latB = 38.899147
lonB = -77.023934
# Calculating azimuth
azi =azimuthLineAtoB(latA,lonA,latB,lonB)

```

## Models
-----------


### Free Space Model


```julia

using PathLoss

# point A
latA = 38.893
lonA = -77.037852
# point B
latB = 38.899147
lonB = -77.023934

# Calculating distance
dist = distanceInKm(latA,lonA,latB,lonB)
# Calculating PathLoss
fs = FreeSpaceModel() # For ERP
fs.freq = 800 #Mhz
p_fs1 = pathloss(fs,dist)

```

### Okumura-Hata Model

```julia

using PathLoss

# point A
latA = 38.893
lonA = -77.037852
# point B
latB = 38.899147
lonB = -77.023934

# Calculating distance
dist = distanceInKm(latA,lonA,latB,lonB)

# Model Setup
m = OkumuraHataModel()
m.freq = 800                 # frequency in Mhz
m.txH = 90                    # Height of the cell site (in meters)
m.rxH = 1.2                   # Height of Mobile Station (in meters)
m.areaKind = AreaKind.Urban  # Area Type (Urban SubUrban Open)
m.cityKind = CityKind.Medium # City type (Small Medium Large)

# Calculating PathLoss
pl = pathloss(m,dist)

```

### COST-231 Hata Extension Model

```julia
using PathLoss

# point A
latA = 38.893
lonA = -77.037852
# point B
latB = 38.899147
lonB = -77.023934

# Calculating distance
dist = distanceInKm(latA,lonA,latB,lonB)

# Model Setup
m = Cost231HataModel()
m.freq = 1800    #frequency in Mhz
m.txH = 90      # height of the cell site (
m.rxH = 1.5     # height of MS(Mobile Station)
m.areaKind = AreaKind.Urban # cyte type(Small,Medium or Large).

# Calculating PathLoss
pl = pathloss(m,dist)
```



### COST-231 Waldrosch-Ikegami Model

```julia
using PathLoss

# point A
latA = 38.893
lonA = -77.037852
# point B
latB = 38.899147
lonB = -77.023934

# Calculating distance
dist = distanceInKm(latA,lonA,latB,lonB)

# Model Setup
m = Cost231Model()
m.freq = 800    #frequency in Mhz
m.txH = 90      # height of the cell site (
m.rxH = 1.5     # height of MS(Mobile Station)
m.ws = 20       # average width of the street in meters
m.bs = 7        # average setback of buildings in meters
m.hr = 8        # mean height of houses in meters
m.cityKind = CityKind.Medium # cyte type(Small,Medium or Large).

# Calculating PathLoss
pl = pathloss(m,dist)
```


### ECC-33

```julia
using PathLoss

# point A
latA = 38.893
lonA = -77.037852
# point B
latB = 38.899147
lonB = -77.023934

# Calculating distance
dist = distanceInKm(latA,lonA,latB,lonB)

# Model Setup
m = Ecc33Model()
m.freq = 950                 # frequency in Mhz
m.txH = 90                   # Height of the cell site (
m.rxH = 1.2                  # Height of MS(Mobile Station)

# Calculating PathLoss
pl = pathloss(m,dist)
```


### Ericsson 9999

```julia

using PathLoss

# point A
latA = 38.893
lonA = -77.037852
# point B
latB = 38.899147
lonB = -77.023934

# Calculating distance
dist = distanceInKm(latA,lonA,latB,lonB)

# Model Setup
m = EricssonModel()
m.freq = 800    #frequency in Mhz
m.txH = 35      # height of the cell site (15 and 40 m.)
m.rxH = 2       # height of MS(Mobile Station)
m.cityKind = CityKind.Medium


pl = pathloss(m,dist)

```


### SUI (STANFORD UNIVERSITY INTERIM)

```julia
using PathLoss

# point A
latA = 38.893
lonA = -77.037852
# point B
latB = 38.899147
lonB = -77.023934

# Calculating distance
dist = distanceInKm(latA,lonA,latB,lonB)

# Model Setup
m = SuiModel()
m.freq = 2100    #frequency in Mhz
m.txH = 35      # height of the cell site (15 and 40 m.)
m.rxH = 2       # height of MS(Mobile Station)
m.shadowFading = 9.0 # Shadow Fading(8.2 dB and 10.6)
m.terrainKind = TerrainKind.B

# TerrainKind
# Category A: hilly terrain with moderate-to-heavy tree densities,
# which results in the maximum path loss.
# Category B: hilly environment but rare vegetation, or high vegetation but flat terrain. Intermediate path loss condition is typical of this category.
# Category C: mostly flat terrain with light tree densities. It corresponds to minimum path loss conditions
# Calculating PathLoss



pl = pathloss(m,dist)

```

### Lee Model

```julia
# point A
latA = 38.893
lonA = -77.037852
# point B
latB = 38.899147
lonB = -77.023934

# Calculating distance
dist = distanceInKm(latA,lonA,latB,lonB)

# Model Setup
m = LeeModel()
m.freq = 950    #frequency in Mhz
m.txH = 90      # height of the cell site
m.rxH = 1.5     # height of MS(Mobile Station
m.leeArea = LeeArea.NewYorkCity # (determined empirically)
# Area parameters are tuples as follow:
# FreeSpace = (2.0,45.0)
# OpenArea =  (4.35,49.0)
# SubUrban= (3.84,61.7)
# Philadelphia=(3.68, 70.0)
# Newark=(4.31, 64.0)
# Tokyo=(3.05, 84.0)
# NewYorkCity =(4.8,77.0) # n=4.8 Po=77.0

# Calculating PathLoss
pl = pathloss(m,dist)


# it is posssible to change the area parameters as follow:
m.leeArea = (5.0,81.0)
pl2 = pathloss(m,dist)

```


### Flat Earth Model

```julia
# point A
latA = 38.893
lonA = -77.037852
# point B
latB = 38.899147
lonB = -77.023934

# Calculating distance
dist = distanceInKm(latA,lonA,latB,lonB)

# Model Setup
m = FlatEarthModel()
m.freq = 950    #frequency in Mhz
m.txH = 90      # height of the cell site
m.rxH = 1.5     # height of MS(Mobile Station

# Calculating PathLoss
pl = pathloss(m,dist)

```


## Models Setup
-----------

### Frequency Range

It is necessary to set ``checkFreqRange=false``  to use the model outside of the frequency range specified in the model's paper.
For example, the Okumura-Hata is specified to work in the range 500Mhz - 1500Mhz,
nevertheless, in the example below, the Okumura-Hata is used for ``f = 1800 Mhz``:

```julia

using PathLoss

# point A
latA = 38.893
lonA = -77.037852
# point B
latB = 38.899147
lonB = -77.023934

# Calculating distance
dist = distanceInKm(latA,lonA,latB,lonB)

# Model Setup
m = OkumuraHataModel()
m.freq = 1800                 # frequency in Mhz
m.txH = 90                    # Height of the cell site (in meters)
m.rxH = 1.2                   # Height of Mobile Station (in meters)
m.areaKind = AreaKind.Urban  # Area Type (Urban SubUrban Open)
m.cityKind = CityKind.Medium # City type (Small Medium Large)
m.checkFreqRange=false       # To use in the range outside of 500MHz-1500Mhz
# Calculating PathLoss
pl = pathloss(m,dist)

```

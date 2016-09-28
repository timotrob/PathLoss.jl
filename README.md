# PathLoss



[![Build Status](https://travis-ci.org/timotrob/PathLoss.jl.svg?branch=master)](https://travis-ci.org/timotrob/PathLoss.jl)

A Julia package for evaluating Radio Frequency Propagation models.

This package also provides Geo functions to compute distances and azimuths.

## Installation

The package is installed by calling:

Pkg.clone("https://github.com/timotrob/PathLoss.jl.git")

## Supported Models

- Free Space
- Okumura-Hata
- COST231
- ECC-33
- Ericsson 9999
- SUI(STANFORD UNIVERSITY INTERIM)

## Exemples

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
m = OkumuraHataModel()      # For ERP
m.freq = 800                 # frequency in Mhz
m.txH = 90                    # Height of the cell site (
m.rxH = 1.2                   # Height of MS(Mobile Station)
m.areaKind = AreaKind.Urban  # Area Type (Urban SubUrban Open)
m.cityKind = CityKind.Medium # City type (Small Medium Large)

# Calculating PathLoss
pl = pathloss(m,dist)

```

### COST-231

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
m.freq = 800                 # frequency in Mhz
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

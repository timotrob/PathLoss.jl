# PathLoss

A Julia package for evaluating Radio Frequency Propagation models.

This package also provides Geo functions to compute distances and azimuths.

## Installation

The package is installed by calling:

Pkg.clone("https://github.com/timotrob/PathLoss.jl.git")

## Supported Models

- Free Space
- Okumura-Hata
- COST231-Hata Extension
- ECC-33
- Ericsson 9999

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
m.hb = 90                    # Height of the cell site
m.hm = 1.2                   # Height of MS(Mobile Station)
m.areaKind = AreaKind.Urban  # Area Type (Urban SubUrban Open)
m.cityKind = CityKind.Medium # City type (Small Medium Large)

# Calculating PathLoss
pl = pathloss(m,dist)

```

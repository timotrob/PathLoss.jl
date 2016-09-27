using PathLoss
using Base.Test

# write your own tests here
@test 1 == 1


# Distance test
lat1 = 38.893
lon1 = -77.037852
lat2 = 38.899147
lon2 = -77.023934
d_calc = distanceInKm(lat1,lon1,lat2,lon2)
d_real = 1.385 # km
@test_approx_eq_eps d_calc d_real 0.01 # precision 10 m


# Azimuth test
az_real = 60.42
az_calc  = azimuthLineAtoB(lat1,lon1,lat2,lon2)
@test_approx_eq_eps az_calc az_real 0.1 # precision o.1


# FreeSpaceModel Test
fs = FreeSpaceModel() # For ERP
fs.freq =800 #Mhz
p_fs1 = pathloss(fs,1.385)
p_fs2 = 93.33
@test_approx_eq_eps p_fs1 p_fs2 0.01 # precision 0.01 Db

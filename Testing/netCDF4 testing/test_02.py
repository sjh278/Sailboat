from netCDF4 import Dataset
import numpy as np
import matplotlib.pyplot as plt


# read a a specific netCDF file
my_example_nc_file = '/Users/mukundsudarshan/Documents/SampleData/uv20150106rt.nc'
# create a netCDF4.Dataset object
fh = Dataset(my_example_nc_file, mode='r')

# create some netCDF4.Variable objects
x = fh.variables['u']
y = fh.variables['v']

# create some numpy.ndarray objects
lons = fh.variables['lon'][:]
lats = fh.variables['lat'][:]
tmax = fh.variables['time'][:]

tmax_units = fh.variables['time'].units



print lats

fh.close()
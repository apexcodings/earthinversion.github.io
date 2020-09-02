---
title: "Plotting 1 arc-minute global relief map [Python]"
date: 2020-05-09
tags: [topography, python, noaa, global relief, geophysics]
excerpt: "Plotting 1 arc-minute topographic map in python"
mathjax: "true"
classes:
  - wide
header:
  teaser: "/images/topographic_map_python/test_africa.png"
---
{% include toc %}

- see [here](https://iescoders.com/plotting-topographic-map-using-noaa-global-relief-data-in-python/) too
- uses Python’s matplotlib (basemap) library for plotting
- to use topographic map from 1 arc-minute global relief data from NOAA (or even higher resolution)
- uses a sliced array for plotting the data for the selected region
- run-time has been optimized
- colormap is customizable
- visit here for the codes
- 1 arc-minute global relief data can be downloaded from NOAA’s webpage.

## World Map
``` python
## World map
lonmin, lonmax = -180,180
latmin, latmax = -50,50

fig = plt.figure(figsize=(10,6))
ax = fig.add_subplot(111)
map = Basemap(projection='merc',resolution = 'l', area_thresh = 10000., llcrnrlon=lonmin, llcrnrlat=latmin,urcrnrlon=lonmax, urcrnrlat=latmax)
cs = plot_topo(map,cmap='terrain',lonextent=(lonmin, lonmax),latextent=(latmin, latmax),zorder=2)
fig.colorbar(cs, ax=ax, shrink=0.4)
map.drawcoastlines(color='k',linewidth=0.5)
map.drawcountries(color='k',linewidth=0.1)
# map.drawstates(color='gray',linewidth=0.05)
# map.drawrivers(color='blue',linewidth=0.05)
parallelmin = int(latmin)
parallelmax = int(latmax)+1
map.drawparallels(np.arange(parallelmin, parallelmax,10,dtype='int16').tolist(),labels=[1,0,0,0],linewidth=0,fontsize=6)

meridianmin = int(lonmin)
meridianmax = int(lonmax)+1
map.drawmeridians(np.arange(meridianmin, meridianmax,20,dtype='int16').tolist(),labels=[0,0,0,1],linewidth=0,fontsize=6)

map.drawmapboundary(color='k', linewidth=2, zorder=1)

plt.savefig('world_map.png',bbox_inches='tight',dpi=300)
plt.close('all')
```
<figure>
<img src="https://raw.githubusercontent.com/earthinversion/plotting_topographic_maps_in_python/master/world_map.png" alt="world map">
</figure>

## Africa Map 
``` python
## Map1
lonmin, lonmax = -30,70
latmin, latmax = -40,40

fig = plt.figure(figsize=(10,6))
ax = fig.add_subplot(111)
map = Basemap(projection='merc',resolution = 'l', area_thresh = 10000., llcrnrlon=lonmin, llcrnrlat=latmin,urcrnrlon=lonmax, urcrnrlat=latmax)
cs = plot_topo(map,cmap='terrain',lonextent=(lonmin, lonmax),latextent=(latmin, latmax),zorder=2)
fig.colorbar(cs, ax=ax, shrink=0.9)
map.drawcoastlines(color='k',linewidth=0.5)
map.drawcountries(color='k',linewidth=0.1)
map.drawstates(color='gray',linewidth=0.05)
map.drawrivers(color='blue',linewidth=0.05)
parallelmin = int(latmin)
parallelmax = int(latmax)+1
map.drawparallels(np.arange(parallelmin, parallelmax,10,dtype='int16').tolist(),labels=[1,0,0,0],linewidth=0)

meridianmin = int(lonmin)
meridianmax = int(lonmax)+1
map.drawmeridians(np.arange(meridianmin, meridianmax,20,dtype='int16').tolist(),labels=[0,0,0,1],linewidth=0)

map.drawmapboundary(color='k', linewidth=2, zorder=1)

plt.savefig('africa.png',bbox_inches='tight',dpi=300)
plt.close('all')
```

<figure>
<img src="https://raw.githubusercontent.com/earthinversion/plotting_topographic_maps_in_python/master/africa.png" alt="africa map">
</figure>


## Africa Etopo (NOAA):
```python
lonmin, lonmax = -30,70
latmin, latmax = -40,40

fig = plt.figure(figsize=(10,6))
ax = fig.add_subplot(111)
map = Basemap(projection='merc',resolution = 'l', area_thresh = 10000., llcrnrlon=lonmin, llcrnrlat=latmin,urcrnrlon=lonmax, urcrnrlat=latmax)
cs = plot_topo_netcdf(map,etopo_file='ETOPO1_Bed_g_gmt4.grd',cmap='terrain',lonextent=(lonmin, lonmax),latextent=(latmin, latmax),zorder=2)
fig.colorbar(cs, ax=ax, shrink=0.4)
map.drawcoastlines(color='k',linewidth=0.5)
map.drawcountries(color='k',linewidth=0.1)

parallelmin,parallelmax = int(latmin), int(latmax)+1
map.drawparallels(np.arange(parallelmin, parallelmax+1,10,dtype='int16').tolist(),labels=[1,0,0,0],linewidth=0,fontsize=6)
meridianmin,meridianmax = int(lonmin),int(lonmax)+1
map.drawmeridians(np.arange(meridianmin, meridianmax+1,20,dtype='int16').tolist(),labels=[0,0,0,1],linewidth=0,fontsize=6)
map.drawmapboundary(color='k', linewidth=2, zorder=1)
plt.savefig('test_africa.png',bbox_inches='tight',dpi=600)
plt.close('all')
```

<figure>
<img src="{{ site.url }}{{ site.baseurl }}/images/topographic_map_python/test_africa.png" alt="africa map">
</figure>


## Taiwan Plot
```python
### ETOPO TAIWAN
lonmin, lonmax = 119,123
latmin, latmax = 20,26

fig = plt.figure(figsize=(10,6))
ax = fig.add_subplot(111)
map = Basemap(projection='merc',resolution = 'f', area_thresh = 1000., llcrnrlon=lonmin, llcrnrlat=latmin,urcrnrlon=lonmax, urcrnrlat=latmax)
cs = plot_topo_netcdf(map,etopo_file='ETOPO1_Bed_g_gmt4.grd',cmap='terrain',lonextent=(lonmin, lonmax),latextent=(latmin, latmax),zorder=2)
fig.colorbar(cs, ax=ax, shrink=0.9)

map.drawcoastlines(color='k',linewidth=0.5)
map.drawcountries(color='k',linewidth=0.1)
parallelmin,parallelmax = int(latmin), int(latmax)+1
map.drawparallels(np.arange(parallelmin, parallelmax+1,10,dtype='int16').tolist(),labels=[1,0,0,0],linewidth=0,fontsize=6)
meridianmin,meridianmax = int(lonmin),int(lonmax)+1
map.drawmeridians(np.arange(meridianmin, meridianmax+1,20,dtype='int16').tolist(),labels=[0,0,0,1],linewidth=0,fontsize=6)

map.drawmapboundary(color='k', linewidth=2, zorder=1)
plt.savefig('taiwan_plot.png',bbox_inches='tight',dpi=600)
plt.close('all')
```

<figure>
<img src="https://raw.githubusercontent.com/earthinversion/plotting_topographic_maps_in_python/master/taiwan_plot.png" alt="africa map">
</figure>

See more:
[iescoders post](https://iescoders.com/plotting-topographic-map-using-noaa-global-relief-data-in-python/)

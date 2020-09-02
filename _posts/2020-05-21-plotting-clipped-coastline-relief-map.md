---
title: "Topographic map clipped by coastlines [Python]"
date: 2020-05-21
tags: [maps,  clipped, python, geophysics]
excerpt: "This post demonstrate how to use Python to set up clip topographic map based on coastlines."
classes:
  - wide
header:
  teaser: "/images/station_map_masked.png"
---
{% include toc %}

In this post, we demonstrate how to plot the clipped relief map in Python. For the previous post on "Plotting the geospatial data clipped by coastlines in Python", see [here](https://iescoders.com/plotting-the-geospatial-data-clipped-by-coastlines-in-python/). Here we use the same approach but instead of the geospatial dataset, we use the 1-arc minute topographic map we used in the [previous plot](https://www.earthinversion.com/Shaded-topo-map-python/). 

We use the matplotlib's [`Path`](https://matplotlib.org/3.2.1/tutorials/advanced/path_tutorial.html) module to deal with the polylines of the coastal path in Taiwan. The approach is simple (may not be so efficient computationally), we first plot the topography on the map, then select the polylines using the `Path` and then mask the region outside the coastline with lightblue color.


<figure class="half">
	<img width="400" src="{{ site.url }}{{ site.baseurl }}/images/station_map_masked.png">
    <img width="400" src="{{ site.url }}{{ site.baseurl }}/images/station_map_masked_reverse.png">
</figure>


```python
from mpl_toolkits.basemap import Basemap
import matplotlib.pyplot as plt
import numpy as np
import netCDF4 #you need to read gridded ETOPO1 file
import pandas as pd
from matplotlib.colors import LinearSegmentedColormap
from matplotlib.patches import Path, PathPatch
from matplotlib.colors import LightSource



etopo_file = "/Users/utpalkumar50/Documents/bin/ETOPO1_Bed_g_gmt4.grd"

lonmin, lonmax = 119.5,122.5
latmin, latmax = 21.5,25.5


fig, ax = plt.subplots(figsize=(10,10))
map = Basemap(projection='merc',resolution = 'f', area_thresh = 10000., llcrnrlon=lonmin, llcrnrlat=latmin,urcrnrlon=lonmax, urcrnrlat=latmax)
f = netCDF4.Dataset(etopo_file)
try:
    lons = f.variables['lon'][:]
    lats = f.variables['lat'][:]
    etopo = f.variables['z'][:]
except:
    lons = f.variables['x'][:]
    lats = f.variables['y'][:]
    etopo = f.variables['z'][:]


lonmin,lonmax = lonmin-1,lonmax+1
latmin,latmax = latmin-1,latmax+1

lons_col_index = np.where((lons>lonmin) & (lons<lonmax))[0]
lats_col_index = np.where((lats>latmin) & (lats<latmax))[0]

etopo_sl = etopo[lats_col_index[0]:lats_col_index[-1]+1,lons_col_index[0]:lons_col_index[-1]+1]
lons_sl = lons[lons_col_index[0]:lons_col_index[-1]+1]
lats_sl = lats[lats_col_index[0]:lats_col_index[-1]+1]
lons_sl, lats_sl = np.meshgrid(lons_sl,lats_sl)

ls = LightSource(azdeg=315, altdeg=45)
rgb = ls.shade(np.array(etopo_sl), cmap=plt.cm.terrain, vert_exag=1, blend_mode=ls.blend_soft_light)

map.imshow(rgb,zorder=2,alpha=0.8,cmap=plt.cm.terrain, interpolation='bilinear')

# Use a proxy artist for the colorbar...
cs = map.imshow(np.array(etopo_sl), cmap=plt.cm.terrain)
cs.remove()
fig.colorbar(cs, ax=ax, shrink=0.8)

map.drawcoastlines(color='k',linewidth=1,zorder=3)
map.drawcountries(color='k',linewidth=1,zorder=3)

parallelmin,parallelmax = int(latmin), int(latmax)+1
map.drawparallels(np.arange(parallelmin, parallelmax+1,0.5).tolist(),labels=[1,0,0,0],linewidth=0,fontsize=6)
meridianmin,meridianmax = int(lonmin),int(lonmax)+1
map.drawmeridians(np.arange(meridianmin, meridianmax+1,0.5).tolist(),labels=[0,0,0,1],linewidth=0,fontsize=6)
map.drawmapboundary(color='k', linewidth=2, zorder=1)



## Masking the topography outside Taiwan coastlines
x0,x1 = ax.get_xlim()
y0,y1 = ax.get_ylim() 
map_edges = np.array([[x0,y0],[x1,y0],[x1,y1],[x0,y1]])
##getting all polygons used to draw the coastlines of the map
polys = [p.boundary for p in map.landpolygons]
##combining with map edges
polys = [map_edges]+polys[:]
##creating a PathPatch
codes = [[Path.MOVETO]+[Path.LINETO for p in p[1:]] for p in polys]
verts = [v for p in polys for v in p]
codes = [xx for cs in codes for xx in cs]

path = Path(verts, codes)
patch = PathPatch(path,facecolor='lightblue', edgecolor='none',zorder=4)

##masking the data outside the inland of taiwan
ax.add_patch(patch)

plt.savefig('station_map_masked.png',bbox_inches='tight',dpi=300)
plt.close('all')
```


It is also possible to reverse the masking and keep the bathymetry of the region and mask the land region with white.


```python
from mpl_toolkits.basemap import Basemap
import matplotlib.pyplot as plt
import numpy as np
import netCDF4
import pandas as pd
from matplotlib.colors import LinearSegmentedColormap
from matplotlib.patches import Path, PathPatch
from matplotlib.colors import LightSource



etopo_file = "/Users/utpalkumar50/Documents/bin/ETOPO1_Bed_g_gmt4.grd"

lonmin, lonmax = 119.5,122.5
latmin, latmax = 21.5,25.5


fig, ax = plt.subplots(figsize=(10,10))
map = Basemap(projection='merc',resolution = 'f', area_thresh = 10000., llcrnrlon=lonmin, llcrnrlat=latmin,urcrnrlon=lonmax, urcrnrlat=latmax)
f = netCDF4.Dataset(etopo_file)
try:
    lons = f.variables['lon'][:]
    lats = f.variables['lat'][:]
    etopo = f.variables['z'][:]
except:
    lons = f.variables['x'][:]
    lats = f.variables['y'][:]
    etopo = f.variables['z'][:]


lonmin,lonmax = lonmin-1,lonmax+1
latmin,latmax = latmin-1,latmax+1

lons_col_index = np.where((lons>lonmin) & (lons<lonmax))[0]
lats_col_index = np.where((lats>latmin) & (lats<latmax))[0]

etopo_sl = etopo[lats_col_index[0]:lats_col_index[-1]+1,lons_col_index[0]:lons_col_index[-1]+1]
lons_sl = lons[lons_col_index[0]:lons_col_index[-1]+1]
lats_sl = lats[lats_col_index[0]:lats_col_index[-1]+1]
lons_sl, lats_sl = np.meshgrid(lons_sl,lats_sl)

ls = LightSource(azdeg=315, altdeg=45)
rgb = ls.shade(np.array(etopo_sl), cmap=plt.cm.terrain, vert_exag=1, blend_mode=ls.blend_soft_light)

map.imshow(rgb,zorder=2,alpha=0.8,cmap=plt.cm.terrain, interpolation='bilinear')


map.drawcoastlines(color='k',linewidth=1,zorder=3)
map.drawcountries(color='k',linewidth=1,zorder=3)

parallelmin,parallelmax = int(latmin), int(latmax)+1
map.drawparallels(np.arange(parallelmin, parallelmax+1,0.5).tolist(),labels=[1,0,0,0],linewidth=0,fontsize=6)
meridianmin,meridianmax = int(lonmin),int(lonmax)+1
map.drawmeridians(np.arange(meridianmin, meridianmax+1,0.5).tolist(),labels=[0,0,0,1],linewidth=0,fontsize=6)
map.drawmapboundary(color='k', linewidth=2, zorder=1)



##getting all polygons used to draw the coastlines of the map
polys = [p.boundary for p in map.landpolygons]
##combining with map edges
polys = polys[:]
##creating a PathPatch
codes = [[Path.MOVETO]+[Path.LINETO for p in p[1:]] for p in polys]
verts = [v for p in polys for v in p]
codes = [xx for cs in codes for xx in cs]

path = Path(verts, codes)
patch = PathPatch(path,facecolor='white', edgecolor='none',zorder=4)

##masking the data outside the inland of taiwan
ax.add_patch(patch)


plt.savefig('station_map_masked_reverse.png',bbox_inches='tight',dpi=300)
plt.close('all')
```

Download codes [here](https://github.com/earthinversion/Relief_map_clipped_by_coastlines).
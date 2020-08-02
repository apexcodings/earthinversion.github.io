---
title: "Plotting track and trajectory of hurricanes on a topographic map [Python]"
date: 2020-07-10
tags: [hurricane track, typhoon track, basemap, topography, geophysics]
excerpt: "Short demostration of how to plot the track or trajectory of a hurricane on a map. Codes are included."
classes:
  - wide
---

<h2 id="top">Contents</h2>
<ol>
  <li><a href="#introduction">Introduction</a></li>
  <li><a href="#import-libraries">Import necessary libraries</a></li>
  <li><a href="#define-parameters">Define necessary parameters</a></li>
  <li><a href="#set-up-basemap">Set up basemap</a></li>
  <li><a href="#plot-track">Plot track of the hurricane</a></li>
  <li><a href="#references">References</a></li>
</ol>


<h2 id="introduction">Introduction <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h2>
Plotting track or trajectory of the hurriance (or typhoon or cyclone) is essential part of analyzing and understanding the hurricane. For details see <a href="#references">references</a>.

<h3 id="import-libraries">Importing Libraries <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
import matplotlib.pyplot as plt
from obspy.imaging.beachball import beach
from obspy.geodetics.base import gps2dist_azimuth
import numpy as np
from mpl_toolkits.basemap import Basemap
from plotting_topo import plot_topo, plot_topo_netcdf
import pandas as pd
import glob
```

<h3 id="define-parameters">Define necessary parameters <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
etopo_file = "" #location-of-your-etopo-file

lonmin, lonmax = 60, 95
latmin, latmax = 0, 25
```

<h3 id="set-up-basemap">Set up basemap with topography<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
fig = plt.figure(figsize=(10,6))
axx = fig.add_subplot(111)
m = Basemap(projection='merc', resolution="f", llcrnrlon=lonmin, llcrnrlat=latmin, urcrnrlon=lonmax, urcrnrlat=latmax)
cs = plot_topo_netcdf(m,etopo_file,cmap='jet',lonextent=(lonmin, lonmax),latextent=(latmin, latmax),zorder=2)

fig.colorbar(cs, ax=axx, shrink=0.6)

m.drawcoastlines(color='k',linewidth=0.5,zorder=3)
m.drawcountries(color='k',linewidth=0.1,zorder=3)

parallelmin = int(latmin)
parallelmax = int(latmax)+1
m.drawparallels(np.arange(parallelmin, parallelmax,5,dtype='int16').tolist(),labels=[1,0,0,0],linewidth=0,fontsize=10, zorder=3)

meridianmin = int(lonmin)
meridianmax = int(lonmax)+1
m.drawmeridians(np.arange(meridianmin, meridianmax,5,dtype='int16').tolist(),labels=[0,0,0,1],linewidth=0,fontsize=10, zorder=3)
```

<h3 id="plot-track">Plot track on the basemap <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
colors = ['C0','C1','C3','C2','C4','C5','C6','C7']
datafiles = glob.glob("01_TRACKS/*.txt") #to read individual data files containing the coordinates of the track for each typhoon
for jj in range(8):
    dff = pd.read_csv(datafiles[jj],sep='\s+', dtype={'time': object}) #read data file and time as string
    year = datafiles[jj].split("/")[1].split("_")[1].split("-")[0] #extract year information from the filename
    track_name = datafiles[jj].split("/")[1].split("(")[1].split(")")[0] #extract track information from the filename

    track_name = track_name.capitalize()
    ## extract lat and lon info from pandas data frame and convert to map scale
    lons = dff['lon'].values
    lats = dff['lat'].values
    x, y = m(lons, lats)

    ## plot the track 
    m.plot(x, y,'o-',color=colors[jj],ms=4, zorder=4,label=f"TRACK {jj} ({year})")

    ## extract the time info and label the track with the time for every 3 data points
    typh_time=[]
    for i in range(dff.shape[0]):
        date=dff.loc[i,'date']
        try:
            dd = date.split(".")[0]
            month = date.split(".")[1]
        except:
            dd = date.split("/")[0]
            month = date.split("/")[1]

        time=dff.loc[i,'time']

        track_times="{}{} ({})".format(month, dd, time[:2])
        typh_time.append(track_times)
    typh_time=np.array(typh_time)

    for i in np.arange(0,len(typh_time),5):
        plt.text(x[i]+20000,y[i]-10000,typh_time[i],fontsize=6,zorder=4)

    ## plot the arrow based on the last two data points to indicate the trajectory of the track
    plt.arrow(x[-1], y[-1]+1, x[-1]-x[-2], y[-1]-y[-2],head_width=50000, head_length=60000, fc='w', ec='k',color='k',alpha=1,zorder=4)
plt.legend(loc=1)

## save the map as png
plt.savefig('map.png',bbox_inches='tight',dpi=300)
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/hurricane-track/map.png">
  <figcaption>Hurricanes</figcaption>
</p>

<h3 id="references">References <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>
<ol>
  <li>Fovell, R. G., and Su, H. (2007), Impact of cloud microphysics on hurricane track forecasts, Geophys. Res. Lett., 34, L24810, doi:10.1029/2007GL031723.</li>
  <li>Huang, Y., C. Wu, and Y. Wang, 2011: The Influence of Island Topography on Typhoon Track Deflection. Mon. Wea. Rev., 139, 1708–1727, https://doi.org/10.1175/2011MWR3560.1.</li>
</ol>
---
title: "Plotting track and trajectory of hurricanes on a topographic map [Python]"
date: 2020-07-10
tags: [hurricane track, typhoon track, cyclone track, basemap, topography, matplotlib, geophysics]
excerpt: "Short demostration of how to plot the track or trajectory of a hurricane on a map. Codes are included."
classes:
  - wide
header:
  teaser: "/images/hurricane-track/map.png"
authors: balajiseela
---

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/hurricane-track/map.png">
  <figcaption>Track plot</figcaption>
</p>

<h2 id="top">Contents</h2>
<ol>
  <li><a href="#introduction">Introduction</a></li>
  <li><a href="#tropical-cyclone-data">Tropical cyclones best track data base sites</a></li>
  <li><a href="#import-libraries">Import necessary libraries</a></li>
  <li><a href="#define-parameters">Define map parameters</a></li>
  <li><a href="#set-up-basemap">Set up basemap</a></li>
  <li><a href="#plot-track">Plot track of the hurricane</a></li>
  <li><a href="#references">References</a></li>
</ol>


<h2 id="introduction">Introduction <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h2>
Plotting track or trajectory of the hurriance is essential part of analyzing and understanding the hurricane. For details see <a href="#references">references</a>.

<h3 id="tropical-cyclone-data">Tropical cyclones (TCs) best track data base sites <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

- For north Indian Ocean TCs: [India Meteorological department](http://www.rsmcnewdelhi.imd.gov.in/)

- For south Indian Ocean TCs: [Australia bureau of meteorological](http://www.bom.gov.au/cyclone/tropical-cyclone-knowledge-centre/databases/)

- For northwest Pacific TCs: [Japan Meteorological Agency](https://www.jma.go.jp/jma/jma-eng/jma-center/rsmc-hp-pub-eg/RSMC_HP.htm)

- For Atlantic Ocean: [National Oceanic and Atmospheric Administration](https://www.nhc.noaa.gov/data/)

- For global tropical cyclones: [All oceanic tropical cyclones](https://www.metoc.navy.mil/jtwc/jtwc.html?best-tracks)

<h2>Visualization <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h2>

<h3 id="import-libraries">Importing Libraries <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

The first thing I like to do is to import all the necessary libraries for the task. This keeps the code organized.

```python
import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.basemap import Basemap
import pandas as pd
import glob
from plotting_topo import plot_topo
```

- `matplotlib.pyplot` is imported for the plotting purpose,
- `numpy` is for scientific computation and operations, 
- `Basemap` is the matplotlib library for plotting 2D data on map,
- `glob` is for reading the files present in the directory,
- `plot_topo` is the function that reads the topo data for plotting on the map. 

<script src="https://gist.github.com/earthinversion/2d776a3385c02b664a6ef5fe08a0cf5e.js"></script>

The `topo` dir is location in the current directory.

<h3 id="define-parameters">Define map boundary parameters <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
lonmin, lonmax = 60, 95
latmin, latmax = 0, 25
```

<h3 id="set-up-basemap">Set up basemap with topography<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

For more details of plotting topography on a map, see this post for details: https://www.earthinversion.com/station_map_python/
- instantiate the basemap instance within the defined map boundary. Here, we chose the mercator projection. For other projections, check [here](https://matplotlib.org/basemap/users/mapsetup.html)

```python
fig = plt.figure(figsize=(10,6))
axx = fig.add_subplot(111)
m = Basemap(projection='merc', resolution="f", llcrnrlon=lonmin, llcrnrlat=latmin, urcrnrlon=lonmax, urcrnrlat=latmax)
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/hurricane-track/map-tmp1.png">
</p>

- plot the topography on the basemap and draw colorbar

```python
cs = plot_topo(m,cmap=plt.cm.jet,zorder=2,lonextent=(lonmin, lonmax),latextent=(latmin, latmax))

fig.colorbar(cs, ax=axx, shrink=0.6)
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/hurricane-track/map-tmp2.png">
</p>

- draw latitudinal and longitudinal grid lines with the step of 5 degrees. We only show the labels on the left and bottom of the map.

```python
m.drawcoastlines(color='k',linewidth=0.5,zorder=3)
m.drawcountries(color='k',linewidth=0.1,zorder=3)

parallelmin = int(latmin)
parallelmax = int(latmax)+1
m.drawparallels(np.arange(parallelmin, parallelmax,5,dtype='int16').tolist(),labels=[1,0,0,0],linewidth=0,fontsize=10, zorder=3)

meridianmin = int(lonmin)
meridianmax = int(lonmax)+1
m.drawmeridians(np.arange(meridianmin, meridianmax,5,dtype='int16').tolist(),labels=[0,0,0,1],linewidth=0,fontsize=10, zorder=3)
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/hurricane-track/map-tmp3.png">
</p>

<h3 id="plot-track">Plot track on the basemap <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

- define the list of colors to be used for different hurriances
- read the file names stored in the directory `01_TRACKS`, and with the suffix `.txt`
- read the data file as a pandas data frame. 
- extract the `year` info from the filename
- we "capitalize" the track name
- get longitude and latitude as numpy array 
- convert lat and lon to map projection scale
- plot the track with `-o` and label the name of each track

```python
colors = ['C0','C1','C3','C2','C4','C5','C6','C7'] #default colors from Python (can be automated if the order is not important)
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
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/hurricane-track/map-tmp4.png">
</p>

- we extract the time at each data point from the data file for plotting on the map. This gives an idea of the direction of the hurricane.
- the extracted values are the date and month and hour.
- the track time is plotted for every 3rd data point with some shift in x and y direction. The shift is given in terms of the map scale.

```python
for jj in range(8):
  ######CONTINUE FROM ABOVE####
  #############################
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
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/hurricane-track/map-tmp5.png">
</p>
- we can put a triangle at the end of the track to indicate the direction of the hurricane 

```python
for jj in range(8):
  ######CONTINUE FROM ABOVE####
  #############################
    ## plot the arrow based on the last two data points to indicate the trajectory of the track
    plt.arrow(x[-1], y[-1]+1, 0, 0,head_width=50000, head_length=60000, fc='w', ec='k',color='k',alpha=1,zorder=4)
```
<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/hurricane-track/map-tmp6.png">
</p>

- Instead of just triangle to indicate the direction, we plot the rough trajectory of the hurricane based on the last two data points.

```python
for jj in range(8):
  ######CONTINUE FROM ABOVE####
  #############################
    ## plot the arrow based on the last two data points to indicate the trajectory of the track
    plt.arrow(x[-1], y[-1]+1, x[-1]-x[-2], y[-1]-y[-2],head_width=50000, head_length=60000, fc='w', ec='k',color='k',alpha=1,zorder=4)

plt.legend(loc=1)

## save the map as png
plt.savefig('map.png',bbox_inches='tight',dpi=300)
```
<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/hurricane-track/map-tmp7.png">
</p>


<h3 id="references">References <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>
<ol>
  <li>Janapati. J., B. K. Seela, P.-L. Lin, P. K. Wang, and U. Kumar, 2019: An assessment of tropical cyclones rainfall erosivity for Taiwan. Sci. Rep., 9, 15862. https://doi.org/10.1038/s41598-019-52028-5</li>
  <li>Janapati. J., B. K. Seela, P.-L. Lin, P. K. Wang, C.-H. Tseng, K. K. Reddy, H. Hashiguchi, L. Feng, S. K. Das, and C. K. Unnikrishnan (2020),  Raindrop size distribution characteristics of Indian and Pacific ocean tropical cyclones observed at India and Taiwan sites. Journal of the Meteorological Society of Japan. 98(2), 299−317. https://doi.org/10.2151/jmsj.2020-015</li>
  <li>Janapati. J., Balaji Kumar seela, M. Venkatrami Reddy, K. Krishna Reddy, Pay-Liam Lin, T. Narayana Rao and Chian-Yi Liu, (2017), A study on raindrop size distribution variability in before and after landfall precipitations of tropical cyclones observed over southern India, J. Atmos. and Sol.-Terr. Phys., Vol. 159, 23–40. https://doi.org/10.1016/j.jastp.2017.04.011</li>
  <li>Fovell, R. G., and Su, H. (2007), Impact of cloud microphysics on hurricane track forecasts, Geophys. Res. Lett., 34, L24810, doi:10.1029/2007GL031723.</li>
  <li>Huang, Y., C. Wu, and Y. Wang, 2011: The Influence of Island Topography on Typhoon Track Deflection. Mon. Wea. Rev., 139, 1708–1727, https://doi.org/10.1175/2011MWR3560.1.</li>
</ol>
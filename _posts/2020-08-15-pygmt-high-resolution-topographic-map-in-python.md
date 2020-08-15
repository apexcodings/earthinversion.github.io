---
title: "PyGMT: High Quality Topographic Map in Python [Python]"
date: 2020-08-15
tags: [seismology, topography, GMT, Generic Mapping Tools, geophysics]
excerpt: "A simple tutorial on how to plot high resolution topographic map using GMT tools in Python"
classes:
  - wide
header:
  teaser: "/images/pygmt/topo-plot.png"
---

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/pygmt/topo-plot.png">
  <figcaption>Topographic Map of Southern India</figcaption>
</p>

<h2 id="top">Contents</h2>
<ol>
  <li><a href="#top">Contents</a></li>
  <li><a href="#introduction">Introduction </a></li>
  <li><a href="#visualization">Example script </a></li>
  <ul>
    <li><a href="#import-libraries">Importing Libraries </a></li>
    <li><a href="#topo-data">Define topographic data source </a></li>
    <li><a href="#initialize-pygmt-figure">Initialize the pyGMT figure</a></li>
    <li><a href="#color-palletes">Define CPT file</a></li>
    <li><a href="#plot-high-res-topo">Plot the high resolution topography from the data source</a></li>
    <li><a href="#plot-coastlines">Plot the coastlines/shorelines on the map</a></li>
    <li><a href="#plot-topo-contour">Plot the topographic contour lines</a></li>
    <li><a href="#plot-data-points-on-map">Plot data on the topographic map</a></li>
    <li><a href="#plot-colorbar-on-map">Plot colorbar for the topography</a></li>
    <li><a href="#save-figure">Output the figure to a file</a></li>
  </ul>
  <li><a href="#complete-script">Complete Script </a></li>
  <li><a href="#references">References </a></li>  
</ol>


<h2 id="introduction">Introduction <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h2>

If you have been working in seismology, then you must have come across [Generic Mapping Tools (GMT) software](https://www.generic-mapping-tools.org). It is widely used software, not only in seismology but across the Earth, Ocean, and Planetary sciences and beyond. It is a free, open-source software used to generate publication quality maps or illustrations, process data and make animations. Recently, GMT built API (Application Programming Interface) for MATLAB, Julia and Python. In this post, we will explore the Python wrapper library for the GMP API - [PyGMT](https://www.pygmt.org/). Using the GMT from Python script allows enormous capabilities.

<h2 id="visualization">Example script <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h2>
In this post, we will demonstrate the PyGMT implementation by plotting the topographic map of southern India. We will also plot some markers on the map.

<h3 id="import-libraries">Importing Libraries <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

The first thing I like to do is to import all the necessary libraries for the task. This keeps the code organized.

```python
import pygmt
```

```python
minlon, maxlon = 60, 95
minlat, maxlat = 0, 25
```


<h3 id="topo-data">Define topographic data source <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
#define etopo data file
# topo_data = 'path_to_local_data_file'
topo_data = '@earth_relief_30s' #30 arc second global relief (SRTM15+V2.1 @ 1.0 km)
# topo_data = '@earth_relief_15s' #15 arc second global relief (SRTM15+V2.1)
# topo_data = '@earth_relief_03s' #3 arc second global relief (SRTM3S)
```



<h3 id="initialize-pygmt-figure">Initialize the pyGMT figure<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>



```python
# Visualization
fig = pygmt.Figure()
```


<h3 id="color-palletes">Define CPT file<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>


```python
# make color pallets
pygmt.makecpt(
    cmap='topo',
    series='-8000/8000/1000',
    continuous=True
)
```

<h3 id="plot-high-res-topo">Plot the high resolution topography from the data source<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
#plot high res topography
fig.grdimage(
    grid=topo_data,
    region=[minlon, maxlon, minlat, maxlat], 
    projection='M4i'
    )
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/pygmt/topo-plot-test1.png">
</p>

```python
#plot high res topography
fig.grdimage(
    grid=topo_data,
    region=[minlon, maxlon, minlat, maxlat], 
    projection='M4i',
    frame=True
    )
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/pygmt/topo-plot-test2.png">
</p>

```python
#plot high res topography
fig.grdimage(
    grid=topo_data,
    region=[minlon, maxlon, minlat, maxlat], 
    projection='M4i',
    shading=True,
    frame=True
    )
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/pygmt/topo-plot-test3.png">
</p>



<h3 id="plot-coastlines">Plot the coastlines/shorelines on the map<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
fig.coast(
    region=[minlon, maxlon, minlat, maxlat], 
    projection='M4i', 
    shorelines=True,
    frame=True
    )
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/pygmt/topo-plot-test4.png">
</p>

<h3 id="plot-topo-contour">Plot the topographic contour lines<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
fig.grdcontour(
    grid=topo_data,
    interval=4000,
    annotation="4000+f6p",
    limit="-8000/0",
    pen="a0.15p"
    )
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/pygmt/topo-plot-test5.png">
</p>

<h3 id="plot-data-points-on-map">Plot data on the topographic map<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
## Generate fake coordinates in the range for plotting
lons = minlon + np.random.rand(10)*(maxlon-minlon)
lats = minlat + np.random.rand(10)*(maxlat-minlat)
```

```python
# plot data points
fig.plot(
    x=lons,
    y=lats, 
    style='c0.1i', 
    color='red', 
    pen='black', 
    label='something',
    )
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/pygmt/topo-plot-test6.png">
</p>

<h3 id="plot-colorbar-on-map">Plot colorbar for the topography<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
# Plot colorbar
Default is horizontal colorbar
fig.colorbar(
    frame='+l"Topography"'
    )
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/pygmt/topo-plot-test7.png">
</p>

```python
# For vertical colorbar
fig.colorbar(
frame='+l"Topography"',
position="x11.5c/6.6c+w6c+jTC+v"
)
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/pygmt/topo-plot-test8.png">
</p>

<h3 id="save-figure">Output the figure to a file<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
# save figure
fig.savefig("topo-plot.png", crop=True, dpi=300)
```

```python
fig.savefig("topo-plot.pdf", crop=True, dpi=720)
```


<h2 id="complete-script">Complete Script <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h2>

<script src="https://gist.github.com/earthinversion/84104f759cb0af67fd18f3006bbc2ade.js"></script>

<h2 id="references">References <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h2>
<ol>
  <li>Uieda, L., Wessel, P., 2019. PyGMT: Accessing the Generic Mapping Tools from Python. AGUFM 2019, NS21B--0813.</li>
  <li>Wessel, P., Luis, J.F., Uieda, L., Scharroo, R., Wobbe, F., Smith, W.H.F., Tian, D., 2019. The Generic Mapping Tools Version 6. Geochemistry, Geophys. Geosystems 20, 5556–5564. https://doi.org/10.1029/2019GC008515</li>
</ol>
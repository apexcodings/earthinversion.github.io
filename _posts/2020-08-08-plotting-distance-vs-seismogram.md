---
title: "Plotting seismograms with increasing epicentral distance [Python]"
date: 2020-08-08
tags: [seismology, epicentral distance, waveforms, P-arrival, S-arrival, geophysics]
excerpt: "Short demostration of how to plot the distance vs seismic waveforms and mark the P and S arrival times using the IASP91 earth model. Codes are included."
classes:
  - wide
header:
  teaser: "/images/distanceVsSeismogram/dist-waveforms.png"
---

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/distanceVsSeismogram/dist-waveforms.png">
  <figcaption>Distance vs Seismograms</figcaption>
</p>

<h2 id="top">Contents</h2>
<ol>
  <li><a href="#introduction">Introduction</a></li>
  <li><a href="#import-libraries">Import necessary libraries</a></li>
  <li><a href="#normalize-traces">Initialize normalization instance</a></li>
  <li><a href="#define-tauP-object">Initialize the TauP instance</a></li>
  <li><a href="#waveforms">What seismograms to plot?</a></li>
  <li><a href="#plot-waveforms-distance">Plotting the waveforms in the order of increasing distance</a></li>

  <li><a href="#references">References</a></li>
</ol>


<h2 id="introduction">Introduction <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h2>

Seismic waves travel from the source to the recording station. In general, the stations close to the source record the seismic waves first and then the station farther than that. This is however not always true as Earth is not homogeneous. The seismic waves propagating deeper layers of earth tends to reach the station faster. This has mainly to do with the increasing velocity structure of Earth (the subsurface structure of Earth is more complicated that that). The first thing seismologists do to understand the seismic structure is to plot the seismic waveforms in order of increasing epicentral distance. Then they plot the arrival time of the P and S-wave (two most common phase present in the seismograms) based on the known earth model. This gives the idea of the arrival time for these phases. Then the observational seismologists pick these phases manually and compare with the arrival time of the known model. This helps in modeling the fine differences in the earth structure from one region to another.<br>

In this post, we will see how we can plot the seismograms with respect to the epicentral distance. The seismograms are read from a directory in the current location of the code. This, however, can be modified.


<h3 id="import-libraries">Importing Libraries <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

The first thing I like to do is to import all the necessary libraries for the task. This keeps the code organized.

```python
import matplotlib.pyplot as plt
import numpy as np
from sklearn import preprocessing
import glob
from obspy import read
from obspy.taup import TauPyModel
from obspy.geodetics import kilometers2degrees
plt.style.use('seaborn')
```
- `matplotlib.pyplot` is imported for the plotting purpose,
- `numpy` is for computation, 
- `preprocessing` for normalizing the waveforms (there are many other ways to achieve this),
- `read` is for reading the seismograms (in this example, we read the sac format but it can be implemented to read many formats). For more details see <a href="https://docs.obspy.org/packages/autogen/obspy.core.stream.read.html" >here</a>.
- `glob` is for reading the files present in the directory
- `TauPyModel` is for calculating the P and S-wave arrival time for the given Earth model,
- `kilometers2degrees` for converting the km to degrees (as the name suggests)
- `plt.style.use('seaborn')` is for selecting the style for plotting. There are many other styles popular. I personally like the `ggplot`, `seaborn`, `default`, `classic`.

<p align="center">
  <img width="40%" src="{{ site.url }}{{ site.baseurl }}/images/distanceVsSeismogram/dist-waveforms-default.png">
  <img width="40%" src="{{ site.url }}{{ site.baseurl }}/images/distanceVsSeismogram/dist-waveforms-ggplot.png">
  <figcaption>(left) default (right) ggplot </figcaption>
</p>



<h3 id="normalize-traces">Initialize the processing instance for normalizing the waveform fluctuations <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
## for normalizing traces
min_max_scaler11 = preprocessing.MinMaxScaler(feature_range=(-1, 1))
```
The above code defines the preprocessing object for normalizing the waveforms in all the seismograms to the same level. We normalize the waveforms from -1 to 1. 


<h3 id="define-tauP-object">Initialize the TauP instance<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

The TauP is popular tool in seismology for the calculation of travel times and ray paths of seismic phases for a specified 1D spherically symmetric model of the Earth. In this example, we use the TauP module of Obspy.

```python
# tauP earth model setting
model = TauPyModel(model="iasp91")
```
We select the `isap91` model in this example. Some of the other model provided by Obspy are `prem`, `ak135`, `1066a`, etc (see [here](https://docs.obspy.org/packages/obspy.taup.html#basic-usage) for more).

<h3 id="waveforms">What seismograms to plot?<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

In this case, I kept all the seismograms in the sac format in the directory, `./dis` and ending with the suffix, `.DIS`.

```python
## read all waveforms in file "disp"
all_disp = glob.glob("dis/*.DIS")
```
We can print all the files:
```
['dis/LSA.BHZ.IC.DIS', 'dis/MAJO.BHZ.IU.DIS', 'dis/PET.BHZ.IU.DIS', 'dis/HNR.BHZ.IU.DIS', 'dis/TLY.BHZ.II.DIS', 'dis/CASY.BHZ.IU.DIS', 'dis/NIL.BHZ.II.DIS', 'dis/INCN.BHZ.IU.DIS', 'dis/KMBO.BHZ.IU.DIS', 'dis/TAU.BHZ.II.DIS', 'dis/BJT.BHZ.IC.DIS', 'dis/LSZ.BHZ.IU.DIS', 'dis/MDJ.BHZ.IC.DIS', 'dis/SNZO.BHZ.IU.DIS', 'dis/WAKE.BHZ.IU.DIS', 'dis/AAK.BHZ.II.DIS', 'dis/SPA.BHZ.IU.DIS', 'dis/KIV.BHZ.II.DIS', 'dis/ULN.BHZ.IU.DIS', 'dis/ERM.BHZ.II.DIS', 'dis/ARU.BHZ.II.DIS', 'dis/MAKZ.BHZ.IU.DIS', 'dis/SSE.BHZ.IC.DIS', 'dis/XAN.BHZ.IC.DIS', 'dis/KMI.BHZ.IC.DIS', 'dis/SUR.BHZ.II.DIS', 'dis/WMQ.BHZ.IC.DIS', 'dis/YAK.BHZ.IU.DIS', 'dis/BILL.BHZ.IU.DIS', 'dis/OBN.BHZ.II.DIS', 'dis/ADK.BHZ.IU.DIS', 'dis/MSEY.BHZ.II.DIS', 'dis/GUMO.BHZ.IU.DIS', 'dis/CTAO.BHZ.IU.DIS', 'dis/YSS.BHZ.IU.DIS', 'dis/BRVK.BHZ.II.DIS', 'dis/JOHN.BHZ.IU.DIS', 'dis/HIA.BHZ.IC.DIS', 'dis/FURI.BHZ.IU.DIS', 'dis/ENH.BHZ.IC.DIS']
```
`glob` outputs the available files as a list. The data in this case has been obtained from IRIS with the setting of 5 minutes after the P-arrival.
Now, we intantiate a figure instance and then iterate through each seismogram to plot.

<h3 id="plot-waveforms-distance">Plotting the waveforms in the order of increasing distance<a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

Now, we do the following steps in order:
- iterate through each of the sac file, 
- read the seismogram, 
- extract the time and data axis for each seismogram,
- extract the epicentral distance in km and convert to degrees
- calculate the P and S wave arrival times for the given source depth and epicentral distance. Note that we have already specified the earth model in the previous section.
- save P and S arrival time as separate variables
- normalize the seismogram data from -1 to 1 using the instance defined in the previous section.
- plot the normalized data with a shift of epicentral distance. The x-axis in all cases are same. We plot the waveforms with black color and set the linewidth of 0.5 to clearly see the fluctuations. We multiply the amplitude of each seismogram with two to increase visibility.
- Since the data is aligned with respect to the P-arrival time, the P-arrival is same in each case.
- we store the P-arrival time, calculated S-arrival time, and S-arrival marking location for each seismogram.

```python
## visualizing
fig,ax = plt.subplots(1,1,figsize=(10,10))

p_arrival_times,s_arrival_times,s_arrival_dist = [], [], []
## loop through all files
for disp in all_disp:
    # read file
    st =  read(disp)
    dist = kilometers2degrees(st[0].stats.sac['dist']) #convert from km to degree
    time_axis = st[0].times()
    data_axis = st[0].data
    evdp = st[0].stats.sac['evdp'] #event depth
    arrivals = model.get_travel_times(source_depth_in_km=evdp, distance_in_degree=dist, phase_list=["P","S"]) #get P and S wave arrival time using tauP
    p_arrival = arrivals[0].time
    s_arrival = arrivals[1].time
    data_axis = min_max_scaler11.fit_transform((data_axis).reshape(-1, 1)) #normalize traces
    ax.plot(time_axis,2*data_axis+dist,color='k',lw=0.5)
    p_arrival_times.append(5*60)
    s_arrival_times.append(5*60+(s_arrival-p_arrival))
    s_arrival_dist.append(2*np.mean(data_axis)+dist)
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/distanceVsSeismogram/dist-waveforms-tmp1.png">
  <figcaption>Distance vs Seismograms</figcaption>
</p>

- we convert each lists into the numpy array. We used the list to append the data because it is relatively faster and efficient. Numpy array is optimized for computation, which is difficult using the Python's list data type.
- we sort the S-wave arrival x and y locations for each seismograms in order of increasing distance. We also sort the P and S-wave arrival times.
- Now, we plot the P and S arrival times using the dashed line of red color. We made the thickness higher in this case.


```python
s_arrival_dist = np.array(s_arrival_dist)
s_arrival_times = np.array(s_arrival_times)
p_arrival_times = np.array(p_arrival_times)

s_arrival_sort_idx = np.argsort(s_arrival_dist)
s_arrival_dist = s_arrival_dist[s_arrival_sort_idx]
s_arrival_times = s_arrival_times[s_arrival_sort_idx]
p_arrival_times = p_arrival_times[s_arrival_sort_idx]

ax.plot(s_arrival_times,s_arrival_dist,'r--',lw=2) #plot S arrivals
ax.plot(p_arrival_times,s_arrival_dist,'r--',lw=2) #plot P arrivals
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/distanceVsSeismogram/dist-waveforms-tmp2.png">
  <figcaption>Distance vs Seismograms</figcaption>
</p>

- We label the x and y axis. 

```python
ax.set_ylabel('Distance in degrees',fontsize=14)
ax.set_xlabel('Time',fontsize=14)
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/distanceVsSeismogram/dist-waveforms-tmp3.png">
  <figcaption>Distance vs Seismograms</figcaption>
</p>

- We only display the plot for the time axis from 0 to 2500 seconds.
- Finally, we save the figure in the `png` format, crop it to remove the white spaces and set the resolution of 300 dpi.

```python
ax.set_xlim([0,2500])
plt.savefig("dist-waveforms.png",bbox_inches='tight',dpi=300)
```



<h3 id="references">References <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>
<ol>
  <li>Crotwell, H.P., Owens, T.J., Ritsema, J., 1999. The TauP Toolkit: Flexible seismic travel-time and ray-path utilities. Seismol. Res. Lett. 70, 154–160.</li>
  <li><a href="https://docs.obspy.org/packages/obspy.taup.html">Ray theoretical travel times and paths by Obspy (TauP)</a></li>
</ol>
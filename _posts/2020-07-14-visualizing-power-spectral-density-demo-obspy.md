---
title: "Visualizing power spectral density using Obspy [Python]"
date: 2020-07-10
tags: [psd, probabilistic power spectral density, temporal plot, spectrogram ppsd, obspy, geophysics]
excerpt: "Short demonstration of the ppsd class defined in Obspy using 3 days of data for station PB-B075"
classes:
  - wide
header:
  teaser: "/images/visualizing-ppsd/PB_B075-ppsd_cumulative.png"
---
For details, visit [Visualizing Probabilistic Power Spectral Densities](https://docs.obspy.org/tutorial/code_snippets/probabilistic_power_spectral_density.html).
<h2 id="top">Contents</h2>
<ol>
  <li><a href="#import-libraries">Import necessary libraries</a></li>
  <li><a href="#download-data">Download stream using Obspy</a></li>
  <li><a href="#add-data">Add data to the ppsd estimate</a></li>
  <li><a href="#visualizing">Visualization using Obspy</a></li>
  <li><a href="#figures">Output Figures</a></li>
  <li><a href="#references">References</a></li>
</ol>




<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/visualizing-ppsd/pb_075_loc.jpg">
  <figcaption>Location of the event (yellow star) and station (green triangle) [Screenshot from IRIS]</figcaption>
</p>
<br>
<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/visualizing-ppsd/PB_B075traces.jpg">
  <figcaption>Downloaded stream</figcaption>
</p>

<h3 id="import-libraries">Import necessary libraries <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
from obspy.io.xseed import Parser
from obspy.signal import PPSD
from obspy.clients.fdsn import Client
from obspy import UTCDateTime, read_inventory, read
import os, glob
import matplotlib.pyplot as plt
from obspy.imaging.cm import pqlx
import warnings
warnings.filterwarnings('ignore')
```

<h3 id="download-data">Download stream using Obspy <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
## Downloading inventory
net = 'PB' 
sta = 'B075' 
loc='*'
chan = 'EH*'
filename_prefix = f"{net}_{sta}"
mseedfiles = glob.glob(filename_prefix+".mseed")
xmlfiles = glob.glob(filename_prefix+'_stations.xml')

if not len(mseedfiles) or not len(xmlfiles):
    print("--> Missing mseed / station xml file, downloading...")
    time = UTCDateTime('2008-02-19T13:30:00') 
    wf_starttime = time - 60*60
    wf_endtime = time + 3 * 24 * 60 * 60 #3 days of data (requires atleast 1 hour)

    client = Client('IRIS')

    st = client.get_waveforms(net, sta, loc, chan, wf_starttime, wf_endtime)
    st.write(filename_prefix+".mseed", format="MSEED")
    inventory = client.get_stations(starttime=wf_starttime, endtime=wf_endtime,network=net, station=sta, channel=chan, level='response', location=loc)
    inventory.write(filename_prefix+'_stations.xml', 'STATIONXML')
else:
    st = read(filename_prefix+".mseed")
    inventory = read_inventory(filename_prefix+'_stations.xml')
```

<h3 id="add-data">Add data to the ppsd estimate <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
tr = st.select(channel="EHZ")[0]
print(st)
st.plot(outfile=filename_prefix+"traces.png",show=False)
ppsd = PPSD(tr.stats, metadata=inventory)
add_status = ppsd.add(st) #add data (either trace or stream objects) to the ppsd estimate
```

<h3 id="visualizing">Visualization using Obspy <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
if add_status:
    print(ppsd)
    print(ppsd.times_processed[:2]) #check what time ranges are represented in the ppsd estimate
    print("Number of psd segments:", len(ppsd.times_processed))
    ppsd.plot(filename_prefix+"-ppsd.png",cmap=pqlx) #colormap used by PQLX / [McNamara2004] 
    plt.close('all')
    ppsd.plot(filename_prefix+"-ppsd_cumulative.png",cumulative=True,cmap=pqlx) #cumulative version of the histogram
    plt.close('all')
    ppsd.plot_temporal(period=[0.1, 1.0, 10], filename=filename_prefix+"-ppsd_temporal_plot.png") #The central period closest to the specified period is selected
    plt.close('all')
    ppsd.plot_spectrogram(filename=filename_prefix+"-spectrogram.png", show=False)

```

<h3 id="figures">Output Figures <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/visualizing-ppsd/PB_B075-ppsd.png">
  <figcaption>Probabilistic Power Spectral Densities with colormap used by [McNamara2004] </figcaption>
</p>
<br>
<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/visualizing-ppsd/PB_B075-ppsd_cumulative.png">
  <figcaption>Cumulative version of the histogram </figcaption>
</p>

<br>
<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/visualizing-ppsd/PB_B075-ppsd_temporal_plot.png">
  <figcaption>Plot the evolution of PSD value of one (or more) period bins over time. </figcaption>
</p>

<br>
<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/visualizing-ppsd/PB_B075-spectrogram.png">
  <figcaption>Spectrogram of the estimate </figcaption>
</p>

<br>
<h3 id="references">References <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>
<ol>
  <li>McNamara, D. E., & Buland, R. P. (2004). Ambient Noise Levels in the Continental United States. Bulletin of the Seismological Society of America, 94(4), 1517–1527.</li>
  <li>McNamara, D. E., & Boaz, R. I. (2006). Seismic noise analysis system using power spectral density probability density functions: A stand-alone software package. Citeseer.</li>
</ol>
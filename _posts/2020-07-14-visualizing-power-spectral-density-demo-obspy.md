---
title: "How to visualize power spectral density using Obspy [Python]"
date: 2020-07-10
tags: [psd, probabilistic power spectral density, obspy]
excerpt: "Short demonstration of the ppsd class defined in Obspy"
classes:
  - wide
---

<h2 id="top">Outline</h2>
<ol>
  <li><a href="#import-libraries">Import necessary libraries</a></li>
  <li><a href="#references">Import necessary libraries</a></li>
</ol>


<h3 id="import-libraries">Import necessary libraries <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>

```python
from obspy.io.xseed import Parser
from obspy.signal import PPSD
from obspy.clients.fdsn import Client
from obspy import UTCDateTime, read_inventory, read
import os, glob
import matplotlib.pyplot as plt
from obspy.imaging.cm import pqlx
# import warnings
# warnings.filterwarnings('ignore')


net = 'PB' 
sta = 'B075' 
loc='*'
chan = 'EH*'
filename_prefix = f"{net}_{sta}"
mseedfiles = glob.glob(filename_prefix+".mseed")
xmlfiles = glob.glob(filename_prefix+'_stations.xml')

if not len(mseedfiles) or not len(xmlfiles):
    print("--> No mseed or station xml file found, downloading...")
    time = UTCDateTime('2008-02-19T13:30:00') 
    wf_starttime = time - 60*60
    wf_endtime = time + 8 * 60 * 60 #requires atleast 1 hour of data

    client = Client('IRIS')

    st = client.get_waveforms(net, sta, loc, chan, wf_starttime, wf_endtime)
    st.write(filename_prefix+".mseed", format="MSEED")
    inventory = client.get_stations(starttime=wf_starttime, endtime=wf_endtime,network=net, station=sta, channel=chan, level='response', location=loc)
    inventory.write(filename_prefix+'_stations.xml', 'STATIONXML')
else:
    st = read(filename_prefix+".mseed")
    inventory = read_inventory(filename_prefix+'_stations.xml')

tr = st.select(channel="EHZ")[0]
print(st)
ppsd = PPSD(tr.stats, metadata=inventory)
add_status = ppsd.add(st)
print(add_status)
if add_status:
    print(ppsd)
    print(ppsd.times_processed[:2]) #check what time ranges are represented in the ppsd estimate
    print("Number of psd segments:", len(ppsd.times_processed))
    ppsd.plot(filename_prefix+"-ppsd.png",cmap=pqlx) 
    plt.close('all')
    ppsd.plot(filename_prefix+"-ppsd_cumulative.png",cumulative=True,cmap=pqlx)
    plt.close('all')
    ppsd.plot_temporal(period=[0.1, 1, 10], filename=filename_prefix+"-ppsd_temporal_plot.png")
    plt.close('all')
```

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/visualizing-ppsd/PB_B075-ppsd.png">
</p>

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/visualizing-ppsd/PB_B075-ppsd_cumulative.png">
</p>

<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/visualizing-ppsd/PB_B075-ppsd_temporal_plot.png">
</p>

<h3 id="references">References <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>
<ol>
  <li>McNamara, D. E., & Boaz, R. I. (2006). Seismic noise analysis system using power spectral density probability density functions: A stand-alone software package. Citeseer.</li>
  <li>McNamara, D. E., & Buland, R. P. (2004). Ambient Noise Levels in the Continental United States. Bulletin of the Seismological Society of America, 94(4), 1517–1527.</li>
</ol>
---
title: "Remote Online Sessions for Emerging Seismologists (ROSES) Lectures: Revisited [Python]"
date: 2020-07-10
last_modified_at: 2020-07-11
tags: [geophysics, roses, agu, iris, obspy, anaconda, read seismic traces, seismology, removing instrument response, writing stream to file, filtering, trimming data, changing sampling rates, matplotlib, python]
excerpt: "ROSES lecture notes"
mathjax: "true"
classes:
  - wide
---
__WARNING__: THIS POST IS MY "EASILY-ACCESSIBLE" NOTES OF THE LECTURES. I share it on my blog with the hope that it may benefit other seismologists as well.

## Introduction to ROSES
> Amidst many choices for on-learning, on-line networking, and on-line collaboration, the ROSES 2020 summer school will run once a week for 11 weeks, starting on June 25. The school is targeted towards advanced Ph.D. students, who have used Python before and are familiar navigating in Linux/Unix.

- __ROSES__: Remote Online Sessions for Emerging Seismologists
- Organized by: [AGU]( https://www.agu.org), 2020
- ROSES Lectures and Labs will become available on __IRIS__, with some days of delay, at the [this link](https://www.iris.edu/hq/inclass/course/roses).

<h2 id="#top">Contents</h2>
- <a href="#prelecture">Pre-lecture preparation</a>
- <a href="#obspy">ObsPy: a Python toolbox for seismology</a> by Sydney Dybing
- <a href="#data-and-metadata">Data and Metadata</a> by Emily Wolin   
- <a href="#time-series-analysis">Time Series Analysis</a> by German A. Prieto 
- 7/14 (T) _Waveform Cross Correlation_ by Elizabeth Berg 
- 7/21 (T) _Array Seismology/Network Analysis_ by Stephen Arrowsmith 
- 7/28 (T) _Polarization Analysis_ by Dr. O
- 8/4 (T) _Machine Learning_ by Ross, Zachary E. 
- 8/11 (T)  _PyGMT_ by Liam Toney 
- 8/18 (T) _Inversion, Bayesian_ by Steve Myers 
- 8/25 (T) _Inversion, kriging_ by Tony Lowry 
- 9/1 (T) by Suzan van der Lee


<h2 id="prelecture">Pre-lecture preparation <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h2>

### Installation of the environment in anaconda
NOTE: It is important to use specified version of the libraries otherwise there may be some inconsistencies such as the bandpass filter command of `obspy` may throw some error.

- `roses_env.yml` environment yml file can be downloaded from [here](https://github.com/earthinversion/Remote-Online-Sessions-for-Emerging-Seismologists-ROSES-Lectures-Revisited/blob/master/roses_env.yml)
- Install environment using anaconda and the `roses_env.yml`
```
conda env create -f roses_env.yml
```

- [OPTIONAL] Install on macOS (without Anaconda) using the file `roses-env2-osx.txt` (<a href="https://github.com/earthinversion/Remote-Online-Sessions-for-Emerging-Seismologists-ROSES-Lectures-Revisited/find/master" download="Codes">
    <img src="https://img.icons8.com/carbon-copy/100/000000/download-2.png" alt="slrm" width="40" height="40"></a>):
```
conda create --name roses --file roses-env2-osx.txt
```

- Activate `roses` anaconda environment 
```
conda activate roses
```

- Create alias for activating `roses` environment in the `~/.bash_profile` (for mac) or `~/.bashrc` (for linux)
```
alias roses='conda deactivate; conda deactivate; conda activate roses'
```
(will first deactivate any previously activated environment)
PS: The two `deactivate` commands is to safely deactivate double nested environment. You can choose to use `conda deactivate; conda activate roses`.

<h2 id="obspy">ObsPy: a Python toolbox for seismology <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h2>

- Download latex-generated-pdf of the "follow along jupyter notebook" by Sydney Dybing: <a href="https://github.com/earthinversion/Remote-Online-Sessions-for-Emerging-Seismologists-ROSES-Lectures-Revisited/raw/master/Obspy_Tutorial_Follow_Along_Notebook.pdf" download="Codes">
    <img src="https://img.icons8.com/carbon-copy/100/000000/download-2.png" alt="slrm" width="40" height="40"></a>

<h3 id="obspy-outline">Outline</h3>
1. <a href="#obspy-reading-data-file">Reading data from a file</a>
2. <a href="#obspy-downloading-data">Downloading data from online repositories</a>
3. <a href="#removing-instrument-response">Removing instrument response</a>
4. <a href="#writing-data-into-file">Writing data to a file</a>
5. <a href="#some-stream-trace-method">Some Obspy stream and trace methods</a>
  - <a href="#filtering">Filtering</a>
  - <a href="#trimming-data">Trimming data</a>
  - <a href="#changing-sampling-rates">Changing sampling rates</a>
6. <a href="#matplotlib">Plotting with Matplotlib</a>

<h3 id="obspy-reading-data-file">Reading data from a file <a href="#obspy-outline"><i class="fa fa-angle-double-up" aria-hidden="true"></i></a></h3>
- With the `read` function, you basically just only need the path to the file on your computer.
```python
from obspy import read
st = read('B082_EHZ.mseed')
print(st)
```

  ```
  1 Trace(s) in Stream:
  PB.B082..EHZ | 2010-04-04T22:40:42.368400Z - 2010-04-04T22:45:42.358400Z | 100.0 Hz, 30000 samples
  ```

- Access the trace object
```python
tr = st[0] 
print(tr)
```

  ```
  PB.B082..EHZ | 2010-04-04T22:40:42.368400Z - 2010-04-04T22:45:42.358400Z | 100.0 Hz, 30000 samples
  ```

- View the data and metadata
```python
data = tr.data 
print(data)
print(tr.stats) #To view the metadata
```

  ```
[ 49 52 50 ... 6979 7201 7440]
network: PB
station: B082
location:
channel: EHZ
starttime: endtime: sampling_rate: delta:
2010-04-04T22:40:42.368400Z 2010-04-04T22:45:42.358400Z 100.0
0.01
npts: 30000
calib: _format: mseed:
1.0
MSEED
AttribDict({'dataquality': 'M', 'number_of_records': 134,
'encoding': 'STEIM2', 'byteorder': '>', 'record_length': 512, 'filesize': 68608})
```

  ```python
print(tr.stats.network) 
print(tr.stats.npts)
```

  ```
PB 
30000
```

- make simple plots of traces
```python
tr.plot();
```
  <p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig1.jpg">
  </p>


  ```python
  tr.plot(color='b') #colored plot
  ```
  <p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig2.jpg">
  </p>

- reading stream with multiple traces
```python
 st = read('CWC_HNE.mseed') 
 st += read('CWC_HNN.mseed') 
 st += read('CWC_HNZ.mseed') 
 print(st)
```
or

  ```python
tr1 = read('CWC_HNE.mseed') 
tr2 = read('CWC_HNN.mseed') 
tr3 = read('CWC_HNZ.mseed') 
st = tr1 + tr2 + tr3 
print(st)
```

  ```
3 Trace(s) in Stream:
CI.CWC..HNE | 2019-07-05T11:06:53.048393Z - 2019-07-05T11:10:53.038393Z | 100.0 Hz, 24000 samples
CI.CWC..HNN | 2019-07-05T11:06:53.048393Z - 2019-07-05T11:10:53.038393Z | 100.0 Hz, 24000 samples
CI.CWC..HNZ | 2019-07-05T11:06:53.048393Z - 2019-07-05T11:10:53.038393Z | 100.0 Hz, 24000 samples
```

  ```python
  st.plot()
  ```
<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig3.jpg">
  </p>

<h3 id="obspy-downloading-data">Downloading data from online repositories <a href="#obspy-outline"><i class="fa fa-angle-double-up" aria-hidden="true"></i></a></h3>
- Setting up the client and managing times
```python
from obspy.clients.fdsn import Client 
from obspy import UTCDateTime #Times are managed in Obspy using a class called UTCDateTime
client = Client('IRIS') #IRIS is just one “client” that stores data
```
```python
time = UTCDateTime('2019-07-06T03:19:53.04') 
print(time)
starttime = time - 60 
print(starttime)
endtime = time + 15*60
print(endtime)
```
```
2019-07-06T03:19:53.040000Z
2019-07-06T03:18:53.040000Z
2019-07-06T03:34:53.040000Z
```

  ```python
  net = 'IU' #Identifies which network the data belongs to
  sta = 'TUC' #The station within a network 
  loc = '00' #stations can have more than one instrument at them
  chan = 'HH1' #Three character code

  st = client.get_waveforms(net, sta, loc, chan, starttime, endtime) 
  print(st)
  st.plot()
  ```

  ```
  1 Trace(s) in Stream:
  IU.TUC.00.HH1 | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
  ```
<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig4.jpg">
  </p>

- to download multiple channels
```python
chan = 'HH*'
st = client.get_waveforms(net, sta, loc, chan, starttime, endtime) 
print(st)
st.plot()
```
```
3 Trace(s) in Stream:
IU.TUC.00.HH1 | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
IU.TUC.00.HH2 | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
IU.TUC.00.HHZ | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
```
<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig5.jpg">
</p>


<h3 id="removing-instrument-response">Removing instrument response <a href="#obspy-outline"><i class="fa fa-angle-double-up" aria-hidden="true"></i></a></h3>

- without removing the instrument response, the data is quantitaitvely meaningless (see <a href="https://books.google.com.tw/books?id=5PPuCgAAQBAJ&pg=PA197&lpg=PA197&dq=10.1007/978-3-319-21314-9_6&source=bl&ots=R_XJrZxu59&sig=ACfU3U2YdUF5_nlVwRFs0Hbvdm5fHI7_Xw&hl=en&sa=X&q=10.1007/978-3-319-21314-9_6&redir_esc=y#v=snippet&q=10.1007%2F978-3-319-21314-9_6&f=false">Havskov and Alguacil, 2015<a>)

  ```python
  time = UTCDateTime("2019-07-06T03:19:53.04") 
  starttime = time - 60
  endtime = time + 60*15

  net = "IU" 
  sta = "TUC" 
  loc = "00" 
  chan = "HH1"

  st = client.get_waveforms(net, sta, loc, chan, starttime, endtime, attach_response = True)
  print(st) 
  st.plot();
  ```
```
1 Trace(s) in Stream:
IU.TUC.00.HH1 | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
/Users/utpalkumar50/miniconda3/envs/roses/lib/python3.7/site- packages/obspy/io/stationxml/core.py:84: UserWarning: The StationXML file has version 1.1, ObsPy can deal with version 1.0. Proceed with caution.
root.attrib["schemaVersion"], SCHEMA_VERSION))
```
  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig6.jpg">
  </p>

  ```python
  ## To remove the response, it is a good practice to copy the stream
  st_rem = st.copy() 
  print(st_rem) 
  print(st)
  ``` 

  ```
  1 Trace(s) in Stream:
  IU.TUC.00.HH1 | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
  1 Trace(s) in Stream:
  IU.TUC.00.HH1 | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
  ```

  ```python
  st_rem.remove_response(output='VEL') #DISP, ACC 
  st.plot()
  st_rem.plot()
  # Remember, if you run this cell multiple times, your output will be strange because you already removed the
  # response from st_rem. If you want to do it again and try something else, you either have to make a new copy
  # of the original st again, or go back and re-run the previous cell that copied st.
  ```
  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig7.jpg">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig8.jpg">
  </p>

- We can visualize what remove_response is doing by using the `plot = True` option
```python
st_rem = st.copy() # repeating this since the last cell will have removed the response from st_rem already
st_rem.remove_response(output='VEL', plot=True) # other options: output = 'DISP', 'ACC'
```
```
1 Trace(s) in Stream:
IU.TUC.00.HH1 | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
```
<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig9.jpg">
</p>
- data after removing the response
```python
st_rem.plot()
```
<p align="center">
  <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig10.jpg">
</p>

<h3 id="writing-data-into-file">Writing downloaded data to a file <a href="#obspy-outline"><i class="fa fa-angle-double-up" aria-hidden="true"></i></a></h3>
- This can be done with `st.write()` - you just specify the desired file path, name, extension, and data format (SAC, MSEED, etc.).

  ```python
  filename = f'{sta}_{chan}.mseed' 
  st_rem.write(filename, format='MSEED')
  ```
  ```
  /Users/utpalkumar50/miniconda3/envs/roses/lib/python3.7/site- packages/obspy/io/mseed/core.py:772: UserWarning: The encoding specified in trace.stats.mseed.encoding does not match the dtype of the data.
  A suitable encoding will be chosen.
  warnings.warn(msg, UserWarning)
  ```

  ```python
   st = read('TUC_HH1.mseed') 
   print(st)
  st.plot()
  ```
  ```
  1 Trace(s) in Stream:
  IU.TUC.00.HH1 | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
  ```
  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig11.jpg">
  </p>

<h3 id="some-stream-trace-method">Some Stream and Trace Methods <a href="#obspy-outline"><i class="fa fa-angle-double-up" aria-hidden="true"></i></a></h3>
- The stream and trace objects in Obspy both have a number of public methods that can be used to modify the data.
<h4 id="filtering">Filtering</h4>
- One thing we might want to do is look at a specific frequency range of data in our earthquake. We can use the “filter” method for this.

  ```python
  #bandpass filter
  st_filt = st.copy()
  st_filt.filter('bandpass',freqmin = 1.0, freqmax = 20.0) 
  st.plot()
  st_filt.plot()
  ```
  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig12.jpg">
  </p>

<h4 id="trimming-data">Trimming data</h4>
- You can shorten a stream and remove unwanted data with the “trim” method.

  ```python
  print(st[0].stats)
  ```

    ```
    network: IU
    station: TUC
    location: 00
    channel: HH1
    starttime: 2019-07-06T03:18:53.048393Z 
    endtime: 2019-07-06T03:34:53.038393Z
    sampling_rate: 100.0 
    delta: 0.01
    npts: 96000 
    calib: 1.0
    _format: MSEED
    mseed: AttribDict({'dataquality': 'M', 'number_of_records': 1715,
    'encoding': 'FLOAT64', 'byteorder': '>', 'record_length': 512, 'filesize': 878080})
    ```

  ```python
  #say we want to chop 6 minutes off the end of this trace, and 2 minutes off the front
  starttime = st[0].stats.starttime + 2*60 
  endtime = st[0].stats.endtime - 6*60

  st_trim = st_filt.copy() 
  st_trim.trim(starttime=starttime, endtime=endtime) 
  st_filt.plot()
  st_trim.plot()
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig13.jpg">
  </p>

- While trimming data, you also have an option to fill gaps with a value, and for this you just set `fill_value=somenumber` in the method after defining the start and end time.

<h4 id="changing-sampling-rates">Changing sampling rates</h4>

- There are three methods in Obspy for changing the sampling rates of data in a stream or trace:
  1. Decimate: downsamples data by an integer factor
  2. Interpolate: increase sampling rate by interpolating (many method options)
  3. Resample: resamples data using a Fourier method

  ```python
  st_trim[0].stats.sampling_rate
  ```
  ```
  100.0
  ```

  ```python
  st_dec = st_trim.copy() 
  st_dec.decimate(10) 
  st_trim.plot() 
  st_dec.plot()
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig14.jpg">
  </p>

- check the stats again

  ```python
  st_dec[0].stats.sampling_rate
  ```
  ```
  10.0
  ```

<h3 id="matplotlib">Matplotlib <a href="#obspy-outline"><i class="fa fa-angle-double-up" aria-hidden="true"></i></a></h3>

- Let’s examine how we can make some basic plots of seismic data in Matplotlib.

  ```python
  data = st[0].data 
  times = st[0].times()
  print(data)
  print(times)
  print(len(data))
  print(len(times))
  ```

  ```
  [-9.40377808e-07 -9.38652106e-07 -9.40177916e-07 ... -9.52581960e-07 -1.10261625e-06 -9.28648806e-07]
  [0.0000e+00 1.0000e-02 2.0000e-02 ... 9.5997e+02 9.5998e+02 9.5999e+02]
  96000 
  96000
  ```

  ```python
  import matplotlib.pyplot as plt
  plt.plot(times, data);
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig15.jpg">
  </p>

- to clean up this basic plot a bit

  ```python
  net = st[0].stats.network
  sta = st[0].stats.station
  loc = st[0].stats.location
  chan = st[0].stats.channel
  plt.plot(times, data)
  plt.xlim(0,960)
  plt.xlabel('Times (s)')
  plt.ylabel('Ground velocity (m/s)')
  plt.title(f'M7.1 Ridgecrest Earthquake - {net}.{sta}.{loc}.{chan}');
  ```
  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig16.jpg">
  </p>

- use subplots

  ```python
  time = UTCDateTime("2019-07-06T03:19:53.04") 
  starttime = time - 60
  endtime = time + 60*15

  net = "IU" 
  sta = "TUC" 
  loc = "00" 
  chan = "HH*"

  st = client.get_waveforms(net, sta, loc, chan, starttime, endtime, attach_response = True)
  print(st) 
  st.remove_response(output = 'VEL') 
  st.plot();
  ```

  ```
  /Users/utpalkumar50/miniconda3/envs/roses/lib/python3.7/site-packages/obspy/io/stationxml/core.py:84: UserWarning: The StationXML file has version 1.1, ObsPy can deal with version 1.0. Proceed with caution.
  root.attrib["schemaVersion"], SCHEMA_VERSION))

  3 Trace(s) in Stream:
  IU.TUC.00.HH1 | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
  IU.TUC.00.HH2 | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
  IU.TUC.00.HHZ | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig17.jpg">
  </p>

- Let’s plot each of these three channels on their own subplots

  ```python
  for i in range(3): 
    st[i].plot();
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig18.jpg">
  </p>

  ```python
  HH1_data = st[0].data 
  HH1_times = st[0].times()

  HH2_data = st[1].data
  HH2_times = st[1].times()

  HHZ_data = st[2].data 
  HHZ_times = st[2].times()
  ```

  ```python 
  fig= plt.figure(figsize=(8,10))
  plt.subplot(311) 
  plt.plot(HH1_times, HH1_data)

  plt.subplot(312) 
  plt.plot(HH2_times, HH2_data)

  plt.subplot(313) 
  plt.plot(HHZ_times, HHZ_data)
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig19.jpg">
  </p>

- let’s clean it up with some labels, like we did last time, and add some other features like legends and colors

  ```python
  fig = plt.figure(figsize = (8,10))
  plt.suptitle(f"M7.1 Ridgecrest Earthquake - {net}.{sta}.{loc}",fontsize=20) 

  plt.subplot(311)
  plt.plot(HH1_times, HH1_data, label='HH1', color='C0')
  plt.xlim(0,960)
  plt.ylabel('Ground velocity (m/s)',fontsize=14)
  plt.legend()

  plt.subplot(312)
  plt.plot(HH2_times, HH2_data, label='HH2', color='C1') 
  plt.xlim(0,960)
  plt.ylabel('Ground velocity (m/s)',fontsize=14) 
  plt.legend()

  plt.subplot(313)
  plt.plot(HHZ_times, HHZ_data, label='HHZ', color='C2') 
  plt.xlim(0,960)
  plt.ylabel('Ground velocity (m/s)',fontsize=14) plt.legend()
  plt.xlabel('Times (s)', fontsize=14);
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig20.jpg">
  </p>

- plotting UTC times on the x-axis, rather than just seconds from zero, using `matplotlib.dates`

  ```python
  import matplotlib.dates as mdates
  chan = 'HH1'
  HH1_times_mpl = st[0].times(type = 'matplotlib')

  fig, ax = plt.subplots()
  ax.plot(HH1_times_mpl,HH1_data) 
  ax.set_xlim(HH1_times_mpl[0],HH1_times_mpl[-1]) 
  ax.set_xlabel('UTC Time')
  ax.set_ylabel('Ground velocity (m/s)')
  ax.set_title(f"M7.1 Ridgecrest Earthquake - {net}.{sta}.{loc}");
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig21.jpg">
  </p>

- we need to make the dates on the x-axis actually useful. We can do this with a locator.

  ```python
  fig, ax = plt.subplots()
  ax.plot(HH1_times_mpl, HH1_data)
  ax.set_xlim(HH1_times_mpl[0], HH1_times_mpl[-1])
  ax.set_xlabel("UTC Time")
  ax.set_ylabel("Ground Velocity (m/s)")
  ax.set_title("M7.1 Ridgecrest Earthquake - " + net + "." + sta + "." + loc + "." + chan);

  locator = ax.xaxis.set_major_locator(mdates.AutoDateLocator()) 
  ax.xaxis.set_major_formatter(mdates.ConciseDateFormatter(locator))
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig22.jpg">
  </p>


<h2 id="data-and-metadata">Data and Metadata <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h2>

<p align="center">
  <img width="100%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig33.jpg">
    <figcaption>Source: Emily Wolin PPT</figcaption>

</p>

<br>

<p align="center">
  <img width="100%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig32.jpg">
  <figcaption>Source: Emily Wolin PPT</figcaption>

</p>

- The goal is to explore different options in ObsPy’s `remove_response` method and how they affect the output signal after deconvolution.

- start with the usual imports

  ```python
  import obspy
  from obspy.clients.fdsn import Client
  # Edit client to use your data center of interest
  client = Client("IRIS")
  ```

- List of available clients: [https://docs.obspy.org/packages/obspy.clients.fdsn.html]

  ```python
  # Edit this to request metadata from your favorite station(s)
  t1 = obspy.UTCDateTime("2020-07-01")
  inv = client.get_stations(network="IW", station="PLID", channel="BHZ",level="response", starttime=t1)
  inv += client.get_stations(network="GS", station="PR01", channel="HHZ",level="response", starttime=t1)
  # may get a warning about StationXML1.1 -- OK to ignore it
  ```

  ```
  /Users/utpalkumar50/miniconda3/envs/roses/lib/python3.7/site- packages/obspy/io/stationxml/core.py:84: UserWarning: The StationXML file has version 1.1, ObsPy can deal with version 1.0. Proceed with caution.
  root.attrib["schemaVersion"], SCHEMA_VERSION))
  ```

  ```python
  inv.plot_response(min_freq=1e-3) 
  inv.write("inventory.xml", format="stationxml") 
  print(inv)
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig23.jpg">
  </p>

  ```
  Inventory created at 2020-07-02T17:21:09.802508Z 
  Created by: ObsPy 1.1.0
  https://www.obspy.org Sending institution: IRIS-DMC (IRIS-DMC)
  Contains:
          Networks (2):
                  GS, IW
          Stations (2):
                  GS.PR01 (PR01, Lajas)
                  IW.PLID (Pearl Lake, Idaho, USA) 
          Channels (2):
                  GS.PR01.00.HHZ, IW.PLID.00.BHZ
  ```

- Let’s revisit the example in the previous lecture (__Obspy__) using the 2019 M7.1 Ridgecrest earthquake and GSN station IU.TUC in Tucson, Arizona.

  ```python
  time = obspy.UTCDateTime("2019-07-06T03:19:53.04") 
  starttime = time - 60
  endtime = time + 60*15
  net = "IU" 
  sta = "TUC" 
  loc = "00" 
  chan = "HH1"

  # Requesting waveforms with attach_response=True tells ObsPy to request an inventory object for the channels requested.
  st = client.get_waveforms(net, sta, loc, chan, starttime, endtime, attach_response = True)
  print(st)
  st_rem = st.copy() # make a copy of our original stream so we can try different options later
  st_rem.remove_response(output = 'VEL', plot = True) # Use ObsPy defaults to remove response

  # What happens if you choose a different water_level? What if you set water_level = 0?
  st.plot() 
  st_rem.plot(color='red');
  # Remember, if you remove the response from the same trace multiple times, your output will be strange (and non-physical).
  # This is why we make a new copy of st for each example below.
  ```

  ```
  /Users/utpalkumar50/miniconda3/envs/roses/lib/python3.7/site- packages/obspy/io/stationxml/core.py:84: UserWarning: The StationXML file has version 1.1, ObsPy can deal with version 1.0. Proceed with caution.
  root.attrib["schemaVersion"], SCHEMA_VERSION))
  1 Trace(s) in Stream:
  IU.TUC.00.HH1 | 2019-07-06T03:18:53.048393Z - 2019-07-06T03:34:53.038393Z | 100.0 Hz, 96000 samples
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig24.jpg">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig25.jpg">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig26.jpg">
  </p>

- By default, ObsPy removes the mean of the signal and applies a 5% cosine taper to the ends of the signal before removing the response: [https://docs.obspy.org/packages/autogen/obspy.core.trace.Trace.remove_response.html]

- What happens if we don’t remove the mean or taper the signal?? Let's also add a larger offset to the data to mimic a seismometer with masses that have drifted off-center (a common occurrence).

  ```python
  st_rem = st.copy() # repeating this since the last cell will have removed the response from st_rem already
  # ObsPy's remove_response command automatically removes the mean and applies a 5% taper
  # This supresses low and high-frequency artifacts

  # What happens if you turn these off?
  # Let's add a big offset to the data to exaggerate the effects st_rem[0].data = st_rem[0].data + 3e6
  st_rem.remove_response(output = 'VEL', plot = True, taper=0, zero_mean=False)
  st.plot() 
  st_rem.plot(color='green');
  ```
  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig27.jpg">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig28.jpg">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig29.jpg">
  </p>

- use the pre_filt option to apply a filter to your data before removing the response. This helps stabilize the deconvolution and avoids blowing up long-period noise.

  ```python
  st_rem = st.copy() # repeating this since the last cell will have removed the response from st_rem already
  # Use pre_filt command to filter the signal in your frequency band of interest 
  # Here's an example with pre_filt parameters useful for surface-wave studies 
  
  # Experiment with changing the 4 frequencies to see how this modifies the red pre_filt curve in the first row of plots
  # Try modifying it to a frequency band that emphasizes body waves (~1 s) and filters out surface waves (~10s-100s of sec)
  
  # Note: pre_filt is specified in Hz
  # Remember: best not to work too close to Nyquist (highest freq should be no higher than about 0.75*fny)

  print(st_rem[0].stats.sampling_rate)
  st_rem.remove_response(output = 'VEL', plot = True, pre_filt=[0.0036, 0.006, 0.1, 0.5])
  st.plot() 
  st_rem.plot(color='blue');
  ```
    - pre_filt is specified in Hz
    - best not to work too close to Nyquist (highest freq should be no higher than about `0.75*fny`)

  ```
  100.0
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig30.jpg">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig31.jpg">
  </p>

<p align="center">
  <img width="60%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig34.jpg">
  <figcaption>PSDs, PDFs, and noise models. At T>20s, horizontal components are usually noisier than verticals due to local tilt effects. Horizontal noise decreases with increasing depth of installation. Source: Emily Wolin PPT</figcaption>
</p>

<h2 id="time-series-analysis">Time Series Analysis <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h2>

<h3 id="time-series-analysis-outline">Outline</h3>
<ol>
<li><a href="#fft-intuition">Some initial intuition on the FFT</a></li>
  <ol>
    <li><a href="#computing-fft-x-y">Computing FFT of each sequence, x and y</a></li>
    <li><a href="#fft-synthetic-example">A synthetic example</a></li>
  </ol>
<li><a href="#computing-psd">Computing the PSD (or amplitude spectrum)</a></li>
<li><a href="#dealing-fourier-transforms">Good Practices to dealing with Fourier transforms</a></li>
</ol>


<h3 id="fft-intuition">Some initial intuition on the FFT <a href="#time-series-analysis-outline"><i class="fa fa-angle-double-up" aria-hidden="true"></i></a></h3>

Let's visit some examples to understand how most algorithms of the FFT store the data once FFT is computed.

- 
  ```python
  import numpy as np
  import scipy
  import scipy.signal as signal
  import matplotlib.pyplot as plt import obspy
  from obspy.clients.fdsn import Client
  ```

- The Fourier Transform of a real signal is symmetric \\( \hat{f}(\nu) = \hat{f}(-\nu) \\). To demonstrate this, let's take two real-valued random sequences, with 10 and 11 points, zero-mean and \\(\sigma = 0\\).

  ```python
  nx = 10
  ny = 11
  x = np.random.normal(0.0,0.5,(nx,1)) 
  y = np.random.normal(0.0,0.5,(ny,1)) 
  print(x)
  print('')
  print(y)
  ```
  ```
  [[-0.18087004]
  [ 0.42576673]
  [ 0.19175834]
  [ 0.24833008]
  [ 0.38652315]
  [-0.20192222]
  [ 0.71790958]
  [ 0.00834092]
  [ 0.5592964 ]
  [ 0.46869672]]

  [[-0.39022371]
  [-0.94168346]
  [ 0.09322267]
  [-0.30768772]
  [ 0.71110194]
  [-0.43521681]
  [-0.49482095]
  [ 0.42947471]
  [ 1.07826146]
  [-0.7189414 ]
  [ 0.33758408]]
  ```

<h4 id="computing-fft-x-y">Computing FFT of each sequence, `x` and `y`</h4>
Notice the symmetry of the transformed data. Also, how the first point (\\(\nu=0\\) Hz) is real, while the rest is complex. Also, notice the difference between the FFT of an even sequence (\\(x\\) and an odd sequence (\\(y\\)). 

  ```python
  fx = scipy.fft.fft(x, axis=0)
  fy = scipy.fft.fft(y, axis=0)
  print(fx)
  print('')
  print(fy)
  ```
  ```
  [[ 2.62382964-0.j        ]
  [ 0.00395644+0.34132389j]
  [-0.58036663+0.08275716j]
  [-0.31402859+0.28102471j]
  [-1.68852886-0.74734316j]
  [ 0.7254052 -0.j        ]
  [-1.68852886+0.74734316j]
  [-0.31402859-0.28102471j]
  [-0.58036663-0.08275716j]
  [ 0.00395644-0.34132389j]]

  [[-0.6389292 -0.j        ]
  [-1.12257563+1.09506396j]
  [-1.91549567+0.47038812j]
  [ 2.18478857+0.03705081j]
  [-0.73805273+2.49487829j]
  [-0.23543034+2.04411055j]
  [-0.23543034-2.04411055j]
  [-0.73805273-2.49487829j]
  [ 2.18478857-0.03705081j]
  [-1.91549567-0.47038812j]
  [-1.12257563-1.09506396j]]
  ```

- For $nx$ even, the number of frequency points is \\(nf=(nx/2)+1 \\) , that is \\( nx=10\\) , \\(nf=6 \\).

- For $ny$ odd,  the number of frequency points is \\(nf=(nx+1)/2 \\), that is \\( ny=11\\), \\( nf=6\\).

- If you are dealing with a complex time series, or if you want to do correlations, coherence, deconvolution, you need to keep the entire fourier transform it is recommended to use the `scipy.fft.fft`. Just keep in mind $nf$ if you want to plot the PSD. 

  ```python
  # The rfft version
  fx = scipy.fft.rfft(x,axis=0)
  fy = scipy.fft.rfft(y,axis=0)
  print(fx)
  print()
  print(fy)
  ```
  ```
  [[ 2.62382964+0.j        ]
  [ 0.00395644+0.34132389j]
  [-0.58036663+0.08275716j]
  [-0.31402859+0.28102471j]
  [-1.68852886-0.74734316j]
  [ 0.7254052 +0.j        ]]

  [[-0.6389292 +0.j        ]
  [-1.12257563+1.09506396j]
  [-1.91549567+0.47038812j]
  [ 2.18478857+0.03705081j]
  [-0.73805273+2.49487829j]
  [-0.23543034+2.04411055j]]
  ```

- What frequency is represented for the FFT?
The Nyquist frequency in the above example with \\(dt=1.0 s \\), is \\( f_{nyq}=0.5=1/dt\\). 
Note that the frequency array is slightly different, even though \\( nf\\) is the same for both. 

  ```python
  # Define corresponding frequency vector
  freqx = scipy.fft.fftfreq(nx)
  freqy = scipy.fft.fftfreq(ny)
  print(freqx)
  print()
  print(freqy)
  ```
  ```
  [ 0.   0.1  0.2  0.3  0.4 -0.5 -0.4 -0.3 -0.2 -0.1]

  [ 0.          0.09090909  0.18181818  0.27272727  0.36363636  0.45454545
  -0.45454545 -0.36363636 -0.27272727 -0.18181818 -0.09090909]
  ```

  ```python
  # Define corresponding frequency vector
  freqx = scipy.fft.rfftfreq(nx)
  freqy = scipy.fft.rfftfreq(ny)
  print(freqx)
  print()
  print(freqy)
  ```
  - 
  ```
  [0.  0.1 0.2 0.3 0.4 0.5]

  [0.         0.09090909 0.18181818 0.27272727 0.36363636 0.45454545]
  ```

  ```python
  # Freq vector for a long time series
  freq_long = scipy.fft.fftfreq(100*nx)
  print(freq_long[0:3])
  ```
  - 
  ```
  [0.    0.001 0.002]
  ```

Here, the key things to remember are:
- The FFT algorithm (as implemented) displays first the positive frequencies, and then the negative frequencies.
- If the number of points of the time series $nx$ is greater, the frequency sampling \\(df \\) is smaller. **Be careful, smaller frequency sampling, does not mean higher resolution** for example when applying zero-padding.  

<h4 id="fft-synthetic-example">A synthetic example</h4>

The toy signal has a fundamental frequency (that WE NEED to determine), inmersed in a background colored-spectra.
The toy signal really has 10 *realizations*, in the code below one of the *realizations* is randomly selected.

**To avoid complications in explaining the codes, I normalize the spectrum in a quick way (could be better). One should always do it**

$$ var(x) = \int_{-1/2}^{1/2} S(f) df = \sum_{n=0}^{nfft} S(f) * df$$

- 
  ```python
  # Load data. 
  x       = np.loadtxt('test1.dat')
  npts    = np.size(x,0)
  ntr     = np.size(x,1)
  dt      = 1.0  # 1 sps
  t       = np.arange(0,npts)*dt

  # randomly select one trace
  itr     = np.random.randint(0,ntr)
  x2      = x[:,itr]
  xvar    = np.var(x2)

  # Plot time series
  fig = plt.figure()
  ax  = fig.add_subplot(111)
  ax.plot(t,x2)
  ax.set_title('Selected Trace '+str(itr));
  ax.set_xlabel('Time (s)')
  ax.set_ylabel('Amplitude (A.U.)');
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig35.jpg">
  </p>

- Calculate Periodogram (with box car taper).
__Note:__ You should never really do this, but just so you know, this is how one would do it. 

  ```python
  #---------------------------------------
  # Check if data is even or odd, define nf
  #---------------------------------------
  if (npts%2 == 0):
      nf = int(npts/2)+1
  else:
      nf = int((npts+1)/2)+1

  #---------------------------------------
  # Get frequency vector
  #---------------------------------------
  freq = scipy.fft.fftfreq(npts,dt)
  freq=abs(freq[0:nf])
  df = freq[1]

  #---------------------------------------
  # calculate Periodogram (***** bad idea, never do *****)
  #---------------------------------------
  Sp = scipy.fft.fft(x2,npts)
  Sp = abs(Sp)**2
  Ssc = xvar/(np.sum(Sp)*df) #normalize power spectrum Parseval's theorem
  Sp = Sp * Ssc
  Sp = Sp[0:nf]*2.0 #negative and positive part need to be added up

  fig = plt.figure()
  ax = fig.add_subplot(111)
  ax.semilogy(freq,Sp)
  ax.set_title('Trace = '+str(itr))
  ax.set_xlabel('Frequency (Hz)')
  ax.set_ylabel('$A^2/$Hz');
  ```

  <p align="center">
    <img width="80%" src="{{ site.url }}{{ site.baseurl }}/images/roses/fig36.jpg">
  </p>

<h3 id="computing-psd">Computing the PSD (or amplitude spectrum) <a href="#time-series-analysis-outline"><i class="fa fa-angle-double-up" aria-hidden="true"></i></a></h3>
<h3 id="dealing-fourier-transforms">Good Practices to dealing with Fourier transforms <a href="#time-series-analysis-outline"><i class="fa fa-angle-double-up" aria-hidden="true"></i></a></h3>


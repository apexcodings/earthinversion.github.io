---
title: "Remote Online Sessions for Emerging Seismologists (ROSES) Lectures: Revisited [Python]"
date: 2020-07-10
tags: [geophysics, roses, agu, iris, obspy, anaconda, read seismic traces, seismology]
excerpt: "ROSES lecture notes"
classes:
  - wide
---

## Introduction to ROSES
> Amidst many choices for on-learning, on-line networking, and on-line collaboration, the ROSES 2020 summer school will run once a week for 11 weeks, starting on June 25. The school is targeted towards advanced Ph.D. students, who have used Python before and are familiar navigating in Linux/Unix.

- __ROSES__: Remote Online Sessions for Emerging Seismologists
- Organized by: [AGU]( https://www.agu.org), 2020
- ROSES Lectures and Labs will become available on __IRIS__, with some days of delay, at the [this link](https://www.iris.edu/hq/inclass/course/roses).

## Contents
- <a href="#prelecture">Pre-lecture preparation</a>
- <a href="#obspy">ObsPy: a Python toolbox for seismology</a> by Sydney Dybing
- __Data and Metadata__ by Emily Wolin 
- __Time Series Analysis__ by German A. Prieto 
- 7/14 (T) _Waveform Cross Correlation_ by Elizabeth Berg 
- 7/21 (T) _Array Seismology/Network Analysis_ by Stephen Arrowsmith 
- 7/28 (T) _Polarization Analysis_ by Dr. O
- 8/4 (T) _Machine Learning_ by Ross, Zachary E. 
- 8/11 (T)  _PyGMT_ by Liam Toney 
- 8/18 (T) _Inversion, Bayesian_ by Steve Myers 
- 8/25 (T) _Inversion, kriging_ by Tony Lowry 
- 9/1 (T) by Suzan van der Lee


<h2 id="prelecture">Pre-lecture preparation</h2>

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

<h2 id="obspy">ObsPy: a Python toolbox for seismology</h2>
- Download latex generated pdf of the "follow along jupyter notebook" by Sydney Dybing: <a href="https://github.com/earthinversion/Remote-Online-Sessions-for-Emerging-Seismologists-ROSES-Lectures-Revisited/raw/master/Obspy_Tutorial_Follow_Along_Notebook.pdf" download="Codes">
    <img src="https://img.icons8.com/carbon-copy/100/000000/download-2.png" alt="slrm" width="40" height="40"></a>

<h3>Outline</h3>
1. <a href="#obspy-reading-data-file">Reading data from a file</a>
2. <a href="#obspy-downloading-data">Downloading data from online repositories</a>
3. <a href="#removing-instrument-response">Removing instrument response</a>
4. Writing data to a file
5. Some Obspy stream and trace methods
6. Plotting with Matplotlib

<h3 id="obspy-reading-data-file">Reading data from a file</h3>
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

<h3 id="obspy-downloading-data">Downloading data from online repositories</h3>
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


<h3 id="removing-instrument-response">Removing instrument response</h3>

- without removing the instrument response, the data is quantitaitvely meaningless see (<a href="https://books.google.com.tw/books?id=5PPuCgAAQBAJ&pg=PA197&lpg=PA197&dq=10.1007/978-3-319-21314-9_6&source=bl&ots=R_XJrZxu59&sig=ACfU3U2YdUF5_nlVwRFs0Hbvdm5fHI7_Xw&hl=en&sa=X&q=10.1007/978-3-319-21314-9_6&redir_esc=y#v=snippet&q=10.1007%2F978-3-319-21314-9_6&f=false">Havskov and Alguacil, 2015<a>)

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
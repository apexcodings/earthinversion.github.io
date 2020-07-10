---
title: "Remote Online Sessions for Emerging Seismologists (ROSES) Lectures: Revisited [Python]"
date: 2020-07-10
tags: [geophysics, roses, agu, iris, obspy, anaconda]
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
- Download latex generated pdf of the follow along jupyter notebook by Sydney Dybing: <a href="https://github.com/earthinversion/Remote-Online-Sessions-for-Emerging-Seismologists-ROSES-Lectures-Revisited/raw/master/Obspy_Tutorial_Follow_Along_Notebook.pdf" download="Codes">
    <img src="https://img.icons8.com/carbon-copy/100/000000/download-2.png" alt="slrm" width="40" height="40"></a>

<h3>Outline</h3>
1. <a href="#obspy-reading-data-file">Reading data from a file</a>
2. Downloading data from online repositories 
3. Removing instrument response
4. Writing data to a file
5. Some Obspy stream and trace methods
6. Plotting with Matplotlib

<h3 id="obspy-reading-data-file">Reading data from a file</h3>
- With the read function, you basically just only need the path to the file on your computer.
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
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
- __ObsPy__ by Sydney Dybing 
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


## Pre-lecture preparation

### Installation of the environment in anaconda
NOTE: It is important to use specified version of the libraries otherwise there may be some inconsistencies such as the bandpass filter command of `obspy` may throw some error.

- `roses_env.yml` environment yml file can be downloaded from [here](https://github.com/earthinversion/Remote-Online-Sessions-for-Emerging-Seismologists-ROSES-Lectures-Revisited/blob/master/roses_env.yml)
- Install environment using anaconda and the `roses_env.yml`

```
conda env create -f roses_env.yml
```

- [OPTIONAL] Install on macOS (without Anaconda) using the file `roses-env2-osx.txt` (<a href="https://github.com/earthinversion/Remote-Online-Sessions-for-Emerging-Seismologists-ROSES-Lectures-Revisited/find/master" download="Codes">
    <img src="https://img.icons8.com/carbon-copy/100/000000/download-2.png" alt="slrm" width="40" height="40">):

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
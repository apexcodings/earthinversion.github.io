---
title: "Automatically Plotting Record Section for an Earthquake in the Given Time Range [Python]"
date: 2020-07-08
tags: [record section, seismology, obspy, geophysics]
excerpt: "Python code to automatically plot the record section for the highest magnitude earthquake in the given time range"
classes:
  - wide
header:
  teaser: "/images/seismicSection/record_section_example.jpg"
---
{% include toc %}

## Introduction
A seismic record section displays numerous seismic records in a single figure and can be quite useful in the geological interpretation. The ray paths of the seismic waves are curved due to increasing velocity with depth. Hence, the longer the distance to the station from the event, the deeper the ray goes.

Download the complete script: 
<a href="https://github.com/earthinversion/automated_seismic_record_section.git" download="Codes">
    <img src="https://img.icons8.com/carbon-copy/100/000000/download-2.png" alt="seismicSection" width="40" height="40">
</a>

- Code to automatically plot the record section of largest earthquake event within the given time range and geographical selection.
- Define the input parameters in `input_file.yml`
<div class="button_group third">
  <a href="https://github.com/earthinversion/automated_seismic_record_section/blob/master/input_file.yml" class="btn btn--success btn--small" style="font-size:0.6em">View File <code style="color: white; background: transparent;">input_file.yml</code></a>
</div>


- Run the python script `plot_record_section.py`

<div class="button_group third">
  <a href="https://github.com/earthinversion/automated_seismic_record_section/blob/master/plot_record_section.py" class="btn btn--success btn--small" style="font-size:0.6em">View Code for <code style="color: white; background: transparent;">plot_record_section.py</code></a>
</div>

## Run Script
- Install environment for the required packages using either one of the following commands (`spec-file.txt` and `environment.yml` can be downloaded from the github link):
```conda install --name myenv --file spec-file.txt```
```conda env create -f environment.yml```

- Execute script
```python plot_record_section.py```

<img src="{{ site.url }}{{ site.baseurl }}/images/seismicSection/example_inputFile.jpg" width="80%" alt="Input file">


<img src="{{ site.url }}{{ site.baseurl }}/images/seismicSection/record_section_example.jpg" width="80%" alt="Record section 1">


<img src="{{ site.url }}{{ site.baseurl }}/images/seismicSection/runshot1.jpg" width="80%" alt="Runshot 1">
<img src="{{ site.url }}{{ site.baseurl }}/images/seismicSection/runshot2.jpg" width="80%" alt="Runshot 2">


Download the complete script [here](https://github.com/earthinversion/automated_seismic_record_section.git). 

## References
1. [Seismic record sections](https://pubs.geoscienceworld.org/geophysics/article-abstract/16/4/613/67001/Seismic-record-sections?redirectedFrom=fulltext)
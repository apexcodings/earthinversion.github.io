---
title: "Automatically plotting seismic section for an earthquake in the given time range [Python]"
date: 2020-07-08
tags: [seismic section, seismology, obspy, geophysics]
excerpt: "Python code to automatically plot the seismic section for the highest magnitude earthquake in the given time range"
classes:
  - wide
---
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


<img src="{{ site.url }}{{ site.baseurl }}/images/seismicSection/record_section_2013-05-24_SEA-OF-OKHOTSK.png" width="80%" alt="Record section 1">


<img src="{{ site.url }}{{ site.baseurl }}/images/seismicSection/runshot1.jpg" width="80%" alt="Runshot 1">
<img src="{{ site.url }}{{ site.baseurl }}/images/seismicSection/runshot2.jpg" width="80%" alt="Runshot 2">


Download the complete script [here](https://github.com/earthinversion/automated_seismic_record_section.git). 
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
from obspy import read
from obspy.io.xseed import Parser
from obspy.signal import PPSD
```

<h3 id="references">References <a href="#top"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i></a></h3>
<ol>
  <li>McNamara, D. E., & Boaz, R. I. (2006). Seismic noise analysis system using power spectral density probability density functions: A stand-alone software package. Citeseer.</li>
</ol>
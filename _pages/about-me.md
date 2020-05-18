---
title: "About"
permalink: "/about-me/"
classes:
  - wide
---
<ul>
<li> My Ph.D is based on the geophysical data analysis for seismological and geodetic applications. Seismic data gives the capability to inspect the interior of our planet whereas GPS has incredible accuracy for the crustal processes.</li>
<li> Besides Physics and Mathematics, I have acquired background knowledge of Chemistry, Biological Sciences, Computer Sciences, and Electronics in the first 3 years of my intd. BS-MS. This comes handy in my various research endeavors.</li>
<li> I invest significant amount of time in learning new skills for use in data-intensive science, including Python packages like Scikit Learn, SciPy, and machine learning algorithms.</li>
<li> I like to participate in the broader data science community via online webinars, discussions and conferences.</li>
</ul>


<button class="collapsible">Education</button>
<div class="contentCollapse">
<ul style="font-size:0.8em">
  <li><strong>Ph.D., Computational Geophysics:</strong>
    <p>
    __2014 - Current__, National Central University + Academia Sinica (Taiwan International Graduate Program)<br>      
    __Thesis:__ Geophysical Data Analysis for Seismological and GPS based Applications<br>
    __Thesis Advisor:__ [Prof. Benjamin Fong Chao](http://www.earth.sinica.edu.tw/member/info/7), Distinguished Research Fellow, Institute of Earth Sciences, Academia Sinica
    </p>
  </li>
</ul>
</div>


<script>
  document.addEventListener('DOMContentLoaded', () => {
  var coll = document.getElementsByClassName("collapsible");
  var i;
  
  for (i = 0; i < coll.length; i++) {
    coll[i].addEventListener("click", function() {
      this.classList.toggle("active");
      var content = this.nextElementSibling;
      console.log("hi utpal 2");
      if (content.style.maxHeight){
        content.style.maxHeight = null;
      } else {
        content.style.maxHeight = content.scrollHeight + "px";
      } 
    });
  }
});
  </script>





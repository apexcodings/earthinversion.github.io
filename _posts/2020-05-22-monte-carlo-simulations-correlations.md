---
title: "Monte Carlo Simulation to test for the correlation between two dataset [MATLAB]"
date: 2020-05-22
tags: [statistics, matlab, monte-carlo simulations, correlation, geophysics]
excerpt: "We test for the correlation coefficients or the covariance between two sets of random numbers selected from normal distribution using the Monte Carlo simulations."
classes:
  - wide
header:
  teaser: "/images/monteCarloSim.png"
---
{% include toc %}

Monte Carlo Simulations (MCS) can be used to extract important informations from the dataset that would be impossible to assess otherwise. Using MCS rather than the traditional methods to find the relation between two datasets are more intuitive.

### What is Monte Carlo Simulations??
> MCS studies are computer-driven experimental investigations in which certain parameters, such as population means and standard deviations that are known a priori, are used to generate random (but plausible) sample data (Mooney 1997). These generated data are then used to evaluate the sampling behavior of one or more statistics of interest. This process of generating and analyzing data is repeated over many iterations and differing conditions that are thought to influence the sampling behavior of the statistic of interest (e.g., through increasing sample size, mean differences, variability). __[3](https://amstat.tandfonline.com/doi/full/10.1080/10691898.2016.1246953#.XsfmHy-cZ24)__



<figure>
    <img width="400" src="{{ site.url }}{{ site.baseurl }}/images/monteCarloSim.png">
</figure>


```python
%%Monte Carlo simulations of correlation values
clear; close all; clc;
% define
numsim = 10000;   % number of simulations to run
samplesize = 50;  % number of data points in each sample

% pre-allocate the results vector
results = zeros(1,numsim);

% loop over simulations
for num=1:numsim
  
  % draw two sets of random numbers, each from the normal distribution
  data = (randn(samplesize,2).^2)*10+20;
  
  % compute the correlation between the two sets of numbers and store the result
  results(num) = corr(data(:,1),data(:,2));
  
end
% visualize the results
figure; hold on;
hist(results,100);
% ax = axis;
% mx = max(abs(ax(1:2)));  % make the x-axis symmetric around 0
% axis([-mx mx ax(3:4)]);
xlabel('Correlation value');
ylabel('Frequency');
%%
val = prctile(abs(results),95);
val
%%

% visualize this on the figure
ax = axis;
h1 = plot([val val],ax(3:4),'r-');
h2 = plot(-[val val],ax(3:4),'r-');
legend(h1,'Central 95%');
title(sprintf('The values between which most of the correlation values lie is +/- %.4f',val));
saveas(gcf,"monteCarloSim",'pdf')
%%
```

## References:
1. [Lectures on Statistics and Data Analysis in MATLAB](https://www.cmrr.umn.edu/~kendrick/statsmatlab/)
2. [Assessing the Significance of the Correlation between Two Spatial Processes](https://www.jstor.org/stable/2532039?seq=1)
3. [Teaching Statistics With Monte Carlo Simulation](https://amstat.tandfonline.com/doi/full/10.1080/10691898.2016.1246953#.XsfmHy-cZ24)
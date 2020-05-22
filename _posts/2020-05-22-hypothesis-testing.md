---
title: "Hypothesis Test in MATLAB"
date: 2020-05-22
tags: [Statistics, MATLAB, hypothesis testing, Null hypothesis]
excerpt: "Using Randomization to test the disprove the null hypothesis"
classes:
  - wide
---
<figure class="half">
    <img width="400" src="{{ site.url }}{{ site.baseurl }}/images/hypothesis_test.png">
</figure>

```python
%% Hypothesis Testing
clear; close all; clc;
data1=randn(100,1);
data2=(randn(150,1).^2)*10 + 20;
all_data=[data1; data2];
```
- Null hypothesis is that the two distribution that we are sampling are from the same population.


```python
%% First Sample
mu1=mean(data1);

%% Second Sample
mu2=mean(data2);
actualdiffmn=(mu1-mu2)
```

- Now, since our null hypothesis is that the two distribution comes from the same population, we can mix it to draw two samples again.

```python
%% Using Randomization to test the hypothesis
numsim = 10000;   % number of simulations to run
mn1=zeros(1,numsim);
mn2=zeros(1,numsim);
diffmn = zeros(1,numsim);
for num=1:numsim
    % vector of indices (a random ordering of the integers between
    % 1 and n where n is the number of data points)
    indx = randperm(length(all_data));
    data_sim=all_data(indx);
    data_sim1=data_sim(1:length(data1));
    data_sim2=data_sim(1:length(data2));
    mn1(num)=mean(data_sim1);
    mn2(num)=mean(data_sim2);
    diffmn(num)=(mn1(num)-mn2(num));
end

% visualize
figure; hold on;
hist(diffmn,100);
ax = axis;
plot(repmat(actualdiffmn,[1 2]),ax(3:4),'r-');
pval = sum(abs(diffmn) > abs(actualdiffmn)) / length(diffmn);
title(sprintf('Actualdiffmean = %.4f; p-value (two-tailed) = %.6f',actualdiffmn,pval));
legend('Results of simulation','Actual difference in means')
xlabel('Difference in means'), ylabel('Frequency')
```

```
actualdiffmn =
  -28.5153
```
---
title: "Non-linear curve fitting to a model with multiple observational variables in MATLAB"
date: 2020-05-13
tags: [curve-fitting, optimization, lsqfit, non-linear regression]
excerpt: "How to fit data to non-linear model"
mathjax: "true"
classes:
  - wide
---
Non-linear model is the one in which observational data is modeled by a non-linear combination of one or more model parameters and observational variables. 

In the first case, we use 
$$y = f(x1,x2)$$


```
%% Fit Model
% - Utpal Kumar

clear; close all; clc
% generate some random data
Kdp = 0:40;
Zdr = 100:100+length(Kdp)-1;

xdata = [Kdp; Zdr]; %define independent variable 

noise = 0.1*randn(size(xdata(1,:)));
ydata = 26.778*xdata(1,:).^0.946 .*xdata(2,:).^-1.249 + noise; %define dependent, ydata



% define optimization options
options = optimset('Display','iter','FunValCheck','on', ...
                   'MaxFunEvals',Inf,'MaxIter',Inf, ...
                   'TolFun',1e-6,'TolX',1e-6);
paramslb = [-Inf -Inf -Inf];  % lower bound
paramsub = [ Inf Inf Inf];  % upper bound

% define the initial seed
params0 = [20,0.9,-1.2];

% define model function
modelfun = @(pp,xdata) pp(1)*xdata(1,:).^pp(2).*xdata(2,:).^pp(3);

[params,resnorm,residual,exitflag,output] = lsqcurvefit(modelfun,params0,xdata,ydata,paramslb,paramsub,options);
params

% compute model fit
modelfit = modelfun(params,xdata);

% check squared error (the aim is to minimize squared error)
squarederror = sum((ydata(:)-modelfit(:)).^2)


% visualize the data and results
figure;
scatter3(xdata(1,:),xdata(2,:),ydata,'k') %scatter plot of data
hold on
[X,Y] = meshgrid(xdata(1,:),xdata(2,:));  
Z = params(1)*X.^params(2) .*Y.^params(3);
s = surf(X,Y,Z,'FaceColor','interp','FaceAlpha',0.7); %surface plot of the results with the estimated parameters
s.EdgeColor = 'none';
colorbar
title(sprintf('squared error = %.1f; params: [%.2f, %.2f, %.2f]',squarederror,params(1),params(2),params(3)));
```
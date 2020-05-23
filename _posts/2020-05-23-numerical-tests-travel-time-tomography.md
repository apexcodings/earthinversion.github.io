---
title: "Numerical Tests on Travel Time Tomography: Basics"
date: 2020-05-23
last_modified_at: 2020-05-23
tags: [Tomography, Seismic tomography]
excerpt: "Introduction to the concepts of tomography"
mathjax: "true"
classes:
  - wide
---

## Introduction
Tomography, which is derived from the Greek word “tomos” that is “slice”, denotes forming an image of an object from measurements made from slices or rays through it. In other words, forming the structure of an object based on a collection of slices through it.
In principle, it is usually an inverse problem where we have the data, we formulate the geometry of the ray paths and invert for the model parameters that defines the structure.

$$
\begin{aligned}
d &= Gm
\end{aligned}
$$

where, \\( d \\) is the vector containing the data, \\( m \\) is the vector containing the model
parameters and \\( G \\) is the kernel which maps the data into the model and vice-versa. If there are \\( N \\) number of data and \\( M \\) number of model parameters then the size of the matrix \\( G \\) is \\( N \times M \\).

The first step of this problem is to formulate a theoretical relationship between the data and model spaces and the underlying physics. Once, this theoretical relationship is established or the matrix \\( G \\) is formulated, we can address the above problem in two ways – a forward problem or an inverse problem.

The forward problem can be taken as a trial and error process or as an exhaustive search through the model space for the best set of model parameters which can reduce the misfit between the observed and the predicted data. For this case, we guess the model based on the simple real world geology and then determine the data based on the theoretical relationship between data and models. In contrast, in the inverse problem we invert for the model parameters using the data and considering the theoretical relationship between the data and model parameters. Then we interpret for the real world geology.


The solution of the linear tomographic inverse problem depends on the relationship between \\( N \\) and \\( M \\). If \\( N \\) < \\( M \\), then we have more number of model parameters or variables to obtained and lesser number of data or equations to solve. In this case, the equation \\( d = Gm \\) does not provide enough information to determine uniquely all the model parameters and thus the problem is called underdetermined. We usually need extra constraints to solve this kind of problem, for example we take the a priori constraint that the solution to this problem is simple. If \\( N = M \\), then there is ideally enough information to determine the model parameters. But in real world, data is usually inaccurate and inconsistent to invert for the best model parameters in this case. If \\( N > M \\), there is too much information contained in the equation \\( d = Gm \\) for it to possess an exact solution. This case is called the overdetermined.

### Solution of the underdetermined linear inverse problem:
We take the a priori constraint that the solution is simple. The notion of simplicity is quantified by some measure of the length of the solution. One such measure is the Euclidean length of the solution, \\( L = m^{T}m \\).

$$
\begin{aligned}
d &= Gm \\
𝑚^{est} &= 𝐺^T(𝐺𝐺^T)^{-1}𝑑
\end{aligned}
$$

### Solution of the overdetermined linear inverse problem:
$$
\begin{aligned}
d &= Gm \\
𝑚^{est} &= (𝐺^T𝐺)^{-1}𝐺^T𝑑
\end{aligned}
$$

This solution can simply be obtained simply by minimizing the least square error with
respect to the model parameters. (Menke 1989)

### Solution of the Mixed-Determined linear inverse problem:
Most inverse problems that arise in practice are neither completely overdetermined nor completely underdetermined. So, for solving these kinds of problems, ideally we would like to sort the unknown model parameters into two groups- overdetermined and underdetermined. For doing so, we form a set of new model parameters that are linear combinations of the old. Then we can partition from an arbitrary \\( d = Gm \\) to \\( d' = G'm' \\), where \\( m' \\) is partitioned into an upper part that is overdetermined and a lower part that is underdetermined.

$$
\begin{bmatrix}
   G^{'o} & 0 \\
   0 & G^{'o}
\end{bmatrix}
\begin{bmatrix}
   m^{'o} \\
   m^{'u}
\end{bmatrix}
= \begin{bmatrix}
   d^{'o} \\
   d^{'u}
\end{bmatrix}
$$

This partitioning process can be accomplished through singular value decomposition of the data kernel. If this can be achieved then we can determine the overdetermined model parameters by solving the upper equations in the least square sense and determine the underdetermined model parameters by finding those that have minimum least square solution length.

Instead of partitioning \\( m \\), we can determine the solution that minimizes some combination \\( \phi \\) of the prediction error and the solution length for the model parameters.

$$
\phi (m) = (𝑑−𝐺𝑚)^{T} (𝑑−𝐺𝑚) +\epsilon^2 𝑚^T𝑚
$$



__To be Continued__
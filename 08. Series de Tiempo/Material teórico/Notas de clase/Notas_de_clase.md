Stationary Stochastic Time Series Models

Series de Tiempo

UTDT

January 2020

Martin Sola (FE)

Univariate models

01/13

1 / 54

Introduction

Uses of Univariate Times Series models:

1 Forecasting: Need to …nd a model to characterize the series which then is

used to produce a forecast.

2 Finding which process an exogenous driving variable follows (e.g. A process for
Dividends is usually assumed for calculating the fundamental value of Stock
prices)

Martin Sola (FE)

Univariate models

01/13

2 / 54

Modeling a Time Series

Consider a time series

(x1, x2....xn)

as the realization of a stochastic process with distribution given by

p(x1, x2, ..., xn).

Martin Sola (FE)

Univariate models

01/13

3 / 54

In general, fully specifying p is too ambitious: …rst and second moments

n means : E (x1), E (x2), ..., E (xn )
n variances : V (x1), V (x2), ..., V (xn )
n (n

1)

covariances:Cov (xi , xj ), i < j.

(cid:0)
2

However, we only have n data points to estimate 2n + n(n
(cid:0)
2

1)

parameters!

Martin Sola (FE)

Univariate models

01/13

4 / 54

Stationarity

De…nition
A stochastic process is said to be strictly stationary if its properties are
una¤ected by a change in the time origin, that is

l )p(x1, x2, ..., xn) = p(x1+l , x2+l , ..., xn+l )

(1)

(

8

De…nition
A stochastic process is said to be weak stationary if the …rst and second
moments exist and do not depend on time.

E (x1) = E (x2) = ... = E (xt ) = µ

V (x1) = V (x2) = ... = V (xt ) = σ2
k ) = Cov (xt +l , xt

Cov (xt , xt

k +l ) = γk

(cid:0)

(cid:0)

(2)

(3)

(4)

Martin Sola (FE)

Univariate models

01/13

5 / 54

Comments

Covariances are functions only of the lag k, and not of time. These are
usually called autocovariances.
From equations 3 and 4 we can obtain the autocorrelations

ρk =

Cov (x1, x2)
V (x1)V (x2)

2

=

γk
σ2 =

γk
γo

(5)

p
The autocorrelations considered as a function of k are referred to as the
autocorrelation function, ACF
Notice:

γk = Cov (xt , xt

k ) = Cov (xt

(cid:0)

(cid:0)

k , xt ) = Cov (xt , xt +k ) = γ

(6)

k

(cid:0)

Martin Sola (FE)

Univariate models

01/13

6 / 54

Modelling a time Series using Moving Average and
Autoregressive Processes: Using the ACF Function to
identify a series.

µ) and consider the following …rst order M.A. Process,

Lets de…ne yt = (xt
MA(1), for yt :

(cid:0)

Where εt is such that

yt = εt + θ1εt

1

(cid:0)

E (εt ) = 0
V (εt ) = σ2

Cov (εt,εt

(cid:0)

k ) = 0 for all k.

For this process we can:

1 Calculate the …rst and second moments of yt and check the stationarity

condition

2 Check its ACF in oder to use this function to Identify the process.

Martin Sola (FE)

Univariate models

01/13

7 / 54

(7)

(8)

(9)

E (yt ) = 0

E (yt )2 = E (εt + θ1εt

1)2 = σ2(1 + θ2
1)

(cid:0)

E (yt yt

(cid:0)

k ) = E (εt + θ1εt

k + θ1εt

1)

k

(cid:0)

(cid:0)

(cid:0)

1)(εt
(cid:0)
for k = 1
for k > 1

σ2θ1
0

(cid:26)

θ1/(1 + θ2
1)
0

for k = 1
for k > 1

ρk =

(cid:26)

Notice:

1 The MA(1) satis…es the Stationarity Conditions

2 The autocorrelation function, ρk , for a MA(1) has only the …rst term

di¤erent from zero.

Martin Sola (FE)

Univariate models

01/13

8 / 54

A Moving Average of order q: MA(q)

A moving average process of order q can be written as:

yt = εt + θ1εt

1 + θ2εt

(cid:0)

(cid:0)

2 + ... + θq εt

q ,

(cid:0)

t = 1, ..., T

We can calculate the …rst and second moments to check stationarity and also
use the ACF function to Identify the series:

E (yt ) = 0

E (yt )2 = σ2(1 + θ2

1 + θ2

2 + ... + θ2
q )

E (yt yt

k ) =

(cid:0)

q
∑
j =0

8
<

σ2θj θj +k

for k = 1, 2, ..., q

0

for k > q

q
∑
j =0

:
σ2θj θj +k /

q
∑
j =0

θ2
j

for k = 1, 2, ..., q

0

for k > q

ρk =

8
<

The ACF function of a MA(q) process has the …rst q terms di¤erent from
zero and then all equal to zero.

:

Martin Sola (FE)

Univariate models

01/13

8 / 54

Wold’s Decomposition Theorem

Theorem
Every weakly stationary, purely non-deterministic, stochastic process (xt
(cid:0)
be written as a linear combination of uncorrelated random variables. The
representation is given by:

µ) can

(xt

(cid:0)

µ) = εt + θ1εt

=

∞
∑
j =0

θj εt

(cid:0)

Where εt is such that

1 + θ2εt

2 + ...

(cid:0)

(cid:0)
j where θ0 = 1

E (εt ) = 0
V (εt ) = σ2

Cov (εt,εt

(cid:0)

k ) = 0 for all k.

(10)

(11)

(12)

(13)

NB, the MA(1) and the MA(q) are special cases of the theorem and therefore
stationary.

Martin Sola (FE)

Univariate models

01/13

9 / 54

Modelling a Time Series as an Autoregressive Model

An autoregressive process of order p, is written as

yt = φ1yt

1 + φ2yt

(cid:0)

(cid:0)

2 + ... + φp yt

(cid:0)

p + εt ,

t = 1, ..., T

This will be denoted yt ~AR(p)

We will check

1 Under which conditions this processes are stationary

2 Whether we can use the ACF function to identify AR(p) processes.

Martin Sola (FE)

Univariate models

01/13

10 / 54

Consider the following …rst order autorregressive process, AR(1),

yt = φ1yt

1 + εt

(cid:0)

t = 1, ......, T .

Notice that if this relationship is valid for time t, it should also be valid for time
t

1, that is

(cid:0)

Example

Substituting, we get:

and Iterating:

1 = φ1yt

yt

(cid:0)

(cid:0)

2 + εt

1

(cid:0)

yt = φ1(φ1yt
= φ2

2 + εt
(cid:0)
2 + φ1εt

1yt

1) + εt
(cid:0)
1 + εt

(cid:0)

(cid:0)

yt = φ

j
1yt

j + φ

1

j
(cid:0)
1

εt

(cid:0)

(j

(cid:0)

(cid:0)

1) + φ

2

j
(cid:0)
1

εt

(j

(cid:0)

(cid:0)

2) + ... + φ1εt

1 + εt

(cid:0)

Martin Sola (FE)

Univariate models

01/13

11 / 54

If

φ

j

j

< 1, the deterministic component of yt is negligible if j is large enough

yt =

∞
∑
j =0

φ

j
1εt

j

(cid:0)

An AR (1) may be written as a MA (∞) in which the coe¢ cient of εt

(14)

j is φ

j
1.

(cid:0)

Martin Sola (FE)

Univariate models

01/13

12 / 54

AR(1) stationary process

Lemma
When
φ

j

j

< 1, then the AR (1) satis…es the conditions for stationarity

Proof.
The mean exists and does not depend on t

E (yt ) = E (

∞
∑
j =0

φ

j
1εt

(cid:0)

j ) = 0

The Variance exists and does not depend on time

V (yt ) = V (

∞
∑
j =0
∞
∑
j =0

φ

j
1εt

j ) =

E (yt )=0

(cid:0)

E (

∞
∑
j =0

φ

j
1εt

j )2

(cid:0)

φ

2j
1 ε2
t
(cid:0)

j ) = σ2

∞
∑
j =0

φ

2j
1 =

σ2

(1

(cid:0)

φ2
1)

= E (

Martin Sola (FE)

Univariate models

01/13

13 / 54

Proof.
(continues)
The Autocovariances exist and only depend on lag k

E (yt yt

Notice that:

k ) = φ1E (yt
(cid:0)
γk = φ1γk

1yt

k ) + E (εt yt
k )

(cid:0)
(cid:0)
1 + E (εt yt

k )

(cid:0)

(cid:0)

(cid:0)

E (εt yt

(cid:0)

k ) = E [εt (φ

1

j
(cid:0)
1

εt

(j

k

(cid:0)

(cid:0)

(cid:0)

1) + ... + φ1εt

(k

(cid:0)

(cid:0)

1) + εt

k )]

(cid:0)

Given εt is white noise:

Thus

γk = φ1γk

1

(cid:0)

ρk = φ1ρk

1

(cid:0)

(15)

Martin Sola (FE)

Univariate models

01/13

14 / 54

Comments

Whenever the process is stationary the autocorrelation function declines
exponentially:

ρk = φk

1 ρ0.

Example
For φ = 0.5 :

Martin Sola (FE)

Univariate models

01/13

15 / 54

General conditions for stationarity: The use of the lag
operator

De…nition
The lag operator, L, is de…ned by the transformation

Lyt = yt

1

(cid:0)

Notice that the lag operator may also be applied to yt

1 yielding

(cid:0)

Lyt

(cid:0)

1 = yt

2

(cid:0)

Substitution, yields:

(cid:0)
The lag operator can be manipulated in a similar way to any algebraic
quantity.

Lk yt = yt

k

for k

0

(cid:21)

Martin Sola (FE)

Univariate models

01/13

16 / 54

The lag operator

Example
Let us reproduce the MA (∞) representation of the AR (1) process:

yt =

∞
∑
j =0

φ

j
1εt

j

(cid:0)

where we assume

φ1j

j

< 1 . Using L this may be written as:

yt =

∞
∑
j =0

(φ1L)j εt = εt /(1

φ1L)

(cid:0)

This can be rearranged in the following way

(1

φ1L)yt = εt

(cid:0)
yt = φ1yt

1 + εt

(cid:0)

Martin Sola (FE)

Univariate models

01/13

17 / 54

Autoregressive processes using Lag Operators

An AR(p) process may be written as,

(1

(cid:0)

φ1L

(cid:0)

φ2L2

...

(cid:0)

(cid:0)

φp Lp )yt = εt ,

t = 1, ...., T

or

where φ(L) = (1

(cid:0)

φ(L)yt = εt ,
φ2L2

...

φ1L

(cid:0)

(cid:0)

t = 1, ...., T

φp Lp ).

(cid:0)

Martin Sola (FE)

Univariate models

01/13

18 / 54

Stationarity Conditions for Autoregressive processes

The Stationarity condition may be expressed in terms of the roots of the
polynomial of order p in L. Consider an AR (1)

(1

(cid:0)

φ1L)yt = εt ,

t = 1, ...., T .

When we consider the root of (1
greater than 1 (in absolute value) whenever
be stationay whenever L > 1.

(cid:0)

φ1j

j

φ1L) = 0, that is L = 1/φ1, we see it is

< 1.Then the process seems to

In general: an AR (p) is said to be stationary when all the roots of the
polynomial (1

φp Lp ) lie outside the unit circle.

φ2L2

φ1L

...

(cid:0)

(cid:0)

(cid:0)

(cid:0)

Martin Sola (FE)

Univariate models

01/13

19 / 54

Moving Average processes using Lag Operators

Consider the following MA(q) process

yt = (1 + θ1L + θ2L2 + ... + φq Lq )εt

t = 1, ......, T

or

yt = θ(L)εt
where θ(L) = (1 + θ1L + θ2L2 + ... + φq Lq ).

Remark A MA(q) process is said to be invertible if all the roots of the

polynomial (1 + θ1L + θ2L2 + ... + φq Lq ) lie outside the unit circle.

Martin Sola (FE)

Univariate models

01/13

20 / 54

Autoregressive Moving Average Process

De…nition
An autoregressive moving average process of order (p, q), denoted as ARMA(p, q)
is written as

yt = φ1yt

1 + φ2yt

(cid:0)

(cid:0)

2 + ... + φp yt

(cid:0)

p + εt + θ1εt

1 + θ2εt

(cid:0)

(cid:0)

2 + ... + θq εt

q

(cid:0)

t = 1, ......, T

or

Φ(L)yt = Θ(L)εt

Martin Sola (FE)

Univariate models

01/13

21 / 54

Autoregressive Moving Average Process

AR(p) and MA(q) are special cases of the ARMA(p, q) process.

The stationarity of an ARMA process depends solely on its AR part

ARMA is stationary if Φ(L) = 0 lies outside the unit circle

Its invertibility depends only on its MA part

ARMA is invertible if Θ(L) = 0 lies outside the unit circle

If both conditions hold, ARMA can be written as AR (∞) or MA (∞)

Martin Sola (FE)

Univariate models

01/13

22 / 54

Example
ARMA (1,1)

Autocovariance function

yt = φ1yt

(cid:0)

1 + εt + θ1εt

1

(cid:0)

γk = E (yt yt

= φ1γk

(cid:0)

k ) = φ1E (yt
(cid:0)
1 + E (εt yt

1yt
k ) + θ1E (εt

k ) + E (εt yt
(cid:0)
k )
1yt

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

k ) + θ1E (εt

1yt

k )

(cid:0)

(cid:0)

Martin Sola (FE)

Univariate models

01/13

23 / 54

Example
For k = 0

γ0 = φ1γ1 + E (εt (φ1yt

1 + εt + θ1εt

1)) + θ1E (εt

1(φ1yt

(cid:0)

(cid:0)

1 + εt + φ1εt

1)

(cid:0)

(cid:0)

(cid:0)

where

Then:

E (εt

(cid:0)

1(φ1(φ1yt

E (εt (φ1yt
2 + εt

(cid:0)
1 + θ1εt

(cid:0)

(cid:0)

(cid:0)

1 + εt + θ1εt

1)) = σ2

(cid:0)
2) + εt + θ1εt

1)) = (φ1 + θ1)σ2

(cid:0)

γ0 = φ1γ1 + σ2 + θ1(φ1 + θ1)σ2

Martin Sola (FE)

Univariate models

01/13

24 / 54

Example
When k = 1

Thus,

For k

2

(cid:21)

γ1 = φ1γ0 + θ1E (εt

1(φ1yt

(cid:0)

(cid:0)

2 + εt

(cid:0)

1 + θ1εt

2))

(cid:0)

γ1 = φ1γ0 + θ1σ2

γk = φ1γk

1

(cid:0)

Martin Sola (FE)

Univariate models

01/13

25 / 54

Partial Autocorrelations

The ACF can be used to check whether a process is a MA(q), and to
determine q.

The ACF for an AR declines exponentially

However, we cannot guess the order of the AR from the plot of the ACF

Thus, we need to use the Partial Autocorrelation Function, PACF, to
determine the order of the autoregressive process.

Martin Sola (FE)

Univariate models

01/13

26 / 54

Partial Autocorrelation

Consider an AR(1) process, the correlation between yt and yt
through the correlation each other has with yt
The k th partial autocorrelation, φk = φkk , function measures the correlation
which comes only from the direct e¤ect of the k th lag.
To …nd how many partial autocorrelations are di¤erent from zero, we use the
Yule Walker equations

2 comes

(cid:0)

(cid:0)

1

Martin Sola (FE)

Univariate models

01/13

27 / 54

Yule Walker equations

For an autoregressive process of order p the Yule-Walker equations are given by
the following recursion formulae;

ρk = φ1ρk

1 + φ2ρk

2 + φ3ρk

3 + ... + φp ρk

p

for k = 1, ..., p.

(cid:0)

(cid:0)
Then we just need to set k = p or φp = φkk and solve the following system of
equations:

(cid:0)

(cid:0)

ρk = φ11ρk

1 + φ22ρk

2 + φ33ρk

(cid:0)

(cid:0)

(cid:0)

3 + ... + φkk .

Martin Sola (FE)

Univariate models

01/13

28 / 54

Yule Walker equations

Giving values k = 1....k :

ρ1 = φ11ρ0 + φ22ρ1 + φ33ρ2 + ... + φkk ρk
ρ2 = φ11ρ1 + φ22ρ0 + φ33ρ1 + ... + φkk ρk

for k = 1
for k = 2

1

2

(cid:0)

(cid:0)

...

ρk = φ11ρk

1 + φ22ρk

2 + φ33ρk

(cid:0)

(cid:0)

(cid:0)

3 + ... + φkk ρ0

for k = k

It is a k by k system which can be solved for φii (ρ1, ..., ρk ) for i = 1, 2, ...k.

Martin Sola (FE)

Univariate models

01/13

29 / 54

Yule Walker equations

The PACF of an AR(p) has the …rst p terms di¤erent from zero and the rest
equal to zero. The empirical methodology consists in …nding which φkk are
not signi…cantly di¤erent from zero.

Example
AR (1)

Then,

ρk = φ1ρk

1

(cid:0)

ρk = φ11ρk

1

(cid:0)

sin ce p = k = 1,

ρ1 = φ11ρ0

for k = 1.

or
ρ1 = φ11

Martin Sola (FE)

Univariate models

01/13

30 / 54

Example
AR (2)

Thus,

ρk = φ1ρk

1 + φ2ρk

(cid:0)

2

(cid:0)

ρk = φ11ρk

1 + φ22ρk

(cid:0)

(cid:0)

2 since p = k = 2,

Giving values to k

ρ1 = φ11 + φ22ρ1
ρ2 = φ11ρ1 + φ22

for k = 1,
for k = 2,

φ22 =

ρ2
1
ρ2
1

ρ2 (cid:0)
1
(cid:0)

.

Martin Sola (FE)

Univariate models

01/13

31 / 54

Identifying the series through ACF/PACF

For an AR(p) Process: The ACF declines exponentially and the PACF is zero
for lags greater than p

For a MA(p) Process: The ACF is zero for lags greater than q and the PACF
declines exponentially

Martin Sola (FE)

Univariate models

01/13

32 / 54

Box Jenkins Methodology:

Using sample information, we might calculate sample ACF and PACF to try to
identify the right model.

1 Transform the data, if necessary, so that the assumption of covariance

stationarity is a reasonable one.

2 Make an initial guess of small values of p and q for an ARMA(p, q) model

that might describe the transformed series.
3 Estimate the parameters in φ(L) and θ(L)
4 Perform diagnostic analysis to con…rm that the model is indeed consistent

with the observed features of the data.

Martin Sola (FE)

Univariate models

01/13

33 / 54

What’s next:

Empirical properties of sample analogs

Estimation

Martin Sola (FE)

Univariate models

01/13

34 / 54

Correlogram

Basic tool

An inspection of the correlogram may lead to the conclusion that the series is
random, or that exhibits a pattern of serial correlation that which perhaps
can be modeled by a particular stochastic process

Martin Sola (FE)

Univariate models

01/13

35 / 54

Sample ACF and PACF

It can be proved that asymptotically:

ρi (cid:25)
φii (cid:25)
b
c

where T is the sample size

N(0,

N(0,

1
T
1
T

) under H0 : ρi = 0

) under H0 : φii = 0

Martin Sola (FE)

Univariate models

01/13

36 / 54

Signi…cance test

In order to identify using ACF we should test whether the di¤erent
parameters ρk are di¤erent from zero.
Box Pierce Q- Statistic

Q = T

k
∑
i =1

2~χ2(k) under H0 : ρ1 = ... = ρk = 0

ρi

If I don’t reject H0, then,
b
even in large samples.

εt

f

g

is a white noise. This test has low power,

Martin Sola (FE)

Univariate models

01/13

37 / 54

Corrected version

Q (cid:3) = T (T + 2)

k
∑
i =1

2

ρi
T

(cid:0)
b

~χ2(k) under H0 : ρ1 = ... = ρk = 0

i

When the k autocorrelations are calculated for an ARMA(p,q) model, we lose
degrees of freedom. Thus

Q (cid:3)~χ2(k

p

(cid:0)

(cid:0)

q)

Martin Sola (FE)

Univariate models

01/13

38 / 54

Signi…cance test

When we use identifying tools such as :

N(0,

N(0,

1
T
1
T

) under H0 : ρi = 0

) under H0 : φii = 0

ρi (cid:25)
φii (cid:25)
b
c

we …nd that these tools won’t tell us neither whether the preferred model is
mispeci…ed, nor what to do when two di¤erent models seem to be equally
valid.

We will need to estimate these models.

Martin Sola (FE)

Univariate models

01/13

39 / 54

Maximum Likelihood Estimation

Usually when we estimate ARMA(p, q) models we evaluate the conditional
maximum likelihood.

Assume that the …rst max (p, q)observations are known.

Asymptotically, CMLE is equivalent to the MLE and is easier to calculate

Martin Sola (FE)

Univariate models

01/13

40 / 54

Example
AR(1)

where

f (yT , yT

1, ..., y2

j

(cid:0)

y1, φ1, σ2) =

T
∏
i =2

f (yi j

yi

(cid:0)

1, φ1, σ2)

f (yi j

yi

(cid:0)

1, φ1, σ2) =

1
p2πσ

(yt

(cid:0)

φ1 yt
2σ2

(cid:0)

1 )2

e(cid:0)

The objective is to maximize:

=

(T

(cid:0)

L

(cid:0)

1)log (2π).5

(T

(cid:0)

(cid:0)

1) log σ

(cid:0)

T
∑
t =2

(yt

1)2

(cid:0)

φ1yt

(cid:0)
2σ2

Martin Sola (FE)

Univariate models

01/13

41 / 54

Model Selection Criteria

Akaike Criteria (AIC):

AIC (p, q) = log ˆσ2 + 2(p + q)T (cid:0)

1

Shwartz Criteria (SC):

SC (p, q) = log ˆσ2 + (p + q)T (cid:0)
The idea is to weigh likelihood and number of lags.

1 log(T )

It is best when we compare models with the same number of lags

Overparametrized models have less forecast ability

Martin Sola (FE)

Univariate models

01/13

42 / 54

We choose the model with the lower AIC /SC

SC picks more parsimonious models

SC has better large sample properties, while AIC picks overparametrized
models when T

∞

For small samples, AIC may outperform the others

!

If they pick di¤erent models, as SC picks the most parsimonious you should
check the residuals and with AIC you should check for the signi…cance of the
parameters

Martin Sola (FE)

Univariate models

01/13

43 / 54

Forecast

In practice, we only have an approximation to the "true GDP"

identi…cation and estimation errors

Martin Sola (FE)

Univariate models

01/13

44 / 54

Minimum Mean Square Error Forecast

We start with conditional mean

Serves as benchmark

It generates the forecast with the minimum mean square error
ie, if the model is correct, there is no other statistic that produces smaller
forecast errors

Martin Sola (FE)

Univariate models

01/13

45 / 54

Given observations up to, and including yT :

where IT is the information set up to T

b

yT +l

T = E (yT +l j

IT )

j

Martin Sola (FE)

Univariate models

01/13

46 / 54

Notice that for any other forecast

yT +l

j

T , the forecast error maybe divided in two:

T = [yT +l (cid:0)
e
Squaring terms and conditional on T :

yT +l (cid:0)

yT +l

j

yT +l

j

T ] + [

yT +l

T (cid:0)

j

yT +l

T ]

j

e
yT +l

MSE (

T ) = Var (yT +l ) + [

yT +l

j

b

b

T (cid:0)

j

e
E (yt +l j

IT )]2

e

e

Martin Sola (FE)

Univariate models

01/13

47 / 54

One step ahead forecast

Consider the following stationary and invertible ARMA (p, q):

yT +1 = φ1yT + φ2yT

1 + ..... + φp yT

p+1+

εT +1 + θ1εT + θ2εT

1 + ... + θq εT

(cid:0)

(cid:0)

(cid:0)

q+1

(cid:0)

Then,

yt +1

j

We need values for

b

εt

f

g

T = φ1yT + φ2yT
θ1εT + θ2εT

1 + .... + φp yT
(cid:0)
1 + ... + θq εT

(cid:0)
q+1

p+1+

(cid:0)

(cid:0)

to obtain numerical values for the forecast

Martin Sola (FE)

Univariate models

01/13

48 / 54

Example
AR(1)

1 + εT +l

yT +l = φ1yT +l
T = φ1
yT +l

(cid:0)
yT +l
T
T = yT . Then:
b

(cid:0)

1

j

j

j
yT

The initial value is

b

at time T + l

l = 1, 2, ......

b

T = φl

1yT

yT +l

j

b

Martin Sola (FE)

Univariate models

01/13

49 / 54

Example
(continues)
Let’s calculate the forecasting error:

yT +l (cid:0)

yT +l

j

b

1 + εT +l (cid:0)

T = φ1yT +l
(cid:0)
φl
1yT + εT +l + φ1εT +l
φ2
1εT +l

2 + ... + φl
(cid:0)
1

=

1

φl
1yT

(cid:0)

1+
φl
1yT

(cid:0)

εT +l (cid:0)

The forecasting error variance is given by:

V (yT +l (cid:0)

yT +l

j

b

T ) = V (εT +l + φ1εT +l

= (1 + φ2

1 + φ4

1 + ... + φ

(cid:0)

1 + φ2
2(l
1

1εT +l
(cid:0)
1)
)σ2

(cid:0)

2 + ... + φl
(cid:0)
1

1

εT +l )

Martin Sola (FE)

Univariate models

01/13

50 / 54

Example
MA(1)
On T + 1, the equation for MA(1) is given by:

Thus, in general,

yT +1 = εT +1 + θ1εT

yT +l

j

T = ˆεT +l

j

T + θ1 ˆεT +l

T

1

j

(cid:0)

b
yT +l

b

T = θ1εT
= 0

j

for l = 1

for l > 1.

Martin Sola (FE)

Univariate models

01/13

51 / 54

Example
(continues)
The variance of the forecast error for a MA(1) is

V (yT +l (cid:0)

yT +l

j

b

T ) = σ2

= (1 + θ2

1)σ2

for l = 1
for l > 1

Martin Sola (FE)

Univariate models

01/13

52 / 54

Example
ARMA(1, 1)

yT +l

j

b

yt = φ1yt

(cid:0)

1 + εt + θ1εt

1

(cid:0)

T = φ1yT + θ1εT
T

= φ1
= φl

yT +l
1
j
(cid:0)
1yT + φl
(cid:0)
1
b

1

for l = 1
for l > 1

θ1εT

Martin Sola (FE)

Univariate models

01/13

53 / 54

Measuring the Accuracy of Forecasts

Root Mean Squared Error:

RMSE =

v
u
u
t

1
l

T +l
∑
i =T +1

(

Yi

T (cid:0)

j

Yi )2

b

Mean Absolute Error

T +l
∑
i =T +1 j
Remark Which indicator should be used depends of the purpose of the

MAE =

T (cid:0)

Yi j

1
l

Yi

b

j

forecasting exercise. The RMSE will penalize big errors more than
the MAE measure.

Martin Sola (FE)

Univariate models

01/13

54 / 54

Martin Sola (FE)

Univariate models

01/13

54 / 54

Vector Autoregressions

Series de Tiempo

Birkbeck

January 2022

Martin Sola (FE)

Mutivariate Models

01/15

1 / 53

VAR

Uses of Vector Autoregressions:

Forecast

Testing Linear Rational Expectations Models.

Granger Causality.

Impulse Response Analysis.

Variance Decomposition.

STRUCTURE OF THE LECTURE

De…nition and Properties.

Estimation

VAR analysis.

Martin Sola (FE)

Mutivariate Models

01/15

2 / 53

VAR

De…nition
A vector autoregressive (VAR) is simply an autoregressive process for a vector of
variables.
Let us de…ne Wt =

, a matrix A2X 2 and εt =

.

xt
yt

ε1t
ε2t

where

(cid:20)

(cid:21)

(cid:20)

(cid:21)

E (εt ) = 0,

E (εt ε0s ) =

(cid:26)

Ω t = s (Ω = Ω
otherwise
0

0, c 0

Ωc > 0, c

= 0),

Martin Sola (FE)

Mutivariate Models

01/15

3 / 53

6
VAR (1)

Then a VAR(1) may be written as

or

Wt = AWt

1 + εt

(cid:0)

xt = a11xt

yt = a21xt

1 + a12yt

1 + a22yt

1 + ε1t ,

1 + ε2t ,

(cid:0)

(cid:0)

(cid:0)

(cid:0)

Martin Sola (FE)

Mutivariate Models

01/15

4 / 53

VAR(p)

A VAR of order p can be written as

Wt = A1Wt

1 + A2Wt

(cid:0)

(cid:0)

2 + ... + Ap Wt

p + εt

(cid:0)

Using the lag operator

(I

(cid:0)

A1L

(cid:0)

A2L2

...

(cid:0)

(cid:0)

Ap Lp )Wt = εt

The VAR is covariance stationary if all the values of L satisfying
I

= 0 lie outside the unit circle.

...

Ap Lp

A2L2

A1L

j

(cid:0)

(cid:0)

(cid:0)

(cid:0)

j

Martin Sola (FE)

Mutivariate Models

01/15

5 / 53

The Autocovariance Matrix

For a covariance stationary n dimensional vector process we may de…ne the
autocovariance function for a VAR in a way similar to the univariate case:

Γ

k (nxn) = E (Wt W 0t
(cid:0)

k ) where Γ

k (ij ) = cov (Wi ,t , Wj ,t

k )

(cid:0)

Example
Using the above two variables VAR we get the following:

Γ

k (nxn) = E (Wt W 0t
(cid:0)

k ) =

E (xt xt
E (yt xt

(cid:0)

(cid:0)

(cid:20)

k ) E (xt yt
k ) E (yt yt

k )
k )

(cid:0)

(cid:0)

(cid:21)

Martin Sola (FE)

Mutivariate Models

01/15

6 / 53

Comments

Contrary to the univariate case Γk 6

= Γ

(cid:0)

k , instead the correct relationship is:

Γ0k = Γ

k

(cid:0)

Proof.
Leading E (Wt W 0t
(cid:0)
transposing, we obtain:

k ) k periods we get Γ

k (nxn) = E (Wt +k W 0t ). Then,

Γ0k (nxn) = E (Wt W 0t +k ) = Γ

k

(cid:0)

Intuition There is no reason why E (xt yt

1) should be equal to E (xt

1yt ).

(cid:0)

(cid:0)

Martin Sola (FE)

Mutivariate Models

01/15

7 / 53

Example
VAR (1) autocovariance function

Γ

k (nxn) = E (Wt W 0t
(cid:0)

k ) = AE (Wt

1W 0t
(cid:0)

k ) + E (εt W 0t
(cid:0)

k )

(cid:0)

Thus, for k

1 :

(cid:21)

Γ

k (nxn) = AΓk

1.

(cid:0)

Martin Sola (FE)

Mutivariate Models

01/15

8 / 53

Example
(continues)For k = 0:

E (Wt W 0t ) = AE (Wt

1W 0t
(cid:0)

(cid:0)

1)A0 + E (εt ε0t )

or

Γ0 = AΓ0A0 + Ω

In order to obtain Γ0 we use the vec operator

vec(Γ0) = vec(AΓ0A0) + vec(Ω) = (A

A)vec(Γ0) + vec(Ω),

(cid:10)

Using that vec(ABC ) = (C 0 (cid:10)

A)vec(B) :

vec(Γ0) = (I(n)2

(A

(cid:10)

(cid:0)

A))(cid:0)

1vec(Ω).

Martin Sola (FE)

Mutivariate Models

01/15

9 / 53

The companion form

Notice that a VAR(p) may always be re-written as a VAR(1) by de…ning a
vector Ht such that:

Ht = FHt

1 + νt

(cid:0)

where

Ht =

xt
yt
.

xt
yt

i

i

(cid:0)

(cid:0)
.

xt
yt

(p

(p

1)

1)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

2

6
6
6
6
6
6
6
6
6
6
4

3

7
7
7
7
7
7
7
7
7
7
5

A1
I2
(cid:2)
...

2

A2
0
...

... Ap
...
I

0
0

j
j
j

F =

2

4

ε1t
ε2t
..
0

3

7
7
5

3

5

νt = 2

6
6
4

Martin Sola (FE)

Mutivariate Models

01/15

10 / 53

The companion form

Then, the VAR in the Companion form can be expressed in the following way

Ht = FHt

1 + νt

(cid:0)

E (νt ν0t ) =

(cid:26)

Q
0

t = s
otherwise

where

Q(np x np) = 2

6
6
4

Ω 0
.
0
.
.
0
0

0

...

0

...

0

3

7
7
5

Martin Sola (FE)

Mutivariate Models

01/15

11 / 53

The variance covariance matrix can be found noticing that

or

E (Ht H 0t ) = FE (Ht

1H 0t

(cid:0)

(cid:0)

1)F 0 + Q

Σ = F ΣF 0 + Q

where Σ = E (Ht H 0t ).

Γ
Γ

0
01

Γ1
Γ
0

Σ = 2

Γ

0p

Γ

0p

1

(cid:0)

2

(cid:0)

6
6
4

... Γp
Γ
p

(cid:0)

(cid:0)
Γ0

1

2

3

7
7
5

with Γp the autocovariance of the original process

Martin Sola (FE)

Mutivariate Models

01/15

12 / 53

If the process is covariance stationary, then the unconditional variance can be
calculated simply using vec operators, i.e.,

vec(Σ) = vec(F ΣF 0) + vec(Q) = (F
Then the unconditional variance can be obtained as

(cid:10)

F )vec(Σ) + vec(Q),

vec(Σ) = (I(np)2

(F

F ))(cid:0)

1vec(Q).

(cid:0)
Notice as well that the j th autocovariance function of H (denoted Σj ) can be
found by post-multiplying by H 0t

j and taking expectations.

(cid:10)

(cid:0)
j ) = FE (Ht

E (Ht H 0t

(cid:0)

1H 0t

(cid:0)

(cid:0)

j ) + E (νt H 0t

j )

(cid:0)

Martin Sola (FE)

Mutivariate Models

01/15

13 / 53

Thus,

Σk = F Σk

1

(cid:0)

para k = 1, 2, ...

or

Σk = F k Σ.
The k th autocovariance Γk of the original process Wt is given by the n …rst
rows and n columns of Σk = F Σk
1:

Γk = A1Γk

1 + A2Γk

(cid:0)

(cid:0)

(cid:0)
2 + .... + Ap Γk

k = p, p + 1, p + 2, .......

p

(cid:0)

Martin Sola (FE)

Mutivariate Models

01/15

14 / 53

The Conditional likelihood for a vector autoregression.

Let Wt denote an (n
Gaussian VAR.

(cid:2)

1) vector which we assume follows a pth order

Wt = A1Wt

1 + A2Wt

(cid:0)

(cid:0)

2 + ....... + Ap Wt

p + εt

(cid:0)

εt ~N(0, Ω),

The approach is to condition on the …rst p observations (W0, ...W
to base the estimation on the last T observations (WT , ......W1).

(cid:0)

p+1 ) and

f (WT , WT

1, WT

2....W1

W0, ., W

p+1; Θ)

(cid:0)
and maximize with respect to Θ, where Θ is a vector that contains the
elements of A1, A2, A3, ....Ap and Ω.

(cid:0)

(cid:0)

j

Martin Sola (FE)

Mutivariate Models

01/15

15 / 53

Then,

Wt

Wt

j

(cid:0)

1, ..., W

(cid:0)

p+1~N (A1Wt

(cid:0)

1 + ... + Ap Wt

p , Ωn

n)

(cid:2)

(cid:0)

It will be convenient to stack the p lags in a vector xt ,.

1

Wt

(cid:0)
nx 1
Wt
2
| {z }
(cid:0)
nx 1
.
| {z }
Wt
p
(cid:0)
nx 1

| {z }

3

7
7
7
7
7
7
7
7
7
5

npx 1

xt =

2

6
6
6
6
6
6
6
6
6
4

Martin Sola (FE)

Mutivariate Models

01/15

16 / 53

let Π

0 denote the following n

np matrix :

(cid:2)

Thus, the conditional mean is just

Π0 = [A1, A2, A3, ....Ap ]n

np

(cid:2)

Π0xt

Wt

Wt

j

(cid:0)

1,...., W

(cid:0)

p+1~N(Π0xt , Ω)

Therefore,

or

f (Wt
j
= (2π)(cid:0)

Wt
n/2

1, .., W
(cid:0)
1
Ω(cid:0)

(cid:0)
.5 exp[(

p+1; Θ)

j

j

1/2)(Wt

(cid:0)

(cid:0)

Π0xt )0Ω(cid:0)

1(Wt

Π0xt )]

(cid:0)

Martin Sola (FE)

Mutivariate Models

01/15

17 / 53

The joint density conditional on the …rst p observations can be written as:

f (WT , WT
T
∏
t =1

f (Wt

j

1, WT

(cid:0)

(cid:0)

2....W1

W0, ., W

p+1; Θ)

(cid:0)

j
p+1; Θ)

Wt

1, .., W

(cid:0)

(cid:0)

=

Taking logs

L(Θ) =

T
∑
t =1

ln[f (Wt

Wt

j

(cid:0)

1, .., W

(cid:0)

p+1; Θ)]

=

(cid:0)

(cid:0)

(Tn/2)log (2π) + (T /2)log

(1/2)

T
∑
t =1

(Wt

(cid:0)

Π0xt )0Ω(cid:0)

Ω(cid:0)

1

j

j
1(Wt

Π0xt )

(cid:0)

Martin Sola (FE)

Mutivariate Models

01/15

18 / 53

Estimating the parameters in A

It turns out to be that the maximum likelihood estimator is

ˆΠ0 = [

T
∑
t =1

Wt x 0t ][

T
∑
t =1

xt x 0t ](cid:0)

1

where the j column is just

ˆπj (1

(cid:2)

np) = [

T
∑
t =1

Wjt x 0t ][

T
∑
t =1

xt x 0t ](cid:0)

1

Martin Sola (FE)

Mutivariate Models

01/15

19 / 53

The Maximum likelihood estimator of

Ω

We can now ”concentrate” the likelihood using the previous results to …nd
the MLE estimator of Ω
Evaluate the likelihood at the estimate of Π

L(Ω, ˆΠ) =

(cid:0)

(Tn/2)log (2π) + (T /2)log

Ω(cid:0)

1

j (cid:0)

(1/2)

T
∑
t =1

Ω(cid:0)

1 ˆεt

ˆε0t

Using the di¤erentation rules ∂x 0Ax
derivative of L(Ω, ˆΠ) with respect to Ω

1

(cid:0)

j
∂A = xx 0, ∂ log

A
∂A =
j
j

1

A(cid:0)

0and taking the

(cid:0)

(cid:1)

(ˆεt ˆε0t ).

∂L(Ω, ˆΠ)
∂Ω

(cid:0)

1 = (T /2)Ω0

(1/2)

(cid:0)

T
∑
t =1

Equating this expression to zero we obtain the MLE of the
variance-covariance matrix.

ˆΩ0 = (1/T )

T
∑
t =1

(ˆεt ˆε0t )

Martin Sola (FE)

Mutivariate Models

01/15

20 / 53

Comments

Row i, column i of ˆΩ is given by

ˆσ2
i = (1/T )

T
∑
t =1

(ˆε2
it )

which is just the average squared residual from a regression of
a variable of the VAR on the p lags of all variables
Therefore I can use OLS results to construct both ˆΩ and ˆΠ.

Martin Sola (FE)

Mutivariate Models

01/15

21 / 53

Choosing the order of VAR

1 The validity of the tests we carry out depend on having identi…ed the order of

the VAR correctly

A simple way to do so is comparing likelihood ratios

These can be easily computed because we are using OLS

Consider the likelihood function at is Maximum value of a VAR with p0 lags:

L0( ˆΩ, ˆΠ) =

(cid:0)

(Tn/2)log (2π) + (T /2)log

ˆΩ(cid:0)

1
0 j (cid:0)

j

(1/2)

T
∑
t =1

ˆε0t ˆΩ(cid:0)

1
0 ˆεt .

Martin Sola (FE)

Mutivariate Models

01/15

22 / 53

Consider now the last term of this equation,

(1/2)

T
∑
t =1

=

TR (A.B )=TR (B .A)

ˆε0t ˆΩ(cid:0)

1
0 ˆεt =

TR((1/2)

T
∑
t =1

ˆε0t ˆΩ(cid:0)

1
0 ˆεt )

( a scalar )

|{z}
(1/2)TR(

T
∑
t =1

ˆΩ(cid:0)

1
0 ˆεt ˆε0t )

=
|{z}

(1/2)TR( ˆΩ(cid:0)

1
0 T ˆΩ0)

ˆΩ0=∑T

t =1 ˆεt ˆε0t /T )
= (T /2)TR(I ) = (nT )/2.
|{z}

Thus,

L0( ˆΩ, ˆΠ) =

(cid:0)

(Tn/2)log (2π) + (T /2)log

ˆΩ(cid:0)

1
0 j (cid:0)

j

(nT )/2

Martin Sola (FE)

Mutivariate Models

01/15

23 / 53

If we want to test the Hypothesis that the VAR has p lags against p0 lags we
calculate the likelihood for the VAR with p1 lags (p1 > p0 )

L1( ˆΩ, ˆΠ) =

(cid:0)

(Tn/2)log (2π) + (T /2)log

ˆΩ(cid:0)

1
1 j (cid:0)

j

(nT )/2

and compute the likelihood ratio which is

2(L1( ˆΩ, ˆΠ)
(cid:0)
1
ˆΩ(cid:0)
1 j (cid:0)

L0( ˆΩ, ˆΠ))
1
ˆΩ(cid:0)
log
0 j

j

j

= T (log

under H0

)~χ2(n2(p1

p0))

(cid:0)

Sims (1980) proposed the following for small samples:

where k = np1 = max

f

(T

k)(log

ˆΩ(cid:0)

1
1 j (cid:0)

log

ˆΩ(cid:0)

1
0 j

)

(cid:0)

j
number of parameters estimated per equation

j

g

Martin Sola (FE)

Mutivariate Models

01/15

24 / 53

Goodness of Fit Criteria

Measures how good a model is relative to others

Balance between …t and complexity

Typically, we would like to minimize:

C (p) =

(cid:0)

2max(logL) + β(number of freely estimated parameters)

For Gaussian models, the maximized log-likelihood is proportional to

(T /2)log

(cid:0)

Ω

j

j

(since

1

Ω(cid:0)

j

j

= 1/

Ω

)

j

j

Martin Sola (FE)

Mutivariate Models

01/15

25 / 53

Goodness of Fit Criteria

Hence, we choose p to minimize:

C (p) = Tlog

+ β(n2p)

Ω

j

j

For example

β = 2 (Akaike information criterion)

AIC
SBC β = log (T ) (Scharz Bayesian criterion)
HQ

β = 2log (log (T )) (Hannan-Quin criterion)

Alternatively the Akaike’s prediction error (FPE) criterion chooses p so that
to minimize the expected one -step ahead squared forecast error:

FPE = [

T + np + 1
1
np
T

(cid:0)

(cid:0)

Ω

]n

j

j

Martin Sola (FE)

Mutivariate Models

01/15

26 / 53

Asymptotic Distribution of the VAR estimators

MLE will give consistent estimators of Π and Ω
Standard errors of ˆΠ are given by standard OLS formulas
Let ˆπT = vec( ˆΠT ) denote the nk
OLS. Then

(cid:2)

1 vector of coe¢ cients resulting from

pT ( ˆπT (cid:0)

π) L
(cid:0)!

N(0, Ω

1)

Q (cid:0)

(cid:10)

where Q = E (xt x 0t ).
Standard OLS t and F statistics applied to the coe¢ cients of any single
equation in the VAR are asymptotically valid.

Martin Sola (FE)

Mutivariate Models

01/15

27 / 53

Testing Rational Expectations Hypothesis

These models usually impose non-linear cross equation restrictions between
the parameters of the model which are tested using a likelihood ratio test

Consider a …rst order bivariate VAR:

xt = a11xt
yt = a21xt

(cid:0)

1 + a12yt
1 + a22yt

(cid:0)

1 + εt
1 + νt

(cid:0)
where xt is the interest rates di¤erential and yt is the …rst di¤erence of the
logs of the spot exchange rate

(cid:0)

Then uncovered interest parity can be written as

xt = Et yt +1.

Martin Sola (FE)

Mutivariate Models

01/15

28 / 53

Testing Rational Expectations Hypothesis

Condition on both sides of the previous equation on t
following restrictions

(cid:0)

1,we get the

1

0

A =

0

1

A2

(cid:2)
which can be expressed as:

(cid:3)

(cid:2)

(cid:3)

a11 = a22a21/(1

a21)

(cid:0)

a12 = a2

22/(1

a21)

(cid:0)

Estimate the unrestricted and the restricted model and perform a likelihood
ratio test:

2(Lu

(cid:0)

Lr )~asymptotically χ2

Martin Sola (FE)

Mutivariate Models

01/15

29 / 53

Granger Causality

De…nition
y fails to Granger-cause x if for all s > 0 the mean squared error of a forecast of
xt +s based on (xt , xt
1, ....) is the same as the MSE of a forecast of xt +s based
on (xt , xt

1, ....). For linear functions

1, ....) and (yt , yt

(cid:0)

(cid:0)

(cid:0)

MSE [E (xt +s

xt , xt

j

(cid:0)

1, ....)] = MSE [E (xt +s

xt , xt

j

(cid:0)

1, ...., yt , yt

1, ....)]

(cid:0)

Remark Granger’s reason for proposing this de…nition was that if an event

Y is the cause of another event X, then the event Y should precede
the event X.

Martin Sola (FE)

Mutivariate Models

01/15

30 / 53

Granger Causality

The null hypothesis is that y fails to Granger - cause x

We just regress both the general model

xt = a11xt

1 + a12yt

1 + ε1t

(cid:0)

(cid:0)

and the restricted model

xt = a11xt

1 + ε01t

(cid:0)

and compare the residuals sum squares
T (RRS (ε0)

RRS (ε))/RRS (ε)~χ2(1) (asymptotically)

(cid:0)

Martin Sola (FE)

Mutivariate Models

01/15

31 / 53

Conditioning on the correct information set

Omitting a relevant variable in the information set may give spurious results,
since a variable that is thought to be useful for forecasting others, may be
not longer useful once you condition on the right information.

The question of whether a scalar y can help forecast another scalar x needs
to be accommodated considering the information about z.
Then, y fails to Granger-cause x if for all s > 0 the mean squared error of a
1...) is the same as the MSE of a
forecast of xt +s based on (xt , xt
1, .zt , zt
forecast of xt +s based on (xt , xt
1, ....). For linear
1...) and (yt , yt
1, .zt , zt
functions

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

MSE [E (xt +s
= MSE [E (xt +s

xt , xt
xt , xt

j
j

(cid:0)

(cid:0)

1, .zt , zt
(cid:0)
1, ..zt , zt

1, .)]
1.., yt , yt

(cid:0)

1, .)]

(cid:0)

Martin Sola (FE)

Mutivariate Models

01/15

32 / 53

Granger Causality

Example
The Market e¢ ciency hypothesis yields prices as a function of dividends:

Pt =

∞
∑
i =1

(1/(1 + r ))i E (Dt +i j

It )

Suppose

where ut and νt are independent white noise processes, then

Dt = d + ut + δut

1 + νt

(cid:0)

Et Dt +i =

(cid:26)

d + δut
d

for i = 1
for i = 2, 3, ...

Martin Sola (FE)

Mutivariate Models

01/15

33 / 53

Granger Causality

Example
The stock prices will be given by

Pt = d /r + δut /(1 + r )

Thus,Pt is a white noise: no series should granger cause stock prices.
Nevertheless, notice that:

(cid:0)
Substituting back in the Dt :

δut

1 = (1 + r )Pt

(1 + r )d /r

1

(cid:0)

(cid:0)

Dt = d + ut + (1 + r )Pt

(1 + r )d /r + νt

1

(cid:0)

(cid:0)

Thus stock prices Granger cause dividends

Martin Sola (FE)

Mutivariate Models

01/15

34 / 53

Granger Causality

Example
The bivariate VAR takes the form

Pt
Dt

=

(cid:21)

(cid:20)

d /r
d /r

(cid:0)

(cid:20)

+

(cid:21)

(cid:20)

0
(1 + r )

0
0

Pt
Dt

(cid:21) (cid:20)

1
1

(cid:0)

(cid:0)

+

(cid:21)

(cid:20)

δut /(1 + r )
ut + νt

(cid:21)

Hence in this model, Granger causation runs in the opposite direction from the
true causation.

Martin Sola (FE)

Mutivariate Models

01/15

35 / 53

Impulse Response Functions

Recall a stationary VAR has a VMA(∞) representation:

Wt =

∞
∑
z =0

ψz εt

z

(cid:0)

, ψ0 = I

Lead the above expression s periods:

Wt +s =

∞
∑
z =0

ψz εt +s

z

(cid:0)

Evaluate the above expression at z = s. Then

ψs =

∂Wt +s
∂ε0t

has the interpretation of a dynamic multiplier

Martin Sola (FE)

Mutivariate Models

01/15

36 / 53

Impulse Response Functions

(ψs )ij = e¤ect of a one unit increase in the j th variable’s innovation at time
t (εjt ) for the value of the i th variable at time t + s (Wi ,t +s ), holding all
other innovations at all dates constant

You can …nd these multipliers numerically by simulation:

set Wt = ... = Wt
and simulate the system

(cid:0)

p = 0, then set εjt = 1 and all the other terms to zero,

Wt = A1Wt

1 + A2Wt

2 + ... + Ap Wt

p + εt

(cid:0)
for t, t + 1, t + s, with εt +1, εt +2, .... = 0 This simulation corresponds to the J
column of the matrix ψs . By doing this for other values of j we get the whole
matrix.

(cid:0)

(cid:0)

Martin Sola (FE)

Mutivariate Models

01/15

37 / 53

Impulse Response Functions

De…nition
A plot of (ψs )ij , that is row i column j of ψs , as a function of s is called the
impulse response function. It describes the response of Wi ,t +s to a one time
impulse in Wjt with all other variables dated t or earlier held constant.

Martin Sola (FE)

Mutivariate Models

01/15

38 / 53

Impulse Response Functions

De…ne interim multipliers:

and the long run multiplier:

m
∑
j =1

ψj

∞
∑
j =1

ψj .

Martin Sola (FE)

Mutivariate Models

01/15

39 / 53

Impulse Response Function

The assumption that a shock in one innovation does not a¤ect others is
problematic since

E (εt ε0t ) = Ω

= a diagonal matrix

Since Ω is symmetric and positive de…nite, it can be expressed as

where A is a lower triangular matrix and D is a diagonal Matrix.

Ω = ADA0

Martin Sola (FE)

Mutivariate Models

01/15

40 / 53

6
Impulse Response Function

Let ut = A(cid:0)

1εt , then
∞
∑
j =0

Wt =

where

ψj εt

j =

(cid:0)

∞
∑
j =0

ψj AA(cid:0)

1εt

j =

(cid:0)

∞
∑
j =0

ψ(cid:3)j ut

j

(cid:0)

ψ(cid:3)j = ψj A

E (ut u0t ) = E (A(cid:0)

1)0) = A(cid:0)
The matrix D gives the variance of ujt

1εt ε0t (A(cid:0)

1Ω(A(cid:0)

1)0 = A(cid:0)

1ADA0(A(cid:0)

1)0 = D

Martin Sola (FE)

Mutivariate Models

01/15

41 / 53

Impulse Response Function

A plot of ψ(cid:3)s as a function of s is known as an orthogonalized impulse
response function.

The matrix

ψ(cid:3)s =

∂Wt +s
∂u0t

gives the consequences of an increase in Wjt by a unit impulse in ut .
Notice that

ψ(cid:3)0 = ψ0A = IA

is lower triangular. This implies that the ordering of variables is of
importance.

The ordering cannot be determined with statistical methods.

Martin Sola (FE)

Mutivariate Models

01/15

42 / 53

Variance Decomposition

Consider the error in forecasting a VAR s periods ahead:

Wt +S (cid:0)

Wt +S

t =

j

s
1
∑
(cid:0)
j =0

ψj εt +s

j ,

(cid:0)

ψ0 = I

The mean squared error of this s-period ahead forecast is thus

c

MSE (

Wt +s

j

t ) = Ω + ψ1

Ωψ01 + ... + ψs

Ωψ0s

1

(cid:0)

1

(cid:0)

Let us now consider how each of the orthogonalized disturbances (u1t , ..unt )
contributes to this MSE.

c

Martin Sola (FE)

Mutivariate Models

01/15

43 / 53

Variance Decomposition

Lets write

εt = Aut = a1u1t + ....anunt ,

where aj denotes the j th column of the matrix A.
Recalling that the u’s are uncorrelated, we get

Ω = a1a01(n

(cid:2)

n)Var (u1t ) + ... + ana0n(n

n)Var (unt )

(cid:2)

Martin Sola (FE)

Mutivariate Models

01/15

44 / 53

Variance Decomposition

Substituting this in the MSE of the s period ahead forecast we get

MSE (

Wt +s

t ) =

j

n
∑
j =1

Var (ujt )(aj a0j + ψ1aj a0j ψ01 + ... + ψs

1aj a0j ψ0s

1)

(cid:0)

(cid:0)

c

With this expression we can calculate the contribution of the j th
orthogonalized innovation to the MSE of the s-period ahead forecast.

Var (ujt )(aj a0j + ψ1aj a0j ψ01 + ψ2aj a0j ψ02... + ψs

1aj a0j ψ0s

1)

(cid:0)

(cid:0)

Magnitude in general depends on the ordering of the variables

Martin Sola (FE)

Mutivariate Models

01/15

45 / 53

Structural VARs

Blanchard (1989) considers the following structure

ε1t = eu2t + u1t

ε2t = c21ε1t + u2t

where u1t and u2t are regarded as demand and supply shocks, while ε1t and
ε2t are output and unemployment innovations respectively

Martin Sola (FE)

Mutivariate Models

01/15

46 / 53

Structural VARs

Blanchard and Quah (1989) :

They argue that a demand shock should have a zero long-run e¤ect while a
supply shock will not.

ε1t = a1u2t + u1t
ε2t = a2u1t + u2t

where the covariance of ujt is assumed to be zero.

Consider

Wt = A1Wt

1 + A2Wt

(cid:0)

(cid:0)

2 + ... + Ap Wt

p + εt

(cid:0)

is estimated and the implied MA representation is

Wt =

∞
∑
z =0

ψz εt

z

(cid:0)

, ψ0 = I .

Martin Sola (FE)

Mutivariate Models

01/15

47 / 53

Structural VARs

In terms of the shocks of interest, we will write

where A is now de…ned as

εt = Aut

A =

(cid:20)

1
a2

a1
1

.

(cid:21)

The MA representation in terms of the ut shocks becomes:

Wt =

∞
∑
z =0

ψz Aut

z

(cid:0)

, where ψ0 = I

If the long run e¤ect of a demand shock upon output say, W1t , is to be zero:

[

∞
∑
z =0

ψz A][1,1] = 0

Martin Sola (FE)

Mutivariate Models

01/15

48 / 53

Structural VARs

To see how we compute this restriction we …rst notice that

∞
∑
z =0

ψz

is a 2x2 Matix. Let the …rst row of this matrix be

[δ1, δ2]

Then, the restriction is just

δ1 + a2δ2 = 0 or a2 =

δ1/δ2.

(cid:0)

Thus one parameter can be found from this restriction

Martin Sola (FE)

Mutivariate Models

01/15

49 / 53

The other three come from the fact that:

V (εt ) = A

σ2
1
0

(cid:20)

0
σ2
2 (cid:21)

A0

since there are three unknowns in V (εt ) to determine a1, σ2
All that is needed is to estimate δ1, δ2 .

1 and σ2
2.

Martin Sola (FE)

Mutivariate Models

01/15

50 / 53

Notice that the long run multiplier is easy to compute, since we know that

∞
∑
z =0

ψz = ψ(1)

∞
∑
z =0

ψz Li = ψ(L)

∞
∑
z =0

ψz Li = (I

ψ(1) = (I

(cid:0)

(cid:0)

A1L

(cid:0)

A2L2

(cid:0)

... + Ap Lp )(cid:0)

1 = A(L)(cid:0)

1

A1

A2

(cid:0)

(cid:0)

....... + Ap )(cid:0)

1 = A(1)(cid:0)

1

All the information that is needed for the impulse response function, is
obtained from the estimated parameters in the VAR.

Martin Sola (FE)

Mutivariate Models

01/15

51 / 53

Impulse Resonponse Functions using Local Projections

It has been proposed in the literature an alternative way of carrying out
impulse response functions by doing local projections.
you have a VAR(1) (which can be the companion form of a VAR(p) ) of the
type.

Assume you know

Yt = AYt
Now instead of analysing the MA(∞) we substitute backwards τ times to get

1 + εt

(cid:0)

Yt +τ = Aεt +τ

1 + A2εt +τ

(cid:0)

(cid:0)

2 + ... + Aτεt + Aτ+1Yt

1 + εt +τ

(cid:0)

or

where

Yt +τ = Aτ+1Yt

1 + ut +τ

(cid:0)

ut +τ = Aεt +τ

1 + A2εt +τ

(cid:0)

(cid:0)

2 + ... + Aτεt + εt +τ

Martin Sola (FE)

Mutivariate Models

01/15

52 / 53

Then the coe¢ cient of a regression of regression of Yt +τ on Yt

interpretation of

, that is the the τ + 1 impulse response

∂Yt +τ
∂εt
1

(cid:0)

1 has the

(cid:0)

Points to consider

1) The shock needs to be identify. We can simply do an orthogonalization.
∂Yt +τ
∂Bεt
1

= Aτ+1B (cid:0)

1.

(cid:0)
where Bεt
2) If It is a VAR(1), then estimating

1 is the orthogonal shock.

(cid:0)

Yt +τ = Aτ+1Yt

1 + ut +τ

(cid:0)

give unbiased but probably very imprecise estimates of Aτ+1, with standard errors
that need to be corrected (all that can be done using the theoretical structure of
ut +τ).

Martin Sola (FE)

Mutivariate Models

01/15

53 / 53

Non-Stationary Stochastic Time Series Models

Series de Tiempo

UTDT

January 2020

Martin Sola (FE)

Univariate models

01/11

1 / 45

Non-Stationary Series

Importance of cheking for the existence of Unit Roots:

Standard assymptotical theory is not valid

Possibility of Spurrious Regressions.

Regress series of the same order of integration.

STRUCTURE OF THE LECTURE

De…nition and Properties.

Estimation

Testing for Unit Roots.

Martin Sola (FE)

Univariate models

01/11

2 / 45

Time series

There are three important types of time series which one is likely to …nd in
…nancial econometrics:

Stationary, I (0)
Trend stationary
Non-stationary, I (1)

We have focused until now on stationary processes

Martin Sola (FE)

Univariate models

01/11

3 / 45

Trend stationary

De…nition
A trend stationary variable is a variable whose mean grows around a …xed trend.
This provides a classical way of describing an economic time series which grows at
a constant rate. A trend-stationary series tends to evolve around a steady, upward
sloping curve without big swings away from that curve. For simplicity assume that
the following process.

yt = α + µt + εt where εt ~N(0, σ2)

Notice that the mean of this process varies with time but the variance is constant.

E (yt ) = α + µt

V (yt ) = E (α + µt + εt

(α + µt))2 = σ2

(cid:0)

Remark: y (cid:3)t = yt

(cid:0)

(α + µt) then y (cid:3)t

is stationary.

Martin Sola (FE)

Univariate models

01/11

4 / 45

A Non stationary Series: I(1) Processes

De…nition

An autoregressive process of order p, AR(p), has a unit root if the polynomial in
L, (1
process with a unit root is a random walk, i.e.,

...φp Lp ) has a root equal to one. The simplest example of a

φ1L

(cid:0)

(cid:0)

where εt is i.i.d. with zero mean and constant variance.

yt = yt

1 + εt

(cid:0)

Martin Sola (FE)

Univariate models

01/11

5 / 45

We can easily see that the variance of this processes does not exist: lagging
the process one period we can write

1 = yt

yt

(cid:0)

2 + εt

1,

(cid:0)

(cid:0)

and substituting back we get

Then, repeating this procedure we can easily show that

yt = yt

2 + εt

(cid:0)

(cid:0)

1 + εt .

yt = y0 + ε1 + ε2 + ... + εt

1 + εt

(cid:0)

Martin Sola (FE)

Univariate models

01/11

6 / 45

The mean can be calculated assuming that y0 is …xed, then the mean is
constant over time

E (yt ) = E (y0 + ε1 + ε2 + .... + εt

1 + εt ) = y0

(cid:0)

The variance of yt , ”conditional” on knowing y0, can be computed as

V (yt ) = V (y0 + ε1 + ε2 + .... + εt

1 + εt )

(cid:0)
= V (ε1) + V (ε2) + ... + V (εt

1) + V (εt ) = tσ2

(cid:0)

As we move further into the future this expression becomes in…nite. We
conclude that the variance of a unit root process is in…nite.

Martin Sola (FE)

Univariate models

01/11

7 / 45

Comments

A unit root process will only cross the mean of the sample very infrequently
A process that has a unit root is also called integrated of order one,
denoted as I (1)
A stationary process is an integrated of order zero process, denoted as I (0)
Why is this important?

The study of econometric models with non-stationary data has been one of
the most important concerns of econometricians in the last 30 years. The
topic is very vast and we just will mention some of the most important issues.

Martin Sola (FE)

Univariate models

01/11

8 / 45

Spurious Regressions

Granger and Newbold (1974) have shown that, using I (1), you can obtain an
apparently signi…cant regression (say with a high R 2 ) even if the regressor
and the dependent variable are independent.
They did this by generating independent random walk series against each
other
Rule of thumb: whenever you obtain a very high R 2 and a very low DW you
should suspect that the result are spurious.

the reason for the low DW will be understood in what is to come

Martin Sola (FE)

Univariate models

01/11

9 / 45

Regressing Series that are integrated of the same order

Caution!

You should always check that the variables you are regressing one
against the other are of the same order if you are to obtain
meaningful results

Martin Sola (FE)

Univariate models

01/11

10 / 45

Testing for unit roots

We will show that the standard t- test cannot be applied to a process with a
unit root

under the null of α = 1 we get a degenerated distribution

We will …nd a distribution for

α under this circumstances and see that:

1

2

it is not t - student
it is biased to the left

b

Martin Sola (FE)

Univariate models

01/11

11 / 45

Testing for Unit Roots (II)

Consider the following model:

yt = αyt

1 + εt

(cid:0)

where εt is assumed to be N(0,σ2). It can easily be shown that asymptotically

α) L
(cid:0)!
If we want to use this distribution for testing the null hypothesis that α = 1, then
we …nd that the distribution under the null "degenerates" (collapses in one point).

pT ( ˆαT (cid:0)

N(0, (1

(cid:0)

α2))

Martin Sola (FE)

Univariate models

01/11

12 / 45

To obtain a non-degenerate asymptotic distribution for ˆαT in the unit root
case, it turns out that we have to multiply by T and not by the square root
of T . Then the unit root coe¢ cient converges at a faster rate T than for the
stationary case.

To get a better sense of why scaling by T is necessary when the true value of
α is unity consider the OLS estimate:

ˆαT =

1yt

∑T
t =1 yt
(cid:0)
∑T
t =1 y 2
t
(cid:0)

1

.

Then, substituting yt by the AR(1) process we get that:

ˆαT (cid:0)

α =

1εt

∑T
t =1 yt
(cid:0)
∑T
t =1 y 2
t
(cid:0)

1

Martin Sola (FE)

Univariate models

01/11

13 / 45

Multiplying in both sides by T , we get

T ( ˆαT (cid:0)
1
Now, under the null that α = 1, yt can be written as:

α) =

T (cid:0)
T (cid:0)

1 ∑T
2 ∑T

t =1 yt
(cid:0)
t =1 y 2
t
(cid:0)

1εt

.

yt = y0 + ε1 + ε2 + ... + εt
= ε1 + ε2 + ... + εt

(cid:0)
1 + εt

1 + εt

(cid:0)

if we assume y0 = 0.

Then under the null that α = 1, yt ~N(0, σ2t).

Martin Sola (FE)

Univariate models

01/11

14 / 45

Now we proceed to …nd the distribution of the numerator: under the null,

y 2
t = (yt

(cid:0)

1 + εt )2 = y 2
t
(cid:0)

and rearranging terms we obtain

1 + 2yt

(cid:0)

1εt + ε2
t

1εt =

yt

(cid:0)

1
2

(y 2

t (cid:0)

y 2
t
(cid:0)

1 (cid:0)

ε2
t ).

Then, the sum which appears in the numerator can be expressed as

T
∑
t =1

1εt =

yt

(cid:0)

T
∑
t =1

1
2

(y 2

t (cid:0)

y 2
t
(cid:0)

1 (cid:0)

ε2
t ) =

1
2

(y 2

T (cid:0)

y 2
0 )

(cid:0)

T
∑
t =1

1
2

ε2
t .

Then, recalling that y0 = 0 and multiplying by (T (cid:0)
expression of the numerator as the sum of two terms

1) we obtain the

1

T (cid:0)

T
∑
t =1

1εt = (

yt

(cid:0)

1
2T

)y 2

T (cid:0)

T
∑
t =1

(

1
2T

)ε2
t

Martin Sola (FE)

Univariate models

01/11

15 / 45

To …nd the distribution of this expression we divide each side by σ2 which
yields the following result

(σ2T )(cid:0)

1

T
∑
t =1

yt

(cid:0)

1εt = (1/2)(

yT
σpT

)2

(cid:0)

T
∑
t =1

(

1
2σ2T

)ε2
t

Consider the …rst term of this expression. Since we have shown above that yt
~N(0, σ2t), standardizing we obtain

(yT /σpT )~N(0, 1),
and then squaring this expression we …nd that the …rst term of the numerator
is distributed Chi-square

(yT /σpT )2~χ2(1).

Martin Sola (FE)

Univariate models

01/11

16 / 45

It can be shown using the law of large numbers that the second term
converges in probability to σ2, i.e.

(1/T )

T
∑
t =1

ε2
t

P
(cid:0)!

σ2,

or

(1/σ2T )

T
∑
t =1

ε2
t

1

P
(cid:0)!

If we put both results together we can see that the numerator converges to

(σ2T )(cid:0)

1

T
∑
t =1

1εt

yt

(cid:0)

L
(cid:0)!

(1/2)(X

(cid:0)

1) where X ~χ2(1).

It can also be shown using the law of large numbers that the denominator
converges in probability to

E (T (cid:0)

2

T
∑
t =1

y 2
t
(cid:0)

1).

Martin Sola (FE)

Univariate models

01/11

17 / 45

1) = σ2(t
Now,as yt
(cid:0)
expected value of the denominator can be written as

1)), then E (y 2
t
(cid:0)

1 ~N(0, σ2(t

(cid:0)

1). Therefore the

(cid:0)

E (T (cid:0)

2

T
∑
t =1

y 2
t
(cid:0)

1) = T (cid:0)

2

T
∑
t =1

E (y 2
t
(cid:0)

1)

= T (cid:0)

2σ2

= σ2T (cid:0)

T
∑
t =1
2(T

(t

1)

(cid:0)

1)T /2

(cid:0)

Then if we multiply ( ˆαT (cid:0)
non-degenerate asymptotic distribution, but this distribution is not Gaussian.

1) by T instead than by pT , we obtain a

Martin Sola (FE)

Univariate models

01/11

18 / 45

How do we test for unit roots? Dicky Fuller Test

Consider the following model

where εt ”is assumed” to be N(0,σ2)

yt = µ + βt + αyt

1 + εt

(cid:0)

We want to test the Hypothesis of the existence of a unit root therefore we set
the following null and alternative hypothesis.

H0) α = 1(UR)
H1) α < 1(I (0))

Martin Sola (FE)

Univariate models

01/11

19 / 45

The obvious estimator of is the OLS estimator, ˆβ. The problem is that under the
null hypothesis there is considerable evidence of the non - adequacy of the
asymptotic (approximate in large samples) distribution. Therefore
The latter equation can be rewritten as

or

∆yt = µ + (α

1)yt

(cid:0)

(cid:0)

1 + βt + εt

For this expression the relevant hypothesis should be written as:

∆yt = µ + λyt

1 + βt + εt

(cid:0)

H0) λ = 0 (unit root)
H1) λ < 0 (I (0))

Martin Sola (FE)

Univariate models

01/11

20 / 45

Fuller (1976) tabulated, using Monte Carlo methods, critical values for alternative
cases, for example for a sample size of 100 the 5 % critical values are

µ = 0, β = 0
= 0, β = 0
µ
= 0
= 0, β
µ

2.24
3.17
3.73

(cid:0)
(cid:0)
(cid:0)

Therefore the method simply consist to check the t-statistic of ˆλ against the
critical values of Fuller (1976). Notice that the critical values depend on

i ) the sample size
ii ) whether you include a constant and/or a time trend.

This procedure is only valid when there is no evidence of serial correlation in the
residuals, ˆεt .If there is serial correlation you should need to include additional
lags, say ∆yt

2,... until it disappears

1, ∆yt

(cid:0)

(cid:0)

Martin Sola (FE)

Univariate models

01/11

21 / 45

6
6
6
Augmented Dickey Fuller

Consider:

∆yt = µ + λyt

1 + βt + α1∆yt

1 + ... + αk ∆yt

(cid:0)

k + εt

(cid:0)

(cid:0)

We chose to augment the regression with k lags. This is usually denoted as
ADF(k).

Choosing the order of augmentation of the DF regression:

choosing k as a function of the number of observations as in Schwert (1989)

k = INT (12 (T /100 )1/12)

information based rules such as AIC and BIC.
sequential rules
General to speci…c seems to be preferable to the other methods.

Martin Sola (FE)

Univariate models

01/11

22 / 45

Small sample properties of the Dickey Fuller test

The power of the test is extremely low

ADF comes up with con‡icting results depending on the order chosen for the
regression

Good practice: start with quite a general model and then delete lags

Martin Sola (FE)

Univariate models

01/11

23 / 45

Phillips - Perron type tests for unit roots

Alternative approach to DF

They make a non-parametric correction to the standard deviation which
provides a consistent estimator of the variance.

S 2
Tl = T (cid:0)

1

T
∑
t =1

(ε2

t ) + 2T (cid:0)

1

l
∑
t =1

T
∑
t =j +1

εt εt

j

(cid:0)

S 2
ε = T (cid:0)

1

T
∑
t =1

(ε2
t )

where l is the lag truncation parameter used to ensure that the
autocorrelation of the residuals is fully captured.

Martin Sola (FE)

Univariate models

01/11

24 / 45

An asymptotically valid test φ = 1, for

∆yt = µ + (φ

1)yt

(cid:0)

(cid:0)

1 + εt

εt ~iiD(0, σ2)

when the underlying DGP is not necessarily an AR(1) process, is given by the
Phillips Z -test.

Z (τµ) = (Sε/STl )τµ (cid:0)

(1/2)(S 2

Tl (cid:0)

S 2
ε )[STl [T 2

T
∑
t =2

(yt

(cid:0)

y )2].5](cid:0)

1

where τµ is the t-statistic associated with testing the null hypothesis ρ = 1.

Martin Sola (FE)

Univariate models

01/11

25 / 45

Comments The critical values for this test statistic are the same as those

used for the same case in the fuller table.
Monte Carlo work suggests that the Phillips-type test has poor
size properties (tendency to over reject when is true) when the
underlying DGP has large negative MA components.

Martin Sola (FE)

Univariate models

01/11

26 / 45

Structural breaks and unit roots

1 Perron (1988) has shown that an I(0) process with a structural break in the

mean will be di¢ cult to distinguish from a I(1) process.

If we know where the break takes place, the natural thing to do, is to partial
out the break by using dummy variables and test for unit roots once the
break has been partialled out.

A possible solution to try to identify these breaks is to perform the ADF test
recursively and to compute recursive t-statistics.

Martin Sola (FE)

Univariate models

01/11

27 / 45

Recursive t-statistics

The recursive ADF -statistic is computed using sub samples t = 1..k for
k = k0, .....T , where k is the start up value and T is the sample size of the
full sample.

The most general model (with drift and trend) is estimated for each sub
sample
The minimum value of ττ(k/T ) across all the sub samples is chosen and
compared with the table provided by Banjeree, Lumsdaine and Stock

Martin Sola (FE)

Univariate models

01/11

28 / 45

Rolling ADF

The previous method could also be applied using a (large enough) window (of
size k) to see if there are clear changes in the pattern of a series.
The most general model (with drift and trend) is estimated for each sub
sample
The minimum value of ττ(k/T ) across all the sub samples is chosen and
compared with the table found in the class notes.

Martin Sola (FE)

Univariate models

01/11

29 / 45

Tests with stationarity as a null: KPSS test

Consider the following model.

where εt is a stationary process and ξt is a random walk given by

yt = α + δt + ξt + εt

1 + ut
The null of stationarity is formulated as

ξt = ξt

(cid:0)

ut ~iid (0, σ2
u )

H0)σ2

u = 0

Martin Sola (FE)

Univariate models

01/11

30 / 45

The test statistic for this hypothesis is given by

LM =

∑T

t =1 S 2
t
ˆσ2
e

where et are the residuals of a regression of yt on a constant and a time trend, ˆσ2
e
is the residual variance for this regression and St is the partial sum of et de…ned by

St =

T
∑
i =t

ei

t = 1, 2, .., T .

Martin Sola (FE)

Univariate models

01/11

31 / 45

Variance Ratio Tests

This will provide us with another tool to discriminate between (trend)
stationary and non-stationary series.
Consider yt and assume that it follows follows a random walk, i.e.

then by iterative substitution we know that

yt = yt

1 + εt

(cid:0)

yt = yt

(cid:0)

k + εt + εt

1 + εt

2 + εt

(cid:0)

(cid:0)

(cid:0)

3 + ... + εt

k +1

(cid:0)

Martin Sola (FE)

Univariate models

01/11

32 / 45

Denoting the di¤erence between yt and yt

k as ∆k yt , then

∆k yt = εt + εt

1 + εt

(cid:0)

(cid:0)

3 + ... + εt

(cid:0)

k +1

(cid:0)

(cid:0)
2 + εt

and clearly the variance of ∆k yt , is σ2k, where σ2 is the variance of ε.
We can de…ne a ”variance ratio” function (a function of k) as

λ1(k) =

Var (∆k yt )
Var (∆1yt )

= k.

Therefore a plot of λ1 against k should be an increasing straight line

Martin Sola (FE)

Univariate models

01/11

33 / 45

Alternatively we may de…ne a new function λ2(k) as

λ2(k) = λ1(k)/k

If there is a unit root, λ2(k) tends to one when k tends to in…nite.
However if yt does not contain a unit root it can be shown that the lim
λ2(k) when k tends to in…nite is equal to zero.

Martin Sola (FE)

Univariate models

01/11

34 / 45

Proof.
(idea)Assume the following AR(1) process

yt = φ1yt

1 + εt ,

(cid:0)

t = 1, ......, T

we have seen that by iterative substitution we can express this process as

yt = φk

1 yt

k + φk
1

(cid:0)

1

εt

(k

1) + φk
1

(cid:0)

2

εt

(k

2) + ... + φ1εt

1 + εt

(cid:0)
k in both sides of the equation we get the following

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)
Then subtracting yt
expression

(cid:0)

yt

yt

(cid:0)

(cid:0)

k = (φk

1 (cid:0)

1)yt

(cid:0)

k + φk
1

(cid:0)

1

εt

(k

(cid:0)

(cid:0)

1) + φk
1

(cid:0)

2

εt

(k

(cid:0)

(cid:0)

2) + ... + φ1εt

1 + εt

(cid:0)

Martin Sola (FE)

Univariate models

01/11

35 / 45

Proof.
(continues)the variance of yt

k , Var (∆k yt ) is equal to

yt

(cid:0)

(cid:0)

V (yt

yt

(cid:0)

(cid:0)

k ) = (φk

1 (cid:0)

1)2V (yt

k ) + V (

(cid:0)

k
1
∑
(cid:0)
j =0

φ

j
1εt

j )

(cid:0)

Notice that

and

V (yt

(cid:0)

k ) = V (yt ) = (1/(1

1))σ2
φ2

(cid:0)

V (

k
1
∑
(cid:0)
j =0

φ

j
1εt

(cid:0)

j ) = ((1

φ2k
1 )/(1

1))σ2,
φ2

(cid:0)

(cid:0)

Martin Sola (FE)

Univariate models

01/11

36 / 45

Proof.
We can write the variance of ∆yt

k as

(cid:0)
1)2(1/(1

V (yt

yt

k ) = (φk

1 (cid:0)

1))σ2 + ((1
φ2

φ2k
1 )/(1

1))σ2
φ2

(cid:0)

(cid:0)

(cid:0)
In the same way we can express for a stationary process the variance of the …rst
1)yt
di¤erence of yt , (yt
1 + εt .
1) + σ2 = (φ1 (cid:0)

(cid:0)
1) = (φ1 (cid:0)
then the variance ratio can be written as

1) = (φ1 (cid:0)
1)2V (yt

1))σ2 + σ2
φ2

1)(1/(1

V (yt

yt

yt

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

λ1(k) =

(φk

1 (cid:0)

1)2(1/(1
(cid:0)
(φ1 (cid:0)

φ2k
1))σ2 + ( (1
φ2
1 )/(1
(cid:0)
φ2
1))σ2 + σ2
1)2(1/(1

(cid:0)

1) )σ2
φ2

(cid:0)

Martin Sola (FE)

Univariate models

01/11

37 / 45

Proof.
Then the limit of λ1(k) when k tends to in…nite for a stationary process is

limk

!

∞λ1(k) =

1

1

φ1

(cid:0)

= 1.
which is a constant provided that φ1 6
It should be clear from the previous result that the limit of λ2(k) equals 0 when k
tends to in…nite.

Martin Sola (FE)

Univariate models

01/11

38 / 45

Trend stationary and di¤erence stationary processes

A trend stationary variable may be written as

yt = α + µt + εt + θ1εt

1 + θ2εt

2 + θ3εt

3 + ....

(cid:0)

(cid:0)

(cid:0)

Then yt

(cid:0)

k is simply

k = α + µ(t

yt

(cid:0)

k) + εt

k + θ1εt

1

(cid:0)

(cid:0)

k + θ2εt

2

(cid:0)

(cid:0)

k + θ3εt

k + ...

3

(cid:0)

(cid:0)

(cid:0)

(cid:0)

Martin Sola (FE)

Univariate models

01/11

39 / 45

The k th di¤erence can be obtained simply by subtracting the two above equations

yt

yt

(cid:0)

(cid:0)

k = µk + εt + θ1εt
(θk +1 (cid:0)
θ1)εt
1
k
∑
(cid:0)
j =0

= µk +

θj εt

(cid:0)

(cid:0)
(K

(cid:0)

1 + ... + θk

(cid:0)

(cid:0)

(cid:0)

(k

1εt
1) + ... + (θk +q (cid:0)
(cid:0)
∞
∑
θj )2εt
j =0

(θk +j (cid:0)

j +

j

(cid:0)

1) + (θk (cid:0)
θq )εt

1)εt
q + ...

k +

(cid:0)

(cid:0)

Martin Sola (FE)

Univariate models

01/11

40 / 45

Then the variance of yt

yt

(cid:0)

(cid:0)

k may be written as

V (yt

yt

(cid:0)

(cid:0)

k ) = σ2

k
1
∑
(cid:0)
j =0

θ2
j + σ2

∞
∑
j =0

(θk +j (cid:0)

θj )2

From the previous equation we can see that when k tends to in…nity, the variance
of ∆k yt is equal to

V (∆k yt ) = 2σ2

k
1
∑
(cid:0)
j =0

θ2
j

Martin Sola (FE)

Univariate models

01/11

41 / 45

Now the …rst di¤erence of a trend stationary process, ∆yt is

yt

yt

(cid:0)

(cid:0)

1 = µ + εt + (θ1

(cid:0)
+... + (θk +q (cid:0)

1)εt
(cid:0)
θk +q

1 + ... + (θk +1 (cid:0)
q + .......
1)εt

(cid:0)

(cid:0)

θk )εt

(k +1)

(cid:0)

Then the variance of the …rst di¤erence can be written as

V (yt

yt

(cid:0)

(cid:0)

1) = V (εt + (θ1

1)εt

1 + ... + (θk +1 (cid:0)

θk )εt
(k +q) + .......)

1)εt

(cid:0)
θk +q

(k +1)

(cid:0)

(cid:0)
+... + (θk +q (cid:0)
∞
∑
j =0

(θj +1 (cid:0)

= σ2(1 +

(cid:0)

(cid:0)
θj )2)

Martin Sola (FE)

Univariate models

01/11

42 / 45

The variance ratio should be

λ1(k) =

Var (∆k yt )
Var (∆1yt )

=

j + σ2 ∑∞

j =0 θ2
∑k
1
(cid:0)
(1 + ∑∞

j =0(θk +j (cid:0)
θj )2)

j =0(θj +1 (cid:0)

θj )2

,

and the limit when k tends to in…nity is

lim
!!

k

∞

λ1(k) = lim
!!

k

∞

Var (∆k yt )
Var (∆1yt )

= lim
k
!!

∞

(1 + ∑∞

j =0 θ2
1
2 ∑k
(cid:0)
j
j =0(θj +1 (cid:0)

.

θj )2)

Martin Sola (FE)

Univariate models

01/11

43 / 45

The expression is a constant and might be greater or smaller than one
depending on the θj values.
We can distinguish between the two models by simply noting that under the
random walk assumption λ1 increases with k and that under the trend
stationary assumption λ1 tends to a constant.
Alternatively we can consider λ2 Var (∆k yt )/k. and note both, that when
the model is a random walk this expression tends to 1 (see proof above), and
that this ratio should tend to zero when k tends to in…nity since Var (∆k yt )
is constant for the trend stationary model.

Martin Sola (FE)

Univariate models

01/11

44 / 45

Sampling distribution of λ(k) under the Random Walk Hypothesis.

H0) α = 1 or

yt = µ + yt
It can be shown that asymptotically under the null, pTk( ˆλ2(k)
N(0, 2(k
(cid:0)
standardized statistics.

1 + εt

1)). Then tests of the null Hypothesis can be carried out on the

εt ~IIDN(0, )

1) a
~

(cid:0)

(cid:0)

Martin Sola (FE)

Univariate models

01/11

45 / 45

Cointegration

Series de Tiempo

UTDT

January 2020

Martin Sola (UTDT)

Multivariate models

01/13

1 / 45

Cointegration

Importance of checking for cointegration:

If variables do not cointegrate there is not a meaningful relationship between
those variables, then Change the Theory.

If variables do cointegrate we need to write the model correctly.

STRUCTURE OF THE LECTURE

De…nition and Properties.

Valid representations if the variables cointegrate

Testing for Cointegration.

Martin Sola (UTDT)

Multivariate models

01/13

2 / 45

Cointegration

A Cointegration relationship captures the long-run relationship between the
variables of interest.

The aim behind cointegration is the detection and analysis of long run
relationships amongst economic time series variables.

Cointegration analysis provides a way of retaining both short-run and
long-run information.

Cointegration is sometimes thought to be a pre-requisite for the validity of
some economic theory.

Martin Sola (UTDT)

Multivariate models

01/13

3 / 45

De…nition
Consider two I (1) processes
and
or I (0). X and Y are said to cointegrate if there exists (a1, a2) such that
a1Y + a2X ~ I (0).

Yt

Xt

g

f

f

g

.Their linear combination maybe I (1)

Martin Sola (UTDT)

Multivariate models

01/13

4 / 45

Example
Consider the following example where cointegration of Prices and Dividends is a
necessary condition for markets e¢ ciency in the Fama sense. Let us assume that
stock prices might be written as

Pt =

∞
∑
i =1

(1/(1 + r ))i E (Dt +i j

It ) + εt

where we assume that εt is an I(0) process

Martin Sola (UTDT)

Multivariate models

01/13

5 / 45

Example
Let also assume Dt follows a random walk which is a special case of an I(1)
variable.

Then, we may express stock prices as

Dt = Dt

1 + νt .

(cid:0)

Pt = (1/r )Dt + εt

Martin Sola (UTDT)

Multivariate models

01/13

6 / 45

Example
Given that Dt are integrated of order one, stock prices also are integrated of order
(1/r )) is going to be a cointegrating vector since
one. If the theory is valid, (1,

(cid:0)

(1,

(1/r ))

(cid:0)

Pt
Dt

= Zt = εt

(cid:20)
Notice that we assumed that εt was I(0), therefore if the theory holds dividends
and prices should be cointegrated.

(cid:21)

There are cases where there exist a theoretical long run cointegration
relationship dictated by the model. In the previous example is not enough
that Prices and Dividends cointegrate, the cointegrating vector has to be
(1,

(1/r )) for the theory to hold.

(cid:0)

Martin Sola (UTDT)

Multivariate models

01/13

7 / 45

Example
Consider the following model:

xt + βyt = ut

xt + αyt = et

ut = ut

1 + ε1t

(cid:0)
1 + ε2t with

et = ρet

(cid:0)

< 1

ρ

j

j

(ε1t , ε2t )0 is distributed identically and independently as a bivariate normal with
E (ε1t ) = E (ε2t ) = 0, var (ε1t ) = σ11, var (ε2t ) = σ22 cov (ε1t ε2t ) = σ12

Martin Sola (UTDT)

Multivariate models

01/13

8 / 45

Solving for xt and yt form the above system with α

= β gives

xt = α(α
(α
yt =

(cid:0)

(cid:0)

(cid:0)

β)(cid:0)
β)(cid:0)

1ut
β(α
(cid:0)
1ut + (α

β)(cid:0)
β)(cid:0)

1et ,
1et .

(cid:0)

(cid:0)

Then:

1 Both xt and yt are integrated of order one i.e., xt ~I (1), yt ~I (1), since ut is

integrated of order one.

2 xt + αyt is I (0) because et is stationary.
3 The cointegration vector is (1, α) and x + αy is the equilibrium relationship.

Martin Sola (UTDT)

Multivariate models

01/13

9 / 45

6
Proposition In the bivariate case if the equilibrium condition exists, is unique.

Proof.
Suppose that there exist two distinct co-integrating parameters α and γ such that
x + αy and x + γy are both ~I (0). This implies that (α
because a linear combination of two I(0) variable is also I(0). But we know that
for α

γ)yt ~I(1) therefore we have a contradiction unless α = γ.

γ)yt is also I (0)

= γ , (α

(cid:0)

(cid:0)

Martin Sola (UTDT)

Multivariate models

01/13

10 / 45

6
Representation Theorems

Consider the model in the …rst example, with
Whenever xt and yt are cointegrated, we can show, for the simple two
variable model, that the system of two equations has the following
representations:

< 1.

ρ

j

j

Error-correction representation
Vector autoregressive in levels representation
Moving-average representation.

Martin Sola (UTDT)

Multivariate models

01/13

11 / 45

Error correction mechanism

There is a strong empirical motivation for these models since they perform
very well.

This representation has the advantage that it keeps long run and short run
information.

Allows to rewrite RE models which variables are I(1) in terms of I(0) variables.

Martin Sola (UTDT)

Multivariate models

01/13

12 / 45

ECM Representation

I repeat the above model for convenience:

xt + βyt = ut

xt + αyt = et

ut = ut

1 + ε1t

(cid:0)
1 + ε2t with

et = ρet

(cid:0)

< 1

ρ

j

j

Lagging the equations and substracting the lagged values:

∆xt + β∆yt = ∆ut

∆xt + α∆yt = ∆et

and rewriting the equations we have

1 β
1 α

(cid:20)

(cid:21) (cid:20)

∆xt
∆yt

=

(cid:21)

(cid:20)

∆ut
∆et

(cid:21)

Martin Sola (UTDT)

Multivariate models

01/13

13 / 45

Inverting the matrix and noting that

∆ut = ε1t
∆et =
(1

(cid:0)

ρ)et

(cid:0)

(cid:0)

1 + ε2t

we have

∆xt
∆yt

(cid:20)

=

(cid:21)

1

α

β

(cid:20)

(cid:0)

α
1

(cid:0)

β
(cid:0)
1

(cid:21) (cid:20)

(cid:0)

(1

(cid:0)

ε1t
ρ)et

1 + ε2t

(cid:0)

(cid:21)

The ECM representation would be:

∆xt
∆yt

(cid:20)

=

(cid:21)

1

α

β

(cid:20)

(cid:0)

β(1
(1

(cid:0)

(cid:0)
(cid:0)

ρ)(et
(cid:0)
ρ)(et

1)
1)

(cid:0)

+

(cid:21)

(cid:20)

ζ1t
ζ2t (cid:21)

where

ζ1t
ζ2t (cid:21)

=

(cid:20)

1

α

β

(cid:20)

(cid:0)

α
1

(cid:0)

β
(cid:0)
1

ε1t
ε2t

(cid:21)

(cid:21) (cid:20)

Martin Sola (UTDT)

Multivariate models

01/13

14 / 45

VAR representation

Now, notice that:

∆ut = ε1t
∆et =
(1
(1
=

(cid:0)
(cid:0)

(cid:0)
(cid:0)

Then using the ECM representation

ρ)et
(cid:0)
ρ)(xt

1 + ε2t
1 + αyt

(cid:0)

1) + ε2t

(cid:0)

∆xt
∆yt

=

α

1

β(1
(1

(cid:0)

(cid:0)
(cid:0)

β

(cid:20)

ρ)(et
(cid:0)
ρ)(et

1)
1)

(cid:0)

+

(cid:21)

(cid:20)

ζ1t
ζ2t (cid:21)

(cid:20)
(cid:0)
This can be rewritten to obtain:

(cid:21)

∆xt
∆yt

=

α

(cid:21)

1

(cid:0)

=

(cid:21)

1

α

β

(cid:20)

(cid:0)

(cid:20)
∆xt
∆yt

(cid:20)

β

(cid:20)
β(1
(1

(cid:0)

β(1
(1

(cid:0)

(cid:0)
(cid:0)

ρ)(xt
(cid:0)
ρ)(xt

1 + αyt
(cid:0)
1 + αyt

1)
1)

(cid:0)

(cid:0)

+

(cid:21)

(cid:20)

ρ)
ρ)

(cid:0)
(cid:0)

β(1
(1

(cid:0)

(cid:0)
(cid:0)

ρ)α
ρ)α

xt
yt

1
1

(cid:0)

(cid:0)

(cid:21)

(cid:21) (cid:20)

ζ1t
ζ2t (cid:21)
ζ1t
ζ2t (cid:21)

(cid:20)

+

Martin Sola (UTDT)

Multivariate models

01/13

15 / 45

Notice that this VAR representation is not a VAR in the …rst di¤erences. The
VAR can be written as

xt
yt

(cid:20)

=

(cid:21)

1

β(1

α

β

(cid:20)

(cid:0)

ρ) + (α
ρ)
(1

(cid:0)

(cid:0)
(cid:0)

β)

(cid:0)

β(1

ρ)α
(cid:0)
ρ)α + (α

(1

(cid:0)

(cid:0)

β)

(cid:0)

(cid:21) (cid:20)

xt
yt

1
1

(cid:0)

(cid:0)

+

(cid:21)

(cid:20)

ζ1t
ζ2t (cid:21)

Martin Sola (UTDT)

Multivariate models

01/13

16 / 45

Moving Average Representation

Using the fact that

and noting that,

∆xt
∆yt

(cid:20)

=

(cid:21)

1

α

β

(cid:20)

(cid:0)

α
1

(cid:0)

β
(cid:0)
1

∆ut
∆et

,

(cid:21)

(cid:21) (cid:20)

∆ut
∆et

=

(cid:20)
The MA representation is given by:

(cid:20)

(cid:21)

ε1t

L)(1

(1

(cid:0)

(cid:0)

,

ρL)(cid:0)

1ε2t (cid:21)

∆xt
∆yt

(cid:20)

=

(cid:21)

1

α

β

(cid:20)

(cid:0)

α
1

(cid:0)

β
(cid:0)
1

ε1t

L)(1

(1

(cid:0)

(cid:0)

(cid:21) (cid:20)

.

ρL)(cid:0)

1ε2t (cid:21)

The MA polynomial has a root equal to 1 and therefore is not invertible

There isn’t a VAR in di¤erences representation.

Martin Sola (UTDT)

Multivariate models

01/13

17 / 45

Cointergration and Trends

Two variables that are I(1) may cointegrate to an trend stationary
representation.

Examples
Consider the following procesess for Xt and Yt :

Xt = µx + Xt
Yt = µy + Yt

1 + νt ,
1 + εt .

(cid:0)

(cid:0)

X and Y are said to cointegrate if there exists (a1, a2) such that a1X + a2Y ~
I (0). From the above example is eassy to see that the variables may cointegrate
to a trend stationary process since:

Xt = µx t + X0 + νt + νt
Yt = µy t + Y0 + εt + εt

1 + ......... + ν1,
(cid:0)
1 + .......... + ε1.

(cid:0)

then we know that a1(νt + νt
I (0), but (a1µx + a2µy )t and/or (a1X0 + a2Y0) might be di¤erent from zero.

1 + .........+ ν1) + a2(εt + εt

1 + ..........+ ε1) ~

(cid:0)

(cid:0)

Martin Sola (UTDT)

Multivariate models

01/13

18 / 45

Cointegration in the n variable case

De…nition
Consider a n
that the elements of the vector are cointegrated of order (d, b), which we denote
Xt ~CI(d, b) if

1 vector of stochastic variables Xt = (X1t , X2t , .., Xnt ). We say

(cid:2)

1 Each of the components of Xt are I(d).
2 There exists (at least) a vector such that Zt = α0Xt is I(d

b > 0.

d

(cid:21)

b) for

(cid:0)

Then, α is called the cointegrating vector

Martin Sola (UTDT)

Multivariate models

01/13

19 / 45

Comments

1

If d = b = 0, then α0Xt = 0 de…nes a long-run equilibrium relationship.

3

2 Notice that α is not unique.
If n > 2, there may be r
n
(α1, ..., αr ) such that A0Xt ~I (0)
4 The vectors (α1, ..., αr ) are not unique

(cid:20)

(cid:0)

1 linearly independent (n

1) vectors

(cid:2)

Martin Sola (UTDT)

Multivariate models

01/13

20 / 45

Granger Representation Theorem

Theorem
Consider an n - vector time series Xt which satis…es:

Φ(L)Xt = c + ut

∑P

where Φ(L) = In
covariance matrix. It is assumed that det[Φ(z)]= 0 which implies
Suppose that there exist exactly r cointegrating relationships among the elements
of Xt . Then:

Φi Li , and ut is a white noise with positive de…nite

j (cid:21)

i =1

(cid:0)

1.

z

j

1

there exists an (n

r ) matrix A, of rank r < n such that A0Xt ~I(0).

2 ∆Xt has an MA representation given by ∆Xt = µ + Ψ(L)ut with

(cid:2)

where

A0Ψ(1) = 0,

Ψ(L) = In +

∞
∑
i =1

Ψi Li

Martin Sola (UTDT)

Multivariate models

01/13

21 / 45

Theorem
(continues)

[3.]Φ(1) = BA0There exist a VAR representation in levels and the
determinant of the polynomial in Φ has a unit root.There exists an ECM
representation

Martin Sola (UTDT)

Multivariate models

01/13

22 / 45

Error Correction Representation

Transform the original VAR

using the following relationship

Φ(L)Xt = c + ut ,

p
∑
i =1

In

(cid:0)

Φi Li = In

(

P
∑
i =1

(cid:0)

Φi )L

(I

(cid:0)

(cid:0)

L)

p
1
∑
(cid:0)
i =1

Γi Li

where

Γi =

p
1
∑
(cid:0)
i =j

(cid:0)

Φi +1

for j = 1, ..., p

1

(cid:0)

Martin Sola (UTDT)

Multivariate models

01/13

23 / 45

Then

(In

(cid:0)

p
∑
i =1

Φi Li )Xt =

In

p
∑
i =1

(cid:0)

Φi L + (I

L)

(cid:0)

p
1
∑
(cid:0)
i =1

Γi Li

!!

Xt = c + ut .

Rearranging terms

Xt = c + (

Φi )Xt

1 +

(cid:0)

p
1
∑
(cid:0)
i =1

Γi ∆Xt

i + ut

(cid:0)

= c +

Γi ∆Xt

i + (In

(cid:0)

(cid:0)

Φ(1)) Xt

1 + ut

(cid:0)

p
∑
i =1
p
1
∑
(cid:0)
i =1

Martin Sola (UTDT)

Multivariate models

01/13

24 / 45

∆Xt = c +

p
1
∑
(cid:0)
i =1

Γi ∆Xt

i (cid:0)

(cid:0)

Φ(1)Xt

1 + ut

(cid:0)

Thus:

3.4.5.(a) If rank [Φ(1)] = 0 then Φ(1) = 0 and Xt ~I (1)
(b) If rank [Φ(1)] = n then det(Φ(1))

= 0 (Φ(L) does not have a

unit root). This implies that Xt ~I (0)

(c) If rank [Φ(1)] = r , 0 < r < n then Φ(1) = BA0, where B is an

nxr matrix .

Martin Sola (UTDT)

Multivariate models

01/13

25 / 45

6
Restrictions on the parameters of the ECM representation

∆Xt = c +

p
1
∑
(cid:0)
i =1

Γi ∆Xt

i (cid:0)

(cid:0)

BZt

(cid:0)

1 + ut , Zt = A0Xt

A0Xt gives the ”error” from the long run equilibrium relationship, and B
gives the ”correction” to Xt
Taking expected values in both sides we get;

p
1
∑
(cid:0)
i =1

[I

(cid:0)

Γi Li ]E (∆Xt ) = c

BE (Zt

1)

(cid:0)

(cid:0)

Martin Sola (UTDT)

Multivariate models

01/13

26 / 45

If we assume that there is no autonomous growth component

p
1
∑
(cid:0)
i =1

[I

(cid:0)

Γi Li ]E (∆Xt ) = c

BE (Zt

1) = 0

(cid:0)

(cid:0)

or

Thus,

c = BE (Zt

1)

(cid:0)

∆Xt = BE (Zt

1) +

(cid:0)

p
1
∑
(cid:0)
i =1

Γi ∆Xt

i +

(cid:0)

(cid:0)

BZt

(cid:0)

1 + ut

=

B(Zt

1

(cid:0)

(cid:0)

E (Zt

(cid:0)

(cid:0)

1)) +

p
1
∑
(cid:0)
i =1

Γi ∆Xt

i + ut

(cid:0)

The intercept enters the system only via the error-correction term and there
is no autonomous growth component.

Martin Sola (UTDT)

Multivariate models

01/13

27 / 45

Tests for Cointegration: Univariate

Two stages Aproaches:First stage

Consider the following model:

And suppose that the actual model is the following dynamic model

yt = βxt + εt

yt = γo xt + γ1xt

1 + αyt

1 + εt

(cid:0)

(cid:0)

which can be re-written as

yt = λ0xt + λ1∆xt + λ2∆yt + εt

where

λ0 =

γ0 + γ1
1
α

γ1
α
Then the Static model, long-run parameter β
short run terms. The omitted dynamic terms are captured by the residuals
and since the variables in levels converge at speed T, and those in di¤erences
at .pT , that won’t bias the estimates of the static model.

, λ2 = (cid:0)
(cid:0)

, λ1 = (cid:0)
1
(cid:0)

dynamic model without the

α
α

,

(cid:0)

1

.

Martin Sola (UTDT)

Multivariate models

01/13

28 / 45

Two stage approaches Second stage

As a second stage, we can use alternative testing strategies

1 Make an (ADF) test for unit roots for the residuals: The

Engle - Granger Approach.

2 The null may be tested using the Sargan-Bhargava or

CDW test

Martin Sola (UTDT)

Multivariate models

01/13

29 / 45

The Engle - Granger Approach

If you do not reject the Hypothesis that the residuals have a unit root, then
Y and X are not cointegrated.

Regress

∆ˆεt = φˆεt

1 +

(cid:0)

p
1
∑
(cid:0)
i =1

∆ˆεt

φi

(cid:0)

i + µ + δt + ζt

Standard Dickey - Fuller critical values: over reject the null of no
cointegration. See MacKinon

Martin Sola (UTDT)

Multivariate models

01/13

30 / 45

The cointegrating Durbin Watson

This test is very simple and consist in comparing the DW statistic with
tabulated values.

Consider equations :

xt + αyt = et

et = ρet

(cid:0)

1 + ε2t with

< 1

ρ

j

j

A regression of xt on yt will yield serially correlated residuals. We can use the
DW statistic to get information about ρ since this statistic is approximately
2(1

ρ).

(cid:0)

DW (cid:24)= 2(1

ρ)

(cid:0)

Martin Sola (UTDT)

Multivariate models

01/13

31 / 45

Three stages: The Engle - Granger - Yoo approach

They assume a unique cointegrating vector and weak exogeneity of the short
run parameters
Third step: provides a correction for the …rst stage estimate of β
They correct the long run relationship by the small sample bias

γ

1

α

(cid:0)

Martin Sola (UTDT)

Multivariate models

01/13

32 / 45

The Johansen approach

De…ne Xt , a vector of n potentially endogenous variables.
It is possible to specify the following DGP and the model Xt as an
unrestricted VAR involving p lags of Xt :

Φ(L)Xt = c + ut

Using the ECM

∆Xt = c +

p
1
∑
(cid:0)
i =1

Γi ∆Xt

i (cid:0)

(cid:0)

Φ(1)Xt

1 + ut

(cid:0)

where Γi =

∑p

1
(cid:0)
i =j

Φi +1

(cid:0)

for j = 1, ..., p

1, and Φ(1) = In

∑P

i =1

Φi .

(cid:0)

(cid:0)

Martin Sola (UTDT)

Multivariate models

01/13

33 / 45

Consequently testing for cointegration amounts to a consideration of the rank of
Φ(1), that is, …nding the number of r linearly independent columns in Φ(1).

1

2

3

If Φ(1) is full rank the variables in Xt have to be I(0)
If Φ(1) is has zero rank there is no cointegrating vector
If Φ(1) is reduced rank the number of cointegrating vectors is the
RANK(Φ(1))

Martin Sola (UTDT)

Multivariate models

01/13

34 / 45

Canonical correlations

Population Canonical Correlations

Let the (n1
variables. In general

(cid:2)

1) vector yt and the (n2

1) vector xt denote stationary random

(cid:2)

E (yt y 0t ) E (yt x 0t )
E (xt y 0t ) E (xt x 0t )

(cid:20)

=

(cid:21)

(cid:20)

ΣYY ΣYX
ΣXY ΣXX (cid:21)

Martin Sola (UTDT)

Multivariate models

01/13

35 / 45

We can often gain some insight into the nature of these correlations by de…ning
two new (n

1) random vectors ϕt and ξt , where n is the smaller of n1 and n2 .

(cid:2)

ϕt = K 0yt
ξt = A0xt

The matrices K 0 and A0 are chosen such that

E (yt y 0t ) E (yt x 0t )
E (xt y 0t ) E (xt x 0t )

(cid:20)

=

(cid:21)

(cid:20)

ΣYY ΣYX
ΣXY ΣXX (cid:21)

Martin Sola (UTDT)

Multivariate models

01/13

36 / 45

E (ϕt ϕ0t ) = K 0ΣYY K = I

E (ξt ξ0t ) = A0ΣXX A = I

and

E (ϕt ξ0t ) = R = 2
6
6
4

r2

r1

0

0

rn

3

7
7
5

where the elements of ϕt and ξt are ordered in such a way that
1

0

r2......

r1

rn

(cid:21)

(cid:21)

(cid:21)

(cid:21)

Martin Sola (UTDT)

Multivariate models

01/13

37 / 45

De…nition
The population parameter ri is known as the i th population canonical correlation
between yt and xt .

Lemma
The canonical correlations can be calculated by calculating the eigen values of

1
Σ(cid:0)
YY

1
ΣYX Σ(cid:0)
XX

ΣXY ,

λ1 > λ2 > ...λn , and the canonical correlations in turn are the square roots of
these eigenvalues.

Martin Sola (UTDT)

Multivariate models

01/13

38 / 45

The Johansen Method of Reduced Rank Regression

A way to assess the rank of If Φ(1) is to use the auxiliary regressions which allow
to …nd an equivalent method to maximizing the likelihood of the ECM model.
This equivalent expression allows to test how many cointegrating relationships do
exist.

1. Rewrite the ECM Equation

∆Xt + BA0Xt

(cid:0)

1 = c + Γ1∆Xt

1 + ... + Γp

1∆Xt

(cid:0)

(p

(cid:0)

(cid:0)

1) + ut

(cid:0)

2. It is possible to correct for the short run dynamics by regressing
1 separately on the right hand side of the previous

∆Xt and Xt
equation

(cid:0)

∆Xt = c1 + P1∆Xt
1 = c2 + T1∆Xt
Xt

(cid:0)

(cid:0)

(cid:0)

1 + ... + Pp
1 + ... + Tp

1∆Xt
1∆Xt

(cid:0)

(cid:0)

1) + R0t
1) + Rkt

(p

(cid:0)

(cid:0)

(p

(cid:0)

(cid:0)

Martin Sola (UTDT)

Multivariate models

01/13

39 / 45

3. The latter can be used to form the residual (product moment)

matrices

Sij = T (cid:0)

1 ∑

Rit

R 0jt

i, j = 0, k

4. The maximum likelihood estimate of A is obtained as eigenvectors
b

corresponding to the largest eigenvalues of:

b

b

λ

j

Skk (cid:0)
b

S0k

1
S (cid:0)
00

= 0

S0k j
b

5. This gives n eigenvalues ˆλ1 > ˆλ2 > ..... ˆλn and their corresponding
b

b

eigen vectors, ˆϕ = ( ˆϕ1 > ˆϕ2 > ... > ˆϕn)

Martin Sola (UTDT)

Multivariate models

01/13

40 / 45

Testing for reduced rank

The use of the auxiliary regressions allows to write the likelihood as a
function of the eigen values. The likelihood that corresponds to the ECM
without any restriction is

L(cid:3) = (cid:0)

(Tn/2)log (2π)

(cid:0)

(T /2) ∑n

(Tn/2)
(cid:0)
i =1 log(1

(T /2)log
ˆλi )

(cid:0)

(cid:0)

.

S00

(cid:12)
(cid:12)
(cid:12)b

(cid:12)
(cid:12)
(cid:12)

To …nd the number of cointegrating vectors is equivalent to …nd the number
of linearly independent columns in Φ(1) or the number of n
r columns with
small associated eigen values.

(cid:0)

Thus to test the null hypothesis that there are at most r cointegration
vectors amounts to test

H0)λi = 0 i = r + 1, ...., n.

where only the …rst r eigenvalues are non-zero.

Martin Sola (UTDT)

Multivariate models

01/13

41 / 45

Likelihood that corresponds to the ECM without any restriction:

L(cid:3) = (cid:0)

(Tn/2)log (2π)

(cid:0)

(T /2) ∑n

(Tn/2)
(cid:0)
i =1 log(1

(T /2)log
ˆλi )

(cid:0)

(cid:0)

.

S00

(cid:12)
(cid:12)
(cid:12)b

(cid:12)
(cid:12)
(cid:12)

Likelihood that corresponds to the ECM under the null that there are only r
cointegrating vectors is:

L(cid:3)(H0) = (cid:0)

(Tn/2)log (2π)

(cid:0)

(T /2) ∑r

(Tn/2)
(cid:0)
i =1 log(1

(T /2)log
ˆλi )

(cid:0)

(cid:0)

.

S00

(cid:12)
(cid:12)
(cid:12)b

(cid:12)
(cid:12)
(cid:12)

Martin Sola (UTDT)

Multivariate models

01/13

42 / 45

Trace statistic

Thus to test the null hypothesis that there are at most r cointegration
vectors amounts to test

H0)λi = 0 i = r + 1, ...., n.

where only the …rst r eigenvalues are non-zero. (This is tested against the
alternative of n cointegrating vectors).

A likelihood ratio test, using a non standard distribution, can be constructed,
using what is known as the Trace statistic.

λtrace =

n
∑
i =r +1

T

(cid:0)

log(1

ˆλi )

(cid:0)

r = 0, 1, ..., n

2, n

1

(cid:0)

(cid:0)

Martin Sola (UTDT)

Multivariate models

01/13

43 / 45

Max statistic

Another test of the signi…cance of the largest λr is the so called
maximal-eigenvalue or λ

max statistic :

(cid:0)

λmax =

T log(1

(cid:0)

ˆλr +1)

(cid:0)

r = 0, 1, ..., n

2, n

1.

(cid:0)

(cid:0)

This tests the existence of r cointegrating vectors against the alternative that
r + 1 exist and is derived in exactly same way

Martin Sola (UTDT)

Multivariate models

01/13

44 / 45

Testing restrictions on the cointegrating vector

Many times we are interested to test restrictions on the cointegrating vector.

Therefore the asymptotic theory is standard since the regressions only involve
variables which are I(0)and the test would be distributed chi-square. The LR
test will be:

LR =

T

(cid:0)

r
∑
i =1

log(1

(cid:0)

ˆλi ) + T

r
∑
i =1

log(1

˜λi )

(cid:0)

Martin Sola (UTDT)

Multivariate models

01/13

45 / 45

ARCH Models

Series de Tiempo

UTDT

2020

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

1 / 69

Di¤erent ARCH models are proposed to capture the "Stylized Facts" of Asset
returns.

Uses of Univariate ARCH models:

Forecasting Volatility: Need to …nd a model to characterize the series which
then is used to produce a forecast.

Forecasting volatility might be useful when pricing Derivatives.

STRUCTURE OF THE LECTURE

De…nition and Properties.

Estimation and testing

Multivariate extensions

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

2 / 69

Empirical Regularities of Asset Returns

Thick tails : returns tend to be leptokurtic

Volatility clustering

Leverage e¤ects

Non Trading Periods

Forecastable Events

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

3 / 69

ARCH (1)

Consider the following model:

εt = υt (ω + αε2
t
(cid:0)

yt = µ + εt
1)1/2, υt ~IIN(0, 1), ω > 0, α > 0

1)1/2 is the conditional standard deviation, σt de…ned as

NOTICE that (ω + αε2
t
(cid:0)
(E (ε2
t j

1))1/2 .

It

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

4 / 69

ARCH (1)

1)1/2 = 0

E (εt

Var (εt

1) = E (υt

It
j
Since E (υt

(cid:0)

It

1)(ω + αε2
t
j
(cid:0)
1) = E (υt ) = 0

(cid:0)

(cid:0)

It
j
1) = E (ε2
t j
1) = E (υt ) = 1
It

1) = E (υt

It

(cid:0)

(cid:0)
Since E (υt

It

j

j

(cid:0)

Then we de…ne the …rst order ARCH model as

It

j

(cid:0)

1)(ω + αε2
t
(cid:0)

1) = (ω + αε2
t
(cid:0)

1)

t = (ω + αε2
σ2
t
(cid:0)

1)

Notice that whenever the process is stationary applying iterative expectations
we …nd that :

V (εt ) = E (ε2
E (ε2
t ) = ω/(1

t ) = E (σ2
α)

(cid:0)

t ) = E (ω + αε2
t
(cid:0)

1)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

5 / 69

An alternative representation
We can always write the following expression

t = E (ε2
ε2
t j

It

(cid:0)

1) + ηt , where ηt is an innovation.

or
t = ω + αε2
ε2
t
(cid:0)
then if 0 < α < 1, we …nd that

1 + ηt

E (ε2

t ) = ω/(1

α)

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

6 / 69

ARCH (1)

Consider Now the properties of yt = µ + εt when there are ARCH(1) e¤ects:

(cid:0)
yt

1) = µ

E (yt
yt
j
1) = (ω + αε2
Var (yt
t
(cid:0)
V (yt ) = V (εt ) = ω/(1
(cid:0)
( since V (εt ) = E (ε2

(cid:0)

j

1)
α)
t ) = E (ω + αε2
t
(cid:0)

1) = ω + αE (ε2
t
(cid:0)

1) )

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

7 / 69

First order autoregressive process with ARCH e¤ects

Consider:

yt = θyt

where εt = υt (ω + αε2
t
(cid:0)
1)(ω + αε2
t
(cid:0)

1) = E (υt

E (εt

1)

It

It

(cid:0)

(cid:0)

j

j

1 + εt

(cid:0)

1
2 and υt ~IIN(0, 1), ω > 0, α > 0

1
2 = 0 (E (υt

1)

It

j

(cid:0)

1) = E (υt ) = 0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

8 / 69

First order autoregressive process with ARCH e¤ects

Conditional variance:

Var (εt

It

1) = E (υt

It

j
Conditional mean and variance of yt :

(cid:0)

(cid:0)

j

1)(ω + αε2
t
(cid:0)

1) = (ω + αε2
t
(cid:0)

1)

E (yt

yt

1) = θyt

1

j
yt

(cid:0)

(cid:0)
1) = (ω + αε2
t
(cid:0)

(cid:0)

1)

Var (yt

j

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

9 / 69

First order autoregressive process with ARCH e¤ects

Unconditional variance of yt :

Var (yt ) = E (Var (yt

1)) + Var (E (yt

yt

j

(cid:0)

1))

yt

j

(cid:0)

Thus:

E (Var (yt

yt

j

(cid:0)

then

1)) = E (ω + αε2
t
(cid:0)
yt

Var (E (yt

1) = ω + αE (ε2
t
(cid:0)
1)) = θ2Var (yt

j

(cid:0)

1)

(cid:0)

1) = ω + αVar (εt

1)

(cid:0)

Var (yt ) = ω + αVar (εt
if stationary

(cid:0)

1) + θ2Var (yt

1)

(cid:0)

+ θ2Var (yt

1)

(cid:0)

(1

α)
(cid:0)
+ θ2Var (yt

α)

1)

(cid:0)

= ω + α

ω

=

ω

(cid:0)

(cid:0)

(1

(1

ω
α)(1

θ2)

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

10 / 69

ARCH Models

De…nition
An ARCH (q) model for the time varying conditional variance is

σ2
t = ω +

q
∑
i =1

αi ε2
t
(cid:0)

i = w + α(L)ε2
t
(cid:0)

1

Remark A su¢ cient condition for the conditional variance to be positive is

that the parameters of the model satisfy: ω > 0, (

i )αi (cid:21)

8

0

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

11 / 69

ARCH Models

De…ning νt

ε2
t (cid:0)

(cid:17)

σ2
t , the ARCH(q) model can be re-written as

( Notice that σ2

t = E (ε2
t j

It

(cid:0)

t = ω + α(L)ε2
ε2
t
(cid:0)
1))

1 + νt

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

12 / 69

AR(q) model for the squared innovations, ε2
Covariance stationary
less than one, which gives:

,

t .

the sum of the positive autoregressive parameters is

Var (ε2

t ) = ω/(1

α1

(cid:0)

(cid:0)

α2...

(cid:0)

αq ).

εt ’s are clearly not independent through time.

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

13 / 69

GARCH Models

ARCH(q): too many parameters,
t = ω + ∑q
i = ω + α1ε2
σ2
i =1 αi ε2
t
t
(cid:0)
(cid:0)
Generalized ARCH or GARCH (1,1):

1 + ∑q

i =2 αi ε2
t
(cid:0)

i

t = ω + αε2
σ2
t
(cid:0)

1 + βσ2
t
(cid:0)

1

Generalized ARCH or GARCH (p,q):

σ2
t = ω +

q
∑
i =1

= ω + α(L)ε2
t
(cid:0)

i +

p
∑
αi ε2
t
(cid:0)
i =1
1 + β(L)σ2
t
(cid:0)

βi σ2
t
(cid:0)

1

i

A su¢ cient condition for the conditional variance in the model to be well
de…ned is that all the coe¢ cients in the in…nite order linear ARCH are positive

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

14 / 69

GARCH Models

Rearranging the GARCH(p,q) model by de…ning

it follows that

νt = εt

σ2
t

(cid:0)

t = ω + (α(L) + β(L))ε2
ε2
t
(cid:0)
ARMA( Max(p, q),p) model for ε2
t

1 (cid:0)

β(L)νt

1 + νt

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

15 / 69

GARCH Models

Covariance stationary
the unit circle

,

all the coe¢ cients of (1

α(L)

(cid:0)

(cid:0)

β(L)) lie outside

sum of the autoregressive coe¢ cients is less than one

,
Standard time series techniques in the identi…cation of the orders of p and q

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

16 / 69

Persistence and stationarity

GARCH (1,1)
Assuming α + β < 1, the unconditional variance of εt +1 is:

(cid:0)
We can rewrite the GARCH (1,1) as:

ω
(α + β)

1

t = ω + (α + β)ε2
ε2
t
(cid:0)

1 (cid:0)

βνt

(cid:0)

1 + νt

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

17 / 69

Persistence and stationarity

The conditional expectation of volatility j periods ahead is:

1[σ2

t +j ] =

Et

(cid:0)

(1

w
α

(cid:0)

(cid:0)

+ (σ2

t (cid:0)

β)

w
α

(1

(cid:0)

β)

(cid:0)

)(α + β)j

Since, using iterative expectations,
Et

t +j ] = Et

1[Et +j

t +j ] = Et

1[ε2

1ε2

(cid:0)

(cid:0)

(cid:0)

1[σ2

t +j ]

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

18 / 69

IGARCH Models

De…nition
Integrated GARCH models are processes were the autorregresive part of the
square residuals has a unit root, i.e., (α + β) = 1. For this case the conditional
expectation of the volatility j periods ahead is

Et [σ2

t +j ] = σ2

t + j ω.

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

19 / 69

Looks very much like a random walk with drift ω.
The unconditional variance does not exist

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

20 / 69

EGARCH Models

GARCH models not well suited to capture the "leverage e¤ect"
In the exponential GARCH (EGARCH) σ2
sign of lagged residuals.

t depends on both the size and the

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

21 / 69

EGARCH Models

EGARCH(1,1):

(2/π)1/2] + δ(εt

1/σt

1))

ln σ2

t = α0 + β1 ln σ2
t
(cid:0)

1 + γ0([

εt

1/σt

1

j

j (cid:0)

(cid:0)

(cid:0)
Obviously the EGARCH model always produces a positive conditional
variance σ2
Because of the use of both
non-symmetric in εt and, for negative δ, will exhibit higher volatility for large
negative εt .

t for any choice of α0, β1, γ0

and (εt /σt ), σ2

t , it will also be

εt /σt

(cid:0)

(cid:0)

j

j

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

22 / 69

Other ARCH Speci…cations

Glosten, Jagannathan and Runkle (1989) proposed the following speci…cation:

εt = σt νt

where vt is iid.

where, It

(cid:0)

1 = 1 if εt

(cid:0)

(cid:21)

1 + α1ε2
t = α0 + β1σ2
σ2
t
t
(cid:0)
(cid:0)
1 = 0 if εt
0 and It

1

1 + α2ε2
t
(cid:0)
1 < 0.

1It

1,

(cid:0)

(cid:0)

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

23 / 69

Additional Explanatory Variables:

It is straightforward to add other explanatory variables to a GARCH speci…cation:

where X is any positive variable.

t = ω + βσ2
σ2
t
(cid:0)

1 + αε2
t
(cid:0)

1 + γXt

1,

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

24 / 69

GARCH-in-Mean Models

Many theories in …nance assume some kind of relationship between the mean
of a return and its variance .

GARCH in Mean Models allow for the conditional variance to have mean
e¤ects.

Time varying risk premium.

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

25 / 69

GARCH-in-Mean Models

Consider the following model:

yt = θxt + ψσ2

t + εt

and

t = ω + α(L)ε2
σ2
t
(cid:0)

1 + β(L)σ2
t
(cid:0)

1

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

26 / 69

ARCH-in-Mean Models

An ARCH in Mean model simply models the conditional variance as an ARCH
model instead of modeling as GARCH, i.e.

t = ω + α(L)ε2
σ2
t
(cid:0)

1

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

27 / 69

ARCH-in-Mean Models

Example
ARCH(1)-M
Consider a simple version of the above model:

yt = µ + λσ2

t + εt

where εt = vt σt

vt ~N(0,1)

t = ω + αε2
σ2
t
(cid:0)

1

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

28 / 69

ARCH-in-Mean Models

Example
Then yt may be expressed as

yt = µ + λ(ω + αε2
t
(cid:0)

1) + εt

Then the expected value of yt is

E (yt ) = µ + λω + λαE (ε2
t
(cid:0)

1)

and using that E (ε2
t
(cid:0)

1) = ω/(1

α)then

(cid:0)

E (yt ) = µ + λ(ω/(1

α))

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

29 / 69

Lagrange Multiplier test

Check there are ARCH e¤ects in the residuals

Lagrange Multiplier Test for ARCH :

Under the null, the AR(p) process for yt

yt = φ1yt

1 + φ2yt

(cid:0)

(cid:0)

2 + ... + φp yt

p + εt

(cid:0)
1 ~N(0,σ2)

where εt is a Gaussian white noise process, εt

It

j

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

30 / 69

Lagrange Multiplier Test

The test for ARCH(q) e¤ect simply consists on regressing

t = w + α1 ˆε2
ˆε2
t
(cid:0)

1 + α2 ˆε2
t
(cid:0)
Under the null hypothesis that α1 = α2 = ... = αq = 0, TR 2 is asymptotically
distributed χ(q), where T is the number of observations.

2 + ... + αq ˆε2
t
(cid:0)

q + ψt

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

31 / 69

Lagrange Multiplier Test

Caution! While this is the most widely used test we should be careful in

interpreting the results. If the model is misspeci…ed it is quite likely
to reject the null

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

32 / 69

Breaks in the variance will look as ARCH e¤ects when using the whole sample

In these cases, it is better to divide the sample and test for ARCH e¤ects in
the subperiods

Problem: How to divide the sample ex ante

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

33 / 69

Garch E¤ects and Sampling Frequency

GARCH models do not temporaly aggregate

Di¢ cult to determine at which sampling frequency the data presents GARCH
e¤ects

Empirical regularity: the higher is the sampling frequency, the higher the
GARCH e¤ects

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

34 / 69

Maximum Likelihood Estimation with Gaussian Errors

The estimation of GARCH type models is easily done by conditional maximum
likelihood.
If the model to be estimated is

where εt ~N(0,σ2
i.e. ;

t ), and the conditional variance is assumed to be GARCH(1,1),

yt = xt θ + εt

t = ω + αε2
σ2
t
(cid:0)
Then the conditional distribution of yt is

1 + βσ2
t
(cid:0)

1

f (yt

xt , It

j

(cid:0)

1) = (2πσ2

t )(cid:0)

.5 exp(

.5(yt

(cid:0)

(cid:0)

xt θ)2/σ2
t )

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

35 / 69

Maximum Likelihood Estimation with Gaussian Errors

Conditional log likelihood is

log L(θ, ω, α, β

1) =

It

j

(cid:0)

T
∑
t =1

(

(cid:0)

.5 log(2π)

.5 log(σ2
t )

.5σ(cid:0)
t

2

(yt

xt θ)2)

(cid:0)

(cid:0)

(cid:0)

Notice that at time 1 we need initial values for ε2

0 and σ2
0:

and

σ2
0 = ω/(1

α

(cid:0)

(cid:0)

β)

ε2
0 = (ω/(1

α

(cid:0)

(cid:0)

β))

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

36 / 69

Maximum Likelihood Estimation with Non-Gaussian Errors

Some unconditional distributions seem to have fatter tails than the normal:

another distribution for εt : t-distribution.

f (εt ) =

(Γ[(ν + 1)/2]/Γ(ν/2))((ν
2)πσ2
(cid:0)
(ν+1)/2
t /(σ2
2))](cid:0)

[1 + (ε2

t (ν

.5

t )(cid:0)

(cid:0)
n represents the degrees of freedom (estimate)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

37 / 69

How to compare between Di¤erent GARCH Speci…cations

Most GARCH models are non nested

this makes comparison not straight forward

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

38 / 69

Misspeci…cation tests on the standardized residuals

ARCH(1):

Test for the existence ARCH e¤ects in the standardized residuals

εt = vt (ω + αε2
t
(cid:0)

1)1/2

ˆvt = ˆεt /( ˆω + ˆαˆε2
t
(cid:0)

1)1/2

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

39 / 69

Comparison between alternative models based on auxiliary
regressions

Auxiliary regression as a mean of choosing between di¤erent ARCH models:

t = α + β ˆσ2
ˆε2

t + ξt

Regress the squared residuals on the …tted variance of the alternative GARCH
models.

Pagan and Scwhert (1989) propose to test the joint hypothesis:

H0) α = 0, β = 1

H1) α

= 0, β

= 1

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

40 / 69

6
6
Comparison between alternative models based on auxiliary
regressions

As a second step, they propose to compare the models that were not rejected
on the basis of goodness of …t.

The better the …t the better it mimics the conditional variance.

Scale e¤ects: logs

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

41 / 69

Measuring the accuracy of Forecasts of Di¤erent ARCH
Models

Forecasting ability of the di¤erent ARCH models as a way of comparing them

Various loss functions have been proposed :

Mean Squared Error

Mean Absolute Error.

MSE = (1/l )(

T +l
∑
t =T

(ˆε2

t (cid:0)

t )2)
ˆσ2

MAE = (1/l )(

T +l
∑
t =T j

ˆε2
t (cid:0)

ˆσ2
t j

)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

42 / 69

Mean Squared Error of the log of the squared residuals.

[LE ]2 = (1/l )(

T +l
∑
t =T

(ln(ˆε2
t )

(cid:0)

ln( ˆσ2

t ))2)

Mean Absolute Error of the log of the squared residuals.

[MAE ]2 = (1/l )(

T +l
∑
t =T j

ln(ˆε2
t )

ln( ˆσ2
t )

)

j

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

43 / 69

Forecasting performance at di¤erent horizons

Mean Squared Error

MSE = (1/l )(

τ

T +l
∑
(cid:0)
t =T

t +τ (cid:0)τ ˆσ2
(ˆε2

t )2)

Mean Absolute Error.

MAE = (1/l )(

τ

T +l
∑
(cid:0)
t =T j

t +τ (cid:0)τ ˆσ2
ˆε2
t j

)

where τ ˆσ2
time t.

t is the forecast of the variance τ periods ahead given information at

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

44 / 69

Mean Squared Error of the log of the squared residuals.

[LE ]2 = (1/l )(

τ

T +l
∑
(cid:0)
t =T

(ln(ˆε2

t +τ)

(cid:0)

ln( ˆσ2

t ))2)

Mean Absolute Error of the log of the squared residuals.

[MAE ]2 = (1/l )(

τ

T +l
∑
(cid:0)
t =T j

ln(ˆε2

t +τ)

ln( ˆσ2
t )

)

j

(cid:0)

where τ ˆσ2
time t.

t is the forecast of the variance τ periods ahead given information at

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

45 / 69

Multivariate GARCH Models

Multivariate extension of the GARCH(p,q) as follows:

yt = µ + ut

vech(Ht ) = C +

p
∑
i =1

Ai vech(ut

i u0t

(cid:0)

(cid:0)

i ) +

q
∑
i =1

Bi vech(Ht

i )

(cid:0)

where ut

It

j

(cid:0)

1~N(0,Ht )

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

46 / 69

Multivariate GARCH Models

n conditional variance matrix associated with u0t
1 vector of all the unique elements of Ht

(cid:0)

It

1) :n

Ht = E (ut u0t j
(cid:2)
vech(Ht ): (n(n + 1))/2
µ is n
1
C is (n(n + 1))/2
(cid:2)
A1, A2, ...Ap , B1, ...Bq are (n(n + 1))/2

(cid:2)

(cid:2)

1

(n(n + 1))/2

(cid:2)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

47 / 69

Multivariate GARCH Models

Example

A bivariate GARCH (1,1)

xt
wt

=

(cid:21)

(cid:20)

µx
µw (cid:21)

+

(cid:20)

εt
νt

(cid:21)

(cid:20)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

48 / 69

Multivariate GARCH Models

Example
where

or

2

4

vech(Ht ) = C + Avech(ut

1u0t

(cid:0)

(cid:0)

1) + Bvech(Ht

1)

(cid:0)

Vt
COVt
Vt

(cid:0)

1(xt )
1(xt wt )
(cid:0)
1(wt )

(cid:0)

=

3

5

a1
a4
a7
b3
b6
b9

3

5

2

4

+

b2
b5
b8

2

4
+

cx
cxw
cw

b1
b4
b7

2

4

a2
a5
a8

a3
a6
a9

3

2

5
Vt
COVt
(cid:0)
Vt

4
2(xt
(cid:0)
2(xt
(cid:0)
2(wt

(cid:0)

3

2

5

4

(εt

1)2

(εt

(cid:0)
1νt

(cid:0)
(νt

(cid:0)
1)
(cid:0)
1wt
1)

(cid:0)

(cid:0)

1)
1)2 3
5

1)

(cid:0)

3

5

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

49 / 69

A Diagonal Vech Parametrization

Assume that each covariance depends only on its own past values and
innovations
Each element of Ht follows an univariate GARCH model driven by the
corresponding cross product ut u0t .

cx
cxw

cxw
cw

a1
a5

a5
a9

,

(cid:21)

(cid:20)

,

(cid:21)

(cid:20)

b1
b5

b5
b9

(cid:21)

(cid:20)

are all positive de…nite.

This can be ensured by doing simple Cholesky transformations to each of
these matrices.

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

50 / 69

A Quadratic Speci…cation

Ht = C 0C + A

C is a lower triangular with n(n + 1)/2 parameters A and B are square
matrices with n2 parameters each

ut

(cid:0)

1u0t

0

(cid:0)

1A + B 0Ht

1B.

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

51 / 69

A Constant Correlation Speci…cation

Correlation between the assets is constant

COVt

(cid:0)

1(xt wt ) = ρ

Vt

1(xt )Vt

1(wt )

(cid:0)

(cid:0)

q

ρ is also estimated with the rest of the parameter set

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

52 / 69

Stationarity

Conditions are similar to those discussed in the univariate case.
The minimum square error forecast for vech(Ht ) ~GARCH(1, 1)

Es (vech(Ht )) = [

1

t

s
∑
(cid:0)
(cid:0)
k =0

(A1 + B1)k ]C + (A1 + B1)t

(cid:0)

s vech(Hs )

This can be derived in the usual way noting that

vech(Ht ) = C + Avech(ut

(cid:0)
vech(ut u0t ) = vech(Ht ) + vech(ηt )
1) + vech(ηt

1) = vech(Ht

1u0t

(cid:0)

(cid:0)

vech(ut

(cid:0)

(cid:0)

1),

(cid:0)

1u0t

1) + Bvech(Ht

1),

(cid:0)

writing the stochastic representation

vech(ut u0t ) = C + (A + B)vech(ut

1u0t

1)

(cid:0)

(cid:0)

(cid:0)

Bvech(ηt

(cid:0)

1) + vech(ηt ),

and doing the same derivation as in the univariate case.

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

53 / 69

Stationarity

Let V ΛV (cid:0)

1 denote the Jordan decomposition of the matrix A1 + B1, so that

(A1 + B1)t

(cid:0)

s = V Λt

s V (cid:0)

1

(cid:0)

A1

Es (vech(Ht )) converges to the vech of the unconditional covariance matrix,
vech(Σ) = (I
(cid:0)
value of A1 + B1 is strictly less than one.
If the absolute value of the largest eigen value of A1 + B1 is strictly less than
one, then the forecast can be written

the absolute value of the largest eigen

B1)(cid:0)

1C

,

(cid:0)

Es (vech(Ht )) = vech(Σ) + (A1 + B1)t

(cid:0)

s (vech(Hs )

vech(Σ))

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

54 / 69

Co-Persistence in Variance

The empirical estimates for univariate and multivariate ARCH models often
indicate a high degree of persistence in the forecast moments of the
conditional variances,

Es (Ht )ii , i = 1, 2, ....N, for t

∞.

!

This persistence may be common across di¤erent series.

De…nition
The multivariate ARCH process is said to be co-persistent in variance if at least
one of the elements in Es (Ht ) is non-convergent for increasing forecasts, t
s,
but there exists a linear combination γ0εt , such that for every forecast origin s,
the forecasts of the corresponding future conditional variances Es (γ0Ht γ)
converge to a …nite limit, independent of time s information.

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

55 / 69

Multivariate GARCH-M Models

Consider a system of n regression equations,

vech(Ht ) = C +

yt = BXt + Dvech(Ht ) + ut
q
∑
i =1

Ai vech(ut

p
∑
i =1

i ) +

i u0t

(cid:0)

(cid:0)

Bi vech(Ht

i )

(cid:0)

where

It

1~N(0, Ht )Bn

ut
(cid:2)
A1, A2, ...Ap , B1, ....Bq are(n(n + 1))/2

k , Dn

(cid:2)

(cid:0)

j

(n(n+1))/2, C(n(n+1))/2

1,

(cid:2)

(n(n + 1))/2

(cid:2)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

56 / 69

A Bivariate GARCH-M (1,1) Model

xt
wt

=

(cid:21)

(cid:20)

µx
µw (cid:21)

+

(cid:20)

d1
d4

(cid:20)

d2
d5

d3
d6

(cid:21)

2

4

Vt
COVt
Vt

(cid:0)

1(xt )
1(xt wt )
(cid:0)
1(wt )

(cid:0)

εt
νt

+

(cid:20)

(cid:21)

3

5

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

57 / 69

A Bivariate GARCH-M (1,1) Model

Vt
COVt
Vt

(cid:0)

1(xt )
1(xt wt )
(cid:0)
1(wt )

(cid:0)

2

4

=

3

5

c1
c4
c4
b3
b6
b6

3

5

2

4

+

b2
b5
b5

2

4
+

cx
cxw
cw

b1
b4
b4

2

4

c2
c5
c5

c3
c6
c6

3

2

(εt

(εt

1)2

(cid:0)
(νt

(cid:0)

(cid:0)
1νt

1)
1)2 3
(cid:0)
5
1)
(cid:0)
1wt
1)

1)

3

(cid:0)

5

5
Vt
COVt
(cid:0)
Vt

4
2(xt
(cid:0)
2(xt
(cid:0)
2(wt

(cid:0)

(cid:0)

3

2

5

4

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

58 / 69

Estimation

Conditional maximum likelihood estimation.

Lt (θ) =

(cid:0)

(n/2) log(2π)

(1/2) log(

Ht (θ)

)

j

(cid:0)

j

(cid:0)

(1/2)ut (θ)0H (cid:0)
t

1

(θ)ut (θ)

where θ represents a vector of parameters, n represents number of equations
and t represents time.

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

59 / 69

Estimation

Conditional on initial values for u0 and H0 , the likelihood function for the
sample:

L(θ) =

T
∑
t =1

Lt (θ)

Model is highly non-linear and very unstable.

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

60 / 69

Testing the CAPM

Problems:

The CAPM is a statement about the relationships between ex ante risk
premiums and betas, both of which there are not directly observable.
The Roll- critique
The CAPM is a single-period model

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

61 / 69

The Unconditional CAPM

In the simple version of the CAPM the expected return for asset j is

E (rj ) = rf + βjm (E (rm )

rf )

(cid:0)

where rj , rf and rm are the asset j, risk free and market rate of return
respectively.

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

62 / 69

The Unconditional CAPM

De…ning excess returns ˜r , we can rewrite the above expressions as

where

E (˜rj ) = βjm (E ˜rm )

˜rj = rj (cid:0)
˜rm = rm

rf

rf

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

63 / 69

The Conditional CAPM

Models for rjt in which the conditional density rather than the unconditional
density returns is used.

Conditional asset pricing model has

where βjt = cov (˜rjt ˜rmt

j

1)/var (˜rmt

1).

It

j

(cid:0)

1) = βjt E (˜rmt

It

(cid:0)

1)

It

j

(cid:0)

E (˜rjt j
It

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

64 / 69

Multivariate GARCH-M Models: A CAPM with time
varying covariances

The conditional CAPM can be written as

E (rjt j

It

(cid:0)

1)

(cid:0)

rft

(cid:0)

1 = βjt [E (rmt

1)

It

j

(cid:0)

(cid:0)

rft

(cid:0)

1]

βjt = cov (rjt rmt

1)/var (rmt

It

j

(cid:0)

1).

It

j

(cid:0)

where

and

H =

(cid:20)

var (rjt j
It
cov (rjt rmt

1)
(cid:0)
It
j

(cid:0)

1)

cov (rjt rmt
It
j
var (rmt
It

1)
(cid:0)
1)

j

(cid:0)

(cid:21)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

65 / 69

Multivariate GARCH-M Models: A CAPM with time
varying covariances

If we assume that the ”market price of risk”, λ is constant, where

λ = (E (rmt

1)

It

j

(cid:0)

(cid:0)

rft

(cid:0)

1)/var (rmt

1)

It

j

(cid:0)

Then we can write

E (rjt j

It

(cid:0)

1)

(cid:0)

rft

(cid:0)

rft

1]

(cid:0)

(cid:0)

=

1 = βjt [E (rmt
It
j
(cid:0)
cov (rjt rmt
It
j
var (rmt
It
(cid:0)
= λcov (rjt , rmt
j

1)
1)
(cid:0)
1)
It

j

(cid:0)

[E (rmt

1)

It

j

(cid:0)

(cid:0)

rft

(cid:0)

1].

1)

And …nally

rjt = rft

(cid:0)

1 + λcov (rjt , rmt

1) + ujt

It

j

(cid:0)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

66 / 69

Notice that

E (rmt

(since λ = (E (rmt

j

It

1)

It

j

1)

rft
(cid:0)
(cid:0)
1)/var (rmt

1 = λvar (rmt
1) )

It

(cid:0)
rft

1)

It

j

(cid:0)

(cid:0)
(cid:0)
rmt = rft

j
(cid:0)
1 + λvar (rmt

(cid:0)

(cid:0)
It

j

1) + umt

(cid:0)

where ujt and umt are the innovations.

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

67 / 69

Time varying CAPM can be put into multivariate GARCH-M form as

yt = b + dvech(Ht ) + ut

where yt = (rjt (cid:0)
cov (rjt rmt
j

rft
1), var (rmt

1, rmt
It

It

(cid:0)

(cid:0)

j

1)0, vech(Ht ) = (var (rjt j

rft
(cid:0)
1))0, ut = (ujt , umt )0 and
(cid:0)

(cid:0)

1),

It

(cid:0)

d = λ

(cid:20)

0
0

1
0

0
1

.

(cid:21)

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

68 / 69

The zero restrictions implied by the theory may be tested by a likelihood ratio
test which is asymptotically distributed χ2(5).

Martin Sola (FE)

Univariate and Mutivariate Models

07/11

69 / 69

Threshold Models

Series de Tiempo

july 2019

Martín Solá ()

Threshold Models

08/10

1 / 46

Introduction

Economic variables may behave very di¤erently in di¤erent states of the
economy such as, for example, high/low in‡ation, high/low growth, or
high/low stock prices (relative to dividends).

A variety of nonlinear models have been proposed for describing the dynamics
of economic time series subject to changes in regime [see, e.g., Tong (1983,
1990); Hamilton (1993); van Dijk et al. (2002); Dueker et al. (2007)].

Martín Solá ()

Threshold Models

08/10

2 / 46

TAR and SETAR Models

Self-Exciting Threshold AutoRegressive (SETAR) models are an extension of
autoregressive models which allow for a di¤erent behaviour of the series once
the series enters a di¤erent regime.

The switch from one regime to another depends on a past value of the series
(hence the Self-Exciting portion of the name). crossing a threshold value. A
possible parameterization of the SETAR model is

yt = y1t
= y2t

if yt
if yt

(cid:0)

(cid:0)

1 < k
k

1

(cid:21)

where

yit = µi +

p
∑
j =1

(i )
j yt

α

(cid:0)

j + σi ut ,

i = 1, 2,

(1)

(2)

To estimate the model a grid has to be created for k, and then choose the
value of the grid with highest likelihood. Notice that the model can be
estimated by OLS and evaluated using MLE.

Martín Solá ()

Threshold Models

08/10

3 / 46

In general we can consider a model such as

yt = y1t
= y2t

if zt < k
k
if zt

(cid:21)

(3)

where zt is a vector of exogenous or predetermined variables. When doing this we
have to be careful with the exogeneity assumptions about zt .

To test for the existence of two states is not trivial because under the null
that

µ1 = µ2
(2)
(1)
= α
j
j

α

for j = 1, ..., p.

the parameter k is not de…ned, or is what is called a nuisance parameter.

Martín Solá ()

Threshold Models

08/10

4 / 46

Smooth Transition Autoregressive Models

One posible drawback of the SETAR models is that potential big changes on
the conditional mean process are trigerred by small changes in the variable
that drives the regimes.
The STAR model may be thought of as a function of two (or more)
autoregressive processes which are averaged, at any given point in time,
according to some continuous function G (
(cid:1)
STAR models for the univariate time series

) taking values in [0, 1].

may be formulated as

yt = G (zt

1)y1t + [1

G (zt

t = 1, 2, . . . ,

(cid:0)
1 is a vector of exogenous and/or pre-determined variables and

(cid:0)

(cid:0)

where zt

(cid:0)

xt

f
g
1)]y2t ,

yit = µi +

p
∑
j =1

(i )
j yt

α

(cid:0)

j + σi ut ,

i = 1, 2,

(4)

(5)

where p is a positive integer,
f
(i.i.d.) random variables such that ut is independent of (yt
E(ut ) = E(u2
(i = 1, 2;

j = 1, . . . , p) are real constants.

t (cid:0)

ut

g

1) = 0, σ1 and σ2 are positive constants, and µi and α

are independent and identically distributed

p , . . . , y0)

(i )
j

(cid:0)

Martín Solá ()

Threshold Models

08/10

5 / 46

Logistic Smooth Transition Autoregressive Models

STAR models like (4)–(5) have been used extensively in the analysis of
economic and …nancial data. The main feature that di¤erentiates alternative
STAR speci…cations is the choice of the mixing (or transition) function G (
)
and the transition variables zt
1 (see Teräsvirta, 1998; van Dijk et al., 2002).
A popular choice for G (

) in (4) is the logistic speci…cation

(cid:0)

(cid:1)

(cid:1)

G (yt

1) =

(cid:0)

exp
f(cid:0)
1 + exp

γ(yt

1
(cid:0)
γ(yt

f(cid:0)

y (cid:3))

(cid:0)
1
(cid:0)

(cid:0)

g
y (cid:3))

γ > 0,

(6)

,

g

which gives rise to the pth-order LSTAR model, or LSTAR(p).
The location parameter y (cid:3) in (6) may be interpreted as the threshold between
the two regimes associated with the extreme values limyt
and limyt
smoothness of the transitions between the two regimes.

1) = 0
1) = 1, while the slope parameter γ determines the

∞ G (yt

∞ G (yt

!(cid:0)

!

(cid:0)

(cid:0)

(cid:0)

(cid:0)

1

1

Martín Solá ()

Threshold Models

08/10

6 / 46

Exponential Smooth Transition Autoregressive Models

ESTAR models are intended to capture a di¤erent behavior of the time
series when is close to the threshold from when it is far from the threshold.

y (cid:3))2

,

g

(cid:0)

G (yt

1) = exp

γ(yt

1

γ > 0,

(7)

f(cid:0)

(cid:0)

(cid:0)
which gives rise to the pth-order ESTAR model, or ESTAR(p). Notice that
the extreme values limyt
while limyt
This type of models are used for situations like target zones where the
behaviour of the exchange rate in the middle of the band is di¤erent from
that in the middle of the band.

1) = 0 and limyt

!
(cid:0)
1) = 1.

1) = 0,

∞ G (yt

∞ G (yt

G (yt

!(cid:0)

y (cid:3)

!

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

1

1

1

Martín Solá ()

Threshold Models

08/10

7 / 46

Univariate Contemporaneous-Threshold Models

yt

g
f
1)]y2t ,

The C-STAR model of Dueker et al. (2007) may be thought of as a function
of two (or more) autoregressive processes which are averaged, at any given
point in time, according to some continuous function G (
) taking values in
[0, 1].
STAR models for the univariate time series

may be formulated as

(cid:1)

yt = G (zt

1)y1t + [1

G (zt

t = 1, 2, . . . ,

(cid:0)
1 is a vector of exogenous and/or pre-determined variables and

(cid:0)

(cid:0)

where zt

(cid:0)

yit = µi +

p
∑
j =1

(i )
j yt

α

(cid:0)

j + σi ut ,

i = 1, 2,

where p is a positive integer,
f
(i.i.d.) random variables such that ut is independent of (yt
E(ut ) = E(u2
(i = 1, 2; j = 1, . . . , p) are real constants.

t (cid:0)

ut

g

1) = 0, σ1 and σ2 are positive constants, and µi and α

are independent and identically distributed

p , . . . , y0),

(i )
j

(cid:0)

Martín Solá ()

Threshold Models

08/10

8 / 46

The feature that di¤erentiates alternative STAR models is the choice of the
mixing function G (
Dijk et al. (2002)].
The C-STAR model of order p is obtained by de…ning the mixing function
G (

) and transition variables zt

1 [cf. Teräsvirta (1998); van

) in (4) as

(cid:0)

(cid:1)

(cid:1)

G (zt

1) =

(cid:0)

P(y1t < y (cid:3)j
(i )
p , σ2

(i )
1 , . . . , α

P(y1t < y (cid:3)j
zt

zt
1; ϑ1) + P(y2t > y (cid:3)j

1; ϑ1)

(cid:0)

(cid:0)

1; ϑ2)

zt

(cid:0)

where ϑi = (µi , α
with regime i, and zt
Letting αi = (α
two-regime

(cid:0)

(i )
1 , . . . , α

i )0 is the vector of parameters associated
1, ..., yt

1 = (yt
(i )
p )0 (i = 1, 2), the (conditionally) Gaussian

p )0.

(cid:0)

(cid:0)

G (zt

1) =

(cid:0)

Φ(

y (cid:3) (cid:0)

µ1 (cid:0)
σ1

α01zt

1

(cid:0)

)

Φ(

y (cid:3) (cid:0)

µ1 (cid:0)
σ1

α01zt

1

(cid:0)

) + 1

Φ(

y (cid:3) (cid:0)

µ2 (cid:0)
σ2

(cid:0)

α02zt

1

(cid:0)

)

,

(8)

where Φ(
(cid:1)
threshold parameter.

) denotes the standard normal distribution function and y (cid:3) is a

Martín Solá ()

Threshold Models

08/10

9 / 46

Hence, (4) may be rewritten as

yt =

P(y1t < y (cid:3)j

zt
P(y1t < y (cid:3)j

1; ϑ1)y1t + P(y2t
(cid:0)
1; ϑ1) + P(y2t
zt

(cid:0)

zt
zt

y (cid:3)j
y (cid:3)j

(cid:0)

(cid:0)

(cid:21)
(cid:21)

1; ϑ2)y2t
1; ϑ2)

.

As with conventional STAR models, a C-STAR model may be thought of as a
regime-switching model that allows for two regimes associated with the two
latent variables y1t and y2t .
Alternatively, a C-STAR model may be thought of as allowing for a
continuum of regimes, each of which is associated with a di¤erent value of
G (zt

1).

(cid:0)

Martín Solá ()

Threshold Models

08/10

10 / 46

One of the main purposes of the C-STAR model is to address two somewhat
arbitrary features of conventional STAR models:
First, STAR models specify a delay such that the mixing function for period t
consists of a function of yt
j for some j
Second, STAR models specify which of and in what way the model
parameters enter the mixing function.

(cid:21)

1.

(cid:0)

C-STAR models address these twin issues in an intuitive way: they use a
forecasting function such that the mixing function depends on the ex ante
regime-dependent probabilities that yt will exceed the threshold value(s).
Furthermore, the mixing function makes use of all of the model parameters in
a coherent way.

Martín Solá ()

Threshold Models

08/10

11 / 46

Martín Solá ()

Threshold Models

08/10

12 / 46

Martín Solá ()

Threshold Models

08/10

13 / 46

Stability Properties of the Skeleton of the C-STAR

As Chan and Tong (1985) pointed out, we can analyze the properties of a
nonlinear time series by considering the deterministic part of the model alone.

This part is usually called the skeleton of the model and is de…ned as
yt = F (yt

1, Θ), where

(cid:0)

F (yt

1)(µ0 + α0

1yt

1) + (1

G (yt

(cid:0)

1))(µ1 + α1

1yt

1),

(9)

(cid:0)

(cid:0)
and Θ =
Then a …xed point of the skeleton of the model is any value, yL, that satis…es

(cid:0)

(cid:0)

(cid:0)

.

1, Θ) = G (yt
Θ0, Θ1, y (cid:3)g

f

yL = F (yL, Θ) = G (yL)(µ0 + α0

1yL) + (1

G (yL))(µ1 + α1

1yL).

(10)

(cid:0)

Martín Solá ()

Threshold Models

08/10

14 / 46

Since the C-STAR(1) is a nonlinear model, there may be one, several or no
equilibrium values that satisfy equation (10).

Then, assessing which of the equilibria of the nonlinear …rst-order di¤erence
equation are stable is crucial for learning about the stability properties of the
C-STAR model.

We use each of the DGPs presented in Table 2 to assess:

i) the number of equilibria and

ii) the stability of the equilibria.

Martín Solá ()

Threshold Models

08/10

15 / 46

We …nd the number of equilibria for the di¤erent DGPs presented in Table 1,
using a grid of starting values to solve equation (10) numerically.

For each equilibrium, we analyze whether it is locally stable by considering
the following expansion around the …x point

yt

(cid:0)

yL = F (yt

1, Θ)
(cid:0)
1, Θ)
(yt
1

(cid:0)
∂F (yt
(cid:0)
∂yt

(cid:0)

F (yL, Θ)

yL).

1

(cid:0)

(cid:0)

'

Whenever
is a contraction in the neighborhood of y = yL.

∂F (yt
(cid:0)
∂yt
(cid:0)

1,Θ)
1

< 1, the equilibrium is locally stable and F (yt

(cid:12)
(cid:12)
(cid:12)

(cid:12)
(cid:12)
(cid:12)

(11)

1, Θ)

(cid:0)

Martín Solá ()

Threshold Models

08/10

16 / 46

Where

∂F (yL, Θ)
∂yt

1

(cid:0)

and

= α1

1 + (α0

1 (cid:0)

α1
1)G (yL) +

h

(µ0 (cid:0)

µ1) + (α0

1 (cid:0)

α1
1)yL

∂G (yL)
∂yt
1
(cid:0)
(12)

i

∂G (yL)
∂yt
1

(cid:0)
w L

α0
σ0

=

(cid:0)

(cid:18)

φ(w L

1 ) +

0 )Φ(w L

α1
σ1
Φ(w L
Φ(w L
0 ) + [1
(cid:0)
1yL)/σ0 and w L
α0

φ(w L

1 )Φ(w L
0 )
2

1 )]
1 = (y (cid:3)
(cid:1)

0 = (y (cid:3)

µ0 (cid:0)
(cid:0)

(cid:0)

(cid:19)

, where φ = Φ0,

µ1 (cid:0)

(cid:0)

α1
1yL)/σ1.

Martín Solá ()

Threshold Models

08/10

17 / 46

Martín Solá ()

Threshold Models

08/10

18 / 46

Martín Solá ()

Threshold Models

08/10

19 / 46

State Dependent Contemporaneous-Threshold Models

Here we investigate the possibility that the separation of regimes implied by
nonlinear regime-switching autoregressive models is better characterized in
relative terms rather than being dictated by the (constant) level of some
variables.

We consider the threshold as function of variables which potentially a¤ect the
evolution of the time series under consideration.

For example, interest rates may be considered high or low not in absolute
terms but relative to relevant macroeconomic variables that describe the
state of the economy. A rate of interest which is considered to be high when
the economy is in a state of low in‡ation and high output growth may be
considered too low when the economy in a state of high in‡ation and low
output growth.
We propose to model such behavior using variants of smooth transition
autoregressive (STAR) models which allow the interest rate threshold to
evolve over time as a function of in‡ation and output growth.

Martín Solá ()

Threshold Models

08/10

20 / 46

State Dependent Contemporaneous-Threshold Models

We generalize the standard C-STAR speci…cations to allow for state
dependency of the threshold.
We de…ne y (cid:3)t
(cid:0)
combination of the elements of a k-dimensional vector
1 = (x1,t
xt
variables, that is,

1 as a time-varying threshold. This is speci…ed as a linear

1)0 of observable exogenous and/or predetermined

1, . . . , xk ,t

(cid:0)

(cid:0)

(cid:0)

1 = y (cid:3) + δ0xt
where y (cid:3) is an unknown threshold intercept and δ = (δ1, . . . , δk )0 is a vector
of unknown parameters.

y (cid:3)t
(cid:0)

(13)

1,

(cid:0)

Martín Solá ()

Threshold Models

08/10

21 / 46

State Dependent Contemporaneous-Threshold Models

The SDC-STAR(p) model
To generalize the C-STAR(p) speci…cation to allow for a state-dependent
threshold, the mixing weights in (8) are replaced with

G (zt

1) =

(cid:0)

y (cid:3)t
(cid:0)

1 (cid:0)

F1(

α01yt

1

(cid:0)

)

µ1 (cid:0)
σ1

y (cid:3)t
(cid:0)

1 (cid:0)

F1(

µ1 (cid:0)
σ1

α01yt

1

(cid:0)

) + 1

y (cid:3)t
(cid:0)

1 (cid:0)

F2(

µ2 (cid:0)
σ2

(cid:0)

,

α02yt

1

(cid:0)

)

(14)

1 is a time-varying threshold depending on the observable

where y (cid:3)t
(cid:0)
exogenous and/or predetermined variables xt
As before, the threshold y (cid:3)t
(cid:0)
elements of xt

1 given in (13).

(cid:0)

1)0.
1 is speci…ed to be the linear combination of the

1, and zt

1 = (y0t

1, x0t

(cid:0)

(cid:0)

(cid:0)

(cid:0)

Martín Solá ()

Threshold Models

08/10

22 / 46

State Dependent Contemporaneous-Threshold Models

Notice that

G (zt

1) =

(cid:0)

and

P(y1t < y (cid:3)t
(cid:0)

P(y1t < y (cid:3)t
zt
(cid:0)
(cid:0)
1) + P(y2t
1j

1j

zt

(cid:0)

1)

(cid:21)

zt

y (cid:3)t
(cid:0)

1j

(cid:0)

1)

1

G (zt

1) =

(cid:0)

(cid:0)

P(y1t < y (cid:3)t
1j
(cid:0)
Hence, under the assumptions in (13)–(14), the SDC-STAR(p) model may
be rewritten as

y (cid:3)t
(cid:0)

1)

1j

zt

(cid:21)

(cid:0)

(cid:0)

.

P(y2t
zt

y (cid:3)t
zt
(cid:21)
(cid:0)
(cid:0)
1) + P(y2t

1j

1)

yt =

P(y1t < y (cid:3)t
(cid:0)

zt
1j
P(y1t < y (cid:3)t
(cid:0)

1)y1t + P(y2t
(cid:0)
1) + P(y2t
zt
1j

(cid:0)

zt
zt

y (cid:3)t
(cid:0)
y (cid:3)t
(cid:0)

1j
1j

(cid:0)

(cid:0)

(cid:21)
(cid:21)

1)y2t
1)

.

(15)

As in the case of the C-STAR, the mixing weights involve the probability that
the contemporaneous value of y1t (y2t ) is smaller (greater) than some
threshold level y (cid:3)t
(cid:0)
The SDC-STAR(p) model reduces to a C-STAR(p) under the restriction
δ = 0.

1.

Martín Solá ()

Threshold Models

08/10

23 / 46

State Dependent Contemporaneous-Threshold Models

A SDC-STARX(p) Model.
This model includes exogenous and/or predetermined variables xt
equation that describes the dynamics of the latent variables y1t and y2t .
More speci…cally, let

(cid:0)

1 in the

yit = µi + α(i )

0yt

1 + δ(i )

0xt

(cid:0)

1 + σi uit ,

(cid:0)

i = 1, 2,

(16)

where δ(i ) = (δ
the form

(i )
1 , . . . , δ

(i )
k )0 are unknown parameters, and take G (

) to have

(cid:1)

G (zt

1) =

(cid:0)

y (cid:3)t
(cid:0)

1 (cid:0)

F1(

β01zt

1

(cid:0)

)

µ1 (cid:0)
σ1

y (cid:3)t
(cid:0)

1 (cid:0)

F1(

µ1 (cid:0)
σ1

β01zt

1

(cid:0)

) + 1

y (cid:3)t
(cid:0)

1 (cid:0)

F2(

µ2 (cid:0)
σ2

(cid:0)

,

β02zt

1

(cid:0)

)

(17)

with βi = (α0i , δ0i )0 (i = 1, 2). Equations (4), (13), (16) and (17) de…ne a
pth-order state-dependent C-STAR model with exogenous variables.

Martín Solá ()

Threshold Models

08/10

24 / 46

State Dependent Contemporaneous-Threshold Models

0xt

δ(1)

The SDC-STARX(p) model nests several speci…cations.
If δ(1) = δ(2), δ = 0, we obtain a restricted SDC-STARX(p) model, or
RSDC-STARX (p), the mixing weights of which are the same as those of a
1 = y (cid:3) (cid:0)
SDC-STAR(p) model with threshold y (cid:3)t
(cid:0)
speci…cations are not, however, equivalent because they imply di¤erent
conditional distributions for the latent variables yit .
If δ(1) = δ(2) = 0, the SDC-STARX(p) model becomes a SDC-STAR(p).
If δ = 0, we obtain a pth-order C-STAR model with exogenous variables, or
C-STARX(p), and constant threshold y (cid:3).
Finally, if δ(1) = δ(2) = δ = 0, the SDC-STARX(p) reduces to a C-STAR(p)
with constant threshold y (cid:3).
The validity of these restrictions on δ(1), δ(2) and δ can be tested using, for
example, conventional likelihood ratio (LR) tests.

1; the two

(cid:0)

Martín Solá ()

Threshold Models

08/10

25 / 46

Stability

The stability properties of SDC-STAR and C-STARX models follow as special
cases of the SDC-STARX.
Consider a SDC-STARX(1) model with a threshold which depends on a single
1 (k = 1). The skeleton of such a model is de…ned as
exogenous variable xt

(cid:0)

Yt = S (Yt

1, Xt

1),

(cid:0)

(cid:0)

where

S (Yt

1, Xt

(cid:0)

(cid:0)

1) = G (Yt

(cid:0)

1, Xt
(cid:0)
(cid:0)
1 = y (cid:3) + δxt

and G (Yt
y (cid:3)t
(cid:0)

(cid:0)

1, Xt

(cid:0)
G (Yt

1)

µ1 + α
1)

f
1, Xt

(1)
1 Xt

(1)
1 Yt

1 + δ
(2)
1 Yt

(cid:0)
µ2 + α

1

g
(cid:0)
(2)
1 + δ
1 Xt

+

1

f

(cid:0)

(cid:0)

(cid:0)
1) is given by (17) with zt
1.

(cid:0)

gf
1 = (Yt

(cid:0)
1)0 and

1, Xt

(cid:0)

(cid:0)

(18)

,(19)
1
g

(cid:0)

Martín Solá ()

Threshold Models

08/10

26 / 46

Stability

Assuming
xt
g
which satis…es the equation

f

is stationary, a …xed point of the skeleton is any value Ye

Ye = S (Ye , Xe ),

(20)

where Xe = E(xt ). The value Ye is said to be an equilibrium point of the
SDC-STARX(1) model and, since the model is nonlinear, there may be one,
several or no equilibrium points satisfying (20).

An examination of the local stability of each of the equilibrium points can be
carried out by considering a …rst-order Taylor expansion about the …xed point,

Yt

Ye

(cid:0)

(cid:25)

λ(Ye , Xe )(Yt

Ye ),

1

(cid:0)

(cid:0)

where

λ(Ye , Xe ) =

∂S (Yt
(cid:0)
∂Yt

1, Xe )
1

(cid:0)
< 1, then the equilibrium is locally stable and Yt is a

(cid:0)

λ(Ye , Xe )

If
contraction in the neighbourhood of (Ye , Xe ).

j

j

Yt

1=Ye

(cid:12)
(cid:12)
(cid:12)
(cid:12)

(21)

(22)

.

Martín Solá ()

Threshold Models

08/10

27 / 46

Stability

It is straightforward to verify that

∂S (Yt
(cid:0)
∂Yt

1, Xe )
1

(cid:0)

µ1 (cid:0)

µ2 +

+

(cid:16)

where

= α

(2)
1 +

α

f

α

(2)
1 g

G (Yt

(cid:0)

1, Xe )

(1)
1 (cid:0)
(2)
1 g

Yt

α

(1)
1 (cid:0)

f

α

1 +

(cid:0)

δ

(1)
1 (cid:0)

δ

(2)
1 g

f

Xe

(cid:17)

∂G (Yt
(cid:0)
∂Yt

1, Xe )
1

(cid:0)

,

∂G (Yt
(cid:0)
∂Yt

1, Xe )
1

(cid:0)

=

(cid:0)

1
1 α
σ(cid:0)

(1)
1 f1(w1)[1

F2(w2)] + σ(cid:0)

1
2 α
F2(w2)

2

g

(cid:0)

(cid:0)

F1(w1) + 1

f

(2)
1 f2(w2)F1(w1)

,

(23)

) is the density of Fi (

) (i = 1, 2), and

fi (

(cid:1)

wi = σ(cid:0)
i

1

y (cid:3)

(cid:0)

(cid:16)

(i )
1 Yt

α

1 +

(cid:0)

δ

f

(cid:0)

δ

(i )
1 g

Xe

,

(cid:17)

i = 1, 2.

(cid:1)
µi (cid:0)

Martín Solá ()

Threshold Models

08/10

28 / 46

A numerical illustration
Consider a SDC-STARX(1) model where uit (i = 1, 2) have the Student-t
distribution with νi degrees of freedom. Assume that
autoregressive model

is the

xt

f

g

xt = 0.2 + 0.9xt

1 + εt ,

(cid:0)

where
,
having the standardized Student-t distribution with 5 degrees of freedom.

are i.i.d. random variables, independent of

and

u1t

u2t

εt

f

g

g

g

f

f

The parameters of the model take the following values:

µ1 =

0.5,
(cid:0)
σ1 = 3,

δ = 0, 0.3,

(2)
1 = 0.9, 0.99,

α

µ2 = 0.5,
σ2 = 2, ν1 = 3,
(1)
1 = 0, 0.1,

(1)
1 = 0.9, α
ν2 = 4,
(2)
1 = 0,

δ

δ

y (cid:3) = 0,

0.1.

(cid:0)

For each parameter con…guration, we use a grid of starting values to solve
equation (20) numerically and …nd the equilibrium points; the local stability
of each equilibrium point is then examined by considering the expansion in
(21)–(23).

Martín Solá ()

Threshold Models

08/10

29 / 46

Stability

Martín Solá ()

Threshold Models

08/10

30 / 46

Stability

Martín Solá ()

Threshold Models

08/10

31 / 46

Estimation for the SDC-STAR model

Given u1t and u2t , the parameters can be estimated by the ML method.
Letting θ denote the vector of all the unknown parameters, the conditional
log-likelihood function associated with a sample (y1, . . . , yT ) from the is

(θ) =

L

T
∑
t =p+1

ln `t (θ),

where

`t (θ) =

α01yt

1

(cid:0)

(24)

µ1 (cid:0)
σ1

G (zt
(cid:0)
σ1
1

+

(cid:0)

1)

f1

yt

(cid:0)

(cid:18)
1)

(cid:0)

f2

G (zt
σ2

yt

(cid:0)

µ2 (cid:0)
σ2

(cid:18)

(cid:19)
α02yt

1

(cid:0)

,

(cid:19)

with G (zt
density function of uit (i = 1, 2).

1) given by (14) and fi (

(cid:0)

) denoting, as before, the probability

(cid:1)

Martín Solá ()

Threshold Models

08/10

32 / 46

Estimation for the SDC-STARX

Under this model, the contribution of the t-th observation to the conditional
likelihood is

`t (θ) =

G (zt
(cid:0)
σ1
1

+

(cid:0)

1)

f1

yt

(cid:0)

(cid:18)
1)

(cid:0)

f2

G (zt
σ2

β01zt

1

(cid:0)

µ1 (cid:0)
σ1

yt

(cid:0)

µ2 (cid:0)
σ2

(cid:18)

(cid:19)
β02zt

1

(cid:0)

,

(cid:19)

1) given by (17).

with G (zt
In the remainder of the paper, we use the standardized Student-t distribution
with νi > 2 degrees of freedom, i.e.,

(cid:0)

fi (z) =

Γ (
f
Γ(νi /2)

νi + 1

/2)
g
(νi (cid:0)

2)π (cid:18)

1 +

z 2
νi (cid:0)

2

(cid:19)

(νi +1)/2

(cid:0)

,

∞ < z < ∞,

(cid:0)

p

) is the gamma function. This speci…cation has greater ‡exibility to

where Γ(
accommodate possible outliers and other heavy-tailed characteristics in the
data.

(cid:1)

Martín Solá ()

Threshold Models

08/10

33 / 46

An Empirical Application

We investigate whether the dynamics of U.S. short-term interests can be
adequately described using C-STAR model with constant threshold or
whether they are better represented by the SDC-STAR and SDC-STARX
models with a threshold which is determined by in‡ation and output growth.

Our data set consists of quarterly observations from 1947:2 to 2008:4 on the
secondary market rate on three-month U.S. Treasury bills (yt ), the growth
rate of real gross domestic product (gt ), and the consumer price in‡ation
rate (πt ).

Martín Solá ()

Threshold Models

08/10

34 / 46

Estimation Results

We …rst investigate the presence of nonlinearities in the dynamics of the
interest rate. Speci…cally, using the modi…ed Hansen LR-based method, we
test a linear AR(4) model for the interest rate against C-STAR(4) alternative.
The results of the tests show that the standardized LR statistic has, for all
choices of the bandwidth parameter M, a P-value smaller than 0.05 (0.10)
for the C-STAR(4) model. In view of the fact that the test is conservative by
construction, these results provide signi…cant evidence in favour of the
nonlinear models.
The state-dependent threshold y (cid:3)t
(cid:0)
xt

1 is speci…ed as in (13) with

1 = (gt

1, πt

1)0.

(cid:0)

(cid:0)

(cid:0)

Martín Solá ()

Threshold Models

08/10

35 / 46

Martín Solá ()

Threshold Models

08/10

36 / 46

Martín Solá ()

Threshold Models

08/10

37 / 46

The Ljung–Box statistic based on standardized residuals (Qr ) with r = 30
lags; the Ljung–Box statistic based on squared standardized residuals (Q2
r );
the maximized log-likelihood (
the Bayesian information criterion (BIC).

max); the Akaike information criterion (AIC);

L

Since the asymptotic distribution of residual autocorrelations from nonlinear
models such as those considered here is not generally the same as that
obtained under linearity (see, e.g., Li, 1992; Hwang et al., 1994), the
P-values of Qr and Q2
their null sampling distributions instead of the usual chi-squared asymptotic
approximation.

r are computed from a bootstrap approximation to

Martín Solá ()

Threshold Models

08/10

38 / 46

Table 4 reports the ML estimation results for C-STAR(4), SDC-STAR(4),
RC-STARX(4), C-STARX(4) and SDC-STARX(4) models (under the
assumption of Student-t conditional distributions).

For the SDC-STAR and the SDC-STARX models, the coe¢ cients on output
growth (δ1) and in‡ation (δ2) in the equation which determines the
state-dependent threshold are both signi…cantly di¤erent from zero. The
results suggest that, for both models, the interest rate threshold values are
such that regime 1 is favoured the lower output growth is and the
higher in‡ation is, while regime 2 is favoured for high values of output
growth and low values of in‡ation.
This is because high values of in‡ation (and low values of output growth)
result in small values for the threshold, which makes it more likely that the
interest rate would exceed the threshold value. Figure 6, shows that the
SDC-STAR gives weights close to unity in several periods which can be
mostly associated with economic recessions. We …nd that the C-STAR is a
not a valid restriction of the SDC-STAR. The AIC and BIC also favour the
SDC-STAR model over the C-STAR.

Martín Solá ()

Threshold Models

08/10

39 / 46

Martín Solá ()

Threshold Models

08/10

40 / 46

Martín Solá ()

Threshold Models

08/10

41 / 46

The stability of the empirical SDC-STAR(4) is assessed by using numerical
simulation. The skeleton of the model is found to have a single stable …xed
point Ye = 2.2129. The values of the skeleton are plotted in the top left
panel of Figure 7, along with arti…cial data obtained by using the …tted
model as the DGP.

We note that the simulated data appear to replicate the qualitative features
of the observed data – there is a fairly long period during which the series
diverges from its long-run value, which takes the series above the threshold.
The top right panel in Figure 7 shows the values of the mixing function G (
evaluated under the skeleton of the SDC-STAR(4) and C-STAR(4) models,
while the bottom left panel shows the evolution of the state-dependent
threshold and its convergence to its long-run value 7.591. Finally, the bottom
right panel shows the evolution of the mixing functions for the simulated
data, which reveals substantial di¤erences between the absolute and relative
(to the exogenous variable) mixing functions.

)

(cid:1)

Martín Solá ()

Threshold Models

08/10

42 / 46

Within the class of SD-CSTARX models, there are several testable
hypotheses of interest. We …nd that the C-STARX speci…cation is not a valid
reduction of the SD-CSTARX model since the LR statistic for δ1 = δ2 = 0
has a value of 20.818, leading to a rejection of the hypothesis of a constant
threshold at the 1% signi…cance level.

δ

(2)
1 = δ

The RSDC-STARX speci…cation is not a valid simpli…cation either since the
(2)
(1)
2 = δ = 0 is 20.814. When the
LR statistic for δ
δ
2 (cid:0)
SD-CSTAR is tested against the SD-CSTARX, the LR statistic for
(1)
1 = δ
δ
in which output growth and in‡ation are allowed to in‡uence the
regime-speci…c variables directly enjoys more support by the data.

(2)
2 = 0 has a value of 24.368, implying that the model

(1)
1 (cid:0)
(1)
2 = δ

(2)
1 = δ

The SDC-STARX model is favoured by the AIC, while the SDC-STAR is
favoured by the BIC. Overall, there is signi…cant evidence in favour of
speci…cations with a state-dependent threshold.

The stability of the empirical SDC-STARX(4) is assessed in a similar way,
with the corresponding plots shown in Figure 11. We …nd a single stable …xed
point Ye = 5.50 with a long-run value of 5.57 for the threshold.

Martín Solá ()

Threshold Models

08/10

43 / 46

Martín Solá ()

Threshold Models

08/10

44 / 46

Martín Solá ()

Threshold Models

08/10

45 / 46

Summary

In summary, the results presented in this section suggest that models with
state-dependent thresholds, i.e., SDC-STAR and SDC-STARX models, are
capable of characterizing the data successfully. In our application at least,
what seems to matter is not so much the absolute value of the threshold but
rather its level relative to other variables that dictate the evolution of the
economy as a whole.

We believe that, for economic variables such as those considered in this
paper, a relative threshold with respect to other variables that dictate the
evolution of the economy is of more importance for the dynamics of the
variables under consideration than a …xed threshold. Furthermore, since
constant-threshold speci…cations are special cases of state-dependent
speci…cations, it seems reasonable to use state-dependent speci…cations as a
…rst step in a modelling cycle.

Martín Solá ()

Threshold Models

08/10

46 / 46

Switching Regime Estimation

Series de TIempo

UTDT

January 2020

Martin Sola (FE)

Markov Switching models

01/11

1 / 71

The economy (the time series) often behaves very di¤erently in periods such
as booms and recessions. Markov Switching models are a useful way of
characterizing this phenomena.

Uses of Markov Switching Models:

Estimating models which are state dependent.

Use the structure of the model to assess the probability that a state takes
place, say a boom.

Incorporate this feature in Rational Expectations models, pricing, derivatives,
etc.

STRUCTURE OF THE LECTURE

De…nition and Properties.

Estimation and testing

Multivariate extensions and a R.E. example

Martin Sola (FE)

Markov Switching models

01/11

2 / 71

Introduction

Underlying assumption in all econometric models is that all observations have
been drawn from the same distribution conditional on some constant
parameter set

The standard approach consists of trying to detect the existence of the
regime changes and then imposing dummies.

Models with too many dummies

Martin Sola (FE)

Markov Switching models

01/11

3 / 71

How should we model a change in the process?

Suppose that the series under scrutiny has a break in its unconditional mean
at time t1. For data prior to t1 we might use:

yt

(cid:0)

µ0 = φ(yt

1

(cid:0)

(cid:0)

µ0) + εt

for t1 < t

and for data after t1

yt

(cid:0)

µ1 = φ(yt

1

(cid:0)

(cid:0)

µ1) + εt

for t

t1

(cid:21)

Even if this captures the break, it is not a satisfactory model:

A complete time series model would include a description of the probability
law governing the change from µ0 to µ1.

Martin Sola (FE)

Markov Switching models

01/11

4 / 71

We might consider the process to be in‡uenced by an unobserved random
variable xt

xt is the state or regime

In the example above, we could regard xt as:

xt =

(cid:26)

0 if the process has mean µ0
1 if the process has mean µ1

Thus, we could write

yt

µxt

= φ1(yt

1

µxt

) + εt

(cid:0)
xt )µ0 + xt µ1
where µxt
Process for the unobserved variable: Markov chain

= (1

(cid:0)

(cid:0)

(cid:0)

(cid:0)

1

Martin Sola (FE)

Markov Switching models

01/11

5 / 71

Properties of the Markov Process

De…nition
Let xt be a random variable that can take values 0 and 1. If the probability that
xt takes a particular value at time t, only depends on its value at t
variable is governed by a Markov process of order 1.

1, this

(cid:0)

P((xt = i

xt

1 = j, xt

2 = k...) = P((xt = i

(cid:0)
Thus the process is summarized by the probabilities:

(cid:0)

j

1 = j)

xt

j

(cid:0)

P(xt = 0

xt

j

(cid:0)

1 = 0) = q , P(xt = 1

1 = 1) = p.

xt

j

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

6 / 71

The transition Matrix

0
q
(1

q)

(cid:0)

1
(1
p

p)

(cid:0)

0
1
(time t)

(time t-1)

Martin Sola (FE)

Markov Switching models

01/11

7 / 71

Autoregressive Representation of Markov Process

1

xt +1

(cid:0)
xt +1

=

(cid:21)

(cid:20)

q

(cid:0)

(1

q)

(cid:20)

p)

(1

(cid:0)
p

xt

1

(cid:0)
xt

+

(cid:21)

(cid:20)

ζ1,t +1
ζ2,t +1 (cid:21)

(cid:21) (cid:20)

The second row gives

xt +1 = (1

q) + (

1 + p + q)xt + ζ2,t +1

(cid:0)
This expression can be recognized as an AR(1) process with constant term
1

q and autoregressive coe¢ cient (

1 + p + q)

(cid:0)

(cid:0)

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

8 / 71

Expected value of xt :

E (xt +1) = (1

q) + (

(cid:0)

(cid:0)

1 + p + q)E (xt )

or

E (xt ) =

2

1

q

(cid:0)
p

(cid:0)

(cid:0)

q

since E (xt +1) = E (xt ) for a stationary process.

Martin Sola (FE)

Markov Switching models

01/11

9 / 71

Unconditional probabilities of being in state 1 and 0.
1

Notice that E (xt ) = 0P(xt = 0) + 1P(xt = 1) =

(cid:0)
p

q

(cid:0)

.

q

2

(cid:0)

Then,

P(xt = 1) =

P(xt = 0) =

1

(cid:0)
1

(cid:0)

(cid:0)
p

(cid:0)
p

q

(cid:0)
p

(cid:0)

2

2

,

.

q

q

Martin Sola (FE)

Markov Switching models

01/11

10 / 71

Conditional and Unconditional Probabilities of States 0
and 1
An alternative derivation

It can be shown that the unconditional probabilities at time zero multiplied
by the matrix of transition probabilities are equal to the unconditional
probabilities at time one:

P(x1 = 0)
P(x1 = 1)

=

(cid:21)

(cid:20)

q

(cid:0)

(1

q)

(cid:20)

p)

(1

(cid:0)
p

P(x0 = 0)
P(x0 = 1)

(cid:21)

(cid:21) (cid:20)

Martin Sola (FE)

Markov Switching models

01/11

11 / 71

Equilibrium Probabilities

If the process is stationary, there exist state probabilities
satisfy:

Π = PΠ

π0, π1

f

g

that

where P is the matrix of transition probabilities.

π0
π1

=

q

(1

q)

(cid:21)

(cid:20)
(cid:20)
j = 0) and π1 = P(xt

(cid:0)

(cid:0)

p)

(1

(cid:0)
p

π0
π1

(cid:21)

(cid:21) (cid:20)

j = 1) for all values of j.

(cid:0)

where π0 = P(xt

Martin Sola (FE)

Markov Switching models

01/11

12 / 71

Using π0 + π1 = 1:

π0 =

(1

p)

(2

(cid:0)
p

q)

and π1 =

(1

q)

(2

(cid:0)
p

q)

(cid:0)
where π0 and π1 are the equilibrium unconditional probabilities.

(cid:0)

(cid:0)

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

13 / 71

Given the following initial values:

p0(0)
p0(1)

(cid:20)

=

(cid:21)

(cid:20)

π0
π1

(cid:21)

It can be shown (by multiplying n times by the transition probability matrix)
that the unconditional probability vector at time n is:

pn(0)
pn(1)

(cid:20)

=

(cid:21)

(cid:20)

π0
π1

(cid:21)

Therefore, the distribution does not change with time and the stochastic
process is always in equilibrium.

Martin Sola (FE)

Markov Switching models

01/11

14 / 71

Forecasts for a Markov Chain

A n- period ahead forecast for a Markov chain can be obtained simply by
multiplying n times by the transition probability:

P(xt +n = 0)
P(xt +n = 1)

=

(cid:21)

(cid:20)

q

(cid:0)

(1

q)

(1

(cid:0)
p

(cid:20)

n

p)

(cid:21)

(cid:20)

P(xt = 0)
P(xt = 1)

(cid:21)

Martin Sola (FE)

Markov Switching models

01/11

15 / 71

Pn is derived in the following way:

1) Find the eigenvalues of the transition probability Matrix.

2) Find the associated eigenvectors.

λ1 = 1, λ2 =

1 + p + q,

(cid:0)

(1

p)

(cid:0)
(1

(cid:0)
q)

(cid:0)
p

(cid:0)
p

q)

q)

(2

(2

(cid:0)

(cid:0)

2

4

1
(cid:0)
1

(cid:21)

,

(cid:20)

3

5

Martin Sola (FE)

Markov Switching models

01/11

16 / 71

3) Express P as T ΛT (cid:0)

1, where

(1

T =

2

p)
q) (cid:0)
(cid:0)
q)
q)

(cid:0)
p

(cid:0)
p

(cid:0)
(1

(2

(2

1

1 3

(cid:0)
is the matrix of eigenvectors and

4

(cid:0)

Λ =

1
0

(cid:20)

(cid:0)

0
1 + p + q

a diagonal matrix of eigenvalues.

5

(cid:21)

Martin Sola (FE)

Markov Switching models

01/11

17 / 71

4) Use the result that

Pn = T ΛnT (cid:0)

1

or

1

P n =

(2

2

"

(cid:0)
p

(cid:0)
p

p

(cid:0)
q

(cid:0)

(cid:0)
1

(cid:0)

q) (cid:0)
q

1
1 # (cid:20)

1
0

0
1 + p + q

(cid:0)

n

"

(cid:21)

(2

2

1

(cid:0)

q) (cid:0)
q

1
1 #

1

p

(cid:0)
p

(cid:0)
p

(cid:0)
1

(cid:0)

(cid:0)
q

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

18 / 71

0

(1

(cid:0)
p

(cid:0)
p

(2

(2

(cid:0)
(1

(cid:0)

p)

q) + (1

(cid:0)
q)
q) (cid:0)

(cid:0)

(1

1)n

1)n

(cid:0)

(cid:0)

q)(p+q
(2
p
(cid:0)
(cid:0)
q)(p+q
p
(2

(cid:0)

(cid:0)

(cid:0)
q)

(cid:0)
q)

0

1
( t+n)

1

(1

(cid:0)
(1

(2

(2

(1

p)
q) (cid:0)
(cid:0)
q) + (1
q)

(cid:0)
p

(cid:0)
p

(cid:0)

(cid:0)

( t)

1)n

1)n

(cid:0)

(cid:0)

p)(p+q
(2
p
(cid:0)
(cid:0)
p)(p+q
p
(2

(cid:0)

(cid:0)

(cid:0)
q)

(cid:0)
q)

Note that by making n = 1 in the above matrix we end with the matrix of
transition probabilities, P.

Martin Sola (FE)

Markov Switching models

01/11

19 / 71

In addition, we can derive the conditional expectations:

E (xt +n

E (xt +n

j

j

xt = 0) =

xt = 1) =

(1

(2

(cid:0)
(1

(2

(cid:0)

(cid:0)
p

(cid:0)
p

q)

(cid:0)
q)

q)

(cid:0)

q) (cid:0)

+

(1

(1

(cid:0)

(cid:0)

q)(p + q
(2
p
(cid:0)
p)(p + q
(2
p

(cid:0)

(cid:0)

(cid:0)

(cid:0)
q)

(cid:0)
q)

1)n

1)n

Martin Sola (FE)

Markov Switching models

01/11

20 / 71

The expected value of xt at time n conditional on s at time zero is:

E (xt +n

j

xt = xt ) =

(1

(2

(cid:0)

(cid:0)
p

q)

q)

(cid:0)

+ (xt

(1

(cid:0)

(2

(cid:0)

(cid:0)
p

q)

q)

(cid:0)

)(p + q

1)n

(cid:0)

This result is derived assuming that xt is observed (conditional on xt )

Martin Sola (FE)

Markov Switching models

01/11

21 / 71

A brief description of Hamilton’s non linear …lter

The procedure assumes that discrete states of the economy are not known:
inferred from the data.

States follow a discrete Markov process.

Martin Sola (FE)

Markov Switching models

01/11

22 / 71

A brief description of Hamilton’s non linear …lter

The observed variable, yt , is assumed to follow an AR(m):

yt

(cid:0)

µxt

= φ1(yt

1

(cid:0)

(cid:0)

µxt

) + .. + φm (yt

m

µxt

) + σxt εt

1

(cid:0)
(cid:0)
is parameterized as α0 + α1xt and σxt as

(cid:0)

(cid:0)

m

εt is distributed N(0,1) and µxt
w0 + w1xt
The error εt is assumed to be independent of all xt

0

j (cid:21)

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

23 / 71

Hamilton’s Filter
Step 1

Step 1 Calculate the joint density of the m past states and the current

state conditional on the information included in yt
(cid:0)
values of y , where y is the variable that is observed:

1 and all past

p(xt , xt

1, , ..., xt

m

(cid:0)

yt

j

(cid:0)

(cid:0)

1, .., y0) = p(xt

1)p(xt

xt

j

(cid:0)

(cid:0)

1, , ..., xt

m

(cid:0)

yt

j

(cid:0)

1, ..., y0)

Martin Sola (FE)

Markov Switching models

01/11

24 / 71

Hamilton’s Filter
Step 1

Step 1

As in all the subsequent steps the second term on the right-hand-side is obtained
from the preceding step of the …lter. In this case,
p(xt
yt
which in turn represents the result of the iteration at date t

2, ..., y0) is known from the input to the …lter,
1 (from step 5).

2, ..., xt

1, yt

1, xt

m

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

j

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

25 / 71

Hamilton’s Filter
Step 1

Step 1

To begin with the iteration, it is necessary to assign some initial values to the
parameters, and to impose some initial conditions on the Markov process. The
unconditional distribution p(xm
observation:

2, ...x0) has been chosen for the …rst

1, xm

(cid:0)

(cid:0)

p(xm

1, xm

(cid:0)

(cid:0)

2, ...x0) = p(xm

xm

1

j

(cid:0)

(cid:0)

2)...p(x1

j

x0)p(x0)

where p(x0) are the equilibrium unconditional probabilities as de…ned above.

Martin Sola (FE)

Markov Switching models

01/11

26 / 71

Hamilton’s Filter
Step 2

Step 2

Calculate the joint conditional distribution of yt and (xt , xt

1, ..., xt

m ).

(cid:0)

(cid:0)

p(yt , xt , xt

1, ..., xt

m

p(yt
p(xt , xt

j

(cid:0)
xt , xt

(cid:0)
1, ..., xt

(cid:0)
1, xt

(cid:0)
2, ..., xt

(cid:0)

(cid:0)

yt
j
(cid:0)
m , yt
m

(cid:0)

1, yt

(cid:0)
1, yt
(cid:0)
yt
j

(cid:0)

2, ..., y0)

2, ..., y0)

(cid:2)
2, ..., y0)

(cid:0)
1, yt

(cid:0)

=

Martin Sola (FE)

Markov Switching models

01/11

27 / 71

Hamilton’s Filter
Step 2

We assume that

=

j

(cid:0)

p(yt

1, ., xt

xt , xt
1
p2π(ω0 + ω1xt )
α1xt

φ1(yt

1

(cid:0)

(cid:0)

(cid:0)

m , yt

(cid:0)

(cid:0)

exp[

(cid:0)

α0)

1

(cid:0)

(cid:0)

(cid:0)

2, ., y0)
1, yt
1
2[ω0 + ω1xt ]2 ((yt
φm (yt

..

m

(cid:0)

(cid:0)

(cid:0)

(cid:0)

α1xt

α0)

(cid:0)

(cid:0)

α1xt

m

(cid:0)

(cid:0)

α0))2]

Martin Sola (FE)

Markov Switching models

01/11

28 / 71

Hamilton’s Filter
Step 3

Step 3

Marginalize the previous joint density with respect to the states giving the
conditional density, from which the (conditional) likelihood function is calculated.

p(yt
1
∑
xt =0

=

yt

j

1, yt

(cid:0)

(cid:0)
1
∑
1=0

..

2, ., y0)
1
∑
m =0

xt

(cid:0)

xt

(cid:0)

p(yt , xt , xt

1, ., xt

m

(cid:0)

yt

j

(cid:0)

1, yt

(cid:0)

(cid:0)

2, ., y0)

Martin Sola (FE)

Markov Switching models

01/11

29 / 71

Hamilton’s Filter
Step 4

Step 4

Combine the results from steps 2 and 3 to calculate the joint density of the state
conditional on the observed current and past realizations of y

1, ., xt

p(xt , xt
p(yt , xt , xt

(cid:0)

j

m
(cid:0)
1, ., xt
yt

yt , yt
1, yt
1, yt
yt
(cid:0)
(cid:0)
2, ., y0)

m
(cid:0)
1, yt

(cid:0)

(cid:0)

j
(cid:0)

j

(cid:0)

(cid:0)
p(yt

2, ., y0)
2, ., y0)

=

Martin Sola (FE)

Markov Switching models

01/11

30 / 71

Hamilton’s Filter
Step 5

Step 5

The desired output is then obtained from

p(xt , ., xt

m+1

j

(cid:0)

yt , yt

(cid:0)

1.., y0) =

1
∑
m =0

(cid:0)

xt

p(xt , ., xt

yt , ., y0)

m

j

(cid:0)

The output of step 5 is used as an input to the …lter in the next iteration.

Martin Sola (FE)

Markov Switching models

01/11

31 / 71

Hamilton’s Filter
Step 5

Note that to iterate, estimates of the parameters are required.

Maximum likelihood estimates can be obtained numerically from Step 3 as a
by-product of the …lter

ln p(yt , yt

1, yt

(cid:0)

(cid:0)

2, ., ym

ym

j

(cid:0)

1, ., y0) =

T
∑
t =m

ln p(yt

yt

j

(cid:0)

1, ., y0).

which can be maximized numerically with respect to the unknown parameters
(α1, α0, p, q, ω0, ω1, φ1, φ2...φm ).

Martin Sola (FE)

Markov Switching models

01/11

32 / 71

Comments

Notice that p and q, the parameters of the transition matrix, are also
estimated by maximum likelihood.

Hamilton’s …lter requires the numerical optimization of a very complicated
non-linear function.

Martin Sola (FE)

Markov Switching models

01/11

33 / 71

Speci…cation Tests

Speci…cation tests based on the properties of the standardized residuals,
εt = yt
(cid:0)
First calculate the
b

of yt given information at time t

\E (yt
It
j
(cid:0)
σt

1:

1)

.

E (yt

It

j

(cid:0)

b
1) = α0 + α1E (xt
j
+... + φm (yt

It

1) + φ1(yt
α1E (xt

1

(cid:0)
m

(cid:0)
m

(cid:0)

(cid:0)

(cid:0)

(cid:0)
α1E (xt
1)

(cid:0)

(cid:0)
It
j

(cid:0)

1
j
(cid:0)
α0),

It

1)

(cid:0)

(cid:0)

α0)

where

E (xt

It

j

(cid:0)

E (xt

m

(cid:0)

It

(1

q)

1) =

(2

(cid:0)
1) = P(xt

(cid:0)
q)
p
(cid:0)
m = 1

+ (P(xt

(cid:0)
1), m

It

j

It

1

j

(cid:0)
1.

(cid:21)

1)

(1

(cid:0)

(2

(cid:0)

(cid:0)
p

q)

q)

(cid:0)

)(p + q

1),

(cid:0)

P(xt

j
It

m

j

(cid:0)

(cid:0)
1), for m > 1, are called ”smoothing probabilities”

(cid:0)

(cid:0)
They can be calculated from the ”…ltering probabilities”.

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

34 / 71

Computing the standard deviation

Step 1 First make use of the autoregressive representation of the Markov

process

xt = (1

q) + (

1 + p + q)xt

(cid:0)
For this process the error, conditional on xt
characterized as

(cid:0)

(cid:0)

1 + ζ2,t
(cid:0)
1 = 1, can be

and conditional on xt

(cid:0)
ζ2,t =

ζ2,t = (1

p) with probability p
p

(cid:0)
p with probability 1

(cid:0)

(cid:0)
1 = 0

(1

q) with probability q

(cid:0)
q with probability 1

(cid:0)

q

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

35 / 71

Computing the standard deviation

Step 2 Calculate the variance of the error term, ζ2,t , conditional on the

state at t

1.

(cid:0)
xt

xt

E (ζ2
E (ζ2

2,t j
2,t j

1 = 1) = (1
1 = 0) = (1

(cid:0)

(cid:0)

(cid:0)

(cid:0)

p)2p + p2(1
q)2q + q2(1

p) = p(1

q) = q(1

p)

q)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

36 / 71

Computing the standard deviation

Step 3 Calculate the conditional variance (conditional on
)

It
We start by calculating the state dependent variance σ2
function of the Markov switching parameters.

1, ...y0

1 =

yt

f

g

(cid:0)

(cid:0)

xt as a

Martin Sola (FE)

Markov Switching models

01/11

37 / 71

Computing the standard deviation

Step 3 Conditional on xt

1 = 1, the switching variance can be written as:

(cid:0)
xt = E (σ2
σ2
xt j

xt

1 = 1) + V (µxt j

xt

(cid:0)

(cid:0)

1 = 1)

where

xt

E (σ2
xt j
(since σxt

1 = 1) = (E (σxt jj
(cid:0)
is a random variable) and

xt

(cid:0)

1 = 1))2 + Var ((σxt j

1 = 1))

xt

(cid:0)

Var ((σxt j

xt

(cid:0)

1 = 1)) = E (σ2
xt j

xt

(cid:0)

1 = 1)

(E (σxt j

xt

(cid:0)

(cid:0)

1 = 1))2

Martin Sola (FE)

Markov Switching models

01/11

38 / 71

Computing the standard deviation

Step 3 Then using that

(E (σxt j

xt

(cid:0)

1 = 1))2 = (w0 + w1E (xt

1 = 1)2 = (w0 + w1p)2

xt

j

(cid:0)

Var ((σxt j

xt

(cid:0)

1 = 1)) = Var (w0 + w1xt

= w 2

1 p(1

p).

(cid:0)

1 = 1)

xt

j

(cid:0)

V (µxt j

xt

(cid:0)

1 = 1) = Var (α0 + α1xt

= α2

1p(1

p)

(cid:0)

1 = 1)

xt

j

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

39 / 71

Computing the standard deviation

Step 3 Collecting all these terms we can see that

xt = (w0 + w1p)2 + w 2
σ2

1 p(1

p) + α2

1p(1

p)

(cid:0)

(cid:0)

We can obtain a similar formulae for the variance conditional on
xt

1 = 0.

(cid:0)

(cid:0)
and doing the same transformations for state 0 we obtain

(cid:0)

1 = 0) + V (µxt j

xt

1 = 0)

xt = E (σ2
σ2
xt j

xt

σ2
xt = (w0 + w1(1

q))2 + w 2

1 q(1

q) + α2

1q(1

q).

(cid:0)

(cid:0)

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

40 / 71

Computing the standard deviation

Step 3 Clearly the state is not observed at time t

1 but we can use the
…ltered probabilities to make an inference of the unobserved state.

(cid:0)

Then the conditional variance (on information on time t

σ2
t =

((w0 + w1p)2 + w 2
+α2
1p(1
(cid:0)
((w0 + w1(1
α2
1q(1

(cid:0)
q))2 + w 2
P(xt

p))P(xt

(cid:0)
q))(1

1 p(1
1 = 1

(cid:0)
It
j
1 q(1
1 = 1

(cid:0)

(cid:0)

(cid:0)

p)
1)+
q)+
1))

(cid:0)
(cid:0)
It
j

(cid:0)

1) is

(cid:0)

.

Martin Sola (FE)

Markov Switching models

01/11

41 / 71

Computing the standard deviation

Step 3 Then the standardized residuals are simply, vt = εt /σt and we may

conduct standard speci…cation tests for these residuals.

Martin Sola (FE)

Markov Switching models

01/11

42 / 71

Number of tests and speci…cation tests

Crucial: rightly identify the number of states or regimes.

Hamilton proposes to use simple speci…cation tests as a mean of assessing
whether the estimated equation contains the right number of states.

Martin Sola (FE)

Markov Switching models

01/11

43 / 71

A Bivariate model with regime switching

We consider a VAR process in two variables, with 1 lag, with the feature that
the means of each equation and the variance-covariance matrix are allowed to
switch endogenously between two possible states.

The two equations that de…ne the VAR are in‡uenced by the same state
variable.

The state is not observed and has to be inferred from a …lter.

S 0t = ΦS 0t

1 + ψD 0t

(cid:0)

(cid:0)

1 + (ω0 + ω1xt )νt

D 0t = ϕS 0t

1 + ΩD 0t

(cid:0)

(cid:0)

1 + (τ0 + τ1xt )εt

Martin Sola (FE)

Markov Switching models

01/11

44 / 71

A Bivariate model with regime switching

The centered variables are de…ned by the two following equations:

S 0t = St

D 0t = Dt

α0

(cid:0)
β0 (cid:0)

(cid:0)

(cid:0)

α1xt

β1xt

A prime (’) is used to denote centred variables in the remainder of the
presentation
xt denotes the unobserved state of the system and takes values 0 and 1.

Martin Sola (FE)

Markov Switching models

01/11

45 / 71

A Bivariate model with regime switching

xt is governed by a Markov process

P(xt = 0
P(xt = 1

1 = 0) = q
1 = 1) = p

xt
xt

j
j

(cid:0)

(cid:0)

The errors νt , εt are assumed to be independent of all xt

j .

j

(cid:0)

(cid:21)

0.

Martin Sola (FE)

Markov Switching models

01/11

46 / 71

A Bivariate model with regime switching

Substituting the centered variables into the VAR and rearranging terms, we obtain
the following expression for St and Dt

St = α0(1

(cid:0)
+α1(xt

Φ)

(cid:0)

β0ψ + ΦSt

1 + ψDt

(cid:0)
Φxt

1)

(cid:0)

(cid:0)

(cid:0)
β1ψxt

(cid:0)

1

(cid:0)

1 + (ω0 + ω1xt )νt

Dt =

(cid:0)
(cid:0)

α0 ϕ + β0(1
α1 ϕxt

1 + β1(xt

(cid:0)

Ω) + ϕSt
Ωxt

1 + ΩDt
(cid:0)
(cid:0)
1) + (τ0 + τ1xt )εt

1

(cid:0)

(cid:0)

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

47 / 71

Testing The Term Structure of Interest Rates

The process that drives the spread and the short-term interest rate di¤erence
is the VAR of equation described above in which Dt denotes the …rst
di¤erence of the three month rate, R1t
spread R2t
The expectations hypothesis of the term structure of the interest rates can be
written as

1 and St denotes the yield

R1t .

R1t

(cid:0)

(cid:0)

(cid:0)

St = (1/2)Et Dt +1 + θ + ut

The restrictions imposed by the expectations model are presented below.
Both an unrestricted and a restricted VAR can be estimated, and the
restrictions tested using a likelihood ratio test.

Martin Sola (FE)

Markov Switching models

01/11

48 / 71

Derivation of the restrictions in the regime-shifting VAR.

S 0t
D 0t (cid:21)

=

(cid:20)

(cid:20)

Φ ψ
ϕ Ω

(cid:21) (cid:20)

S 0t
(cid:0)
D 0t

(cid:0)

1
1 (cid:21)

(ω0 + ω1xt )νt
(τ0 + τ1xt )εt

+

(cid:20)

To …nd the restrictions we condition on information available at t
sides of the term structure equation.

(cid:0)

(cid:21)
1 on both

E (St

I (cid:3)t
(cid:0)

j

1) = (1/2)E (Dt +1

1) + θ

I (cid:3)t
(cid:0)

j

were I (cid:3)t
(cid:0)

1 =

St

f

(cid:0)

1, St

(cid:0)

2, ., Dt

1, Dt

2, ., xt

1, .,

.

g

(cid:0)

(cid:0)

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

49 / 71

Then, we need to calculate expected values E [Dt +1
can be calculated in the following way:

I (cid:3)t
(cid:0)

j

1] and E [St

1]. These

I (cid:3)t
(cid:0)

j

E [Dt +1

I (cid:3)t
(cid:0)

j

1] = β0 + β1E (xt +1

I (cid:3)t
(cid:0)

1) + E (D 0t +1j

I (cid:3)t
(cid:0)

j

1),

where

1] = [0, 1] ∆2Z 0t
E [D 0t +1j
I (cid:3)t
(cid:0)
1) = [ρ + (xt
E (xt +1
I (cid:3)t
j
(cid:0)

(cid:0)

1

1,
ρ)λ2]

(cid:0)

(cid:0)

where ρ = 1
2
(cid:0)

(cid:0)
p

q

(cid:0)

where

q and λ = (p + q

1).

(cid:0)

E [St

I (cid:3)t
(cid:0)

j

1] = α0 + α1E (xt

I (cid:3)t
(cid:0)

1) + E (S 0t j

I (cid:3)t
(cid:0)

j

1)

E (S 0t j
E (xt
j

I (cid:3)t
(cid:0)
I (cid:3)t
(cid:0)

1

1) =
0
1) = [ρ + (xt
(cid:2)

(cid:3)
(cid:0)

∆Z 0t
1

(cid:0)

1
(cid:0)
ρ)λ]

Martin Sola (FE)

Markov Switching models

01/11

50 / 71

Finally, substituting the expected (di¤erence of the) short-term interest rates and
the expected spread, the term structure of interest rates relationship can be
expressed as;

α0 + α1[ρ + (xt
1
2

(cid:0)
[β0 + β1[ρ + (xt

1

=

ρ)λ] + [1, 0] ∆Z 0t

(cid:0)

(cid:0)

1

((A4))

1

(cid:0)

(cid:0)

ρ)λ2] + [0, 1] ∆2Z 0t

1] + θ

(cid:0)

The restrictions written out in full are:

α1 =

Φ =

ψ =

1
β1λ
2
ϕΩ
2
ϕ

(cid:0)
Ω2

ϕ

2

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

51 / 71

Contagion

De…ne:

zt = [xt , yt ]0
zt = µ + Φst ut

where µ = [µx , µy ]0 and ut is a Gaussian process
st
f
independent of

is modelled as a time-homogeneous Markov chain on

g

1, 2, 3, 4

,

g

f

ut

f

g

Thus,

(st = s)

zt

j

(cid:24)

N(µ, Ωst )

Martin Sola (FE)

Markov Switching models

01/11

52 / 71

Contagion

The variance covariance matrix are:

Ω =

(

Ωs =1 =

Ωs =3 =

σ2
σxh,yh
xh
σyh,xh σ2
yh

#

, Ωs =2 =

σ2
xl
σyh,xl

σxl ,yh
σ2
yh

#

, Ωs =4 =

σ2
σxh,yl
xh
σyl ,xh σ2
yl

#

σ2
xl
σyl ,xl

σxl ,yl
σ2
yl

#)

"

"

"

"

Martin Sola (FE)

Markov Switching models

01/11

53 / 71

Contagion

Transition matrix: 4
πij = Pr(st = i
st
No contagion amounts to:

(cid:0)

j

4 matrix Π (with elements

(cid:2)
1 = j), i, j = 1, 2, 3, 4)

Martin Sola (FE)

Markov Switching models

01/11

54 / 71

Contagion

Contagion will occur when one of the countries leads (or lags) the other one.
This hypothesis can be veri…ed testing (using LR tests distributed as χ2(10))
if we can reduce the transition matrices to Πxly

1 =

0

(1

πxh
0
πxh)
(cid:0)
0

πxh
0
πxh)
(cid:0)
0

(1

B
B
@
indicates x leads y one period

(1

0
πxl )
(cid:0)
0
πxl

(1

0
πxl )
(cid:0)
0
πxl

1

C
C
A

where Πxly
1

Martin Sola (FE)

Markov Switching models

01/11

55 / 71

Markov Switching Causality

The analysis of Granger causality between x1 and x2 is based on the following
Markov switching VAR model:

x1,t
x2,t

(cid:20)

(cid:21)

=

(cid:20)

+

µ10 + µ11s1,t
µ20 + µ21s2,t

(cid:21)
ϕ10 + ϕ11s1,t
ϕ20 + ϕ21s2,t

+

(cid:20)

φ10 + φ11s1,t
ψ2s2,t

ψ1s1,t
φ20 + φ21s2,t

x1,t
x2,t

1
1

(cid:0)

(cid:0)

(cid:21)

(cid:21) (cid:20)

zt

1 +

(cid:0)

u1,t
u2,t

,

t = 1, . . . , T .

(cid:20)
where s1,t s2,t (cid:101)
x2 Granger causes x1 when s1,t = 1 and is Granger non-causal for x1when
s1,t = 0

are unobserved random variables

0, 1

g

f

(cid:21)

(cid:21)

(cid:20)

Martin Sola (FE)

Markov Switching models

01/11

56 / 71

Target Zone Credibility

Dynamic of the nominal interest rate di¤erential

µ(st ) =

rt

(cid:0)

m
∑
j =1

φj [rt

j (cid:0)

(cid:0)

µ(st

(cid:0)

j )] + σ(st )εt ,

(t = 1, . . . , T )

where st (cid:101)

0, 1

f

g

is the state variable with

Pr(st = 1
Pr(st = 0
Pr(st = 0
Pr(st = 1

st
st
st
st

j
j
j
j

(cid:0)

(cid:0)

(cid:0)

(cid:0)

1 = 1) = p,
1 = 1) = 1
1 = 0) = q,
1 = 0) = 1

(cid:0)

(cid:0)

p,

q,

Martin Sola (FE)

Markov Switching models

01/11

57 / 71

Target Zone Credibility

µ(st ) = α0 + α1st ,

σ(st ) = σ0(1

st ) + σ1st .

(cid:0)

and

where α1

α0 > 0

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

58 / 71

Target Zone Credibility

To assess the links between target-zone credibility and macroeconomic
variables:

where zt is an economic variable that a¤ects the state transition probabilities.

Martin Sola (FE)

Markov Switching models

01/11

59 / 71

Target Zone Credibility

Sample log-likelihood function

log L =

T
∑
t =m+1

log f (rt

1)

t

jF

(cid:0)

Fi = (r1, z1, . . . , ri , zi ) (i > 1) and f (rt

where
conditional density of rt given the set of information that is available at date
t

1) represents the

jF

1

(cid:0)

t

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

60 / 71

Target Zone Credibility

Inferences about the unobserved regimes
the …lter probabilities Pr(st

st g
t ), obtained as:

f

may be made on the basis of

Pr(st

t ) =

jF

1
∑
1=0

(cid:0)

st

jF
1
∑
2=0 (cid:1) (cid:1) (cid:1)

st

(cid:0)

1
∑
m =0

(cid:0)

st

Pr(st , st

1, . . . , st

t ).

m

(cid:0)

jF

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

61 / 71

Intrinsic Bubbles and Regime Switching

Pt = e(cid:0)

r Et (Dt + Pt +1).

Any rational bubble Bt in the stock price satis…es

Bt = e(cid:0)

r Et (Bt +1).

The process that drives the log of dividends is assumed to be a random walk
with drift µ :

dt +1 = µ + dt + ξt +1,

where ξt +1 v N(0, σ2).
The “intrinsic bubble”:

B(Dt ) = cD λ
t .

Martin Sola (FE)

Markov Switching models

01/11

62 / 71

Intrinsic Bubbles and Regime Switching

The parameter λ is the positive root of the quadratic equation

σ2
2

λ2 + µλ

r = 0

(cid:0)

The present value (denoted by P pv

t ) is proportional to dividends:
P pv
t = kDt ,

where k = (er

e(µ+ 1

2 σ2))(cid:0)

1.

(cid:0)

Pt = kDt + cD λ
t .

Martin Sola (FE)

Markov Switching models

01/11

63 / 71

Intrinsic Bubbles and Regime Switching

Evolution of real dividends

dt +1 = dt + µ0(1

(cid:0)

st +1) + µ1st +1 + (σ0(1

(cid:0)

st +1) + σ1st +1)εt +1

where st +1 follow an homogenous …rst order Markov Process and εt +1 is an
iid variable
p(st = 1
1 = 1) = p and p(st = 0
st
The fundamental value of the stock is

1 = 0) = q.

st

(cid:0)

(cid:0)

j

j

Pt =

(cid:26)

k0Dt if st = 0
k1Dt if st = 1

Martin Sola (FE)

Markov Switching models

01/11

64 / 71

Then k0 and k1 satisfy

k0 = e(cid:0)
and
k1 = e(cid:0)

r (1 + qk0a0 + (1

r (1 + pk1a1 + (1

q)k1a1).

p)k0a0)

(cid:0)

(cid:0)

where a0 = e(µ0+ 1

2 σ2

0) and a1 = e(µ1+ 1

2 σ2

1).

Martin Sola (FE)

Markov Switching models

01/11

65 / 71

Intrinsic Bubbles and Regime Switching

Intrinsic Bubble:

It satis…es

Bt = ci D λ

t when st = i

Bt = e(cid:0)

r E (Bt +1

Ωt )

j

Putting everything together

where

and

Pst = P pv

st + Bst (Dt )

P pv
st = (k0(1

(cid:0)

st ) + k1st ))Dt ,

Bst (Dt ) = (c0(1

st ) + c1st ))D λ
t .

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

66 / 71

Instrumental Variables

Standard CAPM

u0(Ct ) = βEt [(1 + rt +1)u0(Ct +1)]

Et

Ft

St +1
(cid:0)
Pt +1 (cid:19)

u0(Ct +1)
u0(Ct )

(cid:21)

(cid:20)(cid:18)

= 0

When all the variables are jointly lognormally distributed, the equation may
be rewritten as

ft = Et [st +1] + 1

2 Vart [st +1] + Covt [Rt +1, st +1],

Martin Sola (FE)

Markov Switching models

01/11

67 / 71

Instrumental Variables

UFER Hypothesis

and

ft = Et [st +1]

st +1 = Et [st +1] + ηt +1

These equations are often expressed as

∆st +1 = α + β(ft

st ) + et +1

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

68 / 71

Instrumental Variables

Consumption

Ct = µxt

+

h
∑
j =1

ϕj ,xt

Ct

(cid:0)

j + σxt ζt ,

where
f
independent of

ζt g

is a white noise and

are regime-indicator variables

xt

f

g

f

ζt g
q = Pr[xt = 0

1 = 0],

xt

j

(cid:0)

p = Pr[xt = 1

1 = 1]

xt

j

(cid:0)

Martin Sola (FE)

Markov Switching models

01/11

69 / 71

Instrumental Variables

Conditional on xt = 0, the solution for the forward rate is

ft =

2 Vart [st +1] + qCovt [R (0)
Et [st +1] + 1
(1

q)Covt [R (1)

t +1, st +1]

t +1, st +1]+

(cid:0)

Conditional on xt = 1, the solution is

Et [st +1] + 1

ft =

2 Vart [st +1] + (1
+pCovt [R (1)

(cid:0)
t +1, st +1]

p)Covt [R (0)

t +1, st +1]

t = ln(u0(C (i )

where R (i )
C (i )
t +1 = µi + ∑h

j =1 ϕj ,i Ct +1

t +1)/Pt +1) and

j + σi ζt +1 for i

(cid:0)

0, 1

.

g

2 f

Martin Sola (FE)

Markov Switching models

01/11

70 / 71

Instrumental Variables

These equations yield:

ft = Et [st +1] + A(0)

t

(1

xt ) + A(1)

t xt ,

(cid:0)

with A(i )

t = (1/2)Vart [st +1] + Covt [R (i )

t +1, st +1] for i

0, 1

g

2 f

Martin Sola (FE)

Markov Switching models

01/11

71 / 71

Introduction to Bayesian Econometrics

May 2020

(Institute)

Markov Chain Monte Carlo

11/05

1 / 36

Introduction to Bayesian Econometrics

Consider the following regression Model

Y = X β + ε,

ε~N(0, σ2I )

Within the Bayesian framework the parameters θ =
variables. This parameters have probability distributions which re‡ect the
knowledge of the researcher, before observing the sample on Y and X , about the
parameters of the model.

are treated as random

f

g

β, σ2

This probability distribution, denoted as g (θ) is called a prior distribution.

Once Y is observed, the researcher revises the distribution of the parameters by
combining the prior distribution with the information obtained in the sample using
Bayes Theorem.

(Institute)

Markov Chain Monte Carlo

11/05

2 / 36

We will de…ne the following concepts:

θ) denotes the distribution of Y (from where we draw the data) given

j

f (Y
the parameters
h(θ, Y ) denotes the joint distribution of Y and θ.
f (Y ) denotes the marginal distribution of Y
p(θ

Y ) denotes the posterior distribution of θ given Y

j

(Institute)

Markov Chain Monte Carlo

11/05

3 / 36

Then we can write the joint distribution as

h(θ, Y ) = f (Y

θ)g (θ) = p(θ

Y )f (Y )

j

j

which allows to write the posterior as

Y ) =

p(θ

j

or equivalently

f (Y

θ)g (θ)

j
f (Y )

p(θ

j

Y ) _ f (Y

j

θ)g (θ)

Using the functional equivalence between f (Y
we can express the posterior as

j

θ) and the likelihood L(θ

Y )

j

As we will see later on, the classical and the Bayesian approach are the same when
the prior information is not available, that is, when the prior is di¤use or ‡at.

p(θ

j

Y ) _ L(θ

j

Y )g (θ).

(Institute)

Markov Chain Monte Carlo

11/05

4 / 36

Which prior distributions should be used?

There are groups of densities that may be easier to combine with the
information of the likelihood. The natural conjugate priors are priors that
once they are combined with the likelihood, they produce a posterior which
has the same distribution as the prior.

Example: Distribution of β assuming that σ2 is known

Assume β
known. Then the distribution can be written as

σ2~N(β0, Σ0) (a multivariate normal distribution) where β0 and Σ0 are

j

σ2) = (2π)(cid:0)

K
2

g (β

j

Σ0

j

j

.5exp

_ exp

1
2

(β

(cid:0)

(cid:0)

(cid:26)

(cid:0)

(cid:26)
β0)0Σ(cid:0)

1
0 (β

β0)

(cid:0)

(cid:27)

1
2

(β

(cid:0)

β0)0Σ(cid:0)

1
0 (β

β0)

(cid:0)

(cid:27)

where (2π)(cid:0)

K
2

Σ0

j

j

.5 is a known constant.

(Institute)

Markov Chain Monte Carlo

11/05

5 / 36

The log likelihood

σ2, Y ) = (2πσ2)(cid:0)

T
2 exp

L(β

j

_ exp

1
2σ2 (Y

(cid:0)

(cid:26)

1
2σ2 (Y

(cid:0)

(cid:26)

X β)0(Y

(cid:0)

(cid:0)

(cid:0)

X β)0(Y

X β)

(cid:0)

(cid:27)

X β)

.

(cid:27)

where (2πσ2)(cid:0)
Then the posterior is

T
2

is a known constant.

p(β

j

σ2, Y ) _ g (β

j

_ exp

σ2, Y )
β0)0

σ2)L(β
j
1
2 (β
(cid:0)
1
2σ2 (Y

(cid:0)
(cid:0)

(cid:0)

(cid:26)

1
Σ(cid:0)
0 (β
X β)0(Y

β0)
X β)

(cid:0)
(cid:0)

.

(cid:27)

Rearranging terms it can be shown that the posterior is also normal, therefore the
normal density is the natural conjugate prior for β.

(Institute)

Markov Chain Monte Carlo

11/05

6 / 36

Posterior distribution of β

It can be shown that β

σ2, Y ~N(β1, Σ1) where

j
β1 = (Σ(cid:0)
= (Σ(cid:0)
Σ1 = (Σ(cid:0)

1
0 + σ(cid:0)
1
0 + σ(cid:0)
1
0 + σ(cid:0)

2X 0X )(cid:0)
2X 0X )(cid:0)
2X 0X )(cid:0)

1
0 β0 + σ(cid:0)
1
0 β0 + σ(cid:0)

1(Σ(cid:0)
1(Σ(cid:0)
1

2X 0Y )
2X 0X
β)

b

From the previous equation we can see that the posterior mean of β is an average
of β0 and

β.

b

(Institute)

Markov Chain Monte Carlo

11/05

7 / 36

Example: Distribution of σ2 assuming that β is known

The natural conjugate prior for σ2 is the inverted Gamma distribution (the natural
conjugate prior for 1
Prior of 1
2 , δ0
Then

σ2 is the Gamma distribution)1.
2 ) where υ0 and δ0 are known.

β~Γ( υ0

σ2 j

g (

1
σ2 j

β) ∝ (

1
σ2 )
and

υ0
2 (cid:0)

1 exp(

δ0
2σ2 )

(cid:0)

L(

1
σ2 j

β, Y ) = (2πσ2)(cid:0)

T
2 exp

1
2σ2 (Y

X β)0(Y

(cid:0)

_ (σ2)(cid:0)

T
2 exp

(cid:26)

(cid:0)
(cid:26)
1
2σ2 (Y

(cid:0)

X β)0(Y

(cid:0)

(cid:0)

X β)

(cid:0)

(cid:27)

X β)

.

(cid:27)

with E (W ) = υ

δ and V (W ) = 2 υ
δ2 .

(Institute)

Markov Chain Monte Carlo

11/05

8 / 36

g (W ) ∝ W

υ
2 (cid:0)

1 exp(

W δ
2

)

(cid:0)

The posterior, 1

σ2 j

β, Y ~Γ( υ1

2 , δ1

2 ), is therefore

p(

1
σ2 j

β, Y ) ∝ g (

β) L(

β, Y )

1
σ2 j
1 exp(

1
σ2 j
1
υ0
σ2 )
2 (cid:0)
1
σ2 )
1
σ2 )

υ1
2 (cid:0)

∝ (

= (

= (

υ0
2 + T

1exp

2 (cid:0)

1exp

(cid:0)
(cid:26)
X β)0(Y

(cid:26)

(cid:0)
δ1
2σ2

(cid:0)

where δ1 = δ0 + (Y

(cid:0)

(cid:27)
X β) and υ1 = υ0 + T .

δ0
2σ2 )(σ2)(cid:0)

(cid:0)

T
2 exp

1
2σ2 (Y

(cid:0)

(cid:26)
1
2σ2 (δ0 + (Y

(cid:0)

X β)0(Y

(cid:0)

(cid:0)

X β)0(Y

X β)

(cid:0)

(cid:27)

X β))

(cid:27)

(Institute)

Markov Chain Monte Carlo

11/05

9 / 36

GIbbs- Sampling in Econometrics

Gibbs-sampling is a Markov chain Monte-Carlo method for approximating the
joint and marginal distributions by sampling from conditional distributions.
Consider the following joint density

f (z1, z2, .........., zk )

and that we are interested in obtaining characteristics of the marginal density

f (zt ) =

.....

f (z1, z2, .........., zk )dz1dz2, ..dzt

Z

Z

1dzt +1........, dzk

(cid:0)

such as the mean or the variance. This exercise may be, when possible, very
di¢ cult to perform

Gibbs sampling will allow me, if we are given the complete set of conditional
distributions f (zt
z1, z2, .........., zk without the need of knowing the joint f (z1, z2, .........., zk )
or the marginals f (zt ).

1, zt +1........, zk ), to generate a sample of

z1, z2, ..zt

(cid:0)

j

(Institute)

Markov Chain Monte Carlo

11/05

10 / 36

Methodology

Given arbitrary starting values z 0

1 from f (z1

1) Draw z 1
2) Then draw z 1
3) Then draw z 1

t +1........, z 0
t , z 0
2 , ..z 0
k
z 0
t +1........, z 0
t , z 0
2 , ..z 0
k )
t , z 0
3 , ..z 0
1 , z 0
z 1
4 , z 0
2 , z 0
1 , z 1
z 1

j
2 from f (z2
3 from f (z3

j

t +1........, z 0
k )
5 ........, z 0
k )

j

.

.

.
k) Finally draw z 1

2 , z 1
Then steps 1 to k can be iterated J times to get z j
j = 1, 2, ....., J.

k from f (zk j

1 , z 1
z 1

3 , z 1
1, z j

4 , z 1
2, ..z j

5 ........, z 1
k
t , z j

1)
t +1........, z j

(cid:0)

k , for

(Institute)

Markov Chain Monte Carlo

11/05

11 / 36

∞.

A crucial result in the literature is that of Geman and Geman (1984) that
t +1........, z j
shows that the joint and marginal distributions of z j
k
converge to the joint and marginal distributions of z1, z2, ..zt , zt +1........, zk
as J
Consider J = L + M, then typically what is done is to use the …rst L
simulations until the Gibbs sampler has converged and then use the
remaining M simulations to approximate the empirical distribution.
Convergence of the Gibbs Sampling

2, ..z j

1, z j

t , z j

!

The Convergence of the Gibbs sampler is a very important issue which is somehow
di¢ cult to handle. For example it is usual to plot the posterior densities over the
Gibbs iterations and look for little variation in the generated distribution over the
replications.

(Institute)

Markov Chain Monte Carlo

11/05

12 / 36

Example: A univariate Autoregression

Consider the following autoregressive model

yt = µ + φ1yt

1 + φ2yt

(cid:0)

(cid:0)

2 + φ3yt

where we assume that the roots of (1
outside the unit circle.

(cid:0)

3 + φ4yt
(cid:0)
φ1L

(cid:0)
φ2L2

4 + et , et ~i.i.d.N(0, σ2),
φ4L4) = 0 lie

φ3L3

(cid:0)

(cid:0)

(cid:0)

We can write the autoregressive model in matrix notation as

Y = X β + ε,

ε~N(0, σ2I )

where β = [µ, φ1, φ2, φ3, φ4]0 and X = [1, yt

1, yt

2, yt

3, yt

4].

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(Institute)

Markov Chain Monte Carlo

11/05

13 / 36

Conditional Distributions of β given σ2

The prior distribution of β is β
indicator to denote that all the roots of (1
outside the unit circle.
The posterior distribution of β is β

j

σ2~N(β0, Σ0)I (s (φ)), where I (s(φ)) is an
φ2L2

φ3L3

φ1L

φ4L4) = 0 lie

(cid:0)

(cid:0)
(cid:0)
σ2, Y ~N(β1, Σ1)I (s (φ)),where

(cid:0)

j

β1 = (Σ(cid:0)
Σ1 = (Σ(cid:0)

1
0 + σ(cid:0)
1
0 + σ(cid:0)

2X 0X )(cid:0)
2X 0X )(cid:0)

1
0 β0 + σ(cid:0)

1(Σ(cid:0)
1

2X 0Y )

Conditional Distributions of σ2 given β

β~I Γ( υ0
The Prior distribution of σ2
denotes inverted Gamma distribution.
The posterior distribution of σ2
δ1 = δ0 + (Y

X β)0(Y

j

j

(cid:0)

(cid:0)

β~I Γ( υ1

2 ) where
X β) and υ1 = υ0 + T .

2 , δ1

2 , δ0

2 ) where υ0 and δ0 are known and I Γ

(Institute)

Markov Chain Monte Carlo

11/05

14 / 36

The Gibbs Sampling procedure consists of the following
steps

Start the iteration of the Gibbs Sampling

-To start the iteration we use an arbitrary starting value σ2 =
-Iterate the following steps j = L + M times

0

σ2

(cid:8)

(cid:9)

j

1

(cid:0)

σ2

, that is, the value generated in the previous

Conditional on σ2 =
iteration, we generate βj from the posterior distribution of β.
Conditional on β = βj ,that is, the value β generated in 1), we generate
σ2
Set j = j + 1.
(cid:8)

from the posterior distribution of σ2.

(cid:9)

(cid:8)

(cid:9)

j

(Institute)

Markov Chain Monte Carlo

11/05

15 / 36

In generating β we employ rejection sampling to ensure that all the roots are
outside the unit circle (we discard the draws that do not satisfy this
condition).

As a result of this procedure we generate the following sets of values

β1, β2, ................, βL+M ,

σ2

1

,

σ2

2

, ....,

σ2

L+M

.

n

o

n

o

n

o

We discard the …rst L generated values to ensure convergence of the
Gibbs-Sampler and then use the following M values to make inferences about
β and σ2. The remaining M values provide us with the Joint and the
Marginal distribution.

(Institute)

Markov Chain Monte Carlo

11/05

16 / 36

Markov- Switching and Gibbs Sampling

We have shown that when estimationg M-S models we treat parameters of
the model depending on an unobserved sate variable. We typically estimate
the models and make inferences on the unobserved variables conditional on
the parameters (estimates) of the model.

The Bayesian approach treats both the parameters of the model and the
Markov switching variables as random variables. Then the inference about
the states of the economy (denoted as
joint distribution of the sates and the parameters of the model.

ST = S1, S2, ......ST ) is based on the

e

(Institute)

Markov Chain Monte Carlo

11/05

17 / 36

Consider the following model

+ εt

yt = µSt
µSt
σ2
St

= µ0 + µ1St ,
= σ2
0(1
= σ2
0(1 + h1St ),

(cid:0)

St ) + σ2

)

εt ~N(0, σ2
St
µ1 > 0
1St

h1 > 0

P(St = 0
P(St = 1

1 = 0) = q
1 = 1) = p

St
St

j
j

(cid:0)

(cid:0)

(Institute)

Markov Chain Monte Carlo

11/05

18 / 36

The Bayesian approach will entail the inference about T + 6 random
variables:

1, p, q
We need to derive the joint posterior distribution

S1, S2, ......, ST , µ0, µ1, σ2

0, σ2

f

g

.

g (

ST , µ0, µ1, σ2

0, σ2

1, p, q

j

e

e

ST j
e

ST ).g (

yT ) = g (µ0, µ1, σ2
0, σ2
1, p, q
yT ,
j
= g (µ0, µ1, σ2
0, σ2
ST )
yT ,
1j
e
e
g (p, q
yT )
ST ).g (
yT ,
ST j
e
e
0, σ2
= g (µ0, µ1, σ2
ST )
yT ,
1j
e
e
e
e
yT )
ST ).g (
g (p, q
ST j
e
e
ST , p and q are independent of both other
e

e

j

j

yT )

e

We assume that conditional on
parameters of the model and of the data. Notice that conditional on
expression yt = µSt
dummy.

+ εt , εt ~N(0, σ2
St

e

e

) is simply a regression model with a known

ST , the

e

(Institute)

Markov Chain Monte Carlo

11/05

19 / 36

The Gibbs Sampling estimation procedure

Using arbitrary starting values we repeat the following steps.

S

block

ST from g (

1 Generate St from g (St
j
µ0, µ1, σ2
ST j
2 Generate the transition probabilities p and q from g (p, q
e
e
0, σ2
3 Generate µ0, µ1, σ2
ST ).

=t , µ0, µ1, σ2
0, σ2

e
0, σ2
1, from g (µ0, µ1, σ2
1j

0, σ2
1, p, q,

1, p, q,
yT )

yT ,

e

e

ST ).

j

e

yT ) , or generate the whole

e

e

(Institute)

Markov Chain Monte Carlo

11/05

20 / 36

6
Step 1:Single move Gibbs Sampling, Generate St from
yT )
g (St

1, p, q,
Suppressing the conditioning in the parameters we can write

=t , µ0, µ1, σ2

0, σ2

S

j

e

e

A

C

g (St

j

S

=t ,

yT ) = g (

St

e

e

since g (AB

C )

j

=

(cid:17)

=

z}|{
A
St

g (

z}|{
g (

g (A
j
g (St

j

C

S

B
yt +1, yt +2, ...., yT )

yt ,
=t ,
z }| {
{
z
}|
B
e
e
yt )
=t ,
S
yt +1, yt +2, ...., yT j
,
C
z }| {
{
}|
z
e
e
yt )
yt +1, yt +2, ...., yT j
=t ,
S
z }| {
C )
BC )g (B
{
}|
z
j
e
e
yt )g (yt +1, yt +2, ...., yT j
S
=t ,
S
yt )
g (yt +1, yt +2, ...., yT j
e
e

=t ,

S

B

j

e

=t ,

yt )

= g (St
= g (St

j

j

(Institute)

Since conditional in the state, St and yt +1, .., yT
are independent.
=t ,

yt )

e

e

S

e

(cid:0)

1, St +1, ..., ST ,
e

St
e
Markov Chain Monte Carlo
e

1, yt )

yt

(cid:0)

e

11/05

21 / 36

6
6
6
6
6
6
6
6
6
A

g (

St

z}|{

C

B

(cid:0)

1,
{

j

St
z
e

(cid:0)

yt
1,
}|
e

St +1, ..., ST , yt ) =
z

}|

{

A

B

C

g (

St

,

St +1, ..., ST , yt

z

B

}|

z}|{
g (

St +1, ..., ST , yt
∝ g (St , St +1, ..., ST , yt
{

}|

z

1)
{

(cid:0)

j

St
(cid:0)
C
z
e
yt
1,
(cid:0)
}|
yt
1,
e

yt
1,
}|
e
1)
(cid:0)
{
1)
(cid:0)

(cid:0)

{
St
z
St
j
e

j

e

e

g (St , ., ST , yt

1,

yt

St

j

(cid:0)

(cid:0)

e

e

1) = g (St
= g (St

j

(cid:0)

yt

1,
1)g (St +1, ., ST , yt

1)g (St +1, ., ST , yt
j
St

St ,
Since is homogeneous Markov.

St
St
e

e

(cid:0)

(cid:0)

j

j

St ,
1,

(cid:0)

1,
1)

St
yt
e

(cid:0)

(cid:0)

yt

1)

(cid:0)

e

e

e

(Institute)

Markov Chain Monte Carlo

11/05

22 / 36

Notice that

B

A
yt

g (

z}|{

,

St +1, ., ST j
z
}|
{

St ,
z

C

St

1,
(cid:0)
}|

yt

(cid:0)

e

e

C

yt

1)
(cid:0)
C
{

A
yt

1) = g (
{

St

St ,
1,
j
(cid:0)
z
}|
B
z}|{
e
g (
St ,
St +1, ., ST j
z
St )g (St +1
= g (yt
z
}|
{
j
g (St +2, ., ST ,

= g (yt
∝ g (yt

j
j

j
St )g (St +1
St )g (St +1

j
j

A
e
yt )
St
1,
yt
1
(cid:0)
(cid:0)
{
}|
1, yt )
yt
1,
St
St ,
z}|{
j
e
(cid:0)
(cid:0)
e
St
St +1, St ,
yt
1,
(cid:0)
e
St )g (St +2, ., ST j
e
St )

e

e

(cid:0)

1, yt )
St +1)

(Institute)

Markov Chain Monte Carlo

11/05

23 / 36

Then, we can write

where g (St

St

j

(cid:0)

g (St

S

=t ,

yT ) ∝ g (St

j
1) and g (St +1
e

e

j

1)g (yt

St

(cid:0)

j

j

St )g (St +1

St )

j

St ) are given by the transition probabilities and

g (yt

j

St ) =

1

2πσ2
st

exp

f(cid:0)

1
2σ2
st

(yt

)2

µst

g

(cid:0)

q

(Institute)

Markov Chain Monte Carlo

11/05

24 / 36

6
We can then calculate

P(St = j

j

S

=t ,

yT ) =

∑1

g (St = j
S
j =0 g (St = j
e

j

=t ,
S

j

yT )
=t ,
e

yT )

e

We generate St using a uniform distribution between 0 and 1.
If the generated
e
number is less or equal than P(St = j
yT ), we set the value of St to zero,
S
j
otherwise we set the value equal to one.
e

=t ,

e

e

e

(Institute)

Markov Chain Monte Carlo

11/05

25 / 36

6
6
6
6
Step 1):Multimove Gibbs Sampling - Generate
yT )
g (

µ0, µ1, σ2

1, p, q,

0, σ2

e
Suppressing the conditioning in the parameters we can write
e

ST j
e

St from

yT ) = g (S1, S2, ..., ST ,

yT )

g (

ST j
e

e

= g (ST ,
= g (ST ,
= g (ST ,

j

(cid:0)

1,

j
j
j

j
yT )g (S1, S2, ..., ST
e
yT )g (ST
1,
(cid:0)
e
yT )g (ST
1,
(cid:0)
e
S2, ., ST

yT )
ST ,
yT )g (S1, ., ST
ST ,
j
e
yT )g (ST
2,
ST ,
j
j
(cid:0)
e
yT )...
.......g (S1,
1, ST ,
2, ST
(cid:0)
(cid:0)
e
yT ) = g (ST
g (ST
yT
ST ,
1,
e
since cond on ST , yT adds no info.)
e
1,
(cid:0)
yT

S2, y1)

j
ST ,

1)

e
1,

(cid:0)

(cid:0)

(cid:0)

j

j

= g (ST ,
g (ST

(cid:0)

e
yT )g (ST
j
1,
ST
2,
j
(cid:0)
e
T
1
∏
(cid:0)
yT )
t =1

j

yT
ST ,
j
(cid:0)
2)..g (S1,
e
St +1,

(cid:0)

j

yt ).

g (St ,
e

j

= g (ST ,

(NB

:

2,

(cid:0)

(cid:0)
ST

1)

ST
j
(cid:0)
1, ST ,

1, ST ,
yT )..

yT )

e

e

e

e

(Institute)

Markov Chain Monte Carlo

11/05

26 / 36

The derivation is based on the Markov property that states that to makes
inference about St conditional on St +1 the variables St +2,....ST , yt +1,....yT
have no information beyond that contained in St +1.
Then we proceed in the following way: we …rst generate
yT and then, for the other values of t = T
conditional on yt and the generated t + 1.
e

ST conditional on
2, ..., 1, we generate St

1, t

(cid:0)

(cid:0)

e

(Institute)

Markov Chain Monte Carlo

11/05

27 / 36

We can carry out this using the following steps:

Step 1 Run the Hamilton …lter to get g (St

j
yT ) that is used to generate ST .
yt , for t = T
Step 2 Generate St conditional on St +1 and
e
St +1,

…lter provides g (ST j
form g (St

(cid:0)

e

j

yt ) using the fact that
e

yt ). The last iteration of the

1, t

(cid:0)

2, ..., 1,

g (St

St +1,

j

e
yt ) =

e

=

=

g (St , St +1
g (St +1

yt )

g (St +1

g (St +1

yt )

j

j
yt )
j
e
yt ).g (St
St ,
j
e
yt )
g (St +1
e
St ).g (St
j
e
yt )
g (St +1
j
St ).g (St

j

j

e
yt )

j

j

e

yt )

e

∝ g (St +1

(Institute)

Markov Chain Monte Carlo

11/05

28 / 36

e

Then we calculate

P(St = 1

j

St +1,

yt ) =

We generate St using a uniform distribution between 0 and 1.
number is less or equal than P(St = 1
j
otherwise we set the value equal to one.

St +1,

e

g (St +1
j =0 g (St +1

j

∑1

St = 1)g (St = 1

yt )

j

j

yt )

St = j)g (St = j
e
If the generated
yt ), we set the value of St to zero,

e

j

e

(Institute)

Markov Chain Monte Carlo

11/05

29 / 36

Generating Transition Probabilities p and q, conditional on

ST

Conditional on
parameters of the models2.

ST , p and q are independent of the data set

yT , and the other

e

Prior Distribution

e

e

p~beta(u11, u10),
q~beta(u00, u01),
with g (p, q) ∝ pu11
p)u10
hyper parameters of the priors.

1(1

(cid:0)

(cid:0)

1qu00

1(1

(cid:0)

(cid:0)

(cid:0)

q)u01

(cid:0)

1, where the u

s are known

0

The likelihood function is given by

ST ) = pn11 (1

L(p, q
transitions from i to j which can be counted from

p)n10 qn00 (1

(cid:0)

(cid:0)

j

ST .

q)n01 where nij refers to the number of

e

α0, α1)

g (z

j

∝

z α0

1(1

(cid:0)

= 0

z )α1

(cid:0)

(cid:0)

e

1for 0 < z < 1
otherwise,

with E (z ) = α0

α0 +α1

and Var (z ) =

α0 α1
(α0 +α1 )2 (α0 +α1 +1)

(Institute)

Markov Chain Monte Carlo

11/05

30 / 36

Posterior distribution

g (p, q

j

ST ) = g (p, q)L(p, q
∝ pu11

1(1

e

(cid:0)
pn11 (1
(cid:0)
= pu11+n11
(cid:0)

ST )
j
p)u10
(cid:0)
e
p)n10 qn00 (1
1(1

(cid:0)

(cid:0)

(cid:0)

p)u10+n10

1qu00

q)u01

1

(cid:0)

1(1
(cid:0)
q)n01

(cid:0)

1qu00+n00

1(1

(cid:0)

(cid:0)

q)u01+n01

1,

(cid:0)

(cid:0)

then,
p
q

j
j

ST ~beta(u11+n11, u10 + n10),
ST ~beta(u00 + n00, u01 + n01).
e
e

(Institute)

Markov Chain Monte Carlo

11/05

31 / 36

Generating µ0, µ1,conditional on σ2

0, σ2
1,

yT and

ST

Given

e

e

yt = µ0 + µ1St + εt

we can write
y (cid:3)t = µ0x0t + µ1x1t + υt

εt ~N(0, σ2
St

)

υt ~N(0, 1)

where y (cid:3)t =

yt
σSt

, x0t =

1
σSt

and x1t = St
σSt

(Institute)

Markov Chain Monte Carlo

11/05

32 / 36

Prior Distribution: We can write the model in matrix notation as

then if we assume a normal prior µ
j
0, σ2
σ2
1,

Posterior distribution, µ

Y = X µ + V ,
0, σ2
σ2
ST ,

V ~N(0, I )

1~N(b0, B0), where b0, B0 are given.
yT ~N(b1, B1), where b1, B1 are

j
b1 = (B (cid:0)
B1 = (B (cid:0)

1
e
1

0 + X 0X )(cid:0)
e
0 + X 0X )(cid:0)

0 b0 + X 0Y )

1

1(B (cid:0)
1

to constrain µ1 > 0, we discard the draws where this condition is not satis…ed.

(Institute)

Markov Chain Monte Carlo

11/05

33 / 36

Generating σ2

0, σ2

1,conditional on µ0, µ1,

yT and

ST

Given

σ2
St

= σ2

e
0(1 + h1St ),
where
0(1 + h1).

1 = σ2
σ2

e
h1 > 0

we can …rst generate σ2
on σ2
0.

0 conditional on h1, and then generate (1 + h1) conditional

(Institute)

Markov Chain Monte Carlo

11/05

34 / 36

Generating σ2

0 conditional on h1

We divide both sides of yt by

(1 + h1St ) :

p

y (cid:3)(cid:3)t

where y (cid:3)(cid:3)t

= µ0x (cid:3)0t + µ1x (cid:3)1t + υ(cid:3)t
yt
(1 + h1St )

=

, x (cid:3)0t =

x (cid:3)1t =

p

St

(1 + h1St )

and υ(cid:3)t =
p

υ(cid:3)t ~N(0, σ2
0)
1
(1 + h1St )
εt

,

(1 + h1St )

p

then:
The Prior distribution of σ2
0j
and I Γ denotes inverted Gamma distribution.
The posterior distribution of σ2
0j

p
µ0, µ1, h1~I Γ( υ0

µ0, µ1, h1,

δ1 = δ0 +

(y (cid:3)(cid:3)t (cid:0)

µ0x (cid:3)0t (cid:0)

µ1x (cid:3)1t )2 and υ1 = υ0 + T .

e

e

T
∑
t =1

2 , δ0

2 ) where υ0 and δ0 are known

ST ,

yT ~I Γ( υ1

2 , δ1

2 ) where

(Institute)

Markov Chain Monte Carlo

11/05

35 / 36

Generating h1 conditional on σ2
0

We divide both sides of yt by σ0 :

y (cid:3)(cid:3)(cid:3)t

= µ0x (cid:3)(cid:3)0t + µ1x (cid:3)(cid:3)1t + υ(cid:3)(cid:3)t

where y (cid:3)(cid:3)(cid:3)t

=

yt
σ0

, x (cid:3)(cid:3)0t =

1
σ0

then:

υ(cid:3)(cid:3)t ~N(0, (1 + h1St ))
and υ(cid:3)(cid:3)t = εt
σ0

, x (cid:3)(cid:3)1t = St
σ0

2 , δ2
The Prior distribution of h1
known and I Γ denotes inverted Gamma distribution.
The posterior distribution of h1
ST ,

µ0, µ1, σ2

0~I Γ( υ2

µ0, µ1, σ2
0,

j

j

2 ) where υ2 and δ2 are

yT ~I Γ( υ3

2 , δ3

2 ) where

µ1x (cid:3)(cid:3)1t )2 and υ3 = υ2 + T , where N1 is the
e

e

δ3 = δ2 +

N1∑
(y (cid:3)(cid:3)(cid:3)t (cid:0)
t =1
number of times St = 1.

µ0x (cid:3)(cid:3)0t (cid:0)

(Institute)

Markov Chain Monte Carlo

11/05

36 / 36


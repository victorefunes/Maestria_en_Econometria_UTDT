Stationary Stochastic Time Series Models

When modeling time series it is useful to regard an observed time series,
(x1; x2; :::; xn), as the realisation of a stochastic process. In general a stochas-
tic process can be described by an n - dimensional probability distribution
p(x1; x2; :::; xn) so that the relationship between a realisation and a stochas-
tic process is analogous to that between the sample and population in classical
statistics.

Specifying the complete form of the probability distribution will in general
be too ambitious so we usually content ourselves with the …rst and second
moments, that is, (i) the n means, (ii) the n variances and (iii) the n(n
1)=2
covariances.

(cid:0)

(i) E(x1); E(x2); :::; E(xn)

(ii) V (x1); V (x2); :::; V (xn)

(iii) Cov(xi; xj); i < j:

If we could assume joint normality of the distribution, these set of conditions
would then completely characterise the properties of the stochastic process.
Even if this were the case, it will be impossible to infer all values of the …rst and
second moments from just one realisation of the process, since there are only n
observations but n (means)+ n (variances) + n(n
1)=2 (covariances) unknown
parameters.

(cid:0)

Further simplifying assumptions must be made to reduce the number of

unknown parameters to manageable proportions.

Stationarity

A stochastic process is said to be strictly stationary if its properties are

una¤ected by a change in the time origin, that is

p(x1; x2; :::; xn) = p(x1+l; x2+l; :::; xn+l):

A stochastic process is said to be weak stationary if the …rst and second

moments exist and do not depend on time.

E(x1) = E(x2) = ::: = E(xt) = (cid:22)

V (x1) = V (x2) = ::: = V (xt) = (cid:27)2

Cov(xt; xt

k) = Cov(xt+l; xt

k+l) = (cid:13)k

(cid:0)

(cid:0)

(1)

(2)

(3)

Condition (3) states that the covariances are functions only of the lag k, and
not of time. These are usually called autocovariances.

From conditions (2) and (3) we can easily derive that the autocorrelations,

denoted as (cid:26)k also only depend on the lag.

1

(cid:26)k =

Cov(x1; x2)
V (x1)V (x2)

2

=

(cid:13)k
(cid:27)2 =

(cid:13)k
(cid:13)o

(4)

The autocorrelations considered as a function of k are referred to as the
autocorrelation function, ACF, or sometimes the correlogram. Note that since

p

(cid:13)k = Cov(xt; xt

(cid:0)
it follows that (cid:13)k = (cid:13)

(cid:0)

given.

k) = Cov(xt

k; xt) = Cov(xt; xt+k) = (cid:13)

(cid:0)

k

(cid:0)

k , and only the positive half of the acf is usually

The Wold decomposition theorem

(cid:22))
Every weakly stationary, purely non-deterministic, stochastic process (xt
can be written as a linear combination of uncorrelated random variables. (by
purely non-deterministic we mean that any linear deterministic components
have already been subtracted from xt ).
This representation is given by

(cid:0)

(xt

(cid:0)

(cid:22)) = "t + (cid:18)1"t

1 + (cid:18)2"t

2 + :::

(cid:0)

(cid:0)

(5)

=

1

j=0
X

(cid:18)j"t

j where (cid:18)0 = 1

(cid:0)

The sequence of random variables ("t; "t
2; :::) are assumed to be uncor-
related and identically distributed with zero mean and constant variance (a
white-noise process), that is

1; "t

(cid:0)

(cid:0)

E("t) = 0
V ("t) = (cid:27)2

Cov("t;"t

k) = 0 for all k.

(cid:0)

Using equation (5) we can see that;
The mean of the process described in equation (5) is

The Variance is

E(xt) = (cid:22);

(cid:13)o = E(xt

(cid:22))2
= E("t + (cid:18)1"t
= (cid:27)2(1 + (cid:18)2

(cid:0)

2 + :::)2
1 + (cid:18)2"t
(cid:0)
2 + :::) (since Cov("t;"t

(cid:0)
1 + (cid:18)2

k) = 0 for all k)

(cid:0)

= (cid:27)2 1

(cid:18)2
j where (cid:18)o = 1

j=0
X

The covariance

2

(6)

(7)

(8)

(cid:26)k = E(xt

(cid:22))(xt

(cid:0)

= E("t + (cid:18)1"t
= E((cid:18)k"t
k"t
= (cid:27)2 1

(cid:0)

(cid:0)

k

(cid:22))
(cid:0)
(cid:0)
1 + (cid:18)2"t
(cid:0)
(cid:0)
k) + E((cid:18)k+1(cid:18)1"t

2 + :::)("t

k

(cid:18)j(cid:18)j+k; where (cid:18)1 = 0

k + (cid:18)1"t
(cid:0)
1"t

k + (cid:18)2"t

2
(cid:0)
1) + ::::::::::::::::

(cid:0)

(cid:0)

k

1

(cid:0)

(cid:0)

(cid:0)

(cid:0)

k + :::) (9)

(cid:0)

(10)

j=0
X

Moving Average Processes

A moving average process of order q is a special case of equation (5) where

the number of lags are truncated at q. For yt = xt

(cid:22), is written as

(cid:0)

yt = "t + (cid:18)1"t

1 + (cid:18)2"t

2 + ::: + (cid:18)q"t

q; t = 1; :::; T

(cid:0)

(cid:0)

(cid:0)

and denoted by yt~MA(q)

A …nite moving average is always stationary since equations (6), (7), and (8)

will automatically satisfy the weak stationary conditions for a …nite sum.

Example MA(1)

(11)

1)

(cid:0)

yt = "t + (cid:18)1"t

1

(cid:0)

Then

(i) E(yt) = 0

(ii) E(yt)2 = E("t + (cid:18)1"t

1)2 = (cid:27)2(1 + (cid:18)2
1)
(cid:0)

(iii)

(iv)

(i) E(yt) = 0

E(ytyt

k) = E("t + (cid:18)1"t

(cid:0)

k + (cid:18)1"t

k

(cid:0)

(cid:0)

1)("t
(cid:0)
for k = 1
for k > 1

(cid:27)2(cid:18)1
0

(cid:26)

(cid:18)1=(1 + (cid:18)2
1)
0

for k = 1
for k > 1

(cid:26)k =

(cid:26)

Example MA(q)

(ii) E(yt)2 = (cid:27)2(1 + (cid:18)2

1 + (cid:18)2

2 + ::: + (cid:18)2
q)

3

(iii)

(iv)

E(ytyt

k) =

(cid:0)

q

(cid:27)2(cid:18)j(cid:18)j+k

for k = 1; 2; :::; q

j=0
P

8
<

0

for k > q

q

:
(cid:27)2(cid:18)j(cid:18)j+k=

j=0
P

8
<

0

(cid:18)2
j

q

j=0
P

(cid:26)k =

for k = 1; 2; :::; q

for k > q

:
Autoregressive Model

An autoregressive process of order p is written as

yt = (cid:30)1yt

1 + (cid:30)2yt

2 + ::: + (cid:30)pyt

p + "t;

t = 1; :::; T

(12)

(cid:0)

(cid:0)

(cid:0)

This will be denoted yt~AR(p)

Example AR(1)

Notice that if this relationship is valid for time t, it should also be valid for

yt = (cid:30)1yt

1 + "t

(cid:0)

t = 1; ::::::; T

(13)

time t

(cid:0)

1, that is

(cid:0)
Substituting equation (12) into equation (11) we get the following expression.

(cid:0)

(cid:0)

yt

1 = (cid:30)1yt

2 + "t

1

(14)

yt = (cid:30)1((cid:30)1yt
= (cid:30)2

2 + "t
2 + (cid:30)1"t

1yt

(cid:0)

1) + "t
(cid:0)
1 + "t

(cid:0)
1 times we get

(cid:0)

and repeating this procedure j

yt = (cid:30)j
(cid:30)
j
j

Now if

1

j + (cid:30)j
1
(cid:0)

1yt
(j
(cid:0)
< 1 the deterministic component of yt is negligible if j is large

2) + ::: + (cid:30)1"t

1 + "t

(15)

"t

"t

(j

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

2

enough. Under this condition equation (13) might be written as

(cid:30)j
1"t

j
(cid:0)

(16)

(cid:30)1j
j

In other words, whenever

< 1, an autoregressive process of order 1 may

be written as an in…nite moving average process in which the coe¢ cient of "t
is (cid:30)j
1:
The …rst point to establish about an autoregressive process is the conditions
under which it is stationary. Clearly, for the AR(1) process the condition for
< 1 since whenever this condition holds the weak stationary
stationarity is
conditions are automatically satis…ed:

(cid:30)1j
j

j
(cid:0)

(cid:0)
1) + (cid:30)j
1
(cid:0)

1

yt =

j=0
X

4

(i) The mean exists and does not depend on time.

Proof:

E(yt) = E( 1
j=0
P

(cid:30)j
1"t

(cid:0)

j) = 0

Notice that this is only true when
Using equation (13), we can easily verify that when
E(yt) = (cid:30)j
1yt
Therefore, whenever

(cid:30)1j
j

< 1.

j
(cid:0)

(cid:30)1j (cid:21)
j

then violates the stationarity condition.

(cid:30)1j (cid:21)
j

1 , then

1, the expected value of yt depends on t, and

(ii) The variance exists and does not depend on time.

(cid:0)

j)

j)2

(cid:30)j
1"t

(cid:30)j
1"t

V (yt) = V ( 1
j=0
P
= E( 1
j=0
P
= E( 1
j=0
P
(cid:30)2j
j) = (cid:27)2 1
1 E("2
t
(cid:0)
j=0
P

= 1
j=0
P

(cid:30)2j
1 "2
t
(cid:0)

j)

(cid:0)

or

(since E(yt) = 0)

(since " is a WN process)

(cid:30)2j
1 =

(cid:27)2

(cid:30)2
1)

(1

(cid:0)

(since

< 1)

(cid:30)1j
j

(cid:13)0 =

(cid:27)2

(cid:30)2
1)

(1

(cid:0)

(17)

(iii) The autocovariances exist and do not depend on time.

To calculate the autocovariance of an autoregressive process is slightly more

complicated than that of a moving average. We proceed in the following way;

E(ytyt

k) = (cid:30)1E(yt

1yt

k) + E("tyt

k);

(cid:0)

(cid:0)

(cid:0)

(cid:0)

or

Now notice that

(cid:13)k = (cid:30)1(cid:13)k

1 + E("tyt

k)

(cid:0)

(cid:0)

E("tyt

k) = E["t((cid:30)j
1
(cid:0)

1

(cid:0)

"t

k

(j

(cid:0)

(cid:0)

1) + (cid:30)j
1
(cid:0)

2

(cid:0)

"t

k

(j

(cid:0)

(cid:0)

(cid:0)

2) + ::: + (cid:30)1"t

k

(cid:0)

(cid:0)

1) + "t

k)]

(cid:0)

Given that the error terms are WN processes, this expression is equal to zero

for k > 0, and we can write the autocovariance function as

From equation (16) we can easily derive the autocorrelation function that is

(cid:13)k = (cid:30)1(cid:13)k

1

(cid:0)

(18)

5

Therefore whenever the process is stationary the autocorrelation function
1(cid:26)0:

declines exponentially. Using equation (17) it can easily be seen that (cid:26)k = (cid:30)k

(cid:26)k = (cid:30)1(cid:26)k

1

(cid:0)

(19)

Examples

i)(cid:30)1 = :5

ii)(cid:30)1 =

:5

(cid:0)

The Lag Operator

6

The lag operator, L, is de…ned by the transformation

Lyt = yt

1

(cid:0)

Notice that the lag operator may also be applied to yt

1 yielding

(cid:0)

Lyt

1 = yt

(cid:0)

2

(cid:0)

(20)

(21)

Now substituting (18) into (19) we get Lyt

1 = L(Lyt) = L2yt = yt

2 and

(cid:0)

(cid:0)

so in general

The lag operator can be manipulated in a similar way to any algebraic quan-

Lkyt = yt
(cid:0)

k

for k

0

(cid:21)

(22)

tity.

process in which the coe¢ cient of "t

Example
Let us reproduce for convenience equation (14), an in…nite moving average
j is (cid:30)j
(cid:0)
(cid:30)1j
j where we assume
j

< 1 , then using the lag operator this

1 , that is,

(cid:30)j
1"t

(cid:0)

yt = 1
j=0
P

expression may be written as

yt = 1
j=0
P

((cid:30)1L)j"t = "t=(1

(cid:30)1L)

(cid:0)

Notice that L is regarded as having the property that

1, and then

< 1, which is a necessary condition for the convergence of the series.

L
j

j (cid:20)

This can be rearranged in the following way

(cid:30)1L
j
j

or

(1

(cid:0)

(cid:30)1L)yt = "t

yt = (cid:30)1yt

1 + "t

(cid:0)

The Di¤erence operator

The …rst di¤erence operator, (cid:1), is de…ned as (cid:1) = 1
For example

(cid:0)

L.

(cid:1)yt = (1

(cid:0)

L)yt = yt

(cid:0)

and

yt

1.

(cid:0)

(cid:1)2yt = (1

(cid:0)

L)2yt = (1

(cid:0)

2L + L2)yt = yt

(cid:0)

2yt + yt

2

(cid:0)

Autoregressive processes using Lag operators

7

An AR(p) process may be written as,

(1

(cid:0)

(cid:30)1L

(cid:0)

(cid:30)2L2

:::

(cid:0)

(cid:0)

(cid:30)pLp)yt = "t;

t = 1; ::::; T

or

(cid:30)(L)yt = "t;
(cid:30)2L2

(cid:30)1L

t = 1; ::::; T

where (cid:30)(L) = (1
(cid:0)
The stationarity condition for an autoregressive process may be expressed

:::

(cid:0)

(cid:0)

(cid:0)

(cid:30)pLp):

in terms of the roots of the polynomial of order p in L.

This may be easily understood for a …rst order autoregressive process. We

have shown that an AR(1) process may be written as,

(1

(cid:0)

(cid:30)1L)yt = "t;

t = 1; ::::; T

then we consider the roots ( one in this case) of the polynomial in L, (1
(cid:0)
(cid:30)1L) = 0, that is L = 1=(cid:30)1 , which is greater than 1 (in absolute value) whenever
(cid:30)1j
j
all the roots of the polynomial (1
circle”. (there are all greater than one in absolute value).

< 1.
In general an autoregressive process of order p is said to be stationary when
(cid:30)pLp) lie outside the ”unit

(cid:30)2L2

(cid:30)1L

:::

(cid:0)

(cid:0)

(cid:0)

(cid:0)

Moving average processes using Lag operators

yt = (1 + (cid:18)1L + (cid:18)2L2 + ::: + (cid:30)qLq)"t

t = 1; ::::::; T

or

yt = (cid:18)(L)"t

where (cid:18)(L) = (1 + (cid:18)1L + (cid:18)2L2 + ::: + (cid:30)qLq):
Sometimes we want to express a moving average as an autoregressive process.
For this to be possible we need to impose conditions on the parameters similar
to the ones we impose for stationarity. If these conditions hold the moving av-
erage process is said to be invertible.

Invertibility

ARMA(q) process is said to be invertible if all the roots of the polynomial

(1 + (cid:18)1L + (cid:18)2L2 + ::: + (cid:30)qLq) lie outside the unit circle.

Autoregressive Moving Average processes - ARMA processes

8

An autoregressive moving average process of order (p; q), denoted as ARMA(p; q)

is written as

yt = (cid:30)1yt

1+(cid:30)2yt

2+:::+(cid:30)pyt

p+"t+(cid:18)1"t

1+(cid:18)2"t

2+:::+(cid:18)q"t

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

q

(cid:0)

t = 1; ::::::; T

or

(cid:30)(L)yt = (cid:18)(L)"t

with (cid:30)(L) and (cid:18)(L) de…ned as before.

Notice that the AR(p) and the MA(q) are special cases of the ARMA(p; q)
process. The stationarity of an ARMA process depends solely on its autore-
gressive part and the invertibility only on its moving average part. Therefore
an ARMA process is stationary if the roots of (cid:30)(L) are outside the unit cir-
cle and it is invertible whenever the roots of (cid:18)(L) are outside the unit circle.
If both conditions hold an ARMA process can be written either as an in…nite
autoregressive process or as a in…nite moving average process.

Example ARMA(1,1)

Autocovariance function of an ARMA(1,1).

yt = (cid:30)1yt

1 + "t + (cid:18)1"t

(cid:0)

1

(cid:0)

(cid:13)k = E(ytyt

k) = (cid:30)1E(yt

(cid:0)
1 + E("tyt

(cid:0)

1yt
k) + (cid:18)1E("t

k) + E("tyt
1yt
k)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

k) + (cid:18)1E("t

1yt

k)

(cid:0)

(cid:0)

= (cid:30)1(cid:13)k

When k = 0

(cid:0)

(cid:13)0 = (cid:30)1(cid:13)1 + E("t((cid:30)1yt

1 + "t + (cid:18)1"t

1)) + (cid:18)1E("t

1((cid:30)1yt

1 + "t + (cid:30)1"t

1)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

where

E("t((cid:30)1yt

1 + "t + (cid:18)1"t

(cid:0)
1((cid:30)1((cid:30)1yt

2 + "t

(cid:0)

(cid:0)

1)) = (cid:27)2

(cid:0)
1 + (cid:18)1"t

(cid:0)

(cid:15)

E("t

(cid:0)

(cid:15)
then

2) + "t + (cid:18)1"t

1)) = ((cid:30)1 + (cid:18)1)(cid:27)2
(cid:0)

When k = 1

then

for k

2

(cid:21)

(cid:13)0 = (cid:30)1(cid:13)1 + (cid:27)2 + (cid:18)1((cid:30)1 + (cid:18)1)(cid:27)2

(cid:13)1 = (cid:30)1(cid:13)0 + (cid:18)1E("t

1((cid:30)1yt

2 + "t

1 + (cid:18)1"t

2))

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:13)1 = (cid:30)1(cid:13)0 + (cid:18)1(cid:27)2

9

(cid:13)k = (cid:30)1(cid:13)k

1

(cid:0)

The autocovariance function is therefore

(i) (cid:13)0 = (cid:30)1(cid:13)1 + (cid:27)2 + (cid:18)1((cid:30)1 + (cid:18)1)(cid:27)2

(ii) (cid:13)1 = (cid:30)1(cid:13)0 + (cid:18)1(cid:27)2

(iii) (cid:13)k = (cid:30)1(cid:13)k

1

(cid:0)

Equations (i) and (ii) are a system of two equations with two unknowns (cid:13)0

and (cid:13)1 .

(cid:13)0 =

1 + (cid:18)2
1 + 2(cid:18)1(cid:30)1
(cid:30)2
1
1

(cid:27)2

(cid:0)
(1 + (cid:18)1(cid:30)1)((cid:30)1 + (cid:18)1)

(cid:27)2

(cid:13)1 =

(cid:30)2
1

1

(cid:0)

Partial Autocorrelations

Autocorrelation functions are very useful to identify the existence and the
order of a moving average processes. We have also shown that the autocor-
relation function of an autoregressive process declines exponentially, but it is
di¢ cult to guess the order of the autoregressive process from the plot of the
autocorrelation function. In other words we know that the autocorrelation func-
tion of an autoregressive process declines exponentially but this plot does not
enables us to distinguish between an AR(p) and a AR(p + 1) process.

To help with this problem of discrimination we de…ne the partial autocor-
relation function - PACF. In general, the correlation between two random
variables is due to both being correlated with a third variable, e.g the correlation
between yt and yt
2 , for an AR(1) process has to come through the correlation
(cid:0)
1 and yt
1 on the one hand and yt
between yt and yt

2 on the other hand.

So the kth partial autocorrelation, (cid:30)k = (cid:30)kk , function measures the corre-

(cid:0)

(cid:0)

(cid:0)

lation not accounted for by an AR(k

1) process.

For an autoregressive process of order p the Yule-Walker equations are given

by the following recursion formulae;

(cid:26)k = (cid:30)1(cid:26)k

1 + (cid:30)2(cid:26)k

(cid:0)

2 + (cid:30)3(cid:26)k

(cid:0)

3 + ::: + (cid:30)p(cid:26)k

(cid:0)

p

(cid:0)

for k = 1; ::::::p.

Then we just need to set k = p or (cid:30)p = (cid:30)kk and solve the following system

of equations.

(cid:26)k = (cid:30)11(cid:26)k

1 + (cid:30)22(cid:26)k

(cid:0)

2 + (cid:30)33(cid:26)k

(cid:0)

3 + ::: + (cid:30)kk

(cid:0)

Then I give values to k that range from 1 to k and generate a system of k

equations in k unknowns.

10

(cid:0)

(cid:26)1 = (cid:30)11(cid:26)0 + (cid:30)22(cid:26)1 + (cid:30)33(cid:26)2 + ::: + (cid:30)kk(cid:26)k
(cid:26)2 = (cid:30)11(cid:26)1 + (cid:30)22(cid:26)0 + (cid:30)33(cid:26)1 + ::: + (cid:30)kk(cid:26)k

(cid:26)k = (cid:30)11(cid:26)k

1 + (cid:30)22(cid:26)k

(cid:0)

2 + (cid:30)33(cid:26)k

(cid:0)

(cid:0)

3 + ::: + (cid:30)kk(cid:26)0

1

2

(cid:0)

(cid:0)

for k = 1
for k = 2

for k = k

And solve the system for (cid:30)kk using kramer’s rule.
In practice, however we are ignorant of the true values of (cid:26)i as well as k (the
order of the autoregressive process), which is of course, the whole problem. As
we will see later, the empirical methodology will consist in trying to …nd which
(cid:30)kk is not signi…cantly di¤erent from zero.

If the process generating the data is of pure moving average form, what
pattern would we expect to …nd for the partial autocorrelation function? Since
an MA process may be written as an AR process of in…nite order, we should
expect a moving average process decays exponentially.

Example AR(1)

(cid:26)k = (cid:30)1(cid:26)k
(cid:0)
(cid:26)1 = (cid:30)11(cid:26)0

1 , then (cid:26)k = (cid:30)11(cid:26)k
for k = 1.

1

(cid:0)

since p = k = 1,

Then

(cid:26)1 = (cid:30)1 = (cid:30)11
(cid:30)ii = 0

for k = 1.
for k > 1.

Example AR(2)

then

(cid:26)k = (cid:30)1(cid:26)k

1 + (cid:30)2(cid:26)k

(cid:0)

2

(cid:0)

(cid:26)k = (cid:30)11(cid:26)k

1 + (cid:30)22(cid:26)k

(cid:0)

2 since p = k = 2,

(cid:0)

Giving values to k we construct the following system of equations

(cid:26)1 = (cid:30)11 + (cid:30)22(cid:26)1
(cid:26)2 = (cid:30)11(cid:26)1 + (cid:30)22

f or k = 1;
f or k = 2;

then

(cid:30)22 =

(cid:26)2
1
(cid:26)2
1

(cid:26)2 (cid:0)
1
(cid:0)

:

11

(cid:30)ii = 0 for k > 2

Summary of Identi…cation rules using ACF and PACf

For an AR(p) Process

(i) the ACF declines exponentially

(ii) the PACF is zero for lags greater than p.

For a MA(q) Process

(i) the ACF is zero for lags greater than q.

(ii) the PACF declines exponentially

Therefore using sample information, we might calculate sample ACF and
PACF to try to identify the right model. These methodology advocated by Box
and Jenkins usually consist of four steps.

(1) Transform the data, if necessary, so that the assumption of covariance

stationarity is a reasonable one.

(2) Make an initial guess of small values of p and q for an ARMA(p; q) model

that might describe the transformed series.

(3) Estimate the parameters in (cid:30)(L) and (cid:18)(L)
(4) Perform diagnostic analysis to con…rm that the model is indeed consistent

with the observed features of the data.

We have up to now assumed (1) holds and described point (2). Now we
are going to explain both the empirical properties of the sample analogs of the
above de…ned parameters and how to estimate these models.

Properties of the correlogram, the PACF and other Sample
Statistics.

The correlogram is the basic tool of analysis in the time domain. An inspec-
tion of the correlogram may lead to the conclusion that the series is random,
or that exhibits a pattern of serial correlation that which perhaps can be mod-
eled by a particular stochastic process. In order to decide which model is best
representing the data, it is necessary to know something about the sampling
properties of the correlogram and related statistics such as the mean and auto-
covariances.

12

Sample analogs for the ACF and PACF function

We have described the autocorrelation and partial autocorrelation function
in terms of the population autocorrelations. These values can be estimated
from a single series. In general this involves to calculate the following sample
moments

The sample mean

The sample mean, ^(cid:22), is an unbiased estimator of the mean of a stationary

process, (cid:22). It is calculated as

T

1
^(cid:22) = T (cid:0)

yt

It can easily be shown that ^(cid:22) is unbiased. It can also be shown that, al-
though it is algebraically demanding, that the sample mean is also a consistent
estimator.

t=1
X

The Sample Variance

T

1
^(cid:13)0 = T (cid:0)

(yt

^(cid:22))2

(cid:0)

t=1
X
The sample Autocovariances.

1
^(cid:13)k = T (cid:0)

T

t=k+1
X

(yt

(cid:0)

^(cid:22))(yt

k

(cid:0)

^(cid:22))

(cid:0)

The sample Autocorrelations

The sample autocorrelation, ^(cid:26)k , is de…ned as the ratio of ^(cid:13)k and ^(cid:13)0 .

^(cid:26)k = ^(cid:13)k=^(cid:13)0

It can be shown that the asymptotic variance of ^(cid:26)k , Avar(^(cid:26)k), is approxi-
mately (1/T ), where T is the sample size. Using this approximation, the stan-
dard deviation is clearly

(1=T ) .

p

Testing for the signi…cance of (cid:26)k

13

In order to identify in practice, using autocorrelation functions, which par-
ticular type of model is the one that best represents the data, we should test
whether the di¤erent parameters (cid:26)k are di¤erent from zero. Under the null hy-
pothesis, i.e. (cid:26)k = 0, ^(cid:26)k is distributed asymptotically (valid for large samples)
Normal with mean zero and variance (1=T ).

Proceeding on this basis, a test may be carried out on the sample auto-
correlation at a particular lag, (cid:28) , by treating pT ^(cid:26)k as a standarised normal
variable. At a …ve percent level of signi…cance, the null hypothesis is rejected if
the absolute value of pT ^(cid:26)k is greater than 1.96.

Testing for the signi…cance of (cid:30)kk

We proceed in a similar way than the one we describe to identify the par-
ticular model using autocorrelation functions. We test whether the di¤erent
parameters (cid:30)kk are di¤erent from zero.

Under the null hypothesis, i.e. (cid:30)kk = 0, is distributed approximately asymp-

totically Normal with mean zero and variance (1=T ).

Unfortunately these identifying tools won’t tell us neither whether the pre-
ferred model is mispeci…ed, nor what to do when two di¤erent models, say
ARMA(1,2) and ARMA(2,1) seem to be equally valid. Therefore we will need
to estimate these models.

Autoregressive models may be estimated simply by OLS but this procedure
is not useful whenever the model has Moving Average terms. To estimate these
models we need to use another procedure.

Maximum Likelihood Estimation

The principle on which estimation of ARMA models will be based is that of

maximum likelihood.

We will present this principle for the simplest case which entails to …nd
estimators of the mean and the variance of a random variable, say X, which
is known to be normally distributed. The vector of population parameters is
((cid:22); (cid:27)2).

The principle may be expressed as follows. Given a sample (x1; x2; :::; xn),
which are the values of the population parameters that have most likely gener-
ated that sample.

We then de…ne the likelihood function as a function of the parameters given

the sample, that is,

((cid:22); (cid:27)2

L

x1; x2; :::; xn) = f (x1
j

(cid:22); (cid:27)2)f (x2
j

(cid:22); (cid:27)2):::::::::::f (xn
j

(cid:22); (cid:27)2)
j

In writing the right hand side as the product of the density functions we have
made use of two assumptions; i) the random variables are identically distributed,
ii) there are independent.

14

We can rewrite the likelihood function as

n

((cid:22); (cid:27)2

L

x1; x2; :::; xn) =
j

i=1
Y
where (cid:5) is the multiplication operator and

f (xi

(cid:22); (cid:27)2)
j

f (xi

(cid:22); (cid:27)2) =
j

1
p2(cid:25)(cid:27)

1
2

e(cid:0)

(cid:22))2

(xi(cid:0)
(cid:27)2

n

=

1
p2(cid:25)(cid:27)

1
2

e(cid:0)

(cid:22))2

(xi(cid:0)

(cid:27)2 = (

1
p2(cid:25)(cid:27)

)ne(cid:0)

1
2

(cid:22))2

i=1
P

(xi(cid:0)
(cid:27)2

Notice that

n

i=1
Y

The Maximum likelihood estimators, ^(cid:22) and ^(cid:27)2, are designed to maximize the
likelihood that the sample comes from a normal distribution with parameters
(cid:22) and (cid:27)2. To …nd them optimally we just di¤erentiate the likelihood function
with respect to (cid:22) and (cid:27)2.

Notice that if we make a monotonic transformation of the likelihood func-
tion, the optimal values are not a¤ected by the transformation. Sometimes is
algebraically easier to maximize the logarithm of the maximum likelihood, that
is

log(

((cid:22); (cid:27)2

L

x1; x2; :::; xn)) =
j

(cid:0)

Optimization

n
2

n

log(2(cid:25))

(cid:0)

nlog((cid:27))

n

(xi

(cid:0)
2(cid:27)2

i=1
P

(cid:0)

(cid:22))2

@log(
@(cid:22)

)
L

=

i=1
P

(cid:22))2

(xi

(cid:0)
(cid:27)2

n

= 0

(cid:22))2

= 0

@log(
@(cid:27)

)
L

=

n
(cid:27)

(cid:0)

+

i=1
P

(xi

(cid:0)
(cid:27)3

This system gives as solutions

n

xi

^(cid:22) =

i=1
P
n

(cid:22))2

n

i=1
P

(xi

(cid:0)
n

^(cid:27)2 =

15

Conditional Maximum Likelihood Estimates

Usually when we estimate ARMA(p; q) models we evaluate the conditional
maximum likelihood. What is meant by conditional is that we assume that the
…rst max(p; q) observations are known. In practice we maximize the likelihood
usually by numerical procedures.

For example for an AR(1) process

yt = (cid:30)1yt

1 + "t

(cid:0)

t = 1; 2; T

We then assume the log of joint distribution of yT ; yT

on the value of y1 .

1; :::; y2 conditional

(cid:0)

f (yT ; yT

1; :::; y2

(cid:0)

y1; (cid:30)1; (cid:27)2) =
j

the objective then being to maximize

f (yi

yi
j

1; (cid:30)1; (cid:27)2)
(cid:0)

T

i=2
Q

=

(T

1)log(2(cid:25)):5

(T

1) log (cid:27)

(cid:0)

(cid:0)
We maximize this function by numerical procedures and obtain ^(cid:30)1, ^(cid:27)2.

(cid:0)

(cid:0)

(cid:0)

T

(yt

t=2
P

(cid:0)
2(cid:27)

(cid:30)1yt

1)2

(cid:0)

:

The ”Portmanteau” statistic.

The …nal step in the Box - Jenkins methodology is to perform diagnostic
analysis to con…rm that the model is indeed consistent with the observed features
of the data. If the model that we identi…ed is the right one, the residuals of the
estimated are supposes to be white noise. The most common test for whiteness
of the residuals is the ”Box and Pierce”test which makes use of the Q statistic.

The ”Portmanteau” statistic, Q, de…ned as

Q(cid:3)(k) = T

k

^(cid:26)2
i

it can be shown to be asymptotically distributed, under the null hypothesis

i=1
X

that yt is a white noise, chi square with k degrees of freedom.

^", then Q(cid:3)(k) is distributed (cid:31)2(k

If the test is applied to the residuals of an estimated ARMA(p; q) model, say
q).
This statistic has bad small sample properties. A better approximation is

(cid:0)

(cid:0)

p

obtained by modifying the statistic in the following way.

Q(k) = T (T + 2)

(T

k

i)(cid:0)

1^(cid:26)2
i

(cid:0)

i=1
X

This statistic is the one reported in the econometric package EVIEWS
.

16

The use of model Selection Criteria.

The model selection criteria is a set of rules that will help us to discriminate
between alternative ”successful”models. That is, it might be that we end with
two alternative models that ”pass” all the relevant test and I need to somehow
to decide between them. The most used criteria are

The Akaike Criteria (AIC)

AIC(p; q) = log ^(cid:27)2 + 2(p + q)T (cid:0)
1

The Schwarz Criteria (BIC)

BIC(p; q) = log ^(cid:27)2 + (p + q)T (cid:0)

1 log(T )

These criteria are used as follows; whenever we have two di¤erent models
that seem to be equally good we choose the model which has smallest AIC or
BIC.

Forecasting with Time-Series Models

When we introduced the concept of stochastic process as models for time
series at the beginning of the course, it was with the ultimate objective of using
the models to infer from the past history of a series its likely course in the future.
More precisely we want to derive from a model the conditional distribution of
future observations given the past observations that it implies. This …nal step in
the model building process is what we refer loosely as forecasting. It should be
noted that in practice the model in hand is never the hypothetical ”true”process
generating the data we have observed. Rather, it is an approximation to the
generating process and is subject to errors in both identi…cation and estimation.
Thus, although we shall discuss forecasting as if we knew the generating process,
it is clear that our success in practice will depend in part on the adequacy of our
empirical model and therefore on success in the preceding stages of identi…cation
and estimation.

Minimum Mean-square-error Forecasts

The main motivation for beginning the discussion about forecasting with the
conditional expectation is that in many operational contexts it is desirable to be
able to quote a point forecast, a single number, and the conditional expectation
has the desirable property of being the minimum mean square error forecast.
That is, if the model is correct, there is no other extrapolative forecast which
will produce errors whose squares have smaller expected value.

Although we have not discussed how conditional expectations are computed,

this general result is easily demonstrated as follows.

Given the availability of a set of observations up to, and including yT , the
optimal predictor l steps ahead is the expected value of yt+l conditional on the
information at time t = T . This may be written as

17

yt+l

j

T = E(cid:3)(yt+l

IT )
j

The predictor is optimal in the sense that has minimum mean square error.
b
This is easily seen by observing that for any predictor, E(yt+l
IT ), constructed
j
on the basis of the information available at time T , the forecasting error can be
split into parts:

(cid:0)

yt+l

yt+l

T = [yt+l

IT )] + [E(yt+l
j
Since the second term on the right hand side is …xed at time T , it follows
b
that, on squaring the whole expression and taking expectations at time T , the
cross-product term disappears leaving.

E(yt+l

IT )
j

yt+l

T ]

(cid:0)

(cid:0)

b

j

j

M SE(

yt+l

j

T ) = V ar(yt+l

T ) + [

yt+l

j

T (cid:0)

j

E(yt+l

IT )]2
j

In the …rst term on the right hand side, the conditional variance of yt+l ,
T . Hence the minimum mean square estimate (MMSE)

does not depend on
of yt+l is given by the conditional mean and it is unique.

b
yt+l

b

j

b

Computation of Conditional Expectation
Forecasts

One-Step-Ahead Forecasts
We now consider the question of how to construct an MMSE of a future
observation from an ARMA process, given observations up to and including
time T . The ARMA process is assumed to be stationary and invertible, with
known parameters and independent disturbances with mean zero and constant
variance (cid:27)2.

The equation of an ARMA(p; q) model at time T+1 is

yT +1 = (cid:30)1yT + (cid:30)2yT

1 + ::::: + (cid:30)pyT

p+1+

"T +1 + (cid:18)1"T + (cid:18)2"T

1 + ::: + (cid:18)q"T

(cid:0)

(cid:0)

(cid:0)

q+1

(cid:0)

then

yt+1

j

T = (cid:30)1yT + (cid:30)2yT
(cid:18)1"T + (cid:18)2"T

1 + :::: + (cid:30)pyT
(cid:0)
1 + ::: + (cid:18)q"T

(cid:0)
q+1

p+1+

(cid:0)
Since all variables with time subscripts through period T have been realised
IT ) = 0.
j
yt+l

b
(are no longer random) and E("T +1
For the numerical evaluation of

T from the above equation we need a

(cid:0)

value for the disturbances.

b

j

Optimal predictions for ARMA models

18

We now consider the question of how to construct an MMSE of a future
observation from an ARMA process, given observations up to and including
time T . The ARMA process is assumed to be stationary and invertible, with
known parameters and independent disturbances with mean zero and constant
variance (cid:27)2.

The equation of an ARMA(p; q) model at time T + l is

yT +l

j

b

T = (cid:30)1

yT +l

1

T + (cid:30)2
j
T + (cid:18)1^"T +l

(cid:0)

T + :::: + (cid:30)p

yT +l

2

(cid:0)

j
T + (cid:18)2^"T +l

(cid:0)
T + ::: + (cid:18)q^"T +l

T +

p
j

2

(cid:0)

j

yT +l
1
(cid:0)
b

j

"T +l
b

j

q

(cid:0)

l = 1; 2; :::::

Where
yT +j

j

T = yT +j

for j

0 and ^"T +j

T =

j

(cid:20)

(cid:26)

for j > 0
for j
0

(cid:20)

:

the future observations.

This expression provides a recursion for computing optimal predictions of
b
Example 1 For the AR(1) process

b

0
"t+j

yT +l = (cid:30)1yT +l

1 + "T +l

(cid:0)

at time T + l

b
be solved to yield
1yT

T = (cid:30)l

yT +l

T = (cid:30)1

yT +l

(cid:0)
The starting value is given by

j

1

T

j
yT

l = 1; 2; ::::::

T = yT , and so the previous equation may

j

b

yT +l
thus the predicted values decline exponentially towards zero, and the forecast

b

j

function has exactly the same form as the autocovariance function.

b
Let us calculate the forecast error for this process

yT +l

yT +l

j

(cid:0)

b

T = (cid:30)1yT +l
= (cid:30)l

1 + "T +l

(cid:0)

(cid:0)

(cid:30)l
1yT

1yT + "T +l + (cid:30)1"T +l

1 + (cid:30)2
(cid:0)

1"T +l

2 + ::: + (cid:30)l
(cid:0)
1
(cid:0)

1

"T +l

(cid:30)l
1yT

(cid:0)

Then, the variance of the forecast error l periods ahead is given by

V (yT +l

yT +l

j

(cid:0)

b

T ) = V ("T +l + (cid:30)1"T +l

= (1 + (cid:30)2

1 + (cid:30)4

1 + (cid:30)2
(cid:0)
1 + ::: + (cid:30)2(l

1

2 + ::: + (cid:30)l
1"T +l
(cid:0)
1
(cid:0)
1)
)(cid:27)2

(cid:0)

1

"T +l)

Note that the variance of the forecast error increases (nonlinearly) as l be-

comes large.

Example 2
At time T + 1, the equation for an MA(1) process is of the form

yT +1 = "T +1 + (cid:18)1"T

19

Then in general

yT +l

j

T = ^"T +l

j

T + (cid:18)1^"T +l

1

(cid:0)

T

j

b
yT +l

j

T = (cid:18)1"T
= 0

f or l = 1

f or l > 1:

The variance of the forecast error for a MA(1) is

b

V (yT +l

yT +l

j

(cid:0)

T ) = (cid:27)2

= (1 + (cid:18)2

1)(cid:27)2

for l = 1
for l > 1

Thus the forecast error variance is the same for a forecast 2, 3, etc periods

b

ahead, etc.

The ARMA(1,1) Process

yt = (cid:30)1yt

1 + "t + (cid:18)1"t

(cid:0)

1

(cid:0)

yT +l

j

b

T = (cid:30)1yT + (cid:18)1"T
yT +l
T
1
j
(cid:0)
1yT + (cid:30)l
1
1 (cid:18)1"T
(cid:0)
b

= (cid:30)1
= (cid:30)l

(derive the MSE of the forecast as before).

for l = 1
for l > 1

Measuring the Accuracy of Forecasts

Various measures have been proposed for assessing the predictive accuracy
of forecasting models. Most of these measures are designed to evaluate ex-post
forecasts. The most well known are
The Root Mean Squared Error

RM SE =

1
l

T +l

i=T +1
X

v
u
u
t

b

Yi
(

(cid:0)

Yi)2

where l is the number of periods being forecasted
The Mean Absolute Error.

M AE =

1
l

T +l

i=T +1
X

Yi
j

Yi

j

(cid:0)

b

20

Which indicator should be used depends of the purpose of the forecasting

exercise. The RMSE will penalize big errors more than the MAE measure.

Consider the following two models, say 1 and 2. Assume model 1 forecasts
accurately most of the time but performs very badly for an unusual observation.
On the other hand assume that model 2 forecasting performance is poor most of
the time but predicts the unusual observation with small error. Comparing the
forecasting performances of these models whenever we use the RMSE indicator
we would probably favour model 2, and favour model 1 when the MAE criteria
is used. In this extreme experiment the preferred model depends very much on
the preferences of the user, that is whether she prefers to forecast most of the
time poorly but get right the unusual observation ( e.g. a devaluation of the
currency) or have most of the time a good forecast even if forecasts completely
bad the unusual observation ( buy pounds on tuesday before black Wednesday).

Appendix 1

White’s Theorem

Theorem 1 If
and

Yt
f

1t=1 is a martingale di¤ erence sequence with Y T =
g

1
T

Yt

P

(cid:15)

(cid:15)

(cid:15)

(cid:27)2

P
!
r exist for r
j

2

(cid:21)

E(Y 2

t ) = (cid:27)2

t with (cid:27)2
t

The moments E

Yt
j

Y 2
t

(cid:27)2

P
!

1
T

P

then it can be shown that pT Y T ~ N (0; (cid:27)2):

Consider now the following in…nite moving average representation for Yt,

1

Yt =

 j"t

j;

(cid:0)

j=0
X

with E("t) = 0; E("2
k > 0: Then, Xt is a martingale di¤erence (if "t is iid; "t"t
di¤erence) with variance E(X 2

t ) = (cid:27)2; and de…ne the randomvariable Xt = "tYt
(cid:0)

k for
1 is a martingale
t )E(Y 4
t ) <

t ) and fourth moment E("4

t ) = (cid:27)2E(Y 2

(cid:0)

:

1

Now if we can prove that

1
T

X 2
t

P
!

tions of the White theorem and can use that pT X T =

P

or alternatively

21

E(X 2

t ) we would be under the condi-

Xt~N (0; E(X 2

t )):

1
pT

P

1
pT

"tYt

k~N (0; (cid:27)2E(Y 2
(cid:0)

t ))

Proposition 2

1
T

X 2
t

P
!

X
E(X 2

t ) :

P

Proof. To prove proposition …rst note that
1
1
T
T

("2

P
!

t (cid:0)
(i) ("2

P

t (cid:0)
and therefore

k

k +

(cid:27)2E(Y 2

(cid:27)2Y 2
t
(cid:0)

(cid:27)2)Y 2
t
(cid:0)
(cid:27)2)Y 2
k is a martingale di¤erence with …nite second moments
t
(cid:0)
1
("2
T

(cid:27)2)Y 2
t
(cid:0)

P
!

P

P

P

0;

k

X 2

t =

t Y 2
"2
t
(cid:0)
t ):This results arise since

k =

1
T

1
T

(ii)

1
T

Then, it follows that

P

t (cid:0)
P
!

k

P
(cid:27)2Y 2
t
(cid:0)
1
T

(cid:27)2E(Y 2

t ):

X 2
t

P
!

(cid:27)2E(Y 2

t ) = E(X 2

t ):

Asymptotics of an AR(p) process.

P

Consider an autoregressive process

xt = (cid:22) + (cid:30)1xt

1 + (cid:30)2xt

2 + ::: + (cid:30)pxt

p + "t

(cid:0)

(cid:0)

(cid:0)

We may write the standard autoregressive model in regression notation

yt = zt(cid:12) + ut

zt =

where yt = xt;
2; :::xt
Here we cannot assume ut is independent of zt+1 , although is independent
of zt . Without this we cannot apply any of the small sample results and have
to rely on asymptotic results.

1; xt
f

, etc.

1; xt

g0

(cid:0)

(cid:0)

(cid:0)

p

Consider the OLS estimator of (cid:12): Then we can write

pT (bT

(cid:0)

(cid:12)) = ((1=T )

ztz0t)(cid:0)

1((1=pT )

ztut)

X

X

where

((1=T )

ztz0t)(cid:0)

1 = 2

1

1
T (cid:0)

1
T (cid:0)
1
T (cid:0)

xt

1

(cid:0)

xt
(cid:0)
x2
t
(cid:0)

1

1

:
P

P
:
P
xt

xt
1
(cid:0)
1xt

(cid:0)

p

(cid:0)

1

(cid:0)

3

1
:
T (cid:0)
1
: T (cid:0)
:
:

P
1
T (cid:0)

xt
P
:

X

1
T (cid:0)

xt

1
p T (cid:0)

7
7
5
The elements of the …rst row converge in probability to (cid:22) = E(xt) and
1
T (cid:0)

j converges in probability to E(xt

6
6
4

ixt

ixt

P

P

xt

j) = (cid:13)i

(cid:0)

(cid:0)

(cid:0)

p

1

x2
t
(cid:0)

pxt

ztz0t)(cid:0)

1 converges in probability to Q(cid:0)

1, with the elements

(cid:0)

(cid:0)

P
j + (cid:22)2
(cid:0)

(cid:0)
Then ((1=T )
P

(cid:0)

of Q de…ned as above.

P

22

For the second term ztut is a martingale di¤erence with positive de…nite

variance covariance given by E(ztututz0t) = E(u2

t )E(ztz0t) = (cid:27)2Q:

Then using standard arguments

((1=pT )

N (0; (cid:27)2Q)

ztut) L
(cid:0)!

(notice that p lim 1
T

X
tors with E(ztut) = 0 (a martingale di¤erence) and (ztututz0t) = E(u2
(cid:27)2Q:)

var(ztut) = (cid:27)2Q since ztut sequence of random vec-
t )E(ztz0t) =

P

Then it follows that

pT (bT

ztz0t)(cid:0)

1 P
!

(since ((1=T )

N (0; (cid:27)2Q(cid:0)

1):)

P

N (0; (cid:27)2Q(cid:0)

1)

(cid:12)) L
(cid:0)!
1 and pT (bT

(cid:0)
Q(cid:0)

(cid:12)) = (1=T )

(cid:0)

ztz0t)(cid:0)

1((1=pT )

P

ztut) L
(cid:0)!

P

N (0; (cid:27)2Q(cid:0)

1
1QQ(cid:0)

0) =

For an AR(1).

yt = (cid:30)1yt

1 + "t

Then Q = E(y2
1) = (cid:13)0 = (cid:27)2=(1
t
(cid:0)
and

pT (^(cid:30)T (cid:0)

(cid:30)) L
(cid:0)!

N (0; (cid:27)2((cid:27)2=(1

(cid:0)

(cid:0)
(cid:30)2):

(cid:0)
(cid:30)2))(cid:0)

1) = N (0; (1

(cid:30)2))

(cid:0)

Appendix 2

Forecasts based on Linear Projections and Updating these Projec-

tions.

Consider

Then, if

P (YT +1

Xt) = (cid:11)
j

0

Xt

Xt)X 0t] = 0;
0
Xt is called a linear projection of Yt+1 on Xt .

E[(Yt+1

(cid:0)

(cid:11)

(cid:11)

0

Properties of linear projections

(i) E(Yt+1X 0t) = (cid:11)

E(XtX 0t)
0

then
(cid:11)

0

1
= E(Yt+1X 0t)(E(XtX 0t))(cid:0)

(ii) The mean square error associated with a linear projection is given by
1E(XtYt+1) (once

Xt)2 = E(Yt+1)2

E(Yt+1Xt)(E(XtX 0t))(cid:0)

E(Yt+1
we substitute and rearrange terms)

(cid:0)

(cid:0)

(cid:11)

0

23

(iii) If Xt includes a constant, then projection of aYt+1 + b on Xt

P (aYt+1 + b

Xt) = aP (Yt+1
j

Xt) + b
j

Updating a linear Projection and Triangular Factorizations
a) Triangular Factorizations

Consider the following Matrix
(cid:10)11 (cid:10)12 (cid:10)13
(cid:10)21 (cid:10)22 (cid:10)23
(cid:10)31 (cid:10)32 (cid:10)33

(cid:10) =

3

2

4

Assume (cid:10) is symmetric.
1
Now multiply the …rst row by (cid:10)21(cid:10)(cid:0)

5

11 and subtracting the result from the
1
second row it yields a zero in (2; 1), while multiplying the …rst row by (cid:10)31(cid:10)(cid:0)
11 and
subtracting the result from the third row it yields a zero in (3; 1)

Then if we pre-multiply by

E1 =

1
1
(cid:10)21(cid:10)(cid:0)
11
1
(cid:10)31(cid:10)(cid:0)
11

(cid:0)
(cid:0)

2

4

0 0
1 0
0 1 3
5

= H

3

5

(cid:10)11
0

0

(cid:10)12

1
11 (cid:10)12
(cid:10)22-(cid:10)21(cid:10)(cid:0)

(cid:10)13

1
11 (cid:10)13
(cid:10)23-(cid:10)21(cid:10)(cid:0)

1
11 (cid:10)12
(cid:10)32-(cid:10)31(cid:10)(cid:0)
}
|

h22

{z
h32

1
11 (cid:10)13
(cid:10)33-(cid:10)31(cid:10)(cid:0)
|
}

h23

{z
h33

3

7
7
7
7
7
5

E1(cid:10) =

2

6
6
6
6
6
4

Then

E1(cid:10)E01 =

2

|
(cid:10)11
0
0

{z

}

|

{z

}

0

0

1
(cid:10)22-(cid:10)21(cid:10)(cid:0)
1
(cid:10)32-(cid:10)31(cid:10)(cid:0)

1
11 (cid:10)13
11 (cid:10)12 (cid:10)23-(cid:10)21(cid:10)(cid:0)
1
11 (cid:10)13
11 (cid:10)12 (cid:10)33-(cid:10)31(cid:10)(cid:0)

4
h11
0
0

0
0
h22 h23
h32 h33

3

H =

2

4

E2 =

Repeating the same line of reasoning let de…ne
5
0
0
1 3
5

1
0
1
0 -h32h(cid:0)
22

0
1

2

4

E2H =

and

2

4

h11
0
0

0
h22
0

0
h23

1
22 h23
h33-h32h(cid:0)

3

5

24

E2HE02 =

h11
0
0

2

0
h22
0

0
0

1
22 h23
h33-h32h(cid:0)

= D

3

Then (cid:10) can always been written in the following way (cid:10) = ADA
0

5

where

4
1
1
1 = E(cid:0)
2 :
1 E(cid:0)

A = (E2E1)(cid:0)
Where

1
E(cid:0)
1 =

1
E(cid:0)
2 =

2

4

2

4

1
1
(cid:10)21(cid:10)(cid:0)
11
1
(cid:10)31(cid:10)(cid:0)
11

;

0 0
1 0
0 1 3
5

0
1

1
0
1
0 h32h(cid:0)
22

0
0
1 3
5

1
1
(cid:10)21(cid:10)(cid:0)
11
1
(cid:10)31(cid:10)(cid:0)
11

0
1
1
h32h(cid:0)
22

A =

2

4

and

0
0
1 3
5

Updating a Projection

Let Y =

Y1; Y2; :::Yn
f

g

is

0be a vector of random variables whose second moment

(cid:10) = E(Y Y 0)
Let (cid:10) = ADA0 be a triangular factorization of (cid:10) and de…ne W
W = A(cid:0)
Then E(W W 0) = D, and the W are random variables which are uncorre-

1Y

lated.

Consider n = 3
Then

1
1
(cid:10)21(cid:10)(cid:0)
11
1
(cid:10)31(cid:10)(cid:0)
11

2

0
1
1
h32h(cid:0)
22

The …rst equation states

4

W1
W2
W3

0
0
1 3
5

2

4

Y1
Y2
Y3

3

5

=

3

5

2

4

W1 = Y1
1
The second equation (cid:10)21(cid:10)(cid:0)

11 and
using the …rst equation we have E(W2W1) = 0 (because of the orthogonaliza-
tion) = E((Y2

1
11 W1 + W2 = Y2 , and de…ning (cid:11) = (cid:10)21(cid:10)(cid:0)

(cid:11)Y1)Y1) = 0.

Then the triangular factorization can be used to infer the coe¢ cient of a lin-
ear projection. In general row i of A has the interpretation of a linear projection
of Yi on Y1 .

(cid:0)

Then W2 has the interpretation of the residual of a linear projection of Y2

1
on Y1 so its MSE is E(W2W 02) = D22 = (cid:10)22-(cid:10)21(cid:10)(cid:0)
11 (cid:10)12

The third equation states that
1
(cid:10)31(cid:10)(cid:0)

1
11 W1 + h32h(cid:0)

22 W2 + W3 = Y3

25

1
11 Y1
(cid:10)31(cid:10)(cid:0)

or
W3 = Y3
Thus W3 is the residual of subtracting some linear combination of Y1 and
Y2 from Y3 , and this residual is uncorrelated by construction with either W1 or
W2 , E(W3W1) = E(W3W2) = 0.

1
11 Y1)
(cid:10)21(cid:10)(cid:0)

1
h32h(cid:0)
22 (Y2

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

1
(cid:10)21(cid:10)(cid:0)

1
11 Y1
(cid:10)31(cid:10)(cid:0)

1
h32h(cid:0)
22 (Y2

Then
E[(Y3
Then the linear projection is
1
1
22 (Y2
11 Y1 + h32h(cid:0)
Y2; Y1) = (cid:10)31(cid:10)(cid:0)
P (Y3
j
1
with M SE = D33 = h33-h32h(cid:0)
22 h23
This last expression gives a convenient formula for updating a linear pro-
jection. Suppose we want to forecast Y3 and have initial information about Y1
.

1
11 Y1)
(cid:10)21(cid:10)(cid:0)

11 Y1))Wi]

i = 1 or 2:

(cid:0)

(cid:0)

1
11 Y1:
Y1) = (cid:10)31(cid:10)(cid:0)
j

Then
P (Y3
Let Y2 represent some new information with which we want to update the
forecast. If we where just asked the magnitude of Y2 on the basis of Y1 alone
we get

1
11 Y1:
Y1) = (cid:10)21(cid:10)(cid:0)
j

P (Y2
On the other hand we know that
1
1
P (Y3
22 (y2
11 Y1 + h32h(cid:0)
Y1; Y2) = (cid:10)31(cid:10)(cid:0)
j
Then

1
11 Y1)
(cid:10)21(cid:10)(cid:0)

(cid:0)

P (Y3

Y1; Y2) = P (Y3
j

1
22 (y2
Y1) + h32h(cid:0)
j

(cid:0)

P (Y2

Y1))
j

so we can thus optimally update the forecast P (Y3

1
multiple h32h(cid:0)

22 of the unanticipated component of the new information.

Y1) by adding to it a
j

Notice that h22 = E(Y2

Y1))2 and h32 = E(Y2
P (Y2
j
Y1)); then the projection formulae might be written as.
j

(cid:0)

P (Y3

P (Y2

Y1))(Y3
j

(cid:0)

(cid:0)

+E(Y2

P (Y2

Y1))(Y3
j

(cid:0)

(cid:0)

P (Y3
P (Y3

Y1; Y2) = P (Y3
j
Y1)):(E(Y2
j

(cid:0)

Y1)
j
P (Y2

Y1))2)(cid:0)
j

1(Y2

P (Y3

Y1)):
j

(cid:0)

26

Vector Autoregressions

A vector autoregressive (VAR) is simply an autoregressive process for a

vector of variables.

Let us de…ne Wt =

Then a VAR(1) may be written as

xt
yt

(cid:20)

, a matrix A2X2 and "t =
(cid:21)

"1t
"2t

:

(cid:21)

(cid:20)

or

where

Wt = AWt

1 + "t

(cid:0)

xt = a11xt

1 + a12yt

1 + "1t;

yt = a21xt

1 + a22yt

1 + "2t;

(cid:0)

(cid:0)

(cid:0)

(cid:0)

E("t) = 0;

E("t"0s) =

(cid:10) t = s ((cid:10) = (cid:10)0; c0(cid:10)c > 0; c
0

otherwise.

= 0);

(cid:26)

VAR(p)

Wt = A1Wt

1 + A2Wt

2 + ::: + ApWt

p + "t

(cid:0)

(cid:0)

(cid:0)

or

(I

(cid:0)

A1L

(cid:0)

A2L2

:::

(cid:0)

(cid:0)

ApLp)Wt = "t

The VAR is covariance stationary if all the values of L satisfying
A2L2

= 0 lie outside the unit circle1.

ApLp

:::

(cid:0)

(cid:0)

j

I
j

(cid:0)

A1L

(cid:0)

The Autocovariance Matrix

For a covariance stationary n dimensional vector process we may de…ne the

autocovariance function for a VAR in a way similar to the univariate case

(cid:0)k (nxn) = E(WtW 0t
(cid:0)

k) where (cid:0)k(ij) = cov(Wi;t; Wj;t

k)

(cid:0)

Using the above two variables VAR we get the following

1 For the VAR(1) example with 2 variables this is equivalent to say that the real part both

roots in L are greater than 1.

1
0

0
1

(cid:0)

a11
a21

a12
a22

L

= 0

(cid:20) (cid:18)
(cid:19)
(a11 + a22)L + (a11a22

(cid:18)

(cid:19)
a12a21)L2 = 0

(cid:21)

(cid:0)

Det

or
1

(cid:0)

1

6
(cid:0)k (nxn) = E(WtW 0t
(cid:0)

k) =

E(xtxt
E(ytxt

k) E(xtyt
k) E(ytyt

k)
k)

(cid:0)

(cid:0)

Contrary to the univariate case (cid:0)k

(cid:0)
k , instead the correct relationship
(cid:0)
k. This can be easily understood looking at the simple bivariate case

(cid:0)

(cid:20)
= (cid:0)

(cid:21)

is (cid:0)0k = (cid:0)
where there is no reason why E(xtyt

(cid:0)

1) should be equal to E(xt

1yt).

(cid:0)

(cid:0)

Proof
i) Leading the vector k times we obtain

(cid:0)k (nxn) = E(Wt+kW 0t )

ii) Taking transposes

(cid:0)0k (nxn) = E(WtW 0t+k) = (cid:0)

k

(cid:0)

In terms of our two variables example

(cid:0)k (nxn) =

(cid:20)

E(xtxt
E(ytxt

k) E(xtyt
k) E(ytyt

(cid:0)

(cid:0)

k)
k)

(cid:0)

(cid:0)

(cid:0)0k (nxn) =

(cid:20)

E(xtxt
E(xtyt

k) E(ytxt
k) E(ytyt

(cid:0)

(cid:0)

k)
k)

(cid:0)

(cid:0)

(cid:21)

Leading k periods
=

(cid:20)

z}|{
E(xtxt+k) E(xtyt+k)
E(ytxt+k) E(ytyt+k)

:

(cid:21)

(cid:0)

k (nxn) =

(cid:0)

(cid:20)

;

(cid:21)

E(xt+kxt) E(yt+kxt)
E(xt+kyt) E(yt+kyt)

;

(cid:21)

Autocovariance Function

We can now calculate the autocovariance function for a VAR more or less in
the same way we did for the univariate process. Assume for simplicity that we
have a …rst order VAR.

Then the autocovariance function can be derived as

(cid:0)k (nxn) = E(WtW 0t
(cid:0)
1

then we obtain that for k

(cid:21)

k) = AE(Wt

1W 0t
(cid:0)

k) + E("tW 0t
(cid:0)

k)

(cid:0)

(cid:0)k (nxn) = A(cid:0)k

1:

(cid:0)

When k = 0 we can simply notice that

E(WtW 0t ) = AE(Wt

1W 0t
(cid:0)

(cid:0)

1)A0 + E("t"0t)

or

2

6
(cid:0)0 = A(cid:0)0A0 + (cid:10)

To obtain (cid:0)0 we use the fact that vec(ABC) = (C 0

A)vec(B), then

(cid:10)

vec((cid:0)0) = vec(A(cid:0)0A0) + vec((cid:10)) = (A

A)vec((cid:0)0) + vec((cid:10));

(cid:10)

or

vec((cid:0)0) = (I(np)2

(A

A))(cid:0)

1vec((cid:10)):

(cid:0)
The Companion Form

(cid:10)

Notice that a VAR(p) may always be re-written as a VAR(1) by de…ning a

vector Ht such that

Ht = F Ht

1 + (cid:23)t

(cid:0)

where

Ht =

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

xt
yt
:
xt
i
(cid:0)
yt
i
(cid:0)
:

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

A2
0
I2
0

2

(cid:2)

A1
I2

2

(cid:2)

0

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

; F = 2
6
6
6
6
4

j
j

I2

2

(cid:2)

j

Ap
0

0
0

I

3

7
7
7
7
5

and (cid:23)t =

"1t
"2t
:
0
0
0
0

2

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
5

Then, the VAR in the Companion form can be expressed in the following

way

Ht = F Ht

1 + (cid:23)t

(cid:0)

E((cid:23)t(cid:23)0t) =

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

(cid:10) 0
:
0
:
:
0
0

0

::: 0

::: 0

3

7
7
5

Notice also that the following relationships holds:

E(HtH 0t) = F E(Ht

1H 0t

1)F 0 + Q

(cid:0)

(cid:0)

3

or

where

(cid:6) = F (cid:6)F 0 + Q

where (cid:6) = E(HtH 0t).

(cid:0)0
(cid:0)01

(cid:0)1
(cid:0)0

(cid:6) = 2

::: (cid:0)p
(cid:0)p

1

2

(cid:0)

(cid:0)

and (cid:0)p is the autocovariance of the original process.

(cid:0)0p

1 (cid:0)0p

(cid:0)

2

(cid:0)

(cid:0)0

6
6
4

3

7
7
5

If the process is covariance stationary, then the unconditional variance can

be calculated simply using vec operators, i.e.,

vec((cid:6)) = vec(F (cid:6)F 0) + vec(Q) = (F

F )vec((cid:6)) + vec(Q);

(cid:10)

(Since vec(ABC) = (C 0

A)vec(B))

(cid:10)

Then the unconditional variance can be obtained as

vec((cid:6)) = (I(np)2

(F

(cid:0)

(cid:10)

F ))(cid:0)

1vec(Q):

(NB F
form (cid:21)j(cid:21)i , and we knew that all

F has no unit eigen values since the eigen values of F
(cid:21)i
j

< 1)

(cid:10)

j

F are of the

(cid:10)

Notice as well that the jth autocovariance function of H (denoted (cid:6)j) can

be found by post-multiplying by H 0t

j and taking expectations.

(cid:0)

E(HtH 0t

j) = F E(Ht

1H 0t

j) + E((cid:23)tH 0t

j)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

Thus

or

(cid:6)k = F (cid:6)k

1

(cid:0)

for k = 1; 2; :::

(cid:6)k = F k(cid:6):

The kth autocovariance (cid:0)k of the original process Wt is given by the n …rst

rows and n columns of (cid:6)k = F (cid:6)k

1:

(cid:0)

(cid:0)k = A1(cid:0)k

1 + A2(cid:0)k

(cid:0)

2 + :::: + Ap(cid:0)k

(cid:0)

p

(cid:0)

k = p; p + 1; p + 2; :::::::

4

Maximum likelihood Estimation.
The Conditional likelihood for a vector autoregression.

Let Wt denote an (n

1) vector containing the values that n variables take

at time t. Wt is assumed to follow a pth order gaussian VAR.

(cid:2)

Wt = A1Wt

1 + A2Wt

2 + ::::::: + ApWt

p + "t

"t~N (0; (cid:10));

(cid:0)

(cid:0)
where both (cid:10) and Ai are n
Suppose that we observe these variables for T + p time periods. The ap-
p+1 ) and to base

proach is to condition on the …rst p observations (W0; :::W
the estimation on the last T observations (WT ; ::::::W1).

n matrices of parameters.

(cid:0)

(cid:2)

(cid:0)

f (WT ; WT

1; WT

(cid:0)

2::::W1

(cid:0)

W0; :; W
j

p+1; (cid:2))

(cid:0)

and maximize with respect to (cid:2), where (cid:2) is a vector that contains the elements
of A1; A2; A3; ::::Ap and (cid:10).

Then

Wt

Wt
j

(cid:0)

1; Wt

2; :::W

p+1~N ((A1Wt

1 + A2Wt

2 + ::::::: + ApWt

(cid:0)

(cid:0)

(cid:0)

(cid:0)

p)n

1; (cid:10)n

n)

(cid:2)

(cid:2)

(cid:0)

It will be convenient to stack the p lags in a vector xt;.

xt =

1

Wt

(cid:0)
nx1
Wt
2
| {z }
(cid:0)
nx1
:
| {z }
Wt
p
(cid:0)
nx1

| {z }

2

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
5

np

1

(cid:2)

and let (cid:5)0 denote the following n

np matrix ; (cid:5)0 = [A1; A2; A3; ::::Ap]n

then we can write the conditional mean as (cid:5)0xt .

(cid:2)

np;

(cid:2)

Using this notation, we can write the conditional distribution of Wt as
Wt
j

p+1~N ((cid:5)0xt; (cid:10))

2; :::W

1; Wt

(cid:0)

(cid:0)

(cid:0)

Wt

Wt
f (Wt
j
n=2
= (2(cid:25))(cid:0)

1; Wt
(cid:0)
1
(cid:10)(cid:0)
j

(cid:0)
:5 exp[(
j

2::::W1; W0; ::; W

1=2)(Wt

1(Wt

(cid:5)0xt)]

p+1; (cid:2))
(cid:0)
(cid:5)0xt)0(cid:10)(cid:0)

(cid:0)
The joint density conditional on the …rst p observations can be written as

(cid:0)

(cid:0)

f (WT ; WT
T

1; WT

(cid:0)

2::::W1

(cid:0)

W0; :; W
j

p+1; (cid:2))

(cid:0)

=

f (Wt

t=1
Y

Wt
j

(cid:0)

1; Wt

2::::; W

(cid:0)

p+1; (cid:2))

(cid:0)

5

and taking logs,

T

L((cid:2)) =

log[f (Wt

t=1
X

Wt
j

(cid:0)

1; Wt

2::::; W

p+1; (cid:2))]

(cid:0)

(cid:0)

=

(T n=2)log(2(cid:25)) + (T =2)log

(cid:0)

1
(cid:10)(cid:0)
j

j (cid:0)

T

(1=2)

(Wt

t=1
X

(cid:5)0xt)0(cid:10)(cid:0)

1(Wt

(cid:5)0xt)

(cid:0)

(cid:0)

It turns out to be (for a proof see textbook) that the maximum likelihood
estimator is

T

T

^(cid:5)0 = [

Wtx0t][

1
xtx0t](cid:0)

where the j column is just

t=1
X

t=1
X

^(cid:25)j (1

np) = [

(cid:2)

T

T

Wjtx0t][

1
xtx0t](cid:0)

t=1
X

t=1
X

The Maximum likelihood estimator of (cid:10)

We can now ”concentrate” the likelihood using the previous results to …nd

the MLE estimator of (cid:10) (evaluated at the estimate of (cid:5)).

L((cid:10); ^(cid:5)) =

(T n=2)log(2(cid:25)) + (T =2)log

(cid:0)

1
(cid:10)(cid:0)
j

j (cid:0)

(1=2)

^"0t(cid:10)(cid:0)

1^"t

T

t=1
X

1
taking the derivative with respect to (cid:10)(cid:0)

@L((cid:10); ^(cid:5))=@(cid:10)(cid:0)

1 = (T =2)

@log

1
(cid:10)(cid:0)
j
@(cid:10)(cid:0)

j
1 (cid:0)

T

(1=2)

1^"t
@^"0t(cid:10)(cid:0)
1
@(cid:10)(cid:0)

t=1
X
and using the following results from matrix algebra: @(x0Ax)
@A = xx0 and @log
A
@A =
j
j
1
1 ,we can di¤erentiate the concentrated likelihood with respect to (cid:10)(cid:0)
(A0)(cid:0)

@L((cid:10); ^(cid:5))=@(cid:10)(cid:0)

1 = (T =2)(cid:10)0

(cid:0)

T

(1=2)

(^"t^"0t):

t=1
X

Equating this expression to zero we obtain the MLE of the variance-covariance
matrix.

T

^(cid:10)0 = (1=T )

(^"t^"0t)

t=1
X

A very important result is that the row i, column i of ^(cid:10) is given by ^(cid:27)2

i =
(1=T )
it) which is just the average squared residual from a regression of a
variable of the VAR on the p lags of all variables. Analogously the row i column

t=1(^"2

T

P

6

T
j of ^(cid:10)0 is given by ^(cid:27)2
t=1(^"it^"jt) which is the average product of the
OLS residual for variable i and the OLS residual foe variable j. Therefore I can
use OLS results to construct both ^(cid:10) and ^(cid:5).

ij = (1=T )

P

How to choose the order of a VAR

The results of any test that we carry out using a VAR crucially depend on
identifying correctly the order of that VAR. An easy way to attempt to identify
the order of a VAR is to perform likelihood ratio tests. To do this turns out
to be computationally very simple since the test can be constructed using OLS
results.

Consider the likelihood function at is Maximum value of a VAR with p0 lags,

denoted

L0( ^(cid:10); ^(cid:5)) =

(T n=2)log(2(cid:25)) + (T =2)log

(cid:0)

^(cid:10)(cid:0)
1
0 j (cid:0)
j

(1=2)

Consider now the last term of this equation,

^"0t

^(cid:10)(cid:0)
1
0 ^"t:

T

t=1
X

(1=2)

T

t=1
X

^"0t

^(cid:10)(cid:0)
1

0 ^"t(ascalar) = T R((1=2)

^"0t

^(cid:10)(cid:0)
1
0 ^"t)

T

t=1
X
T

= (1=2)T R(

^(cid:10)(cid:0)
1

0 ^"t^"0t)

(since T R(A:B) = T R(B:A))

t=1
X

= (1=2)T R( ^(cid:10)(cid:0)
1

0 T ^(cid:10)0)

(since ^(cid:10)0 =

^"t^"0t=T )

T

t=1
X

= (T =2)T R(I)
= (nT )=2:

then

L0( ^(cid:10); ^(cid:5)) =

(T n=2)log(2(cid:25)) + (T =2)log

(cid:0)

^(cid:10)(cid:0)
1
0 j (cid:0)
j

(nT )=2

If we want to test the Hypothesis that the VAR has p lags against p0 lags

we calculate the likelihood for the VAR with p1 lags (p1 > p0 )

L1( ^(cid:10); ^(cid:5)) =

(T n=2)log(2(cid:25)) + (T =2)log

(cid:0)

^(cid:10)(cid:0)
1
1 j (cid:0)
j

(nT )=2

7

and compute the likelihood ratio which is

2(L1( ^(cid:10); ^(cid:5))

(cid:0)

L0( ^(cid:10); ^(cid:5))) = T (log

^(cid:10)(cid:0)
1
1 j (cid:0)
j

log

^(cid:10)(cid:0)
1
)
0 j
j

which is distributed under the Null (cid:31)2 with degrees of freedom equal to the
number of restrictions imposed under H0, n2(p1

p0).

(cid:0)

Sims (1980) proposed a modi…cation of the likelihood ratio test to take into

account small sample bias

(T

(cid:0)

k)(log

^(cid:10)(cid:0)
1
1 j (cid:0)
j

log

^(cid:10)(cid:0)
1
)
0 j
j

where k = np1 = number of parameters estimated per equation.

Goodness of …t Criteria

The goodness of …t criteria are measures of how good a model is relative
to others. They re‡ect a balance between the model’s goodness of …t and the
complexity of the model.

Typically, we want to minimize a scalar measure such as

C(p) =

2max(logL) + (cid:12)(number of f reely estimated parameters)

(cid:0)

For Gaussian models, the maximized log-likelihood is proportional to

(T =2)log

(cid:0)

(cid:10)
j

j

(since

1
(cid:10)(cid:0)
j

j

= 1=

)

(cid:10)
j

j

Hence, we choose p to minimize:

C(p) = T log

+ (cid:12)(n2p)

(cid:10)
j

j

AIC (cid:12) = 2 (Akaike information criterion)
SBC (cid:12) = log(T ) (Scharz Bayesian criterion)
HQ

(cid:12) = 2log(log(T )) (Hannan-Quin criterion)

Alternatively the Akaike’s prediction error (FPE) criterion chooses p so that

to minimize the expected one -step ahead squared forecast error:

F P E = [

T + np + 1
np
T
1

(cid:0)

(cid:0)

]n

(cid:10)
j

j

AIC and FPE are not consistent, so that asymptotically they overestimate p
p:

with positive probability. SBC and HQ are consistent in the sense that ^p

!

Asymptotic Distribution of ^(cid:5)

8

The maximum likelihood estimates of ^(cid:5) and ^(cid:10) will give consistent estimates
of the population parameters. Standard errors for ^(cid:5) can be based on the usual
OLS formulas.

Let ^(cid:25)T = vec( ^(cid:5)T ) denote the nk
(cid:2)

regressions of each of the elements of Wt on xt

1 vector of coe¢ cients resulting from OLS

Then

where Q = E(xtx0t).

pT (^(cid:25)T

(cid:0)

(cid:25)) L
(cid:0)!

N (0; (cid:10)

Q(cid:0)

1)

(cid:10)

This establishes that the standard OLS t and F statistics applied to the

coe¢ cients of any single equation in the VAR are asymptotically valid.

where (cid:27)2

i = E("2

it):

pT (^(cid:25)iT

(cid:0)

(cid:25)i) L
(cid:0)!

N (0; ((cid:27)2

i Q(cid:0)

1))

M ain uses of V ector Autoregressions

i) Forecasting
ii) Testing Hypothesis
iii) Granger Causality
iv) Use of Impulse Response Functions
v) Use of the variance decomposition.

ii) Testing Rational expectations Hypothesis

The VAR methodology is very useful to test linear rational expectations hy-
pothesis. These models usually impose non-linear cross equation restrictions
between the parameters of the model which are tested using a likelihood ratio
test which is distributed under the Null (that the model is correct) as a (cid:31)2 dis-
tribution with degrees of freedom equal to the number of restrictions imposed
by the model.

Consider a …rst order bivariate VAR

xt = a11xt
yt = a21xt

1 + a12yt
1 + a22yt

1 + "t
1 + (cid:23)t

(cid:0)

(cid:0)

(cid:0)

(cid:0)

Assume that xt is the interest rates di¤erential, say (it
the …rst di¤erence of the logs of the spot exchange rate (et

Then uncovered interest parity can be written as

(cid:0)
(cid:0)

9

i(cid:3)t ), and that yt is
et

1);

(cid:0)

xt = Etyt+1:

Then if we condition on both sides of the previous equation on information
1 we get the following set of non linear restrictions.

available at t

(cid:0)

1

0

A =

0

1

A2

The above equation can be easily solved and yields the following nonlinear
(cid:2)

(cid:2)

(cid:3)

(cid:3)

restrictions on the parameters

a11 = a22a21=(1

a21)

(cid:0)

a12 = a2

22=(1

a21)

(cid:0)

Then we simply estimate the unrestricted model and the restricted (a func-
tion of only two parameters (and the variance-covariance)), and perform a likeli-
Lr)~asymptotically (cid:31)2 (number of restrictions=2).
hood ratio test, where 2(Lu

(cid:0)

iii)Granger Causality

One of the key questions that can be addressed with vector autoregressions

is how useful some variables are for forecasting others.

De…nition
The question investigated is whether a scalar y can help forecast another

scalar x. If it cannot, then we say that y does not Granger-cause x

Then, y fails to Granger-cause x if for all s > 0 the mean squared error of a
1; ::::) is the same as the MSE of a forecast of

forecast of xt+s based on (xt; xt
xt+s based on (xt; xt

1; ::::) and (yt; yt

(cid:0)

1; ::::). For linear functions

M SE[E(xt+s

1; ::::)] = M SE[E(xt+s

1; ::::; yt; yt

1; ::::)]

xt; xt
j

(cid:0)

(cid:0)

(cid:0)
xt; xt
j

(cid:0)

(cid:0)

Granger’s reason for proposing this de…nition was that if an event Y is the cause
of another event X, then the event Y should precede the event X.

Testing for Granger causality

Ho) y does not cause x or a12 = 0

We just regress both the general model

i) xt = a11xt

1 + a12yt

1 + "1t

(cid:0)

(cid:0)

and the restricted model

ii) xt = a11xt

1 + "01t

(cid:0)

and compare the residuals sum squares T (RRS("0)

RRS("))=RRS(")~(cid:31)2(1)

(cid:0)

(asymptotically)

10

Granger-Causality Tests and Forward-Looking Behaviour

Let us assume risk neutral agents such that stock prices may be written as

Pt =

1

i=1
X

(1=(1 + r))iE(Dt+i

It)
j

suppose

Dt = d + ut + (cid:14)ut

1 + (cid:23)t

(cid:0)

where ut and (cid:23)t are independent white noise processes, then

EtDt+i =

(cid:26)
The stock prices will be given by

d + (cid:14)ut
d

for i = 1
for i = 2; 3; :::

Pt = d=r + (cid:14)ut=(1 + r)

Thus for this example the stock price is a white noise and could not be
forecast on the basis of lagged prices or dividends. No series should granger
cause stock prices.

Nevertheless, notice that using the stock price equation and rearranging

terms, I might express

(cid:0)
Then substituting back in the Dividend process we get the following expres-

(cid:0)

(cid:0)

(cid:14)ut

1 = (1 + r)Pt

1

(1 + r)d=r

sion for dividends

Dt = d + ut + (1 + r)Pt

1

(cid:0)
Thus stock prices Granger cause dividends
The bivariate VAR takes the form

(cid:0)

(1 + r)d=r + (cid:23)t

Pt
Dt

=

(cid:21)

(cid:20)

d=r
d=r

(cid:0)

(cid:20)

+

(cid:21)

(cid:20)

0
(1 + r)

0
0

(cid:21) (cid:20)

Pt
(cid:0)
Dt

1

1

(cid:0)

+

(cid:21)

(cid:20)

(cid:14)ut=(1 + r)
ut + (cid:23)t

(cid:21)

Hence in this model, Granger causation runs in the opposite direction from the
true causation. Dividends fail to G-C prices even though investors’perceptions
of dividends are the sole determinant of stock prices. On the other hand, prices
do ”granger-cause”dividends, even though the market’s evaluation of the stock
in reality has no e¤ect on the dividend process.

iv) The Impulse - Response Function

11

If a VAR is stationary it can always be written as an in…nite vector moving
average. Consider the following vector in…nite moving average representation of
Wt

1

Wt =

z=0
X

 z"t

z

(cid:0)

;  0 = I

Analogously, if we lead the above expression s periods we get

Wt+s =

1

 z"t+s

z

(cid:0)

z=0
X
Therefore we can easily see from the above expression (evaluated at z = s) that
matrix  s has the interpretation of a dynamic multiplier

 s =

@Wt+s
@"0t

(dynamic multiplier or impulse response) where ( s)ij = e¤ect of a one unit
increase in the jth variable’s innovation at time t ("jt ) for the value of the
ith variable at time t + s (Wi;t+s ), holding all other innovations at all dates
constant2.

A simple way of …nding these multipliers numerically is by simulation. To
p = 0, then set "jt = 1 and all the

implement the simulation set Wt = ::: = Wt
(cid:0)
other terms to zero, and simulate the system

Wt = A1Wt

1 + A2Wt

2 + ::: + ApWt

p + "t

(cid:0)

(cid:0)

(cid:0)

for t; t + 1; t + s, with "t+1; "t+2; :::: = 0 This simulation corresponds to the J
column of the matrix  s . By doing this for other values of j we get the whole
matrix.

A plot of ( s)ij , that is row i column j of  s , as a function of s is called
the impulse response function. It describes the response of Wi;t+s to a one time
impulse in Wjt with all other variables dated t or earlier held constant.

2 Consider a …rst order two-variable Var. The relevant term of the in…nite moving average

is

 s"t =

a
c

b
d

"1
"2

(cid:20)

(cid:21) (cid:20)

(cid:21)

(cid:21)

Now assume a unit increase in "1 (i.e. "1 = 1 and "2 = 0), then the e¤ect on Wt+s is
a
c

: (that is a on the …rst variable and c on the second). Now varying s we can get a plot

(cid:20)
of the e¤ects of a shock in the innovation of variable 1 on both variables. A similar argument
can be constructed for a schock in "2, therefor the columns, …rst or second, of  s represent
the e¤ect on each variable of W at time t + s of a unit shock to the …rst or second variable
innovation, keeping the other constant.

12

We can also de…ne the Interim multipliers, which are given by the accumu-

lated responses over m periods

 j;

m

j=1
X

and the long run multiplier which give the total accumulated e¤ects for all future
time periods:

 j:

1

j=1
X

The assumption that a shock in one innovation does not a¤ect others is prob-
lematic since E("t"0t) = (cid:10)
= a diagonal matrix . This means that a shock in
one variable is likely to be accompanied by a shock in another variable in the
same period.

Since (cid:10) is symmetric and positive de…nite, it can be expressed as (cid:10) = ADA0,

where A is a lower triangular matrix and D is a diagonal Matrix.

Let ut = A(cid:0)

1"t; then

Wt =

1

j=0
X

where

 j"t

j =

(cid:0)

1

j=0
X

 jAA(cid:0)

1"t
(cid:0)

j =

 (cid:3)j ut

j
(cid:0)

1

j=0
X

 (cid:3)j =  jA

E(utu0t) = E(A(cid:0)

1"t"0t(A(cid:0)

1)0) = A(cid:0)

1(cid:10)(A(cid:0)

1)0 = A(cid:0)

1ADA0(A(cid:0)

1)0 = D

The matrix D gives the variance of ujt

A plot of  (cid:3)s as a function of s is known as an orthogonalized impulse

response function.
The matrix

 (cid:3)s =

@Wt+s
@u0t

gives the consequences of an increase in Wjt by a unit impulse in ut .

In the new MA representation, it is reasonable to assume that a change in one
component of ut has no e¤ect on the other components because the components
are orthogonal.

Notice that  (cid:3)0 =  0A = IA is lower triangular. This implies that the or-
dering of variables is of importance. The ordering has to be such that Wlt is
the only one with a potential immediate impact on all other variables. W2t may
have an immediate impact on the last n
2 components but not on W1t , and
so on. The ordering cannot be determined with statistical methods.

(cid:0)

v) Variance Decomposition

13

6
Consider the error in forecasting a VAR s periods ahead,

Wt+S

Wt+S

t =

j

(cid:0)

c

s

1

(cid:0)

j=0
X

 j"t+s

j;

(cid:0)

 0 = I

The mean squared error of this s-period ahead forecast is thus

M SE(

Wt+s

j

t) = (cid:10) +  1(cid:10) 01 +  2(cid:10) 02::::::::::: +  s

1(cid:10) 0s

(cid:0)

1

(cid:0)

Let us now consider how each of the orthogonalized disturbances (u1t; ::unt)
contributes to this MSE.

c

Write

"t = Aut = a1u1t + ::::anunt;

where aj denotes the jth column of the matrix A.
Recalling that the u’s are uncorrelated, we get

(cid:10) = a1a01(n

n)V ar(u1t) + a2a02(n

(cid:2)

n)V ar(u2t) + :::ana0n(n

(cid:2)

n)V ar(unt)

(cid:2)

Substituting this in the MSE of the s period ahead forecast we get

M SE(

Wt+s

t) =

j

c

n

j=1
X

V ar(ujt)(aja0j +  1aja0j 01 +  2aja0j 02::: +  s

1aja0j 0s

(cid:0)

1)

(cid:0)

With this expression we can calculate the contribution of the jth orthogonalized
innovation to the MSE of the s-period ahead forecast.

V ar(ujt)(aja0j +  1aja0j 01 +  2aja0j 02::: +  s

1aja0j 0s

(cid:0)

1)

(cid:0)

Again the magnitude in general depends on the ordering of the variables

Structural VAR’s

Blanchard (1989)
To introduce structural information in a VAR there are several ways to
proceed. Probably the most popular is to try to impose restrictions in the
covariance matrix. For a VAR(p), there are p(p+1)=2 elements in the covariance
matrix of the elements of p so we might consider models of the innovations of
the form

C"t = Dut where the ut’s are uncorrelated with variances (cid:27)2

1; :::; (cid:27)2

p . Then,

we can have p(p + 1)=2 - p unknown terms in C and D.

How exactly one would want to specify C and D is left to structural reason-

ing, for example Blanchard (1989) considers the following structure

14

"1t = eu2t + u1t
"2t = c21"1t + u2t

Where u1t and u2t are regarded as demand and supply shocks, while "1t and
"2t are output and unemployment innovations respectively. If e = 0 output just
respond to demand shocks.

Blanchard and Quah (1989).

Probably the most well known approach is Blanchard and Quah (1989).
They have a bivariate system with demand and supply shocks but they do not
impose the assumption that the shocks are uncorrelated. Rather they argue
that a demand shock should have a zero long-run e¤ect while a supply shock
will not. Hence they will have

"1t = a1u2t + u1t
"2t = a2u1t + u2t

where the covariance of ujt is assumed to be zero.
To see how it works consider

Wt = A1Wt

1 + A2Wt

2 + ::: + ApWt

p + "t

(cid:0)

(cid:0)

(cid:0)

is estimated and the implied MA representation is

Wt =

1

z=0
X

 z"t

z

(cid:0)

;  0 = I:

In terms of the shocks of interest, we will write "t = Aut where A is now de…ned

as A =

1
a2

a1
1

.

(cid:21)

(cid:20)

Then the moving average representation becomes,

1

Wt =

z=0
X

 zAut

z

(cid:0)

;  0 = I

But we want the long run e¤ect of a demand shock, taken to be u1t , upon
output say, W1t , to be zero. The long run e¤ect of u1t on W1t is just obtained
by summing

1

[

 zA][1;1] = 0

z=0
X

1z=0  z , be [(cid:14)1; (cid:14)2] , then the restriction is just (cid:14)1+a2(cid:14)2 = 0

Thus one parameter can be found from this restriction and other three come

Let the …rst row of
or a2 =

(cid:14)1=(cid:14)2.

(cid:0)

P

from the fact that

15

(cid:27)2
1
0
(cid:20)
1 and (cid:27)2

0
(cid:27)2
2 (cid:21)

V ("t) = A

mine a1; (cid:27)2
we know that

A0, since there are three unknowns in V ("t) to deter-

2. Then all that is needed is to estimate (cid:14)1; (cid:14)2 . Now since

i)
ii)
iii)
iv)  (1) = (I

1z=0  z =  (1);
1z=0  zLi =  (L);
1z=0  zLi = (I
A1

P
P
P

1;
1; then all the information
that is needed for the impulse response function, is obtained from the estimated
parameters in the VAR.

::: + ApLp)(cid:0)
1 = A(1)(cid:0)

A2L2
(cid:0)
::::::: + Ap)(cid:0)

1 = A(L)(cid:0)

(cid:0)
A2

A1L

(cid:0)

(cid:0)

(cid:0)

(cid:0)

16

Non-Stationary Series.

There are three important types of time series which one is likely to …nd in
…nancial econometrics: stationary (I(0)), trend stationary and non-stationary
(I(1)).

A Stationary process

A (weakly) stationary time series has a constant mean, a constant variance
and the covariance is independent of time. Stationarity is essential for standard
econometric theory. Without it we cannot obtain consistent estimators.

A quick way of telling if a process is stationary is to plot the series against
time. If the graph crosses the mean of the sample many times, chances are that
the variable is stationary, otherwise that is an indication of persistent trends
away from the mean of the series.

A Trend Stationary

A trend stationary variable is a variable whose mean grows around a …xed
trend. This provides a classical way of describing an economic time series which
grows at a constant rate. A trend-stationary series tends to evolve around a
steady, upward sloping curve without big swings away from that curve. De-
trending the series will give a stationary process. For simplicity assume that
the following process.

yt = (cid:11) + (cid:22)t + "t where "t~N (0; (cid:27)2)

Notice that the mean of this process varies with time but the variance is

constant.

E(yt) = (cid:11) + (cid:22)t

V (yt) = E((cid:11) + (cid:22)t + "t

((cid:11) + (cid:22)t))2 = (cid:27)2

(cid:0)

Notice that if you de…ne a new variable, say y(cid:3)t ; y(cid:3)t = yt

is stationary.

((cid:11) + (cid:22)t) then yt

(cid:0)

A Non stationary Series: I(1) Processes

An autoregressive process of order p, AR(p), has a unit root if the polyno-
:::(cid:30)pLp) has a root equal to one. The simplest example

mial in L, (1
of a process with a unit root is a random walk, i.e.,

(cid:30)1L

(cid:0)

(cid:0)

yt = yt

1 + "t

(cid:0)

(1)

where "t is i.i.d. with zero mean and constant variance.

1

We can easily see that the variance of this processes does not exist: lagging

the process one period we can write

yt

1 = yt

2 + "t

1;

(cid:0)

(cid:0)

(cid:0)

and substituting back in equation (1) we get

yt = yt

2 + "t

1 + "t:

(cid:0)

(cid:0)

Then, repeating this procedure we can easily show that

yt = y0 + "1 + "2 + ::: + "t

1 + "t

(cid:0)

Then we can calculate the mean and the variance of this process:

The mean can be calculated assuming that y0 is …xed, then the mean is

constant over time

E(yt) = E(y0 + "1 + "2 + :::: + "t

1 + "t) = y0

(cid:0)

The variance of yt , ”conditional” on knowing y0 , can be computed as

V (yt) = V (y0 + "1 + "2 + :::: + "t

1 + "t)

(cid:0)
= V ("1) + V ("2) + ::: + V ("t

1) + V ("t) = t(cid:27)2
(cid:0)

As we move further into the future this expression becomes in…nite. We conclude
that the variance of a unit root process is in…nite.

A unit root process will only cross the mean of the sample very infrequently,
and the process will experience long positive and negative strays away from the
sample mean.

A process that has a unit root is also called integrated of order one,
denoted as I(1). By contrast a stationary process is an integrated of order
zero process, denoted as I(0).

Why is this Important?
The study of econometric models with non-stationary data has been one of
the most important concerns of econometricians in the last 20 years. Therefore
the topic is very vast and we just will mention some of the most important issues.

Spurious Regressions.

Granger and Newbold (1974) have shown that, using I(1), you can obtain
an apparently signi…cant regression (say with a high R2 ) even if the regressor
and the dependent variable are independent. He generated independent random

2

walks regress one against the other and obtain very high R2 for this equation.
They conclude that this result is spurious. As a rule of thumb whenever you
obtain a very high R2 and a very low DW you should suspect that the result
are spurious.

Regressing Series that are integrated of the same order

Another important issue is that whenever you try to explain a variable, say
yt , by another variable, say xt , you should check that these variables are inte-
grated of the same order to obtain meaningful results.

How do we test for a unit root?

In this section we will show that the standard t-test cannot be applied for
a process with a unit root. The standard testing procedure that we use for
stationary series yields a degenerate distribution. We also …nd the distribution
under these circumstances but; a) it turns out that is not a t-distribution and
b) this distribution is biased to the left.

Consider the following model:

yt = (cid:11)yt

1 + "t

(2)

(cid:0)
where "t ”is assumed”to be N(0,(cid:27)2). It can easily be shown that asymptot-

ically

pT (^(cid:11)T

(cid:11)) L
(cid:0)!
If we want to use this distribution for testing the null hypothesis that (cid:11) = 1;
then we …nd that the distribution under the null "degenerates" (collapses in one
point).

N (0; (1

(cid:0)

(cid:0)

(cid:11)2))

We …nd that the estimator converges in probability to the true parameter:

Even though this is valid, it is not very useful for hypothesis testing.

pT (^(cid:11)T

(cid:0)

0

(cid:11)) P
(cid:0)!

To obtain a non-degenerate asymptotic distribution for ^(cid:11)T in the unit root
case, it turns out that we have to multiply by T and not by the square root
of T . Then the unit root coe¢ cient converges at a faster rate T than for the
stationary case.

To get a better sense of why scaling by T is necessary when the true value

of (cid:11) is unity consider the OLS estimate

^(cid:11)T =

1yt

T
t=1 yt
(cid:0)
T
t=1 y2
t
(cid:0)

1

P

:

Then, substituting yt by the AR(1) process we get that

P

3

^(cid:11)T

(cid:0)

(cid:11) =

1"t

T
t=1 yt
(cid:0)
T
t=1 y2
t
(cid:0)

1

P

and multiplying in both sides by T , we get
P

T
t=1 yt
(cid:0)
T
t=1 y2
t
(cid:0)
Now, under the null that (cid:11) = 1; yt can be written as

1
T (cid:0)
2
T (cid:0)
P

T (^(cid:11)T

(cid:11)) =

P

(cid:0)

1

1"t

:

yt = y0 + "1 + "2 + ::: + "t
= "1 + "2 + ::: + "t

(cid:0)
1 + "t

1 + "t

(cid:0)

if we assume y0 = 0:

Then under the null that (cid:11) = 1; yt ~N(0; (cid:27)2t). To …nd the distribution of
the numerator we need to do some easy but tedious algebra. We start by noting
that under the null,

y2
t = (yt

1 + "t)2 = y2
t
(cid:0)
(cid:0)

1 + 2yt

1"t + "2
t
(cid:0)

and rearranging terms we obtain

yt

1"t =

(cid:0)

1
2

(y2

t (cid:0)

y2
t
1 (cid:0)
(cid:0)

"2
t ):

Then, the sum which appears in the numerator can be expressed as

T

t=1
X

yt

1"t =

(cid:0)

1
2

T

t=1
X

(y2

t (cid:0)

y2
t
1 (cid:0)
(cid:0)

"2
t ) =

1
2

(y2

T (cid:0)

y2
0)

(cid:0)

1
2

"2
t :

T

t=1
X

Then, recalling that y0 = 0 and multiplying by (T (cid:0)
of the numerator as the sum of two terms

1) we obtain the expression

T

1
T (cid:0)

t=1
X

yt

1"t = (

(cid:0)

1
2T

)y2

T (cid:0)

(

1
2T

)"2
t

T

t=1
X

To …nd the distribution of this expression we divide each side by (cid:27)2 which

yields the following result

T

1
((cid:27)2T )(cid:0)

yt

1"t = (1=2)(

(cid:0)

yT
(cid:27)pT

)2

(cid:0)

(

1
2(cid:27)2T

)"2
t

T

t=1
X

t=1
X

Consider the …rst term of this expression. Since we have shown above that

yt ~N(0; (cid:27)2t), standardizing we obtain

(yT =(cid:27)pT )~N (0; 1);

4

and then squaring this expression we …nd that the …rst term of the numerator

is distributed Chi-square

(yT =(cid:27)pT )2~(cid:31)2(1):

It can be shown using the law of large numbers that the second term converges
in probability to (cid:27)2, i.e.

T

(1=T )

"2
t P
(cid:0)!

t=1
X

(cid:27)2;

or

(1=(cid:27)2T )

T

"2
t P
(cid:0)!

1

t=1
X

If we put both results together we can see that the numerator converges to

1
((cid:27)2T )(cid:0)

T

t=1
X

yt

1"t

(cid:0)

L
(cid:0)!

(1=2)(X

(cid:0)

1) where X~(cid:31)2(1):

It can also be shown using the law of large numbers that the denominator

converges in probability to

T

2
E(T (cid:0)

y2
t
(cid:0)

1):

t=1
X

Now,as yt

1 ~N(0; (cid:27)2(t

(cid:0)

1) = (cid:27)2(t
1)), then E(y2
t
(cid:0)

(cid:0)

1). Therefore the

(cid:0)

expected value of the denominator can be written as

2
E(T (cid:0)

T

t=1
X

T

t=1
X

1) = T (cid:0)

2(cid:27)2

y2
t
(cid:0)

1) = (cid:27)2T (cid:0)

2(T

(t

(cid:0)

1)T =2

(cid:0)

Then if we multiply (^(cid:11)T

(cid:11)) by T instead than by pT , we obtain a non-

degenerate asymptotic distribution, but this distribution is not Gaussian.

(cid:0)

For this very simple example it is rather easy to …nd the distribution using
"standard" discrete time algebra. Unfortunately for many other processes is
not as easy. Fortunately there is a convenient way of …nding the distributions of
processes with unit roots which relies in the is use of continuous time stochastic
processes de…ned below.

Testing for the existence of unit roots

Consider the following model

yt = (cid:22) + (cid:12)t + (cid:11)yt

1 + "t

(cid:0)

(3)

where "t ”is assumed” to be N(0,(cid:27)2)

5

We want to test the Hypothesis of the existence of a unit root therefore we

set the following null and alternative hypothesis.

H0) (cid:11) = 1 ( unit root )
H1) (cid:11) < 1 ( Integrated of order zero )
The obvious estimator of is the OLS estimator, ^(cid:12). The problem is that under
the null hypothesis there is considerable evidence of the non - adequacy of the
asymptotic (approximate in large samples) distribution. Therefore

Equation (3) can be reparameterizied as

or

(cid:1)yt = (cid:22) + ((cid:11)

(cid:0)

1)yt

1 + (cid:12)t + "t

(cid:0)

(cid:1)yt = (cid:22) + (cid:21)yt

1 + (cid:12)t + "t

(cid:0)

(4)

For this expression the relevant hypothesis should be written as

H0)(cid:21) = 0 ( unit root )
H1)(cid:21) < 0 ( Integrated of order zero )

Fuller (1976) tabulated, using Monte Carlo methods, critical values for al-
ternative cases, for example for a sample size of 100 the 5 % critical values
are

(cid:22) = 0; (cid:12) = 0
= 0; (cid:12) = 0
(cid:22)
= 0; (cid:12)
(cid:22)
= 0

2:24
3:17
3:73

(cid:0)
(cid:0)
(cid:0)

Therefore the method simply consist to check the t-statistic of ^(cid:21) against the
critical values of Fuller (1976). Notice that the critical values depend on

i) the sample size

ii) whether you include a constant and/or a time trend.

This procedure is only valid when there is no evidence of serial correlation in
the residuals, ^"t . To see if this condition is satis…ed you should look at the di-
agnostic tests for serial correlation in the regression. If there is serial correlation
you should need to include additional lags, say (cid:1)yt
2 etc. to equation
(4) until the serial correlation of the residuals disappears, that is

1; (cid:1)yt

(cid:0)

(cid:0)

Augmented Dickey Fuller

(cid:1)yt = (cid:22) + (cid:21)yt

1 + (cid:12)t + (cid:11)1(cid:1)yt

1 + ::: + (cid:11)k(cid:1)yt

k + "t

(cid:0)

(cid:0)

(cid:0)

In this case we chose to augment the regression with k lags. This is usually
denoted as ADF(k). To choose the order of augmentation of the DF regression
several procedures have been proposed in the literature. Some of these consist
in:

6

6
6
6
(i) choosing k as a function of the number of observations as in Schwert (1989)

k = INT (12 (T =100 )1=12)

(ii ) information based rules such as AIC and BIC.

(iii ) Sequential rules

General to speci…c seems to be preferable to the other methods.

Small sample properties of the Dickey Fuller tests.

The power ( the ability to reject the null Hypothesis) of the Dickey Fuller
Tests is notoriously weak. Thus it can be di¢ cult to reject the null of a unit root
test even if the true series is stationary. That is, most of the time an ADF test
will not reject the null of unit root even if the true model is an autoregressive
model with an autoregressive coe¢ cient of say .8 (that is an Integrated of order
zero series). In addition the ADF tests often come up with con‡icting results
depending in the order of the lag structure. A good practice is to start with a
quite general model and delete the non signi…cant lags of (cid:1)yt.

Phillips-Perron-type tests for unit roots

The ADF test includes additional lagged terms to account for the fact that
the DGP might be more complicated than an AR(1). An alternative approach
is that suggested by Phillips(1987) and Perron (1988). They make a non-
parametric correction to the standard deviation which provides a consistent
estimator of the variance.

They use

T

l

T

S2

1
T l = T (cid:0)

("2

1
t ) + 2T (cid:0)

t=1
X

t=1
X

t=j+1
X

T

S2

1
" = T (cid:0)

("2
t )

"t"t

j
(cid:0)

where l is the lag truncation parameter used to ensure that the autocorrelation
of the residuals is fully captured.

t=1
X

An asymptotically valid test (cid:30) = 1, for

(cid:1)yt = (cid:22) + ((cid:30)

1)yt

1 + "t

"t~iiD(0; (cid:27)2)

(cid:0)
when the underlying DGP is not necessarily an AR(1) process, is given by the
Phillips Z-test.

(cid:0)

7

Z((cid:28) (cid:22)) = (S"=ST l)(cid:28) (cid:22)

(1=2)(S2

T l (cid:0)

(cid:0)

" )[ST l[T 2
S2

T

t=2
X

y)2]:5](cid:0)
1

(yt

(cid:0)

where (cid:28) (cid:22) is the t-statistic associated with testing the null hypothesis (cid:26) = 1. The
critical values for this test statistic are the same as those used for the same case
in the fuller table. Monte Carlo work suggests that the Phillips-type test has
poor size properties (tendency to over reject when is true) when the underlying
DGP has large negative MA components.

Structural breaks and unit roots

We have already mentioned that the ADF test has very low power to reject
the null hypothesis of the existence of a unit root. Therefore is very di¢ cult
using this type of test to distinguish between an autoregressive process with
root, say .95, and a unit root process. This is particularly true if there is a
structural break in the mean of the series. Perron (1988) have shown that an
I(0) process with a structural break in the mean will be di¢ cult to distinguish
from a I(1) process. If we know were the break takes place, the natural thing to
do, is to partial out the break by using dummy variables and test for unit roots
once the break has been partialled out.

A possible solution to try to identify these breaks is to perform the ADF

test recursively and to compute recursive t-statistics.

Perron (1989) showed that if a series is stationary around a deterministic
time trend which has undergone a permanent shift sometime during the period
under consideration, failure to take account of this change in the slope will
be mistaken by the usual ADF unit root test as a persistent innovation to a
stochastic (non-stationary) trend. That is, a unit root test which does not take
into account a break in the series will have very low power. There is a similar
loss in power if there is a shift in the intercept.

If the breaks in the series are known then it is relatively simple to adjust the
ADF test by including dummy variables to ensure there are as many determin-
istic regressors as there are deterministic components in the DGP.

However is unlikely that we will know the break then we can proceed by
using the critical values provided by Banjeree, Lumsdaine and Stock (1992).
They designed a testing strategy and tables which account for a random break
to take palace in any place in the sample. Then they designed tables which are
constructed under the null of a unit root but allowing for a random structural
break in the sample.
They proposed two tests, one based on the recursive
computation of the t - statistics of the ADF regression and another based on
the rolling computation. They compare the minimum values whith the critical
values of tables generated under this scenarios

Recursive t-statistics

8

The recursive ADF -statistic is computed using sub samples t = 1::k f or
k = k0; :::::T , where k is the start up value and T is the sample size of the full
sample. The most general model (with drift and trend) is estimated for each sub
sample and the minimum value of (cid:28) (cid:28) (k=T ) across all the sub samples is chosen
and compared with the table provided by Banjeree, Lumsdaine and Stock

Rolling ADF tests

This method could also be applied using a (large enough) window (of size
k) to see if there are clear changes in the pattern of a series. The most general
model (with drift and trend) is estimated for each sub sample and the minimum
value of (cid:28) (cid:28) (k=T ) across all the sub samples is chosen and compared with the
table.

T
100

250

500

Percentile
.025
.050
.100
.025
.050
.100
.025
.050
.100

(cid:28) (cid:28)
-3.73
-3.45
-3.15
-3.69
-3.43
-3.13
-3.68
-3.42
-3.13

Recursive min (cid:28) (cid:28) Rolling min (cid:28) (cid:28)

-4.62
-4.33
-4.00
-4.42
-4.18
-3.91
-4.42
-4.18
-3.88

-5.29
-5.01
-4.71
-5.07
-4.85
-4.59
-5.00
-4.79
-4.55

Tests with stationarity as null: The KPSS test

Consider the following model.

where "t is a stationary process and (cid:24)t is a random walk given by

yt = (cid:11) + (cid:14)t + (cid:24)t + "t

(cid:24)t = (cid:24)t

1 + ut ut~iid(0; (cid:27)2
u)
(cid:0)

The null of stationarity is formulated as

u = 0

H0)(cid:27)2
The test statistic for this hypothesis is given by

LM =

T
t=1 S2
t
^(cid:27)2
e

P
where et are the residuals of a regression of yt on a constant and a time
e is the residual variance for this regression and St is the partial sum of

trend, ^(cid:27)2
et de…ned by

9

T

St =

ei

t = 1; 2; ::; T:

i=t
X

For testing the null of the level stationary instead of trend stationary the test
is constructed the same way except that et is obtained as the residual from a
regression of yt on an intercept only. The test is an upper tail test. When the
errors are i.id. the asymptotic distribution of the test is derived in Nabeya and
Tanaka (1988). In other cases need to be conveniently adjusted.

Variance Ratio Tests

Given the low power of the ADF test, the variance ratio test will provide us
with another tool to discriminate between (trend) stationary and non-stationary
series.

Consider yt and assume that it follows follows a random walk, i.e.

then by iterative substitution we know that

yt = yt

1 + "t

(cid:0)

yt = yt

k + "t + "t

1 + "t

2 + "t

3 + ::: + "t

k+1

(cid:0)
Now if we denote the di¤erence between yt and yt

(cid:0)

(cid:0)

(cid:0)

(cid:0)
k as (cid:1)kyt , then

(cid:0)

(cid:1)kyt = "t + "t

1 + "t
and clearly the variance of (cid:1)kyt, is (cid:27)2k, where (cid:27)2 is the variance of ".
We can de…ne a ”variance ratio” function (a function of k) as

3 + ::: + "t

2 + "t

k+1

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:21)1(k) =

V ar((cid:1)kyt)
V ar((cid:1)1yt)

= k:

Therefore a plot of (cid:21)1 against k should be an increasing straight line. Alterna-
tively we may de…ne a new function (cid:21)2(k) as (cid:21)2(k) = (cid:21)1(k)=k, then if there is
a unit root, (cid:21)2(k) tends to one when k tends to in…nite.

However if yt does not contain a unit root it can be shown that the lim (cid:21)2(k)
when k tends to in…nite is equal to zero. To see this assume the following AR(1)
process

yt = (cid:30)1yt

1 + "t;

(cid:0)

t = 1; ::::::; T

we have seen that by iterative substitution we can express this process as

1yt

yt = (cid:30)k

k + (cid:30)k
1
(cid:0)
Then subtracting yt
sion

(cid:0)

1

"t

(cid:0)

(k

1) + (cid:30)k
1
(cid:0)

2

"t

(cid:0)

(k

2) + ::: + (cid:30)1"t

1 + "t

(cid:0)
k in both sides of the equation we get the following expres-

(cid:0)

(cid:0)

(cid:0)

10

yt

(cid:0)

yt

k = ((cid:30)k
(cid:0)

1 (cid:0)

1)yt

k + (cid:30)k
1
(cid:0)

1

(cid:0)

"t

(k

(cid:0)

1) + (cid:30)k
1
(cid:0)

2

(cid:0)

"t

(k

(cid:0)

(cid:0)

2) + ::: + (cid:30)1"t

1 + "t

(cid:0)

Then the variance of yt

(cid:0)

yt

k , V ar((cid:1)kyt) is equal to

(cid:0)

V (yt

(cid:0)

Notice that

and

yt

k) = ((cid:30)k
(cid:0)

1 (cid:0)

1)2V (yt
(cid:0)

k
k) + V (

1

(cid:0)

(cid:30)j
1"t

j)

(cid:0)

V (yt

k) = V (yt) = (1=(1

(cid:0)

j=0
X

(cid:30)2
1))(cid:27)2

(cid:0)

1

(cid:0)

k
V (

(cid:30)j
1"t

(cid:0)

j) = ((1

(cid:30)2k
1 )=(1

(cid:30)2
1))(cid:27)2;

(cid:0)

(cid:0)

j=0
X
therefore, we can write the variance of (cid:1)yt

k as

(cid:0)
(cid:30)2
1))(cid:27)2 + ((1

V (yt

yt

k) = ((cid:30)k
(cid:0)

1 (cid:0)

1)2(1=(1

(cid:0)

(cid:0)
In the same way we can express for a stationary process the variance of the …rst
di¤erence of yt; (yt

1 + "t:

1)yt

yt

(cid:0)

(cid:0)

1) = ((cid:30)1 (cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:30)2k
1 )=(1

(cid:30)2
1))(cid:27)2

V (yt

(cid:0)

yt

1) = ((cid:30)1 (cid:0)

(cid:0)

1)2V (yt
(cid:0)

1) + (cid:27)2 = ((cid:30)1 (cid:0)

1)(1=(1

(cid:0)

(cid:30)2
1))(cid:27)2 + (cid:27)2

then the variance ratio can be written as

(cid:21)1(k) =

((cid:30)k

1 (cid:0)

1)2(1=(1

(cid:30)2k
(cid:30)2
1))(cid:27)2 + ( (1
1 )=(1
(cid:30)2
1))(cid:27)2 + (cid:27)2
1)2(1=(1

(cid:0)

(cid:30)2
1) )(cid:27)2

(cid:0)

(cid:0)

(cid:0)
((cid:30)1 (cid:0)

then the limit of (cid:21)1(k) when k tends to in…nite for a stationary process is

limk

!1

(cid:21)1(k) =

1

(cid:30)1

1

(cid:0)

which is a constant provided that (cid:30)1 6
when k tends to in…nite.

= 1:

It should be clear from the previous result that the limit of (cid:21)2(k) equals 0

Trend stationary vs di¤erence stationary processes

11

A trend stationary variable may be written as

yt = (cid:11) + (cid:22)t + "t + (cid:18)1"t

1 + (cid:18)2"t

2 + (cid:18)3"t

3 + ::::

(cid:0)

(cid:0)

(cid:0)

then yt

k is simply

(cid:0)

yt

k = (cid:11) + (cid:22)(t

k) + "t

k + (cid:18)1"t

1

k + (cid:18)2"t

2

k + (cid:18)3"t

3

k + :::

(cid:0)

(cid:0)
The kth di¤erence can be obtained simply by subtracting the two above equa-
tions

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

yt

(cid:0)

yt

(cid:0)

k = (cid:22)k + "t + (cid:18)1"t
(cid:18)1)"t
((cid:18)k+1
1

(cid:0)

(cid:0)
k
(cid:0)

= (cid:22)k +

1 + ::: + (cid:18)k

1"t

(k
(cid:0)
1) + ::: + ((cid:18)k+q

(cid:0)

(cid:0)
(K

(cid:0)

1) + ((cid:18)k
(cid:18)q)"t

(cid:0)

(cid:0)

(cid:0)

(cid:0)
q + :::

1)"t

k +

(cid:0)

(cid:18)j"t

j +

(cid:0)

1

((cid:18)k+j

(cid:18)j)2"t
j
(cid:0)

(cid:0)

j=0
X
yt

j=0
X
k may be written as

(cid:0)

(cid:0)

Then the variance of yt

V (yt

yt

k) = (cid:27)2
(cid:0)

(cid:0)

k

1

(cid:0)

j=0
X

j + (cid:27)2 1
(cid:18)2
j=0
X

((cid:18)k+j

(cid:18)j)2

(cid:0)

From the previous equation we can see that when k tends to in…nity, the variance
of (cid:1)kyt is equal to

V ((cid:1)kyt) = 2(cid:27)2

k

1

(cid:0)

(cid:18)2
j

Now the …rst di¤erence of a trend stationary process, (cid:1)yt is

j=0
X

yt

(cid:0)

yt

(cid:0)

1 = (cid:22) + "t + ((cid:18)1
+::: + ((cid:18)k+q

(cid:0)
(cid:0)

1)"t
(cid:0)
(cid:18)k+q

1 + ::: + ((cid:18)k+1
q + :::::::
1)"t

(cid:0)

(cid:0)

(cid:0)

(cid:18)k)"t

(k+1)

(cid:0)

Then the variance of the …rst di¤erence can be written as

V (yt

(cid:0)

(cid:0)

yt

1) = V ("t + ((cid:18)1

1)"t

1 + ::: + ((cid:18)k+1

(cid:18)k)"t

(cid:0)

(k+1)

(cid:0)

1)"t

(k+q) + :::::::)

(cid:0)
+::: + ((cid:18)k+q

(cid:0)
(cid:18)k+q

(cid:0)

= (cid:27)2(1 +

((cid:18)j+1

(cid:0)

1

j=0
X

(cid:0)

(cid:0)
(cid:18)j)2)

The variance ratio should be

(cid:21)1(k) =

V ar((cid:1)kyt)
V ar((cid:1)1yt)

=

1

k

(cid:0)

j=0 (cid:18)2
(1 +

P

j + (cid:27)2

1j=0((cid:18)k+j

1j=0((cid:18)j+1
P

(cid:0)

(cid:18)j)2

;

(cid:0)
(cid:18)j)2)

P

12

and the limit when k tends to in…nity is

lim
!!1

k

(cid:21)1(k) = lim

k

!!1

V ar((cid:1)kyt)
V ar((cid:1)1yt)

= lim
k

!!1

(1 +

1

k

j=0 (cid:18)2
2
(cid:0)
1j=0((cid:18)j+1
P

j

(cid:0)

:

(cid:18)j)2)

P

This expression is a constant and might be greater or smaller than one de-
pending on the (cid:18)j values. Therefore can simply distinguish between the two
models by simply noting that under the random walk assumption (cid:21)1 increase
with k and that under the trend stationary assumption (cid:21)1 tends to a constant.
Alternatively we can consider (cid:21)2 V ar((cid:1)kyt)=k. and note both, that when the
model is a random walk this expression tends to 1 (see proof above), and that
this ratio should tend to zero when k tends to in…nity since V ar((cid:1)kyt) is con-
stant for the trend stationary model.

Sampling distribution of (cid:21)(k) under the Random Walk Hypothesis.

H0) (cid:11) = 1 or

yt = (cid:22) + yt

1 + "t

"t~IIDN (0; )

(cid:0)
It can be shown that asymptotically under the null, pT k(^(cid:21)2(k)

a
~
1)). Then tests of the null Hypothesis can be carried out on the

1)

(cid:0)

N (0; 2(k
standardized statistics.

(cid:0)

13

1 Appendix

Brownian Motion

To show what is a BM we may start …rst considering a simple RW without

drift.

or

yt = yt

1 + "t; "t~N (0; 1)

(cid:0)

yt = "1 + "2 + ::: + "t

1 + "t and yt~N (0; t)

(cid:0)

Now consider the change between t and s

ys

(cid:0)

yt = "t + "t+1 + ::: + "s

is ~N (0; s
t < s < r < q:

(cid:0)

t) and is independent of changes between dates r and q whenever

Consider now the change between yt and yt

1 with "t~N (0; 1), and suppose

we view "t as the sum of two independent Gaussian variables.

(cid:0)

"t = e1t + e2t with eit~N (0; 1=2)

We may associate e1t with the change between yt

1 and yt at some interim

(cid:0)

point, say yt

1=2 , such that

(cid:0)

and

Sampled at an integer yt
as above such that,

(cid:0)

yt

1=2 (cid:0)
(cid:0)

yt

1 = e1t

(cid:0)

yt

(cid:0)

yt

1=2 = e2t

(cid:0)

yt

1 ~N(0,1), but we can consider n possible divisions

(cid:0)

yt

yt

1 = e1t + e2t + :::::: + eN t

(cid:0)
where eit ~i.i.d N(0,1=N ) .
The limit when N

(cid:0)

is a continuous process called a Standard Brownian
Motion. The value this process takes at date t is denoted W (t). A realization of
a continuous time process can be viewed as a stochastic function, denoted W (:)
where W : t

! 1

[0;

R:

)

2

1

!

De…nition of a SBM

W (:) is a continuous time process,associating each date t

scalar W (t) such that

(a) W (0) = 0

[0; 1] with the

2

14

(b) for any dates 0 < t1 < t2::: < tk < 1,

W (t2)
are independent multivariate Gaussian with W (ts)

W (t1); ::::::; W (tk)

W (tk

1).

(cid:0)

(cid:0)

(cid:0)

W (tt)~N(0,s

t)

(cid:0)

(cid:0)

(c) W (t) is continuous with probability 1.

The functional Central Limit Theorem

Recall the simplest version of the Central limit Theorem.
If "t~i.i.d with mean zero and variance (cid:27)2; then the sample mean ~"T =
1
T (cid:0)

T
t=1 "t and the central limit theorem states that

P

pT ~"T L
(cid:0)!

N (0; (cid:27)2)

Consider now an estimator based on the following principle: Given a sample
size T , we calculate the mean of the …rst half of the sample and throw out the
rest of the observations.

1
"[T =2](cid:3) = ([T =2](cid:3))(cid:0)

"t

[T =2]

where [T =2](cid:3) is the larger integer

e

t=1
X
than T =2; i.e.

(cid:21)

[T =2](cid:3) = T =2 f or T even

[T =2](cid:3) = (T

(cid:0)

1)=2 f or T odd:

This will also satisfy

[T =2](cid:3)~"[T =2](cid:3) L
(cid:0)!

p

N (0; (cid:27)2)

Moreover the estimator will be independent of an estimator that uses only the
second half of the sample.

More generally we can construct a Variable XT (r) from the sample mean of

the …rst rth fraction of observations, where r

[0; 1] de…ned by

2

XT (r) =

1
T

T r(cid:3)

t=1
X

"t

For any given realization XT (r) is a step function in r, with

XT (r) = 8
>><
>>:

0
"1=T
("1 + "2)=T
("1 + "2 + "3 + "4 + ::: + "T )=T

15

(cid:20)

for 0
for (1=T )
for (2=T )
for r = 1

r < (1=T )

r < (2=T )
r < (3=T )

(cid:20)
(cid:20)

then

but

pT XT (r) = (1=pT )

T r(cid:3)

t=1
X

"t = (pT r(cid:3)=pT )(1=pT r(cid:3))

"t

T r(cid:3)

t=1
X

T r(cid:3)

(1=pT r(cid:3))

t=1
X

"t L
(cid:0)!

N (0; (cid:27)2) while

(pT r(cid:3)=pT )

pr

!

Hence the asymptotic distribution of pT X(r) is that of pr times a N (0; (cid:27)2)

N (0; (cid:27)2r):
or pT XT (r) L
Clearly this implies that
(cid:0)!

pT XT (r)
(cid:27)

N (0; r):

L
(cid:0)!

Notice that this is evaluated at a given value r (N B

variable).

pT XT (r)
(cid:27)

is a random

We could consider the behaviour of the sample mean based on T r(cid:3)1 through

T r(cid:3)2 for r2 > r1 and conclude that

pT (XT (r2)
(cid:27)
Then a sequence of stochastic functions pT (XT (:)

XT (r1))

L
(cid:0)!

N (0; r2

(cid:0)

r1)

(cid:0)

probability law that is described by a standard Brownian motion.

(cid:27)

1T =1 has an asymptotic
j

pT (XT (:))
(cid:27)

L
(cid:0)!

W (:) (this is a random f unction)

1
This function evaluated at r = 1 is just the sample mean, XT (1) = T (cid:0)

then when r = 1 the CLT is a special case of this function, that is

N (0; 1)

Convergence in Functions

T
t=1 "t,

pT (XT (1))
(cid:27)

P

W (1) =

L
(cid:0)!

Let S(:) represent a continuous time stochastic process with S(r) repre-
[0; 1]. Suppose further that for any
senting its value at some date r for r
given realization S(:) is a continuous function of r with probability 1, being
ST (:)

1T =1 a sequence of such continuous functions,

2

f

gj

We say that

ST (:) L
(cid:0)!

S(:) whenever the following holds:

a) For any …nite collection of k particular dates 0 < r1 < r2:::: < rk

sequence of k dimensional random vectors yT L
(cid:0)!

y where

16

1, the

(cid:20)

yT

(cid:17)

(cid:20)

ST (r1)
ST (rk)

(cid:21)

and y

S(r1)
S(rk)

(cid:21)

(cid:17)

(cid:20)

b) For each " > 0 the probability that ST (r1) di¤ers from ST (r2) for any dates
r1 and r2 within a distance (cid:14) of each other goes to zero uniformly in T as
(cid:14)

0:.

c) P

!
ST (0)
j

fj

> (cid:21)

g !

0 uniformly in T as (cid:21)

.
! 1

This de…nition applies to sequences of continuous functions though XT (r) is
a discontinuous step function. Fortunately the discontinuities occur at count-
able points.

Convergence for a sequence of Random Functions.

It will be helpful to extend the earlier de…nition of convergence in probability

to sequences of random functions.

Let

ST (:)
f
functions with

gj

1T =1 and

VT (:)
f

gj

1T =1 denote sequences of random continuous

ST : r

[0; 1]

2

!

R;

VT : r

[0; 1]

R:

!

2

Let the scalar YT represent the largest amount by which ST (r) di¤ers from
VT (r).

YT = Sup

ST (r)
j

VT (r)
j

(cid:0)
Then
1T =1 is a sequence of random variables and we could talk about its
probability limit. If the sequence converges in probability to 0, then we can say
that

YT
f

gj

ST (r) P
(cid:0)!

VT (r)

ST (r)
or Sup
j

VT (r)
j

(cid:0)

0:

P
(cid:0)!

ST (:)
This can be generalized to sequences of functions. For example, if
1T =1
gj
f
ST (:) and
1T =1 are sequences of continuous functions with VT (:) P
(cid:0)!

S(:), for S(:) a continuous function, then VT (:) L
(cid:0)!

VT (:)
and
f
ST (:) L
(cid:0)!

S(:)

gj

Continuous Mapping Theorem

If g(:) is a continuous functional, which could associate a real variable y with
S(:) and

the stochastic function S(:), then the theorem states that if ST (:) L
(cid:0)!
g(:) is a continuous functional, then g(ST (:)) L
(cid:0)!

g(S(:))

( Examples of continuous functionals)

17

y =

1
0 S(r)dr or y =

1

0 [S(r)]2dr

R
Example

Given

pT XT (:)
(cid:27)

L
(cid:0)!

R

W (:) , we can simply use the theorem to get

pT XT (:) L
(cid:0)!

(cid:27)W (:)

[pT XT (:)]2 L
(cid:0)!

[(cid:27)W (:)]2

Applications to Unit Root Processes

Example: a Random Walk.

yt = yt

1 + "t

(cid:0)

"t~iid(0; (cid:27)2)

or

or

this can be used to express the stochastic function

yt = "1 + "2 + :::::: + "t

1 + "t

(cid:0)

0
y1=T
y2=T
yT =T

XT (r) = 8
>><
>>:

(cid:20)

for 0
for (1=T )
for (2=T )
for r = 1

r < (1=T )

r < (2=T )
r < (3=T )

(cid:20)
(cid:20)

18

Notice that the tth rectangle has width 1=T and height yt

1=T: The total

(cid:0)

area is then

1

XT (r)dr = y1=T 2 + y2=T 2 + ::::::::::: + yT

0
Z
Multiplying both sides by pT

1=T 2
(cid:0)

pT XT (r)dr = T (cid:0)

3=2

1

0
Z

T

t=1
X

yt

1

(cid:0)

But we know from the continuous mapping theorem that as T

! 1

( since [pT XT (:)]

pT XT (r)dr L

[(cid:27)W (r)]dr

1

0
(cid:0)! Z
[(cid:27)W (:)]); implying

1

0
Z

L
(cid:0)!

3=2

T (cid:0)

T

t=1
X

yt

1 L

(cid:0)

0
(cid:0)! Z

1

[(cid:27)W (r)]dr

Distribution of the OLS estimator under the Unit root Hypothesis

Consider now the following autoregressive process

yt = (cid:26)yt

1 + "t

(cid:0)

"t~iid(0; (cid:27)2)

T
t=1 yt
(cid:0)
T
t=1 y2
t
(cid:0)
then and assume that we want to test the null

(^(cid:26)T (cid:0)

(cid:26)) =

P

1

1"t

P

H0) (cid:26) = 1 .

T (^(cid:26)T (cid:0)

1) =

1
T (cid:0)
2
T (cid:0)
P

1"t

T
t=1 yt
(cid:0)
T
t=1 y2
t
(cid:0)

1

Then the distribution of the denominator can be easily obtained since

P

2
T (cid:0)

T

t=1
X

because

1

[(cid:27)W (r)]2dr

y2
t
(cid:0)

1 L

0
(cid:0)! Z

[pT XT (:)] L
(cid:0)!
[pT XT (:)]2 L
(cid:0)!

[(cid:27)W (:)];

[(cid:27)W (:)]2;

19

1

0
Z

[pT XT (r)]2dr L

[(cid:27)W (r)]2dr;

1

0
(cid:0)! Z

2
T (cid:0)

T

t=1
X

y2
t
(cid:0)

1 =

1

0
Z

[pT XT (r)]2dr

and

This is because

0
(y1=T )2
(y2=T )2
.
(yT =T )2

(XT (r))2 = 8
>>>><
>>>>:

and

r < (1=T )

r < (2=T )
r < (3=T )

(cid:20)
(cid:20)

(cid:20)

for 0
for (1=T )
for (2=T )
.
for r = 1

1

0
Z

[pT XT (r)]2dr = T

(y1)2 =T 3 + (y2)2 =T 3 + ::::::::::: + (yT

(cid:16)

1)2 =T 3
(cid:0)

:

(cid:17)

Also

T

1
T (cid:0)

1
(Recall that T (cid:0)

then

(1=2)(cid:27)2[W (1)2

1]

(cid:0)

yt

(cid:0)

1"t L
(cid:0)!
1"t = (1=2T )y2

t=1
X
T
t=1 yt

(cid:0)

T (cid:0)

P

T (^(cid:26)T (cid:0)

1) =

P
(1=2)(cid:27)2[W (1)2

(cid:0)
1
0 [(cid:27)W (r)]2dr

1]

R

T
t=1(1=2T )"2

t (when y0 = 0))

Recall that W (1)2 is chi square with one degree of freedom. The probability
that a Chi-Square is less than 1 is .68 and since the denominator is positive,
1 is negative approaches 0.68 as T tends to in…nity.
the probability that ^(cid:26)T (cid:0)
In other words in two thirds of the samples generated by a RW, the estimate
will be less than the true value of unity or negative values will be twice as likely
than positive values.

In practice critical values for the random variable T (^(cid:26)T (cid:0)

1) are found by
calculating the exact small-sample distribution assuming the innovations are
Gaussian, generally by Monte Carlo.

^(cid:26)T is a super consistent estimator

20

It follows that ^(cid:26)T is a super consistent estimate of the true value.

pT (^(cid:26)T (cid:0)

1) =

T (cid:0)

3=2

1"t

2
T (cid:0)

T
t=1 yt
(cid:0)
T
t=1 y2
t
(cid:0)
2 (1=2)(cid:27)2[W (1)2

P

P

1

1

but the numerator converges to T (cid:0)

1] . The chi-square
function has …nite variance then the variance of the numerator is of order (1=T ),
meaning that the numerator converges in probability to zero, hence pT (^(cid:26)T (cid:0)
1)
P
(cid:0)!

(cid:0)

0

21

Cointegration

In economics we usually think that there exist long-run relationships between
many variables of interest. For example, although consumption and income may
each follow random walks, it seem reasonable to expect that there is a long run
relationship between these variables, or in other words that in the long run these
variables move together. The alternative scenario will be that Income increase
relative to consumption with time. This seems implausible. Other series that
appear to move together are: short term - long term interest rates, imports and
exports, prices and wages, stock prices and dividends ,etc.

Then the aim behind cointegration is the detection and analysis of long run
relationships amongst economic time series variables. Given that most eco-
nomic time series, appear to be non-stationary, they often require di¤erencing
or detrending to be transformed to stationarity. A problem with di¤erenc-
ing or detrending is that we may remove relevant long run information. The
cointegration analysis provides a way of retaining both short-run and long-run
information.

Another reason why we are concerned with cointegration is that sometimes
is thought to be a pre-requisite for the validity of some economic theory. For
example if short term and long term interest rates (assuming there are I(1)) are
not cointegrated, then, the term structure of interest rates cannot hold.

De…nitions
A linear combination of two I(1) variables, say Y and X can be either I(1)
or I(0). If this combination is I(1) the variables are said to be not-cointegrated.
If there are I(0) such that Y + (cid:11)X~I(0) then the variables are said to be coin-
tegrated.

Example 1
Consider the following model:

xt + (cid:12)yt = ut

xt + (cid:11)yt = et

ut = ut

1 + "1t

(cid:0)

et = (cid:26)et

1 + "2t with

(cid:0)

(1)

(2)

(3)

(4)

< 1

(cid:26)
j

j

("1t; "2t)0 is distributed identically and independently as a bivariate normal

with

E("1t) = E("2t) = 0

var("1t) = (cid:27)11; var("2t) = (cid:27)22; cov("1t"2t) = (cid:27)12

(5)

(6)

1

Solving for xt and yt form the above system with (cid:11)

= (cid:12) gives

xt = (cid:11)((cid:11)
((cid:11)
yt =

(cid:0)

(cid:0)
(cid:0)

(cid:12))(cid:0)
(cid:12))(cid:0)

1ut
(cid:12)((cid:11)
(cid:0)
1ut + ((cid:11)

(cid:12))(cid:0)
(cid:0)
(cid:12))(cid:0)
(cid:0)

1et;
1et:

Then we can conclude that both xt and yt are integrated of order one i.e.,
xt~I(1), yt~I(1), since ut is integrated of order one. Nonetheless xt + (cid:11)yt is
I(0) because et is stationary. In this example the cointegrating vector is (1,(cid:11))
and x + (cid:11)y is the equilibrium relationship. In the long run the variables move
towards the equilibrium x + (cid:11)y = 0 recognizing that this relationship need not
to be realized exactly even as t tends to in…nity.

In the bivariate case if the equilibrium condition exists, is unique.

Proof.
Suppose that there exist two distinct co-integrating parameters (cid:11) and (cid:13) such
that x + (cid:11)y and x + (cid:13)y are both ~I(0). This implies that ((cid:11)
(cid:13))yt is also I(0)
because a linear combination of two I(0) variable is also I(0). But we know that
for (cid:11)

(cid:13))yt ~I(1) therefore we have a contradiction unless (cid:11) = (cid:13).

= (cid:13) , ((cid:11)

(cid:0)

(cid:0)

Example
Consider the following example where cointegration of Prices and Dividends

is a necessary condition for markets e¢ ciency in the Fama sense.

Let us assume that stock prices might be written as

1

Pt =

(1=(1 + r))iE(Dt+i

It) + "t
j

i=1
X

where we may assume that "t is an I(0) process that might be, a white noise if
it represents, say a measurement error, or it might be an autoregressive process
if we assume agents are risk adverse. Let also assume Dt follows a random walk
which is a special case of an I(1) variable.

Dt = Dt

1 + (cid:23)t:

(cid:0)

Then, we may express stock prices as

Pt = (1=r)Dt + "t

Given that Dt are integrated of order one, stock prices also are integrated of
order one, since the sum of an I(1) process and an I(0) process is I(1).

We can easily see that if the theory is valid, (1;

cointegrating vector since

(1=r)) is going to be a

(cid:0)

(1;

(1=r))

(cid:0)

(cid:20)

Pt
Dt

2

(cid:21)

= Zt = "t

6
6
Notice that we assumed that "t was I(0), therefore if the theory holds dividends
and prices should be cointegrated.

Di¤erent Representations for a cointegrating relationship

Consider the model described in equations (1) - (6). Take

< 1; then
whenever xt and yt are cointegrated, we can show, for the simple two variables
model, that the system of two equations has di¤erent representations, namely,
vector autoregressive in levels, error-correction and moving-average representa-
tions.

(cid:26)
j

j

VAR Representation

Let us reproduce for expositional reasons equations (1), (2), (3) and (4)

xt + (cid:12)yt = ut

xt + (cid:11)yt = et

ut = ut

1 + "1t

(cid:0)
1 + "2t with

et = (cid:26)et

(cid:0)

(1)

(2)

(3)

(4)

< 1

(cid:26)
j

j

If we lag one period equations (1) and (2) and subtract the lagged value from
each expression we get

(cid:1)xt + (cid:12)(cid:1)yt = (cid:1)ut

(cid:1)xt + (cid:11)(cid:1)yt = (cid:1)et

(7)

(8)

Notice that

(cid:1)ut = "1t
(cid:1)et =
(1
(1
=

(cid:0)
(cid:0)

(cid:0)
(cid:0)

(cid:26))et
(cid:0)
(cid:26))(xt

1 + "2t and using equation (2)
1 + (cid:11)yt

1) + "2t

(cid:0)
then (7) and (8) might be rewritten as

(cid:0)

1 (cid:12)
1 (cid:11)

(cid:20)

(cid:21) (cid:20)

(cid:1)xt
(cid:1)yt

=

(cid:21)

(1

(cid:0)

(cid:0)

(cid:20)

and inverting the matrix we have

"1t
1 + (cid:11)yt

(cid:26))(xt

(cid:0)

1) + "2t

(cid:0)

(cid:21)

(cid:1)xt
(cid:1)yt

=

(cid:11)

(cid:21)

1

(cid:0)

(cid:12)

(cid:20)

(cid:11)
1
(cid:0)

(cid:20)

(cid:12)
(cid:0)
1

(1

(cid:0)

(cid:0)

(cid:21) (cid:20)

(cid:26))(xt

(cid:0)

"1t
1 + (cid:11)yt

1) + "2t

(cid:0)

(cid:21)

or

or

(cid:1)xt
(cid:1)yt

(cid:20)

(cid:1)xt
(cid:1)yt

(cid:20)

(cid:21)

(cid:21)

=

=

(cid:11)

1

(cid:11)

(cid:12)

(cid:20)

(cid:0)

1

(cid:0)

(cid:12)

(cid:20)

(cid:11)"1t + (cid:12)(1
"1t
(1

(cid:0)

(cid:0)

(cid:0)
(cid:0)

(cid:26))(xt
(cid:26))(xt

1 + (cid:11)yt
1 + (cid:11)yt

(cid:12)"2t

1)
(cid:0)
1) + "2t

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(9)

(cid:21)

(cid:12)(1
(1

(cid:0)

(cid:0)
(cid:0)

(cid:26))
(cid:26))

(cid:12)(1
(1

(cid:0)

(cid:0)
(cid:0)

(cid:26))(cid:11)
(cid:26))(cid:11)

(cid:21) (cid:20)

3

xt
yt

1

1

(cid:0)

(cid:0)

+

(cid:21)

(cid:20)

(cid:16) 1t
(cid:16) 2t (cid:21)

(cid:0)
(cid:0)

(cid:12)"2t)

(cid:12))(cid:0)
(cid:12))(cid:0)

1((cid:11)"1t
1("2t

where
(cid:16) 1t = ((cid:11)
(cid:16) 2t = ((cid:11)
Notice that this VAR representation IS NOT a VAR in the …rst di¤erences.
We would see later on that a VAR in …rst di¤erences is not a possible rep-
resentation when the variables are I(0). Notice that the var can be written
as

(cid:0)
"1t)

(cid:0)

xt
yt

=

(cid:11)

(cid:21)

1

(cid:0)

(cid:20)

(cid:12)

(cid:20)

(cid:12)(1

(cid:0)
(1

(cid:0)

(cid:26)) + 1
(cid:26))

(cid:0)

(cid:12)(1
(1

(cid:0)

(cid:0)

(cid:26))(cid:11)
(cid:0)
(cid:26))(cid:11) + 1

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

(cid:16) 1t
(cid:16) 2t (cid:21)

Error Correction Mechanism

In the 70’s the way to proceed when the series under consideration where
I(1) was just to take di¤erences of these series and then regress the di¤erenced
series. It has been shown that this procedure is unsatisfactory mainly because
it looses all long run information. (Also the interpretation of the coe¢ cients is
di¤erent from that one of the original regression)

In recent years one of the most popular ways of proceeding is to write our
models as ECM (error correction mechanisms). The strong motivation for this
In later
models was mainly empirical since these models perform very well.
years it have been shown that if two variables are cointegrated, there exist an
ECM representation for these variables. This representation has the advantage
that it keeps long run and short run information.

Consider a vector of I(1) variables Xt; then if Xt ~CI(1; 1) there exist an
error-correction representation for the data. A very general way of writing
these type of models is

(cid:30)(L)(1

L)Xt =

(cid:11)0Xt

1 + (cid:18)(L)"t;

(cid:0)

(cid:0)

(cid:0)

where (cid:11) is the cointegrating vector, (cid:18)(L) is a polynomial in the lag operator,
(cid:30)(L) is a …nite order lag polynomial with roots outside the unit circle and "t is
a white noise. Also (cid:30)(0) = I:

Alternatively we could write the model as

(cid:1)Xt =

(cid:11)0Xt

1 + (cid:8)(L)(cid:1)Xt + (cid:18)(L)"t;

(cid:0)

(cid:0)

where (cid:30)(L) = I + (cid:8)(L):
The intuition behind the error-correction model is that long run errors have
to be corrected in the short run dynamics such that the process can move closer
to its long run target.

Again let Xt = (X1t; X2t) and let Zt
Then the error correction equation for X2t is

(cid:0)

1 be the cointegrating relationship.

(cid:1)X2t = (cid:13)Zt

1 + (cid:8)1(L)(cid:1)X1t

1 + (cid:8)2(L)(cid:1)X2t

1 + (cid:18)(L)(cid:23)t

(cid:0)

(cid:0)

(cid:0)

4

Then if the error correction theory is true we will expect that (cid:13) < 0 which implies
that whenever Zt
1 > 0; i:e:; X2t is above the long run equilibrium, then, (cid:1)X2t
will be negative, i:e:; it will move in the direction of the equilibrium.

(cid:0)

An important implication of the theory of cointegration is that asset prices
cannot be cointerated if the weak e¢ ciency market hypothesis holds. This is
simply because if two asset prices are cointegrated, it is possible to forecast time
t returns using information available a t time t
1. This goes against the simple
no-arbitrage model.

(cid:0)

ECM representation.

Consider once more the two variables model. It can be seen that the ECM

representation follows directly from the VAR representation (equation (9)) .

(cid:1)xt
(cid:1)yt

=

(cid:11)

(cid:21)

1

(cid:0)

(cid:12)

(cid:20)

(cid:12)(1
(1

(cid:0)

(cid:0)
(cid:0)

(cid:20)

(cid:26))(et
(cid:26))(et

1)
1)

(cid:0)

(cid:0)

+

(cid:21)

(cid:20)

(cid:16) 1t
(cid:16) 2t (cid:21)

(9’)

Moving Average Representation
This follows directly from the VAR representation (1) and (2).
Equations (1) and (2) may be written in matrix notation as

1 (cid:12)
1 (cid:11)

xt
yt

=

(cid:21)

(cid:20)

ut
et

;

(cid:21)

(cid:21) (cid:20)

(cid:20)

which can be also written as

xt
yt

(cid:20)

=

(cid:11)

(cid:21)

or taking …rst diferences as

(cid:1)xt
(cid:1)yt

=

(cid:11)

(cid:21)

(cid:20)
and noting that

1

(cid:0)

1

(cid:0)

(cid:12)

(cid:20)

(cid:12)

(cid:20)

(cid:11)
1
(cid:0)

(cid:11)
1
(cid:0)

(cid:12)
(cid:0)
1

ut
et

;

(cid:21)

(cid:21) (cid:20)

(cid:12)
(cid:0)
1

(cid:1)ut
(cid:1)et

;

(cid:21)

(cid:21) (cid:20)

(cid:1)ut
(cid:1)et

(cid:20)

=

(cid:21)

(cid:20)

"1t

L)(1

(1

(cid:0)

(cid:0)

(cid:26)L)(cid:0)

1"2t

;

(cid:21)

we can obtain the MA representation as

(cid:1)xt
(cid:1)yt

=

1

(cid:11)

(cid:12)

(cid:11)
1
(cid:0)

(cid:12)
(cid:0)
1

"1t

(1

L)(1

(cid:26)L)(cid:0)

1"2t

:

(cid:21)

(cid:20)

(cid:21) (cid:20)
We have analyzed the possible representations assuming a cointegration re-
lationship between two variables. The concept of cointegration can be easily
extended to n-variables.

(cid:0)

(cid:0)

(cid:0)

(cid:20)

(cid:21)

5

Cointegration between n variables

De…nition
Consider a n

1 vector of stochastic variables Xt = (X1t; X2t; ::; Xnt). We
say that the elements of the vector are cointegrated of order (d; b), which we
denote Xt ~CI(d; b) if

(cid:2)

i) each of the components of Xt are I(d).

ii) there exists (at least) a vector such that Zt = (cid:11)0Xt is I(d

b) for d

b > 0.

(cid:21)

(cid:0)

Then, (cid:11) is called the cointegrating vector

If d = b = 0, then (cid:11)0Xt = 0 de…nes a long-run equilibrium relationship.
Notice that (cid:11) is not unique since for any non-zero scalar b, b (cid:11)0Xt is also inte-
grated of order zero. Then in speaking of the cointegrating vector, an arbitrary
normalization must be made, such that the …rst element of is unity.

If n > 2, there may be r

n

1 linearly independent (n

((cid:11)1; :::; (cid:11)r) such that A0Xt ~I(0), where A is the (n
such that rank(A)=r, where r is the cointegrating rank.

(cid:2)

(cid:20)

(cid:0)

1) vectors
(cid:2)
r) matrix A = [(cid:11)1;:::; (cid:11)r],

The vectors ((cid:11)1; :::; (cid:11)r) are not unique, since for any non-zero (r
b, b0A0Xt~I(0), so b0A0 could be described as a cointegrating matrix.

(cid:2)

1) vector

Granger’s Representation Theorem

In the two variables case we have shown that when two variables are coin-
tegrated they do have a VAR, an ECM and a MA representation. These were
particular cases of the Granger’s Representation Theorem which is valid for a
N variables vector.

Consider an n - vector time series Xt which satis…es:

(cid:8)(L)Xt = c + ut

P
i=1 (cid:8)iLi , and ut is a white noise with positive de…nite
where (cid:8)(L) = In
covariance matrix. It is assumed that det[(cid:8)(z)]= 0 which implies
1. Sup-
pose that there exist exactly r cointegrating relationships among the elements
of Xt . Then:

j (cid:21)

z
j

P

(cid:0)

(i) there exists an (n

(cid:2)

r) matrix A, of rank r < n such that A0Xt ~I(0).

(ii) (cid:1)Xt has an MA representation given by (cid:1)Xt = (cid:22) + (cid:9)(L)ut with

where

A0(cid:9)(1) = 0;

(cid:9)(L) = In +

1

(cid:9)iLi

To understand the meaning of the restriction A0(cid:9)(1) = 0 and its implica-
tions consider the MA

i=1
X

6

Now re-write it as Xt = Xt

1 + (cid:22) + (cid:9)(L)ut and substitute backwards to obtain

(cid:0)

(cid:1)Xt = (cid:22) + (cid:9)(L)ut

Xt = X0 + (cid:22)t + (cid:9)(1)

t

ui + (cid:17)t (cid:0)

(cid:17)0

i=1
X

where (cid:22) = E((cid:1)Xt) and

is a I(0) sequence: (cid:17)t =

(cid:17)tg
f

(cid:0)

1i=1 (cid:9)s+i
Then, pre-multiplying Xt by the cointegrating matrix A0, we get the coin-
tegrating relationship. Therefore each term in the right hand side has to be
I(0).

P

P

1S=0 asut

s,

(cid:0)

as =

A0Xt = A0(X0

(cid:0)

(cid:17)0) + A0(cid:22)t + A0(cid:9)(1)

ui + A0(cid:17)t

t

i=1
X

Then, it is easy to see that for A0Xt ~I(0), it is necessary that A0(cid:9)(1) = 0.
This is only a necessary condition. Stationarity of A0Xt further requires that
A0(cid:22) = 0. If (cid:22)
= 0, then unless A0(cid:22) = 0 is satis…ed, the linear combination A0Xt
will grow deterministically at rate A0(cid:22).

Notice that A0(cid:9)(1) = 0 implies that (cid:9)(1) is singular since A0 is a matrix
with r LI vectors. This means that the matrix operator (cid:9)(L) is non invertible.
Thus, a cointegrated system can never be represented by a …nite-order VAR for
(cid:1)Xt:

(iii) (cid:8)(1) = BA0

Theorem 1

The (n

n) matrix (cid:8)(1) has a reduced rank r < n, and there exists an

(cid:2)

r) matrix B such that (cid:8)(1) = BA0.

(n
Proof. Consider an n-vector time series Xt which satis…es:

(cid:2)

and the Wold representation

(cid:8)(L)Xt = c + ut

(cid:1)Xt = (cid:22) + (cid:9)(L)ut:

Then multiplying the Wold representation by (cid:8)(L), we get

and using the autoregressive representation (multiplied by(1

(1

(cid:0)

L)(cid:8)(L)Xt = (cid:8)(1)(cid:22) + (cid:8)(L)(cid:9)(L)ut

L)) we get

(cid:0)

(1

(cid:0)

L)(cid:8)(L)Xt = (1

L)(c + ut)

(cid:0)

7

6
and equating the last two expressions we get

(1

(cid:0)

L)ut = (cid:8)(1)(cid:22) + (cid:8)(L)(cid:9)(L)ut

(cid:0)

L)c = 0) then, the above expresion implies that:

(since (1
1) (cid:8)(1)(cid:22) = 0.
L) = (cid:8)(L)(cid:9)(L), in particular for L = 1, requires that (cid:8)(1)(cid:9)(1) = 0:
2) (1
Let (cid:25)0 denote a row of (cid:8)(1); then conditions 1) and 2) imply that (cid:25) is a

(cid:0)

cointegrating vector.

Now if a1; a2; :::ar form a basis for the space of cointegrating vectors, then
we can express, (cid:25)nx1 = (a1; a2; :::ar)nxrbr
1; since any linear combination of
a cointegrating vector is also a cointegrating vector.or (cid:25)0 = b0A0 Applying the
same reasoning for each of the rows of the rows we get

(cid:2)

(cid:8)(1) = BA0

(iv) There exist a VAR representation in Levels and the determinant of the
polynomial in (cid:8) has a unit root. This can be shown by noticing that (cid:8)(1)
is singular.

(v) Error Correction Representation.

To show this point we …rst need to transform the original VAR

using the following relationship

(cid:8)(L)Xt = c + ut;

In

(cid:0)

p

i=1
X

(cid:8)iLi = In

(cid:0)

P

(

(cid:8)i)L

i=1
X

(I

(cid:0)

(cid:0)

L)

1

p
i=j (cid:8)j+1
(cid:0)

(cid:0)

for j = 1; :::; p

1

(cid:0)

p

1

(cid:0)

i=1
X

(cid:0)iLi

where

(cid:0)i =
Then

P
p

(cid:8)iLi)Xt =

In

(In

(cid:0)

i=1
X

Then rearranging terms

p

(cid:0)

i=1
X

(cid:8)i)L + (I

L)

(cid:0)

p

1

(cid:0)

i=1
X

(cid:0)iLi

!!

Xt = c + ut:

p

Xt = c + (

(cid:8)i)Xt

1 +

(cid:0)

p

1

(cid:0)

i=1
X

(cid:0)i(cid:1)Xt

i + ut

(cid:0)

= c +

(cid:0)i(cid:1)Xt

i + (In

(cid:8)(1)) Xt

1 + ut

(cid:0)

(cid:0)

i=1
X
p
1
(cid:0)

i=1
X

(cid:0)

8

p

1

(cid:0)

(cid:1)Xt = c +

i=1
X

(cid:0)i(cid:1)Xt

i
(cid:0)

(cid:0)

(cid:8)(1)Xt

1 + ut

(cid:0)

From this expression we can derive the following results.

(a) If rank [(cid:8)(1)] = 0 then (cid:8)(1) = 0 and Xt~I(1) since we can write everything
in terms of a VAR in diferences. This is only valid when the variables do
not cointegrate.

(b) If rank [(cid:8)(1)] = n then det((cid:8)(1))

= 0 ((cid:8)(L) does not have a unit root). This
implies that Xt~I(0) and therefore it should have a MA representation
since we can invert the original expression, i:e:;

Xt = (cid:8)(L)(cid:0)

1(c + +ut)

(c) If rank [(cid:8)(1)] = r; 0 < r < n then (cid:8)(1) = BA0; where B is an nxr matrix .

(See a explanation of these in the section about Johansen Procedure).

Restrictions in the parameters of the Error Correction Representation.

p

1

(cid:0)

(cid:1)Xt = c +

i=1
X

(cid:0)i(cid:1)Xt

i
(cid:0)

(cid:0)

BZt

1 + ut; Zt = A0Xt

(cid:0)

In this error-correction representation all variables are I(0). Then the term
A0Xt is viewed as the ”error” from the long run equilibrium relationship, and
B gives the ”correction” to Xt caused by this error.

Notice that taking expected values in both sides we get;

[I

(cid:0)

(cid:0)iLi]E((cid:1)Xt) = c

(cid:0)

BE(Zt

1)

(cid:0)

p

1

(cid:0)

i=1
X

Thus, in order to have a system in which there is no drift in any of the variables
[i.e., E((cid:1)Xt) = 0 ], we need to impose the restriction c = BE(Zt
1) (this is
equivalent to A0(cid:22) = 0) In the absence of such a restriction, it is implied by the
r separate time trends that account for the trend Xt .
ECM that there are n

(cid:0)

(cid:0)
Then imposing this restriction we obtain

(cid:1)Xt = BE(Zt

1) +

(cid:0)

p

1

(cid:0)

i=1
X

=

B(Zt

1

(cid:0)

(cid:0)

E(Zt

1)) +

(cid:0)

(cid:0)

9

(cid:0)i(cid:1)Xt

i +

(cid:0)

(cid:0)

BZt

1 + ut

(cid:0)

p

1

(cid:0)

i=1
X

(cid:0)i(cid:1)Xt

i + ut

(cid:0)

6
the intercept enters the system only via the error-correction term and there is
no autonomous growth component.

Again notice that A is not unique since (cid:8)(1) = BA0 = BP P (cid:0)

1A0 = B(cid:3)A(cid:3)0,

for all r

(cid:2)

r non-singular matrices P .

Tests For Cointegration.

Univariate Tests for Cointegration.

1) Two Stages Approaches

First stage: A static Regression
For the model

yt = (cid:12)xt + "t

Regress y on x using OLS achieves a consistent estimate of the long-run steady
-state relationship between the variables of the model, and all dynamics and en-
dogeneity issues can be ignored asymptotically. This arises because of the super
consistency property of the OLS estimator when the series are cointegrated.

Suppose that the model that dynamic model that captures both short ad-

justment and the long run relationship is

yt = (cid:13)oxt + (cid:13)1xt

1 + (cid:11)yt

1 + "t

(cid:0)

(cid:0)

This can be re-written as

yt = (cid:21)0xt + (cid:21)1(cid:1)xt + (cid:21)2(cid:1)yt + "t

where (cid:21)0 = (cid:13)0+(cid:13)1

(cid:13)1
(cid:11)
(cid:11) :
(cid:11) , (cid:21)2 = (cid:0)
(cid:11) , (cid:21)1 = (cid:0)
1
1
(cid:0)
(cid:0)
(cid:0)

1

Thus, estimating the static model to obtain the long-run parameter (cid:12) is
equivalent to estimating the dynamic model without the short run terms. Ac-
cording to the super consistency property if yt and xt are both non-stationary
I(1) variables, and "t ~I(0), then as the sample size, T , becomes larger the OLS
estimator converges to its true value at a much faster rate than the I(0) vari-
ables. Of course the omitted dynamic terms are captured by the residuals. This
we will see later will be a problem in short samples.

As a second stage I can use alternative testing
stragesies:

i) Make an (ADF) test for unit roots for the residuals:: The Engle -

Granger Approach.

10

If you do not reject the Hypothesis that the residuals have a unit root (that
there are I(1)), then Y and X are not cointegrated. On the other hand if you
do reject this hypothesis against the stationary alternative, then you conclude
that the residuals ( a linear combination of Y and X ) are I(0), then Y and X
are cointegrated.

Therefore we regress

(cid:1)^"t = (cid:30)^"t

1 +

(cid:0)

(cid:30)i(cid:1)^"t

i + (cid:22) + (cid:14)t + (cid:16) t

(cid:0)

p

1

(cid:0)

i=1
X

The question of including a trend and or a constant term in the test regression
depends of whether this terms appear in the original regression. That is the
deterministic component can be added either to the static regression or to the
ADF regression, but not to both. Hansen (1992) has shown that including a
deterministic trend results in loss of power.1

Note that is not possible to use standard Dickey - Fuller critical values. The
standard table will tend to over reject the null of no cointegration. Note also
that the distribution of the test statistic under the null is a¤ected by the number
of regressors included in the static model.

Fortunately MacKinon (1991) provides Table which has linked the critical
values for particular tests to a set of parameters of an equation of response
surfaces.

C(p) = (cid:30)

1

+ (cid:30)1T (cid:0)

2
1 + (cid:30)2T (cid:0)

Response surfaces for critical values of cointegration tests.

1 Notice that if we consider the simple DF test for the residuals

This can be re-written (evaluating at (cid:12) = ^(cid:12) )

(cid:1)^"t = (cid:30)^"t

1 + (cid:16)t

(cid:0)

or

(cid:1)(yt

(cid:0)

(cid:12)xt) = (cid:30)(yt

1

(cid:0)

(cid:0)

(cid:12)xt

1) + (cid:16)t

(cid:0)

This model is not an unrestricted ECM and it imposes that the change in the short run is the
same that the long run e¤ect. This is unlikely to be true.

(cid:1)yt = (cid:12)(cid:1)xt + (cid:30)(yt

1

(cid:0)

(cid:0)

(cid:12)xt

1) + (cid:16)t:

(cid:0)

11

n Model %point
1

no C
no t

1
5
10
1
5
10
1
5
10
1
5
10

1 C

no t

1 C
t

3 C

no t

1

(cid:30)
-2.5658
-1.9393
-1.6156
-3.4336
-2.8621
-2.5671
-3.9638
-3.4126
-3.1279
-4.2981
-3.7429
-3.4556

(cid:30)1
-1.960
-0.398
-0.181
-5.999
-2.738
-1.438
-8.353
-4.039
-2.418
-13.790
-8.352
-6.241

(cid:30)2
-10.04
0.0
0.0
-29.25
-8.36
-4.48
-47.44
-17.83
-7.58
-46.37
-13.41
-2.79

where C(p) is the p per cent critical value.

The Cointegrating Durbin-Watson.

ii) The null may be tested using the Sargan-Bhargava or CDW test

This test is very simple and consist in comparing the DW statistic with tabu-
lated values. The rationality of this procedure is as follows: Consider equations
(2) and (4).

xt + (cid:11)yt = et

et = (cid:26)et

1 + "2t with

(cid:0)

< 1

(cid:26)
j

j

(2)

(4)

A regression of xt on yt will yield serially correlated residuals. We can use
the DW statistic to get information about (cid:26) since this statistic is approximately
2(1

(cid:26)).

(cid:0)

DW (cid:24)= 2(1

(cid:26))

(cid:0)

Then if (cid:26) is equal to 1 (a unit root), the DW statistic equals zero. Sar-
gan and Bhargava provide tables to test this hypothesis. However, this critical
value is only relevant when the disturbance follows a …rst order autoregressive
process and there is there no higher serial correlation, which is unlikely. Thus
the CRDW test is generally not a suitable test statistic.

2) Three Stages:The Engle-Granger-Yoo Approach.

12

Engle and Yoo propose a third step to the standard Engle-Granger proce-
dure which seeks to overcome some of the problems inherent in using the static
model which yields (cid:12) generally biased in small samples. Assuming that there is
a unique cointegration vector and weak exogeneity of the short run parameters,
then the third step provides a correction of the …rst stage estimate of (cid:12) and en-
sures it has a normal distribution. The methodology consists of correcting the
long-run relationship by the small sample bias ((cid:13)=(1
(cid:11))) and use the correct
residuals to perform the ADF test.

(cid:0)

Stg1 Regress yt = (cid:13)oxt + (cid:13)1xt

Stg2 Construct

(cid:0)
(cid:13)1
(cid:11) xt
(cid:0)
b
Stg3 Perform an ADF test for
b

ut = yt

(cid:13)0+
1

ut:

(cid:0)

b

b

1 + (cid:11)yt

1 + "t

(cid:0)

b

Cointegration in Multivariate Systems- The Johansen Approach

De…ning zt , a vector of n potentially endogenous variables it is possible to
specify the following DGP and the model zt as an unrestricted VAR involving
k-lags of zt

zt = A1zt

1 + ::: + Akzt

k + ut

(cid:0)

(cid:0)

where zt is n
above this equation can be written as a vector error-correction model

1 and each of the Ai is n

n matrix of parameters. As we show

(cid:2)

(cid:2)

(cid:1)zt = (cid:0)1(cid:1)zt

1 + ::: + (cid:0)k

1(cid:1)zt

k

1 + (cid:5)zt

k + ut

(cid:0)
Ai) (i = 1; ::; k

(cid:0)

(cid:0)

(cid:0)
1), and (cid:5) =

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(I

(I

:::

A1

A1

Ak).2
where (cid:0)i =
This way of specifying the system contains information on both the short run
and the long run adjustments to changes in zt , via the estimates of ^(cid:0)i and
^(cid:5) respectively. As it will be seen, (cid:5) = (cid:11)(cid:12)0, where (cid:11) represents the speed
of adjustment to disequilibrium, while (cid:12) is a matrix of long-run coe¢ cients
such that the term (cid:12)0zt
1 cointegration relationships.
Assuming that zt is a vector of non-stationary I(1) variables, then all the terms
in di¤erences are I(0) while (cid:5)zt
k must also be I(0) for the error term to be a
white noise.

k represents up to n

:::

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

There are two cases where this requirement is met:

1. When there is no cointegration at all, implying that there are no linear
n
combinations of zt that are I(0), and consequently (cid:5) is a matrix of n
zeros. In this case the appropriate model is a VAR in di¤erences.

(cid:2)

2 Notice that in this presentation the variable in levels is LAG k, while in the previous
presentation the variable in levels was lag 1. The analysis can be carried out in both ways.

13

2. When there exist up to n

(cid:20)

(cid:0)

1 cointegration relationships (cid:12)0zt
n

k ~I(0).
In this instance there will exist a number r
1 cointegration vectors
where r is the number of columns of which form r LI combinations of the
variables in zt , together with (n
r) non-stationary vectors in (cid:12). Only the
cointegration vectors in enter in the VECM, which implies that for the last
(n
r) columns, the are insigni…cantly small. Thus the typical problem
faced, of determining how many r cointegration vectors exist amounts to
equivalently testing which columns in (cid:5) are zero. Consequently testing for
cointegration amounts to a consideration of the rank of (cid:5), that is, …nding
the number of r linearly independent columns in (cid:5).

(cid:0)

(cid:0)

(cid:0)

(cid:0)

If (cid:5) is f ull rank the variables in zt have to be I(0)
If (cid:5) is zero there is no cointegrating vector
If (cid:5) is reduced rank the number of cointegrating vectors is the RAN K((cid:5))

(cid:0)
(cid:0)
(cid:0)

Canonical Correlations

Population Canonical Correlations
Let the (n1

1) vector yt and the (n2

1) vector xt denote stationary
random variables. Typically this variables are measured in deviations from the
population mean such that E(yty0t) represents the variance-covariance matrix of
yt .

(cid:2)

(cid:2)

In general

E(yty0t) E(ytx0t)
E(xty0t) E(xtx0t)

=

(cid:6)Y Y (cid:6)Y X
(cid:6)XY (cid:6)XX

(cid:20)

(cid:21)
We can often gain some insight into the nature of these correlations by de…ning
1) random vectors 't and (cid:24)t , where n is the smaller of n1 and n2
two new (n
.

(cid:2)

(cid:20)

(cid:21)

't = K 0yt
(cid:24)t = A0xt

The matrices K 0 and A0 are chosen such that

E(yty0t) E(ytx0t)
E(xty0t) E(xtx0t)

=

(cid:21)

(cid:20)

(cid:6)Y Y (cid:6)Y X
(cid:6)XY (cid:6)XX

(cid:21)

(cid:20)

E('t'0t) = K 0(cid:6)Y Y K = I;

E((cid:24)t(cid:24)0t) = A0(cid:6)XX A = I and,

14

E('t(cid:24)0t) = R = 2

r1

r2

0

3

7
7
where the elements of 't and (cid:24)t are ordered in such a way that1
5

6
6
4

rn

0

r2::::::

rn

0

(cid:21)

(cid:21)

r1

(cid:21)

(cid:21)

The population ri is known as the ith population canonical correlation be-

tween yt and xt .

The canonical correlations can be calculated by calculating the eigen values

of

1
(cid:6)(cid:0)

1
Y Y (cid:6)Y X (cid:6)(cid:0)

XX (cid:6)XY ;

(cid:21)1 > (cid:21)2 > :::(cid:21)n , and the canonical correlations turn out to be the square roots
of these eigenvalues.

The Johansen Method of reduced rank regression

The procedure may be described as follows:
First rewrite the ECM Equation

(cid:1)zt + (cid:11)(cid:12)0zt

k = (cid:0)1(cid:1)zt

1 + ::: + (cid:0)k

(cid:0)

(cid:0)

1(cid:1)zt

(k

(cid:0)

1) + ut

(cid:0)

(cid:0)

it is possible to correct for the short run dynamics (i.e., take out their e¤ect)
by regressing (cid:1)zt and 0zt
k separately on the right hand side of the previous
equation, i.e.,

(cid:0)

(cid:1)zt = P1(cid:1)zt
k = T1(cid:1)zt
zt

1 + ::: + Pk
1 + ::: + Tk

1(cid:1)zt
(cid:0)
1(cid:1)zt

(cid:0)

(cid:0)

(cid:0)

(cid:0)

1) + R0t
(cid:0)
1) + Rkt

(k

(cid:0)

(k

(cid:0)

(cid:0)

Which can be used to form the residual (product moment) matrices

1
Sij = T (cid:0)

Rit

R0jt

i; j = 0; k

The maximum likelihood estimate of (cid:12) is obtained as eigenvectors corresponding
to the largest eigenvalues from solving the equation

b

b

b

X

(cid:0)

(cid:21)
j

= 0

S0k

S0k

Skk

1
S(cid:0)
00
which gives the n eigenvalues ^(cid:21)1 > ^(cid:21)2 > :::::^(cid:21)n and their corresponding eigen
b
vectors, ^' = (^'1 > ^'2 > ::: > ^'n). Those r elements in ^' which determine lin-
ear combinations of stationary relationships can be denoted (cid:12) = (^'1; ^'2; :::; ^'r),
that is, these are the cointegration vectors. This is because the eigen values are
the largest squared canonical correlations between the ”levels”residuals Rkt and
the ”di¤erences” residuals R0t, that is, we obtain estimates of all the distinct

b

b

b

j

15

^'0izt combinations of the I(1) levels of zt which produce high correlations with
the stationary (cid:1)zt elements, such combinations being the cointegrating vectors
by the virtue of the fact that they must themselves be I(0) to achieve a high
correlation. Thus the magnitude of ^(cid:21)i is a measure of how strongly the coin-
tegration relations are correlated with the stationary part of the model. The
last (n
r) combinations indicate the non-stationary combinations and theo-
retically are uncorrelated with the stationary elements. Consequently, for the
eigenvectors corresponding to the non-stationary part of the model, ^(cid:21)i = 0 for
i = r + 1; :::::::; n:

(cid:0)

Testing for reduced rank

To …nd the number of cointegrating vectors we said that is equivalent to
r

…nd the number of linearly independent columns in (cid:5) or the number of n
columns of signi…cantly small.

(cid:0)

The approach amounts to a reduced rank regression which provides n eigen-
values ^(cid:21)1 > ^(cid:21)2 > :::::^(cid:21)n and their corresponding eigen vectors,^' = (^'1 > ^'2 >
::: > ^'n). Those r elements in ^' which determine linear combinations of station-
ary relationships can be denoted (cid:12) = (^'1; ^'2; :::; ^'r) that is, the distinct ^'0izt ,
which we will denote (cid:12)0izt , are correlated with the stationary part of the model.
The last n
r combinations obtained from the Johansen approach indicate the
non stationary combinations, and theoretically these are uncorrelated with the
stationary elements in the ECM. Consequently, for the eigenvectors correspond-
ing to the non-stationary part of the model, ^(cid:21)i = 0 for i = r + 1; :::; n.

(cid:0)

Thus to test the null hypothesis that there are at most r cointegration vectors

amounts to test

H0)(cid:21)i = 0

i = r + 1; ::::; n:

where only the …rst r eigenvalues are non-zero.
alternative of n cointegrating vectors).

(This is tested against the

It can be shown (see Hamilton) that the likelihood test that corresponds to

the ECM under the null that there are only r cointegrating vectors is

L(cid:3)(H0) =

(T n=2)log(2(cid:25))

(cid:0)

(T n=2)

(cid:0)

(cid:0)

(T =2)log

S00

r

(T =2)

log(1

i=1
X

(cid:0)

^(cid:21)i):

(cid:0)

(cid:12)
(cid:12)
(cid:12) b

(cid:12)
(cid:12)
(cid:12)

It can also be shown that the likelihood test that corresponds to the ECM
without any restriction on the number of cointegrating vectors is

L(cid:3) =

(T n=2)log(2(cid:25))

(cid:0)

(T n=2)

(cid:0)

(cid:0)

n

(T =2)

log(1

i=1
X

(cid:0)

^(cid:21)i):

(cid:0)

(T =2)log

S00

(cid:12)
(cid:12)
(cid:12) b

(cid:12)
(cid:12)
(cid:12)

16

Then a likelihood ratio test, using a non standard distribution, can be con-
structed, using what is known as the Trace statistic.

n

(cid:21)trace =

T

(cid:0)

log(1

^(cid:21)i)

(cid:0)

r = 0; 1; :::; n

2; n

1

(cid:0)

(cid:0)

i=r+1
X

Another test of the signi…cance of the largest (cid:21)r is the so called maximal-

eigenvalue or (cid:21)

(cid:0)

max statistic :

(cid:21)max =

T log(1

(cid:0)

^(cid:21)r+1)

(cid:0)

r = 0; 1; :::; n

2; n

1:

(cid:0)

(cid:0)

This tests the existence of r cointegrating vectors against the alternative that
r + 1 exist and is derived in exactly same way.

Testing restrictions on the cointegrating vector.

Many times we are interested to test restrictions on the cointegrating vector.
For example I might be interested in some theoretical long run relationship which
impose some restrictions on the values of the cointegrating relationship. We may
be also interested in testing whether we should include or not a regressor in the
cointegrating relationship.

The crucial point in deriving a LR test for these type of hypothesis is that
both under the null and the alternative there are r cointegrating relationships
and therefore the asymptotic theory is standard since the regressions only in-
volve variables which are I(0)and the test would be distributed chi-square. The
LR test will be

LR =

T

(cid:0)

r

i=1
X

log(1

(cid:0)

^(cid:21)i) + T

r

i=1
X

log(1

~(cid:21)i)

(cid:0)

17

Arch Models

Most investors dislike risk taking and require a premium for holding assets
with risky payo¤s. The variance of an asset has been used to measure risk, and
split the risk into a company speci…c component, which is diversi…able, and a
market component which cannot be diversi…ed. This measure of the uncondi-
tional volatility does not recognize that there may be predictable patterns in
stock market volatility. We will analyze models of conditional (on information
at time t-1) volatility. These type of models have the implication for …nance
that investors can predict the risk. This type of models successfully character-
ize the fact that stock prices seem to go through long periods of high and long
periods of low volatility.

The fact that market participants may predict volatility has important impli-
cations The most important is that for periods where the investor has forecasted
prices to be very volatile, she should either exit the market or require a large
premium as a compensation for bearing an unusual high risk.

Empirical Regularities of Asset Returns.
i Thick Tails

Asset returns tend to be leptokurtotic . The documentation of this empirical

regularity is presented in Mandelbrot (1965).

ii Volatility Clustering

" ... large changes tend to be followed by large changes, of either sign and

small changes tend to be followed by small changes "

iii Leverage E¤ ects

The so-called "leverage e¤ect" …rst noted by Black(1976) refers to the ten-
dency for stock prices to be negatively correlated with changes in stock volatility.
A …rm with debt and equity outstanding typically becomes more highly lever-
aged when the value of the …rm falls. This raises the equity return volatility.

iv) Non-Trading Periods

Information that accumulates when …nancial markets are closed is re‡ected
If for example, information accumulates
in prices after the markets reopen.
at a constant rate over calendar time, then the variance of the returns over the
period from Friday close to the Monday close should be three times the variance
from the Monday close to the Tuesday close.

v) Forecastable Events

1

Patell and Wolfson (1979,1981) show that individual …rm’s stock returns

volatility is high around earning announcements.

Introduction: Conditional and Unconditional moments

Before presenting the alternative Arch type models, we will brie‡y review

the di¤erence between conditional and unconditional moments.

Let us assume that yt follows a random walk, i.e.

yt = yt

1 + "t

(cid:0)

Then

t

yt = y0 +

"i

i=1
X

Unconditional Moments

The unconditional mean and variance are;

E(yt) = y0
V (yt) = t(cid:27)2

A RW has a constant unconditional mean but a time varying unconditional

variance.

Conditional Moments
The conditional mean and variance are;

V (yt

1) = E(yt

yt
j

(cid:0)

(cid:0)

E(yt

E(yt
yt
j

(cid:0)

1) = yt
yt
j
(cid:0)
1))2 = E(yt

(cid:0)

1
1 + "t

(cid:0)

E(yt

(cid:0)

yt
j

(cid:0)

1))2 = (cid:27)2

A RW has a constant unconditional mean but a time varying unconditional

variance.

So while the unconditional variance of a random walk model tends to in…nite

as t increase, the conditional variance is constant.

2

Univariate Parametric Models

Arch Models
In the linear Arch(q) model originally introduced by Engle(1982), the time
varying conditional variance is postulated to be a linear function of the past q
squared innovations.

q

(cid:27)2

t = ! +

i=1
X

i = w + (cid:11)(L)"2
(cid:11)i"2
t
t
(cid:0)
(cid:0)

1

A su¢ cient condition for the conditional variance to be positive is that the
parameters of the model satisfy the following constraints; ! > 0 and (cid:11)1 >
0; (cid:11)2 > 0; ; ::::(cid:11)q > 0
"2
De…ning (cid:23)t
t (cid:0)

t , the ARCH(q) model can be re-written as

(cid:27)2

(cid:17)

"2
t = ! + (cid:11)(L)"2
t
(cid:0)
1; "2
"2
( Notice that (cid:27)2
1((cid:23)t) = 0, the model corre-
t
t
(cid:0)
(cid:0)
sponds to an AR(q) model for the squared innovations, "2
t . Then, the process
is covariance stationary if and only if the sum of the positive autoregressive
parameters is less than one, in which case the unconditional variance equals

1 + (cid:23)t
2; :::::)) Since Et

t = E("2
t j

(cid:0)

V ar("2

t ) = !=(1

(cid:11)1

(cid:11)2:::

(cid:11)q):

(cid:0)
Even though "t ’s are serially uncorrelated they are clearly not independent
through time. In accordance with the stylized facts for assets returns discussed
above, there is a tendency for large (small) absolute values of the process to be
followed by other large (small) values of unpredictable sign.

(cid:0)

(cid:0)

The ARCH(1) Model

Constant unconditional Variance but non-constant conditional Variance.

Some useful statistical results are given below for the simplest ARCH(1)
model, which is identical to the one used by Engle (1982). The main result
is that this simple model exhibits constant unconditional variance but non-
constant conditional variance.

Consider the following model

yt = (cid:22) + "t

1)1=2; ut~IIN (0; 1); ! > 0; (cid:11) > 0
"t = ut(! + (cid:11)"2
t
(cid:0)

1)1=2 is the conditional standard deviation, (cid:27)t de…ned
(NOTICE that (! + (cid:11)"2
t
(cid:0)
2; :::::))1=2 .
1; "2
as (E("2
"2
t j
t
t
(cid:0)
(cid:0)

i) The conditional expectation of "t is equal to zero

E("t

1) = E(ut

"t
j

(cid:0)

"t
j

1)1=2 = 0
1)(! + (cid:11)"2
t
(cid:0)
(cid:0)

3

Notice that E(ut

1) = E(ut) = 0, since ut ~IIN(0,1)

"t
j

(cid:0)

ii) The conditional variance is given by the following formula

V ar("t

"t
j
Notice that E(u2
t j
Then the conditional mean and variance of yt are given by the following

1) = E(u2
t j
(cid:0)
1) = E(u2
t ) = 1, since ut ~IIN(0,1)
"t

1) = (! + (cid:11)"2
1)(! + (cid:11)"2
t
t
(cid:0)
(cid:0)
(cid:0)

1)

"t

(cid:0)

formulae;

E(yt

1) = (cid:22)

yt
j

(cid:0)

V ar(yt

yt
j

1) = (! + (cid:11)"2
t
(cid:0)
(cid:0)

1)

Then, the conditional variance of yt is time varying. On the other hand it
can be easily seen that the unconditional variance is time invariant whenever "2
t
is stationary, i.e.

whenever the process is stationary.

V (yt) = V ("t) = !=(1

(cid:11))

(cid:0)

( since V ("t) = E("2

1) = ! + (cid:11)E("2
t ) = E(! + (cid:11)"2
t
t
(cid:0)
(cid:0)

1) )

First Order Autoregressive Process with ARCH e¤ects.

For more complicated models such as AR(1)-ARCH(1), we obtain similar
results provided that the process for y is stationary, i.e. that the autoregressive
parameter is smaller than one in absolute value.

Assume the following …rst order autoregressive process

where "t = ut(! + (cid:11)"2
t
(cid:0)

then

yt = (cid:18)yt

1 + "t

(cid:0)
1) and ut ~IIN(0,1) , ! >0 , (cid:11)> 0

i) The conditional expectation of "t is equal to zero

E("t

"t
j

1) = E(u2
t j
(cid:0)

"t

1)(! + (cid:11)"2
t
(cid:0)
(cid:0)

1) = 0 since E(ut

1) = E(ut) = 0

"t
j

(cid:0)

ii) The conditional variance is given by the following formula

V ar("t

"t
j

1) = E(u2
t j
(cid:0)
1) = E(ut) = 1
"t

"t

since E(u2
t j

(cid:0)

1) = (! + (cid:11)"2
1)(! + (cid:11)"2
t
t
(cid:0)
(cid:0)
(cid:0)

1)

4

Then the conditional mean and variance of yt are given by the following

formulae;

E(yt

yt
j

(cid:0)

1) = (cid:18)yt

1

(cid:0)

To …nd the unconditional variance of yt we recall the following property for

V ar(yt

yt
j

1) = (! + (cid:11)"2
t
(cid:0)
(cid:0)

1)

the variance;

then

V ar(yt) = E(V ar(yt

1)) + V ar(E(yt

yt
j

(cid:0)

1))

yt
j

(cid:0)

i) E(V ar(yt

yt
j
ii) V ar(E(yt

1) = ! + (cid:11)E("2
1)) = E(! + (cid:11)"2
t
t
(cid:0)
(cid:0)
1)

1)) = (cid:18)2V ar(yt
(cid:0)
(cid:0)

(cid:0)
yt
j

1) = ! + (cid:11)V ar("t

1)

(cid:0)

Then if the process is covariance stationary we have

V ar(yt) =

! + (cid:11)V ar("t
(cid:18)2)

(1

1)

(cid:0)

(cid:0)
!
(cid:11))(1

(cid:18)2)

(cid:0)

(Since V ar("t

1) = !=((1

(cid:0)

=

(1

(cid:0)

(cid:11)))

(cid:0)

GARCH Models

In empirical applications it is often di¢ cult to estimate models with large
number of parameters, say ARCH(q). To circumvent this problem Bollerslev
(1986) proposed the Generalized ARCH or GARCH(p; q) model,

q

p

(cid:27)2

t = ! +

i +

(cid:11)i"2
t
(cid:0)
i=1
X
= ! + (cid:11)(L)"2
1 + (cid:12)(L)(cid:27)2
t
t
(cid:0)
(cid:0)

i=1
X

(cid:12)i(cid:27)2
i
t
(cid:0)

1

A su¢ cient condition for the conditional variance in the GARCH(p; q) model
to be well de…ned is that all the coe¢ cients in the in…nite order linear ARCH
model must be positive. Provided that (cid:11)(L) and (cid:12)(L) have no common roots
and that the roots of the polynomial in L, (1
(cid:12)(L)) = 0 lie outside the unit
circle, this positive constraint is satis…ed, if and only if, the coe¢ cients of the
in…nite power series expansion for (cid:11)(L)=(1

(cid:12)(L)) are non-negative.

(cid:0)

Rearranging the GARCH(p; q) model by de…ning (cid:23)t

(cid:0)

"2
t (cid:0)

(cid:17)

(cid:27)2

t , it follows

that

5

t = ! + ((cid:11)(L) + (cid:12)(L))"2
"2
t
1 (cid:0)
(cid:0)

(cid:12)(L)(cid:23)t

1 + (cid:23)t

(cid:0)

which de…nes an ARMA( Max(p; q),p) model for "2
t

the roots of (1

By standard arguments, the model is covariance stationary if and only if all
(cid:12)(L)) lie outside the unit circle.
If all the coe¢ cients are positive, this is equivalent to the sum or the autore-

(cid:11)(L)

(cid:0)

(cid:0)

gressive coe¢ cients being smaller that 1.

The analogy to ARMA class of models also allows for the use of standard

time series techniques in the identi…cation of the orders of p and q.

In most empirical applications with …nitely sampled data, the simple GARCH(1; 1)

is found to provide a fair description of the data.

Persistence and Stationarity

Using the GARCH(1,1) model it is easy to construct multi period forecasts
(cid:12)).

of volatility. When (cid:11)+(cid:12) < 1, the unconditional variance of "t+1 is !=(1

(cid:11)

If we re-write the following GARCH(1,1) as

(cid:0)

(cid:0)

1 + (cid:12)(cid:27)2
t = ! + (cid:11)"2
(cid:27)2
t
t
1
(cid:0)
(cid:0)
1) + ((cid:11) + (cid:12))(cid:27)2
(cid:27)2
= ! + (cid:11)("2
t
t
t
1 (cid:0)
(cid:0)
(cid:0)
(cid:0)

1

The coe¢ cient measures the extent to which a volatility shock today feeds
through into next periods volatility, while ((cid:11) + (cid:12)) measures the rate at which
this e¤ect dies over time. Recursively substituting and using the law of iterated
expectations, the conditional expectation of volatility j periods ahead is,

Et[(cid:27)2

t+j] = ((cid:11) + (cid:12))j((cid:27)2

t (cid:0)

!=(1

(cid:11)

(cid:0)

(cid:0)

(cid:12))) + w=(1

(cid:11)

(cid:0)

(cid:0)

(cid:12))

The multi period volatility forecast reverts to its unconditional mean at rate
((cid:11) + (cid:12)).

IGARCH Models

Integrated GARCH models are processes were the autorregresive part of the
square residuals has a unit root, i.e., ((cid:11) + (cid:12)) = 1. For this case the conditional
expectation of the volatility j periods ahead is

Et[(cid:27)2

t + j!:

t+j] = (cid:27)2
This process looks very much as a random walk with drift !. Then, if "t follows
an IGARCH process the unconditional variance does not exist and therefore
it is not covariance stationary. Nelson(1990) shows that the analogy with the
random walk process should be treated with caution since the IGARCH process
is not covariance stationary but it may be proved to be strictly stationary.

6

For example when ! = 0, Et[(cid:27)2

t+j] = (cid:27)2
t , so volatility is a martingale. But
the volatility remains bounded , since it cannot be negative, and then using the
fact that a bounded martingale must converge, we can show that it converges
to zero, a degenerate distribution.

Despite the fact that it seems to be an empirical regularity that volatility is
IGARCH (many estimated models have coe¢ cients that sum near 1) we regard
this type of process as unlikely. (see section on structural breaks and GARCH
models)

EGARCH Models

Even if GARCH models successfully capture thick tailed returns, and volatil-
ity clustering, are not well suited to capture the "leverage e¤ect" since the con-
ditional variance is a function only of the magnitudes of the lagged residuals
and not their signs

In the exponential GARCH (EGARCH) model of Nelson (1991) (cid:27)2

t depends

on both the size and the sign of lagged residuals.

EGARCH(1,1) Models

ln (cid:27)2

t = (cid:11)0 + (cid:12)1 ln (cid:27)2
t
(cid:0)

"t
1 + (cid:13)0([
j

(cid:0)

1=(cid:27)t

1

(cid:0)

j (cid:0)

(2=(cid:25))1=2] + (cid:14)("t
(cid:0)

1=(cid:27)t

1))

(cid:0)

Obviously the EGARCH model always produces a positive conditional variance
(cid:27)2
t for any choice of (cid:11)0, (cid:12)1, (cid:13)0 and so that no restrictions need to be placed
and
on these coe¢ cients (except
("t=(cid:27)t), (cid:27)2
t will also be non-symmetric in "t and, for negative (cid:14), will exhibit
higher volatility for large negative "t .

< 1). Because of the use of both

"t=(cid:27)t
j

(cid:12)1j
j

j

Other ARCH Speci…cations

Glosten, Jagannathan and Runkle (1989) proposed the following speci…ca-

tion:

"t = (cid:27)t(cid:23)t

,

where vt is iid.

t = (cid:11)0 + (cid:12)1(cid:27)2
(cid:27)2
1 + (cid:11)2"2
1 + (cid:11)1"2
t
t
t
(cid:0)
(cid:0)
(cid:0)
1 = 0 if "t
0 and It

1 = 1 if "t

1It

1

(cid:0)

1;

(cid:0)

(cid:21)

(cid:0)

where, It

(cid:0)

1 < 0.

(cid:0)

The non-negativity condition is satis…ed provided that all the parameters

are positive. If leverage e¤ects do exist, (cid:11)2 < 0.

Additional Explanatory Variables.

7

It is straightforward to add other explanatory variables to a GARCH spec-
i…cation. Glosten, Jagannathan and Runkle(1993) add a short-term nominal
interest rate to various GARCH models and show that it has a signi…cant pos-
itive e¤ect on stock market volatility.

where X is any positive variable.

1 + (cid:11)"2
t = ! + (cid:12)(cid:27)2
(cid:27)2
t
t
(cid:0)
(cid:0)

1 + (cid:13)Xt

1;

(cid:0)

GARCH in Mean Models

Many theories in …nance assume some kind of relationship between the mean
of a return and its variance . A way to take this into account is to explicitly
write the returns as a function of the conditional variance or, in other words, to
include the conditional variance as another regressor. GARCH in Mean Models
allow for the conditional variance to have mean e¤ects. Most of the time this
conditional variance term will have the interpretation of a time varying risk
premium.

Consider the following model.

and

yt = (cid:18)xt +  (cid:27)2

t + "t

1 + (cid:12)(L)(cid:27)2
t = ! + (cid:11)(L)"2
(cid:27)2
t
t
(cid:0)
(cid:0)

1

Consistent estimation of (cid:18) and   is dependent on the correct speci…cation of the
entire model. The estimation of GARCH in Mean type of models is numerically
unstable and many empirical applications have used ARCH-M type of models
which are easier to estimate.

An ARCH in Mean model simply models the conditional variance as an

ARCH model instead of modeling as GARCH, i.e.

t = ! + (cid:11)(L)"2
(cid:27)2
t
(cid:0)

1

Example of an ARCH(1)-M
Consider a simple version of the above model.

where "t = vt(cid:27)t

vt ~N(0,1)

yt =  (cid:27)2

t + "t

t = w + ! + (cid:11)"2
(cid:27)2
t
(cid:0)

1

Then yt may be expressed as

Then the expected value of yt is

yt =  (! + (cid:11)"2
t
(cid:0)

1) + "t

E(yt) =  ! +  (cid:11)E("2
t
(cid:0)

1)

8

and using that E("2
t
(cid:0)

1) = !=(1

(cid:0)

(cid:11))then

E(yt) =  ! +  (cid:11)!=(1

(cid:11))

(cid:0)

Which can be viewed in …nance models as the unconditional expected return
for holding a risky asset.

Testing for Arch

Before attempting to estimate a GARCH model you should …rst check if
there are ARCH e¤ects in the residuals of the model. Clearly we should not
explicitly model (and estimate) the conditional volatility of series as GARCH
when there are not signs of Arch e¤ects.

The original Lagrange Multiplier test for ARCH proposed by Engle (1982) is
very simple to compute, and relatively easy to derive. Under the null hypothesis
it is assumed that the model is say an AR(p) model

yt = (cid:30)1yt

1 + (cid:30)2yt

2 + ::: + (cid:30)pyt

p + "t

(cid:0)

(cid:0)

(cid:0)

where "t is a Gaussian white noise process, "t
formation set. The Alternative hypothesis is that the errors are ARCH(q).

1 ~N(0,(cid:27)2)where It is the in-

It
j

(cid:0)

The test for ARCH(q) e¤ect simply consists on regressing

2 + ::: + (cid:11)q^"2
1 + (cid:11)2^"2
t = (cid:11)1^"2
^"2
t
t
t
(cid:0)
(cid:0)
(cid:0)
Under the null hypothesis that (cid:11)1 = (cid:11)2 = ::: = (cid:11)q = 0, and T R2 is asymptoti-
cally distributed (cid:31)(q), where T is the number of observations.

q +  t

While this is the most widely used test we should be cautious in interpret-
ing the results. If the model is misspeci…ed it is quite likely to reject the null
hypothesis simply because most of the time serial correlation in the residuals
will induce serial correlation in the squared residuals.

Structural Breaks and ARCH e¤ects

It has been shown ( Diebold (1986) ) that breaks in the variance, which are
not taken into account by the econometrician, will look as ARCH e¤ects when
the whole sample is used. In other words, it might be that for a sub sample the
unconditional variance changes from say to and then back to the previous level.
In this case to model the conditional variance as an ARCH model will be the
wrong thing to do. In this case, it is recommended to divide the sample and
test for ARCH for the sub periods, if no ARCH e¤ects are found for any of the
sub periods but are found for the whole sample that is a clear indication of a
break in the unconditional variance and not of ARCH e¤ects. Many researchers
wrongly estimated GARCH Models in many situations where there was only a
change in regime. For example many papers use GARCH models to …t interest

9

rate series for USA when the change in the Volatility was simply a result of the
di¤erent operative procedures of the Federal Reserve (a di¤erent distribution).

GARCH E¤ects and Sampling Frequency

It can be proved that GARCH models do not temporarily aggregate, or
in other words if a model is GARCH using daily data cannot be GARCH with
weakly data and so on. Given that we don’t observe the data generating process
in practice is very di¢ cult to determine at which sampling frequency the data
presents GARCH e¤ects (if it has at all). Nevertheless there are some well
established empirical regularities that show that the higher is the sampling fre-
quency (say daily) the higher the GARCH e¤ects. Weakly and every forth night
data seem to also present GARCH e¤ect. Monthly data usually does not have
GARCH e¤ects and whenever these are detected, are usually due to a structural
break of the unconditional variance.

Estimating GARCH Models

Maximum likelihood Estimation with Gaussian Errors
The estimation of GARCH type models is easily done by conditional maxi-

mum likelihood.

If the model to be estimated is

yt = xt(cid:18) + "t

Where xt is a (row) vector of predetermined variables, which could include
lagged variables, (cid:18) is a parameter vector and "t ~N(0,(cid:27)2
t ), where the conditional
variance is assumed to be GARCH(1,1), i.e. ;

1 + (cid:12)(cid:27)2
t = ! + (cid:11)"2
(cid:27)2
t
t
(cid:0)
(cid:0)
Then the conditional distribution of yt is

1

xt; It
j
Then the conditional log likelihood is

1) = (2(cid:25)(cid:27)2
(cid:0)

f (yt

t )(cid:0)

:5 exp(

:5(yt

(cid:0)

xt(cid:18))2=(cid:27)2
t )

(cid:0)

T

log L((cid:18); !; (cid:11); (cid:12)

1) =

It
j

(cid:0)

(
(cid:0)

:5 log(2(cid:25))

(cid:0)

:5 log((cid:27)2
t )

2
t (yt
:5(cid:27)(cid:0)

(cid:0)

xt(cid:18))2)

(cid:0)

t=1
X
Notice that at time 1 we need initial values for "0 and (cid:27)2
usually assumed to be the equilibrium values, that is (cid:27)2
"0 = (!=(1

(cid:12))):5

(cid:11)

0. These values are
(cid:12)) and

(cid:11)

0 = !=(1

(cid:0)

(cid:0)

(cid:0)

(cid:0)

Maximum likelihood Estimation with non Gaussian Errors

10

The unconditional distribution of many …nancial time series seems to have
fatter tails than the normal. GARCH e¤ects may not account for this and
we need to use another distribution for "t . A tractable distribution is the
t-distribution. We proceed as before but replace the Normal density function
by

f ("t) = ((cid:0)[((cid:23) + 1)=2]=(cid:0)((cid:23)=2))(((cid:23)

(cid:0)

2)(cid:25)(cid:27)2

t )(cid:0)

:5[1 + ("2

t =((cid:27)2

t ((cid:23)

2))](cid:0)

((cid:23)+1)=2

(cid:0)

Where n is a parameter to be estimated which represents the degrees of freedom.
We estimate as before numerically subject to the constraint that n is greater
than 2.

Stochastic Volatility Models

A possible response to non-normality of returns conditional upon past re-
turns is to assume that there is a random variable conditional upon which
returns are normal, but this variable-which we may call stochastic volatility-is
not directly observed.

A simple example of a stochastic-volatility model is the following:

(cid:17)t = "te(cid:11)t=2; (cid:11)t = (cid:30)(cid:11)t
(cid:0)

1 + (cid:24)t

where "t ~N(0,(cid:27)2
uncorrelated and independent of each other.

(cid:24)t ~N(0,(cid:27)2

"),

(cid:24)), and we assume that "t and (cid:24)t are serially

If we squared (cid:17)t, the returns equation, and take logs we can write this

expression as

log((cid:17)2

t ) = (cid:11)t + log("2

t ); (cid:11)t = (cid:30)(cid:11)t

1 + (cid:24)t

(cid:0)

This is in linear state-space (to be covered in the course) form except that has
an error with a log (cid:31)2 distribution instead of a normal distribution.

How to compare Between Di¤erent GARCH - Speci…cations

Most of the GARCH models are non-nested (they cannot be written as a
restricted version of a more general process). Therefore the comparison between
di¤erent GARCH Models is no straight forward.

Misspeci…cation Tests on the standardized residuals.
We have seen above that the residuals may be written as the product of a
WN and the conditional standard deviation. For example for an ARCH(1) this
can be written as

1)1=2
"t = vt(! + (cid:11)"2
t
(cid:0)

11

Therefore we can test for the existence ARCH e¤ects in the standardized resid-
uals

^vt = ^"t=(^! + ^(cid:11)^"2
1)1=2
t
(cid:0)

The model that ”cleans” the standardized residuals is a candidate to be the
”true” model.

Some Other Ways Of Discriminating between alternative ARCH
models.

We are going to present two alternative ways of discriminating between
ARCH models; (i) based on the use of auxiliary regressions of the squared
residuals, (ii) based in their forecasting ability.

(i) Comparison between alternative models based on the use of auxiliary
regressions

Pagan and Scwhert (1989) suggest to use the following auxiliary regression

as a mean of choosing between di¤erent Arch models.

t = (cid:11) + (cid:12) ^(cid:27)2
^"2

t + (cid:24)t

This regress the squared residuals on the …tted variance of the alternative
GARCH models.
If the chosen GARCH model is appropriate to explain the
conditional volatility of the series under scrutiny, you should expect (cid:11) to be
zero, (cid:12) to be one and the …t (R2) to be good.

Pagan and Scwhert (1989) propose to test the joint hypothesis

H0)(cid:11) = 0; (cid:12) = 1
= 0; (cid:12)
H1)(cid:11)
= 1

As a second step, they propose to compare the models that were not rejected
on the basis of goodness of …t. The argument being, the one with better …t the
better that mimics the conditional variance.

They also propose to express the previous regression in logarithms to ac-
count for scale e¤ects and then compare the goodness of …t of this alternative
auxiliary regression.

(ii) Measuring the Accuracy of Forecasts of Di¤ erent Arch Models.

Hamilton (1994) propose to use the forecasting ability of the di¤erent ARCH
models as a way of comparing these models. As we said before, the ARCH type
of models have the property that they allow to forecast the conditional variance

12

6
6
of a series, therefore a criteria which may enable us to choose between di¤erent
models is to choose that one that forecast better.

Various measures (loss functions) have been proposed for assessing the pre-

dictive accuracy of the forecasting ARCH models.

The Mean Squared Error

M SE = (1=T )(

T

The Mean Absolute Error.

t=1
X

T

(^"2

t (cid:0)

^(cid:27)2
t )2)

M AE = (1=T )(

^"2
t (cid:0)

^(cid:27)2
)
t j

t=1 j
X

The Mean Squared Error of the log of the squared residuals.

[LE]2 = (1=T )(

T

t=1
X

(ln(^"2
t )

(cid:0)

ln(^(cid:27)2

t ))2)

The Mean Absolute Error of the log of the squared residuals.

T

[M AE]2 = (1=T )(

ln(^"2
t )

ln(^(cid:27)2
)
t )
j

t=1 j
X
For all the models we calculate the proportional improvement over a model
t = ^(cid:27)2 (to account for scale e¤ects).
which assumes constant variance, i.e., ^(cid:27)2
The model that provides the largest proportional improvement is the one to be
preferred.

(cid:0)

Hamilton also propose to compare the forecasting performance at di¤erent
horizons (4 and 8 periods). That will slightly modify the above formulae in the
following way;

The Mean Squared Error

M SE = (1=T )(

T

The Mean Absolute Error.

t=1
X

T

(^"2

t+(cid:28) (cid:0)

(cid:28) ^(cid:27)2

t )2)

M AE = (1=T )(

^"2
t+(cid:28) (cid:0)

(cid:28) ^(cid:27)2
)
t j

t=1 j
X

The Mean Squared Error of the log of the squared residuals.

[LE]2 = (1=T )(

T

(ln(^"2

t+(cid:28) )

(cid:0)

ln(^(cid:27)2

t ))2)

The Mean Absolute Error of the log of the squared residuals.

t=1
X

13

T

[M AE]2 = (1=T )(

t=1 j
X

ln(^"2

t+(cid:28) )

ln(^(cid:27)2
)
t )
j

(cid:0)

where (cid:28) ^(cid:27)2
time t.

t is the forecast of the variance (cid:28) periods ahead given information at

14

Multivariate GARCH models.

Financial market volatility moves together over time across assets and mar-
kets. Recognizing this commonality through a multivariate modeling framework
leads to obvious gains in e¢ ciency.

Following Bollerslev et al (1986) consider a multivariate extension of the

GARCH(p,q) as follows:

Consider a system of n regression equations,

yt = (cid:22) + ut

vech(Ht) = C +

p

i=1
X

Aivech(ut

iu0t

i) +

(cid:0)

(cid:0)

q

i=1
X

Bivech(Ht

i)

(cid:0)

where ut

1~N(0,Ht)

It
j

(cid:0)

n conditional variance
It
In this formulation, Ht = E(utu0tj
matrix associated with the error vector u0t and vech(Ht) denotes the (n(n+1))=2
1 vector of all the unique elements of Ht obtained by stacking the lower

1) is the n

(cid:2)

(cid:0)

(cid:2)
triangle of Ht
Also

1 .

(cid:22) is n

1

(cid:2)

C is (n(n + 1))=2

1

(cid:2)
A1; A2; :::Ap; B1; :::Bq are (n(n + 1))=2

(n(n + 1))=2

(cid:2)

(cid:15)

(cid:15)

(cid:15)

Example: A Bivariate GARCH(1,1)

Since most empirical applications of the model have restricted attention to
multivariate GARCH(1,1) systems. We …rst consider the easiest example is the
simple bivariate process which depends on its conditional variance covariance
matrix (Ht).

1 In general if
a
b

c
d

A =

(cid:20)
Then

(cid:21)
a
b
c
d

vech(A) = 2

3

6
6
For a symmetric matrix
4
c
d

B =

7
7
5

a
c

(cid:20)

(cid:21)n

(cid:2)

n

is standard to write the vector using either the lower or the upper triangular information

vech(B) =

a
c
d 3
5

2

4

(n

(n+1)=2)

(cid:2)

1

(cid:2)

1

xt
wt

=

(cid:21)

(cid:20)

(cid:22)x
(cid:22)w (cid:21)

+

(cid:20)

"t
(cid:23)t

(cid:21)

(cid:20)

where

2

4

Vt
(cid:0)
COVt
Vt

1(xt)
1(xtwt)
(cid:0)
1(wt)

(cid:0)

=

3

5

cx
cxw
cw
b1
b4
b7

2

2

4
+

2

4

3

5

+

b2
b5
b8

4

3

2

a1 a2 a3
a4 a5 a6
a7 a8 a9
b3
b6
b9

3

2

5

4

4
5
2(xt
Vt
(cid:0)
2(xt
COVt
(cid:0)
(cid:0)
2(wt
Vt

(cid:0)

("t

1)2

("t

(cid:0)
1(cid:23)t

(cid:0)
((cid:23)t
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

Estimation of this model may be obtained by ML using numerical procedures.
Two main problems with the estimation of these type of models should be
apparent:

1. As its stands this model is very general, requiring a large number of para-
meters to be estimated. The ”simplest”general model has 23 parameters.

2. We should ensure Ht to be positive de…nite. (see Bera and Higgins).

Various simpli…cations have been suggested to account for (1) and (2).

A Diagonal Vech Parameterization

(Bollerslev, Engle and Wooldridge (1982))

A natural simpli…cation is to assume that each covariance depends only on
its own past values and innovations, i.e., that Ai and Bi are diagonal. Then Each
element of Ht follows an univariate GARCH model driven by the corresponding
cross product utu0t. The implied conditional covariance matrix is always positive
de…nite if the matrices of parameters

cx
cxw

cxw
cw

;

(cid:21)

(cid:20)

a1 a5
a5 a9

b1
b5

b5
b9

;

(cid:21)

(cid:20)

(cid:21)

(cid:20)

are all positive de…nite. This can be ensured by doing simple Cholesky trans-
formations to each of these matrices.

A Quadratic Speci…cation,

(Engle and Kroner(1995))
An alternative to the diagonal vech parameterization is to achieve a positive

de…nite covariance matrix is the quadratic parameterization

2

Ht = C 0C + A
0

1u0t
where C is a lower triangular with n(n + 1)=2 parameters and A and B are
square matrices with n2 parameters each. Weak restrictions on A and B guar-
antee that the Ht is always positive de…nite.

1A + B0Ht

1B:

ut

(cid:0)

(cid:0)

(cid:0)

A Constant-Correlation Speci…cation,

(Bollerslev(1990))
This speci…cation is similar to the diagonal speci…cation, but imposes the

restriction that the correlation between the assets is constant.

COVt

1(xtwt) = (cid:26)

(cid:0)

Vt

1(xt)Vt

1(wt)

(cid:0)

(cid:0)

Where (cid:26) is also estimated with the rest of the parameter set. The conditions to
p
get a positive de…nite matrix are as in the diagonal case.

Stationarity and Co-persistence

Stationarity

The conditions for stationarity and moment convergence for the multivariate
case are similar to those discussed in the univariate case. Specially, for the
multivariate vech GARCH(1,1) model de…ned above, the minimum square error
forecast for vech(Ht) as of time s < t takes the form

t
(cid:0)
Es(vech(Ht)) = [

s

1

(cid:0)

svech(Hs)
(A1 + B1)k]C + (A1 + B1)t
(cid:0)

where (A1 + B1)0 is equal to the identity matrix by de…nition.

k=0
X

Let V (cid:3)V (cid:0)

1 denote the Jordan decomposition of the matrix A1 + B1, so that
1 . Thus, Es(vech(Ht)) converges to the unconditional
, if and only if the absolute

(A1 +B1)t
s = V (cid:3)t
(cid:0)
(cid:0)
covariance matrix (I
value of the largest eigen value of A1 + B1 is strictly less than one.

sV (cid:0)
A1

1C , for t

B1)(cid:0)

! 1

(cid:0)

(cid:0)

Results for other multivariate formulations are scarce, a possible exception is
the constant conditional correlations parameterization where the conditions for
the model to be covariance stationary are simply determined by the conditions
of each of the univariate conditional variances.

Co-Persistence in Variance

The empirical estimates for univariate and multivariate ARCH models often
indicate a high degree of persistence in the forecast moments of the conditional
variances, i.e. Es(Ht)ii , i = 1; 2; ::::N , for t
. At the same time, the

! 1

3

commonality in volatility movements suggest that this persistence may be com-
mon across di¤erent series. More formally Bollerslev and Engle (1993) de…ne
the multivariate ARCH process to be co-persistent in variance if at least one
of the elements in Es(Ht) is non-convergent for increasing forecasts, t
s, but
there exists a linear combination (cid:13)0"t , such that for every forecast origin s, the
forecasts of the corresponding future conditional variances Es((cid:13)0Ht(cid:13)) converge
to a …nite limit, independent of time s information. The conditions for this to
occur are presented in Bollerslev and Engle (1993) and are similar to the con-
ditions for co-integration in the mean as developed by Engle and Granger (1987).

(cid:0)

Multivariate GARCH-M models .

Engle and Bollerslev (1986) consider a multivariate extension of the gARCH-

m as follows:

Consider a system of n regression equations,

yt = BXt + Dvech(Ht) + ut
q

p

vech(Ht) = C +

i=1
X

where ut

1~N (0; Ht)

It
j

(cid:0)

Where

Aivech(ut

iu0t

i) +

(cid:0)

(cid:0)

Bivech(Ht

i)

(cid:0)

i=1
X

B is n

k

(cid:2)

D is n

(n(n + 1))=2

(cid:2)
C is (n(n + 1))=2

1

(cid:2)
A1; A2; :::Ap; B1; ::::Bq are (n(n + 1))=2

(cid:15)

(cid:15)

(cid:15)

(cid:15)

(n(n + 1))=2

(cid:2)

A Bivariate GARCH-M(1,1) model

The easiest example is the simple bivariate process which depends on its

conditional variance covariance matrix (Ht)

Vt
(cid:0)
COVt
Vt

1(xt)
1(xtwt)
(cid:0)
1(wt)

(cid:0)

"t
(cid:23)t

+

(cid:20)

(cid:21)

3

5

xt
wt

=

(cid:21)

(cid:20)

(cid:22)x
(cid:22)w (cid:21)

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

where

4

Vt
(cid:0)
COVt
Vt

1(xt)
1(xtwt)
(cid:0)
1(wt)

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

2

4

3

5

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

Estimation

c2
c5
c5

c3
c6
c6

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

("t

1)2

("t

(cid:0)
1(cid:23)t

(cid:0)
((cid:23)t
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

The estimation of all the models presented above is carried out using condi-
tional maximum likelihood estimation. The conditional log likelihood function
for a single observation can be written as

Lt((cid:18)) =

(n=2) log(2(cid:25))

(cid:0)

(cid:0)

(1=2) log(Ht((cid:18)))

(cid:0)

1
(1=2)ut((cid:18))0H (cid:0)
t

((cid:18))ut((cid:18))

where (cid:18) represents a vector of parameters, n represents number of equations
and t represents time.

Then conditional on initial values for u0 and H0 , the likelihood function for

the sample 1; ::; T can be written as

T

L((cid:18)) =

Lt((cid:18))

t=1
X
The maximization is usually achieved through numerical methods Notice that
the model is highly non-linear and very unstable.

An application of the MGARCH-M model : Testing The CAPM

General issues

Three main di¢ culties associated with testing the CAPM

1. The CAPM is a statement about the relationships between ex ante risk
premiums and betas, both of which there are not directly observable. This
problem is usually dealt with by assuming that investors form rational
expectations: the realized return on assets are drawings from the ex ante
probability distribution of returns on those assets.

2. The Roll- critique; many assets are not measurable (human capital etc.)
so tests of the CAPM have to be based on proxies for the market portfolio
which only includes (a subset of) traded assets.

5

3. The CAPM is a single-period model. However, in order to test the model
time series are frequently used. This is only a valid procedure if both risk
premia and betas are stationary.

The Unconditional CAPM a short review of the literature.

Markowitz(1959) laid the ground work for the CAPM. He cast the investor’s
portfolio selection problem in terms of the expected return and variance of the
return. He argued that investors would optimally hold a mean-variance e¢ cient
portfolio. Sharpe and Litener showed that if investors have homogeneous expec-
tations and optimally hold mean-variance portfolios then, the market portfolio
will also be mean-variance. They also assume the existence of lending and bor-
rowing at a risk free rate of interest. For this version of the CAPM the expected
return for asset j is2

E(rj) = rf + (cid:12)jm(E(rm)

rf )

(cid:0)

Where rj; rf and rm are the asset j, risk free and market rate of return respec-
tively.

De…ning excess returns ~r, we can rewrite the above expressions as

E(~rj) = (cid:12)jm(E ~rm)

where ~rj = rj

rf ;

~rm = rm

rf

(cid:0)

(cid:0)

Since the risk free rate is assumed to be non-stochastic the two equations
above are equivalent. Nevertheless in empirical applications rf is typically sto-
chastic and therefore the (cid:12)0 may di¤er.

Empirical tests of the Sharpe-Litener CAPM have focused on three implica-

tions of the last expression.

1. The intercept is zero

2. The parameter beta completely captures the cross sectional variation of

expected excess returns

3. the market risk premium, (E ~rm) is positive.

Statistical Framework for the Sharpe-Lintner Version.

The CAPM is a single-period model and do not have time dimension. For
econometric analysis of the model we need to add an assumption concerning the
time series properties of returns over time. We assume that the returns are IID
and jointly multivariate Normal.

Imposing the restriction that rjt and rmt are multivariate normal, it follows

that

2 In testing the CAPM we usually do some simplifying assumptions. One is that the risk

free rate is often approximated by the treasury bill lending rate.

6

where

E(~rjt

~rmt) = (cid:11) + (cid:12)~rmt
j

(cid:12)j = cov(~rjt~rmt)=var(~rmt)
and
(cid:11)j = E(~rjt)

(cid:12)jE(~rmt)

(cid:0)

Therefore

~rjt = (cid:11)j + (cid:12)j ~rmt + "jt

(1)

Traditionally (cid:12) has been estimated by OLS regression, meaning that the
range of problems encountered with any linear regression model recur here as
well. To test the CAPM is equivalent to test the restriction that (cid:11)j = 0 and this
can be done in this context by a simple F test. Alternatively we may consider
the test in a multivariate context were

rt = (cid:11) + (cid:12)~rmt + "t

(cid:22)m)2 = (cid:27)2

m; Cov(rmt; "t) = 0

E("t) = 0

E("t"0t) = (cid:6)

(cid:15)

(cid:15)

E(rmt) = (cid:22)m; E(rmt

(cid:15)
(cid:0)
Where (cid:12) is a vector of N

disturbances.

1 and "t are N

(cid:2)

1 asset returns intercepts and

(cid:2)

We can estimate this model by maximum likelihood and test the N zero in-
tercept restriction by a likelihood ratio test which is asymptotically distributed
(cid:31)2(N ).

The Black (1972) version.

In the absence of a risk free asset Black (1972) derived a more general version
of the CAPM. In this version the expected return of asset i en excess of the zero-
beta return is linearly related to its beta.

Then

E(rj) = rom + (cid:12)jm(E(rm)

rom)

(cid:0)

where r is the return of the zero beta portfolio associated with m. This
portfolio is de…ned to be the portfolio that has minimum variance of all the
portfolios associated with m.

The econometric analysis of the Black version of the CAPM treats the zero-
beta portfolio as an unobserved quantity. This version can be tested as a re-
striction on the real return market model

7

and the implication of this version is (cid:11)jm = E(rom)(1

E(rj) = (cid:11)j + (cid:12)jmE(rm)

This restrictions can also be tested by a likelihood ratio test.

(cid:12)jm)

(cid:0)

Applied work

Most tests of the CAPM have used a time-series of monthly rates of return
on common stocks listed in the New York Stock Exchange as a proxy of the
market portfolio. Suppose that the objective is to explain the (excess) return
of the jth portfolio of assets rjt . If there is only one asset per portfolio this
will simply be the (excess) return on that asset. ”Portfolios”can be interpreted
in diverse ways. For example Harvey(1989) has rjt as the (excess) return on
equity in the jth country. In the market model rjt is related to the return on
the market or aggregate portfolio, rmt . The latter may be a simple average of
the returns to all stocks in the economy or perhaps is a weighted average, with
weights depending on the value of the portfolio accounted for each stock.

b) The second approach interprets the tests conditional on the investors’
information set which is assumed to be jointly stationary and with multivariate
normally distributed asset returns.

E(~rjt

1) = (cid:12)jtE(~rmt

It
j

(cid:0)

1)

It
j

(cid:0)

(2)

The Conditional CAPM

In (1) (cid:12)j was a constant equal to the ratio cov(rjtrmt)=var(rmt). However,
in line with the distinction between conditional and unconditional moments, one
might wish to consider models for rjt in which the conditional density rather
than the unconditional density returns is used. Let It
1 be a set of conditioning
variables including the past history of rjt and rmt . Then the conditional asset
pricing model has

(cid:0)

E(~rjt

It
j
1)=var(~rmt

1) = (cid:12)jtE(~rmt
1).

(cid:0)

1)

It
j

(cid:0)

(cid:0)

It
j

where (cid:12)jt = cov(~rjt~rmt
It
j
Because the coe¢ cients of the conditional market model are functions of the
conditional moments for rjt and rmt it is necessary to model this in some way.
A natural way to proceed is to allow the conditional mean for rjt to depend
on its conditional variance, as in GARCH-M models, and to subsequently model
cov(rt

1) by a multivariate GARCH.

(cid:0)

It
j

(cid:0)

(2)

Multivariate GARCH-M models:A CAPM with time-varying covariances

8

As discussed above the conditional CAPM can be written as

E(rjt

where

1)

It
j

(cid:0)

(cid:0)

rf t

1 = (cid:12)jt[E(rmt

(cid:0)

1)

It
j

(cid:0)

(cid:0)

rf t

1]

(cid:0)

It
(cid:12)jt = cov(rjtrmt
j
where, because we now allow the covariance matrix of returns

1)=var(rmt

It
j

1):

(cid:0)

(cid:0)

H =

var(rjt
It
j
cov(rjtrmt

1)

(cid:0)
It
j

(cid:0)

1)

(cid:20)

cov(rjtrmt
It
j
It
var(rmt
j

(cid:0)

1)

(cid:0)
1)

(cid:21)

to vary over time, both the expected returns and the betas will, in general, be
time varying.

This formulation of the CAPM is, however, non-operational because of the

lack of an observed series for the expected market returns.

If we assume that the ”market price of risk”, (cid:21) is constant, where

(cid:21) = (E(rmt

1)

It
j

(cid:0)

(cid:0)

rf t

1)=var(rmt

(cid:0)

1):

It
j

(cid:0)

So that

[E(rjt

then we can write

1)

It
j

(cid:0)

(cid:0)

rf t

1] = (cid:21)cov(rjt; rmt

(cid:0)

1)

It
j

(cid:0)

rjt = rf t

1 + (cid:21)cov(rjt; rmt

(cid:0)

1) + ujt

It
j

(cid:0)

Also nothing that

(since (cid:21) = (E(rmt

E(rmt

1)

rf t

1 = (cid:21)var(rmt

(cid:0)

1)

It
j

(cid:0)

(cid:0)

1)

It
j

(cid:0)

(cid:0)

1)=var(rmt

1) )

It
j

(cid:0)

It
j
rf t

(cid:0)

(cid:0)

Where ujt and umt are the innovations.

rmt = rf t

1 + (cid:21)var(rmt

(cid:0)

1) + umt

It
j

(cid:0)

This time varying CAPM can be put into multivariate GARCH-M form as

yt = b + dvech(Ht) + ut

where yt = (rjt
var(rmt

1; rmt
1))0; ut = (ujt; umt)0 and

rf t

rf t

(cid:0)

(cid:0)

(cid:0)

(cid:0)

1)0; vech(Ht) = (var(rjt

1); cov(rjtrmt

It
j

(cid:0)

It
j

(cid:0)

1);

It
j

(cid:0)

d = (cid:21)

(cid:20)

0
0

1
0

0
1

:

(cid:21)

The zero restrictions implied by the theory may be tested (against a general
model) by a likelihood ratio test which is asymptotically distributed (cid:31)2(5). A
by-product of this methodology is that plot of conditional time varying betas
can easily been obtained. This plot is very informative since it may provide
as with time varying beta ranking and also show how di¤erent stocks react to
shocks to the economy.

9

SWITCHING REGIME ESTIMATION.
Introduction.

Usually in econometrics we assume that observed data has been drawn from
some data generating mechanism which may be related to some speci…c eco-
nomic theory or simply represent the true relationship between a set of variables.
An underlying assumption in all econometric models is that all the observations
have been drawn from the same distribution conditional on some constant pa-
rameter set. It is very unlikely that economic time series can be characterized
in such a way since we expect changes in the properties of the data when there
is a change in macroeconomic policy, say from free ‡oating to target exchange
rates, or even a more dramatic change from war time to peace time.

The standard econometric approach consist of trying to detect the existence
of these changes in regime using di¤erent types of parameter constancy tests, and
then impose dummy variables to account for these changes. By doing this, the
econometrician could ensure parameter constancy within regime. Nevertheless
this procedure might be very rigid and may lead to the use of models with too
many dummy variables. How should we model a change in the process followed
by a particular time series? Suppose that the series under scrutiny has a break
in the unconditional mean at time t1 . For data prior to t1 we might use a model
such as

yt

and for data after t1

(cid:0)

(cid:22)1 = (cid:30)(yt

1

(cid:0)

(cid:22)1) + "t

f or t1 < t

(cid:0)

yt

(cid:0)

(cid:22)2 = (cid:30)(yt

1

(cid:0)

(cid:0)

(cid:22)2) + "t

f or t

t1

(cid:21)

Even if this speci…cation may capture the break at t1 , is not a satisfactory
time series model. For example, how are we to forecast a series described as
above. Also, if the process has change in the past it could also change again.
The change in regime does not need to be the outcome of a perfectly foreseeable,
deterministic event. Rather the change itself may be regarded as a random
variable. A complete time series model would therefore include a description of
the probability law governing the change from (cid:22)1 to (cid:22)2

We might consider the process to be in‡uenced by an unobserved random
variable xt , which is called the state or regime. This variable may take di¤erent
values at date t; if xt = 1, then the process is in regime 1, while xt = 2 means
that the process is in regime 2. Therefore we can write this model as

yt

(cid:0)

(cid:22)xt = (cid:30)1(yt

(cid:22)xt

1) + "t

1

(cid:0)

(cid:0)
where the unconditional mean takes the values (cid:22)1 when xt = 1 and the value
(cid:22)2 when xt = 2:

(cid:0)

We then need a description of the time series process for the unobserved
variable. Since xt only takes discrete values we need to model this process using
a discrete-valued random variable. The easiest is a Markov chain.

1

Properties of Markov Processes.

Let xt be a random variable ( which denotes the unobserved state of the
system) that can take values 0 and 1. If the probability that xt takes a particular
value at time t, only depends on its value at t
1, this variable is governed by
a Markov process.

(cid:0)

1 = 0) = q and

xt
P ((xt = i
j

1 = j; xt

xt
2 = k:::) = P ((xt = i
j

1 = j)

(cid:0)
xt
The process is summarized by the probabilities: P (xt = 0
j
xt
P (xt = 1
j

1 = 1) = p.

(cid:0)

(cid:0)

(cid:0)

(cid:0)

These information is usually summarized in what is called the transition

Matrix or transition probability matrix.

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

Autoregressive Representation of Markov Process.

1

xt+1

(cid:0)
xt+1

=

(cid:21)

(cid:20)

q

(cid:0)

q)

(1

p)

(1

(cid:0)
p

1

xt

(cid:0)
xt

+

(cid:21)

(cid:20)

(cid:16) 1;t+1
(cid:16) 2;t+1 (cid:21)

(cid:21) (cid:20)

(cid:20)

or

where

Wt+1 =

0, so EtUt+1 = 0

(cid:20)

1

xt+1

(cid:0)
xt+1

Wt+1 = PWt + Ut+1

and Ut+1 =

(cid:21)

(cid:16) 1;t+1
(cid:16) 2;t+1 (cid:21)

(cid:20)

and Et(cid:16) 1;t+1 = 0, Et(cid:16) 2;t+1 =

Then it follows that Wt is a random vector that takes the value

when xt = 0

= when xt = 1

1
0

0
1

(cid:21)

(cid:21)

Wt =

and

Wt =

(cid:20)

(cid:20)
E(Wt+1

xt = i) =
j

E(Wt+1

xt = i) =
j

1

1

q

(cid:0)

(cid:0)
p

q

p

(cid:21)

(cid:21)

(cid:20)

(cid:20)

when i = 0

when i = 1.

The above vectors are simply column i + 1 of the transition matrix.

2

Then

and

E(Wt+1

Wt) = P
j

1
0

0
1

(cid:20)

(cid:21)

Ut+1 = Wt+1

E(Wt+1

Wt) = Wt+1
j

(cid:0)

P

(cid:0)

1
0

0
1

(cid:20)

(cid:21)

Now notice that the second row gives

(cid:0)

xt+1 = (1

q) + (

1 + p + q)xt + (cid:16) 2;t+1

(cid:0)
This expression can be recognized as an AR(1) process with constant term 1
1 + p + q)
and autoregressive coe¢ cient (

(cid:0)

q

(cid:0)

The process is stationary whenever the autoregressive coe¢ cient is smaller

than 1, i.e., (

1 + p + q) < 1 ,or ,p + q < 2.

Then the expected value of xt is given by

(cid:0)

or

E(xt+1) = (1

(cid:0)

q) + (

1 + p + q)E(xt)

(cid:0)

E(xt) = (1

q)=(2

p

(cid:0)

(cid:0)

q)

(cid:0)

since E(xt+1) = E(xt) for a stationary process. Also notice that the expected
value may be written as

E(xt) = 0: P (xt = 0) + 1P (xt = 1) = P (xt = 1)

therefore the unconditional probabilities of being in state 1 and zero are

and

P (xt = 1) = (1

q)=(2

p

(cid:0)

(cid:0)

q)

(cid:0)

P (xt = 0) = 1

P (xt = 1) = 1

(1

(cid:0)

(cid:0)

q)=(2

p

(cid:0)

(cid:0)

q) = (1

p)=(2

p

(cid:0)

(cid:0)

q)

(cid:0)

(cid:0)

Conditional and Unconditional Probabilities of States 0 and 1

(An alternative derivation).

Notice that to start the Markov chain we need information of the probabili-
ties of state 0 and 1 at time zero. This is given by the unconditional probabilities
P (x0 = 0) and P (x0 = 1). To get the unconditional probabilities of the states

3

at time 1, you simply need to multiply the unconditional probabilities at time
zero by the matrix of transition probabilities.

P (x1 = 0)
P (x1 = 1)

=

(cid:21)

(cid:20)

q

(cid:0)

(1

p)

(1

(cid:0)
p

q)

(cid:21) (cid:20)

P (x0 = 0)
P (x0 = 1)

(cid:21)

(cid:20)

It is shown in Cox and Miller (1965) that if there exists a statistical equilibrium
in which the state equilibrium is independent of the initial conditions, then the
state probability (cid:25) satis…es the condition that (cid:5) = P(cid:5), where P is the matrix
of transition probabilities.

(cid:25)0
(cid:25)1

=

(cid:20)

(cid:21)

(cid:20)

q

(cid:0)

(1

p)

(1

(cid:0)
p

q)

(cid:25)0
(cid:25)1

(cid:21) (cid:20)

(cid:21)

where (cid:25)0 = P (xt

j = 0) and (cid:25)1 = P (xt
Then using (cid:25)0 + (cid:25)1 = 1 we get the following values:

j = 1) for all values of j.

(cid:0)

(cid:0)

(cid:25)0 =

(1

p)

(cid:0)
p

(cid:0)

(cid:0)

(2

q)

and (cid:25)1 =

(1

q)

(cid:0)
p

(cid:0)

(cid:0)

(2

q)

where (cid:25)0 and (cid:25)1 are the equilibrium unconditional probabilities. If there
exists a pair of initial values that introduce stationarity in the stochastic process,
then choice of the initial value is of great importance. Note that the initial values
can be the equilibrium unconditional probability.

Given the following initial values,

p0(0)
p0(1)

=

(cid:25)0
(cid:25)1

(cid:21)
it can be shown (by multiplying n times by the transition probability matrix)
that the unconditional probability vector at time n is:

(cid:20)

(cid:20)

(cid:21)

pn(0)
pn(1)

=

(cid:25)0
(cid:25)1

(cid:21)
Therefore, the distribution does not change with time and the stochastic process
is always in equilibrium.

(cid:20)

(cid:21)

(cid:20)

Forecasts for a Markov chain

Sometimes it is also useful to know the probability of being in state 1 (0)at
time t+n given that state 1 (0) prevailed at time t. A clear example is Hamilton’s
(1988) application of …lter to test the (rational) expectational hypothesis of the
term structure of interest rates which requires the forecasting of the state n
periods ahead given the information of the state at time t.

. A n-periods ahead forecast for a Markov chain can be obtained simply by

multiplying n times by the transition probability.

P (xt+n = 0)
P (xt+n = 1)

=

(cid:21)

(cid:20)

q

(cid:0)

(1

(cid:20)

q)

4

(1

(cid:0)
p

n

p)

(cid:21)

(cid:20)

P (xt = 0)
P (xt = 1)

(cid:21)

Following Cox and Miller (1965), Pn is derived in the following way:

1) Find the eigen-values of the transition probability Matrix.

2) Find the associated eigen-vectors.

(cid:21)1 = 1;

(cid:21)2 =

1 + p + q;

(cid:0)

"

3) Express P as T (cid:3)T (cid:0)

1, where

(1

p)

q)

(cid:0)
(1

(cid:0)
q)

(cid:0)
p

(cid:0)
p

(2

(2

(cid:0)

(cid:0)

q) #

1
(cid:0)
1

;

(cid:20)

(cid:21)

T =

"

(1

(cid:0)
(1

p)
1
q) (cid:0)
(cid:0)
q)
1 #
q)

(cid:0)
p

(cid:0)
p

(2

(2

(cid:0)

(cid:0)

;

is the matrix of eigen-vectors and

(cid:20)
a diagonal matrix of eigen-values.

(cid:3) =

1
0

0
1 + p + q

(cid:0)

;

(cid:21)

4) Use the result that

Pn = T (cid:3)nT (cid:0)
1

1
0

0
1 + p + q

(cid:0)

(cid:21) "

(1

(cid:0)
(1

p)
1
q) (cid:0)
(cid:0)
q)
1 # (cid:20)
q)

(cid:0)
p

(cid:0)
p

(2

(2

(cid:0)

(cid:0)

1
(1

q)

(cid:0)
p

q)

(cid:0)

(cid:0)

(2

(cid:0)

1

(cid:0)
p

(1

p)

(2

(cid:0)

(cid:0)

q) #

0

(1

(2

(2

p)

q) + (1

(cid:0)
p

(cid:0)
(1

(cid:0)

(cid:0)
q)
q) (cid:0)

(cid:0)

(cid:0)
p

(1

1)n

1)n

(cid:0)

(cid:0)

q)(p+q
p
(2
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
q)
q) + (1

(cid:0)
p

(cid:0)
p

(cid:0)

(cid:0)

1)n

1)n

p)(p+q
p
(2
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

(cid:0)

(cid:0)

(time t)

or

Pn =

"

0

1
(time t+n)

Note that by making n = 1 in the above matrix we end with the matrix of

transition probabilities, P.

Note also that when n tends to in…nity, the conditional tends to the uncon-
ditional probability. The fact that xt has been in state 0 or 1 ”in…nite”number
of periods ago does not provide any useful information.

In addition, we can derive the conditional expectations:

5

E(xt+n

xt = 0) =
j

E(xt+n

xt = 1) =
j

(2

(1

(2

(cid:0)
(1

q)

(cid:0)
q)

(cid:0)
p

(cid:0)
p

q) (cid:0)

+

q)

(1

(1

(cid:0)

(cid:0)

q)(p + q
p
(2
(cid:0)
p)(p + q
p
(2

(cid:0)

(cid:0)
q)

(cid:0)
q)

1)n

1)n

(cid:0)
The expected value of xt at time n conditional on s at time zero is:

(cid:0)

(cid:0)

(cid:0)

E(xt+n

xt = xt) =
j

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

This result is derived assuming that xt is observed (conditional on xt ),
in most of the empirical applications we will assume that the states are unob-
served and must be predicted from the realizations of yt (the observed variable).
Hamilton has done this using a non-linear …lter consisting of …ve steps that are
described below. His procedure for drawing inferences about xt is an iterative
one. Given an initial inference about xt
1 based on data observed through date
(cid:0)
t
1, iteration t produces an inference about xt based on data observed through
(cid:0)
data t.

A Brief Description of Hamilton’s Non-Linear Filter.

The …lter developed by Hamilton assumes that discrete states ( say high or
low in‡ation) of the economy are not known and therefore have to be inferred
from the data. He assumes that the states follow a discrete Markov process.
Hamilton constructed an optimal non-linear forecast, which can be thought
of as arising from a two step procedure which involves obtaining an optimal
inference about the current state given the past values of the variable that is to
be forecast, and then using the outcome of the …lter to generate future forecasts
of this variable.

Hamilton’s starting point is the assumption that the economy has two possi-
ble states, let us say, state zero and state one. For the sake of simplicity, he also
assumes that the unconditional mean and the variance are the only parameters
that are allowed to vary between regimes. It should be noted that there is no
reason to assume a priori that the other parameters will remain constant from
one regime to the other, and this is something that can easily be tested using
traditional procedures.

The observed variable, yt , is assumed to follow an autoregressive process of
order m, allowing the mean and the variance to vary from state 0 to state 1.
This can be represented in the following way.

yt

(cid:22)xt = (cid:30)1(yt

1

(cid:22)xt

1) + (cid:30)2(yt

2

(cid:22)xt

2) + :: + (cid:30)m(yt

m

(cid:22)xt

m ) + (cid:27)xtvt

(cid:0)
vt is distributed N(0,1) and (cid:22)xt is parameterized as (cid:11)0 + (cid:11)1xt and (cid:27)xt as

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

w0 + w1xt

6

That is the mean is equal to (cid:11)0 in state 0 (when xt = 0), and equal to
(cid:11)0 + (cid:11)1 in state 1 (when xt = 1) and the standard deviation is equal to w0 in
state zero and equal to w0 + w1 in state one.

The error vt is assumed to be independent of all xt

j
(cid:0)

0

(cid:21)

4.2.2 Hamilton’s Filter.

Step_1. Calculate the joint density of the m past states and the current
1 and all past values of y,
state conditional on the information included in yt
where y is the variable that is observed. This is done by using the Markov
property which says that only the information of the last state is relevant.1

(cid:0)

p(xt; xt

1; :; xt

(cid:0)

m

(cid:0)

yt
j

(cid:0)

(cid:0)

1; yt

2; :; y0) = p(xt

1)p(xt

1; xt

2; :; xt

(cid:0)

(cid:0)

xt
j

(cid:0)

m

(cid:0)

yt
j

(cid:0)

1; yt

2; :; y0)

(cid:0)

(cid:0)

p(xt

xt
j

1) is given by (4.1). As in all the subsequent steps the second term
In
2; :::; y0) is known from the input to the
1 (from step

on the right-hand-side is obtained from the preceding step of the …lter.
this case, p(xt
1; yt
yt
j
…lter, which in turn represents the result of the iteration at date t
5).

2; :::; xt

1; xt

(cid:0)

m

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:0)

To begin with the iteration, it is necessary to assign some initial values to
the parameters, and to impose some initial conditions on the Markov process.
For the sake of simplicity, the unconditional distribution p(xm
2; :::x0)
has been chosen for the …rst observation.

1; xm

(cid:0)

(cid:0)

p(xm

1; xm

2; :::x0) = p(xm

(cid:0)

(cid:0)

1

xm
j

(cid:0)

(cid:0)

2):::p(x1

x0)p(x0)
j

where p(x0) are the equilibrium unconditional probabilities as de…ned above.

Step_2. Calculate the joint conditional distribution of yt and (xt; xt

1; :::; xt

m).

(cid:0)

(cid:0)

p(yt; xt; xt

1; :::; xt

1; yt

2; :::; y0) = p(yt

1; :::; xt

m; yt

2; :::; y0):

(cid:0)

m

(cid:0)

yt
j

(cid:0)

(cid:0)

xt; xt
j
p(xt; xt

(cid:0)
1; xt

(cid:0)

(cid:0)

(cid:0)

2; :::; xt

1; yt
(cid:0)
yt
j

(cid:0)

(cid:0)
1; yt

(cid:0)

m

(cid:0)

2; :::; y0)

where we assume that

=

(cid:0)

p(yt

1; :; xt

xt; xt
j
1
p2(cid:25)(!0 + !1xt)
(cid:11)1xt

(cid:30)1(yt

1

(cid:0)

(cid:0)

(cid:0)

m; yt

(cid:0)
exp[

(cid:0)

2; :; y0)
1; yt
(cid:0)
1
2[!0 + !1xt]2 ((yt
(cid:11)0)

(cid:30)m(yt

::

m

(cid:0)

(cid:0)

(cid:0)

(cid:0)

1

(cid:0)

(cid:0)

(cid:11)1xt

(cid:11)0)

(cid:0)

(cid:11)1xt

m

(cid:0)

(cid:11)0))2]

(cid:0)

(cid:0)

(cid:0)

1 This means that the probability of the current state conditional on the previous state is

equal to the probability of the current state conditional on the m past states, that is;

P (Xt

j

(cid:0)

Xt

1) = (Xt

Xt

1; :::; Xt

m)

j

(cid:0)

(cid:0)

7

Note that p(yt

xt; xt
j
is a vector which can take 2m+1 values.

1; :; xt

m; yt

(cid:0)

(cid:0)

(cid:0)

1; yt

(cid:0)

2; :; y0) involves (xt; xt

1; :; xt

m) which

(cid:0)

(cid:0)

Step_3. Marginalise the previous joint density with respect to the states
giving the conditional density, from which the (conditional) likelihood function
is calculated.

p(yt

yt
j

(cid:0)

1; yt

2; :; y0) =

(cid:0)

1

1

1

::

xt=0
X

xt

1=0

(cid:0)

X

xt

m=0

(cid:0)

X

p(yt; xt; xt

1; :; xt

(cid:0)

m

(cid:0)

yt
j

(cid:0)

1; yt

2; :; y0)

(cid:0)

Step_4. Combine the results from steps 2 and 3 to calculate the joint density

of the state conditional on the observed current and past realizations of y

p(xt; xt

1; :; xt

(cid:0)

m

(cid:0)

yt; yt
j

(cid:0)

1; yt

2; :; y0) =

(cid:0)

.

p(yt; xt; xt

(cid:0)
p(yt

1; :; xt
yt
j

(cid:0)

m
(cid:0)
1; yt

(cid:0)

yt
1; yt
j
(cid:0)
2; :; y0)

(cid:0)

2; :; y0)

Step_5. The desired output is then obtained from

1

p(xt; xt

1; :; xt

(cid:0)

m+1

(cid:0)

yt; yt
j

(cid:0)

1; yt

2::; y0) =

(cid:0)

xt

m=0

(cid:0)

X

p(xt; xt

1; :; xt

(cid:0)

m

(cid:0)

yt; yt
j

(cid:0)

1; yt

2; :; y0)

(cid:0)

The output of step 5 is used as an input to the …lter in the next iteration.
Note that to iterate, estimates of the parameters are required. Maximum like-
lihood estimates can be obtained numerically from Step 3 as a by-product of
the …lter, and this is the approach followed in Hamilton (1988). The sample
conditional likelihood is:

ln p(yt; yt

1; yt

(cid:0)

ym
2; :; ym)
j

(cid:0)

(cid:0)

1; :; y0) =

1; :; y0):

yt
j

(cid:0)

T

ln p(yt

t=m
X

which can be maximized numerically with respect to the unknown parameters
((cid:11)1; (cid:11)0; p; q; !0; !1; (cid:30)1; (cid:30)2:::(cid:30)m).

Notice that p and q, the parameters of the transition matrix, are also esti-
mated by maximum likelihood. As we said in Note 1, p and q are the parameters
of the transition matrix associated with remaining in the previous state.

Hamilton’s …lter requires the numerical optimization of a very complicated
non-linear function. Cramer (1986) has pointed out that maximum likelihood
estimation su¤ers from several speci…c types of failures. First, the parameter
vector may change direction at ever increasing speed toward absurd values, while
still increasing log likelihood at each step. Second, the iterative process may
also enter a loop and keep repeating the same movements of the parameters.
Third, collinearity of the data or under identi…cation of the model can produce

8

a close to singular information matrix. We must bear in mind that most of these
problems can occur in the examples to be analyzed as a result of the non-linear
nature of Hamilton’s …lter.

9

Introduction to Bayesian Econometrics

Consider the following regression Model

Y = Xβ + ε,

ε˜N (0, σ2I)

Within the Bayesian framework the parameters θ =

are treated as
random variables. This parameters have probability distributions which reﬂect
the knowledge of the researcher, before observing the sample on Y and X, about
the parameters of the model. This probability distribution, denoted as g(θ) is
called a prior distribution.

β, σ2
{

}

Once Y is observed, the researcher revises the distribution of the parameters
by combining the prior distribution with the information obtained in the sample
using Bayes Theorem.

We will deﬁne the following concepts:

i) f (Y

θ) denotes the distribution of Y (from where we draw the data) given
|

the parameters

ii) h(θ, Y ) denotes the joint distribution of Y and θ.

iii) f (Y ) denotes the marginal distribution of Y

iv) p(θ

Y ) denotes the posterior distribution of θ given Y
|

Then we can write the joint distribution as

h(θ, Y ) = f (Y

θ)g(θ) = p(θ
|

|

Y )f (Y )

which allows to write the posterior as

or equivalently

p(θ

Y ) =
|

f (Y

θ)g(θ)
|
f (Y )

p(θ

Y ) ∝ f (Y
|

θ)g(θ)
|

Using the functional equivalence between f (Y

we can express the posterior as

θ) and the likelihood L(θ
|

Y )
|

Y )g(θ).
|
As we will see later on, the classical and the Bayesian approach are the same
when the prior information is not available, that is, when the prior is diﬀuse or
ﬂat.

Y ) ∝ L(θ
|

p(θ

1

Which prior distributions should be used?
There are groups of densities that may be easier to combine with the in-
formation of the likelihood. The natural conjugate priors are priors that once
they are combined with the likelihood, they produce a posterior which has the
same distribution as the prior.

Example: Distribution of β assuming that σ2 is known

Assume β

Σ0 are known. Then the distribution can be written as

σ2˜N (β0, Σ0) (a multivariate normal distribution) where β0 and
|

g(β

σ2) = (2π)−
|

K
2

∝ exp

−

½

Σ0
|
1
2

(β

.5 exp
|

1
2

−

(β

½
1
0 (β
β0)0Σ−

−

β0)

−

¾

1
0 (β
β0)0Σ−

−

β0)

−

¾

where (2π)−

K
2

Σ0
|

.5 is a known constant.
|

The log likelihood

L(β

σ2, Y ) = (2πσ2)−
|

T
2 exp

∝ exp

1
2σ2 (Y

−

½

1
2σ2 (Y

−

½

Xβ)0(Y

−

−

−

Xβ)0(Y

Xβ)

−

¾

Xβ)

.

¾

where (2πσ2)−

T
2 is a known constant.

Then the posterior is

p(β

σ2, Y ) ∝ g(β
|

σ2)L(β
|
1
∝ exp
2

σ2, Y )
|
(β

−

−

1
0 (β
β0)0Σ−

½

β0)

−

−

1
2σ2 (Y

−

Xβ)0(Y

−

Xβ)

.

¾

Rearranging terms it can be shown that the posterior is also normal, there-

fore the normal density is the natural conjugate prior for β.

Posterior distribution of β

It can be shown that β

σ2, Y ˜N (β1, Σ1) where
|
1
1
1(Σ−
2X 0X)−
β1 = (Σ−
0 + σ−
1
1
2X 0X)−
1(Σ−
0 + σ−
= (Σ−
1
1
2X 0X)−
0 + σ−
Σ1 = (Σ−

0 β0 + σ−
0 β0 + σ−

2X 0Y )
2X 0X

β)

b

2

From the previous equation we can see that the posterior mean of β is an

average of β0 and

β.

Example: Distribution of σ2 assuming that β is known

b

The natural conjugate prior for σ2 is the inverted Gamma distribution (the

natural conjugate prior for 1

σ2 is the Gamma distribution)1.

Prior of 1

β˜Γ( υ0

2 , δ0

2 ) where υ0 and δ0 are known.

σ2 |

Then

g(

1
σ2 |

β)

∝

υ0
2 −

1 exp(

δ0
2σ2 )

−

(

1
σ2 )
and

L(

1
σ2 |

β, Y ) = (2πσ2)−

T
2 exp

1
2σ2 (Y

∝ (σ2)−

T
2 exp

−
½
1
2σ2 (Y

−

½

Xβ)0(Y

−

Xβ)

−

¾

Xβ)0(Y

−

−

Xβ)

.

¾

The posterior, 1

β, Y ˜Γ( υ1

2 , δ1

2 ), is therefore

σ2 |

p(

1
σ2 |

β, Y )

∝

∝

g(

β) L(

β, Y )

1
σ2 |
1 exp(

(

1
σ2 |
1
υ0
σ2 )
2 −
1
σ2 )
1
σ2 )

υ1
2 −

= (

= (

υ0
2 + T

1 exp

2 −

1 exp

−
½
Xβ)0(Y

½

−
δ1
2σ2

−

where δ1 = δ0 + (Y

−

¾
Xβ) and υ1 = υ0 + T.

−

T
2 exp

δ0
2σ2 ) (σ2)−
1
2σ2 (δ0 + (Y

1
2σ2 (Y

−

½

Xβ)0(Y

−

−

−

Xβ)0(Y

Xβ)

−

¾

Xβ))

¾

1 Let zt˜i.i.d.N (0, 1

δ ), t = 1, 2, ......, υ.

Then W =

υ

t=1
(cid:91)

with E(W ) = υ

δ and V (W ) = 2 υ
δ2 .

g(W )

W

∝

t ˜Γ( υ
z2

2 , δ

2 ), where the density of the Gamma distribution is given by

υ
2 −

1 exp(

−

W δ
2

)

3

GIbbs- Sampling in Econometrics
Gibbs-sampling is a Markov chain Monte-Carlo method for approximating
the joint and marginal distributions by sampling from conditional distributions.

Consider the following joint density

f (z1, z2, .........., zk)

and that we are interested in obtaining characteristics of the marginal density

f (zt) =

.....

Z

Z

f (z1, z2, .........., zk)dz1dz2, ..dzt

1dzt+1........, dzk

−

such as the mean or the variance. This exercise may be, when possible, very
diﬃcult to perform

Gibbs sampling will allow me, if we are given the complete set of con-
ditional distributions f (zt
1, zt+1........, zk), to generate a sample of
z1, z2, .........., zk without the need of knowing the joint f (z1, z2, .........., zk) or
the marginals f (zt).

z1, z2, ..zt
|

−

Methodology
Given arbitrary starting values z0

2, ..z0

t , z0

t+1........, z0
k

1) Draw z1

1 from f (z1

2) Then draw z1

3) Then draw z1

t , z0
2, ..z0
z0
|
1, z0
z1
2 from f (z2
|
1, z1
z1
|

3 from f (z3

t+1........, z0
k)
3, ..z0
2, z0

t , z0
4, z0

t+1........, z0
k)
5........, z0
k)

.

.

.

k) Finally draw z1

k from f (zk

1, z1
z1
|

2, z1

3, z1

4, z1

5........, z1
k
−

1)

Then steps 1 to k can be iterated J times to get zj

1, zj

2, ..zj

t , zj

t+1........, zj
k,

f orj = 1, 2, ....., J.

A crucial result in the literature is that of Geman and Geman (1984) that
k con-

shows that the joint and marginal distributions of zj
verge to the joint and marginal distributions of z1, z2, ..zt, zt+1........, zk as J

t+1........, zj

2, ..zj

1, zj

t , zj

→

.

∞

Consider J = L + M, then typically what is done is to use the ﬁrst L
simulations until the Gibbs sampler has converged and then use the remaining
M simulations to approximate the empirical distribution.

4

Convergence of the Gibbs Sampling
The Convergence of the Gibbs sampler is a very important issue which is
somehow diﬃcult to handle.
For example it is usual to plot the posterior
densities over the Gibbs iterations and look for little variation in the generated
distribution over the replications.

Example: A univariate Autoregression

Consider the following autoregressive model

yt = μ + φ1yt

1 + φ2yt

2 + φ3yt

3 + φ4yt

4 + et,

−

−

−

et˜i.i.d.N (0, σ2),

where we assume that the roots of (1

outside the unit circle.

−

φ2L2

−

−

φ3L3

−

φ4L4) = 0 lie

−
φ1L

We can write the autoregressive model in matrix notation as

Y = Xβ + ε,

ε˜N (0, σ2I)

where β = [μ, φ1, φ2, φ3, φ4]0 and X = [1, yt

1, yt

2, yt

3, yt

4].

−

−

−

−

Conditional Distributions of β given σ2

The prior distribution of β is β

indicator to denote that all the roots of (1
lie outside the unit circle.

−

σ2˜N (β0, Σ0)I(s(φ)), where I(s(φ)) is an
|
φ4L4) = 0

φ2L2

φ3L3

φ1L

−

−

−

The posterior distribution of β is β

1
β1 = (Σ−
1
Σ1 = (Σ−

0 + σ−
0 + σ−

σ2, Y ˜N (β1, Σ1)I(s(φ)),where
|
1
2X 0X)−
1(Σ−
1
2X 0X)−

0 β0 + σ−

2X 0Y )

Conditional Distributions of σ2 given β

The Prior distribution of σ2

β˜IΓ( υ0
|
IΓ denotes inverted Gamma distribution.

2 , δ0

2 ) where υ0 and δ0 are known and

The posterior distribution of σ2

Xβ) and υ1 = υ0 + T.

β˜IΓ( υ1
|

2 , δ1

2 ) where δ1 = δ0+(Y

Xβ)0(Y

−

−

5

The Gibbs Sampling procedure consists of the following steps.

Start the iteration of the Gibbs Sampling

•
To start the iteration we use an arbitrary starting value σ2 =

Iterate the following steps j = L + M times

•

0

σ2

©

ª

1) Conditional on σ2 =

σ2

j

1

−

, that is, the value generated in the previous

iteration, we generate βj from the posterior distribution of β.

©

ª

2) Conditional on β = βj,that is, the value β generated in 1), we generate

j

σ2

from the posterior distribution of σ2.

3) Set j = j + 1.

ª

©

In generating β we employ rejection sampling to ensure that all the roots are
outside the unit circle (we discard the draws that do not satisfy this condition).

As a result of this procedure we generate the following sets of values

β1, β2, ................, βL+M ,
2
σ2

, ....,

σ2

σ2

1

,

L+M

.

ª
We discard the ﬁrst L generated values to ensure convergence of the Gibbs-
Sampler and then use the following M values to make inferences about β and σ2.
The remaining M values provide us with the Joint and the Marginal distribution.

ª

©

ª

©

©

Markov- Switching and Gibbs Sampling

We have shown that when estimationg M-S models we treat parameters of
the model depending on an unobserved sate variable. We typically estimate
the models and make inferences on the unobserved variables conditional on
the parameters (estimates) of the model. The Bayesian approach treats both
the parameters of the model and the Markov switching variables as random
variables. Then the inference about the states of the economy (denoted as
ST = S1, S2, ......ST ) is based on the joint distribution of the sates and the
parameters of the model.
e

6

EXAMPLE:

Consider the following model

yt = μSt + εt
μSt = μ0 + μ1St,
St = σ2
σ2
= σ2

0(1
0(1 + h1St),

−

St) + σ2

εt˜N (0, σ2
μ1 > 0
1St

St )

h1 >

1
−

P (St = 0
|
P (St = 1
|

St
St

1 = 0) = q
1 = 1) = p

−

−

The Bayesian approach will entail the inference about T +6 random variables:

S1, S2, ......, ST , μ0, μ1, σ2
{

0, σ2
We need to derive the joint posterior distribution

1, p, q

.
}

g(

ST , μ0, μ1, σ2

0, σ2

1, p, q

e

yT ) = g(μ0, μ1, σ2
|
= g(μ0, μ1, σ2
= g(μ0, μ1, σ2

e

0, σ2
0, σ2
1|
0, σ2
1|

1, p, q
yT ,
yT ,
e

ST ).g(
yT ,
|
ST ).g(p, q
e
e
ST ).g(p, q
e

ST
yT )
|
ST ).g(
yT ,
|
e
e
ST
ST ).g(
|
e
e
e

e

e

yT )
ST
|
yT )
|
e

e

We assume that conditional on

parameters of the model and of the data. Notice that conditional on
expression yt = μSt +εt, εt˜N (0, σ2
St
dummy.

ST , p and q are independent of both other
ST , the
) is simply a regression model with a known
e

e

e

e

The Gibbs Sampling estimation procedure

Using arbitrary starting values we repeat the following steps.

1) Generate St from g(St

block

ST from g(

ST

=t, μ0, μ1, σ2
S
|
μ0, μ1, σ2
|

0, σ2
1, p, q,

0, σ2

1, p, q,
yT )

e

e

2) Generate the transition probabilities p and q from g(p, q

e

3) Generate μ0, μ1, σ2

1, from g(μ0, μ1, σ2

yT ,

ST ).

e
0, σ2

e
0, σ2
1|

ST ).
|

e

yT ) , or generate the whole

e

e

7

6
Step 1):Single move Gibbs Sampling - Generate St from g(St

=t, μ0, μ1, σ2
S
|

0, σ2

1, p, q,

Suppressing the conditioning in the parameters we can write

e

yT )

e

g(St

=t,

S
|

yT ) = g(St

=t,

yt, yt+1, yt+2, ...., yT )

S
|

e

e

=

=

yt)

e

=t,

e

e

yt)

=t,

S
|

e
yt)

g(St

e
S
|

yt)
e

S
|
yt)
e

S
g(St, yt+1, yt+2, ...., yT
|
e
=t,
S
g(yt+1, yt+2, ...., yT
|
e
yt)g(yt+1, yt+2, ...., yT
=t,

=t,
g(yt+1, yt+2, ...., yT
e
=t,
S
|
St
|
e

1, St+1, ..., ST ,
e
g(St, St+1, ..., ST , yt
St
|
St
g(St+1, ..., ST , yt
|
−
e
g(St, St+1, ..., ST , yt
St
|
e
1,
e
St,
1)g(St+1, ..., ST , yt
|

1)
−
St,
1)g(St+1, ..., ST , yt
|
1,
St

yt
−
1,
−
e
yt
1,
−
e
yt
1,
e

e
e
1, yt)
yt
1)

St
|
St
|
e

−
1)

yt

e

e

−

−

−

−

−

−

e

= g(St

= g(St

=

∝
= g(St
= g(St

1,
1)

St
yt
e

−

−

yt

1)

−

e

e

e

Notice that

g(St+1, ..., ST , yt

St,
|

St

1,

yt

−

−

e

e

Then, we can write

1) = g(yt
= g(yt
= g(yt
g(yt

∝

St
St,
|
−
St)g(St+1
|
e
St)g(St+1
|
St)g(St+1
|

1, St+1, ..., ST ,
yt
St

−

1,
St,
|
St)g(St+2, ..., ST
|
St)
|

e

e

1)g(St+1, ..., ST t

yt
−
1)g(St+2, ..., ST ,
−
e
St+1)
|

St

St,
|
−
St+1, St,
|

e

yt

1,
St
−
e

1, yt)
yt

−
1,

−

1, yt)

e

e

where g(St

S
|

g(St

=t,

yT )

∝
1) and g(St+1

e

e

St
|

−

g(St

St

|

1)g(yt

−

St)g(St+1
|

St)
|

St) are given by the transition probabilities and
|

g(yt

St) =
|

1
2πσ2
st

exp

{−

1
2σ2
st

(yt

μst)2

}

−

We can then calculate

p

P (St = j

=t,

S
|

yT ) =

e

e

g(St = j
S
|
1
j=0 g(St = j
e

=t,
S

|

yT )
=t,
e

yT )

e

e

P

8

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
6
6
6
We generate St using a uniform distribution between 0 and 1.

If the gen-
yT ), we set the value of St to

erated number is less or equal than P (St = j
S
|
zero, otherwise we set the value equal to one.

=t,

e

e

Step 1):Multimove Gibbs Sampling - Generate

St from g(

ST

Suppressing the conditioning in the parameters we can write

e

e

μ0, μ1, σ2
|

0, σ2

1, p, q,

yT )

e

g(

ST

yT ) = g(S1, S2, ..., ST ,
|

e

e

−

1,

yT )

yT )
|
yT )g(S1, S2, ..., ST
|
e
1,
yT )g(ST
|
e
1,
yT )g(ST
|
−
e
S2, ., ST
|
e
1,
yT )g(ST
|
T
1

ST ,
|
ST ,
yT )g(S1, S2, ., ST
|
e
yT )g(ST
ST ,
2,
ST
|
|
−
e
yT )...
1, ST ,
2, ST
−
−
e
2,
1)g(ST
yT
ST ,
|
e

−

−

−

−

−

ST
|

= g(ST ,
= g(ST ,
= g(ST ,

= g(ST ,

= g(ST ,

.......g(S1,

−

t=1
Y

yT )
e
|

e

g(St,

St+1,
e
|

yt).

e

e

1, ST ,

ST
2,
|
−
1, ST ,

−
yT )..

yT )

e

1,

−

e
yT
−

2)..g(S1,

S2, y1)
|

The derivation is based on the Markov property that states that to makes
inference about St conditional on St+1 the variables St+2,....ST , yt+1,....yT have
no information beyond that contained in St+1.

Then we proceed in the following way: we ﬁrst generate

and then, for the other values of t = T
on yt and the generated t + 1.

−

1, t

−

We can carry out this using the following steps:

ST conditional on

yT
2, ..., 1, we generate St conditional
e

e

Step 1 Run the Hamilton ﬁlter to get g(St

yt). The last iteration of the ﬁlter

provides g(ST

yT ) that is used to generate ST .
|

e
Step 2 Generate St conditional on St+1 and
yt, for t = T

|

g(St

St+1,
|

e

yt) using the fact that

1, t

−

−

2, ..., 1, form

e

e

g(St

St+1,
|

yt) =

e

=

=

∝

9

g(St, St+1
g(St+1

g(St+1

yt)
|
yt)
|
yt).g(St
St,
e
|
yt)
g(St+1
e
|
St).g(St
e
|
yt)
g(St+1
e
|
St).g(St
|

yt)
e
|

yt)
|

g(St+1

g(St+1

e

yt)

|

e

e

6
Then we calculate

P (St = 1
St+1,
|

yT ) =

St = 1)g(St
g(St+1
|
1
St = j)g(St = j
j=0 g(St+1

yt)
|

|

yt)
|

e

We generate St using a uniform distribution between 0 and 1.

e

P

If the gener-
e
yT ), we set the value of St to

ated number is less or equal than P (St = 1
St+1,
|
zero, otherwise we set the value equal to one.

Generating Transition Probabilities p and q, conditional on

ST

e

Conditional on

ST , p and q are independent of the data set

parameters of the models2.

Prior Distribution

e

p˜beta(u11, u10),
q˜beta(u00, u01),

yT , and the other

e

e

with g(p, q)

pu11

1(1

−

p)u10

∝
hyper parameters of the priors.

−

1qu00

−

1(1

−

q)u01

−

1, where the u
0

−

s are known

The likelihood function
The likelihood function is given by

L(p, q

ST ) = pn11(1
|

−
transitions from i to j which can be counted from

−

p)n10qn00(1

q)n01 where nij refers to the number of

e

Posterior distribution

ST .

e

g(p, q

ST ) = g(p, q)L(p, q
|
pu11
1(1
∝
= pu11+n11

−
1(1
−

e

−

ST )
|
p)u10
e
−

1qu00
−
−
p)u10+n10

1(1

q)u01
−
1qu00+n00

−

1pn11(1
1(1

−

−

p)n10qn00(1

−
q)u01+n01

1,

−

q)n01

−

−

2 A beta distribution denoted by z˜beta(z

α0, α1), is dependent on two hyperparameters
|

α0, α1 > 0 and has density given by

g(z

α0, α1)
|

zα0

∝
= 0

1(1

−

−

z)α1

−

1f or 0 < z < 1
otherwise,

with E(z) = α0

α0+α1

and V ar(z) =

α0α1
(α0+α1)2(α0+α1+1)

10

then,
p
ST ˜beta(u11+n11, u10 + n10),
|
ST ˜beta(u00 + n00, u01 + n01).
q
|
e
e

Generating μ0, μ1,conditional on σ2

0, σ2
1,

yT and

ST

Given

e

e

yt = μ0 + μ1St + εt

εt˜N (0, σ2

St)

we can write

y∗t = μ0x0t + μ1x0t + υt

υt˜N (0, 1)

where y∗t =

yt
σSt

, x0t =

1
σSt

and x1t = St
σSt

Prior Distribution
We can write the model in matrix notation as

Y = Xμ + V,

V ˜N (0, I)

0, σ2
σ2
then if we assume a normal prior μ
|
Posterior distribution
0, σ2
σ2
1,
μ
|

yT ˜N (b1, B1), where b1, B1 are

ST ,

1˜N (b0, B0), where b0, B0 are given.

e

e

1
b1 = (B−
1
B1 = (B−

1
1(B−
0 + X 0X)−
1
0 + X 0X)−

0 b0 + X 0Y )

to constrain μ1 > 0, we discard the draws where this condition is not satis-

ﬁed.

Generating σ2

0, σ2

1,conditional on μ0, μ1,

Given

St = σ2
σ2

0(1 + h1St),

where

1 = σ2
σ2

0(1 + h1).

h1 >

1
−

yT and

ST

e

e

we can ﬁrst generate σ2

0 conditional on h1, and then generate (1 + h1) con-

ditional on σ2
0.

11

Generating σ2

0 conditional on h1

We divide both sides of yt by

(1 + h1St) :

p

y∗∗t

where y∗∗t

= μ0x∗0t + μ1x∗0t + υ∗t
yt
(1 + h1St)

, x∗0t =

=

υ∗t ˜N (0, σ2
0)
1
(1 + h1St)

,

x∗1t =

St

(1 + h1St)

and υ∗t =
p

εt

(1 + h1St)

p

p

then:
The Prior distribution of σ2
0|

μ0, μ1, h1˜IΓ( υ0
known and IΓ denotes inverted Gamma distribution.

p
2 , δ0

2 ) where υ0 and δ0 are

The posterior distribution of σ2
0|

T

μ0, μ1, h1,

ST ,

yT ˜IΓ( υ1

2 , δ1

2 ) where δ1 =

(y∗∗t −

μ0x∗0t −

μ1x∗0t)2 and υ1 = υ0 + T.

e

e

δ0 +

t=1
X

Generating h1 conditional on σ2
0

We divide both sides of yt by σ0 :

y∗∗∗t

= μ0x∗∗0t + μ1x∗∗0t + υ∗∗t

where y∗∗t

=

yt
σ0

, x∗∗0t =

1
σ0

, x∗∗1t = St
σ0

υ∗∗t ˜N (0, (1 + h1St))
and υ∗∗t = εt
σ0

then:
The Prior distribution of h1

0˜IΓ( υ2
known and IΓ denotes inverted Gamma distribution.

μ0, μ1, σ2
|

2 , δ2

2 ) where υ2 and δ2 are

The posterior distribution of h1

2 ) where δ3 =
μ1x∗0t)2 and υ3 = υ2 + T, where N1 is the number of
e

μ0, μ1, σ2
0,
|

yT ˜IΓ( υ3

2 , δ3

ST ,

e

N1

δ2 +

t=1
X
times St = 1..

(y∗∗∗t −

μ0x∗0t −

12


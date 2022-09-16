# Frequency-Moments
Here we give an implementation of the famous online algorithm approximating the frequency moments of a stream of counting data. The outline of the algorithm can be found in at: 

> [The Space Complexity of Approximating the Frequency Moments](https://www.sciencedirect.com/science/article/pii/S0022000097915452), The College Mathematics Journal, 2018

We implement both the 2nd and $k^\text{th}$ moment randomized algorithms, as well as a deterministic $k^\text{th}$ moment algorithm. We also provide accuracy-testing scripts.

## Frequency Moments and their Approximations
Consider a dataset consisting of a string of length $m$, where each element is one of $n$ unique characters. Suppose the characters are numbered $1,...,n$, and $m_i$ gives the number of characters in the data that are character $i$. The kth frequency moment is given by $\sum_i (m_i)^k$. Noteworty moments are the $0^\text{th}$ moment, which gives $n$; the $1^\text{th}$ moment, which gives $m$; and the $2^\text{nd}$ moment, which is used to calculate the ginni coefficient and the suprise index of the string.

[The Space Complexity of Approximating the Frequency Moments](https://www.sciencedirect.com/science/article/pii/S0022000097915452) gives a method of approximating the $k^\text{th}$ frequency moment through a streaming algorithm, that is, an algorithm that does not store the data in memory but processes it in a stream and forgets it. This is desirable when the data's size is large enough to prohibit storage. It also gives an improved method for estimating the $2^\text{nd}$ moment. The algorithm is randomized, and there is a tension between the pobability the approximation is within stipulated error bounds, and the ammount of memory alloted to the algorithm.

## Contents/How to Run
Runs tests on the accuracy of the $2^\text{nd}$ and $k^\text{th}$ moment approximation algorithms:
```
counterTest.m
```

Implementation of a class for the deterministic/exact moment calculater:
```
dCounter.m
```

Implementation a class for the $k^\text{th}$ moment approximation algorithm:
```
rGeneralCounter.m
```

Implementation a class for the improved $2^\text{nd}$ moment approximation algorithm:
```
rTwoCounter.m
```

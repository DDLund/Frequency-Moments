# Frequency-Moments
Here we give an implementation of the famous online algorithm approximating the frequency moments of a stream of counting data. The outline of the algorithm can be found in at: 

> [The Space Complexity of Approximating the Frequency Moments](https://www.sciencedirect.com/science/article/pii/S0022000097915452), The College Mathematics Journal, 2018

We implement both the 2nd and $k^\text{th}$ moment randomized algorithms, as well as a deterministic $k^\th{th}$ moment algorithm. We also provide accuracy-testing scripts.

## Frequency Moments and their Approximations
Consider a dataset consisting of a string of length $m$, where each element is one of $n$ unique characters. Suppose the characters are numbered $1,...,n$, and $m_i$ gives the number of characters in the data that are character $i$. The kth frequency moment is given by $\sum_i (m_i)^k$. Noteworty moments occure at $k=0$ ($n$), $k=1$ ($m$), and $k=2$, which is used to calculate the ginni coefficient and the suprise index of the string.

The Space Complexity of Approximating the Frequency Moments](https://www.sciencedirect.com/science/article/pii/S0022000097915452) gives a method of approximating the $k^\text{th}$ frequency moment through a streaming algorithm, that is, an algorithm that does not store the data in memory but processes it in a stream and forgets it. This is desirable when the data's size is large enough to prohibit storage. The algorithm is randomized, and there is a tension between the pobability the approximation is within stipulated error bounds, and the ammount of memory alloted to the algorithm.

## How to Run
To run tests comparing the two randomized alorithms to the exact value, run the file:
```
counterTest.m
```
To run tests for frequency moments higher than 2, comment out lines corresponding to the two-counter in the file and run.

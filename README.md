# Frequency-Moments
Here we give an implementation of the famous online algorithm approximating the frequency moments of a stream of counting data. The outline of the algorithm can be found in "The Space Complexity of Approximating the Frequency Moments", which can be found here: 

> [The Space Complexity of Approximating the Frequency Moments](https://www.sciencedirect.com/science/article/pii/S0022000097915452), The College Mathematics Journal, 2018


We implement both the 2nd and kth moment randomized algorithms, as well as a deterministic kth moment algorithm. We also provide accuracy-testing scripts.

## How to Run
To run the tests comparing the two randomized alorithms agains the exact value, run the file:
```
counterTest.m
```
To run tests for frequency moments higher than 2, comment out lines corresponding to the two-counter in the file and run.

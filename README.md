# Frequency-Moments
Here we give an implementation of the famous online algorithm approximating the frequency moments of a stream of counting data. The outline of the algorithm can be found in "The Space Complexity of Approximating the Frequency Moments", which can be found here: https://www.sciencedirect.com/science/article/pii/S0022000097915452

## How to run the code for different applications

**1. Generate the images from the trafic light example**

The general usage of the script is shown below. Please do not run any code in this section until you understand section 2. You will need partial models to run the script and section 2 will tell you how to do that. 
```
python main.py $image_file $first_part_model $model_second_part $x1 $y1 $x2 $y2 -n $num_steps -p $percent
```
You can use the following command to check more details:
```
python main.py -h
```
To reproduce the results we show above, use the following command:
```
python main.py n06874185_1258.JPEG  model_first_part.pt model_second_part.pt 45 100 90 130 -n 256 -p 1
```

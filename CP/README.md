# Instructions to Test the CP Model Execution

The cp model can be tested directly from the Minizinc file by setting manually the instances or through a python script which imports the model from the mzn file and provides the instances read from the txt file and outputs graphically the solution.

## Running the Basic Model

To run the basic model, it is sufficient to open the `PWP.mzn` and uncomment the interested instance or insert it manually.

## Running the Multi Model

To run the multi model, you have to run firstly the `PWP2_1.mzn` with the desired instance and then, with the solved values of the variable x, run `PWP2_2.mzn`.

**ACHTUNG:** Remember to comment again all the instances in the mzn files before running the python scripts.

## Running the Simulation Script

In order to run the script for the simulation, you need python correctly installed. Then you need the following libraries: numpy, matplotlib, seaborn, minizinc. These can be installed by typing in the terminal the following commands:

```
pip install numpy
pip install matplotlib
pip install seaborn
pip install minizinc
```

The script works by giving it an argument which must be an integer between 8 and 40, which indicates the instance you want to solve. For example, if you want to solve 11x11.txt, you have to write in the terminal placed in the `src` folder:

```
python cp_model.py 11           # to execute the basic model
python cp_model_multi.py 11     # to execute the multi model
```

Anytime the script is executed, in the same folder, the file `pwp.txt` containing the solution is generated, and a graphical representation of the solution is shown.

## General Folder

The `general` folder contains the points 5 and 6 of the project, which deal with rotation and rectangles with the same dimension. I provide also two instances 11 and 12 modified from the originals to test this model.

In order to run them, it is sufficient to execute the `PWP_rot.mzn` or write in the terminal placed in the `general` folder:

```
python cp_model_rot_same.py 11
python cp_model_rot_same.py 12
```

## Checking Results

You can also run only the function which shows graphically the instances solved. This function takes as argument the relative path of the file txt of the solution. For example, if you want to see the graphical result of 11x11-out.txt, you have to write in the terminal placed in the `src` folder the following commands:

```
python
from show_pwp import show_pwp
show_pwp("../out/11x11-out.txt")
```

Due to the fact that sometimes nearby pieces are represented with the same color, for a further checking, the function `show_pwp` also prints a file called `mat.txt` in the src folder to show with a matrix the exact position of each element.

For a faster checking, I also provide the figures of the solved instances in the `out_figures` folder.
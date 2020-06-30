INSTRUCTIONS TO TEST THE CP MODEL

The cp model can be tested directly from the Minizinc file by setting manually the instances or through a python script which imports the model from the mzn file and provides the instances read from the txt file and outputs graphically the solution.

In order to run the script for the simulation you need python correctly installed.
Then you need the following libraries numpy, matplotlib, seaborn, minizinc. These can be installed by typing in the terminal the following commands:
'pip install numpy'
'pip install matplotlib'
'pip install seaborn'
'pip install minizinc'

The script works by giving it an argument which must be an integer between 8 and 40, which indicates the instance you want to solve, for example if you want to solve 11x11.txt you have to write in the terminal placed in the src folder 
'python cp_model.py 11'

You can also run only the function which shows graphically the instances solved, for example if you want to see the graphical result of 11x11-out.txt you have to write in the terminal placed in the src folder the following commands:
'python'
'from show_pwp import show_pwp'
'show_pwp('../out/11x11-out.txt')'

Due to the fact that sometimes nearby pieces are represented with the same color, for a further checking, the function show_pwp also prints a file called 'mat.txt' in the src folder to show with a matrix the exact position of each element.
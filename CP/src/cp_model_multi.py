import numpy as np
import matplotlib
from matplotlib import pyplot as plt
import seaborn as sns
import sys
from minizinc import Instance, Model, Solver, Result
from show_pwp import show_pwp


# Read the file
dim = sys.argv[1]
filepath = '../../Instances/' + str(dim) + 'x' + str(dim) + '.txt'
with open(filepath, 'r') as file:
    data = file.read()
    file.close()

# Extract the data from the file
temp = data.split('\n')
w = int(temp[0].split(' ')[0])
h = int(temp[0].split(' ')[1])
n = int(temp[1])
l = []
for i in range(n):
  l_temp = list(map(int, temp[2+i].split(' ')))
  l.append(l_temp)
l = np.array(l)
p_width = list(map(int, l[:,0]))
p_height = list(map(int, l[:,1]))


# Load model from file
pwp = Model("./PWP2_1.mzn")
# Find the MiniZinc solver configuration for Gecode
gecode = Solver.lookup("gecode")
# Create an Instance of the PWP model for Gecode
instance = Instance(gecode, pwp)
# Assign the instances
instance["n"] = n
instance["w"] = w
instance["h"] = h
instance["p_width"] = p_width
instance["p_height"] = p_height
res: Result = instance.solve()

print('Solving for x')
if not(res.solution):
    print('Failed to solve')
else:
    print(res.solution)
    x = res.__getitem__('x')

    # Print the statistics
    for value in res.statistics:
        print(value + ": " + str(res.statistics[value]))


    # Load model from file
    pwp = Model("./PWP2_2.mzn")
    # Find the MiniZinc solver configuration for Gecode
    gecode = Solver.lookup("gecode")
    # Create an Instance of the PWP model for Gecode
    instance = Instance(gecode, pwp)
    # Assign the instances
    instance["n"] = n
    instance["w"] = w
    instance["h"] = h
    instance["p_width"] = p_width
    instance["p_height"] = p_height
    instance["x"] = x
    res: Result = instance.solve()

    print('')
    print('Solving for y')
    if not(res.solution):
        print('Failed to solve')
    else:
        print(res.solution)
        y = res.__getitem__('y')

        # Write the pwp.txt file
        output = str(w) + ' ' + str(h) + '\n' + str(n) + '\n' 
        for i in range(n):
            output = output + str(p_width[i]) + ' ' + str(p_height[i]) + ' ' + str(x[i]) + ' ' + str(y[i]) + '\n'
        filepath_out = '../out/' + str(dim) + 'x' + str(dim) + '-out.txt'
        with open('pwp.txt', 'w') as file:
            file.write(output)
            file.close()
        # with open(filepath_out, 'w') as file:
        #     file.write(output)
        #     file.close()

        # Print the statistics
        for value in res.statistics:
            print(value + ": " + str(res.statistics[value]))

        # Show the result
        show_pwp('pwp.txt')


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

print(p_width)
print(p_height)

# Load model from file
pwp = Model("./PWP.mzn")
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

print(res.solution)
x = res.__getitem__('x')
# y = res.__getitem__('y')

# print(res.__getitem__('x'))
count = np.zeros(w)
y = []
for i in range(n):
  val = int(max(count[x[i]:x[i]+p_width[i]]))
  y.append(val)
  count[x[i]:x[i]+p_width[i]] = val + p_height[i]

output = str(w) + ' ' + str(h) + '\n' + str(n) + '\n' 
for i in range(n):
    output = output + str(p_width[i]) + ' ' + str(p_height[i]) + ' ' + str(x[i]) + ' ' + str(y[i]) + '\n'
filepath_out = '../out/' + str(dim) + 'x' + str(dim) + '-out.txt'
with open('pwp.txt', 'w') as file:
    file.write(output)
    file.close()
with open(filepath_out, 'w') as file:
    file.write(output)
    file.close()


for value in res.statistics:
	print(value + ": " + str(res.statistics[value]))

show_pwp('pwp.txt')
# print(res.solution)


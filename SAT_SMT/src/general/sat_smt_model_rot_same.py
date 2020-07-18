import z3
from z3 import *
import numpy as np
import sys
from show_pwp import show_pwp


# Read the file
dim = sys.argv[1]
filepath = './' + str(dim) + 'x' + str(dim) + '.txt'
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
p_w = list(map(int, l[:,0]))
p_h = list(map(int, l[:,1]))

x = [ Int('x_%i' % (i + 1)) for i in range(n) ]
y = [ Int('y_%i' % (i + 1)) for i in range(n) ]

# In order to deal with rotation I add a boolean array of variables which 
# indicate if an element is rotated or not
rot = [ Bool('rot_%i' % (i + 1)) for i in range(n) ]

val_x = [ And(0 <= x[i], If(rot[i], x[i] <= h-p_h[i], x[i] <= w-p_w[i])) for i in range(n) ]
val_y = [ And(0 <= y[i], If(rot[i], y[i] <= w-p_w[i], y[i] <= h-p_h[i])) for i in range(n) ]

overlap = []
for i in range(n):
    overlap.append([If(And(rot[i], rot[j]), 
                        Or(x[i] + p_h[i] <= x[j], x[j] + p_h[j] <= x[i], 
                            y[i] + p_w[i] <= y[j], y[j] + p_w[j] <= y[i]),
                        If(rot[i],
                            Or(x[i] + p_h[i] <= x[j], x[j] + p_w[j] <= x[i], 
                                y[i] + p_w[i] <= y[j], y[j] + p_h[j] <= y[i]),
                            If(rot[j],
                                Or(x[i] + p_w[i] <= x[j], x[j] + p_h[j] <= x[i], 
                                    y[i] + p_h[i] <= y[j], y[j] + p_w[j] <= y[i]),
                                Or(x[i] + p_w[i] <= x[j], x[j] + p_w[j] <= x[i], 
                                    y[i] + p_h[i] <= y[j], y[j] + p_h[j] <= y[i]),   
                        ))) for j in range(i+1, n)])

# If there are multiple rectangles with the same dimension I can force 
# a relation between the two positions
same_dim = []
for i in range(n):
    same_dim.append([If(And(p_w[i] == p_w[j], p_h[i] == p_h[j]),
                        Or(x[j] >= x[i] + p_w[i], y[j] >= y[i] + p_h[i]),
                        True) for j in range(i+1, n)])

constraints = val_x + val_y
for i in range(n):
    constraints = constraints + overlap[i] + same_dim[i]

# Solve the problem
s = Solver()
s.add(constraints)
if s.check() == sat:
    m = s.model()
    x_eval = [ m.evaluate(x[i]) for i in range(n) ]
    y_eval = [ m.evaluate(y[i]) for i in range(n) ]
    rot_eval = [ m.evaluate(rot[i]) for i in range(n) ]
    print('x = ' + str(x_eval))
    print('y = ' + str(y_eval))
    print('rot = ' + str(rot_eval))
else:
    print("Failed to solve")

# Print output file
output = str(w) + ' ' + str(h) + '\n' + str(n) + '\n' 
for i in range(n):
    if(rot_eval[i]):
        output = output + str(p_h[i]) + ' ' + str(p_w[i]) + ' ' + str(x_eval[i]) + ' ' + str(y_eval[i]) + '\n'
    else:
        output = output + str(p_w[i]) + ' ' + str(p_h[i]) + ' ' + str(x_eval[i]) + ' ' + str(y_eval[i]) + '\n'
filepath_out = '../out/' + str(dim) + 'x' + str(dim) + '-out.txt'
with open('pwp.txt', 'w') as file:
    file.write(output)
    file.close()
# with open(filepath_out, 'w') as file:
#     file.write(output)
#     file.close()

show_pwp('pwp.txt')

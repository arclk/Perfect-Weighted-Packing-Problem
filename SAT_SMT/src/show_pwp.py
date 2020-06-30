import numpy as np
import matplotlib
from matplotlib import pyplot as plt
import seaborn as sns
import sys

def show_pwp(filename):

    # Read the file
    with open(filename, 'r') as file:
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

    # Create the matrix representing the solution of the problem
    matrix = np.zeros((w,h))
    for i in range(n):
        c = l[i]
        matrix[c[2]:c[2]+c[0], c[3]:c[3]+c[1]] = i+1

    mat = np.rot90(matrix)
    np.set_printoptions(threshold=sys.maxsize)
    out_mat = str(mat)
    out_mat = out_mat.replace('. ', ' ')
    out_mat = out_mat.replace('.', '')
    out_mat = out_mat.replace('\n  ', ' ')

    with open('mat.txt', 'w') as file:
        file.write(out_mat)
        file.close()

    # Plot the solution
    sns.heatmap(mat, cbar=None, linewidths=1, xticklabels=False, yticklabels=False, square=True, cmap='tab20')
    matplotlib.pyplot.show(block=True)
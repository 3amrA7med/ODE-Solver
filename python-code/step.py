import numpy as np
import random
from step_utils import dec2bin
from step_utils import bin2dec
from modules import adder

N = random.randint(1, 50)                                   # size of vector from 1 to 50
print("N = ", N)

Hinit = random.random() + random.randint(0, 1)              # initial step from 0 to 2
Hinit = bin2dec(dec2bin(str(Hinit), 7))                     # approximate to match fixed point representation
print("Initial h = ", Hinit)

L = 2                                                       # tolerance
print("Tolerance = ", L)

X0 = []
X1 = []
Hnew = 0

for i in range(N):
    num = random.random() + random.randint(0, 60)       # random decimal number between 0 and 60.99
    sf = random.randint(0, 6)                           # random scale factor
    strBinNum = dec2bin(str(num), sf)                   # 16 bit binary string
    X0.append(strBinNum)

    num = random.random() + random.randint(0, 60)      # random decimal number between 0 and 60.99
    sf = random.randint(0, 6)                          # random scale factor
    strBinNum = dec2bin(str(num), sf)                  # 16 bit binary string
    X1.append(strBinNum)

print("X0 in bin : ", X0)

print("X0 in dec : ")
for i in range(N):
    print(bin2dec(X0[i]))

print("X1 in bin : ", X1)

print("X1 in dec : ")
for i in range(N):
    print(bin2dec(X1[i]))

error = 0
for i in range(N):
    diff, q, w = adder(X0[i], X1[i], 1, 0)          # Diff using subtract module
    diff = bin(diff).split('b')[1]      # Diff in fixed point as binary
    error += np.abs(bin2dec(diff))      # error as decimal value

print("Error = ", error)
if error > L:
    Hnew = (0.9 * pow(Hinit, 2) * L) / error

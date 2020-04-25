import numpy as np
import random
import sys
from step_utils import dec2bin
from step_utils import bin2dec
from step_utils import adder
from step_utils import multiplier
from step_utils import division
from step_utils import binaryToDecimal
from step_utils import create_testBench

N = random.randint(1, 50)  # size of vector from 1 to 50

print("N = ", N)

Hinit = random.random() + random.randint(0, 5)  # initial step from 0 to 2
# Hinit = 2.0
Hinit = dec2bin(str(Hinit), 4)  # approximate to match fixed point representation
print("Initial h = ", bin2dec(Hinit))

L = 2.0 # tolerance
print("Tolerance = ", L)

X0 = [ ]
X1 = [ ]
X0Decimal = [ ]
X1Decimal = [ ]
Hnew = 0
invalid = 0

for i in range(N):
    num = random.random() + random.randint(0, 10)  # random decimal number between 0 and 10.99
    sf = random.randint(0, 3)  # random scale factor
    strBinNum = dec2bin(str(num), sf)  # 16 bit binary string
    X0.append(strBinNum)

    num = random.random() + random.randint(0, 10)  # random decimal number between 0 and 10.99
    sf = random.randint(0, 3)  # random scale factor
    strBinNum = dec2bin(str(num), sf)  # 16 bit binary string
    X1.append(strBinNum)

# X0 = ["0000000000000110", "0000000000000111"]
# X1 = ["0000000000000100", "0000000000000101"]
print("X0 in bin : ", X0)

print("X0 in dec : ")
for i in range(N):
    X0Decimal.append(bin2dec(X0[ i ]))
    print(bin2dec(X0[ i ]))

print("X1 in bin : ", X1)

print("X1 in dec : ")
for i in range(N):
    print(bin2dec(X1[ i ]))
    X1Decimal.append(bin2dec(X1[ i ]))

error = "0000000000000000"
for i in range(N):
    diff, v = adder(X0[ i ], X1[ i ], 1, 0)  # Diff using subtract module
    invalid = invalid or v
    sf_diff = diff >> 13  # store scale factor of diff to convert it from dec to binary
    diff = bin(diff).split('b')[ 1 ]  # Diff in fixed point as binary
    diff = bin2dec(diff)  # get decimal value of difference
    diff = np.abs(diff)  # get absolute value
    diff = dec2bin(str(diff), sf_diff)  # change to binary string again
    r, v = adder(error, diff, 0, 0)
    invalid = invalid or v
    error = bin(r).split('b')[ 1 ]

print("Error in binary = ", error)
print("Error in decimal = ", bin2dec(error))

if bin2dec(error) > L:
    const = dec2bin(str(0.9), 7)
    # print("0.9 = ", const)
    # print("0.9 = ", bin2dec(const))

    r, v = multiplier(const, dec2bin(str(L), 0))
    Hnew = bin(r).split('b')[ 1 ]
    invalid = invalid or v
    # print(Hnew)
    # print(bin2dec(Hnew))

    r, v = multiplier(Hnew, Hinit)
    Hnew = bin(r).split('b')[ 1 ]
    invalid = invalid or v
    # print("h square = ", Hnew)
    # print("h square = ", bin2dec(Hnew))

    r, v = multiplier(Hnew, Hinit)
    Hnew = bin(r).split('b')[ 1 ]
    invalid = invalid or v
    # print(Hnew)
    # print(bin2dec(Hnew))

    v, r, z = division(0, Hnew, error)
    Hnew = bin(r).split('b')[ 1 ]
    invalid = invalid or v or z
    Hnew = '0' + Hnew

    if invalid:
        print("Overflow or division by zero occured")
    else:
        print("Hnew in binary  = ", Hnew)
        print("Hnew in decimal = ", bin2dec(Hnew))

    # Hnew = (0.9 * pow(Hinit, 2) * L) / error
else:
    if(binaryToDecimal(int(Hinit)) > 1):
        Hnew = 1
    else:
        Hnew = Hinit



create_testBench(X0, X1, N, Hnew, L, Hinit, error)

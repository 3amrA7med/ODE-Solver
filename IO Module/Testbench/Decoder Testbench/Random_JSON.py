
import random
from random import randint
import json 

scaleFactor = 2
N = randint(1, 50)
M = randint(1, 50)
Count =  randint(1, 5)
Mode = randint(0, 1)
H = round(random.uniform(0,2), scaleFactor)
Err = round(random.uniform(0,1), scaleFactor)
PerMode = randint(0, 2)

# A, B
A = []
for i in range(N):
    A.append([])
    for j in range(N):
        A[i].append(round(random.uniform(-2000,2000), scaleFactor))

B = []
for i in range(N):
    B.append([])
    for j in range(M):
        B[i].append(round(random.uniform(-2000,2000), scaleFactor))

X0 = []
for i in range(N):
    X0.append(round(random.uniform(-2000,2000), scaleFactor))

T = []
for i in range(Count):
    T.append(randint(1, 50))

U0 = []
for i in range(M):
    U0.append(round(random.uniform(-2000,2000), scaleFactor))

Us = []
for i in range(Count):
    Us.append([])
    for j in range(M):
        Us[i].append(round(random.uniform(-2000,2000), scaleFactor))


data = {
        "N" : N,
        "M" : M,
        "Count": Count,
        "Mode": Mode,
        "H": H,
        "Err": Err,
        "PerMode": PerMode,
        "A": A,
        "B": B,
        "X0": X0,
        "T": T,
        "U0": U0,
        "Us": Us
        }

with open('JsonData.json', 'w') as outfile:
    json.dump(data, outfile)
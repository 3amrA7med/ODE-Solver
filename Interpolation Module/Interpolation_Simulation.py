
# coding: utf-8

# In[6]:



import random
import sys
from modules import * 

U_COUNT = 1        #No of Us to calculate
Current_T = '0010000000000001'
U_SIZE = 2         #size of U vector
T_SIZE = U_COUNT + 1

time_stamps = []
Us= []
Current_U = []
UKs = []
Current_UK = []

for i in range(T_SIZE):
    time_stamps.append(f'{i:016b}')

for i in range(U_COUNT + 1):    
    for j in range(U_SIZE):
        Current_U.append(f'{random.randint(0, 10):016b}')
    Us.append(Current_U)
    Current_U = []

indx = 0    
for i in range(U_COUNT):
    for indx in range(U_SIZE):
        UK1, UK1_COUT, UK1_INVALID = adder(Us[i + 1][indx], Us[i][indx], 1, 0)
        UK1 = f'{UK1:016b}'
        UK2, UK2_COUT, UK2_INVALID = adder(time_stamps[i + 1], time_stamps[i], 1, 0)
        UK2 = f'{UK2:016b}'
        UK1_INVALID, UK1, UK1_DIVZERO, UK1_READY = division(1, UK1, UK2)
        UK1 = f'{UK1:016b}'
        UK2, UK2_COUT, UK2_INVALID = adder(Current_T, time_stamps[i], 1, 0)
        UK2 = f'{UK2:016b}'
        UK1, UK1_INVALID = multiplier(UK2, UK1)
        UK1 = f'{UK1:016b}'
        UK1, UK1_COUT, UK1_INVALID = adder(UK1, Us[i][indx], 0, 0)
        UK1 = f'{UK1:016b}'
        Current_UK.append(UK1)
    
    indx = 0
    UKs.append(Current_UK)
    Current_UK = []
    Current_T, Current_T_COUT, Current_T_INVALID = adder(Current_T, f'{1:016b}', 0, 0)
    Current_T = f'{Current_T:016b}'

f= open("testcase.txt","w+")
f.write("%s\n" % f'{U_COUNT:016b}')
f.write("%s\n" % '0010000000000001')
f.write("%s\n" % f'{U_SIZE:016b}')
for i in range(T_SIZE):
    f.write("%s\n" % time_stamps[i])

for i in range(50 - T_SIZE):
    f.write("%s\n" % '0000000000000000')
for i in range(U_COUNT + 1):
    for j in range(U_SIZE):
        f.write("%s\n" % Us[i][j])
    for k in range(50 - U_SIZE):
        f.write("%s\n" % '0000000000000000')
    

var = (5 - (U_COUNT + 1)) * 50
for k in range(var):
    f.write("%s\n" % '0000000000000000') 
for i in range(U_COUNT):
    for j in range(U_SIZE):
        f.write("%s\n" % UKs[i][j])
    for k in range(50 - U_SIZE):
        f.write("%s\n" % '0000000000000000')         
        
f.close()      


# In[1]:


i = 7
f'{i:016b}'


# In[20]:


int('1111111111111111', 2)


# In[2]:


Current_T = '1110000001000000'
Current_T


# In[3]:


adder('0010000000000001', '0000000000000000', 1, 0)


# In[3]:


division(1, '0001111111111111', '0000000000000001')


# In[9]:


var = 32
 
print("value = ", -(~var))


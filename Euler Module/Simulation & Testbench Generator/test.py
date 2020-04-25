import numpy as np
import sys
sys.path.append('../..')
from python_code.modules import multiplier,adder
#Python=58112   Verilog=65152



def MatrixMultiplication(matrix,vector):
    result = np.zeros((matrix.shape[0],1)).astype('uint16')
    for i in range(0,matrix.shape[0]):
        for j in range(0,vector.shape[0]):
            m="{0:016b}".format(matrix[i,j])
            v="{0:016b}".format(vector[j,0])
            r = np.uint16(multiplier(m,v)[0])
            mul="{0:016b}".format(multiplier(m,v)[0])
            print(matrix[i,j],vector[j,0],r)
            res="{0:016b}".format(result[i,0])
            result[i,0] = adder(res,mul,0,0)[0]
            print(result[i,0])
    return result

def Final(Res1,Res2,h_val,X_vec):
    
    h_val="{0:016b}".format(h_val)
    # for i in range(0,Res1.shape[0]):
    R1="{0:016b}".format(Res1)
    R2="{0:016b}".format(Res2)
    X_b="{0:016b}".format(X_vec)

    sumR= adder(R1,R2,0,0)[0]
    sumR = "{0:016b}".format(sumR)
    mulH = "{0:016b}".format(multiplier(sumR,h_val)[0])
    result=np.uint16(adder(X_b,mulH,0,0)[0])
    return result


n=24
m=24
h=42487

A=np.array([35913, 11622, 16449, 54529, 10802, 30080, 60928, 38337, 54025, 1536, 4528, 52370, 36619, 48049, 54779, 58211, 6967, 9551, 9797, 16785, 4225, 26162, 60194, 3316])
B=np.array([29863, 15517, 35174, 31588, 25312, 53080, 37094, 40868, 65180, 15599, 59980, 56672, 21053, 11930, 4078, 38673, 26312, 25476, 41510, 53346, 58077, 1831, 54487, 48584])
X=np.array([2440, 5185, 57211, 34274, 53257, 2120, 61665, 21306, 63750, 3918, 44992, 22397, 2684, 7953, 62359, 9260, 12259, 5240, 16802, 48869, 56654, 38980, 29338, 48291])
U=np.array([34799, 20343, 48289, 10554, 1422, 21886, 55974, 8912, 38241, 20693, 52648, 48625, 2250, 25725, 34965, 57977, 50264, 48820, 12398, 3825, 24619, 18404, 28335, 64819])


A=np.reshape(A,(1,24))
X=np.reshape(X,(24,1))
B=np.reshape(B,(1,24))
U=np.reshape(U,(24,1))



print("####################################################### B*U #################################################")
R1=MatrixMultiplication(B,U)
print("####################################################### A*X #################################################")
R2=MatrixMultiplication(A,X)
Ans=Final(R1[0,0],R2[0,0],h,X[18,0])
print(Ans)
import numpy as np
import sys
sys.path.append('../..')
from python_code.modules import multiplier,adder

def init():
    out.write('vlog *.v\n')
    out.write('quit -sim\n')
    out.write('vsim work.Euler\n')
    out.write('radix -unsigned\n')
    out.write('add wave *\n')
    out.write('force -freeze CLK 0 1, 1 {50 ps} -r 100\n')
    out.write('force INT 0\n')
    out.write('force PROCESS 0\n')
    out.write('run 100 ps\n')

def writeMemory(value,pos):
        out.write('mem load -filltype value -filldata '+str(value)+' -fillradix unsigned /Euler/Memory/Memory('+str(pos)+')\n')

def writeMatrix(name, mat, address):
    out.write('\n#Set '+ name +' Matrix\n')
    pos=0
    for row in mat:
        for val in row:
            writeMemory(val,address+pos)
            pos+=1

def writeIF(value,test,index):
    out.write('\nset val [examine RAM_DATA_WR]\n')
    out.write('if {$val != '+str(value)+'} {\n')
    out.write('error "Test'+str(test)+': Failed, XNew['+str(index)+'] != '+str(value)+'"\n')
    out.write('}\n')

def MatrixMultiplication(matrix,vector):
    result = np.zeros((matrix.shape[0],1)).astype('int')
    # print(result)
    for i in range(0,matrix.shape[0]):
        for j in range(0,vector.shape[0]):
            m="{0:016b}".format(matrix[i,j])
            v="{0:016b}".format(vector[j,0])
            mul="{0:016b}".format(multiplier(m,v)[0])
            res="{0:016b}".format(result[i,0])
            result[i],cout, inv = adder(res,mul,0,0)
            result[i]+=(cout<<16)
    return result

def Final(Res1,Res2,h_val,X_vec):
    result = np.zeros((Res1.shape[0],1)).astype('int')
    
    h_val="{0:016b}".format(h_val)
    for i in range(0,Res1.shape[0]):
        R1="{0:016b}".format(Res1[i,0])
        R2="{0:016b}".format(Res2[i,0])
        X_b="{0:016b}".format(X_vec[i,0])

        sumR,cout,inv = adder(R1,R2,0,0)
        sumR+=(cout<<16)
        sumR = "{0:016b}".format(sumR)
        mulH = "{0:016b}".format(multiplier(sumR,h_val)[0])
        result[i],cout,inv =adder(X_b,mulH,0,0)
        result[i]+=(cout<<16)
    return result


n_ADD=0
m_ADD=1
h_ADD=4
A_ADD=7
B_ADD=2507
X_ADD=5207
U_ADD=5257
out=open('stress_testbench.do','w')

testcase=int(sys.argv[1])  #Number of testcases
init()

tc=0

for tc in range(0,testcase):
    n=np.random.randint(1,51)
    m=np.random.randint(1,51)
    h=np.random.randint(1,11)
    A = np.random.randint(0,1<<13,(n,n)).astype('int')
    X = np.random.randint(0,1<<13,(n,1)).astype('int')
    B = np.random.randint(0,1<<13,(n,m)).astype('int')
    U = np.random.randint(0,1<<13,(m,1)).astype('int')

    # R1=np.dot(B,U)
    # R2=np.dot(A,X)
    # Ans=(R1+R2)*h+X
    R1=MatrixMultiplication(B,U)
    R2=MatrixMultiplication(A,X)
    Ans=Final(R1,R2,h,X)

    out.write('\n\n################################################## Testcase: ' + str(tc) +' ##################################################\n')
    writeMemory(n,n_ADD)
    writeMemory(m,m_ADD)
    writeMemory(h,h_ADD)
    writeMatrix('A',A,A_ADD)
    writeMatrix('X',X,X_ADD)
    writeMatrix('B',B,B_ADD)
    writeMatrix('U',U,U_ADD)

    out.write('force INT 1\n')
    out.write('run 200 ps\n')
    out.write('force PROCESS 1\n')
    out.write('run 400 ps\n')
    out.write('force Interpolate_DONE 1\n')
    out.write('run 200 ps\n')
    out.write('force Interpolate_DONE 0\n')
    out.write('run ' +str(m*n*100-50)+ ' ps\n')
    out.write('run 100 ps\n')
    out.write('run ' +str(n*n*100)+ ' ps\n')
    
    for i in range(0,n):
        out.write('run 300 ps\n')
        writeIF(Ans[i,0],tc,i)


    out.write('puts "Test '+str(tc)+' Passed!"\n')
    out.write('run 250 ps\n')
    out.write('force INT 0\n')
    out.write('force PROCESS 0\n')
    out.write('run 100 ps\n')


out.write('puts "All tests Passed Successfully!"\n')
out.close()




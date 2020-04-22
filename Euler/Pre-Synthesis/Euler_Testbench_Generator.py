import numpy as np
import sys

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

for tc in range(0,testcase):
    out.write('\n\n################################################## Testcase: ' + str(tc) +' ##################################################\n')
    n=np.random.randint(1,51)
    m=np.random.randint(1,51)
    h=np.random.randint(1,11)
    writeMemory(n,n_ADD)
    writeMemory(m,m_ADD)
    writeMemory(h,h_ADD)
    A = np.random.randint(1,6,(n,n));   writeMatrix('A',A,A_ADD)
    X = np.random.randint(1,6,(n,1));   writeMatrix('X',X,X_ADD)
    B = np.random.randint(1,6,(n,m));   writeMatrix('B',B,B_ADD)
    U = np.random.randint(1,6,(m,1));   writeMatrix('U',U,U_ADD)

    R1=np.dot(B,U)
    R2=np.dot(A,X)
    Ans=(R1+R2)*h+X
    # print(n,m,h)
    # print("A")
    # print(A)
    # print("X")
    # print(X)
    # print("B")
    # print(B)
    # print("U")
    # print(U)
    # print("R1")
    # print(R1)
    # print("R2")
    # print(R2)
    # print("Ans")
    # print(Ans)
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
    
    out.write('run 250 ps\n')
    out.write('force INT 0\n')
    out.write('force PROCESS 0\n')
    out.write('run 100 ps\n')
    

out.write('puts "All tests Passed Successfully!"\n')
out.close()




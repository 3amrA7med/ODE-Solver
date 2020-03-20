import sys
import numpy as np

#Function print output in binary and fixed point representation
def printOutput(output):
    print(bin(output).split('b')[1])

    if output >> 15:
        output = (np.uint16((output << 1) >> 4))
        #print(bin(output))
        output = ~output
        output = output & 0x0FFF
        #print(bin(output))
        output = np.uint16(output + 1)
        #print(bin(output))
        print((output * -1) / pow(2, SF_out))
    else:
        print((output >> 3) / pow(2, SF_out))

#===========================================================================================

arg1 = sys.argv[1]              #input arguments
arg2 = sys.argv[2]

input_1 = np.uint16(int(arg1, base=2))
input_2 = np.uint16(int(arg2, base=2))
output = np.uint16(0)

num_1 = np.uint32((input_1 >> 3) << 3)
num_2 = np.uint32((input_2 >> 3) << 3)

SF_1 = input_1 & 0x0007         #scale factor of input 1
SF_2 = input_2 & 0x0007         #scale factor of input 2
SF_out = 0
SF_diff = 0

if SF_1 == SF_2:
    SF_out = SF_1
    output = np.uint16(num_1 + num_2)
    output = output | SF_out

else:
    if SF_1 > SF_2:
        SF_out = SF_1
        SF_diff = SF_1 - SF_2
        if num_1 >> 15:
            num_1 = num_1 | 0xFFFF0000          #sign extend
        if num_2 >> 15:
            num_2 = num_2 | 0xFFFF0000          #sign extend
        num_2 = np.uint32(num_2 << SF_diff)
        output = np.uint16(num_1 + num_2)
        output = output | SF_out

    else:
        SF_out = SF_2
        SF_diff = SF_2 - SF_1
        if num_1 >> 15:
            num_1 = num_1 | 0xFFFF0000          #sign extend
        if num_2 >> 15:
            num_2 = num_2 | 0xFFFF0000          #sign extend
        num_1 = np.uint32(num_1 << SF_diff)
        output = np.uint16(num_1 + num_2)
        output = output | SF_out


printOutput(output)
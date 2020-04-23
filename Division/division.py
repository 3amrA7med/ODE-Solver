import numpy as np
import sys
# Function multiplier that simulates module multiplier hardware
def division(reset, dividend, divisor):
    divideByZero = 0
    ready = 0
    overFlow = 0
    input_1 = np.uint16(int(dividend, base=2))
    input_2 = np.uint16(int(divisor, base=2))
    # print(bin(input_1))
    # print(bin(input_2))
    # Extract scale factor and obtain numbers
    sf_1 = (input_1 & 0xE000) >> 13  # Scale factor of first operand
    # print("scale factor of the dividend"+str(bin(sf_1)))
    num_1 = np.uint16(input_1 & 0x1FFF)  # Number of first operand
    # print("Dividend => "+str(bin(num_1)))
    if (input_1 >> 12) & 0x0001:
        num_1 = num_1 | 0xE000   # sign extend
        # print("dividend has extended witn the sign"+str(bin(num_1)))
    else :
        num_1 = num_1 | 0x0000   # sign extend
        # print("dividend has extended witn the sign"+str(bin(num_1)))
    sf_2 = (input_2 & 0xE000) >> 13  # Scale factor of second operand
    # print("scale factor of the divisor"+str(bin(sf_2)))
    num_2 = np.uint16(input_2 & 0x1FFF)  # Number of second operand
    # print("Divisor => "+str(bin(num_2)))
    if (input_2 >> 12) & 0x0001:
        num_2 = num_2 | 0xE000  # sign extend
        # print("divisor has extended witn the sign"+str(bin(num_2)))
    else :
        num_2 = num_2 | 0x0000  # sign extend
        # print("divisor has extended witn the sign"+str(bin(num_2)))      
    sign = np.logical_xor( (input_2 >> 12) , (input_1 >> 12) )
    # print ("sign of the result will be = "+str(sign))

    # getting the 2's complement of the negative number to work on a positive ones
    if (input_1 >> 12) & 0x0001:
            num_1 = (0xFFFF ^ num_1)+0x0001 
            # print ("dividend after 2's complement will be => "+str(bin(num_1)))
    if (input_2 >> 12) & 0x0001:
            num_2 = (0xFFFF ^ num_2)+0x0001 
            # print ("divisor after 2's complement will be => "+str(bin(num_2)))

    if (sf_1 > sf_2):
        number = (sf_1) - (sf_2)        
        if (number > 0):    
            num_2 = num_2 << number
            num_1 = num_1 << 3
            output_scale_factor = 3
        else:	
            num_1 = num_1 << 3
            output_scale_factor = 3 
    else :
        number = sf_2 - sf_1
        if (number > 0):
            num_1 = num_1 << number
            num_1 = num_1 << 3
            output_scale_factor = 3
        else:
            num_1 = num_1 << 3
            output_scale_factor = 3
    if num_2 == 0:
        ready = 1
        divideByZero = 1
        res = 0
        print (" you want to divide by zero ")
        return overFlow,res,divideByZero,ready

    # print ("final value for the dividend to work => "+str(bin(num_1)))
    # print ("final value for the divisor to work => "+str(bin(num_2)))
    
    res = int (num_1 / num_2)
    # print ("output of the division operation = "+str(bin(res)))
    if (res >> 12) & 0x0001 or (res >> 13) & 0x0001 or (res >> 14) & 0x0001 or (res >> 15) & 0x0001:
        overFlow = 1
    if sign == True:
        res = (0xFFFF ^ res)+0x0001 
    res = res | 0x6000
    # print ("final result = "+str(bin(res)))
    ready = 1
    return overFlow,res,divideByZero,ready

division(1,"0000000000000111","0000000000000000")
import numpy as np


def binary_representer(number, scale_factor):
    whole, dec = str(number).split(".")
    whole = int(whole)
    dec = int(dec)
    res = bin(whole).lstrip("0b") + "."
    for x in range(scale_factor):
        if (str((decimal_converter(dec)) * 2) == "0"):
            whole, dec = "0.0".split(".")
        else:
            whole, dec = str((decimal_converter(dec)) * 2).split(".")
        dec = int(dec)
        res += whole

    return res


def decimal_converter(num):
    while num > 1:
        num /= 10
    return num


# function that converts decimal to binary
def dec2bin(number, accuracy):
    if (int(accuracy) > 7 or int(accuracy) < 0):
        print("accuracy must be within 0 and 7")
        return
    negative = False
    if (number.find("-") != -1):
        negative = True
        number = number.lstrip("-")

    output_number = binary_representer(number, scale_factor=int(accuracy))

    integerVal, floatVal = output_number.split(".")
    binary_rep = integerVal + floatVal
    if (negative):
        negative_number = np.uint32(int(binary_rep, base=2))
        negative_number = ~negative_number + 1
        binary_rep = bin(negative_number)[2:]
        first_zero = binary_rep.find("0")
        if (first_zero != -1 and first_zero != 0):
            binary_rep = binary_rep[first_zero - 1:]

    if (len(binary_rep) > 13):
        print("this input with this accuracy can't be represented because it exceeds 13 bits")
        return
    elif (len(binary_rep) == 13 and not negative):
        print("this input with this accuracy can't be represented because it exceeds 13 bits")
        return
    if (negative):
        binary_rep = binary_rep.rjust(13, "1")
    else:
        binary_rep = binary_rep.zfill(13)
    scale_factor = bin(int(accuracy))[2:].zfill(3)
    return scale_factor + binary_rep


def bin2dec(output):
    output = np.uint16(int(output, base=2))
    sf_out = output >> 13
    num = np.uint16(output & 0x1FFF)

    if num >> 12:
        num = (np.uint16((num << 4) >> 4))
        num = ~num
        num = num & 0x0FFF
        num = np.uint16(num + 1)
        return (num * -1) / pow(2, sf_out)
    else:
        return num / pow(2, sf_out)


import numpy as np
import sys


# Function division that simulates module division hardware
# Function division that simulates module division hardware
def division(reset, dividend, divisor):
    # indicate division by zero
    divideByZero = 0
    # indicate that the operation is finished
    ready = 0
    # indicate overflow
    overFlow = 0
    input_1 = np.uint16(int(dividend, base=2))
    input_2 = np.uint16(int(divisor, base=2))
    #     print(bin(input_1))
    #     print(bin(input_2))
    # Extract scale factor and obtain numbers
    sf_1 = (input_1 & 0xE000) >> 13  # Scale factor of first operand
    #     print("scale factor of the dividend"+str(bin(sf_1)))
    num_1 = np.uint16(input_1 & 0x1FFF)  # Number of first operand
    #     print("Dividend => "+str(bin(num_1)))
    if (input_1 >> 12) & 0x0001:
        num_1 = num_1 | 0xE000  # sign extend
    #         print("dividend has extended witn the sign"+str(bin(num_1)))
    else:
        num_1 = num_1 | 0x0000  # sign extend
    #         print("dividend has extended witn the sign"+str(bin(num_1)))
    sf_2 = (input_2 & 0xE000) >> 13  # Scale factor of second operand
    #     print("scale factor of the divisor"+str(bin(sf_2)))
    num_2 = np.uint16(input_2 & 0x1FFF)  # Number of second operand
    #     print("Divisor => "+str(bin(num_2)))
    if (input_2 >> 12) & 0x0001:
        num_2 = num_2 | 0xE000  # sign extend
    #         print("divisor has extended witn the sign"+str(bin(num_2)))
    else:
        num_2 = num_2 | 0x0000  # sign extend
    #         print("divisor has extended witn the sign"+str(bin(num_2)))
    sign = (input_2 >> 12) ^ (input_1 >> 12)
    #     print ("sign of the result will be = "+str(sign))

    # getting the 2's complement of the negative number to work on a positive ones
    if (input_1 >> 12) & 0x0001:
        num_1 = (0xFFFF ^ num_1) + 0x0001
    #             print ("dividend after 2's complement will be => "+str(bin(num_1)))
    if (input_2 >> 12) & 0x0001:
        num_2 = (0xFFFF ^ num_2) + 0x0001
    #             print ("divisor after 2's complement will be => "+str(bin(num_2)))

    if (sf_1 > sf_2):
        number = (sf_1) - (sf_2)
        if (number > 0):
            num_2 = num_2 << number
            num_1 = num_1 << 3
            output_scale_factor = 3
        else:
            num_1 = num_1 << 3
            output_scale_factor = 3
    else:
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
        #         print (" you want to divide by zero ")
        return overFlow, res, divideByZero, ready

    #     print ("final value for the dividend to work => "+str(bin(num_1)))
    #     print ("final value for the divisor to work => "+str(bin(num_2)))

    res = int(num_1 / num_2)
    #     print ("output of the division operation = "+str(bin(res)))
    if (res >> 12) & 0x0001 or (res >> 13) & 0x0001 or (res >> 14) & 0x0001 or (res >> 15) & 0x0001:
        overFlow = 1
    if sign == True:
        res = ~(np.uint16(res))
        res = np.uint16(res) + 0x0001
    #     print ("final result = "+str(bin(np.uint16(res))))
    res = np.uint16(res) << 3
    res = np.uint16(res) >> 3
    res = np.uint16(res) | 0x6000
    #     print ("final result = "+str(bin(np.uint16(res))))
    ready = 1
    return overFlow, np.uint16(res), divideByZero


def multiplier(first_operand, second_operand):
    input_1 = np.int16(int(first_operand, base=2))
    input_2 = np.int16(int(second_operand, base=2))

    # Extract scale factor and obtain numbers
    sf_1 = (input_1 & 0xE000) >> 13  # Scale factor of first operand
    num_1 = np.uint16(input_1 & 0x1FFF)  # Number of first operand
    if (input_1 >> 12) & 0x0001:
        num_1 = num_1 | 0xFFFFE000   # sign extend
        # print(bin(num_1))
    sf_2 = (input_2 & 0xE000) >> 13  # Scale factor of second operand
    num_2 = np.uint16(input_2 & 0x1FFF)  # Number of second operand
    if (input_2 >> 12) & 0x0001:
        num_2 = num_2 | 0xFFFFE000  # sign extend

    # Calculate sum of scale factors and multiply the 2 numbers
    max_scale_factor = 0
    shift_factor = 0  # Calculate how much the num needed to be shifted right

    if sf_1 > sf_2:   #Take maximum scale factor as output scale factor
        max_scale_factor = sf_1
        shift_factor = sf_2
    else:
        max_scale_factor = sf_2
        shift_factor = sf_1
    output_number = np.uint32(np.uint32(num_1) * np.uint32(num_2))
    output_number = np.uint32(output_number >> shift_factor)  # Shift the number right
    output_scale_factor = max_scale_factor
    overflow = None #Check for overflow
    if ((output_number & 0xFFFFE000) == 0xFFFFE000) or ((output_number & 0xFFFFE000) == 0x00000000):
        overflow = False
    else:
        overflow = True
    output_number = np.uint16(output_number)
    output = np.uint16((output_number & 0x1FFF) | output_scale_factor << 13)  # Shift number left 3 bits then OR with scale factor
    return output, overflow

def adder(first_operand, second_operand, sub, cin):
    input_1 = np.uint16(int(first_operand, base=2))
    input_2 = np.uint16(int(second_operand, base=2))
    sub = int(sub)
    cin = int(cin)

    output = np.uint16(0)
    invalid = 0
    valid = 0
    cout = 0
    tempOut = 0

    #convert to 32bit for sign extend
    num_1 = np.uint32(input_1 & 0x1FFF)
    num_2 = np.uint32(input_2 & 0x1FFF)

    SF_1 = (input_1 >> 13)  # scale factor of input 1
    SF_2 = (input_2 >> 13)  # scale factor of input 2
    SF_out = 0              # initialize output scale factor
    SF_diff = 0             # initialize scale factor difference

    if num_1 >> 12:
        num_1 = num_1 | 0xFFFFE000  # sign extend
    if num_2 >> 12:
        num_2 = num_2 | 0xFFFFE000  # sign extend

    # if scale factor of inputs match then output scale factor match and add directly without shift
    if SF_1 == SF_2:
        SF_out = SF_1
        # if subtract get 2's complement of the second operand
        if sub == 1:
            num_2 = (~num_2)
            cin = 1  # force cin to be 1 to get 2's complement
        tempOut = num_1 + num_2 + cin
    else:
        if SF_1 > SF_2:
            SF_out = SF_1
            SF_diff = SF_1 - SF_2
            num_2 = num_2 << SF_diff
            # if subtract get 2's complement of the second operand
            if sub == 1:
                num_2 = (~num_2)
                cin = 1  # force cin to be 1 to get 2's complement
            tempOut = num_1 + num_2 + cin

        else:
            SF_out = SF_2
            SF_diff = SF_2 - SF_1
            num_1 = num_1 << SF_diff
            # if subtract get 2's complement of the second operand
            if sub == 1:
                num_2 = (~num_2)
                cin = 1  # force cin to be 1 to get 2's complement
            tempOut = num_1 + num_2 + cin

    # carry out
    if (tempOut >> 32) == 1:
        cout = 1

    # overflow
    # if 2 inputs are negative and output is positive
    if(num_1 >> 31) and (num_2 >> 31) and (not(tempOut & 0x080000000)):
        invalid = 1
    # if 2 inputs are positive and output is negative
    if(not(num_1 >> 31)) and (not(num_2 >> 31)) and (tempOut & 0x080000000):
        invalid = 1

    # invalid output
    tempOut = np.uint32(tempOut)        # get output without carry
    # output number can be represented in 13 bits which are dedicated to it in our fixed point representation
    # the left most bits represent sign only, weather all are ones or all are zeros
    if ((tempOut & 0xFFFFF000) == 0xFFFFF000) or ((tempOut & 0xFFFFF000) == 0):
        valid = 1

    # invalid of overflow occurs in addition or output can't be represented in 13 bits
    invalid = invalid or (not valid)

    # take the least 13 bits to be our output
    output = np.uint16(tempOut & 0x00001FFF)
    # scale factor of output
    output = np.uint16(output | (SF_out << 13))

    return output,  invalid


def binaryToDecimal(binary):
    binary1 = binary
    decimal, i, n = 0, 0, 0
    while (binary != 0):
        dec = binary % 10
        decimal = decimal + dec * pow(2, i)
        binary = binary // 10
        i += 1
    return decimal


def create_testBench(X0, X1, N, Hnew, L, Hinit, error):
    File = open('StepTestBench.do', 'w')
    print('# Testbench for Step module \n', file=File)
    print('vsim work.Coordinator_Module \n', file=File)
    print('radix -unsigned \n', file=File)
    print('add wave * \n', file=File)
    print('set n %s \n' % (str(N)), file=File)
    print('set m %s \n' % (str(N + 1)), file=File)
    print('set mode %s \n' % (str(1)), file=File)
    print('set l %s \n' % (str(int(L))), file=File)
    print('set h_temp %s \n' % (str(binaryToDecimal(int(Hinit)))), file=File)
    print('set h_init %s \n' % (str(binaryToDecimal(int(Hinit)))), file=File)
    print('set x_process %s \n' % (str(6)), file=File)
    print('set x_init %s \n' % (str(56)), file=File)
    print('set x_n+1_0 %s \n' % (str(106)), file=File)
    print('set cur 0 \n', file=File)
    print(' \n\n\n', file=File)
    print('# Answers\n', file=File)
    print('set Error %s \n' % (str(binaryToDecimal(int(error)))), file=File)
    print('set hnew %s \n' % (str(binaryToDecimal(int(Hnew)))), file=File)
    print(' \n\n\n', file=File)
    print('force -freeze sim:/Coordinator_Module/Euler_End 0 0 \n', file=File)
    print('force -freeze sim:/Coordinator_Module/CLK 1 0, 0 {50 ps} -r 100 \n', file=File)
    print('force -freeze sim:/Coordinator_Module/RST 1 0 \n', file=File)
    print('run 250 ps \n', file=File)
    print('force -freeze sim:/Coordinator_Module/RST St0 0 \n', file=File)
    print(' \n\n\n', file=File)

    print('mem load -filltype value -filldata $n -fillradix unsigned /Coordinator_Module/Memory/Memory(0) \n',
          file=File)
    print('mem load -filltype value -filldata $m -fillradix unsigned /Coordinator_Module/Memory/Memory(1) \n',
          file=File)
    print('mem load -filltype value -filldata $mode -fillradix unsigned /Coordinator_Module/Memory/Memory(2) \n',
          file=File)
    print('mem load -filltype value -filldata $l -fillradix unsigned /Coordinator_Module/Memory/Memory(3) \n',
          file=File)
    print('mem load -filltype value -filldata $h_temp -fillradix unsigned /Coordinator_Module/Memory/Memory(4) \n',
          file=File)
    print('mem load -filltype value -filldata $h_init -fillradix unsigned /Coordinator_Module/Memory/Memory(5) \n',
          file=File)

    for i in range(N):
        print(
            'mem load -filltype value -filldata { %s } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_process]) \n'
            % (str(binaryToDecimal(int(X0[i])))), file=File)
        print(
            'mem load -filltype value -filldata { %s } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_init]) \n'
            % (str(binaryToDecimal(int(X1[i])))), file=File)
        print('incr cur; \n', file=File)

    print('run 200 ps \n', file=File)
    print('force -freeze sim:/Coordinator_Module/Step/Euler_End 1 0 \n', file=File)
    print('run 100 ps \n', file=File)
    print('force -freeze sim:/Coordinator_Module/Step/Euler_End 0 0 \n', file=File)
    print('run 200 ps \n', file=File)
    print('for {set i 0} {$i < [expr $n]} {incr i} { \n', file=File)
    print('run 500 ps } \n', file=File)
    print('run 2 ns \n', file=File)
    print('run 200 ps \n', file=File)
    print('force -freeze sim:/Coordinator_Module/Step/Euler_End 1 0 \n', file=File)
    print('run 100 ps \n', file=File)
    print('force -freeze sim:/Coordinator_Module/Step/Euler_End 0 0 \n', file=File)
    print('run 200 ps \n', file=File)
    print('force -freeze sim:/Coordinator_Module/Step/Euler_End 1 0 \n', file=File)
    print('run 100 ps \n', file=File)
    print('force -freeze sim:/Coordinator_Module/Step/Euler_End 0 0 \n', file=File)
    print('run 200 ps \n', file=File)
    print('for {set i 0} {$i < [expr $n]} {incr i} { \n', file=File)
    print('run 500 ps } \n', file=File)
    print('run 100 ps \n', file=File)
    print('run 3 ns \n', file=File)
    print('set val [examine /Coordinator_Module/Error_Flag ] \n', file=File)
    print('if {$val == 1} { \n', file=File)
    print('error "Test0: Error in Chip Error_Flag = 1 } \n', file=File)
    print('set val [examine /Coordinator_Module/Memory/Memory(4) ] \n', file=File)
    print('if {$val != $hnew} { \n', file=File)
    print('error "Test1: Failed, h_temp != $hnew } \n', file=File)
    print('set val [examine /Coordinator_Module/Memory/Memory(5) ] \n', file=File)
    print('if {$val != $hnew} { \n', file=File)
    print('error "Test2: Failed, h_init != $hnew } \n', file=File)
    print('puts "All tests Passed Successfully!"; \n', file=File)

    File.close()






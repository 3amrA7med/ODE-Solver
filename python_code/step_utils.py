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
def division(reset, dividend, divisor):
    # indicate division by zero
    divideByZero = 0
    # indicate that the operation is finished
    ready = 0
    # indicate overflow
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
        num_1 = num_1 | 0xE000  # sign extend
        # print("dividend has extended witn the sign"+str(bin(num_1)))
    else:
        num_1 = num_1 | 0x0000  # sign extend
        # print("dividend has extended witn the sign"+str(bin(num_1)))
    sf_2 = (input_2 & 0xE000) >> 13  # Scale factor of second operand
    # print("scale factor of the divisor"+str(bin(sf_2)))
    num_2 = np.uint16(input_2 & 0x1FFF)  # Number of second operand
    # print("Divisor => "+str(bin(num_2)))
    if (input_2 >> 12) & 0x0001:
        num_2 = num_2 | 0xE000  # sign extend
        # print("divisor has extended witn the sign"+str(bin(num_2)))
    else:
        num_2 = num_2 | 0x0000  # sign extend
        # print("divisor has extended witn the sign"+str(bin(num_2)))
    sign = np.logical_xor((input_2 >> 12), (input_1 >> 12))
    # print ("sign of the result will be = "+str(sign))

    # getting the 2's complement of the negative number to work on a positive ones
    if (input_1 >> 12) & 0x0001:
        num_1 = (0xFFFF ^ num_1) + 0x0001
        # print ("dividend after 2's complement will be => "+str(bin(num_1)))
    if (input_2 >> 12) & 0x0001:
        num_2 = (0xFFFF ^ num_2) + 0x0001
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
        print(" you want to divide by zero ")
        return overFlow, res, divideByZero, ready

    # print ("final value for the dividend to work => "+str(bin(num_1)))
    # print ("final value for the divisor to work => "+str(bin(num_2)))

    res = int(num_1 / num_2)
    # print ("output of the division operation = "+str(bin(res)))
    if (res >> 12) & 0x0001 or (res >> 13) & 0x0001 or (res >> 14) & 0x0001 or (res >> 15) & 0x0001:
        overFlow = 1
    if sign == True:
        res = (0xFFFF ^ res) + 0x0001
    res = res | 0x6000
    # print ("final result = "+str(bin(res)))
    ready = 1
    return res

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
    return output

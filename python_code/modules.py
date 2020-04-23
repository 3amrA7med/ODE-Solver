<<<<<<< HEAD
import numpy as np

def binary_representer(number, scale_factor):
    whole, dec = str(number).split(".") 
    whole = int(whole) 
    dec = int (dec) 
    res = bin(whole).lstrip("0b") + "."
    for x in range(scale_factor): 
        if(str((decimal_converter(dec)) * 2) == "0"):
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
#function that converts decimal to binary  
def dec2bin(number,accuracy):
    if(int(accuracy) > 7 or int(accuracy) < 0):
        print("accuracy must be within 0 and 7")
        return
    negative = False
    if(number.find("-") != -1):
        negative = True
        number = number.lstrip("-")
    
    output_number = binary_representer(number, scale_factor = int(accuracy))
    if(negative):
        print("number is :", "-" + output_number) 
    else:
        print("number is :", output_number) 

    integerVal, floatVal = output_number.split(".")
    binary_rep = integerVal+floatVal
    if(negative):
        negative_number = np.uint32(int(binary_rep, base=2))
        negative_number = ~negative_number + 1
        binary_rep = bin(negative_number)[2:]
        first_zero = binary_rep.find("0")
        if (first_zero != -1 and first_zero != 0):
            binary_rep = binary_rep[first_zero-1:]
    print(binary_rep)

    if(len(binary_rep) > 13):
        print("this input with this accuracy can't be represented because it exceeds 13 bits")
        return
    elif (len(binary_rep) == 13 and not negative):
        print("this input with this accuracy can't be represented because it exceeds 13 bits")
        return
    if(negative):
        binary_rep = binary_rep.rjust(13,"1")
    else:
        binary_rep = binary_rep.zfill(13)
    scale_factor = bin(int(accuracy))[2:].zfill(3)
    print("input representation is :", scale_factor+binary_rep)


# Function multiplier that simulates module multiplier hardware
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
    return output,overflow


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

    # if subtract get 2's complement of the second operand
    if sub == 1:
        num_2 = (~num_2)        # 1's complement
        cin = 1                 # force cin to be 1 to get 2's complement

    # if scale factor of inputs match then output scale factor match and add directly without shift
    if SF_1 == SF_2:
        SF_out = SF_1
        tempOut = num_1 + num_2 + cin
    else:
        if SF_1 > SF_2:
            SF_out = SF_1
            SF_diff = SF_1 - SF_2
            num_2 = num_2 << SF_diff
            tempOut = num_1 + num_2 + cin

        else:
            SF_out = SF_2
            SF_diff = SF_2 - SF_1
            num_1 = num_1 << SF_diff
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

    return output, cout, invalid
=======
import numpy as np

def binary_representer(number, scale_factor):
    whole, dec = str(number).split(".") 
    whole = int(whole) 
    dec = int (dec) 
    res = bin(whole).lstrip("0b") + "."
    for x in range(scale_factor): 
        if(str((decimal_converter(dec)) * 2) == "0"):
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
#function that converts decimal to binary  
def dec2bin(number,accuracy):
    if(int(accuracy) > 7 or int(accuracy) < 0):
        print("accuracy must be within 0 and 7")
        return
    negative = False
    if(number.find("-") != -1):
        negative = True
        number = number.lstrip("-")
    
    output_number = binary_representer(number, scale_factor = int(accuracy))
    if(negative):
        print("number is :", "-" + output_number) 
    else:
        print("number is :", output_number) 

    integerVal, floatVal = output_number.split(".")
    binary_rep = integerVal+floatVal
    if(negative):
        negative_number = np.uint32(int(binary_rep, base=2))
        negative_number = ~negative_number + 1
        binary_rep = bin(negative_number)[2:]
        first_zero = binary_rep.find("0")
        if (first_zero != -1 and first_zero != 0):
            binary_rep = binary_rep[first_zero-1:]
    print(binary_rep)

    if(len(binary_rep) > 13):
        print("this input with this accuracy can't be represented because it exceeds 13 bits")
        return
    elif (len(binary_rep) == 13 and not negative):
        print("this input with this accuracy can't be represented because it exceeds 13 bits")
        return
    if(negative):
        binary_rep = binary_rep.rjust(13,"1")
    else:
        binary_rep = binary_rep.zfill(13)
    scale_factor = bin(int(accuracy))[2:].zfill(3)
    print("input representation is :", scale_factor+binary_rep)

# Function multiplier that simulates module multiplier hardware
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
    return output,overflow


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

    # if subtract get 2's complement of the second operand
    if sub == 1:
        num_2 = (~num_2)        # 1's complement
        cin = 1                 # force cin to be 1 to get 2's complement

    # if scale factor of inputs match then output scale factor match and add directly without shift
    if SF_1 == SF_2:
        SF_out = SF_1
        tempOut = num_1 + num_2 + cin
    else:
        if SF_1 > SF_2:
            SF_out = SF_1
            SF_diff = SF_1 - SF_2
            num_2 = num_2 << SF_diff
            tempOut = num_1 + num_2 + cin

        else:
            SF_out = SF_2
            SF_diff = SF_2 - SF_1
            num_1 = num_1 << SF_diff
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

    return output, cout, invalid
>>>>>>> 4212a712eb92419ee534cf3a6dd9115f34ed8414

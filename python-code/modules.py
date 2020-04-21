import numpy as np


# Function multiplier that simulates module multiplier hardware
def multiplier(first_operand, second_operand):
    input_1 = np.uint16(int(first_operand, base=2))
    input_2 = np.uint16(int(second_operand, base=2))

    # Extract scale factor and obtain numbers
    sf_1 = (input_1 & 0xE000) >> 13  # Scale factor of first operand
    num_1 = np.uint16(input_1 & 0x1FFF)  # Number of first operand
    if (input_1 >> 12) & 0x0001:
        num_1 = num_1 | 0xFFFFE000   # sign extend
        print(bin(num_1))
    sf_2 = (input_2 & 0xE000) >> 13  # Scale factor of second operand
    num_2 = np.uint16(input_2 & 0x1FFF)  # Number of second operand
    if (input_2 >> 12) & 0x0001:
        num_2 = num_2 | 0xFFFFE000  # sign extend

    # Calculate sum of scale factors and multiply the 2 numbers
    sum_scale_factor = sf_1 + sf_2
    output_number = np.uint32(num_1 * num_2)

    if sum_scale_factor > 7:
        output_scale_factor = np.uint16(7)  # Assign output scale factor to 7 (Max possible scale factor)
        shift_factor = sum_scale_factor - output_scale_factor  # Calculate how much the num needed to be shifted right
        output_number = np.uint16(output_number >> shift_factor)  # Shift the number right
    else:
        output_scale_factor = sum_scale_factor  # Else do nothing

    output = np.uint16((output_number & 0x1FFF) | output_scale_factor << 13)  # Shift number left 3 bits then OR with scale factor
    return output


def adder(first_operand, second_operand):
    input_1 = np.uint16(int(first_operand, base=2))
    input_2 = np.uint16(int(second_operand, base=2))
    output = np.uint16(0)
    invalid = 0
    valid = 0
    cout = 0
    tempOut = 0
    cin = 0
    sub = 0

    num_1 = np.uint32(input_1 & 0x1FFF)
    num_2 = np.uint32(input_2 & 0x1FFF)

    SF_1 = (input_1 >> 13)  # scale factor of input 1
    SF_2 = (input_2 >> 13)  # scale factor of input 2
    SF_out = 0
    SF_diff = 0

    if num_1 >> 12:
        num_1 = num_1 | 0xFFFFE000  # sign extend
    if num_2 >> 12:
        num_2 = num_2 | 0xFFFFE000  # sign extend
    if sub:
        num_2 = (~num_2)
        cin = 1

    if SF_1 == SF_2:
        SF_out = SF_1
        tempOut = num_1 + num_2 + cin
    else:
        if SF_1 > SF_2:
            SF_out = SF_1
            SF_diff = SF_1 - SF_2
            tempOut = num_1 + num_2 + cin

        else:
            SF_out = SF_2
            SF_diff = SF_2 - SF_1
            tempOut = num_1 + num_2 + cin

    #carry out
    if (tempOut >> 32) == 1:
        cout = 1

    #overflow
    if(num_1 >> 31) and (num_2 >> 31) and (not(tempOut & 0x080000000)):
        invalid = 1
    if(not(num_1 >> 31)) and (not(num_2 >> 31)) and (tempOut & 0x080000000):
        invalid = 1
    #invalid output
    tempOut = np.uint32(tempOut)
    if ((tempOut & 0xFFFFF000) == 0xFFFFF000) or ((tempOut & 0xFFFFF000) == 0):
        valid = 1

    invalid = invalid or (not valid)

    output = np.uint16(tempOut & 0x00001FFF)
    output = output | (SF_out << 13)

    return output

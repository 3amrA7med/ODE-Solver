import numpy as np


# Function multiplier that simulates module multiplier hardware
def multiplier(first_operand, second_operand):
    input_1 = np.uint16(int(first_operand, base=2))
    input_2 = np.uint16(int(second_operand, base=2))

    # Extract scale factor and obtain numbers
    sf_1 = input_1 & 0x0007  # Scale factor of first operand
    num_1 = np.uint32(input_1 >> 3)  # Number of first operand

    sf_2 = input_2 & 0x0007  # Scale factor of second operand
    num_2 = np.uint32(input_2 >> 3)  # Number of second operand
    # Calculate sum of scale factors and multiply the 2 numbers
    sum_scale_factor = sf_1 + sf_2
    output_number = np.uint32(num_1 * num_2)

    if sum_scale_factor > 7:
        output_scale_factor = np.uint16(7)  # Assign output scale factor to 7 (Max possible scale factor)
        shift_factor = sum_scale_factor - output_scale_factor  # Calculate how much the num needed to be shifted right
        output_number = np.uint16(output_number >> shift_factor)  # Shift the number right
    else:
        output_scale_factor = sum_scale_factor  # Else do nothing

    output = np.uint16((output_number << 3) | output_scale_factor)  # Shift number left 3 bits then OR with scale factor
    return output


def adder(first_operand, second_operand):
    input_1 = np.uint16(int(first_operand, base=2))
    input_2 = np.uint16(int(second_operand, base=2))
    output = np.uint16(0)

    num_1 = np.uint32((input_1 >> 3) << 3)
    num_2 = np.uint32((input_2 >> 3) << 3)

    SF_1 = input_1 & 0x0007  # scale factor of input 1
    SF_2 = input_2 & 0x0007  # scale factor of input 2
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
                num_1 = num_1 | 0xFFFF0000  # sign extend
            if num_2 >> 15:
                num_2 = num_2 | 0xFFFF0000  # sign extend
            num_2 = np.uint32(num_2 << SF_diff)
            output = np.uint16(num_1 + num_2)
            output = output | SF_out

        else:
            SF_out = SF_2
            SF_diff = SF_2 - SF_1
            if num_1 >> 15:
                num_1 = num_1 | 0xFFFF0000  # sign extend
            if num_2 >> 15:
                num_2 = num_2 | 0xFFFF0000  # sign extend
            num_1 = np.uint32(num_1 << SF_diff)
            output = np.uint16(num_1 + num_2)
            output = output | SF_out
    return output

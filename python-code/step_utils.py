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
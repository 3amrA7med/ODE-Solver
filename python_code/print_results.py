def print_results():
    """
    This function convert binary.txt file to readable Results.txt file
    :return: None
    """
    # Define 2 files, one for reading binary numbers and the other for writing the results
    file_reader = open('../python-code/binary.txt', 'r')
    file_writer = open('../results.txt', 'w')
    # Read the first 3 values in the file, they are number of t and x variables and if the data is 64 bit
    is_64bit = int(file_reader.readline(), 2)
    number_of_t = int(file_reader.readline(), 2)
    number_of_x = int(file_reader.readline(), 2)

    # Loop on every t
    for t in range(number_of_t):
        result = file_reader.readline()
        # If the data is 64 bit then the next line is the 32 MSBs so parse them with the result
        if is_64bit == 1:
            result = file_reader.readline()[:-1] + result
        result = int(result, 2)
        file_writer.write("T" + str(t) + ": " + str(result))
        # Loop on every x
        for x in range(number_of_x):
            result = file_reader.readline()
            # If the data is 64 bit then the next line is the 32 MSBs so parse them with the result
            if is_64bit == 1:
                result = file_reader.readline()[:-1] + result
            result = int(result, 2)
            file_writer.write("\tX" + str(x) + ": " + str(result))
        file_writer.write("\n")


# Function call
print_results()

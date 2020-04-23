from rig.type_casts import float_to_fp, fp_to_float
import itertools
import decimal 
import json 
import math


data = {
        "N" : -2.5,
        "M" : 2,
        "Count":2,
        "Mode":1,
        "H": 0,
        "Err": 0,
        "PerMode": 0,
        "A": [[3,8,25],[25,25,25],[25,25,25]],
        "B": [[3,5],[25,25],[25,25]],
        "X0": [45,25,33],
        "T": [64,46],
        "U0": [66 , 89],
        "Us": [[88,88],[99,44]]
        }

with open('JsonData.json', 'w') as outfile:
    json.dump(data, outfile)


with open('./JsonData.json') as Json_File:
  Json_Data = json.load(Json_File)
 
DATA_WIDTH = 16
SCALE_FACTOR_SIZE = 3

# Function to find two's complement 
def findTwoscomplement(value): 
    n = len(value) 
  
    # Traverse the string to get first  
    # '1' from the last of string 
    i = n - 1
    while(i >= 0): 
        if (value[i] == '1'): 
            break
        i -= 1

    # If there exists no '1' concatenate 1  
    # at the starting of string 
    if (i == -1): 
        return '1'+ value
  
    # Continue traversal after the  
    # position of first '1' 
    k = i - 1
    while(k >= 0): 
        # Just flip the values 
        if (value[k] == '1'): 
            value = list(value) 
            value[k] = '0'
            value = ''.join(value) 
        else: 
            value = list(value) 
            value[k] = '1'
            value = ''.join(value) 
        k -= 1
    # return the modified string 
    return value
  

"""
This Function is used to convert Numbers to Binary Fixed Point Representation 
""" 
def fixedPointBinary(value):
    # Calculate the appropriate Scale Factor up to exact Number of Bits [SCALE_FACTOR_SIZE]
    scaleFactor = min(-decimal.Decimal(str(value)).as_tuple().exponent, (2 ** SCALE_FACTOR_SIZE) - 1)
    # Convert the Number to Fixed Point Representation
    s34 = float_to_fp(signed = True, n_bits = 16, n_frac = scaleFactor)
    # The Number will occupe exact Number of Bits depends on DATA_WIDTH after removing 
    # the SCALE_FACTOR_SIZE, 2 is used to consider the added "0b" 
    DATA_WIDTH_STRING = str(DATA_WIDTH - SCALE_FACTOR_SIZE + 2)
    SCALE_FACTOR_SIZE_STRING = str(SCALE_FACTOR_SIZE + 2)
    ZEROS_STRING = "0" * (64 - DATA_WIDTH)
    scaleFactorBinaryString = format(scaleFactor, "#0" + SCALE_FACTOR_SIZE_STRING + "b")[2:]
    if(value < 0):
      valueBinaryString = findTwoscomplement(format(s34(-value), "#0" + DATA_WIDTH_STRING + "b")[2:])
    else:
      valueBinaryString = format(s34(value), "#0" + DATA_WIDTH_STRING + "b")[2:]
    #Final Representation
    finalValue = ZEROS_STRING + scaleFactorBinaryString + valueBinaryString
    return finalValue
   
"""
This Function is used to convert Numbers to Normal Binary Representation 
Value : the Value to be Converted
Size : Number of Bits Required 
""" 
def toBinary(value, size):
    size = "#0" + str(size + 2) + "b"
    return format(value, size)[2:]

# Rows List: To Store the whole Row in one Binary String  
Rows = []
# Elements List: To Store each Element in Its Binary String
# It's used to Compare the Elements before Encoding and after Decoding
Elements = []
## The ELements Before Encoding In Decimal => For Testing  
FinalElementsDecimal = []
# Packets List: To Store the Data Packets after Encoding
Packets = []
# SentPackets List : It's used To Store the 32 bits Packets that will be Sent to the Decoder
# Each Sent Packet is combined of Multiple Packets [depends on the Packet Size]  
SentPackets = []
#------------------------------- First Row ---------------------------------
# Add Its Elements
Elements.append(fixedPointBinary(Json_Data['N']))
Elements.append(fixedPointBinary(Json_Data['M']))
Elements.append(fixedPointBinary(Json_Data['Count']))
Elements.append(fixedPointBinary(Json_Data['Mode']))
Elements.append(fixedPointBinary(Json_Data['H']))
Elements.append(fixedPointBinary(Json_Data['Err']))
Elements.append(fixedPointBinary(Json_Data['PerMode']))
# Add Its Row
Rows.append(fixedPointBinary(Json_Data['N']) + fixedPointBinary(Json_Data['M']) +
               fixedPointBinary(Json_Data['Count']) + fixedPointBinary(Json_Data['Mode']) +
               fixedPointBinary(Json_Data['H']) + fixedPointBinary(Json_Data['Err']) +
               fixedPointBinary(Json_Data['PerMode']))

# A, B
rowNumber = 1
for matrix in Json_Data['A'], Json_Data['B']:
  for row in matrix:
    Rows.append("")
    for element in row:
      Elements.append(fixedPointBinary(element))
      Rows[rowNumber] += fixedPointBinary(element)
    rowNumber += 1

# X0, T, U0
for vector in Json_Data['X0'], Json_Data['T'], Json_Data['U0']:
  Rows.append("")
  for element in vector:
      Elements.append(fixedPointBinary(element))
      Rows[rowNumber] += fixedPointBinary(element)      
  rowNumber += 1

# Us
for U in Json_Data['Us']:
  Rows.append("")
  for element in U:
    Elements.append(fixedPointBinary(element))
    Rows[rowNumber] += fixedPointBinary(element)
  rowNumber += 1

## Calculate the Max Number of Consecutive Zeros or Ones in all Rows [Row by Row]
maxConsecutive = 0
for row in Rows:
  ## Calculate the Max Consecutive Number in This Row
  rowMaxConsecutive = max([(x[0], len(list(x[1]))) for x in itertools.groupby(row)] 
                        , key=lambda x:x[1])[1]
  maxConsecutive = max(maxConsecutive , rowMaxConsecutive)

# Packet Size = Max Consecutive Zeros or Ones + Indication bit
PacketSize = len(bin(maxConsecutive)[2:]) + 1

# Approximate the Packet Size to be Factor of 32
while (32 % PacketSize != 0):
  PacketSize += 1

## The First Two Packets are used to Store Information that's required by the Decoder
# First Packet = Packet Size 
# Second Packet = Number of Rows 
Packets.append(toBinary(PacketSize, 32))
Packets.append(toBinary(len(Rows), 32))

## Start To Generate Packets from Data
for i, row in enumerate(Rows):
  # First bit is used to indicate if first packet represent 0 or 1
  # And Its Inverse is used to indicate the Last Packet in The Row
  firstBit = row[0]
  fristBitInverse = str(1 - int(firstBit)) 

  # Extract All Consecutive Zeros or Ones with Its Size in tuples
  consecutivePairs = [(x[0], len(list(x[1]))) for x in itertools.groupby(row)]
  # Extract their Sizes
  consecutiveSizes = [Pair[1] for Pair in consecutivePairs]
  print("Row #{} Packets: {}".format(i + 1, consecutiveSizes) )

  for i, consecutiveBits in enumerate(consecutiveSizes):
    ## Last Packet in Row has The Inverse Indication Bit
    if(i == len(consecutiveSizes) - 1):
        Packets.append(fristBitInverse + toBinary(consecutiveBits, PacketSize - 1))
    ## Any other Packet in the Row has Indication Bit Itself
    else :
        Packets.append(firstBit + toBinary(consecutiveBits, PacketSize - 1))
        
 
# Combine those Packets to 32 bits By Merging some of them [depends on Packet Size]  
NumberOfSmallPacketsIn32Bits = '{}' * int(32 / PacketSize)
## The First Two Packets Which Represent the Packet Size and Number Of Rows 
# aren't combined with other Packets
SentPackets[0:2] = Packets[0:2]
# Combine The Packets
SentPackets[2:] = [NumberOfSmallPacketsIn32Bits.format(*element) \
                  for element in zip(*[iter(Packets[2:])] * int(32 / PacketSize))]

## The Last 32 bits must be handled as NUmber Of Packets may not be multiple of 32
LastPacket = []
## Loop On the Remaining Packets and combine them together 
for index in range((len(SentPackets) - 2) * int(32 / PacketSize) + 2, len(Packets)):
  LastPacket += Packets[index]

## Add Zeros to the Last Packet tobe Sure It's 32 bits
if(len(LastPacket) != 0 ):
  LastPacket = ''.join(LastPacket) + '0' * (32 - len(LastPacket)) 
  SentPackets.append(LastPacket)

## Write The Packets to the File that will be Opened By TCL Scirpt
# To Send them to The I/O Module 
with open("Packets.txt", "w") as txt_file:
    for line in SentPackets:
        txt_file.write(line + "\n") 

## Write The Elements Before Encoding [In Binary] to the File that will be Opened By TCL Scirpt
# To Compare Them with The Decoded Data 
with open("OriginalElements.txt", "w") as txt_file:
    for element in Elements:
        txt_file.write(element + "\n") 


for element in Elements:
  FinalElementsDecimal.append(int(element,2))


print("Original Inputs: ", FinalElementsDecimal) 

print("Packet Size: " , PacketSize)

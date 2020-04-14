from rig.type_casts import float_to_fp, fp_to_float
import itertools
import decimal 
import json 
import math


data = {
        "N" : 2,
        "M" : 3,
        "Mode":1,
        "H": 2,
        "Err": 3,
        "PerMode": 3,
        "Count":3,
        "A": [[3,8,25],[25,25,25],[25,25,25]],
        "B": [[3,5],[25,25],[25,25]],
        "X0": [45,25],
        "T": [64,46],
        "U0": [66 , 89],
        "Us": [[88,88],[99,44]]
        }

with open('JsonData.json', 'w') as outfile:
    json.dump(data, outfile)


with open('./JsonData.json') as Json_File:
  Json_Data = json.load(Json_File)
 
DATA_WIDTH = 64
SCALE_FACTOR_SIZE = 3

def fixedPointBinary(value):
    scaleFactor = min(-decimal.Decimal(str(value)).as_tuple().exponent, (2 ** SCALE_FACTOR_SIZE) - 1)
    s34 = float_to_fp(signed = True, n_bits = 16, n_frac = scaleFactor)
    DATA_WIDTH_STRING = str(DATA_WIDTH - SCALE_FACTOR_SIZE + 2)
    SCALE_FACTOR_SIZE_STRING = str(SCALE_FACTOR_SIZE + 2)
    return format(s34(value), "#0" + DATA_WIDTH_STRING + "b")[2:] + format(scaleFactor, "#0" + SCALE_FACTOR_SIZE_STRING + "b")[2:]

def toBinary(value, size):
    size = "#0" + str(size + 2) + "b"
    return format(value, size)[2:]

Rows = []
Elements = []
# First Row
Elements.append(fixedPointBinary(Json_Data['N']))
Elements.append(fixedPointBinary(Json_Data['M']))
Elements.append(fixedPointBinary(Json_Data['Mode']))
Elements.append(fixedPointBinary(Json_Data['H']))
Elements.append(fixedPointBinary(Json_Data['PerMode']))
Elements.append(fixedPointBinary(Json_Data['Count']))
Elements.append(fixedPointBinary(Json_Data['Err']))

Rows.append(fixedPointBinary(Json_Data['N']) + fixedPointBinary(Json_Data['M']) +
               fixedPointBinary(Json_Data['Mode']) + fixedPointBinary(Json_Data['H']) +
               fixedPointBinary(Json_Data['PerMode']) + fixedPointBinary(Json_Data['Count']) +
               fixedPointBinary(Json_Data['Err']))

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


maxConsecutive = 0
for row in Rows:
  maxConsecutive = max(maxConsecutive , max([(x[0], len(list(x[1]))) for x in itertools.groupby(row)] 
                        , key=lambda x:x[1])[1])

# Packet Size = Max Consecutive Zeros or Ones + bit used to indicate the last packet
PacketSize = len(bin(maxConsecutive)[2:]) + 1

# Approximate the Packet Size to be multiple of 32
while (32 % PacketSize != 0):
  PacketSize += 1

Packets = []
Packets.append(toBinary(PacketSize, 32))
Packets.append(toBinary(len(Rows), 32))

for row in Rows:
  # First bit is used to indicate if first packet represent 0 or 1
  # And Its Inverse is used to indicate the Last Packet in The Row
  firstBit = row[0]
  fristBitInverse = str(1 - int(firstBit)) 

  # Generate Packet for each consecutive 0's or 1's 
  consecutivePairs = [(x[0], len(list(x[1]))) for x in itertools.groupby(row)]
  consecutiveSizes = [Pair[1] for Pair in consecutivePairs]
  print(consecutiveSizes)
  for i, consecutiveBits in enumerate(consecutiveSizes):
    if(i == len(consecutiveSizes) - 1):
        Packets.append(fristBitInverse + toBinary(consecutiveBits, PacketSize - 1))
    else :
        Packets.append(firstBit + toBinary(consecutiveBits, PacketSize - 1))
        
 
# Make 32 bits Packets
temp = '{}' * int(32 / PacketSize)
SentPackets = []
SentPackets[0:2] = Packets[0:2]
SentPackets[2:] = [temp.format(*element) for element in zip(*[iter(Packets[2:])] * int(32 / PacketSize))]

LastPacket = []
for index in range((len(SentPackets) - 2) * int(32 / PacketSize) + 2, len(Packets)):
  LastPacket += Packets[index]

if(len(LastPacket) != 0 ):
  LastPacket = ''.join(LastPacket) + '0' * (32 - len(LastPacket)) 
  SentPackets.append(LastPacket)

with open("BinaryData.txt", "w") as txt_file:
    for line in SentPackets:
        txt_file.write(line + "\n") 


FinalElementsDecimal = []
for element in Elements:
  FinalElementsDecimal.append(int(element,2))


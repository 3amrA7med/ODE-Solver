import click
from modules import multiplier, adder, dec2bin
import numpy as np


@click.command()
@click.option('-m', '--module', default='multiplier',
              help='Choose module you want to run.', type=click.Choice(['multiplier', 'adder','dec2bin']))
@click.option('-n', '--number',
              help='Write number in decimal floating representation.')
@click.option('-a', '--accuracy',
              help='Write the accuracy a.k.a scale factor.')

@click.option('-sub', '--sub',
              help='Enter 0 for Add or 1 for Subtract.')
@click.option('-c', '--cin',
              help='Enter 0 or 1 for carry in.')

@click.option('-f', '--first_operand',
              help='first operand in fixed point representation')
@click.option('-s', '--second_operand',
              help='second operand in fixed point representation.')
def cli(module, first_operand, second_operand, number, accuracy, sub, cin):
    overflow = None
    if module == "multiplier":
        output, overflow = multiplier(first_operand, second_operand)
        print("overflow is", overflow)
        print_output(output)
    if module == "adder":
        output, cout, overflow = adder(first_operand, second_operand, sub, cin)
        print("Cout is ", cout)
        print("Overflow is ", overflow)
        print_output(output)
    if module == "dec2bin":
            dec2bin(number, accuracy)
   


# Function print output in binary and fixed point representation
def print_output(output):
    print("Output in binary :", bin(output).split('b')[1].zfill(16))
    sf_out = output >> 13
    num = np.uint16(output & 0x1FFF)

    if num >> 12:
        num = (np.uint16((num << 4) >> 4))
        num = ~num
        num = num & 0x0FFF
        num = np.uint16(num + 1)
        print("Output in decimal :", (num * -1) / pow(2, sf_out))
    else:
        print("Output in decimal :", num / pow(2, sf_out))


# Start of the program.
if __name__ == '__main__':
    cli()

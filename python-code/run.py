import click
from modules import multiplier, adder
import numpy as np


@click.command()
@click.option('-m', '--module', default='multiplier',
              help='Choose module you want to run.', type=click.Choice(['multiplier', 'adder']))
@click.option('-f', '--first_operand',
              help='first operand in fixed point representation', required=True)
@click.option('-s', '--second_operand', required=True,
              help='second operand in fixed point representation.')
def cli(module, first_operand, second_operand):
    if module == "multiplier":
        output = multiplier(first_operand, second_operand)
    if module == "adder":
        output = adder(first_operand, second_operand)
    print_output(output)


# Function print output in binary and fixed point representation
def print_output(output):
    print("Output in binary :", bin(output).split('b')[1])
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

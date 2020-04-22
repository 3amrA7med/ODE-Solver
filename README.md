# ODE-Solver
Solving Ordinary Differential Equations using numerical methods 

## Verilog Code
We used verilog language in our simulation.
### Installation
you will need IDE to run the simulation code (etc Modelsim)
### Run
open Modelsim and navigate to the verilog-dofiles folder to run the scripts you want in the command line of the Modelsim


## Python Simulation
We used python to simulate the multiplier and adder modules.
### Installation
Use the package manager [pip](https://pip.pypa.io/en/stable/) to install numpy and click.

```bash
pip install numpy
pip install click
```
### Run
To run the program in the command line navigate to the python-code folder and write help to see the options.
```python
python run.py --help 
```
Example
```python
python run.py -m multiplier -f 0000000000111001  -s 0000001010100100
```

### Preserved Addresses (Starting Locations)
```
0 => N
1 => M
2 => Count
3 => Mode
4 => H
5 => L
6 => PerMode
7  => A
2507 => B
5007 => X0
5057 => T
5107 => U0
5157 => U1
5207 => Euler Operating X (Need to be prepared)
5257 => Euler Operating U (Need to be prepared)
5307 => Euler Temp1
5357 => Euler Temp2
5407 => Euler Resulting X (The location of the output)
```
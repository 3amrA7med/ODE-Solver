# ODE-Solver
Solving Ordinary Differential Equations using numerical methods 

## Verilog Code
We used verilog to simulate the modules
### Installation
you will need ide to run the simulation code (etc Modelsim)

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
To run the program in the command line navigate to the python-code folder and write
```python
python run.py --help 
```
to see the options.
Example
```python
python run.py -m multiplier -f 0000000000111001  -s 0000001010100100
```

import filecmp
import subprocess
import os

inputs = "/home/alexmiclea/Documents/Proiect-Lab-ASC/inputs/"
brute_gen = "/home/alexmiclea/Documents/Proiect-Lab-ASC/brute_matrix/"
asm_sol = "/home/alexmiclea/Documents/Proiect-Lab-ASC/asm_outputs/"



for i in range(1000):

    bashCommand = "/home/alexmiclea/Documents/Proiect-Lab-ASC/sol_asm/ex_1.o < " + inputs + f"test{i+1}.txt" + " > " + asm_sol + f"test{i+1}.txt"
    os.system(bashCommand)

    #print(f"Testul {i+1}: "+ str(filecmp.cmp(brute_gen + f"test{i+1}.txt", asm_sol + f"test{i+1}.txt", shallow=True)))
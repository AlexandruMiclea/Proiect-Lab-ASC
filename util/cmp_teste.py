import filecmp

asm_sol = "/home/alexmiclea/Documents/Proiect-Lab-ASC/asm_outputs/"
py_sol = "/home/alexmiclea/Documents/Proiect-Lab-ASC/py_outputs/"
output = "/home/alexmiclea/Documents/Proiect-Lab-ASC/util/rez.txt"

outfile = open(output, "w")

for test in range(1000):
    #print(f"Verdict testul {test+1}: ", end=' ')
    outfile.write(f"Verdict testul {test+1}: ")

    test_asm = open(asm_sol + f"test{test+1}.txt", "r")
    test_py = open(py_sol + f"test{test+1}.txt", "r")

    verdict = filecmp.cmp(asm_sol + f"test{test+1}.txt", py_sol + f"test{test+1}.txt", shallow=True)
    strVerdict = "ACCEPTED" if verdict == True else "WRONG ANSWER" 
    #print(strVerdict)
    outfile.write(strVerdict + '\n')

    data_asm = test_asm.readlines().copy()
    data_asm = [x.strip(" \n") for x in data_asm]

    data_py = test_py.readlines().copy()
    data_py = [x.strip(" \n") for x in data_py]

    if len(data_asm) == 1:
        #print("C2 asm, ", end ="")
        outfile.write("C2 asm, ")
    else:
        #print("C1 asm, ", end ="")
        outfile.write("C1 asm, ")
    if len(data_py) == 1:
        #print("C2 py")
        outfile.write("C2 py\n")
    else:
        #print("C1 py")
        outfile.write("C1 py\n")

    

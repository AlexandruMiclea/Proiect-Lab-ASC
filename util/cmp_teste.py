import filecmp

asm_sol = "/home/alexmiclea/Documents/Proiect-Lab-ASC/asm_outputs/"
py_sol = "/home/alexmiclea/Documents/Proiect-Lab-ASC/py_outputs/"
output = "/home/alexmiclea/Documents/Proiect-Lab-ASC/util/rez.txt"

outfile = open(output, "w")

inputs = "/home/alexmiclea/Documents/Proiect-Lab-ASC/inputs/"

for test in range(1000):
    #print(f"Verdict testul {test+1}: ", end=' ')
    outfile.write(f"Verdict testul {test+1}: ")

    testfile = open(inputs + f"test{test+1}.txt", "r")
    c = testfile.read()
    #print(c[0])
    c = int(c[0])

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

    if verdict == False:
        outfile.write("asm: " + str(data_asm[0]) + ", py: " + str(data_py[0]) + " ")

        outfile.write(f"C{c} asm, ")
        outfile.write(f"C{c} py\n")

    

matrix_brut = "/home/alexmiclea/Documents/Proiect-Lab-ASC/matrix_input_py/"
inputs = "/home/alexmiclea/Documents/Proiect-Lab-ASC/inputs/"
output_sol = "/home/alexmiclea/Documents/Proiect-Lab-ASC/py_outputs/"


for nr_test in range(1000):
    inputfile = open(inputs + f"test{nr_test+1}.txt", "r")
    file = open(output_sol + f"test{nr_test+1}.txt", "w")
    data = inputfile.readlines().copy()
    data = [x.strip(" \n") for x in data]
    #print(data)
    cerinta = int(data[0])
    
    nr_noduri = int(data[1])
    #print(nr_noduri)

    L = [[0] * nr_noduri for i in range(nr_noduri)]
    
    #print(*L, sep='\n')

    distanta = 0
    nodstanga = 0
    noddreapta = 0


    index = 2+nr_noduri
    nr_vecini = data[2:2+nr_noduri]
    #print(data[2:2+nr_noduri])
    for i in range(nr_noduri):
        vecini = data[index:index+int(nr_vecini[i])]
        for vecin in vecini:
            L[i][int(vecin)] = 1
        index = index+int(nr_vecini[i])

    if cerinta == 1: pass
    else:

        distanta = int(data[-3])
        #print(distanta)
        nodstanga = int(data[-2])
        noddreapta = int(data[-1])
    

    Lans = L.copy()
    #print(Lans)
    L1 = L.copy()
    L2 = L.copy()

    if cerinta == 1:

        for l in L:
            for el in l:
                file.write(str(el) + ' ')
            file.write("\n")

    else:

        for nr in range(distanta - 1):

            L2 = Lans.copy()
            Lans = [[0] * nr_noduri for l in range(nr_noduri)]

            for i in range(nr_noduri):
                for j in range(nr_noduri):
                    for k in range(nr_noduri):
                        Lans[i][j] += L2[i][k] * L1[k][j]

            
        file.write(str(Lans[nodstanga][noddreapta]))
    # print()
    # print(distanta)
    # print(nodstanga)
    # print(noddreapta)
    # print()
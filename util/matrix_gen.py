input_location = "/home/alexmiclea/Documents/Proiect-Lab-ASC/inputs/"
output_location = "/home/alexmiclea/Documents/Proiect-Lab-ASC/matrix_first_inputs/"

for i in range(10):

    with open(input_location + f"test{i+1}.txt") as file:
        data = file.readlines()
        data = [x.strip(" \n") for x in data]
        #print(data)
        
        print(data, sep='\n')
        #print('\n')
        #ce e in data fac matricea de adiacenta pe ea
        nr_noduri = int(data[1])

        L = [[0] * nr_noduri for i in range(nr_noduri)]
        
        #print(*L, sep='\n')


        index = 2+nr_noduri
        nr_vecini = data[2:2+nr_noduri]
        #print(data[2:2+nr_noduri])
        for i in range(nr_noduri):
            vecini = data[index:index+int(nr_vecini[i])]
            for vecin in vecini:
                L[i][int(vecin)] = 1
            index = index+int(nr_vecini[i])

        print(*L, sep='\n')
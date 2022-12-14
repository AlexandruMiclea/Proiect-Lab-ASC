input_location = "/home/alexmiclea/Documents/Proiect-Lab-ASC/inputs/"
output_location = "/home/alexmiclea/Documents/Proiect-Lab-ASC/matrix_first_inputs/"

for i in range(10):

    with open(input_location + f"test{i+1}.txt") as file:
        data = file.readlines()
        data = [x.strip(" \n") for x in data]
        #print(data)
        
        print(data, sep='\n')
        print('\n')
        #ce e in data fac matricea de adiacenta pe ea
        #nr_noduri = data[1]
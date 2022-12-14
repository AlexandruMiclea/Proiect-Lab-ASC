import random
import itertools as it

input_location = "/home/alexmiclea/Documents/Proiect-Lab-ASC/inputs/"

# 1 // numarul cerintei
# 4 // nr. noduri
# 2 // 0 are 2 legaturi (cu 1 si 2)
# 2 // 1 are 2 legaturi (cu 2 si 3)
# 1 // 2 are 1 legatura (cu 3)
# 0 // 3 nu are nicio legatura
# 1 // legaturile
# 2 // nodului 0
# 2 // legaturile
# 3 // nodului 1
# 3 // legatura nodului 2

for i in range(10): #creez 10 teste
    random.seed(a=None, version=2)
    nr_noduri = random.randint(2,10) #intre 2 si 10 noduri

    with open(input_location + f"test{i+1}.txt", "w") as file:
        l = []
        file.write("1")
        file.write("\n")
        file.write(str(nr_noduri))
        file.write("\n")
        for j in range(nr_noduri):
            nr_vec = random.randint(0, nr_noduri-1)
            l.append(str(nr_vec))
            file.write(str(nr_vec))
            file.write("\n")
        for j in range(nr_noduri):
            vec_posibili = set([int(x) for x in range(nr_noduri)])
            #print(*vec_posibili)
            vec_posibili.remove(j)
            lvec = list(vec_posibili)
            random.shuffle(lvec)
            lvec = lvec[:int(l[j])]
            print(lvec)

            #lvec = list(vec_posibili)
            
            for el in lvec:
                file.write(str(el))
                file.write("\n")
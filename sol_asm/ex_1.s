.data
    cerinta: .space 4
    matrice: .space 40000
    numarNoduri: .space 4
    numarVecini: .space 400
    strScan: .asciz "%ld"
    strPrint: .asciz "%ld "
    strLn: .asciz "\n"

    idxVecin: .space 4
    idxNod: .space 4
    right: .space 4
    idxPozitie: .space 4
    idxLin: .space 4
    idxCol: .space 4
.text
.global main

main:

    pushl $cerinta
    pushl $strScan
    call scanf
    addl $8, %esp

    pushl $numarNoduri
    pushl $strScan
    call scanf
    addl $8, %esp

    movl numarNoduri, %ebx
    xorl %ecx, %ecx
    lea numarVecini, %esi
    movl $0, idxNod
    movl $0, idxVecin

lscannrvec:

    cmp %ecx, %ebx
    je lcitnrvec
    
    lea (%esi, %ecx, 4), %edi

    pushl %ecx #trebuie sa restaurez ecx dupa scanf?
    pushl %edi
    pushl $strScan
    call scanf
    addl $8, %esp
    popl %ecx

    incl %ecx

    jmp lscannrvec

lcitnrvec:

    movl idxNod, %ecx
    movl numarNoduri, %ebx
    cmp %ecx, %ebx
    je lprintlin
    lea numarVecini, %esi
    movl (%esi, %ecx, 4), %ebx

    lcitvec:
        lea numarVecini, %esi
        movl idxNod, %ecx
        movl (%esi, %ecx, 4), %ebx

        movl idxVecin, %ecx
        cmp %ecx, %ebx
        je lcitvecexit

        pushl $right
        pushl $strScan
        call scanf
        addl $8, %esp

        // in right am dreapta, in idxNod stanga

        xorl %eax, %eax
        xorl %edx, %edx
        movl idxNod, %eax
        mull numarNoduri
        addl right, %eax

        lea matrice, %esi
        #lea (%esi, %eax, 4), %edi
        movl $1, (%esi, %eax, 4)

        incl idxVecin
        jmp lcitvec

    lcitvecexit:

    incl idxNod
    movl $0, idxVecin
    jmp lcitnrvec


lprintlin:

    lea matrice, %esi
    movl idxLin, %ecx
    movl numarNoduri, %ebx
    cmp %ecx, %ebx
    je etexit

    lprintcol:

        movl idxCol, %ecx
        movl numarNoduri, %ebx
        cmp %ecx, %ebx
        je lprintcolexit

        movl idxLin, %eax
        xorl %edx, %edx
        mull numarNoduri
        addl idxCol, %eax

        movl (%esi, %eax, 4), %edx

        pushl %edx
        pushl $strPrint
        call printf
        addl $8, %esp

        pushl $0
        call fflush
        addl $4, %esp

        incl idxCol
        jmp lprintcol        

    lprintcolexit:

        pushl $strLn
        call printf
        addl $4, %esp

        pushl $0
        call fflush
        addl $4, %esp

        incl idxLin
        movl $0, idxCol
        jmp lprintlin

etexit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
    
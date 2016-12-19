#OpenWorm CSV to JSON
#Author: Gaston Gentile

import gspread, getpass, os

os.system('clear')

#Primer paso, los datos son tomados / First Step, data is taken.
def start():
    print 'Convert CSV to JSON'
    user = raw_input("Gmail user: ")
    pwd = getpass.getpass("Gmail Password: ")
    gc = gspread.login(user,pwd)
    docurl = raw_input("Spreadsheet url: ")
    sh = gc.open_by_url(docurl)#apertura del documento / Open Doc.
    worksheet = sh.worksheet("Single Neurons")#Seleccion de la hoja / Sheet selection.

    print 'Taking values...'
    #Toma los valores de las celdas / Take value of celds.
    colb = worksheet.col_values(2)
    cold = worksheet.col_values(4)
    colf = worksheet.col_values(6)

    #Segundo paso, datos convertidos / Second Step, converted data.
    print 'Converting values to JSON...'
    celd = 2
    celegans = open('celegans.json','w')
    head = "{\n""\"name\":\"NeuroNetwork\",\n\"children\": [\n"
    celegans.write(head)

    for i in range(301):
        chld = "{\n\"name\":\""+colb[celd]+"\",\n\"children\": [\n{\"name\": \""+str(cold[celd])+"\", \"size\": 3000},\n{\"name\": \""+str(colf[celd])+"\", \"size\": 3000}\n]\n},\n"
        celd += 1
        celegans.write(chld)

    celegans.write("]\n}")
    celegans.close()

    print "\nWORKS!, celegans.json was generated!\n"
start()

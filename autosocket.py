#read input file
fin = open("%userprofile%\\.lunarclient\\solartweaks\\config.json", "rt")
#read file contents to string
data = fin.read()
#replace all occurrences of the required string
data = data.replace('wss://assetserver.lunarclientprod.com/connect', 'wss://socket.solartweaks.com')
#close the input file
fin.close()
#open the input file in write mode
fin = open("config.json", "wt")
#overrite the input file with the resulting data
fin.write(data)
#close the file
fin.close()

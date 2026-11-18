import psutil

for processo in psutil.process_iter():
    print("Processo:", processo.name(), "PID:", processo.pid, "Status:", processo.status())
    if processo.status() == "running":
        print("O programa está em execução")
    else:
        print("O programa não está em execução neste momento")
				
processos_conhecidos = ["chrome.exe", "explorer.exe", "python.exe"]


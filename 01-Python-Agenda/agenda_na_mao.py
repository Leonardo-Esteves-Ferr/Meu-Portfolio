AGENDA = {
    "guilherme": {
        "telefone": "9999-1010",
        "email": "contato@soli.com.br",
        "endereco": "av. 1"
    },
    "maria": {
        "telefone": "9072-1012",
        "email": "maria@soly.com.br",
        "endereco": "av. 2"
    },
    "joao": {
        "telefone": "9172-313",
        "email": "joao@soly.com.br",
        "endereco": "av. 3"
    }
}


def mostrar_contatos():
    for contato in AGENDA:
        buscar_contato(contato)
        print('________________________________________')


def buscar_contato(contato):
    if contato in AGENDA:
        print('Nome:', contato)
        print('Telefone:', AGENDA[contato]['telefone'])
        print('Email:', AGENDA[contato]['email'])
        print('Endereço:', AGENDA[contato]['endereco'])
    else:
        print('Contato não encontrado')


def incluir_editar_contato(contato, telefone, email, endereco):
    AGENDA[contato] = {
        'telefone': telefone,
        'email': email,
        'endereco': endereco,
    }
    print()
    print(">>>> Contato {} incluído/atualizado com sucesso".format(contato))
    print()


def excluir_contato(contato):
    if contato in AGENDA:
        AGENDA.pop(contato)
        print(">>>> Contato {} excluído com sucesso".format(contato))
    else:
        print('Contato não encontrado')


def exportar_contatos():
    try:
        with open('agenda.txt', 'w') as arquivo:
            for contato in AGENDA:
                telefone = AGENDA[contato]['telefone']
                email = AGENDA[contato]['email']
                endereco = AGENDA[contato]['endereco']
                arquivo.write("{};{};{};{}\n".format(contato, telefone, email, endereco))
        print('Agenda exportada com sucesso')
    except:
        print('Algum erro ocorreu ao exportar contatos')


def imprimir_menu():
    print('________________________________________')
    print('1 - Mostrar todos os contatos na agenda')
    print('2 - Buscar contato')
    print('3 - Incluir contato')
    print('4 - Editar contato')
    print('5 - Excluir contato')
    print('6 - Exportar contatos para CSV')
    print('0 - Fechar agenda')
    print('________________________________________')


while True:
    imprimir_menu()

    opcao = input('Escolha uma opção: ')

    if opcao == '1':
        mostrar_contatos()

    elif opcao == '2':
        contato = input('Digite o nome do contato: ')
        buscar_contato(contato)

    elif opcao == '3' or opcao == '4':
        contato = input('Digite o nome do contato: ')
        telefone = input('Digite o telefone do contato: ')
        email = input('Digite o email do contato: ')
        endereco = input('Digite o endereço do contato: ')
        incluir_editar_contato(contato, telefone, email, endereco)

    elif opcao == '5':
        contato = input('Digite o nome do contato: ')
        excluir_contato(contato)

    elif opcao == '6':
        exportar_contatos()

    elif opcao == '0':
        print('Fechando programa')
        break

    else:
        print('Opção inválida')
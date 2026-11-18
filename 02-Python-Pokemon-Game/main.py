from Pokemon import *
from pessoa import *


def escolher_pokemon_inicial(player):
    print("Olá {}, você poderá escolher agora o Pokemon que irá lhe acompanhar nessa jornada!".format(player))

    pikachu = PokemonEletrico("Pikachu", level=1)
    charmander = PokemonFogo("Charmander", level=1)
    blastoise = PokemonAgua("Blastoise", level=1)

    print("Você possui 3 escolhas:")
    print("1 - ", pikachu)
    print("2 - ", charmander)
    print("3 - ", blastoise)

    while True:
        escolha = input("Escolha o seu Pokemon: ")

        if escolha == "1":
            player.capturar(pikachu)
            break
        elif escolha == "2":
            player.capturar(charmander)
            break
        elif escolha == "3":
            player.capturar(blastoise)
            break
        else:
            print("Escolha inválida")


player = Player("Guilherme")

escolher_pokemon_inicial(player)

inimigo1 = Inimigo(nome="Gary", pokemons=[PokemonAgua("Squirtle", level=1)])

player.batalhar(inimigo1)
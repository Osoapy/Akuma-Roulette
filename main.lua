-- Creating global variables
Akuma = require("akuma")
Player = require("player")
Game = require("game")

-- Starting the game
print("WELCOME TO AKUMA\'S ROULETTE...")

print("What is your name? ")

Player.setName(io.read())

print("Ok " .. Player.name .. ". By playing this game you agree to the following terms:\n")

print("If you die, that\'s not Akuma\'s fault or responsability. The game consists in you both having the same number of lifes. If you die, you lose. If you survive, you win. Got it? Some might say to not accept a deal with the devil, but I\'m not him, I\'m a creature made in the essence of Nothing Hill. In the case you get badly hurt, seeing a doctor is necessary, but it\'s not included in none of your earnings.")

Game.sleep(6) -- SLEEP!!!

while true do
    if Game.shotsLeft == Game.shots then
        Akuma.setLifes(Game.lifes)
        Player.setLifes(Game.lifes)
        print("We both will have " .. Game.lifes .. " lifes. Let the shooting begin...")
    end

    if Game.shotsLeft == 0 then
        Game.recharge()
        Game.sleep(2) -- SLEEP!!!
        os.execute("clear")
        print("This round we'll have " .. Game.shots .." shots. " .. Game.shots // 2 .. " will be real and " .. Game.shots - Game.shots // 2 .. " will be fake. Let's see if you can guess them all...")
    end

    ::Player::
    print("You have " .. Player.lifes .. " lifes. Akuma has " .. Akuma.lifes .. " lifes.")
    print("SHOOT HIM (A) SHOOT YOURSELF (B)")
    local choice = io.read()

    Game.sleep(2) -- SLEEP!!!
    Game.shotsLeft = Game.shotsLeft - 1
    if choice == "A" then
        if Game.sequence[Game.shotsLeft + 1] == 1 then
            print("It was a real shot. He lost a life.")
            Akuma.lifes = Akuma.lifes - 1
        else
            print("It was a fake shot.")
        end
    end
    if choice == "B" then
        if Game.sequence[Game.shotsLeft + 1] == 1 then
            print("It was a real shot. You lost a life.")
            Player.lifes = Player.lifes - 1
        else
            print("It was a fake shot.")
            if Game.shotsLeft > 0 then
                goto Player
            end
        end
    end

    ::Akuma::
    if Game.shotsLeft > 0 then
        local akumasChoice = Akuma.decide(Game.sequence, Game.shotsLeft, Game.shots)
        print("Akuma\'s turn...")
        Game.sleep(2) -- SLEEP!!!
        Game.shotsLeft = Game.shotsLeft - 1
        if akumasChoice == 1 then
            if Game.sequence[Game.shotsLeft + 1] == 1 then
                print("He shot you. It was a real shot. You lost a life.")
                Player.lifes = Player.lifes - 1
            else
                print("He shot you. It was a fake shot.")
            end
        end
        if akumasChoice == 0 then
            if Game.sequence[Game.shotsLeft + 1] == 1 then
                print("He shot himself. It was a real shot. He lost a life.")
                Akuma.lifes = Akuma.lifes - 1
            else
                print("He shot himself. It was a fake shot.")
                goto Akuma
            end
        end
    end
end
-- Creating global variables
Akuma = require("akuma")
Player = require("player")
Game = require("game")
IOF = require("IOF")

-- Starting the game
IOF.betweenSignals("WELCOME TO AKUMA\'S ROULETTE...", 0.2)

IOF.dramaticWriting("What is your name? ", 0.4)

Player.setName(io.read())

IOF.dramaticWriting("Ok " .. Player.name .. ". By playing this game you agree to the following terms:\n", nil, 1)

IOF.dramaticWriting("If you die, that\'s not Akuma\'s fault or responsability. The game consists in you both having the same number of lifes. If you die, you lose. If you survive, you win. Got it? Some might say to don\'t accept a deal with the devil, but I\'m not him, I\'m a creature made in the essence of Nothing Hill. In the case you get badly hurt, seeing a doctor is necessary, but it\'s not included in none of your earnings.", nil, 1)

Game.sleep(2) -- SLEEP!!!

while true do
    if Game.shotsLeft == Game.shots then
        Akuma.setLifes(Game.lifes)
        Player.setLifes(Game.lifes)
        print("\nWe both will have " .. Game.lifes .. " lifes. Let the shooting begin...")
        Game.sleep(2) -- SLEEP!!!
    end

    if Game.shotsLeft == 0 then
        Game.recharge()
        Game.sleep(2) -- SLEEP!!!
        os.execute("clear")
        IOF.dramaticWriting("This round we'll have " .. Game.shots .." shots. " .. Game.shots // 2 .. " will be real and " .. Game.shots - Game.shots // 2 .. " will be fake. Let's see if you can guess them all...", 0.05, 1)
    end

    ::Player::
    IOF.dramaticWriting("You have " .. Player.lifes .. " lifes. Akuma has " .. Akuma.lifes .. " lifes.", nil, 1)
    IOF.betweenSignals("SHOOT HIM (A) SHOOT YOURSELF (B)")
    local choice = io.read()

    Game.sleep(2) -- SLEEP!!!
    Game.shotsLeft = Game.shotsLeft - 1
    if choice == "A" then
        if Game.sequence[Game.shotsLeft + 1] == 1 then
            IOF.dramaticWriting("It was a real shot. He lost a life.", nil, 1)
            Akuma.lifes = Akuma.lifes - 1
        else
            IOF.dramaticWriting("It was a fake shot.", nil, 1)
        end
    end
    if choice == "B" then
        if Game.sequence[Game.shotsLeft + 1] == 1 then
            IOF.dramaticWriting("It was a real shot. You lost a life.", nil, 1)
            Player.lifes = Player.lifes - 1
        else
            IOF.dramaticWriting("It was a fake shot.", nil, 1)
            if Game.shotsLeft > 0 then
                goto Player
            end
        end
    end

    ::Akuma::
    if Game.shotsLeft > 0 then
        local akumasChoice = Akuma.decide(Game.sequence, Game.shotsLeft, Game.shots)
        IOF.dramaticWriting("Akuma\'s turn...", nil, 1)
        Game.sleep(2) -- SLEEP!!!
        Game.shotsLeft = Game.shotsLeft - 1
        if akumasChoice == 1 then
            if Game.sequence[Game.shotsLeft + 1] == 1 then
                IOF.dramaticWriting("He shot you. It was a real shot. You lost a life.", nil, 1)
                Player.lifes = Player.lifes - 1
            else
                IOF.dramaticWriting("He shot you. It was a fake shot.", nil, 1)
            end
        end
        if akumasChoice == 0 then
            if Game.sequence[Game.shotsLeft + 1] == 1 then
                IOF.dramaticWriting("He shot himself. It was a real shot. He lost a life.", nil, 1)
                Akuma.lifes = Akuma.lifes - 1
            else
                IOF.dramaticWriting("He shot himself. It was a fake shot.", nil, 1)
                goto Akuma
            end
        end
    end
end
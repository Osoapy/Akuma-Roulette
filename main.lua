-- Creating global variables
Akuma = require("akuma")
Player = require("player")
Game = require("game")
IOF = require("IOF")

-- Starting the game
IOF.akuma()

IOF.betweenSignals("WELCOME TO AKUMA\'S ROULETTE...", 0.2)

IOF.dramaticWriting("What is your name? ", 0.4)

io.flush()
Player.setName(io.read())

IOF.dramaticWriting("Ok " .. Player.name .. ". By playing this game you agree to the following terms:\n", nil, 1)

IOF.dramaticWriting("If you die, that\'s not Akuma\'s fault or responsability. The game consists in you both having the same \nnumber of lifes. If you die, you lose. If you survive, you win. Got it? Some might say to don\'t \naccept a deal with the devil, but I\'m not him, I\'m a creature made in the essence of Nothing Hill. \nIn the case you get badly hurt, seeing a doctor is necessary, but it\'s not included in none of your \nearnings.", nil, 1)

Game.sleep(2) -- SLEEP!!!

while true do
    -- STARTING THE GAME
    if Game.shotsLeft == Game.shots then
        Akuma.setLifes(Game.lifes)
        Player.setLifes(Game.lifes)
        print("\nWe both will have " .. Game.lifes .. " lifes. Let the shooting begin...")
        Game.sleep(2) -- SLEEP!!!
    end

    -- RESETING THE TURN
    if Game.shotsLeft == 0 then
        Game.recharge()
        Game.sleep(2) -- SLEEP!!!
        os.execute("clear")
        IOF.akuma()
        IOF.signals(0.005)
        IOF.dramaticWriting("This round we'll have " .. Game.shots .." shots. " .. Game.shots // 2 .. " will be real and " .. Game.shots - Game.shots // 2 .. " will be fake. Let's see if you can guess them all...", 0.05, 1)
        Game.sleep(3) -- SLEEP!!!
    end

    -- PLAYER'S REALM
    ::Player::
    os.execute("clear")
    IOF.akuma()
    IOF.signals(0.005)
    IOF.dramaticWriting("You have " .. Player.lifes .. " lifes. Akuma has " .. Akuma.lifes .. " lifes.", nil, 1)
    IOF.betweenSignals("(A) SHOOT HIM (B) SHOOT YOURSELF")

    -- ASKING ITS WILL
    io.flush()
    local choice = io.read()

    Game.sleep(1) -- SLEEP!!!
    Game.shotsLeft = Game.shotsLeft - 1
    if choice == "A" then
            os.execute("clear")
            -- IF IT IS A REAL SHOT
            if Game.sequence[Game.shotsLeft + 1] == 1 then
                    IOF.shootingAkuma()
                    IOF.signals(0.005)
                    IOF.dramaticWriting("It was a real shot. He lost a life.", nil, 1)
                    Akuma.lifes = Akuma.lifes - 1
            -- IF IT IS A FAKE SHOT
            else
                    IOF.akuma()
                    IOF.signals(0.005)
                    IOF.dramaticWriting("It was a fake shot.", nil, 1)
            end
            Game.sleep(3) -- SLEEP!!!
    end
    if choice == "B" then
            os.execute("clear")
            IOF.pointingYourself()
            Game.sleep(3) -- SLEEP!!!
            os.execute("clear")
            -- IF IT IS A REAL SHOT
            if Game.sequence[Game.shotsLeft + 1] == 1 then
                    IOF.shootingYourself()
                    IOF.signals(0.005)
                    IOF.dramaticWriting("It was a real shot. You lost a life.", nil, 1)
                    Game.sleep(3) -- SLEEP!!!
                    Player.lifes = Player.lifes - 1
            -- IF IT IS A FAKE SHOT
            else
                    IOF.pointingYourself()
                    IOF.signals(0.005)
                    IOF.dramaticWriting("It was a fake shot.", nil, 1)
                    Game.sleep(3) -- SLEEP!!!
                    if Game.shotsLeft > 0 then
                        goto Player
                    end
            end
    end

    -- AKUMA'S REALM
    ::Akuma::
    if Game.shotsLeft > 0 then
            os.execute("clear")
            IOF.akuma()
            IOF.signals(0.005)
            -- ASKING ITS WILL
            local akumasChoice = Akuma.decide(Game.sequence, Game.shotsLeft, Game.shots)
            IOF.dramaticWriting("Akuma\'s turn...", nil, 1)
            Game.sleep(3) -- SLEEP!!!
            Game.shotsLeft = Game.shotsLeft - 1
            os.execute("clear")
            if akumasChoice == 1 then
                    -- IF IT IS A REAL SHOT
                    if Game.sequence[Game.shotsLeft + 1] == 1 then
                            IOF.shootingYourself()
                            IOF.signals(0.005)
                            IOF.dramaticWriting("He shot you. It was a real shot. You lost a life.", nil, 1)
                            Player.lifes = Player.lifes - 1
                    -- IF IT IS A FAKE SHOT
                    else
                            IOF.akuma()
                            IOF.signals(0.005)
                            IOF.dramaticWriting("He shot you. It was a fake shot.", nil, 1)
                    end
                    Game.sleep(3) -- SLEEP!!!
            end
            if akumasChoice == 0 then
                    -- IF IT IS A REAL SHOT
                    if Game.sequence[Game.shotsLeft + 1] == 1 then
                            IOF.shootingAkuma()
                            IOF.signals(0.005)
                            IOF.dramaticWriting("He shot himself. It was a real shot. He lost a life.", nil, 1)
                            Akuma.lifes = Akuma.lifes - 1
                            Game.sleep(3) -- SLEEP!!!
                    -- IF IT IS A FAKE SHOT
                    else
                            IOF.akuma()
                            IOF.signals(0.005)
                            IOF.dramaticWriting("He shot himself. It was a fake shot.", nil, 1)
                            Game.sleep(3) -- SLEEP!!!
                            goto Akuma
                    end
            end
    end
end
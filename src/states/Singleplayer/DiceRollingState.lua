--[[
    Mahjong DiceRollingState

    1. A pair of dice is rolled to determine whose tiles are dealed
    2. Rerolled is then done to determine which tiles are cut and therefore distributed to each player
]]

DiceRollingState = Class{__includes = BaseState}

function DiceRollingState:init(playerRoll)
    
    self.diceAnimation = Animation {
        frames = {1, 2, 3, 4, 5, 6},
        interval = 0.1
    }
    self.diceAnimationTrigger = true

end

function DiceRollingState:enter(params)

    self.playerRoll = params.playerRoll

end

function DiceRollingState:update(dt)
    self.diceAnimation:update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self.diceAnimationTrigger = not self.diceAnimationTrigger
        diceOne = math.random(6)
        diceTwo = math.random(6)
        diceSum = diceOne + diceTwo
    end 
end

function DiceRollingState:rolldice()
    return diceSum
end

function DiceRollingState:render()

    -- background
    love.graphics.draw(gTextures['background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    -- dice rolling animation
    if self.diceAnimationTrigger then

        -- first dice
        love.graphics.draw(gTextures['dice'], 
        gFrames['dice'][self.diceAnimation:getCurrentFrame()],
        VIRTUAL_WIDTH / 2 - DICE_WIDTH / 4 * 3,  
        VIRTUAL_HEIGHT / 2 - DICE_HEIGHT / 2,  
        0, 
        DICE_WIDTH / 51,
        DICE_HEIGHT / 52)

        -- second dice
        love.graphics.draw(gTextures['dice'], 
        gFrames['dice'][self.diceAnimation:getCurrentFrame()],
        VIRTUAL_WIDTH / 2 + DICE_WIDTH / 4 * 3,  
        VIRTUAL_HEIGHT / 2 - DICE_HEIGHT / 2,  
        0, 
        DICE_WIDTH / 51,
        DICE_HEIGHT / 52)

        if self.playerRoll then

            love.graphics.setFont(gFonts['medium'])
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.printf("Press Enter To Roll!", 
            0, 
            VIRTUAL_HEIGHT / 2 + DICE_HEIGHT, 
            VIRTUAL_WIDTH, 'center')

        end

    else

        -- first dice
        love.graphics.draw(gTextures['dice'], 
        gFrames['dice'][diceOne],
        VIRTUAL_WIDTH / 2 - DICE_WIDTH / 4 * 3,  
        VIRTUAL_HEIGHT / 2 - DICE_HEIGHT / 2, 
        0, 
        DICE_WIDTH / 51,
        DICE_HEIGHT / 52)

        -- second dice
        love.graphics.draw(gTextures['dice'], 
        gFrames['dice'][diceTwo],
        VIRTUAL_WIDTH / 2 + DICE_WIDTH / 4 * 3,  
        VIRTUAL_HEIGHT / 2 - DICE_HEIGHT / 2,  
        0, 
        DICE_WIDTH / 51,
        DICE_HEIGHT / 52)

    end
end
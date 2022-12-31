--[[
    Mahjong SettingState
]]

SettingState = Class{__includes = BaseState}

function SettingState:init()
    minFan = 1
    maxFan = 5
    tileColor = 1
    joker, jokerstring = false, "False"
    highlighted = 1
    
    settingWidth, settingHeight = VIRTUAL_WIDTH / 4 + 10, VIRTUAL_HEIGHT / 2 + 10
end

function SettingState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    highlighted = highlighted % 5

    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
        highlighted = highlighted - 1
        --gSounds['']:play()
    end

    if love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
        highlighted = highlighted + 1
        --gSounds['']:play()
    end

    if joker then
        jokerstring = "True"
    elseif not joker then
        jokerstring = "False"
    end

    -- confirm highlighted option after enter key is pressed
    if highlighted == 0 then
        if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or love.mousepressed() == 1 then
            gStateMachine:change('diceRoll', {
                playerRoll = true
            })
        end

    elseif highlighted == 1 then
        --gSounds['']:play()
        if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a') then
            minFan = math.max(1, minFan - 1)
            --gSounds['']:play()
        elseif love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d') then
            minFan = math.min(5, minFan + 1)
            --gSounds['']:play()
        end

    elseif highlighted == 2 then
        --gSounds['']:play()
        if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a') then
            maxFan = math.max(5, maxFan - 1)
            --gSounds['']:play()
        elseif love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d') then
            maxFan = math.min(10, maxFan + 1)
            --gSounds['']:play()
        end

    elseif highlighted == 3 then
        tileColor = tileColor % 6
        --gSounds['']:play()
        if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a') then
            tileColor = tileColor - 1
            --gSounds['']:play()
        elseif love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d') then
            tileColor = tileColor + 1
            --gSounds['']:play()
        end

    elseif highlighted == 4 then
        --gSounds['']:play()
        if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a') or love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d') then
            joker = not joker
            --gSounds['']:play()  
        end
    end

end

function SettingState:render()
    -- background
    love.graphics.draw(gTextures['background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    -- menu translucent rounded rectangle
    love.graphics.setColor(1, 1, 1, 0.25)
    love.graphics.rectangle("fill", VIRTUAL_WIDTH / 8 * 3 - 5, VIRTUAL_HEIGHT / 4 - 5, settingWidth, settingHeight, 5, 5)

    -- settings title
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Settings", 0, VIRTUAL_HEIGHT / 4 + 5, VIRTUAL_WIDTH, 'center')

    -- options
    love.graphics.setFont(gFonts['small'])

    -- if we're highlighting 1, render that option red
    if highlighted == 1 then
        love.graphics.setColor(189/255, 44/255, 32/255, 1)
    end
    love.graphics.printf("Minimum Fan : " .. (minFan), 0, VIRTUAL_HEIGHT / 4 + 30, VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    -- if we're highlighting 2, render that option red
    if highlighted == 2 then
        love.graphics.setColor(189/255, 44/255, 32/255, 1)
    end
    love.graphics.printf("Maximum Fan : " .. (maxFan), 0, VIRTUAL_HEIGHT / 4 + 40, VIRTUAL_WIDTH, 'center')
        
    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    -- if we're highlighting 3, render that option red
    if highlighted == 3 then
        love.graphics.setColor(189/255, 44/255, 32/255, 1)
    end
    love.graphics.printf("Tile Colour :", VIRTUAL_WIDTH / 2 - 35, VIRTUAL_HEIGHT / 4 + 60, VIRTUAL_WIDTH)
        
    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    -- render the tile and its colour
    if tileColor == 0 then
        love.graphics.draw(gTextures['tiles'], gFrames['tiles'][6], VIRTUAL_WIDTH / 2 + 15, VIRTUAL_HEIGHT / 4 + 50, 0, 
            0.1, 0.1)
    else
        love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tileColor], VIRTUAL_WIDTH / 2 + 15, VIRTUAL_HEIGHT / 4 + 50, 0, 
            0.1, 0.1)
    end

    -- if we're highlighting 4, render that option red
    if highlighted == 4 then
        love.graphics.setColor(189/255, 44/255, 32/255, 1)
    end

    love.graphics.printf("Joker Allowed : " .. (jokerstring), 0, VIRTUAL_HEIGHT / 4 + 80, VIRTUAL_WIDTH, 'center')
        
    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['medium'])

    -- if we're highlighting 0, render that option red
    if highlighted == 0 then
        love.graphics.setColor(189/255, 44/255, 32/255, 1)
    end
    love.graphics.printf("Enter Game!", 0, VIRTUAL_HEIGHT / 4 + 95, VIRTUAL_WIDTH, 'center')
        
    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)
end
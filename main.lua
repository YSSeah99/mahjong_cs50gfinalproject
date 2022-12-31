--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('Mahjong SEA')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    love.graphics.setFont(gFonts['small'])

    gStateMachine = StateMachine {
        ['menu'] = function() return MenuState() end,
        ['setting'] = function() return SettingState() end,
        ['diceRoll'] = function() return DiceRollingState() end
    }
    gStateMachine:change('setting')

    --gSounds['music']:setLooping(true)
    --gSounds['music']:play()

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mousepressed(button)
    return button
end

function love.update(dt)
    Timer.update(dt)
    gStateMachine:update(dt)

    love.mouse.setVisible(true)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()

    -- mouse?
    push:apply("start")
    
    love.graphics.setColor(50, 0, 0)
    --love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
    mouseX, mouseY = love.mouse.getPosition()
    mouseX, mouseY = push:toGame(mouseX, mouseY)
    --nil is returned if mouse is outside the game screen
    
    love.graphics.setColor(255, 255, 255)    
    push:apply("end")
end
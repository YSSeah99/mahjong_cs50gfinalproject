--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'
require 'src/tile'
require 'src/deck'

require 'src/states/BaseState'
require 'src/states/MenuState'

require 'src/states/Singleplayer/SettingState'
require 'src/states/Singleplayer/DiceRollingState'

gTextures = {
    ['background'] = love.graphics.newImage('graphics/mahjong_background.png'),
    ['tiles'] = love.graphics.newImage('graphics/tile_colour.png'),
    ['pattern'] = love.graphics.newImage('graphics/patterns.png'),
    ['dice'] = love.graphics.newImage('graphics/dice_Sprite.png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 190, 240),
    ['patterns'] = GenerateQuads(gTextures['pattern'], 150, 200),
    ['dice'] = GenerateQuads(gTextures['dice'], 51, 52)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}

gSounds = {
    
}
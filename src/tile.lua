--[[
    Mahjong
]]

Tile = Class{}

function Tile:init(def)

    self.class = def.class

    self.suit = def.suit or nil
    self.number = def.number or nil

    self.type = def.type or nil

    self.windNo = def.windNo or nil

    self.animal = def.animal or nil
    self.animalPair = def.animalPair or nil

end

function Tile:update(dt)

end

function Tile:render()

end
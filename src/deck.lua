--[[
    Mahjong SEA
]]

Deck = Class{}

function Deck.generate(jokerTrue)

    local deck = {}
    local suits = {"dots", "bamboo", "characters"}
    local winds = {"east", "south", "west", "north"}
    local dragons = {"red", "green", "white"}
    local flowers = {"plum", "orchid", "chrysanthemum", "bamboo"}
    local seasons = {"spring", "summer", "autumn", "winter"}
    local animals = {"cat", "mouse", "rooster", "worm"}

    -- generate all the suits and honours (4 times)
    for times = 1, 4 do

        -- for the suits
        for suitTypes = 1, 3 do
            -- generate for all the numbers from 1 to 9
            for number = 1, 9 do
                local tile = Tile {
                    class = "suits",
                    suit = suits[suitTypes],
                    number = number
                }
                table.insert(deck, tile)
            end
        end

        -- for the winds
        for windTypes = 1, 4 do
            local tile = Tile {
                class = "honours",
                type = winds[windTypes],
                windNo = windTypes
            }
            table.insert(deck, tile)
        end

        -- for the dragons
        for dragonTypes = 1, 3 do
            local tile = Tile {
                class = "honours",
                type = dragons[dragonTypes]
            }
            table.insert(deck, tile)
        end
    end

    -- generate all the bonuses

    -- for the flowers
    for flowersNo = 1, 4 do
        local tile = Tile {
            class = "bonus",
            type = flowers[flowersNo],
            number = flowersNo
        }
        table.insert(deck, tile)
    end

    -- for the seasons
    for seasonsNo = 1, 4 do
        local tile = Tile {
            class = "bonus",
            type = seasons[seasonsNo],
            number = seasonsNo
        }
        table.insert(deck, tile)
    end

    -- for the animals
    for animalPairNo = 1, 4 do
        local tile = Tile {
            class = "bonus",
            animal = animals[animalPairNo],
            animalPair = math.ceil(animalPairNo / 2)
        }
        table.insert(deck, tile)
    end

    if jokerTrue then
        for times = 1, 4 do
            local tile = Tile {
                class = "bonus",
                type = "joker"
            }
            table.insert(deck, tile)
        end
    end

    return deck
end

function Deck.shuffle(deck, jokerTrue)

    local sortedDeck = {}

    for i, tile in ipairs(deck) do
        local pos = math.random(1, #sortedDeck+1)
        table.insert(sortedDeck, pos, tile)
    end

    local wallOne = {} -- dealer's wall
    local wallTwo = {}
    local wallThree = {}
    local wallFour = {}

    if jokerTrue then
        
        for i, tile in ipairs(deck) do
            if i <= 38 then
                table.insert(wallOne, tile)
            elseif i <= 76 then
                table.insert(wallTwo, tile)
            elseif i <= 114 then
                table.insert(wallThree, tile)
            else
                table.insert(wallFour, tile)
            end
        end

    else

        for i, tile in ipairs(deck) do
            if i <= 38 then
                table.insert(wallOne, tile)
            elseif i <= 74 then
                table.insert(wallTwo, tile)
            elseif i <= 112 then
                table.insert(wallThree, tile)
            else
                table.insert(wallFour, tile)
            end
        end

    end

    return wallOne, wallTwo, wallThree, wallFour
end

function Deck.sort(diceSumOne, diceSumTwo, wallOne, wallTwo, wallThree, wallFour, jokerTrue)

    local handOne = {} -- dealer hand
    local handTwo = {}
    local handThree = {}
    local handFour = {}
    local drawWall = {}

    local dealerNo = diceSumOne % 4
    if dealerNo == 0 then dealerNo = 4 end

    local diceSum = diceSumOne + diceSumTwo
    if jokerTrue then
        if diceSum >= 19 then
            dealerNo = dealerNo + 1
            if dealerNo == 5 then dealerNo = 1 end
            diceSum = diceSum - 38
        end
    else
        if diceSum >= 19 and (dealerNo == 1 or dealerNo == 3) then
            dealerNo = dealerNo + 1
            diceSum = diceSum - 38
        elseif
            if diceSum >= 19 and (dealerNo == 2 or dealerNo == 4) end
            dealerNo = dealerNo + 1
            if dealerNo == 5 then dealerNo = 1 end
            diceSum = diceSum - 36
        end
    end

    local tilestostartDrawing = diceSum * 2


    -- distributing process
    counter = 0
    


    return handOne, handTwo, handThree, handFour, drawWall
end
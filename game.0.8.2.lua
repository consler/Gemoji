--Dont changee this
white="⬜"
black="⬛"
red="🟥"
blue="🟦"
brown="🟫"
orange="🟧"
green="🟩"
yellow="🟨"
-- position of player(you can change it)
posX = 1
posY = 1
-- choose size of the map
mapX = 16
mapY = 16
--choose skins
playerSKIN = blue -- white/black/red/blue/brown/orange/green/yellow
coinSKIN = yellow -- white/black/red/blue/brown/orange/green/yellow
stoneSKIN = black -- white/black/red/blue/brown/orange/green/yellow
emptySKIN = white -- white/black/red/blue/brown/orange/green/yellow
--choose level
lvl = 6

-- LOGIC(dont change anything there)
local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
function hmt(var, symb)
  local list = {}
  list[1] = 1
  for i=1, string.len(var) do
    if string.sub(var, i, i) == symb then
      list[i+1] = i
      list[i+1] = 0
    end
  end
  list[string.len(var) + 2] = string.len(move)
  return list
end
seed = 0
math.randomseed(seed)
seed = seed + 1
posList = {}
move = ""
round = 0
curX = 0
curx = 0
curY = 0
posx = 0
posy = 0
score = 0
stoneX = {}
stoneY = {}
for i = 1, lvl do
  seed = seed + 1
  math.randomseed(os.clock())
  stoneX[i] = math.random(2, mapX)
  seed = seed + 1
  math.randomseed(os.clock())
  stoneY[i] = math.random(1, mapY)
end
botX = math.random(2, mapX)
botY = math.random(2, mapY)
i = false
while not i do
            botX = math.random(2, mapX - 1)
            botY = math.random(2, mapY - 1)
            if not has_value(stoneX, botX) and not has_value(stoneY, botY) then i = true end
          end
sizeMap = mapX * mapY
posY = posY - 1
botY = botY - 1
--load
function loads()
  if(score==nil) then
    score = 0
  end
    -- moving player
    if move == "a" then
        if not has_value(stoneX, posX - 1) or not has_value(stoneY, posY) then posX = posX - 1 end
    elseif move == "d" then
        if not has_value(stoneX, posX + 1) or not has_value(stoneY, posY) then posX = posX + 1 end
    elseif move == "s" then
        if not has_value(stoneY, posY + 1 ) or not has_value(stoneX, posX) then posY = posY + 1 end
    elseif move == "w" then
        if not has_value(stoneY, posY - 1) or not has_value(stoneX, posX) then posY = posY - 1 end
    elseif move == "stop" then
        print("score: " .. score)
        return 0
    elseif move == "score" then
        print(score)
    elseif move == "step" then
      print(round)
    elseif string.sub(move, 1, 2) == "tp" then
      a = string.sub(move, 4, string.len(move) - 1)
      loadstring("list = {" .. a .. "}")()
      posX = list[1]
      posY = list[2]-1
    elseif string.sub(move, 1, 6) == "score+" then
      a = string.sub(move, 8, string.len(move) - 1)
      score = tonumber(a)
    else
      print("WRONG")
    end
    -- vars
    curX = 0
    curx = 0
    curY = 0
    -- spawn
    for i=1, sizeMap do
        curx = curx + 1
        curX = curX + 1
        if curx == posX and curY == posY then -- spawning player
            io.write(playerSKIN)
        elseif curx == botX and curY == botY then --spawning bot
            io.write(coinSKIN)
        elseif has_value(stoneX, curx) and has_value(stoneY, curY) then
            io.write(stoneSKIN)
        else -- other space
            io.write(emptySKIN)
        end
        if posX == botX and posY == botY then
        i = false
          while not i do
            botX = math.random(2, mapX - 1)
            botY = math.random(2, mapY - 1)
            if not has_value(stoneX, botX) and not has_value(stoneY, botY) then i = true end
          end
            score = score + 1
        end
        if curX % mapX == 0 and curX <= sizeMap and curX >= 0 then  -- new line
            io.write("\n")
        end
        if curx == mapX then -- reset value if new line
            curx = 0
        end
        if curx == 0 then -- add 1 to current Y if new line
            curY = curY + 1
        end
    end
    if curX == sizeMap then -- separation in the end of the cykle
        count = 0
        for i=1, mapX do
            count = count + 1
            io.write("➖")
            if count == mapX then io.write("\n") end
        end
    end
    round = round + 1
    rest()
end
-- start(restart)
function rest()
    move = io.read()
    loads()
end
loads()
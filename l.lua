setDefaultTab('dgs')

local dungeonOptions = {    
  "Mudoku", "Special Anko", "Solo Black Wolf", "Black Lobisomem",    
  "Special Chisana", "Dungeon Farukon", "Dungeon Kakuzu", "Solo Lobisomem", "Special Haku",    
  "Dungeon Shita", "Elite Black Dragon", "Madara Rikudou", "Special Minato",    
  "Special Itachi", "Special Obito", "Special Hagoromo", "Naruto Barion", "Special Tsunade", "Majo Tsuyoi"    
}    

local dungeonSetupPanel = setupUI([[    
Panel    
  id: dungeonSetupPanel    
  height: 15
  width: 140
  margin: 5    
  padding: 3   
  anchors.top: parent.top    
  anchors.left: parent.left    
  draggable: true    

  Button      
    id: toggleButton      
    text: Dungeons
    color: blue  
    width: 60  
    height: 20      
    anchors.left: parent.left      
    anchors.top: parent.top

  Panel    
    id: checkboxPanel    
    layout:    
      type: verticalBox      
    anchors.top: toggleButton.bottom    
    anchors.left: parent.left    
    anchors.right: parent.right    
    height: 0    
    visible: false    
]])

local checkboxesCreated = false    

-- Função para criar checkboxes
local function createDungeonCheckboxes()
  local checkboxPanel = dungeonSetupPanel.checkboxPanel
  if not checkboxesCreated then    
    for _, name in ipairs(dungeonOptions) do    
      local id = name:gsub("%s+", "")    
      local checkbox = g_ui.createWidget("CheckBox", checkboxPanel)    
      checkbox:setId(id)    
      checkbox:setText(name)    
      checkbox:setWidth(140)    
      checkbox:setChecked(storage["dungeon_" .. name] or false)    

      checkbox.onCheckChange = function(widget, value)    
        storage["dungeon_" .. name] = value    
      end    
    end    
    checkboxesCreated = true    
  end
end

-- Cria checkboxes e abre o painel automaticamente
createDungeonCheckboxes()
local checkboxPanel = dungeonSetupPanel.checkboxPanel
checkboxPanel:setVisible(true)
checkboxPanel:setHeight(#dungeonOptions * 20)
dungeonSetupPanel:setHeight(#dungeonOptions * 20 + 40)

-- Mantém funcionalidade do toggle button
dungeonSetupPanel.toggleButton.onClick = function()    
  local show = not checkboxPanel:isVisible()    
  checkboxPanel:setVisible(show)    
  if show then    
    checkboxPanel:setHeight(#dungeonOptions * 20)    
    dungeonSetupPanel:setHeight(#dungeonOptions * 20 + 40)    
  else    
    checkboxPanel:setHeight(0)    
    dungeonSetupPanel:setHeight(40)    
  end    
end    

-- Config Panel
local configPanelMain = setupUI([[
Panel
  id: configPanelMain
  height: 15
  width: 140
  margin: 5    
  padding: 3   
  anchors.top: dungeonSetupPanel.bottom
  anchors.left: parent.left

  Button
    id: configButton
    text: Configs
    color: green
    width: 60
    height: 20
    anchors.left: parent.left      
    anchors.top: parent.top

  Panel
    id: configPanel
    layout:
      type: verticalBox
    anchors.top: configButton.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: 0
    visible: false
]])

local configsCreated = false
configPanelMain.configButton.onClick = function()
  local configPanel = configPanelMain.configPanel
  local show = not configPanel:isVisible()

  if show and not configsCreated then
    local treinoCheckbox = g_ui.createWidget("CheckBox", configPanel)
    treinoCheckbox:setId("treinoCheckbox")
    treinoCheckbox:setText("Ativar Treino")
    treinoCheckbox:setWidth(140)
    treinoCheckbox:setChecked(storage.treinoAtivo or false)
    treinoCheckbox.onCheckChange = function(widget, value)
      storage.treinoAtivo = value
    end

    configsCreated = true
  end

  configPanel:setVisible(show)
  if show then
    configPanel:setHeight(20)
    configPanelMain:setHeight(configPanelMain:getHeight() + 30)
  else
    configPanel:setHeight(0)
    configPanelMain:setHeight(configPanelMain:getHeight() - 30)
  end
end

configPanelMain.configButton.onClick()

-- Efeito RGB nos botões
local function applyRGB(btn)
  macro(1000, function()  
    if not btn then return end  
    btn:setColor("pink")  
    schedule(200, function() if btn then btn:setColor("red") end end)  
    schedule(400, function() if btn then btn:setColor("yellow") end end)  
    schedule(600, function() if btn then btn:setColor("orange") end end)  
    schedule(800, function() if btn then btn:setColor("#00FFFF") end end)  
    schedule(1000, function() if btn then btn:setColor("green") end end)  
    schedule(1200, function() if btn then btn:setColor("blue") end end)  
  end)
end

applyRGB(dungeonSetupPanel.toggleButton)
applyRGB(configPanelMain.configButton)

-- Dungeon Labels
local dungeonLabels = {      
  { name = "Mudoku", label = "startMudoku", endLabel = "endMudoku" },      
  { name = "Special Anko", label = "startAnko", endLabel = "endAnko" },      
  { name = "Solo Black Wolf", label = "startSoloWolf", endLabel = "endSoloWolf" },      
  { name = "Black Lobisomem", label = "startBlackLobisomem", endLabel = "endBlackLobisomem" },      
  { name = "Special Chisana", label = "startChisana", endLabel = "endChisana" },      
  { name = "Dungeon Farukon", label = "startDungeonFarukon", endLabel = "endDungeonFarukon" },      
  { name = "Solo Lobisomem", label = "startSoloLobisomem", endLabel = "endLobisomem" },      
  { name = "Special Haku", label = "startSpecialHaku", endLabel = "endSpecialHaku" },      
  { name = "Dungeon Shita", label = "startDungeonShita", endLabel = "endDungeonShita" },      
  { name = "Elite Black Dragon", label = "startEliteBlackDragon", endLabel = "endEliteBlackDragon" },      
  { name = "Madara Rikudou", label = "startMadaraRikudou", endLabel = "endMadaraRikudou" },      
  { name = "Special Minato", label = "startSpecialMinato", endLabel = "endSpecialMinato" },      
  { name = "Special Itachi", label = "startItachi", endLabel = "endItachi" },      
  { name = "Special Obito", label = "startSpecialObito", endLabel = "endSpecialObito" },      
  { name = "Special Hagoromo", label = "startHagoromo", endLabel = "endHagoromo" },      
  { name = "Majo Tsuyoi", label = "startMajoTsuyoi", endLabel = "endMajoTsuyoi" },      
  { name = "Special Tsunade", label = "startTsunade", endLabel = "endTsunade" },      
  { name = "Dungeon Kakuzu", label = "startKakuzu", endLabel = "endKakuzu" },      
  { name = "Naruto Barion", label = "startNarutoBarion", endLabel = "endNarutoBarion" }      
}      

-- Bosses
local bossNames = {      
  "Mudoku", "Special Anko", "Special Itachi", "Black Lobisomem", "Special Chisana",      
  "Elite Black Dragon", "Special Haku", "Dungeon Fuuton Heart", "Solo Black Wolf", "Solo Lobisomem", "Madara Rikudou",      
  "Special Minato", "Special Obito", "Majo Tsuyoi", "Dungeon Shita",      
  "Dungeon Farukon", "Naruto Barion", "Special Tsunade", "Special Hagoromo"      
}      

-- Configs de macros
local checkInterval = 30000      
local maxWaitTime = 15000      
local currentDungeon = nil      
local tryingToEnterSince = nil      
local dungeonIndex = 1      

local treinoSquares = {  
  {x = 1449, y = 1220, z = 8},  
  {x = 1449, y = 1222, z = 8},  
  {x = 1449, y = 1224, z = 8},  
  {x = 1449, y = 1226, z = 8},  
  {x = 1449, y = 1228, z = 8},  
  {x = 1449, y = 1230, z = 8},  
  {x = 1449, y = 1232, z = 8},   
  {x = 1449, y = 1234, z = 8},  
  {x = 1449, y = 1236, z = 8},  
  {x = 1449, y = 1238, z = 8},  
}  

local estavaNoTreino = nil              
local suppressExitOff = false           

local function estaNoTreino(p)  
  for _, sq in ipairs(treinoSquares) do  
    if p.x == sq.x and p.y == sq.y and p.z == sq.z then  
      return true  
    end  
  end  
  return false  
end  

macro(500, function()      
  for _, val in pairs(getSpectators()) do      
    if val:isMonster() then      
      local name = val:getName():lower()      
      for _, boss in ipairs(bossNames) do      
        if name:find(boss:lower()) and val:getHealthPercent() <= 95 then      
          CaveBot.setOn(false)      
          currentDungeon = nil      
          tryingToEnterSince = nil      
          return      
        end      
      end      
    end      
  end      
end)      

macro(200, function()  
  local p = pos()  
  if not p then return end  
  local noTreino = estaNoTreino(p)  

  if estavaNoTreino == nil then  
    estavaNoTreino = noTreino  
    return  
  end  

  if not estavaNoTreino and noTreino then  
    CaveBot.setOn(false)  
  elseif estavaNoTreino and not noTreino then  
    if suppressExitOff then  
      suppressExitOff = false  
    else  
      CaveBot.setOn(false)  
    end  
  end  

  estavaNoTreino = noTreino  
end)

macro(checkInterval, "Auto Dungeon", function()  
  local now = os.clock() * 1000  

  if currentDungeon and tryingToEnterSince and (now - tryingToEnterSince > maxWaitTime) then      
    CaveBot.gotoLabel(currentDungeon.label)      
    tryingToEnterSince = now      
    return      
  end      

  if currentDungeon then return end      

  local attempts = 0      
  while attempts < #dungeonLabels do      
    local dungeon = dungeonLabels[dungeonIndex]      
    local enabled = storage["dungeon_" .. dungeon.name] or false      

    if enabled then      
      local isAvailable = false      

      for _, child in pairs(g_ui.getRootWidget():recursiveGetChildren()) do      
        if type(child.getText) == "function" and child:isVisible() then      
          local text = child:getText()      
          if text and text:find(dungeon.name) then      
            local parent = child:getParent()      
            if parent then      
              for _, label in pairs(parent:getChildren()) do      
                if type(label.getText) == "function" and label:isVisible() and label:getText() == "OK" then      
                  isAvailable = true      
                  break      
                end      
              end      
            end      
          end      
        end      
        if isAvailable then break end      
      end      

      if isAvailable then      
        local p = pos()  
        if p and estaNoTreino(p) then  
          suppressExitOff = true  
        end  

        CaveBot.setOn(true)      
        CaveBot.gotoLabel(dungeon.label)      
        currentDungeon = dungeon      
        tryingToEnterSince = now      
        return      
      end      
    end      

    dungeonIndex = dungeonIndex + 1      
    if dungeonIndex > #dungeonLabels then dungeonIndex = 1 end      
    attempts = attempts + 1      
  end      

  local p = pos()  
  local noTreino = (p and estaNoTreino(p)) or false  
  if not noTreino and (storage.treinoAtivo or false) then  
    CaveBot.setOn(true)  
    CaveBot.gotoLabel("startTreino")  
  end  
end)

-- Voltar do hospital
macro(10000, function()
  local px, py, pz = posx(), posy(), posz()
  if (px >= 1075 and px <= 1090) and (py >= 905 and py <= 920) and pz == 7 then
    CaveBot.setOn()
    CaveBot.gotoLabel("recoverFromDeath")
  end
end)


local alavancas = {
  {x = 255, y = 1257, z = 7}, --Mudoku
  {x = 862, y = 1819, z = 6}, -- lobisomem
  {x = 1175, y = 1418, z = 8}, --Madara
  {x = 1331, y = 1749, z = 8}, --Minato
  {x = 1190, y = 1161, z = 8}, --Haku
  {x = 1374, y = 1743, z = 8}, -- Dragon
}

-- Mapeamento de direções para g_game.walk
local directionMap = {
  ["0,-1"] = 0,  -- North
  ["1,0"]  = 1,  -- East
  ["0,1"]  = 2,  -- South
  ["-1,0"] = 3,  -- West
  ["1,-1"] = 4,  -- NorthEast
  ["1,1"]  = 5,  -- SouthEast
  ["-1,1"] = 6,  -- SouthWest
  ["-1,-1"]= 7   -- NorthWest
}

-- Verifica se tile está livre para andar (sem criaturas e walkable)
local function isTileFree(tile)
  if not tile or not tile:isWalkable() then return false end
  for _, thing in ipairs(tile:getThings()) do
    if thing:isCreature() then
      return false
    end
  end
  return true
end

-- Distância máxima entre posições (considerando quadrados)
local function getDistance(pos1, pos2)
  return math.max(math.abs(pos1.x - pos2.x), math.abs(pos1.y - pos2.y))
end

-- Empurrar jogador da alavanca, priorizando diagonais
local function empurrarPlayer(alavancaPos)
  local tile = g_map.getTile(alavancaPos)
  if not tile then return false end

  for _, thing in pairs(tile:getThings()) do
    if thing:isCreature() and not thing:isLocalPlayer() then
      local myPos = g_game.getLocalPlayer():getPosition()

      -- Se estiver colado no player, afasta primeiro
      if getDistance(myPos, alavancaPos) == 1 then
        local afastarDirecoes = {
          {x = 1, y = 0}, {x = -1, y = 0}, {x = 0, y = 1}, {x = 0, y = -1},
          {x = 1, y = 1}, {x = 1, y = -1}, {x = -1, y = 1}, {x = -1, y = -1}
        }
        for _, dir in ipairs(afastarDirecoes) do
          local newPos = {x = myPos.x + dir.x, y = myPos.y + dir.y, z = myPos.z}
          if isTileFree(g_map.getTile(newPos)) and getDistance(newPos, alavancaPos) > 1 then
            local key = dir.x .. "," .. dir.y
            if directionMap[key] then
              g_game.walk(directionMap[key])
              return false
            end
          end
        end
      end

      -- Tentar todas as diagonais primeiro
      local diagonalDirs = {
        {x=1, y=-1},  -- NE
        {x=1, y=1},   -- SE
        {x=-1, y=1},  -- SW
        {x=-1, y=-1}, -- NW
      }
      for _, dir in ipairs(diagonalDirs) do
        local toPos = {x = alavancaPos.x + dir.x, y = alavancaPos.y + dir.y, z = alavancaPos.z}
        if isTileFree(g_map.getTile(toPos)) then
          if g_game.move(thing, toPos, 1) then
            return true
          end
        end
      end

      -- Se não conseguiu diagonais, tenta ortogonais
      local orthoDirs = {
        {x=0, y=-1},  -- N
        {x=1, y=0},   -- E
        {x=0, y=1},   -- S
        {x=-1, y=0},  -- W
      }
      for _, dir in ipairs(orthoDirs) do
        local toPos = {x = alavancaPos.x + dir.x, y = alavancaPos.y + dir.y, z = alavancaPos.z}
        if isTileFree(g_map.getTile(toPos)) then
          if g_game.move(thing, toPos, 1) then
            return true
          end
        end
      end
    end
  end
  return false
end

-- Macro para empurrar automaticamente a cada 2 segundos
macro(200, function()
  for _, pos in ipairs(alavancas) do
    empurrarPlayer(pos)
  end
end)


local mwRuneId = 7397

local mwPositionsHagoromo = {
  {x = 2146, y = 1066, z = 15},
  {x = 2147, y = 1066, z = 15},
  {x = 2147, y = 1067, z = 15},
  {x = 2147, y = 1068, z = 15},
  {x = 2146, y = 1068, z = 15},
}

local cooldown = 5000 -- 20 segundos por posição
local lastUsed = {}

macro(3000, function()
  for _, pos in ipairs(mwPositionsHagoromo) do
    local key = pos.x .. "," .. pos.y .. "," .. pos.z

    if not lastUsed[key] or now - lastUsed[key] >= cooldown then
      local tile = g_map.getTile(pos)
      if tile then
        local topThing = tile:getTopThing()
        local topId = topThing and topThing:getId()

        -- Se não tiver MW no tile (ID 7397 ou variantes)
        if not topId or (topId ~= 7397 and topId ~= 2128 and topId ~= 2129) then
          g_game.useInventoryItemWith(mwRuneId, tile:getTopUseThing())
          lastUsed[key] = now
          return
        end
      end
    end
  end
end)

-- abrir DungeonTimers
macro(1000, function()
  if modules.game_bosstimes and modules.game_bosstimes.open then
    modules.game_bosstimes.open()
  end
end)




-- burlarNpc corrigido

local function sayWord1(str)
    local _, strStart = str:find("palavra ")
    local strEnd = str:find(" para")
    if not strStart or not strEnd then return nil end
    return str:sub(strStart + 1, strEnd - 1):trim()
end

local function sayWord2(str)
    local _, strStart = str:find("palavra ")
    local strEnd = str:find(" para")
    if not strStart or not strEnd then return nil end
    return str:sub(strStart + 1, strEnd - 1):trim()
end

local function sayWord3(str)
    local _, strStart = str:find("> ")
    local strEnd = str:find(" <")
    if not strStart or not strEnd then return nil end
    return str:sub(strStart + 1, strEnd - 1):trim()
end

local function sayWord4(str)
    local _, strStart = str:find("digite: ")
    local strEnd = str:find(" para")
    if not strStart or not strEnd then return nil end
    return str:sub(strStart + 1, strEnd - 1):trim()
end

local function sayWord5(str)
    local _, strStart = str:find("palavra ")
    local strEnd = str:find(" para")
    if not strStart or not strEnd then return nil end
    return str:sub(strStart + 1, strEnd - 1):trim()
end

onTalk(function(name, level, mode, text, channelId, pos)
    local wordFunc

    if name == 'Kirigakure' then
        wordFunc = sayWord1
    elseif name == 'Myoboku' then
        wordFunc = sayWord2
    elseif name == 'Benisu' then
        wordFunc = sayWord3
    elseif name == 'Port Island' then
        wordFunc = sayWord4
    elseif name == 'Dark Island' then
        wordFunc = sayWord5
    end

    if wordFunc then
        local word = wordFunc(text)
        if word then
            word = word:gsub("^%s*{", ""):gsub("}%s*$", "")
            NPC.say(word)
            schedule(400, function() NPC.say('yes') end)
        end
    end
end)



if player:getBlessings() == 0 then
    say("!bless")
    schedule(2000, function()
        if player:getBlessings() == 0 then
            error("!! Blessings not bought !!")
        end
    end)
end



-- ==================== CONFIGURAÇÃO ====================

-- Campo de texto para editar IDs das armas
-- Formato:
-- PvP: distancia,corpoacorpo
-- Boss: principal,secundaria
-- Trainer: id
storage.weaponIDsText = storage.weaponIDsText or "PvP:13614,14253\nBoss:13614,14579\nTrainer:14413"

-- Modos disponíveis
local modos = {"PvP", "Boss"}
storage.weaponModeIndex = storage.weaponModeIndex or 1

-- ==================== FUNÇÕES ====================

-- Equipar arma até funcionar (máx 20 tentativas)
function equiparAteFuncionar(itemId, slot)
    local tentativas = 0
    local function tentar()
        local itemAtual = g_game.getLocalPlayer():getInventoryItem(slot)
        if itemAtual and itemAtual:getId() == itemId then return end
        if tentativas >= 20 then return end
        moveToSlot(itemId, slot)
        tentativas = tentativas + 1
        schedule(500, tentar)
    end
    tentar()
end

-- Função para parsear IDs do texto
local function parseWeaponIDs()
    local ids = {}
    for line in storage.weaponIDsText:gmatch("[^\n]+") do
        local mode, list = line:match("(%w+):(.+)")
        if mode and list then
            local values = {}
            for id in list:gmatch("%d+") do
                table.insert(values, tonumber(id))
            end
            ids[mode] = values
        end
    end
    return ids
end

-- ==================== UI ====================

local modoLabel = UI.Label("Modo: " .. modos[storage.weaponModeIndex])

local changeModeButton = UI.Button("Trocar Modo", function()
    storage.weaponModeIndex = storage.weaponModeIndex + 1
    if storage.weaponModeIndex > #modos then
        storage.weaponModeIndex = 1
    end
    modoLabel:setText("Modo: " .. modos[storage.weaponModeIndex])
end)

-- Campo de texto para configurar os IDs das armas
addTextEdit("Config Armas (Modo:ID1,ID2)", storage.weaponIDsText, function(widget, text)
    storage.weaponIDsText = text
end)

-- ==================== CONTROLE DE TEMPO ====================

local lastSwitchTime = 0
local isUsingSecondary = false
local lastAttackTime = 0

-- ==================== MACRO TROCAR ARMA ====================

local trocarArmaMacro = macro(100, "Trocar Arma", function()
    if not g_game.isAttacking() then return end

    local currentTime = now
    local target = g_game.getAttackingCreature()
    if not target then return end

    local checkID = getLeft()
    local currentWeapon = checkID and checkID:getId() or 0
    local distance = getDistanceBetween(pos(), target:getPosition())

    -- Parse IDs atuais
    local weaponIDs = parseWeaponIDs()
    local mode = modos[storage.weaponModeIndex]

    -- ========= PRIORIDADE: TRAINER =========
    if target:getName():lower() == "trainer" then
        local trainerID = weaponIDs.Trainer[1]
        if currentWeapon ~= trainerID then
            equiparAteFuncionar(trainerID, SlotLeft)
        end
        return
    end

    -- ========= MODOS NORMAIS =========
    if mode == "PvP" then
        local rangeID = weaponIDs.PvP[1]
        local meleeID = weaponIDs.PvP[2]

        if distance > 1 then
            if currentWeapon ~= rangeID then equiparAteFuncionar(rangeID, SlotLeft) end
        else
            if currentWeapon ~= meleeID then equiparAteFuncionar(meleeID, SlotLeft) end
        end

    elseif mode == "Boss" then
        local idPrincipal = weaponIDs.Boss[1]
        local idSecundaria = weaponIDs.Boss[2]

        if lastAttackTime == 0 then
            lastAttackTime = currentTime
            return
        end

        if currentTime - lastAttackTime < 1500 then return end

        if isUsingSecondary and (currentTime - lastSwitchTime >= 2000) then
            if not checkID or checkID:getId() ~= idPrincipal then
                equiparAteFuncionar(idPrincipal, SlotLeft)
            end
            isUsingSecondary = false
            lastSwitchTime = currentTime
            lastAttackTime = 0
        elseif not isUsingSecondary and (currentTime - lastSwitchTime >= 30000) then
            if not checkID or checkID:getId() ~= idSecundaria then
                equiparAteFuncionar(idSecundaria, SlotLeft)
            end
            isUsingSecondary = true
            lastSwitchTime = currentTime
            lastAttackTime = 0
        end
    end
end)

-- ==================== ÍCONE ====================

armaIcon = addIcon("Trocar Arma", {item = 11927, text = "Trocar Arma", hotkey = ""}, trocarArmaMacro)
armaIcon:breakAnchors()
armaIcon:move(240, 300)



local mwRuneId = 11600

local mwPositionsHagoromo = {
  {x = 907, y = 1588, z = 15},
  {x = 908, y = 1588, z = 15},
  {x = 908, y = 1589, z = 15},
  {x = 908, y = 1590, z = 15},
  {x = 907, y = 1590, z = 15},
  {x = 907, y = 1587, z = 15},
  {x = 908, y = 1587, z = 15},
  {x = 909, y = 1587, z = 15},
  {x = 909, y = 1588, z = 15},
  {x = 909, y = 1589, z = 15},
  {x = 909, y = 1590, z = 15},
  {x = 909, y = 1591, z = 15},
  {x = 908, y = 1591, z = 15},
  {x = 907, y = 1591, z = 15},
}

local cooldown = 1000 -- 5 segundos por posição
local lastUsed = {}

macro(1000, function()
  local now = os.clock() * 1000

  for _, pos in ipairs(mwPositionsHagoromo) do
    local key = pos.x .. "," .. pos.y .. "," .. pos.z

    if not lastUsed[key] or (now - lastUsed[key] >= cooldown) then
      local tile = g_map.getTile(pos)
      if tile then
        local topThing = tile:getTopThing()
        local topId = topThing and topThing:getId()

        -- Se não tiver MW no tile (ID 14047)
        if not topId or topId ~= 14047 then
          g_game.useInventoryItemWith(mwRuneId, tile:getTopUseThing())
          lastUsed[key] = now
          return
        end
      end
    end
  end
end)




storage.desviarDelay = storage.desviarDelay or 1000
storage.effectBlacklist = storage.effectBlacklist or {}
storage.debuggedBlacklist = storage.debuggedBlacklist or {}

-- Botão de ajuste de delay
local delayLabel = UI.Label("Delay: " .. storage.desviarDelay .. "ms")
UI.Button("Trocar Delay", function()
  storage.desviarDelay = (storage.desviarDelay == 1000) and 500 or 1000
  delayLabel:setText("Delay: " .. storage.desviarDelay .. "ms")
end)

-- IDs dos efeitos perigosos
local effectId1, effectId2 = 1541, 1533
local maxRange = 10
local blacklistDuration = 1500
local effectScanRadius = 5

-- Lista de posições onde não deve desviar
local ignoredPositions = {
  {x = 907, y = 1589, z = 15},
  -- adicione quantas posições quiser
}


local function getMillisNow()
  return g_clock.millis()
end

local function hasEffect(tile, effect1, effect2)
  for _, fx in ipairs(tile:getEffects()) do
    local id = fx:getId()
    if id == effect1 or id == effect2 then
      return true
    end
  end
  return false
end

local function posToStr(pos)
  return pos.x .. "," .. pos.y .. "," .. pos.z
end

local function blacklistPos(pos)
  local key = posToStr(pos)
  storage.effectBlacklist[key] = getMillisNow()
end

local function isBlacklisted(pos)
  local key = posToStr(pos)
  local t = storage.effectBlacklist[key]
  if t and (getMillisNow() - t < blacklistDuration) then
    return true
  elseif t then
    storage.effectBlacklist[key] = nil
    storage.debuggedBlacklist[key] = nil
  end
  return false
end

local function isIgnored(pos)
  for _, p in ipairs(ignoredPositions) do
    if pos.x == p.x and pos.y == p.y and pos.z == p.z then
      return true
    end
  end
  return false
end

local scanMacro = macro(200, function()
  local playerPos = pos()
  if not g_map.getTile(playerPos) then return end

  for dx = -effectScanRadius, effectScanRadius do
    for dy = -effectScanRadius, effectScanRadius do
      local checkPos = {x = playerPos.x + dx, y = playerPos.y + dy, z = playerPos.z}
      local tile = g_map.getTile(checkPos)
      if tile and hasEffect(tile, effectId1, effectId2) then
        blacklistPos(checkPos)
      end
    end
  end
end)

desviarMacro = macro(100, "Desviar", function()
  local playerPos = pos()
  if not g_map.getTile(playerPos) then return end

  -- Se estiver em posição ignorada, não desvia
  if isIgnored(playerPos) then
    return
  end

  if isBlacklisted(playerPos) then
    for dist = 1, maxRange do
      for dx = -dist, dist do
        for dy = -dist, dist do
          if math.abs(dx) == dist or math.abs(dy) == dist then
            local checkPos = {x = playerPos.x + dx, y = playerPos.y + dy, z = playerPos.z}
            local tile = g_map.getTile(checkPos)

            if tile and g_map.isWalkable(checkPos)
              and not hasEffect(tile, effectId1, effectId2)
              and not isBlacklisted(checkPos) then

              local path = findPath(playerPos, checkPos, 250)
              if path and #path > 0 then
                autoWalk(checkPos, 50, { ignoreNonPathable = true, precision = 1 })
                delay(storage.desviarDelay)
                return
              end
            end
          end
        end
      end
    end
  end
end)

desviar1 = addIcon("Desviar", {item = 12435, text = "Desviar", hotkey = ""}, desviarMacro)
desviar1:breakAnchors()
desviar1:move(300, 300)

onCreaturePositionChange(function(creature, newPos, oldPos)
  if creature:isLocalPlayer() and oldPos then
    local reset = false
    -- Mudança de andar
    if newPos.z ~= oldPos.z then
      reset = true
    end
    -- Teleporte grande em X ou Y (≥ 5 SQM de diferença)
    if math.abs(newPos.x - oldPos.x) >= 5 or math.abs(newPos.y - oldPos.y) >= 5 then
      reset = true
    end
    if reset then
      storage.effectBlacklist = {}
      storage.debuggedBlacklist = {}
      -- opcional: echo("Blacklist resetada (mudança grande de posição).")
    end
  end
end)


-- Lista de monstros permitidos na ordem de prioridade
local allowedMonsters = {
  "Dungeon Fuuton Heart",
  "Dungeon Raiton Heart",
  "Dungeon Katon Heart",
  "Dungeon Suiton Heart",
  "Dungeon Kakuzu"
}

local distance = 10

atackMacro = macro(1, function()
  if isInPz() then
    return
  end

  local mobToAttack = nil

  -- Percorre a lista de prioridade
  for _, monsterName in ipairs(allowedMonsters) do
    for _, val in pairs(getSpectators()) do
      if val:isMonster() and val:canShoot() then
        if val:getName():lower():find(monsterName:lower()) then
          if getDistanceBetween(player:getPosition(), val:getPosition()) <= distance then
            mobToAttack = val
            break
          end
        end
      end
    end
    if mobToAttack then break end -- Encontrou o monstro prioritário, sai do loop
  end

  -- Ataca o monstro encontrado
  if mobToAttack then
    if not g_game.isAttacking() or g_game.getAttackingCreature() ~= mobToAttack then
      g_game.attack(mobToAttack)
    end
  end
end)






-- IDs das comidas específicas
storage.foodItems = {13958, 14059} -- Substitua pelos IDs dos seus alimentos

macro(62000, function()
  if not storage.foodItems or #storage.foodItems == 0 then
    print("[COMIDA] Nenhum ID configurado.")
    return
  end

  local usados = {}

  for _, container in pairs(g_game.getContainers()) do
    for __, item in ipairs(container:getItems()) do
      local id = item:getId()
      for _, foodId in ipairs(storage.foodItems) do
        if id == foodId and not usados[foodId] then
          g_game.use(item)
          print("[COMIDA] Usou item ID: " .. id)
          usados[foodId] = true
        end
      end
    end
  end

  for _, id in ipairs(storage.foodItems) do
    if not usados[id] then
      print("[COMIDA] Não encontrou item ID: " .. id)
    end
  end
end)




-- Nome exato da bag que será verificada (substitua conforme necessário)
local bagName = "halloween backpack protect v4"

-- Função para abrir a bag principal (slot das costas)
function openMainBackpack()
  local bpItem = getBack()
  if not bpItem then return end

  -- Verifica se já tem uma container com o mesmo itemId da mochila nas costas
  for _, container in pairs(g_game.getContainers()) do
    if container:getContainerItem():getId() == bpItem:getId() then
      return -- Já está aberta, não faz nada
    end
  end

  -- Abre a bag se não estiver aberta
  g_game.open(bpItem)
end

-- Botão manual
UI.Button("Abrir Bag", function()
  openMainBackpack()
end)

-- Abrir ao carregar
openMainBackpack()

-- Verificação automática a cada 2 segundos
macro(2000, function()
  openMainBackpack()
end)



-- IDs das caixas que você quer abrir
local boxIds = {1234, 5678, 13999} -- substitua pelos IDs reais das caixas

-- Tempo entre as verificações (em milissegundos)
local checkInterval = 1000

macro(checkInterval, function()
  local containers = g_game.getContainers()
  for _, container in pairs(containers) do
    for slot, item in pairs(container:getItems()) do
      if table.contains(boxIds, item:getId()) then
        g_game.open(item)
        return -- evita abrir várias caixas de uma vez
      end
    end
  end
end)



-- Macro de ataque apenas para Trainer
local trainerName = "Trainer" -- nome exato do monstro

trainerMacro = macro(1, "Atacar Treiner", function()
  if isInPz() then
    return
  end

  local mob
  for i, val in pairs(getSpectators()) do
    -- Verifica se é monstro, atacável e com nome Trainer
    if val:isMonster() and val:canShoot() and val:getName():lower() == trainerName:lower() then
      mob = val
      break
    end
  end

  if mob then
    if not g_game.isAttacking() or g_game.getAttackingCreature() ~= mob then
      g_game.attack(mob)
    end
  end
end)



--treinar
local config = {
    regen_mana_by_spell = true, -- se o teu regen de mana for por spell, deixe true, se n, false
    regen_mana_spell = 'chakra rest', -- spell p regenerar mana
    regen_mana_by_item = false, -- se o teu regen de mana for por item, deixe true, se n, false
    regen_mana_id_item = 0, -- item p regenerar mana
    percent_train_ml = 90, -- porcentagem que irá intercalar entre regenerar e treinar, < regen > train
    spell_train = 'powerdown', -- spell de treino
    dance_interval = 5, -- tempo em segundos para girar
}

-- Controle da dança
local lastDance = now
local directions = {North, East, South, West}

macro(1000, function()
    local target = g_game.getAttackingCreature()
    if not target or target:getName():lower() ~= "trainer" then
        return -- só funciona contra trainer
    end

    -- Regen / treino
    if manapercent() <= config.percent_train_ml then
        if config.regen_mana_by_item then
            useWith(config.regen_mana_id_item, player)
        elseif config.regen_mana_by_spell then
            say(config.regen_mana_spell)
        end
    else
        say(config.spell_train)
    end

    -- Sistema de dance (girar aleatoriamente)
    if now - lastDance >= config.dance_interval * 1000 then
        local dir = directions[math.random(1, #directions)]
        turn(dir)
        lastDance = now
    end
end)





local _combo = {
    spellCount = 5, -- quantidade de magias
}
storage.uCombo = storage.uCombo or {}

_combo.logic = function()
    local target = g_game.getAttackingCreature()
    if target then
        local targetName = target:getName():lower()
        if targetName ~= "trainer" then
            for index, spell in ipairs(storage.uCombo) do
                if spell and spell ~= "" then
                    say(spell)
                end
            end
        end
    end
end

_combo.macro = macro(100, "Combo", _combo.logic)

for i = 1, _combo.spellCount do
    addTextEdit("id"..i, storage.uCombo[i] or "", function(self, text)
        storage.uCombo[i] = text
    end)
end





















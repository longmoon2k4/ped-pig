

print("[ped-pig] client.lua loaded")

RegisterCommand("spawnpig", function()
    local model = GetHashKey("a_c_pig")
    RequestModel(model)
    local timeout = 0
    while not HasModelLoaded(model) and timeout < 50 do
        Wait(100)
        timeout = timeout + 1
    end
    if not HasModelLoaded(model) then
        print("[ped-pig] Không thể load model a_c_pig. Kiểm tra lại resource và fxmanifest!")
        return
    end
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local ped = CreatePed(28, model, pos.x + 2, pos.y, pos.z, 0.0, true, false)
    if ped == 0 then
        print("[ped-pig] Spawn thất bại! Có thể model chưa đúng hoặc vị trí không hợp lệ.")
    else
        print("[ped-pig] Đã spawn thành công con heo!")
        if not _G.pigPeds then _G.pigPeds = {} end
        table.insert(_G.pigPeds, ped)
    end
end, false)


-- Vòng lặp kiểm tra tương tác với các heo đã spawn
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local found = false
        if _G.pigPeds then
            for i, ped in ipairs(_G.pigPeds) do
                if DoesEntityExist(ped) then
                    local pigCoords = GetEntityCoords(ped)
                    local dist = #(playerCoords - pigCoords)
                    local headPos = nil
                    local boneIndex = GetPedBoneIndex(ped, 31086) -- SKEL_Head
                    if boneIndex and boneIndex ~= -1 then
                        headPos = GetWorldPositionOfEntityBone(ped, boneIndex)
                    end
                    local tx, ty, tz = pigCoords.x, pigCoords.y, pigCoords.z + 1.5
                    if headPos then
                        tx, ty, tz = headPos.x, headPos.y, headPos.z + 0.25
                    end
                    if dist < 30.0 then
                        DrawText3D(tx, ty, tz, "<Font Face = 'Oswald'> HEO Ở ĐÂY </Font>")
                    end
                    if dist < 2.0 then
                        found = true
                        DrawText3D(tx, ty, tz + 0.2, "<Font Face = 'Oswald'> ~g~[E]~w~ Tương tác với con heo </Font>")
                        if IsControlJustReleased(0, 38) then -- phím E
                            TriggerEvent("pedpig:interact", ped)
                        end
                        break
                    end
                end
            end
        end
        if not found then
            Citizen.Wait(500)
        end
    end
end)

-- Hàm vẽ text 3D
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- Sáng tạo: Khi tương tác, cho phép vuốt ve hoặc "nói chuyện" với heo
RegisterNetEvent("pedpig:interact")
AddEventHandler("pedpig:interact", function(ped)
    local options = {
        "Vuốt ve con heo",
        "Nói chuyện với con heo",
        "Cho con heo ăn"
    }
    local choice = math.random(1, #options)
    local msg = options[choice]
    -- Hiển thị thông báo
    TriggerEvent('chat:addMessage', {
        color = { 255, 192, 203 },
        multiline = true,
        args = { "🐷 Heo", msg }
    })
    -- Có thể thêm animation hoặc hiệu ứng ở đây nếu muốn
end)

-- Helper: Enumerator cho tất cả ped
function EnumeratePeds()
    return coroutine.wrap(function()
        local handle, ped = FindFirstPed()
        local success
        repeat
            coroutine.yield(ped)
            success, ped = FindNextPed(handle)
        until not success
        EndFindPed(handle)
    end)
end

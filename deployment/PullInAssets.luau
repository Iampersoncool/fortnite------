local process = require('@lune/process')

local remodel = require("./Remodel.luau")

local ASSET_PLACE_ID = process.env.ASSET_PLACE_ID

local gameWithAssets = remodel.readPlaceAsset(ASSET_PLACE_ID)
local gameWithScripts = remodel.readPlaceFile("./build.rbxl")

local services = { "ReplicatedStorage", "ServerStorage", "Lighting", "StarterGui", "StarterPack" }

for _, service in ipairs(gameWithAssets:GetChildren()) do
	local foundService = table.find(services, service.Name)
  if not foundService then continue end

  for _, childInService in ipairs(service:GetChildren()) do
    if childInService:IsA("Terrain") then continue end

    local serviceName = childInService.Parent.Name
    local serviceObj = gameWithScripts:FindFirstChild(serviceName)

    if serviceObj then
      childInService.Parent = serviceObj
    else
      childInService.Parent = gameWithScripts:GetService(serviceName)
    end

  end

end

remodel.writePlaceFile("build.rbxl", gameWithScripts)

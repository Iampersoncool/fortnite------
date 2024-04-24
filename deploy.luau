local net = require("@lune/net")
local fs = require("@lune/fs")
local process = require("@lune/process")

local remodel = require("./remodel.luau")

local UNIVERSE_ID = process.env.UNIVERSE_ID
local START_PLACE_ID = process.env.START_PLACE_ID
local RBXCLOUDAPI_KEY = process.env.RBXCLOUDAPI_KEY

local gameWithAssets = remodel.readPlaceAsset(17260570236)
local gameWithScripts = remodel.readPlaceFile("build.rbxl")

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



local gameUrl = "https://apis.roblox.com/universes/v1/"..UNIVERSE_ID.."/places/"..START_PLACE_ID.."/versions?versionType=Published"

local response = net.request({
  url = gameUrl,
  method = "POST",
  headers = {
    ["Content-Type"] = "application/octet-stream",
    ["x-api-key"] = RBXCLOUDAPI_KEY,
  },
  body = fs.readFile("build.rbxl")
})

print(response.body)
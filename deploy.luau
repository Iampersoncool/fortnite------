local net = require("@lune/net")
local fs = require("@lune/fs")
local process = require("@lune/process")

local UNIVERSE_ID = process.env.UNIVERSE_ID
local START_PLACE_ID = process.env.START_PLACE_ID
local RBXCLOUDAPI_KEY = process.env.RBXCLOUDAPI_KEY

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
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local TestService = Knit.CreateService { Name = "TestService" }

function TestService:KnitInit()
  print("Service init")
end

function TestService:KnitStart()
  print("Test service started")
end

return TestService

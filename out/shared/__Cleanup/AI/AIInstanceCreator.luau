-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier 
local HttpService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").HttpService
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local partforData = Instance.new("Part")
local AI_Request = GameStorage:getEvent("AI_Request")
local GameObject
local AIInstanceCreator
do
	AIInstanceCreator = setmetatable({}, {
		__tostring = function()
			return "AIInstanceCreator"
		end,
	})
	AIInstanceCreator.__index = AIInstanceCreator
	function AIInstanceCreator.new(...)
		local self = setmetatable({}, AIInstanceCreator)
		return self:constructor(...) or self
	end
	function AIInstanceCreator:constructor()
		self._creations = {}
		self._creationRequestConnection = AI_Request.OnServerEvent:Connect(function(player, ...)
			local args = { ... }
			warn("Creation Request: ", args)
			AIInstanceCreator:CreateInstance(args[1])
		end)
	end
	function AIInstanceCreator:Start()
		if AIInstanceCreator._instance == nil then
			AIInstanceCreator._instance = AIInstanceCreator.new()
		end
		return AIInstanceCreator._instance
	end
	function AIInstanceCreator:CreateInstance(jsonString)
		local gameObject = GameObject.new(jsonString)
		gameObject:createInGame()
	end
end
do
	GameObject = setmetatable({}, {
		__tostring = function()
			return "GameObject"
		end,
	})
	GameObject.__index = GameObject
	function GameObject.new(...)
		local self = setmetatable({}, GameObject)
		return self:constructor(...) or self
	end
	function GameObject:constructor(jsonString)
		self._part = partforData
		local encodedString = HttpService:JSONDecode(jsonString)
		--encodedString.Parent = this._part.Parent; 
		local data = HttpService:JSONEncode(self._part)
		warn("TestPart: ", data)
		warn("EncodedString: ", encodedString)
	end
	function GameObject:createInGame()
		-- Logic to create and manipulate the part in Roblox
	end
end
return {
	AIInstanceCreator = AIInstanceCreator,
	GameObject = GameObject,
}

-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local PositionGenerator = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "PositionGenerator").PositionGenerator
local Workspace = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Workspace
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local ShapeTester
do
	local super = Skill
	ShapeTester = setmetatable({}, {
		__tostring = function()
			return "ShapeTester"
		end,
		__index = super,
	})
	ShapeTester.__index = ShapeTester
	function ShapeTester.new(...)
		local self = setmetatable({}, ShapeTester)
		return self:constructor(...) or self
	end
	function ShapeTester:constructor(...)
		super.constructor(self, ...)
	end
	function ShapeTester:OnConstruct()
		Logger:Log(script, "ShapeTester", "OnConstruct")
	end
	function ShapeTester:OnConstructServer()
	end
	function ShapeTester:OnConstructClient()
	end
	function ShapeTester:OnStartServer()
		--Logger.Log(script,"ShapeTester", "OnStartServer");
		local fire = Instance.new("Fire")
		fire.Size = 3
		fire.Parent = self.Character.Instance
		local firePart = Instance.new("Part")
		firePart.Parent = self.Character.Instance
		fire.Parent = firePart
		firePart.Size = Vector3.new(0.5, 0.5, 0.5)
		firePart.Anchored = true
		local character = self.Character.Instance
		if character == nil then
			Logger:Log(script, "ShapeTester", "No Character Found")
			return nil
		end
		local spiral = PositionGenerator:CreateSpiral(character:GetPivot(), math.pi, 100, 1)
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(position)
			local part = Instance.new("Part")
			local attachment = Instance.new("Attachment")
			attachment.Parent = part
			part.Size = Vector3.new(1, 1, 1)
			part.Position = position
			part.Name = "SpiralPart" .. tostring(position.X) .. tostring(position.Y) .. tostring(position.Z)
			part.Anchored = true
			part.Parent = Workspace:FindFirstChild("JSONParts")
			--wait(0.3);
			part:AddTag("SoulSeeker")
		end
		for _k, _v in spiral do
			_callback(_v, _k - 1, spiral)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function ShapeTester:OnEndServer()
	end
	ShapeTester = SkillDecorator(ShapeTester) or ShapeTester
end
return {
	ShapeTester = ShapeTester,
}

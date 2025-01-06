-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local SkillDefinitions = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Character", "Skills").SkillDefinitions
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local BasicMelee
do
	local super = Skill
	BasicMelee = setmetatable({}, {
		__tostring = function()
			return "BasicMelee"
		end,
		__index = super,
	})
	BasicMelee.__index = BasicMelee
	function BasicMelee.new(...)
		local self = setmetatable({}, BasicMelee)
		return self:constructor(...) or self
	end
	function BasicMelee:constructor(...)
		super.constructor(self, ...)
	end
	function BasicMelee:OnConstruct()
		Logger:Log(script, "- Construct")
		Logger:Log(script, SkillDefinitions.BasicMelee)
	end
	function BasicMelee:OnConstructServer()
		Logger:Log(script, " - Server")
		--this.DamageContainer = new DamageContainer(this, "Melee", 10);
	end
	function BasicMelee:OnConstructClient()
		Logger:Log(script, "- Client")
		local _result = self.Character.Instance
		if _result ~= nil then
			_result = _result:FindFirstChild("Animator", true)
		end
		local animator = _result
		if animator == nil then
			Logger:Log(script, "Animator not found")
			return nil
		end
		local animation = Instance.new("Animation")
		animation.Name = "BasicMelee"
		animation.AnimationId = SkillDefinitions.BasicMelee.animation
		self.animationTrack = animator:LoadAnimation(animation)
	end
	function BasicMelee:OnStartServer()
		Logger:Log(script, "Start Server")
		local _result = self.animationTrack
		if _result ~= nil then
			_result:Play()
		end
	end
	function BasicMelee:OnEndServer()
		Logger:Log(script, "End Server")
	end
	BasicMelee = SkillDecorator(BasicMelee) or BasicMelee
end
return {
	BasicMelee = BasicMelee,
}

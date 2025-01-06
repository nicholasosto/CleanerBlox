-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
--import { SkillDefinitions } from "shared/_References/Skills";
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local SkillDefinitions = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Character", "Skills").SkillDefinitions
local BasicRanged
do
	local super = Skill
	BasicRanged = setmetatable({}, {
		__tostring = function()
			return "BasicRanged"
		end,
		__index = super,
	})
	BasicRanged.__index = BasicRanged
	function BasicRanged.new(...)
		local self = setmetatable({}, BasicRanged)
		return self:constructor(...) or self
	end
	function BasicRanged:constructor(...)
		super.constructor(self, ...)
	end
	function BasicRanged:OnConstruct()
		Logger:Log(script, "BasicRanged Construct")
	end
	function BasicRanged:OnConstructServer()
		Logger:Log(script, "BasicRanged Server")
		--this.DamageContainer = new DamageContainer(this, "Melee", 10);
	end
	function BasicRanged:OnConstructClient()
		Logger:Log(script, "BasicRanged Client")
		local characterModel = self.Character.Instance
		local animator = characterModel:FindFirstChild("Animator", true)
		local animation = Instance.new("Animation")
		animation.Name = "BasicRanged"
		animation.AnimationId = SkillDefinitions.BasicRanged.animation
		self.animationTrack = animator:LoadAnimation(animation)
	end
	function BasicRanged:OnStartClient()
		Logger:Log(script, "BasicRanged Start Client")
		self:playAnimation()
	end
	function BasicRanged:OnStartServer()
		Logger:Log(script, "Start Server", SkillDefinitions.BasicRanged)
	end
	function BasicRanged:OnEndServer()
		Logger:Log(script, "End Server")
	end
	function BasicRanged:playAnimation()
		local _result = self.animationTrack
		if _result ~= nil then
			_result:Play()
		end
	end
	BasicRanged = SkillDecorator(BasicRanged) or BasicRanged
end
return {
	BasicRanged = BasicRanged,
}

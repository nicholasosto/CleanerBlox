-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local StatusEffect = _wcs.StatusEffect
local StatusEffectDecorator = _wcs.StatusEffectDecorator
local Stun
do
	local super = StatusEffect
	Stun = setmetatable({}, {
		__tostring = function()
			return "Stun"
		end,
		__index = super,
	})
	Stun.__index = Stun
	function Stun.new(...)
		local self = setmetatable({}, Stun)
		return self:constructor(...) or self
	end
	function Stun:constructor(...)
		super.constructor(self, ...)
	end
	function Stun:OnStartServer()
		self:SetHumanoidData({
			WalkSpeed = { 0, "Set" },
		})
	end
	Stun = StatusEffectDecorator(Stun) or Stun
end
return {
	Stun = Stun,
}

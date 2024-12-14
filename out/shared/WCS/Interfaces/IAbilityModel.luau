-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local AbilityModel
do
	AbilityModel = setmetatable({}, {
		__tostring = function()
			return "AbilityModel"
		end,
	})
	AbilityModel.__index = AbilityModel
	function AbilityModel.new(...)
		local self = setmetatable({}, AbilityModel)
		return self:constructor(...) or self
	end
	function AbilityModel:constructor(wcsCharacter, templateModel)
		self.AnimationTracks = {}
		self.AudioTracks = {}
		Logger:Log("AbilityModel", " - Ability Model Constructed\n")
		self.Model = templateModel:Clone()
		self.HitPart = self.Model:FindFirstChild("HitPart")
		self.WCSCharacterReference = wcsCharacter
		self.HitConnection = self.HitPart.Touched:Connect(function(hit)
			if hit.Parent == self.WCSCharacterReference.Instance then
				Logger:Log("AbilityModel", " - Hit Self\n")
				return nil
			end
			self:OnHit()
		end)
		return self
	end
	function AbilityModel:Activate(phase)
		repeat
			if phase == 1 then
				Logger:Log("AbilityModel", "\t Phase 1 \n")
				break
			end
			if phase == 2 then
				Logger:Log("AbilityModel", "\t Phase 2 \n")
				break
			end
			if phase == 3 then
				Logger:Log("AbilityModel", "\t Phase 3 \n")
				break
			end
			break
		until true
	end
	function AbilityModel:Cancel()
		Logger:Log("AbilityModel", " - Ability Cancelled\n")
	end
	function AbilityModel:OnEnded()
		-- Do something when the ability ends
		Logger:Log("AbilityModel", " - Ability Ended\n")
	end
	function AbilityModel:OnHit()
		Logger:Log("AbilityModel", " - Ability Hit\n")
		-- Do something when the ability hits
	end
end
return {
	AbilityModel = AbilityModel,
}

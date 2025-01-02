-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local Spotlight
do
	Spotlight = setmetatable({}, {
		__tostring = function()
			return "Spotlight"
		end,
	})
	Spotlight.__index = Spotlight
	function Spotlight.new(...)
		local self = setmetatable({}, Spotlight)
		return self:constructor(...) or self
	end
	function Spotlight:constructor(spotlightModel, owner)
		-- Set the instance
		self.instance = spotlightModel
		-- Set the Attribute "State" to "UNK"
		self.instance:SetAttribute("State", "UNK")
		-- Listen for property changes
		local _result = self.instance.PrimaryPart
		if _result ~= nil then
			_result = _result.Touched:Connect(function(hit)
				return self:handlePartTouched(hit)
			end)
		end
		self.HitConnection = _result
		-- Listen for state changes
		self.StateChangeConnection = self.instance:GetAttributeChangedSignal("State"):Connect(function()
			return self:OnStateChanged()
		end)
		-- Set the State to Idle
		self.instance:SetAttribute("State", "Active")
		return self
	end
	function Spotlight:handlePartTouched(hit)
		local _exp = hit
		local _result = hit
		if _result ~= nil then
			_result = _result.Parent
		end
		Logger:Log(script, "Spotlight", "Toucher", _exp, _result)
	end
	function Spotlight:OnStateChanged()
		--print("State Changed: ", this.instance.GetAttribute("State"));
		local _exp = self.instance:GetAttribute("State")
		repeat
			if _exp == "Active" then
				self:OnActive()
				break
			end
			if _exp == "Triggered" then
				self:OnTriggered()
				break
			end
			if _exp == "Inactive" then
				--print("TODO: Spotlight is Inactive");
				break
			end
			if _exp == "Homing" then
				self:OnHoming()
				break
			end
			if _exp == "Exploding" then
				self:OnExploding()
				break
			end
			break
		until true
	end
	function Spotlight:OnActive()
		Logger:Log(script, "Spotlight", "[State]", self.instance:GetAttribute("State"))
		local primaryPart = self.instance.PrimaryPart
		Logger:Log(script, "Spotlight", "PrimaryPart", primaryPart)
		--const tween = TTweener.tweenPartCFrame(this.instance.PrimaryPart as Part, new CFrame(0, 0, 0), 22);
		--tween.Play();
	end
	function Spotlight:OnTriggered()
		Logger:Log(script, "Spotlight", "[State]", self.instance:GetAttribute("State"))
	end
	function Spotlight:OnHoming()
		Logger:Log(script, "Spotlight", "[State]", self.instance:GetAttribute("State"))
	end
	function Spotlight:OnExploding()
		Logger:Log(script, "Spotlight", "[State]", self.instance:GetAttribute("State"))
	end
	function Spotlight:Destroy()
		local _result = self.HitConnection
		if _result ~= nil then
			_result:Disconnect()
		end
		local _result_1 = self.StateChangeConnection
		if _result_1 ~= nil then
			_result_1:Disconnect()
		end
		self.instance:Destroy()
		--this.Destroy();
	end
end
return {
	Spotlight = Spotlight,
}

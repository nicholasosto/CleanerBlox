-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local WCS = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local GameStorage
do
	GameStorage = setmetatable({}, {
		__tostring = function()
			return "GameStorage"
		end,
	})
	GameStorage.__index = GameStorage
	function GameStorage.new(...)
		local self = setmetatable({}, GameStorage)
		return self:constructor(...) or self
	end
	function GameStorage:constructor()
	end
	function GameStorage:cloneHumanoidDescription(humanoidName)
		-- Get the humanoid from the storage
		local _humanoid = self._humanoidStorage:FindFirstChild(humanoidName, true)
		-- Validate the humanoid
		if _humanoid == nil then
			Logger:Log("GameStorage", `Humanoid {humanoidName} not found in storage.`)
			return nil
		end
		-- Clone the humanoid
		local _clonedHumanoid = _humanoid:Clone()
		Logger:Log("XXX Found", _clonedHumanoid)
		return _clonedHumanoid
	end
	function GameStorage:cloneAccessory(accessoryName)
		-- Get the accessory from the storage
		local _accessory = self._accessoriesStorage:FindFirstChild(accessoryName, true)
		-- Validate the accessory
		if _accessory == nil then
			Logger:Log("GameStorage", `Accessory {accessoryName} not found in storage.`)
			return nil
		end
		-- Clone the accessory
		local _clonedAccessory = _accessory:Clone()
		return _clonedAccessory
	end
	function GameStorage:getEvent(event)
		local _event = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild(event, true)
		if not _event then
			error(`Event {event} not found in storage.`)
		end
		return _event
	end
	function GameStorage:cloneRigCharacter(rigName)
		-- Get the rig from the storage
		local _rig = self._modelsStorage:FindFirstChild(rigName, true)
		-- Validate the rig
		if not _rig then
			self:printAvailableItems(self._modelsStorage)
			error(`Rig {rigName} not found in storage.`)
		end
		-- Clone the rig
		local _clonedRig = _rig:Clone()
		return _clonedRig
	end
	function GameStorage:cloneAnimation(animationName)
		-- Get the animation from the storage
		local _animation = self._animationsStorage:FindFirstChild(animationName, true)
		-- Validate the animation
		if not _animation then
			self:printAvailableItems(self._animationsStorage)
			error(`Animation {animationName} not found in storage.`)
		end
		return _animation:Clone()
	end
	function GameStorage:cloneSound(instanceName, parent)
		-- Get the sound from the storage
		local _sound = self._audioStorage:FindFirstChild(instanceName, true)
		if _sound == nil then
			Logger:Log("GameStorage", `Sound {instanceName} not found in storage.`)
			return nil
		end
		local _clonedSound = _sound:Clone()
		if parent then
			_clonedSound.Parent = parent
		end
		return _clonedSound
	end
	function GameStorage:cloneConfiguration(configurationName)
		-- Get the configuration from the storage
		local _configuration = self._configurationStorage:FindFirstChild(configurationName, true)
		-- Validate the configuration
		if not _configuration then
			self:printAvailableItems(self._configurationStorage)
			error(`Configuration {configurationName} not found in storage.`)
		end
		return _configuration
	end
	function GameStorage:cloneGUIComponent(guiName)
		-- Get the GUI from the storage
		local _gui = self._guiStorage:FindFirstChild(guiName, true)
		-- Validate the GUI
		if not _gui then
			self:printAvailableItems(self._guiStorage)
			error(`GUI {guiName} not found in storage.`)
		end
		return _gui
	end
	function GameStorage:cloneModel(modelName)
		-- Get the model from the storage
		local _model = self._modelsStorage:FindFirstChild(modelName, true)
		-- Validate the model
		if not _model then
			self:printAvailableItems(self._modelsStorage)
			error(`Model {modelName} not found in storage.`)
		end
		return _model:Clone()
	end
	function GameStorage:cloneTool(toolName)
		-- Get the tool from the storage
		local _tool = self._toolsStorage:FindFirstChild(toolName, true)
		-- Validate the tool
		if not _tool then
			self:printAvailableItems(self._modelsStorage)
			error(`Tool {toolName} not found in storage.`)
		end
		return _tool:Clone()
	end
	function GameStorage:cloneParticleGroupAttachment(particleGroupName)
		-- Get the particle group part from the storage
		local _result = self._particlesStorage:FindFirstChild(particleGroupName, true)
		if _result ~= nil then
			_result = _result:Clone()
		end
		local _particleGroupPart = _result
		local _result_1 = _particleGroupPart
		if _result_1 ~= nil then
			_result_1 = _result_1:FindFirstChildWhichIsA("Attachment")
		end
		local _attachment = _result_1
		-- Validate the particle group part
		if not _particleGroupPart then
			self:printAvailableItems(self._particlesStorage)
			error(`Particle Group Part {particleGroupName} not found in storage.`)
		end
		return _attachment
	end
	function GameStorage:printAvailableItems(storage)
		local _items = storage:GetChildren()
		for _, item in _items do
			if item:IsA("Folder") then
				local _exp = item:GetChildren()
				-- ▼ ReadonlyArray.forEach ▼
				local _callback = function(child)
					--print(child.Name);
				end
				for _k, _v in _exp do
					_callback(_v, _k - 1, _exp)
				end
				-- ▲ ReadonlyArray.forEach ▲
			end
			--print(item.Name);
		end
	end
	function GameStorage:createSkillButton(wcsSkill)
		-- Create the skill button
		local skillButton = self:cloneGUIComponent("SkillButton")
		-- skillButton.Name = wcsSkill.GetName();
		-- skillButton.Image = wcsSkill.StateChanged.Connect((state) => {
		-- 	state.StarterParams.
		-- skillButton.Size = new UDim2(0, 50, 0, 50);
		-- skillButton.Position = new UDim2(0, 0, 0, 0);
		-- skillButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		-- skillButton.BackgroundTransparency = 0.5;
		-- Return the skill button
		return skillButton
	end
	function GameStorage:getUniqueModelNameswithinWorkspace()
		local modelNames = {}
		local workspaceModels = game.Workspace:GetChildren()
		for _, model in workspaceModels do
			if model:IsA("Model") then
				local _name = model.Name
				table.insert(modelNames, _name)
			end
		end
		return modelNames
	end
	GameStorage._storageModel = ReplicatedStorage:WaitForChild("SoulSteelStorage")
	GameStorage._accessoriesStorage = GameStorage._storageModel:WaitForChild("ACCESSORIES")
	GameStorage._humanoidStorage = GameStorage._storageModel:WaitForChild("HUMANOID")
	GameStorage._animationsStorage = GameStorage._storageModel:WaitForChild("ANIMATIONS")
	GameStorage._audioStorage = GameStorage._storageModel:WaitForChild("AUDIO")
	GameStorage._configurationStorage = GameStorage._storageModel:WaitForChild("CONFIGURATIONS")
	GameStorage._guiStorage = GameStorage._storageModel:WaitForChild("GUI")
	GameStorage._modelsStorage = GameStorage._storageModel:WaitForChild("MODELS")
	GameStorage._toolsStorage = GameStorage._storageModel:WaitForChild("TOOLS")
	GameStorage._particlesStorage = GameStorage._storageModel:WaitForChild("PARTICLES")
end
return {
	GameStorage = GameStorage,
}

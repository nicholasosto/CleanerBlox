-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
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
	function GameStorage:getAccessory(accessoryName)
		-- Get the accessory from the storage
		local _accessory = self._accessoriesStorage:FindFirstChild(accessoryName, true)
		-- Validate the accessory
		if not _accessory then
			self:printAvailableItems(self._accessoriesStorage)
			error(`Accessory {accessoryName} not found in storage.`)
		end
		return _accessory
	end
	function GameStorage:getAnimation(animationName)
		-- Get the animation from the storage
		local _animation = self._animationsStorage:FindFirstChild(animationName, true)
		-- Validate the animation
		if not _animation then
			self:printAvailableItems(self._animationsStorage)
			error(`Animation {animationName} not found in storage.`)
		end
		return _animation
	end
	function GameStorage:getAudio(audioName)
		-- Get the audio from the storage
		local _audio = self._audioStorage:FindFirstChild(audioName, true)
		-- Validate the audio
		if not _audio then
			self:printAvailableItems(self._audioStorage)
			error(`Audio {audioName} not found in storage.`)
		end
		return _audio
	end
	function GameStorage:getConfiguration(configurationName)
		-- Get the configuration from the storage
		local _configuration = self._configurationStorage:FindFirstChild(configurationName, true)
		-- Validate the configuration
		if not _configuration then
			self:printAvailableItems(self._configurationStorage)
			error(`Configuration {configurationName} not found in storage.`)
		end
		return _configuration
	end
	function GameStorage:getGUI(guiName)
		-- Get the GUI from the storage
		local _gui = self._guiStorage:FindFirstChild(guiName, true)
		-- Validate the GUI
		if not _gui then
			self:printAvailableItems(self._guiStorage)
			error(`GUI {guiName} not found in storage.`)
		end
		return _gui
	end
	function GameStorage:getModel(modelName)
		-- Get the model from the storage
		local _model = self._modelsStorage:FindFirstChild(modelName, true)
		-- Validate the model
		if not _model then
			self:printAvailableItems(self._modelsStorage)
			error(`Model {modelName} not found in storage.`)
		end
		return _model
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
	function GameStorage:cloneModel(modelName)
		local _model = self:getModel(modelName)
		if _model == nil then
			error(`Model {modelName} not found in storage.`)
		end
		return _model:Clone()
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
					print(child.Name)
				end
				for _k, _v in _exp do
					_callback(_v, _k - 1, _exp)
				end
				-- ▲ ReadonlyArray.forEach ▲
			end
			print(item.Name)
		end
	end
	function GameStorage:createSkillButton(wcsSkill)
		-- Create the skill button
		local skillButton = self:getGUI("SkillButton")
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
	GameStorage._storageModel = ReplicatedStorage:WaitForChild("SoulSteelStorage")
	GameStorage._accessoriesStorage = GameStorage._storageModel:WaitForChild("ACCESSORIES")
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

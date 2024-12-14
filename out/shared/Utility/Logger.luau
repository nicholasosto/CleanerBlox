-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local HttpService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").HttpService
-- Note: Utility class for logging
-- LogLevel: Enum for logging levels
local LogLevel = {
	Info = "[Inf]",
	Warn = "[Wrn]",
	Error = "[Err]",
}
-- Logger: Utility class for logging
local Logger
do
	Logger = setmetatable({}, {
		__tostring = function()
			return "Logger"
		end,
	})
	Logger.__index = Logger
	function Logger.new(...)
		local self = setmetatable({}, Logger)
		return self:constructor(...) or self
	end
	function Logger:constructor()
	end
	function Logger:Log(logTag, ...)
		local messages = { ... }
		-- Check if logging is enabled
		if not self._enabled then
			return nil
		end
		-- Log message
		local logMessage = `{self._logLevel}[{logTag}] `
		-- Iterate through messages and log them
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(message)
			local _message = message
			local _exp = typeof(_message)
			repeat
				if _exp == "CFrame" then
					logMessage ..= self:StringifyCFrame(message)
					break
				end
				if _exp == "Vector3" then
					logMessage ..= self:StringifyVector3(message)
					break
				end
				logMessage ..= tostring(message)
			until true
			--logMessage += tostring(message);
		end
		for _k, _v in messages do
			_callback(_v, _k - 1, messages)
		end
		-- ▲ ReadonlyArray.forEach ▲
		-- Log the message to the console
		if self._logLevel == LogLevel.Error then
			warn(logMessage)
		else
			print(logMessage)
		end
	end
	function Logger:StringifyCFrame(cf)
		-- Position
		local pos = cf.Position
		local x = math.round(pos.X * 100) / 100
		local y = math.round(pos.Y * 100) / 100
		local z = math.round(pos.Z * 100) / 100
		-- Orientation
		local lookVector = cf.LookVector
		local lx = math.round(lookVector.X * 100) / 100
		local ly = math.round(lookVector.Y * 100) / 100
		local lz = math.round(lookVector.Z * 100) / 100
		local logMessage = `{self._logLevel}: \n\nCFrame\n================\n Pos: ({x}, {y}, {z})\n Look:({lx}, {ly}, {lz})\n================\n`
		return logMessage
	end
	function Logger:StringifyVector3(vec)
		local x = math.round(vec.X * 100) / 100
		local y = math.round(vec.Y * 100) / 100
		local z = math.round(vec.Z * 100) / 100
		local logMessage = `{self._logLevel}: \n\n Vector3\n================\n Pos: ({x}, {y}, {z})\n================\n`
		return logMessage
	end
	function Logger:SetLogLevel(logLevel)
		self._logLevel = logLevel
	end
	function Logger:EnableLogging(enable)
		self._enabled = enable
	end
	function Logger:LogJSONToScreenUI(player, scriptName, json)
		-- Log the JSON to the console
		warn(json)
		local message = HttpService:JSONEncode(json)
		local playerGui = player:WaitForChild("PlayerGui")
		local Developer = playerGui:WaitForChild("Developer")
		local ScrollingTextFrame = Developer:FindFirstChild("UIConsoleScroller", true)
		local ScriptNameLabel = ScrollingTextFrame:WaitForChild("ScriptName")
		ScriptNameLabel.Text = scriptName
		local TextItem = ScrollingTextFrame:WaitForChild("TextItem")
		TextItem.Text = message
	end
	function Logger:GetInstance()
		return self._logger
	end
	Logger._logger = Logger.new()
	Logger._logLevel = LogLevel.Info
	Logger._enabled = true
end
return {
	LogLevel = LogLevel,
	Logger = Logger,
}

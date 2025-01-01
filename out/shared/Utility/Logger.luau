-- Compiled with roblox-ts v3.0.0
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
		if not self._enabled then
			return nil
		end
		warn(logTag, unpack(messages))
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
	function Logger:GetInstance()
		return self._logger
	end
	function Logger:PrintSkillInfo(skill)
		warn(`Skill: {skill:GetName()}\n`)
		print("Player: ", skill.Player)
		print("Character: ", skill.Character)
		print("Type: ", skill:GetSkillType())
		print("Cooldown Time: ", skill.MetadataChanged)
	end
	function Logger:ErrorLog(logmessage)
		warn("Error_Log: ", logmessage)
	end
	Logger._logger = Logger.new()
	Logger._logLevel = LogLevel.Info
	Logger._enabled = true
	Logger._filterTag = ""
end
return {
	LogLevel = LogLevel,
	Logger = Logger,
}

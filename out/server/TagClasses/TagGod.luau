-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local CollectionService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").CollectionService
local SoulSeaker = TS.import(script, game:GetService("ServerScriptService"), "TS", "TagClasses", "SoulSeeker").SoulSeaker
local ClassTags = {
	SoulEntity = "SoulEntity",
	SoulSeeker = "SoulSeeker",
}
local TagGod
do
	TagGod = setmetatable({}, {
		__tostring = function()
			return "TagGod"
		end,
	})
	TagGod.__index = TagGod
	function TagGod.new(...)
		local self = setmetatable({}, TagGod)
		return self:constructor(...) or self
	end
	function TagGod:constructor()
		-- Soul Seeker Tag
		local soulSeakerAddedConnection = CollectionService:GetInstanceAddedSignal(ClassTags.SoulSeeker):Connect(function(instance)
			print("Soul Seeker Added: ", instance)
		end)
		local soulSeakerRemovedConnection = CollectionService:GetInstanceRemovedSignal(ClassTags.SoulSeeker):Connect(function(instance)
			print("Soul Seeker Removed: ", instance)
			local soulSeeker = SoulSeaker.new(instance)
			print("Soul Seeker: ", soulSeeker)
		end)
		local __tagAddedConnections = TagGod._tagAddedConnections
		local _soulSeeker = ClassTags.SoulSeeker
		__tagAddedConnections[_soulSeeker] = soulSeakerAddedConnection
		local __tagRemovedConnections = TagGod._tagRemovedConnections
		local _soulSeeker_1 = ClassTags.SoulSeeker
		__tagRemovedConnections[_soulSeeker_1] = soulSeakerRemovedConnection
		-- Soul Entity Tag
		local soulEntityAddedConnection = CollectionService:GetInstanceAddedSignal(ClassTags.SoulEntity):Connect(function(instance)
			print("Soul Entity Added: ", instance)
		end)
		local soulEntityRemovedConnection = CollectionService:GetInstanceRemovedSignal(ClassTags.SoulEntity):Connect(function(instance)
			print("Soul Entity Removed: ", instance)
		end)
		local __tagAddedConnections_1 = TagGod._tagAddedConnections
		local _soulEntity = ClassTags.SoulEntity
		__tagAddedConnections_1[_soulEntity] = soulEntityAddedConnection
		local __tagRemovedConnections_1 = TagGod._tagRemovedConnections
		local _soulEntity_1 = ClassTags.SoulEntity
		__tagRemovedConnections_1[_soulEntity_1] = soulEntityRemovedConnection
	end
	function TagGod:Start()
		if self._instance == nil then
			TagGod._instance = TagGod.new()
		end
	end
	TagGod._tagAddedConnections = {}
	TagGod._tagRemovedConnections = {}
end
return {
	ClassTags = ClassTags,
	TagGod = TagGod,
}

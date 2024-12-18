-- Compiled with roblox-ts v3.0.0
local JSONSamples = {
	CubePart = {
		ClassName = "Part",
		Name = "Cube",
		Size = {
			X = 4,
			Y = 4,
			Z = 4,
		},
		Position = {
			X = 0,
			Y = 0,
			Z = 0,
		},
		Color3 = {
			R = 255,
			G = 0,
			B = 0,
		},
		Anchored = true,
		Parent = "Workspace",
		Transparency = 0,
		Material = "Plastic",
		Shape = "Block",
		CanCollide = true,
	},
	Fire = {
		ClassName = "Fire",
		Name = "Fire",
		Size = 3,
		Parent = "Workspace",
		Color3 = {
			R = 255,
			G = 0,
			B = 0,
		},
	},
	Beam = {
		ClassName = "Beam",
		Name = "Beam",
		Parent = "Workspace",
		Color = ColorSequence.new(Color3.new(1, 0, 0)),
		FaceCamera = true,
		LightEmission = 1,
		LightInfluence = 0,
		Segments = 10,
		Attachment0 = "ScriptBlockAttachment",
		Attachment1 = "FireAttachment",
	},
	Motor6D = {
		ClassName = "Motor6D",
		Name = "Motor6D",
		Part0 = "Part0",
		Part1 = "Part1",
		C0 = CFrame.new(),
		C1 = CFrame.new(),
		Parent = "Workspace",
	},
	Attachment = {
		ClassName = "Attachment",
		Name = "Attachment",
		Parent = "Part",
	},
	NPC = {
		ClassName = "NPC",
		Name = "NPC",
		Parent = "Workspace",
		Position = {
			X = 0,
			Y = 0,
			Z = 0,
		},
		Health = 100,
		Damage = 10,
		Speed = 16,
	},
}
return {
	JSONSamples = JSONSamples,
}

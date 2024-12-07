-- Compiled with roblox-ts v3.0.0
local function makeHello(name)
	return `Hello from {name}!`
end
local function makeGoodbye(name)
	return `Goodbye from {name}!`
end
return {
	makeHello = makeHello,
	makeGoodbye = makeGoodbye,
}

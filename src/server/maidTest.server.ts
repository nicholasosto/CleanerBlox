import { Players, Workspace } from "@rbxts/services";
import Maid from "@rbxts/maid";
// Create a Maid instance
const maid = new Maid();

// Add a part to be destroyed later
const part = new Instance("Part");
part.Parent = Workspace;
maid.GiveTask(part);

// Add an event connection to be disconnected
const connection = Players.PlayerAdded.Connect((player) => {
    print(`${player.Name} joined the game.`);
});
maid.GiveTask(connection);

// Add a custom cleanup function
maid.GiveTask(() => {
    print("Custom cleanup function executed!");
});

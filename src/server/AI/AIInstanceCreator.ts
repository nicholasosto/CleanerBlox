/* eslint-disable prettier/prettier */
import { HttpService } from "@rbxts/services";
import { GameStorage } from "shared/Utility/GameStorage";

const partforData: Part = new Instance("Part");
const AI_Request: RemoteEvent = GameStorage.getEvent("AI_Request");


export class AIInstanceCreator  {
	private static _instance: AIInstanceCreator;
	private _creations: Map<string, Instance>;
	private _creationRequestConnection: RBXScriptConnection | undefined;

	constructor() {
		this._creations = new Map<string, Instance>();
		this._creationRequestConnection = AI_Request.OnServerEvent.Connect((player: Player, ...args) => {
			warn("Creation Request: ", args);
			AIInstanceCreator.CreateInstance(args[0] as string);
		});
	}

	public static Start() {
		if (AIInstanceCreator._instance === undefined) {
			AIInstanceCreator._instance = new AIInstanceCreator();
		}
		return AIInstanceCreator._instance;
	}

	public static CreateInstance(jsonString: string) {
		const gameObject = new GameObject(jsonString);
		gameObject.createInGame();
	}
}

export class GameObject {
	private _part: Part;

	constructor(jsonString: string) {
        this._part = partforData;
        const encodedString: Part = HttpService.JSONDecode(jsonString) as Part;
        //encodedString.Parent = this._part.Parent; 
		const data = HttpService.JSONEncode(this._part);
		warn("TestPart: ",data);
        warn("EncodedString: ",encodedString);
	}

	createInGame() {
		// Logic to create and manipulate the part in Roblox
	}
}

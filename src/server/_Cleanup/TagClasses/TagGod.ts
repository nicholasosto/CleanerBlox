import { CollectionService } from "@rbxts/services";
import { SoulSeaker } from "./SoulSeeker";

export enum ClassTags {
	SoulEntity = "SoulEntity",
	SoulSeeker = "SoulSeeker",
}

export class TagGod {
	private static _instance: TagGod;
	private static _tags: Map<string, ClassTags>;
	private static _tagAddedConnections: Map<string, RBXScriptConnection> = new Map<string, RBXScriptConnection>();
	private static _tagRemovedConnections: Map<string, RBXScriptConnection> = new Map<string, RBXScriptConnection>();

	private constructor() {
		// Soul Seeker Tag
		const soulSeakerAddedConnection = CollectionService.GetInstanceAddedSignal(
			ClassTags.SoulSeeker as string,
		).Connect((instance) => {
			print("Soul Seeker Added: ", instance);
		});
		const soulSeakerRemovedConnection = CollectionService.GetInstanceRemovedSignal(ClassTags.SoulSeeker).Connect(
			(instance) => {
				print("Soul Seeker Removed: ", instance);
				const soulSeeker = new SoulSeaker(instance as Part);
				print("Soul Seeker: ", soulSeeker);
			},
		);
		TagGod._tagAddedConnections.set(ClassTags.SoulSeeker, soulSeakerAddedConnection);
		TagGod._tagRemovedConnections.set(ClassTags.SoulSeeker, soulSeakerRemovedConnection);

		// Soul Entity Tag
		const soulEntityAddedConnection = CollectionService.GetInstanceAddedSignal(ClassTags.SoulEntity).Connect(
			(instance) => {
				print("Soul Entity Added: ", instance);
			},
		);
		const soulEntityRemovedConnection = CollectionService.GetInstanceRemovedSignal(ClassTags.SoulEntity).Connect(
			(instance) => {
				print("Soul Entity Removed: ", instance);
			},
		);
		TagGod._tagAddedConnections.set(ClassTags.SoulEntity, soulEntityAddedConnection);
		TagGod._tagRemovedConnections.set(ClassTags.SoulEntity, soulEntityRemovedConnection);
	}

	public static Start() {
		if (this._instance === undefined) {
			TagGod._instance = new TagGod();
		}
	}
}

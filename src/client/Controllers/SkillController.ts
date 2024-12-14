import { Players, ReplicatedStorage } from "@rbxts/services";
import { Logger } from "shared/Utility/Logger";
import { SkillsData } from "shared/Interfaces/IData";
import { Character } from "@rbxts/wcs";
// Events
const event_SkillSlotRequest = ReplicatedStorage.FindFirstChild("SKILL_GetSlots", true) as RemoteEvent;
const event_SkillInventoryRequest = ReplicatedStorage.FindFirstChild("SKILL_GetInventory", true) as RemoteEvent;
const event_AssignSlotRequest = ReplicatedStorage.FindFirstChild("SKILL_AssignSlot", true) as RemoteEvent;

class AbilityButton {
	private _button: TextButton;
	private _skillId: string;
	private _buttonConnection: RBXScriptConnection;
	constructor(button: TextButton, skillId: string) {
		this._button = button;
		this._skillId = skillId;
		this._buttonConnection = button.MouseButton1Down.Connect(() => {
			const character = Character.GetLocalCharacter();
			const wcsSkill = character?.GetSkills().find((skill) => skill.GetName() === this._skillId);
			if (wcsSkill === undefined) {
				Logger.Log("AbilityButton", "wcsSkill: ", this._skillId, " is undefined");
				return;
			}
			wcsSkill.Start();
		});

		this._button.MouseButton1Up.Connect(() => {
			const character = Character.GetLocalCharacter();
			const wcsSkill = character?.GetSkills().find((skill) => skill.GetName() === this._skillId);
			if (wcsSkill === undefined) {
				Logger.Log("AbilityButton", "wcsSkill: ", this._skillId, " is undefined");
				return;
			}
			wcsSkill.Stop();
		});

		return this;
	}
}

export class SkillController {
	// eslint-disable-next-line prettier/prettier
	private static _slotsFrame = Players.LocalPlayer.WaitForChild("PlayerGui").WaitForChild("Action Bar").FindFirstChild("ActionBarSlots",	true) as Frame;
	private static _slotFrames = this._slotsFrame.GetChildren().filter((child) => child.IsA("Frame")) as Array<Frame>;

	private static _skillsInventoryScrollingFrame = Players.LocalPlayer.WaitForChild("PlayerGui").FindFirstChild(
		"SkillInventoryScroller",
		true,
	) as ScrollingFrame;

	private constructor() {}

	public static Start() {
		Logger.Log("C_SkillManager", "Started");
	}

	public static LoadSlot(slotName: string, skillId: string) {
		const slotFrame = this._slotFrames.find((frame) => frame.Name === slotName) as Frame;
		if (slotFrame === undefined) return;

		const contentFrame = slotFrame.FindFirstChild("Content", true) as Frame;
		if (contentFrame === undefined) return;

		const testButton = new Instance("TextButton");
		testButton.Size = new UDim2(1, 0, 1, 0);
		testButton.Text = skillId;
		testButton.Parent = contentFrame;
		new AbilityButton(testButton, skillId);
		event_SkillInventoryRequest.FireServer(Players.LocalPlayer);
	}

	public static _connectionGetSkillSlots = event_SkillSlotRequest.OnClientEvent.Connect((data: SkillsData) => {
		// eslint-disable-next-line prettier/prettier
		const SkillSlotFrame = Players.LocalPlayer.WaitForChild("PlayerGui").FindFirstChild("ActionBarSlots", true) as Frame;

		if (SkillSlotFrame === undefined) return;

		SkillController.LoadSlot("Slot_1", data.Slot_1);
		SkillController.LoadSlot("Slot_2", data.Slot_2);
		SkillController.LoadSlot("Slot_3", data.Slot_3);
		SkillController.LoadSlot("Slot_4", data.Slot_4);
		SkillController.LoadSlot("Slot_5", data.Slot_5);
	});

	// eslint-disable-next-line prettier/prettier
    public static _connectionGetSkillInventory = event_SkillInventoryRequest.OnClientEvent.Connect((data: Array<string>) => {
			SkillController._skillsInventoryScrollingFrame
				.GetChildren()
				.filter((child) => child.IsA("TextButton"))
				.forEach((child) => child.Destroy());
			data.forEach((skillId) => {
				const skillButton = new Instance("TextButton");
				skillButton.Size = new UDim2(1, 0, 0, 50);
				skillButton.Text = skillId;
				skillButton.Parent = SkillController._skillsInventoryScrollingFrame;
				new AbilityButton(skillButton, skillId);
			});
		},
	);
}

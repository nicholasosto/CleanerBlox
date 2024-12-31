// Roblox Services
import { CollectionService, RunService } from "@rbxts/services";

import { GameStorage } from "shared/Utility/GameStorage";
import { Logger } from "shared/Utility/Logger";

export enum EHumanoidDescription {
	RobotBase = "RobotBase",
	DemonBase = "DemonBasee",
	VampireBase = "VampireBase",
	HumanBase = "HumanBase",
	AngelBase = "AngelBase",
	OccultistBase = "OccultistBase",
	WolfForm = "WolfForm",
}

export class HumanoidDescriptionFactory {
	private static _instance: HumanoidDescriptionFactory;

	private static _humanoidDescriptions: Map<EHumanoidDescription, HumanoidDescription> = new Map<
		EHumanoidDescription,
		HumanoidDescription
	>();

	private constructor() {
		// Private constructor to prevent instantiation
		CollectionService.GetInstanceAddedSignal("HDROBOT").Connect((instance) => {
			Logger.Log("HumanoidDescriptionFactory", `Instance added: ${instance.Name}`);
			const humanoid = instance.FindFirstChildOfClass("Humanoid");
			if (humanoid === undefined) {
				Logger.Log("HumanoidDescriptionFactory", `Humanoid not found in instance.`);
				return;
			}
			const humanoidDescription = humanoid.GetAppliedDescription();
			if (humanoidDescription === undefined) {
				Logger.Log("HumanoidDescriptionFactory", `Humanoid cache not found in storage.`);
				return;
			}
			HumanoidDescriptionFactory.ApplyHumanoidDescription(humanoid, EHumanoidDescription.RobotBase);
		});


        CollectionService.GetInstanceAddedSignal("WolfForm").Connect((instance) => {
			Logger.Log("XXXHumanoidDescriptionFactory", `Instance added: ${instance.Name}`);
			const humanoid = instance.FindFirstChildOfClass("Humanoid");
			if (humanoid === undefined) {
				Logger.Log("XXXHumanoidDescriptionFactory", `Humanoid not found in instance.`);
				return;
			}
			const humanoidDescription = humanoid.GetAppliedDescription();
			if (humanoidDescription === undefined) {
				Logger.Log("XXXHumanoidDescriptionFactory", `Humanoid cache not found in storage.`);
				return;
			}
			HumanoidDescriptionFactory.ApplyHumanoidDescription(humanoid, EHumanoidDescription.WolfForm);
		});
		this.LoadBaseHumanoidDescriptions();
		return this;
	}

	public static getInstance(): HumanoidDescriptionFactory {
		if (HumanoidDescriptionFactory._instance === undefined) {
			HumanoidDescriptionFactory._instance = new HumanoidDescriptionFactory();
		}

		return HumanoidDescriptionFactory._instance;
	}

	private LoadBaseHumanoidDescriptions(): void {
		HumanoidDescriptionFactory.setHumanoidDescription(EHumanoidDescription.RobotBase);
		HumanoidDescriptionFactory.setHumanoidDescription(EHumanoidDescription.DemonBase);
		HumanoidDescriptionFactory.setHumanoidDescription(EHumanoidDescription.VampireBase);
		HumanoidDescriptionFactory.setHumanoidDescription(EHumanoidDescription.HumanBase);
		HumanoidDescriptionFactory.setHumanoidDescription(EHumanoidDescription.AngelBase);
		HumanoidDescriptionFactory.setHumanoidDescription(EHumanoidDescription.OccultistBase);
        HumanoidDescriptionFactory.setHumanoidDescription(EHumanoidDescription.WolfForm);
	}

	public static getHumanoidDescription(humanoidDescription: EHumanoidDescription): HumanoidDescription {
		return HumanoidDescriptionFactory._humanoidDescriptions.get(humanoidDescription) as HumanoidDescription;
	}

	public static setHumanoidDescription(hdName: EHumanoidDescription): void {
		const humanoidDescription = GameStorage.cloneHumanoidDescription(hdName);
		if (humanoidDescription === undefined) {
			Logger.Log("HumanoidDescriptionFactory", `Humanoid ${hdName} not found in storage.`);
			return;
		}

		HumanoidDescriptionFactory._humanoidDescriptions.set(hdName, humanoidDescription);
	}

	public static ApplyHumanoidDescription(humanoid: Humanoid, hdName: EHumanoidDescription): void {
		const humanoidDescription = HumanoidDescriptionFactory.getHumanoidDescription(hdName);
		const currenctDescription = humanoid.GetAppliedDescription();
		if (currenctDescription === undefined) {
			Logger.Log("HumanoidDescriptionFactory", `Humanoid cache not found in storage.`);
		}
		if (humanoidDescription === undefined) {
			Logger.Log("HumanoidDescriptionFactory", `Humanoid ${hdName} not found in storage.`);
			return;
		}

		humanoid.ApplyDescription(humanoidDescription);
	}
}

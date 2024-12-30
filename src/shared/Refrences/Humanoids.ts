import { GameStorage } from "shared/Utility/GameStorage";
import { Logger } from "shared/Utility/Logger";

export enum EHumanoidDescription {
	RobotBase = "RobotBase",
	DemonBase = "DemonBasee",
	VampireBase = "VampireBase",
	HumanBase = "HumanBase",
	AngelBase = "AngelBase",
	OccultistBase = "OccultistBase",
}

export class HumanoidDescriptionFactory {
	private static _instance: HumanoidDescriptionFactory;
	private static _humanoidDescriptions: Map<EHumanoidDescription, HumanoidDescription> = new Map<
		EHumanoidDescription,
		HumanoidDescription
	>();

	private constructor() {
		// Private constructor to prevent instantiation
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

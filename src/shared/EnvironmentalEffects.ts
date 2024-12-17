import { TweenService, CollectionService } from "@rbxts/services";

const FogTextureTweenInfo = new TweenInfo(10, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out, -1, true, 0);

export enum EnumEnvironmentalEffects {
    Fog = "Fog",
    Portal = "Portal",
    Rain = "Rain",
    Snow = "Snow",
}

export class EnvironmentGod {
    public static _godInstance: EnvironmentGod;


    private constructor() {
        // Singleton
    }

    public static Summon(): EnvironmentGod {
        if (!this._godInstance) {
            this._godInstance = new EnvironmentGod();
        }

        return this._godInstance;
    }
}
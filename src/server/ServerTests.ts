import { Logger } from "shared/Utility/Logger";
import { HomingSphere, HSState } from "../shared/Skill Parts/HomingSphere";
import { CollectionService } from "@rbxts/services";


export class ServerTests {
    private constructor() {}

    public static TestHomingSphere() {
        // Initialize the HomingSphere listener
        CollectionService.GetInstanceAddedSignal("HomingSphere").Connect((instance) => {
            Logger.Log(`HomingSphere tagged: ${instance.Name}`);
            const homingSphere = new HomingSphere(instance as Model);
            homingSphere.transitionTo(HSState.Searching);
        });

        // Handle existing instances already tagged with "HomingSphere"
        CollectionService.GetTagged("HomingSphere").forEach((instance) => {
            Logger.Log(`Existing HomingSphere found: ${instance.Name}`);
            const homingSphere = new HomingSphere(instance as Model);
            homingSphere.transitionTo(HSState.Searching);
        });
    }
}
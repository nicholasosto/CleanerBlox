import { Skill, SkillDecorator, Message } from "@rbxts/wcs";
import { Stun } from "shared/WCS/StatusEffects/Stun";

@SkillDecorator
export class Dash extends Skill {
	@Message({
		Type: "Event",
		Destination: "Client",
	})
	protected updateCooldown() {
		//Logger.Log`Cooldown updated. ${this.GetDebounceEndTimestamp()}`);
	}
	public OnStartServer() {
		const stun = new Stun(this.Character);
		this.ApplyCooldown(5);
		stun.Start(1);
		this.updateCooldown();
		// Logger.Log(script,"Hi, dash just started!");
	}
}

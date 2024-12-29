export interface IState {
	// Called when we enter this state
	onEnter(previousState: IState | undefined): void;

	// Called every frame or at a fixed interval to update state logic
	onUpdate(dt: number): void;

	// Called when exiting this state
	onExit(nextState: IState): void;

	name: string;
}

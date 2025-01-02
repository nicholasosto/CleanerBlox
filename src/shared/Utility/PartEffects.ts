import { RunService, TweenService } from "@rbxts/services";

export function rotatePart(part: BasePart, duration: number) {
	const initialCFrame = part.CFrame;
	const goalCFrame = initialCFrame.mul(CFrame.Angles(0, math.pi * 2, 0));
	const tweenInfo = new TweenInfo(duration);
	const tween = TweenService.Create(part, tweenInfo, { CFrame: goalCFrame });

	tween.Play();
	tween.Completed.Connect(() => {
		part.CFrame = initialCFrame;
		tween.Destroy();
	});

	// Remove the RenderStepped connection code
}

export function rotateModel(model: Model, duration: number) {
	//Logger.Log(script,"Rotating model: ", model.Name, " for ", duration, " seconds");
	const primaryPart = model.PrimaryPart;
	if (!primaryPart) {
		warn("Model does not have a PrimaryPart set.");
		return;
	}

	const goalCFrame = primaryPart.CFrame.mul(CFrame.Angles(0, math.pi * 2, 0));
	const rotatedCFrame = new CFrame(primaryPart.Position, new Vector3(350, 0, 0));
	const tweenInfo = new TweenInfo(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true);
	const tween = TweenService.Create(primaryPart, tweenInfo, { CFrame: rotatedCFrame });

	return tween;
}

// generate a random search path for the model based on the search distance and number of positions
export function randomSearch(model: Model, numPositions: number, searchDistance: number, duration: number) {
	for (let i = 0; i < numPositions; i++) {
		const position = new Vector3(
			math.random(-searchDistance, searchDistance),
			0,
			math.random(-searchDistance, searchDistance),
		);

		const goalCFrame = new CFrame(model.GetPivot().Position).mul(new CFrame(position));
		const tweenInfo = new TweenInfo(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true);
		if (model.PrimaryPart) {
			const tween = TweenService.Create(model.PrimaryPart, tweenInfo, { CFrame: goalCFrame });
			return tween;
		} else {
			warn("Model does not have a PrimaryPart set.");
		}
	}
}

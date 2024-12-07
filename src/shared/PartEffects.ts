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
    print("Rotating model: ", model.Name, " for ", duration, " seconds");
	const primaryPart = model.PrimaryPart;
	if (!primaryPart) {
		warn("Model does not have a PrimaryPart set.");
		return;
	}

	const initialCFrames = new Map<BasePart, CFrame>();
	model.GetDescendants().forEach((descendant) => {
		if (descendant.IsA("BasePart")) {
			initialCFrames.set(descendant, descendant.CFrame);
		}
	});

	const goalCFrame = primaryPart.CFrame.mul(CFrame.Angles(0, math.pi * 2, 0));
	const tweenInfo = new TweenInfo(duration);
	const tween = TweenService.Create(primaryPart, tweenInfo, { CFrame: goalCFrame });

	tween.Play();
	tween.Completed.Connect(() => {
		initialCFrames.forEach((cf, part) => {
			part.CFrame = cf;
		});
		tween.Destroy();
	});

	// Remove the RenderStepped connection code
}

// ...existing code...

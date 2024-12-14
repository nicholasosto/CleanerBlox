import { CreateMoveset } from "@rbxts/wcs";

import { Spotlights } from "../Skills/Spotlights";
import { BigRed } from "../Skills/BigRed";
import { DevilBeam } from "../Skills/DevilBeam";

export const DefaultMoveset = CreateMoveset("DefaultMoveset", [Spotlights, BigRed, DevilBeam]);

import { CreateMoveset } from "@rbxts/wcs";

import { BasicMelee } from "../Skills/BasicMelee";
import { BasicHold } from "../Skills/BasicHold";
import { BasicRanged } from "../Skills/BasicRanged";

export const DefaultMoveset = CreateMoveset("DefaultMoveset", [BasicMelee, BasicRanged, BasicHold]);

import { CreateMoveset } from "@rbxts/wcs";

import { Attack } from "../Skills/Attack";
import { Block } from "../Skills/Block";
import { Dash } from "../Skills/Dash";
import { Spotlights } from "../Skills/Spotlights";

export const DefaultMoveset = CreateMoveset("DefaultMoveset", [Attack, Block, Dash, Spotlights]);

import { CreateMoveset } from "@rbxts/wcs";

import { Attack } from "shared/Skills/Attack";
import { Block } from "shared/Skills/Block";
import { Dash } from "shared/Skills/Dash";
import { Spotlights } from "shared/Skills/Spotlights";

export const DefaultMoveset = CreateMoveset("DefaultMoveset", [Attack, Block, Dash, Spotlights]);

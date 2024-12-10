import { CreateMoveset } from "@rbxts/wcs";

import { Attack } from "../Skills/Attack";
import { Block } from "../Skills/Block";
import { Dash } from "../Skills/Dash";
import { Spotlights } from "../Skills/Spotlights";
import { BigRed } from "../Skills/BigRed";

export const DefaultMoveset = CreateMoveset("DefaultMoveset", [Attack, Block, Dash, Spotlights, BigRed]);

import { CreateMoveset } from "@rbxts/wcs";

//import { Spotlights } from "../Skills/Spotlights";
//import { BigRed } from "../Skills/BigRed";
import { BasicMelee } from "../Skills/BasicMelee";
import { BasicHold } from "../Skills/BasicHold";

export const DefaultMoveset = CreateMoveset("DefaultMoveset", [BasicMelee, BasicHold]);

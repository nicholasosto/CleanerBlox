import { CreateMoveset } from "@rbxts/wcs";

//import { Spotlights } from "../Skills/Spotlights";
//import { BigRed } from "../Skills/BigRed";
import { BasicMelee } from "../Skills/BasicMelee";
import { BasicHold } from "../Skills/BasicHold";
import { ShapeTester } from "../Skills/ShapeTester";

export const DefaultMoveset = CreateMoveset("DefaultMoveset", [ShapeTester,BasicMelee, BasicHold]);

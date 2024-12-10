import { AttributeLabel } from "./AttributeLabel";
import { AbilityButton } from "./AbilityButton";

export const ColorGradients = {
    Rust: new ColorSequence(new Color3(0.6, 0.2, 0.2), new Color3(0.8, 0.4, 0.4)),
    Blue: new ColorSequence(new Color3(0.2, 0.2, 0.6), new Color3(0.4, 0.4, 0.8)),
    Mana: new ColorSequence(new Color3(0.2, 0.6, 0.6), new Color3(0.4, 0.8, 0.8)),
    Stamina: new ColorSequence(new Color3(0.6, 0.6, 0.2), new Color3(0.8, 0.8, 0.4)),
    Experience: new ColorSequence(new Color3(0.6, 0.2, 0.6), new Color3(0.8, 0.4, 0.8)),
    Modern: new ColorSequence(new Color3(0.2, 0.6, 0.2), new Color3(0.4, 0.8, 0.4)),
    Snazzy: new ColorSequence(new Color3(0.6, 0.6, 0.6), new Color3(0.8, 0.8, 0.8)),
};

export const AttributeLabels = {
    Strength: new AttributeLabel("Str:", "Strength"),
    Speed: new AttributeLabel("Spd:", "Speed"),
    Dexterity: new AttributeLabel("Dex:", "Dexterity"),
    Intelligence: new AttributeLabel("Int:", "Intelligence"),
    Constitution: new AttributeLabel("Con:", "Constitution"),
    Level: new AttributeLabel("Lvl:", "Level"),
    Experience: new AttributeLabel("Exp:", "Experience"),
    ExperienceToNextLevel: new AttributeLabel("ExpTNL:", "ExperienceToNextLevel"),
    MaxHealth: new AttributeLabel("MaxHP:", "MaxHealth"),
    MaxMana: new AttributeLabel("MaxMP:", "MaxMana"),
    MaxStamina: new AttributeLabel("MaxSP:", "MaxStamina"),

};

export const AbilityButtons = {
    Spotlights: new AbilityButton("Sky Crusher", "Spotlights","rbxassetid://82703415014111"),
    BigRed: new AbilityButton("Big Red", "BigRed","rbxassetid://108246514585300"),
};

export const ToggleButtons = {
    Todo: "Implement Toggle Buttons",
};

export const Inventory = {
    Todo: "Implement Inventory",
};

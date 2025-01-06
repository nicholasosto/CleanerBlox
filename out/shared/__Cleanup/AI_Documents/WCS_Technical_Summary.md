# WCS Package Technical Summary

## Character

The `Character` module represents entities within the game world. It handles attributes such as health, movement, skills, and status effects. It provides methods to manage the character's abilities and interactions.

### Example

```typescript
import { Character } from "@rbxts/wcs";

// Create a new character instance
const character = new Character(characterInstance);

// Apply a moveset to the character
character.ApplyMoveset("WarriorMoveset");

// Add a status effect to the character
character.AddStatusEffect(new ShieldStatusEffect());
```

## Client

The `Client` module manages client-side operations, including input handling, UI updates, and communication with the server.

## Server

The `Server` module oversees server-side logic, managing game state, processing client requests, and maintaining synchronization between clients.

## Skill

The `Skill` module defines abilities or actions that a `Character` can perform. It includes execution logic and effect handling.

### Use Case

A `Skill` can be used to implement a character's special ability, such as a dash maneuver or a projectile attack.

### Example

```typescript
import { Skill } from "@rbxts/wcs";

// Define a new skill called DashSkill
class DashSkill extends Skill {
    execute() {
        // Logic to move the character forward quickly
        this.character.moveForward(10);
    }
}

// Register the skill
RegisterSkill("DashSkill", DashSkill);
```

## HoldableSkill

The `HoldableSkill` module extends `Skill` to support abilities that can be held or charged, managing duration and release mechanics.

### Example

```typescript
import { HoldableSkill } from "@rbxts/wcs";

class ChargeSkill extends HoldableSkill {
    constructor(character) {
        super(character);
        this.SetMaxHoldTime(5); // Set maximum hold time to 5 seconds
    }

    execute() {
        // Execute the skill based on hold duration
        const chargeTime = this.HoldTimer.GetTime();
        // Perform action with power proportional to chargeTime
    }
}

// Register the holdable skill
RegisterHoldableSkill("ChargeSkill", ChargeSkill);
```

## MoveSet

The `MoveSet` module organizes and manages a collection of `Skill` instances for a `Character`, allowing for dynamic skill assignment.

### Example

```typescript
import { CreateMoveset } from "@rbxts/wcs";

// Define a new moveset with skills
const warriorMoveset = CreateMoveset("WarriorMoveset", [DashSkill, ChargeSkill]);

// Apply moveset to character
character.ApplyMoveset(warriorMoveset);
```

## Message

The `Message` module facilitates communication between the client and server, defining message formats and handling data transmission.

### Example

```typescript
import { Message } from "@rbxts/wcs";

class ChatService {
    @Message({ Destination: "Server", Type: "Event" })
    sendChatMessage(message: string) {
        // Handle sending chat message to server
    }
}
```

## SkillDecorator

The `SkillDecorator` module applies additional functionality to `Skill` instances, implementing the decorator pattern to enhance or modify skills.

## StatusEffect

The `StatusEffect` module manages temporary effects applied to `Character` instances, such as buffs or debuffs that alter attributes like strength or speed.

### Example

```typescript
import { StatusEffect } from "@rbxts/wcs";

class ShieldStatusEffect extends StatusEffect {
    onStart() {
        // Increase character's defense
        this.character.Defense += 10;
    }

    onEnd() {
        // Revert defense increase
        this.character.Defense -= 10;
    }
}

// Register the status effect
RegisterStatusEffect("ShieldStatusEffect", ShieldStatusEffect);
```

## RegisterStatusEffect

The `RegisterStatusEffect` module provides functionality to define and register custom status effects within the game, allowing for extensible effect management.

### Example

```typescript
import { RegisterStatusEffect } from "@rbxts/wcs";

// Register a new status effect
RegisterStatusEffect("ShieldStatusEffect", ShieldStatusEffect);
```

## RegisterSkill

The `RegisterSkill` module allows developers to create and register new `Skill` types, facilitating the expansion of character abilities.

### Example

```typescript
import { RegisterSkill } from "@rbxts/wcs";

// Register a new skill
RegisterSkill("DashSkill", DashSkill);
```

## RegisterHoldableSkill

The `RegisterHoldableSkill` module enables the registration of new `HoldableSkill` variants, supporting skills that require charging or holding mechanisms.

### Example

```typescript
import { RegisterHoldableSkill } from "@rbxts/wcs";

// Register a new holdable skill
RegisterHoldableSkill("ChargeSkill", ChargeSkill);
```

## DefineMessage

The `DefineMessage` module is used to define new message formats for client-server communication, ensuring consistent data exchange protocols.

### Example

```typescript
import { Message } from "@rbxts/wcs";

class PlayerActions {
    @Message({ Destination: "Server", Type: "Event" })
    performAction(actionName: string) {
        // Send action to server
    }
}
```

## SkillType

`SkillType` is an enumeration that categorizes skills, typically used to distinguish between different skill behaviors or activation methods.

### Example

```typescript
import { SkillType } from "@rbxts/wcs";

if (mySkill.type === SkillType.Passive) {
    // Handle passive skill
}
```

## FlagWithData

The `FlagWithData` module handles flags associated with additional data, useful for tracking complex states or conditions within the system.

### Example

```typescript
import { FlagWithData } from "@rbxts/wcs";

// Create a new flag with data
const stunFlag = new FlagWithData("Stunned", { duration: 2 });

// Apply flag to character
character.applyFlag(stunFlag);

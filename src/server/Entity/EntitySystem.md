# Technical Documentation: Entity System

This document provides an overview of the entity system implemented in the provided TypeScript files for a Roblox game project. The entity system includes interfaces, classes, and utilities that define and manage entities, their attributes, attachments, resources, and behaviors within the game world.

## Table of Contents

- [Interfaces](#interfaces)
  - [IAttachments](#iattachments)
  - [IEntity](#ientity)
- [Implementations](#implementations)
  - [EntityResource](#entityresource)
  - [EntityAttachments](#entityattachments)
  - [BaseEntity](#baseentity)
- [Utilities](#utilities)
  - [EntityCalculator](#entitycalculator)
  - [EntityManager](#entitymanager)
- [Enums](#enums)
- [Conclusion](#conclusion)

## Interfaces


### IAttachments

**File:** `Interfaces/IAttachments.ts`

Specifies attachment points on an entity's character model:

- **Head attachments:** Head, Halo, Body.
- **Hand attachments:** LeftHand, RightHand.
- **Foot attachments:** LeftFoot, RightFoot.
- **Other attachments:** Floor.

### IEntity

**File:** `Interfaces/Interfaces.ts`

Describes the structure and behavior of an entity:

**Properties:**

- **Id:** Unique identifier for the entity.
- **Name:** Name of the entity.
- **Type:** Type of entity (e.g., Player, Mob).
- **State:** Current state (e.g., Idle, Attacking).
- **Attributes:** An instance of `IEntityAttributes`.
- **Attachments:** An instance of `IAttachments`.
- **WCSCharacter:** Reference to the entity's character in the Weapon Combat System.

**Methods:**

- Actions such as `MoveTo`, `Attack`, `Die`, `Interact`, `Cast`, `Equip`, `Unequip`, `Use`.
- Stat management methods like `LevelUp`, `GainExperience`, `TakeDamage`, `Heal`, `RestoreMana`, `RestoreStamina`.

## Implementations

### EntityResource

**File:** `Implementation/EntityResource.ts`

Manages a specific resource for an entity (e.g., Health, Mana, Stamina).

**Properties:**

- **Entity:** The entity instance.
- **Name:** Name of the resource.
- **MaxValue:** Maximum value of the resource.
- **CurrentValue:** Current value of the resource.
- **RegenRate:** Rate at which the resource regenerates.
- **RegenAmount:** Amount regenerated each tick.
- **RegenActive:** Whether regeneration is active.
- Attribute names for syncing with the entity's attributes.

**Methods:**

- Private `_regenStep()`: Handles regeneration logic each tick.
- `onResourceChange()`: Callback triggered when the resource value changes.
- `assignOnMinChange(callback)`: Assigns a callback for minimum value changes.
- `assignOnMaxChange(callback)`: Assigns a callback for maximum value changes.
- `startRegen()`: Activates regeneration.
- `stopRegen()`: Deactivates regeneration.
- `BindToEntity(entity)`: Binds the resource to a specific entity.
- `Destroy()`: Cleans up connections and resources.

### EntityAttachments

**File:** `Implementation/EntityAttachment.ts`

Implements the `IAttachments` interface by initializing attachments on an entity's character model.

**Constructor:**

- Accepts a character model and assigns attachment points by finding them within the model.

### BaseEntity

**File:** `Implementation/Entity.ts`

Represents a base class for all entities, providing common properties and behaviors.

**Properties:**

- **CharacterModel:** The Roblox model representing the entity.
- **WCS_Character:** The character instance from the Weapon Combat System (WCS).
- **EntityAttachments:** Manages the entity's attachments.
- **StatsData:** Core stats including Level, Strength, Dexterity, Intelligence, Constitution, Speed.
- **Resources:** Health, Mana, Stamina as instances of `EntityResource`.
- **MaxHealth, MaxMana, MaxStamina:** Calculated maximum values for resources.
- **Target:** The current target of the entity.

**Methods:**

- `updateAttributes()`: Updates attributes and recalculates max values based on stats.
- `setTarget(target)`: Sets another entity as the target.
- `Destroy()`: Cleans up resources and destroys the entity instance.

**Constructor:**

- Accepts a rig model and initializes the entity, including character setup, attachments, attributes, and resource management.

## Utilities

### EntityCalculator

**File:** `Implementation/EntityCalculator.ts`

Provides utility functions to calculate entity stats:

- `calculateMaxHealth(level, Constitution)`: Calculates maximum health.
- `calculateMaxMana(level, Intelligence)`: Calculates maximum mana.
- `calculateMaxStamina(level, Speed)`: Calculates maximum stamina.
- `calculateExperienceToNextLevel(level)`: Determines experience required to reach the next level.

### EntityManager

**File:** `EntityManager.ts`

Manages all entities within the game environment.

**Properties:**

- Static `_entities`: A map storing entities by name.
- Static `_instance`: Singleton instance of `EntityManager`.
- Static `_connectionCharacterAdded`: Connection to player character additions.

**Methods:**

- `Start()`: Initializes the `EntityManager` and sets up event listeners for player additions.
- `CreateEntity(rig)`: Creates a new `BaseEntity` from a character rig.
- `GetEntity(name)`: Retrieves an entity by name.
- `RemoveEntity(name)`: Removes an entity from the manager.

**Constructor:**

- Sets up connections to handle new players and their character additions, creating entities accordingly.

## Enums

**File:** `Data/Enums.ts`

Defines enumerated types for entity states and types.

**EntityStates:**

- Possible states an entity can be in, such as Idle, Walking, Running, Attacking, Casting, Dead, Interacting.

**EntityTypes:**

- Classification of entity types, including Player, Mob, Boss, Wildlife, Pet, Shopkeeper, QuestGiver.

## Conclusion

The entity system provides a comprehensive framework for managing game entities in a Roblox project. It defines clear interfaces for entity attributes and attachments, implements robust classes for resource management and entity behaviors, and includes utilities for stat calculations and entity management. This modular design facilitates scalability and maintainability, allowing for easy expansion and customization of game entities.

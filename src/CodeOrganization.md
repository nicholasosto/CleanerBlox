# Game Organization
    
## Environment

1. Roblox Game Development
2. Typescript development language
3. Visual Studio Code

```txt

project-root/
├─ src/
│  ├─ client/
│  │  ├─ controllers/
│  │  │  ├─ CameraController.ts
│  │  │  ├─ InputController.ts
│  │  │  └─ UIController.ts
│  │  ├─ ui/
│  │  │  ├─ InventoryUI.tsx
│  │  │  ├─ QuestLogUI.tsx
│  │  │  └─ SkillTreeUI.tsx
│  │  └─ main.client.ts
│  │
│  ├─ server/
│  │  ├─ services/
│  │  │  ├─ DataService.ts
│  │  │  ├─ NPCService.ts
│  │  │  ├─ WorldService.ts
│  │  │  └─ CombatService.ts
│  │  ├─ systems/
│  │  │  ├─ DamageSystem.ts
│  │  │  ├─ DropTableSystem.ts
│  │  │  ├─ LevelingSystem.ts
│  │  │  └─ QuestSystem.ts
│  │  ├─ main.server.ts
│  │
│  ├─ shared/
│  │  ├─ models/
│  │  │  ├─ Character.ts
│  │  │  ├─ Enemy.ts
│  │  │  ├─ NPC.ts
│  │  │  ├─ PlayerCharacter.ts
│  │  │  ├─ Weapon.ts
│  │  │  └─ Ability.ts
│  │  ├─ constants/
│  │  │  ├─ ItemRarity.ts
│  │  │  ├─ QuestTypes.ts
│  │  │  └─ StatNames.ts
│  │  ├─ interfaces/
│  │  │  ├─ ICharacter.ts
│  │  │  ├─ IWeapon.ts
│  │  │  ├─ IQuest.ts
│  │  │  └─ IAbility.ts
│  │  ├─ utilities/
│  │  │  ├─ Logger.ts
│  │  │  ├─ MathHelpers.ts
│  │  │  ├─ TableUtils.ts
│  │  │  └─ RNG.ts
│  │  └─ data/
│  │     ├─ WeaponData.ts
│  │     ├─ EnemyData.ts
│  │     ├─ AbilityData.ts
│  │     └─ QuestData.ts
│  │
│  ├─ index.ts
│
├─ tests/
│  ├─ Character.spec.ts
│  ├─ Weapon.spec.ts
│  ├─ QuestSystem.spec.ts
│  └─ CombatService.spec.ts
│
├─ typings/
│  └─ customtypes.d.ts
│
├─ package.json
├─ tsconfig.json
└─ README.md
```

## Testing Checklists

### Server

1. ``` DataManager ``` - Data Loads correctly from the Datastore 
2. ``` PlayerConfiguration ``` Player Instance is modified to work in the game world
    1. ``` Attributes ``` , ``` Configurations ``` are added and configured.
3. Equipment Checks
4. Skill Checks
5. Inventory Checks
6. Attribute Values check
7. Data Save Check

### Client

1. UI Checks
    - ProgressBars
    - UI Lists and Grids
    - Panel Loading
    - Button Events

2. Motion Checks
    - Flight
    - Dashing
    - Sprinting
3. Notifications Check
4. Teleoport Checks

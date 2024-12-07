// PartCreator.ts
export class PartCreator {
    private part: Part;

    constructor(name: string, position: Vector3, size: Vector3, color: Color3) {
        this.part = new Instance("Part");
        this.part.Name = name;
        this.part.Position = position;
        this.part.Size = size;
        this.part.Color = color;
        this.part.Anchored = true;
        this.part.Parent = game.Workspace;
    }

    // Function to set a new position for the part
    public setPosition(newPosition: Vector3): void {
        this.part.Position = newPosition;
    }

    // Function to change the size of the part
    public setSize(newSize: Vector3): void {
        this.part.Size = newSize;
    }

    // Function to change the color of the part
    public setColor(newColor: Color3): void {
        this.part.Color = newColor;
    }

    // Function to delete the part
    public deletePart(): void {
        this.part.Destroy();
    }

    // Function to get the instance of the part
    public getPart(): Part {
        return this.part;
    }
}
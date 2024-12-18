

export class SoulSeaker {
    public _part: Part;
    private _fire: Fire = new Instance("Fire") as Fire;
    constructor(part: Part) {
        this._fire.Size = 3;
        this._fire.Parent = part;
        this._fire.Heat = 10;
        this._fire.Color = Color3.fromRGB(255, 0, 0);
        this._part = part;
        this._fire.Parent = this._part;
        return this;
    }
}
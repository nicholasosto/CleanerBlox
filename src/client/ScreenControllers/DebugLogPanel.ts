import { Players } from "@rbxts/services";
import { Logger, Printable } from "shared/Utility/Logger";

export class DebugLogPanel {
    private _screenGui: ScreenGui;
    private _logFrame: ScrollingFrame;
    private _connection: RBXScriptConnection;

    private constructor() {
        const player = Players.LocalPlayer;
        this._screenGui = new Instance("ScreenGui");
        this._screenGui.IgnoreGuiInset = true;
        this._screenGui.ResetOnSpawn = false;
        this._screenGui.Name = "Developer";
        this._screenGui.Parent = player.WaitForChild("PlayerGui");

        this._logFrame = new Instance("ScrollingFrame");
        this._logFrame.Size = new UDim2(0.4, 0, 0.3, 0);
        this._logFrame.Position = new UDim2(0, 0, 0.7, 0);
        this._logFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        this._logFrame.BackgroundTransparency = 0.4;
        this._logFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        this._logFrame.ScrollBarThickness = 6;
        this._logFrame.Parent = this._screenGui;

        const layout = new Instance("UIListLayout");
        layout.FillDirection = Enum.FillDirection.Vertical;
        layout.SortOrder = Enum.SortOrder.LayoutOrder;
        layout.Parent = this._logFrame;

        this._connection = Logger.GetLogEvent().Event.Connect((tag: string | Instance, ...messages: Array<Printable>) => {
            const text = `${typeof tag === "string" ? tag : tag.GetFullName()}: ${messages.map(v => tostring(v)).join(" ")}`;
            const label = new Instance("TextLabel");
            label.Size = UDim2.fromScale(1, 0);
            label.AutomaticSize = Enum.AutomaticSize.Y;
            label.BackgroundTransparency = 1;
            label.Font = Enum.Font.Code;
            label.TextXAlignment = Enum.TextXAlignment.Left;
            label.TextColor3 = Color3.fromRGB(255, 255, 255);
            label.Text = text;
            label.Parent = this._logFrame;
        });
    }

    public static Create(): DebugLogPanel {
        return new DebugLogPanel();
    }
}

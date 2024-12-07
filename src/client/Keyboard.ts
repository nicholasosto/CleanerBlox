// KeyboardClient.ts
import { Players, UserInputService } from "@rbxts/services";

export class KeyboardClient {
    private player: Player;

    constructor() {
        this.player = Players.LocalPlayer;
        this.bindKeyboardEvents();
    }

    private bindKeyboardEvents(): void {
        UserInputService.InputBegan.Connect((input, isProcessed) => {
            if (isProcessed) return; // Prevent handling if another context has processed this input

            if (input.UserInputType === Enum.UserInputType.Keyboard) {
                const keyCode = input.KeyCode;

                switch (keyCode) {
                    case Enum.KeyCode.W:
                        this.onWKeyPress();
                        break;
                    case Enum.KeyCode.A:
                        this.onAKeyPress();
                        break;
                    case Enum.KeyCode.S:
                        this.onSKeyPress();
                        break;
                    case Enum.KeyCode.D:
                        this.onDKeyPress();
                        break;
                    // Add additional keys as needed
                }
            }
        });
    }

    private onWKeyPress(): void {
        // Implement logic for when 'W' is pressed
        print("W key pressed");
    }

    private onAKeyPress(): void {
        // Implement logic for when 'A' is pressed
        print("A key pressed");
    }

    private onSKeyPress(): void {
        // Implement logic for when 'S' is pressed
        print("S key pressed");
    }

    private onDKeyPress(): void {
        // Implement logic for when 'D' is pressed
        print("D key pressed");
    }
}


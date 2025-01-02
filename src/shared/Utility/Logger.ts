import { HttpService } from "@rbxts/services";
import { Skill } from "@rbxts/wcs";

export type Printable = string | number | boolean | undefined | Vector3 | CFrame | Instance;

// LogLevel: Enum for logging levels
export enum LogLevel {
	Info = "[Inf]",
	Warn = "[Wrn]",
	Error = "[Err]",
}

// Logger: Utility class for logging
export class Logger {
	// Private Variables
	private static _logger: Logger = new Logger();
	private static _logLevel: LogLevel = LogLevel.Info;
	private static _enabled: boolean = true;
	private static _filterTag: string = "";

	// Log: Log messages to the console
	public static Log(logTag: string | Instance, ...messages: Array<Printable>) {
		if (!this._enabled) {
			return;
		}
		warn(logTag);
		print(...messages);
		//warn(logTag, ...messages);
	}

	// CFrame: Convert CFrame to string with rounded values
	public static StringifyCFrame(cf: CFrame): string {
		// Position
		const pos = cf.Position;
		const x = math.round(pos.X * 100) / 100;
		const y = math.round(pos.Y * 100) / 100;
		const z = math.round(pos.Z * 100) / 100;

		// Orientation
		const lookVector = cf.LookVector;
		const lx = math.round(lookVector.X * 100) / 100;
		const ly = math.round(lookVector.Y * 100) / 100;
		const lz = math.round(lookVector.Z * 100) / 100;

		const logMessage = `${this._logLevel}: \n\nCFrame\n================\n Pos: (${x}, ${y}, ${z})\n Look:(${lx}, ${ly}, ${lz})\n================\n`;
		return logMessage;
	}

	// Vector3: Convert Vector3 to string with rounded values
	public static StringifyVector3(vec: Vector3): string {
		const x = math.round(vec.X * 100) / 100;
		const y = math.round(vec.Y * 100) / 100;
		const z = math.round(vec.Z * 100) / 100;

		const logMessage = `${this._logLevel}: \n\n Vector3\n================\n Pos: (${x}, ${y}, ${z})\n================\n`;
		return logMessage;
	}

	// SetLogLevel: Set the log level
	public static SetLogLevel(logLevel: LogLevel) {
		this._logLevel = logLevel;
	}

	// Set Enabled: Enable logging
	public static EnableLogging(enable: boolean) {
		this._enabled = enable;
	}

	// GetInstance: Get the instance of the logger
	public static GetInstance(): Logger {
		return this._logger;
	}

	public static PrintSkillInfo(skill: Skill) {
		warn(`Skill: ${skill.GetName()}\n`);
		print("Player: ", skill.Player);
		print("Character: ", skill.Character);
		print("Type: ", skill.GetSkillType());
		print("Cooldown Time: ", skill.MetadataChanged);
	}
}

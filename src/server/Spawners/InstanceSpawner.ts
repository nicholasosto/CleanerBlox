
import { PositionGenerator } from 'shared/Utility/PositionGenerator';
import { Logger } from 'shared/Utility/Logger';


export class InstanceSpawner {
    private static instance: InstanceSpawner;
    private static spawnRequestConnection: RBXScriptConnection;
    private static spawnRequestEvent: RemoteEvent;

    private constructor() {
    }
    public static Start() {
        if (this.instance === undefined) {
            this.instance = new InstanceSpawner();
        }
    }


}
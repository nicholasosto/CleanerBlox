/**
 * An interface for classes responsible for generating one or multiple CFrames
 * for use in skill activations or object placements. Implementations can derive
 * the user’s position and orientation directly from the provided userCFrame.
 */
export interface ICFrameCreator {
	/**
	 * Creates a single CFrame offset by the provided offsetFrame for positioning
	 *
	 * @param sourceFrame - The user's current CFrame, containing both position
	 *                     and orientation.
	 * @param offsetFrame - The multipliers for the offset in each axis.
	 * @returns A CFrame positioned and oriented for a single model placement.
	 */
	createOffsetFrame(sourceFrame: CFrame, offsetFrame: CFrame): CFrame;

	/**
	 * Creates a single CFrame for positioning a skill model relative to the
	 * provided userCFrame. The userCFrame’s position and orientation can be
	 * used to determine where the generated CFrame should be placed.
	 *
	 * @param userCFrame - The user's current CFrame, containing both position
	 *                     and orientation.
	 * @param offset - The distance in front of the userCFrame at which the new
	 *                 CFrame should be placed.
	 * @returns A CFrame positioned and oriented for a single model placement.
	 */
	createTargetFrame(userCFrame: CFrame, offset: number): CFrame;

	/**
	 * Creates a ring of CFrames around the userCFrame, useful for scenarios such
	 * as a circular AoE or placing multiple objects in a circle.
	 *
	 * @param userCFrame - The user's current CFrame, containing both position
	 * and orientation.
	 *
	 * @param radius - The radius of the ring.
	 *
	 * @param numPositions - The number of CFrames to generate.
	 *
	 * @returns An array of CFrames arranged for multiple model placements.
	 * */

	createRing(userCFrame: CFrame, radius: number, numPositions: number): CFrame[];
}

--- @class AIActivity : Object @AIActivity is an Object registered with an `AIActivityHandler`, representing one possible activity that the handler may execute each time it ticks.
--- @field name string @This activity's name.
--- @field owner AIActivityHandler @The AIActivityHandler that owns this activity. May be `nil` if this activity has been removed from its owner.
--- @field priority number @The current priority of this activity. Expected to be greater than 0, and expected to be adjusted by the `tick` function provided when adding the activity to its handler, though this can be set at any time.
--- @field isDebugModeEnabled boolean @True if this activity has debugging enabled in the AI Debugger. Useful for deciding whether to log additional information about specific activities.
--- @field isHighestPriority boolean @True if this activity is the activity with the highest priority among its owner's list of activities. Note that this value does not update immediately when setting an activity's priority, but will be updated by the handler each tick when the handler evaluates its list of activities.
--- @field elapsedTime number @If this activity is the highest priority for its handler, returns the length of time for which it has been highest priority. Otherwise returns the length of time since it was last highest priority, or since it was added to the handler.
--- @field type string
local AIActivityInstance = {}
--- @param typeName string
--- @return boolean
function AIActivityInstance:IsA(typeName) end

--- @class GlobalAIActivity : Object @AIActivity is an Object registered with an `AIActivityHandler`, representing one possible activity that the handler may execute each time it ticks.
AIActivity = {}

--- @class AIActivityHandler : CoreObject @AIActivityHandle is a CoreObject which can manage one or more `AIActivity`. Each tick, the handler calls a function on each of its registered activities to give them a chance to reevaluate their priorities. It then ticks the highest priority activity again, allowing it to perform additional work.
--- @field isSelectedInDebugger boolean @True if this activity handler is currently selected in the AI Debugger.
--- @field type string
local AIActivityHandlerInstance = {}
--- Creates a new AIActivity registered to the handler with the given unique name and optional functions. Raises an error if the provided name is already in use by another activity in the same handler. `functions` may contain the following:
--- 
--- `tick - function(number deltaTime)`: Called for each activity on each tick by the handler, expected to adjust the priority of the activity.
--- 
--- `tickHighestPriority - function(number deltaTime)`: Called after `tick` for whichever activity has the highest priority within the handler.
--- 
--- `start - function()`: Called between `tick` and `tickHighestPriority` when an activity has become the new highest priority activity within the handler.
--- 
--- `stop - function()`: Called when the current highest priority activity has been removed from the handler or is otherwise no longer the highest priority activity.
--- @overload fun(name: string): AIActivity
--- @param name string
--- @param functions table
--- @return AIActivity
function AIActivityHandlerInstance:AddActivity(name, functions) end

--- Removes the activity with the given name from the handler. Logs a warning if no activity is found with that name. If the named activity is currently the highest priority activity in the handler, its `stop` function will be called.
--- @param name string
function AIActivityHandlerInstance:RemoveActivity(name) end

--- Removes all activities from the handler. Calls the `stop` function for the highest priority activity.
function AIActivityHandlerInstance:ClearActivities() end

--- Returns an array of all of the handler's activities.
--- @return table<number, AIActivity>
function AIActivityHandlerInstance:GetActivities() end

--- Returns the activity with the given name, or `nil` if that name is not found in the handler.
--- @param name string
--- @return AIActivity
function AIActivityHandlerInstance:FindActivity(name) end

--- @param typeName string
--- @return boolean
function AIActivityHandlerInstance:IsA(typeName) end

--- @class GlobalAIActivityHandler : CoreObject @AIActivityHandle is a CoreObject which can manage one or more `AIActivity`. Each tick, the handler calls a function on each of its registered activities to give them a chance to reevaluate their priorities. It then ticks the highest priority activity again, allowing it to perform additional work.
AIActivityHandler = {}

--- @class Ability : CoreObject @Abilities are CoreObjects that can be added to Players and guide the Player's animation in sync with the Ability's state machine. Spawn an Ability with `World.SpawnAsset()` or add an Ability as a child of an Equipment/Weapon to have it be assigned to the Player automatically when that item is equipped.. . Abilities can be activated by association with an Action Binding. Their internal state machine flows through the phases: Ready, Cast, Execute, Recovery, and Cooldown. An Ability begins in the Ready state and transitions to Cast when its Binding (for example Left mouse click) is activated by the owning player. It then automatically flows from Cast to Execute, then Recovery and finally Cooldown. At each of these state transitions it fires a corresponding event.. . Only one ability can be active at a time. By default, activating an ability will interrupt the currently active ability. The `canBePrevented` and `preventsOtherAbilities` properties can be used to customize interruption rules for competing abilities.. . If an ability is interrupted during the Cast phase, it will immediately reset to the Ready state. If an ability is interrupted during the Execute or Recovery phase, the ability will immediately transition to the Cooldown phase.
--- @field readyEvent Event @Fired when the Ability becomes ready. In this phase it is possible to activate it again.
--- @field castEvent Event @Fired when the Ability enters the Cast phase.
--- @field executeEvent Event @Fired when the Ability enters Execute phase.
--- @field recoveryEvent Event @Fired when the Ability enters Recovery.
--- @field cooldownEvent Event @Fired when the Ability enters Cooldown.
--- @field interruptedEvent Event @Fired when the Ability is interrupted.
--- @field tickEvent Event @Fired every tick while the Ability is active (isEnabled = true and phase is not ready).
--- @field actionBinding string @*This property is deprecated. Please use `actionName` instead, but note that `actionBinding` and `actionName` use different values.*  Which action binding will cause the Ability to activate. Possible values of the bindings are listed on the [Ability binding](../api/key_bindings.md) page.
--- @field actionName string @Which binding set action name will cause the Ability to activate. See [Binding Sets](../references/binding_sets.md) reference.
--- @field canActivateWhileDead boolean @Indicates if the Ability can be used while the owning Player is dead. False by default.
--- @field animation string @Name of the animation the Player will play when the Ability is activated. Possible values: See [Ability Animation](../api/animations.md) for strings and other info.
--- @field canBePrevented boolean @Used in conjunction with the phase property `preventsOtherAbilities` so multiple abilities on the same Player can block each other during specific phases. True by default.
--- @field castPhaseSettings AbilityPhaseSettings @Config data for the Cast phase (see below).
--- @field executePhaseSettings AbilityPhaseSettings @Config data for the Execute phase.
--- @field recoveryPhaseSettings AbilityPhaseSettings @Config data for the Recovery phase.
--- @field cooldownPhaseSettings AbilityPhaseSettings @Config data for the Cooldown phase.
--- @field isEnabled boolean @Turns an Ability on/off. It stays on the Player but is interrupted if `isEnabled` is set to `false` during an active Ability. True by default.
--- @field owner CoreObject|Player @Assigning an owner applies the Ability to that Player.
--- @field type string
local AbilityInstance = {}
--- Returns information about what the Player has targeted this phase.
--- @return AbilityTarget
function AbilityInstance:GetTargetData() end

--- Updates information about what the Player has targeted this phase. This can affect the execution of the Ability.
--- @param target AbilityTarget
function AbilityInstance:SetTargetData(target) end

--- The current AbilityPhase for this Ability. These are returned as one of: AbilityPhase.READY, AbilityPhase.CAST, AbilityPhase.EXECUTE, AbilityPhase.RECOVERY and AbilityPhase.COOLDOWN.
--- @return AbilityPhase
function AbilityInstance:GetCurrentPhase() end

--- Returns the settings for the current phase of this Ability. Returns `nil` if the current phase is `AbilityPhase.READY`.
--- @return AbilityPhaseSettings
function AbilityInstance:GetCurrentPhaseSettings() end

--- Seconds left in the current phase.
--- @return number
function AbilityInstance:GetPhaseTimeRemaining() end

--- Changes an Ability from Cast phase to Ready phase. If the Ability is in either Execute or Recovery phases it instead goes to Cooldown phase.
function AbilityInstance:Interrupt() end

--- Activates an Ability as if the button had been pressed.
function AbilityInstance:Activate() end

--- Advances a currently active Ability from its current phase to the next phase. For example, an ability in the Cast phase will begin the Execute phase, an ability on cooldown will become ready, etc.
function AbilityInstance:AdvancePhase() end

--- @param typeName string
--- @return boolean
function AbilityInstance:IsA(typeName) end

--- @class GlobalAbility : CoreObject @Abilities are CoreObjects that can be added to Players and guide the Player's animation in sync with the Ability's state machine. Spawn an Ability with `World.SpawnAsset()` or add an Ability as a child of an Equipment/Weapon to have it be assigned to the Player automatically when that item is equipped.. . Abilities can be activated by association with an Action Binding. Their internal state machine flows through the phases: Ready, Cast, Execute, Recovery, and Cooldown. An Ability begins in the Ready state and transitions to Cast when its Binding (for example Left mouse click) is activated by the owning player. It then automatically flows from Cast to Execute, then Recovery and finally Cooldown. At each of these state transitions it fires a corresponding event.. . Only one ability can be active at a time. By default, activating an ability will interrupt the currently active ability. The `canBePrevented` and `preventsOtherAbilities` properties can be used to customize interruption rules for competing abilities.. . If an ability is interrupted during the Cast phase, it will immediately reset to the Ready state. If an ability is interrupted during the Execute or Recovery phase, the ability will immediately transition to the Cooldown phase.
Ability = {}

--- @class AbilityPhaseSettings : Object @Each phase of an Ability can be configured differently, allowing complex and different Abilities. AbilityPhaseSettings is an Object.
--- @field duration number @Length in seconds of the phase. After this time the Ability moves to the next phase. Can be zero. Default values per phase: 0.15, 0, 0.5 and 3.
--- @field canMove boolean @Is the Player allowed to move during this phase. True by default.
--- @field canJump boolean @Is the Player allowed to jump during this phase. False by default in Cast & Execute, default True in Recovery & Cooldown.
--- @field canRotate boolean @Is the Player allowed to rotate during this phase. True by default.
--- @field preventsOtherAbilities boolean @When true this phase prevents the Player from casting another Ability, unless that other Ability has canBePrevented set to False. True by default in Cast & Execute, false in Recovery & Cooldown.
--- @field isTargetDataUpdated boolean @If `true`, there will be updated target information at the start of the phase. Otherwise, target information may be out of date.
--- @field facingMode AbilityFacingMode @How and if this Ability rotates the Player during execution. Cast and Execute default to "Aim", other phases default to "None". Options are: AbilityFacingMode.NONE, AbilityFacingMode.MOVEMENT, AbilityFacingMode.AIM
--- @field type string
local AbilityPhaseSettingsInstance = {}
--- @param typeName string
--- @return boolean
function AbilityPhaseSettingsInstance:IsA(typeName) end

--- @class GlobalAbilityPhaseSettings : Object @Each phase of an Ability can be configured differently, allowing complex and different Abilities. AbilityPhaseSettings is an Object.
AbilityPhaseSettings = {}

--- @class AbilityTarget @A data type containing information about what the Player has targeted during a phase of an Ability.
--- @field hitPlayer Player @Convenience property that is the same as hitObject, but only if hitObject is a Player.
--- @field hitObject CoreObject|Player @Object under the reticle, or center of the screen if no reticle is displayed. Can be a Player, StaticMesh, etc.
--- @field spreadHalfAngle number @Half-angle of cone of possible target space, in degrees.
--- @field spreadRandomSeed number @Seed that can be used with RandomStream for deterministic RNG.
--- @field type string
local AbilityTargetInstance = {}
--- Gets the direction the Player is moving.
--- @return Rotation
function AbilityTargetInstance:GetOwnerMovementRotation() end

--- Sets the direction the Player faces, if `Ability.facingMode` is set to `AbilityFacingMode.MOVEMENT`.
--- @param rotation Rotation
function AbilityTargetInstance:SetOwnerMovementRotation(rotation) end

--- Returns the world space position of the camera.
--- @return Vector3
function AbilityTargetInstance:GetAimPosition() end

--- The world space location of the camera. Setting this currently has no effect on the Player's camera.
--- @param worldPosition Vector3
function AbilityTargetInstance:SetAimPosition(worldPosition) end

--- Returns the direction the camera is facing.
--- @return Vector3
function AbilityTargetInstance:GetAimDirection() end

--- Sets the direction the camera is facing.
--- @param direction Vector3
function AbilityTargetInstance:SetAimDirection(direction) end

--- Returns the world space position of the object under the Player's reticle. If there is no object, a position under the reticle in the distance. If the Player doesn't have a reticle displayed, uses the center of the screen as if there was a reticle there.
--- @return Vector3
function AbilityTargetInstance:GetHitPosition() end

--- Sets the hit position property. This may affect weapon behavior.
--- @param worldPosition Vector3
function AbilityTargetInstance:SetHitPosition(worldPosition) end

--- Returns physics information about the point being targeted
--- @return HitResult
function AbilityTargetInstance:GetHitResult() end

--- Sets the hit result property. Setting this value has no affect on the Ability.
--- @param hitResult HitResult
function AbilityTargetInstance:SetHitResult(hitResult) end

--- @param typeName string
--- @return boolean
function AbilityTargetInstance:IsA(typeName) end

--- @class GlobalAbilityTarget @A data type containing information about what the Player has targeted during a phase of an Ability.
AbilityTarget = {}
--- Constructs a new Ability Target data object.
--- @return AbilityTarget
function AbilityTarget.New() end


--- @class AnimatedMesh : CoreMesh @AnimatedMesh objects are skeletal CoreMeshes with parameterized animations baked into them. They also have sockets exposed to which any CoreObject can be attached.
--- @field animationEvent Event @Some animations have events specified at important points of the animation (for example the impact point in a punch animation). This event is fired with the animated mesh that triggered it, the name of the event at those points, and the name of the animation itself.
--- @field animationStance string @The stance the animated mesh plays.
--- @field animationStancePlaybackRate number @The playback rate for the animation stance being played.
--- @field animationStanceShouldLoop boolean @If `true`, the animation stance will keep playing in a loop. If `false` the animation will stop playing once completed.
--- @field playbackRateMultiplier number @Rate multiplier for all animations played on the animated mesh. Setting this to `0` will stop all animations on the mesh.
--- @field type string
local AnimatedMeshInstance = {}
--- Returns an array of all available animations on this object.
--- @return table<number, string>
function AnimatedMeshInstance:GetAnimationNames() end

--- Returns an array of all available animation stances on this object.
--- @return table<number, string>
function AnimatedMeshInstance:GetAnimationStanceNames() end

--- Returns an array of all available sockets on this object.
--- @return table<number, string>
function AnimatedMeshInstance:GetSocketNames() end

--- Returns an array of available animation event names for the specified animation. Raises an error if `animationName` is not a valid animation on this mesh.
--- @param animationName string
--- @return table<number, string>
function AnimatedMeshInstance:GetAnimationEventNames(animationName) end

--- Attaches the specified object to the specified socket on the mesh if they exist.
--- @param objectToAttach CoreObject
--- @param socket string
function AnimatedMeshInstance:AttachCoreObject(objectToAttach, socket) end

--- Plays an animation on the animated mesh.
--- 
--- Optional parameters can be provided to control the animation playback: `startPosition (number)`: A number between 0 and 1 controlling where in the animation playback will start; `playbackRate (number)`: Controls how fast the animation plays; `shouldLoop (boolean)`: If `true`, the animation will keep playing in a loop. If `false` the animation will stop playing once completed.
--- @overload fun(animationName: string)
--- @param animationName string
--- @param optionalParameters table
function AnimatedMeshInstance:PlayAnimation(animationName, optionalParameters) end

--- Stops all in-progress animations played via `PlayAnimation` on this object.
function AnimatedMeshInstance:StopAnimations() end

--- Returns the duration of the animation in seconds. Raises an error if `animationName` is not a valid animation on this mesh.
--- @param animationName string
--- @return number
function AnimatedMeshInstance:GetAnimationDuration(animationName) end

--- Assigns a mesh to the specified slot on this `AnimatedMesh`. If `assetId` is an empty string or identifies an incompatible asset, the slot will be cleared.
--- @param slotIndex number
--- @param assetId string
function AnimatedMeshInstance:SetMeshForSlot(slotIndex, assetId) end

--- Returns the asset ID of the mesh assigned to the specified slot on this `AnimatedMesh`. Returns `nil` if no mesh is assigned to the slot.
--- @param slotIndex number
--- @return string
function AnimatedMeshInstance:GetMeshForSlot(slotIndex) end

--- Set the material in the given slot to the material specified by assetId.
--- @param assetId string
--- @param slotName string
function AnimatedMeshInstance:SetMaterialForSlot(assetId, slotName) end

--- Get the MaterialSlot object for the given slot. If called on the client on a networked object, the resulting object cannot be modified.
--- @param slotName string
--- @return MaterialSlot
function AnimatedMeshInstance:GetMaterialSlot(slotName) end

--- Get an array of all MaterialSlots on this mesh. If called on the client on a networked object, the resulting object cannot be modified.
--- @return table<number, MaterialSlot>
function AnimatedMeshInstance:GetMaterialSlots() end

--- Resets a material slot to its original state.
--- @param slotName string
function AnimatedMeshInstance:ResetMaterialSlot(slotName) end

--- @param typeName string
--- @return boolean
function AnimatedMeshInstance:IsA(typeName) end

--- @class GlobalAnimatedMesh : CoreMesh @AnimatedMesh objects are skeletal CoreMeshes with parameterized animations baked into them. They also have sockets exposed to which any CoreObject can be attached.
AnimatedMesh = {}

--- @class AreaLight : Light @AreaLight is a Light that emits light from a rectangular plane. It also has properties for configuring a set of "doors" attached to the plane which affect the lit area in front of the plane.
--- @field sourceWidth number @The width of the plane from which light is emitted. Must be greater than 0.
--- @field sourceHeight number @The height of the plane from which light is emitted. Must be greater than 0.
--- @field barnDoorAngle number @The angle of the barn doors, in degrees. Valid values are in the range from 0 to 90. Has no effect if `barnDoorLength` is 0.
--- @field barnDoorLength number @The length of the barn doors. Must be non-negative.
--- @field type string
local AreaLightInstance = {}
--- @param typeName string
--- @return boolean
function AreaLightInstance:IsA(typeName) end

--- @class GlobalAreaLight : Light @AreaLight is a Light that emits light from a rectangular plane. It also has properties for configuring a set of "doors" attached to the plane which affect the lit area in front of the plane.
AreaLight = {}

--- @class Audio : CoreObject @Audio is a CoreObject that wrap sound files. Most properties are exposed in the UI and can be set when placed in the editor, but some functionality (such as playback with fade in/out) requires Lua scripting.
--- @field isSpatializationEnabled boolean @Default true. Set to false to play sound without 3D positioning.
--- @field isAttenuationEnabled boolean @Default true, meaning sounds will fade with distance.
--- @field isOcclusionEnabled boolean @Default true. Changes attenuation if there is geometry between the player and the audio source.
--- @field isAutoPlayEnabled boolean @Default false. If set to true when placed in the editor (or included in a template), the sound will be automatically played when loaded.
--- @field isTransient boolean @Default false. If set to true, the sound will automatically destroy itself after it finishes playing.
--- @field isAutoRepeatEnabled boolean @Loops when playback has finished. Some sounds are designed to automatically loop, this flag will force others that don't. Useful for looping music.
--- @field pitch number @Default 1. Multiplies the playback pitch of a sound. Note that some sounds have clamped pitch ranges (0.2 to 1).
--- @field volume number @Default 1. Multiplies the playback volume of a sound. Note that values above 1 can distort sound, so if you're trying to balance sounds, experiment to see if scaling down works better than scaling up.
--- @field radius number @Default 0. If non-zero, will override default 3D spatial parameters of the sound. Radius is the distance away from the sound position that will be played at 100% volume.
--- @field falloff number @Default 0. If non-zero, will override default 3D spatial parameters of the sound. Falloff is the distance outside the radius over which the sound volume will gradually fall to zero.
--- @field isPlaying boolean @Returns if the sound is currently playing.
--- @field length number @Returns the length (in seconds) of the Sound.
--- @field currentPlaybackTime number @Returns the playback position (in seconds) of the sound.
--- @field fadeInTime number @Sets the fade in time for the audio. When the audio is played, it will start at zero volume, and fade in over this many seconds.
--- @field fadeOutTime number @Sets the fadeout time of the audio. When the audio is stopped, it will keep playing for this many seconds, as it fades out.
--- @field startTime number @The start time of the audio track. Default is 0. Setting this to anything else means that the audio will skip ahead that many seconds when played.
--- @field stopTime number @The stop time of the audio track. Default is 0. A positive value means that the audio will stop that many seconds from the start of the track, including any fade out time.
--- @field type string
local AudioInstance = {}
--- Begins sound playback.
function AudioInstance:Play() end

--- Stops sound playback.
function AudioInstance:Stop() end

--- Starts playing and fades in the sound over the given time.
--- @param time number
function AudioInstance:FadeIn(time) end

--- Fades the sound out and stops over time seconds.
--- @param time number
function AudioInstance:FadeOut(time) end

--- @param typeName string
--- @return boolean
function AudioInstance:IsA(typeName) end

--- @class GlobalAudio : CoreObject @Audio is a CoreObject that wrap sound files. Most properties are exposed in the UI and can be set when placed in the editor, but some functionality (such as playback with fade in/out) requires Lua scripting.
Audio = {}

--- @class BindingSet : CoreObject @BindingSet is a CoreObject which contains a set of actions a creator has defined for a game and the default key bindings to trigger those actions.
--- @field type string
local BindingSetInstance = {}
--- @param typeName string
--- @return boolean
function BindingSetInstance:IsA(typeName) end

--- @class GlobalBindingSet : CoreObject @BindingSet is a CoreObject which contains a set of actions a creator has defined for a game and the default key bindings to trigger those actions.
BindingSet = {}

--- @class BlockchainContract @Metadata about a smart contract on the blockchain.
--- @field address string @The address of the contract.
--- @field name string @The name of the contract, if it has one.
--- @field description string @The description of the contract, if it has one.
--- @field symbol string @An abbreviated name for the contract.
--- @field count number @The number of tokens contained in the contract, if available.
--- @field type string
local BlockchainContractInstance = {}
--- @param typeName string
--- @return boolean
function BlockchainContractInstance:IsA(typeName) end

--- @class GlobalBlockchainContract @Metadata about a smart contract on the blockchain.
BlockchainContract = {}

--- @class BlockchainToken @Metadata about a token stored on the blockchain.
--- @field contractAddress string @The address of the contract this token belongs to.
--- @field tokenId string @The ID of this token within its contract.
--- @field name string @The name of the token, if it has one.
--- @field description string @The description of the token, if it has one.
--- @field rawMetadata string @The raw, unprocessed metadata value from the token. This could be anything, including a URL, JSON string, etc.
--- @field ownerAddress string @The wallet address of the token's owner.
--- @field creatorAddress string @The address of the token's creator.
--- @field type string
local BlockchainTokenInstance = {}
--- Returns the contract this token belongs to.
--- @return BlockchainContract
function BlockchainTokenInstance:GetContract() end

--- Returns an array of this token's attributes.
--- @return table<number, BlockchainTokenAttribute>
function BlockchainTokenInstance:GetAttributes() end

--- Returns the attribute with the specified name. Returns nil if this token does not contain the desired attribute.
--- @param name string
--- @return BlockchainTokenAttribute
function BlockchainTokenInstance:GetAttribute(name) end

--- @param typeName string
--- @return boolean
function BlockchainTokenInstance:IsA(typeName) end

--- @class GlobalBlockchainToken @Metadata about a token stored on the blockchain.
BlockchainToken = {}

--- @class BlockchainTokenAttribute @A single attribute on a BlockchainToken.
--- @field name string @The name of the attribute.
--- @field type string
local BlockchainTokenAttributeInstance = {}
--- Returns the attribute's value as a string.
--- @return string
function BlockchainTokenAttributeInstance:GetValue() end

--- @param typeName string
--- @return boolean
function BlockchainTokenAttributeInstance:IsA(typeName) end

--- @class GlobalBlockchainTokenAttribute @A single attribute on a BlockchainToken.
BlockchainTokenAttribute = {}

--- @class BlockchainTokenCollection @Contains a set of results from [Blockchain.GetTokens()](blockchain.md) and related functions. Depending on how many tokens are available, results may be separated into multiple pages. The `.hasMoreResults` property may be checked to determine whether more tokens are available. Those results may be retrieved using the `:GetMoreResults()` function.
--- @field hasMoreResults boolean @Returns `true` if there are more tokens available to be requested.
--- @field type string
local BlockchainTokenCollectionInstance = {}
--- Returns the list of tokens contained in this set of results. This may return an empty table.
--- @return table<number, BlockchainToken>
function BlockchainTokenCollectionInstance:GetResults() end

--- Requests the next set of results for this list of tokens and returns a new collection containing those results. This function may yield until a result is available. Returns `nil` if the `hasMoreResults` property is `false`, or if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value.
--- @return BlockchainTokenCollection|BlockchainTokenResultCode|string
function BlockchainTokenCollectionInstance:GetMoreResults() end

--- @param typeName string
--- @return boolean
function BlockchainTokenCollectionInstance:IsA(typeName) end

--- @class GlobalBlockchainTokenCollection @Contains a set of results from [Blockchain.GetTokens()](blockchain.md) and related functions. Depending on how many tokens are available, results may be separated into multiple pages. The `.hasMoreResults` property may be checked to determine whether more tokens are available. Those results may be retrieved using the `:GetMoreResults()` function.
BlockchainTokenCollection = {}

--- @class Box @A 3D box aligned to some coordinate system.
--- @field type string
local BoxInstance = {}
--- Returns the coordinates of the center of the box.
--- @return Vector3
function BoxInstance:GetCenter() end

--- Returns a Vector3 representing half the size of the box along its local axes.
--- @return Vector3
function BoxInstance:GetExtent() end

--- Returns a Transform which, when applied to a unit cube, produces a result matching the position, size, and rotation of this box.
--- @return Transform
function BoxInstance:GetTransform() end

--- @param typeName string
--- @return boolean
function BoxInstance:IsA(typeName) end

--- @class GlobalBox @A 3D box aligned to some coordinate system.
Box = {}

--- @class Camera : CoreObject @Camera is a CoreObject which is used both to configure Player Camera settings as well as to represent the position and rotation of the Camera in the world. Cameras can be configured in various ways, usually following a specific Player's view, but can also have a fixed orientation and/or position.. . Each Player (on their client) can have a default Camera and an override Camera. If they have neither, camera behavior falls back to a basic third-person behavior. Default Cameras should be used for main gameplay while override Cameras are generally employed as a temporary view, such as a when the Player is sitting in a mounted turret.
--- @field followPlayer Player @Which Player's view the camera should follow. Set to the local Player for a first or third person camera. Set to nil to detach.
--- @field isOrthographic boolean @Whether the camera uses an isometric (orthographic) view or perspective.
--- @field fieldOfView number @The field of view when using perspective view. Clamped between 1.0 and 170.0.
--- @field viewWidth number @The width of the view with an isometric view. Has a minimum value of 1.0.
--- @field useCameraSocket boolean @If you have a followPlayer, then use their camera socket. This is often preferable for first-person cameras, and gives a bit of view bob.
--- @field currentDistance number @The distance controlled by the Player with scroll wheel (by default).
--- @field isDistanceAdjustable boolean @Whether the Player can control their camera distance (with the mouse wheel by default). Creators can still access distance through currentDistance below, even if this value is false.
--- @field minDistance number @The minimum distance the Player can zoom in to.
--- @field maxDistance number @The maximum distance the Player can zoom out to.
--- @field rotationMode RotationMode @Which base rotation to use. Values: `RotationMode.CAMERA`, `RotationMode.NONE`, `RotationMode.LOOK_ANGLE`.
--- @field hasFreeControl boolean @Whether the Player can freely control their rotation (with mouse or thumbstick). Requires movement mode `RotationMode.CAMERA`. This has no effect if the camera is following a player.
--- @field currentPitch number @The current pitch of the Player's free control.
--- @field minPitch number @The minimum pitch for free control.
--- @field maxPitch number @The maximum pitch for free control.
--- @field isYawLimited boolean @Whether the Player's yaw has limits. If so, `maxYaw` must be at least `minYaw`, and should be outside the range `[0, 360]` if needed.
--- @field currentYaw number @The current yaw of the Player's free control.
--- @field minYaw number @The minimum yaw for free control.
--- @field maxYaw number @The maximum yaw for free control.
--- @field useAsAudioListener boolean @Whether the local player's audio should be attenuated and spatialized based on their view position while this is the active camera.
--- @field audioListenerOffset Vector3 @This property is deprecated. Please use the GetAudioListenerOffset() and SetAudioListenerOffset() functions instead.
--- @field lerpTime number
--- @field isUsingCameraRotation boolean
--- @field isCameraCollisionEnabled boolean @When true, this camera will collide with objects that have camera collision enabled. When set to false, the camera will not collide with any objects. Defaults to true.
--- @field type string
local CameraInstance = {}
--- An offset added to the camera or follow target's eye position to the Player's view.
--- @return Vector3
function CameraInstance:GetPositionOffset() end

--- An offset added to the camera or follow target's eye position to the Player's view.
--- @param positionOffset Vector3
function CameraInstance:SetPositionOffset(positionOffset) end

--- A rotation added to the camera or follow target's eye position.
--- @return Rotation
function CameraInstance:GetRotationOffset() end

--- A rotation added to the camera or follow target's eye position.
--- @param rotationOffset Rotation
function CameraInstance:SetRotationOffset(rotationOffset) end

--- Returns the local offset to the view position when using this camera as the audio listener.
--- @return Vector3
function CameraInstance:GetAudioListenerOffset() end

--- Sets the local offset to the view position when using this camera as the audio listener.
--- @param offset Vector3
function CameraInstance:SetAudioListenerOffset(offset) end

--- Captures an image at the specified resolution using this camera. Returns a `CameraCapture` object that may be used to display this image or refresh the capture. May return `nil` if the maximum number of capture instances at the desired resolution has been exceeded. The optional parameter table is currently unused.
--- @overload fun(resolution: CameraCaptureResolution): CameraCapture
--- @param resolution CameraCaptureResolution
--- @param optionalParameters table
--- @return CameraCapture
function CameraInstance:Capture(resolution, optionalParameters) end

--- @param typeName string
--- @return boolean
function CameraInstance:IsA(typeName) end

--- @class GlobalCamera : CoreObject @Camera is a CoreObject which is used both to configure Player Camera settings as well as to represent the position and rotation of the Camera in the world. Cameras can be configured in various ways, usually following a specific Player's view, but can also have a fixed orientation and/or position.. . Each Player (on their client) can have a default Camera and an override Camera. If they have neither, camera behavior falls back to a basic third-person behavior. Default Cameras should be used for main gameplay while override Cameras are generally employed as a temporary view, such as a when the Player is sitting in a mounted turret.
Camera = {}

--- @class CameraCapture @CameraCapture represents an image rendered by a `Camera` to be used elsewhere in the game, for example in UI. Each camera capture instance uses a certain amount of the memory based on the resolution size. Creators are free to create whatever combination (mixed resolutions) of camera captures needed up until the budget is fully consumed. Creators may wish to explicitly release existing capture instances when they are no longer needed, so that they can create more elsewhere. A released capture is no longer valid, and should not be used thereafter.. . The total budget is 8 megapixels (8,388,608 pixels).. . Below lists the total number of captures that can be done per resolution. Creators can mix the resolution size as long as the total budget is not above the limit of 8 megapixels.. . - 2048 maximum captures at `VERY_SMALL` resolution size.. - 512 maximum captures at `SMALL` resolution size.. - 128 maximum captures at `MEDIUM` resolution size.. - 32 maximum captures at `LARGE` resolution size.. - 8 maximum captures at `VERY_LARGE` resolution size.
--- @field resolution CameraCaptureResolution @The resolution of this capture.
--- @field camera Camera @The Camera to capture from.
--- @field type string
local CameraCaptureInstance = {}
--- Returns `true` if this capture instance has valid resources.
--- @return boolean
function CameraCaptureInstance:IsValid() end

--- Recaptures the render using the current camera.
function CameraCaptureInstance:Refresh() end

--- Releases the texture resources associated with this capture instance. This instance will become invalid and should no longer be used.
function CameraCaptureInstance:Release() end

--- @param typeName string
--- @return boolean
function CameraCaptureInstance:IsA(typeName) end

--- @class GlobalCameraCapture @CameraCapture represents an image rendered by a `Camera` to be used elsewhere in the game, for example in UI. Each camera capture instance uses a certain amount of the memory based on the resolution size. Creators are free to create whatever combination (mixed resolutions) of camera captures needed up until the budget is fully consumed. Creators may wish to explicitly release existing capture instances when they are no longer needed, so that they can create more elsewhere. A released capture is no longer valid, and should not be used thereafter.. . The total budget is 8 megapixels (8,388,608 pixels).. . Below lists the total number of captures that can be done per resolution. Creators can mix the resolution size as long as the total budget is not above the limit of 8 megapixels.. . - 2048 maximum captures at `VERY_SMALL` resolution size.. - 512 maximum captures at `SMALL` resolution size.. - 128 maximum captures at `MEDIUM` resolution size.. - 32 maximum captures at `LARGE` resolution size.. - 8 maximum captures at `VERY_LARGE` resolution size.
CameraCapture = {}

--- @class Color @An RGBA representation of a color. Color components have an effective range of `[0.0, 1.0]`, but values greater than 1 may be used.
--- @field r number @The Red component of the Color.
--- @field g number @The Green component of the Color.
--- @field b number @The Blue component of the Color.
--- @field a number @The Alpha (transparency) component of the Color.
--- @field type string
--- @operator add(Color): Color @ Component-wise addition.
--- @operator sub(Color): Color @ Component-wise subtraction.
--- @operator mul(Color): Color @ Multiplication operator.
--- @operator mul(number): Color @ Multiplication operator.
--- @operator div(Color): Color @ Division operator.
--- @operator div(number): Color @ Division operator.
local ColorInstance = {}
--- Returns the desaturated version of the Color. 0 represents no desaturation and 1 represents full desaturation.
--- @param desaturation number
--- @return Color
function ColorInstance:GetDesaturated(desaturation) end

--- Returns a hexadecimal sRGB representation of this color, in the format "#RRGGBBAA". Channel values outside the normal 0-1 range will be clamped, and some precision may be lost.
--- @return string
function ColorInstance:ToStandardHex() end

--- Returns a hexadecimal linear RGB representation of this color, in the format "#RRGGBBAA". Channel values outside the normal 0-1 range will be clamped, and some precision may be lost.
--- @return string
function ColorInstance:ToLinearHex() end

--- @param typeName string
--- @return boolean
function ColorInstance:IsA(typeName) end

--- @class GlobalColor @An RGBA representation of a color. Color components have an effective range of `[0.0, 1.0]`, but values greater than 1 may be used.
--- @field WHITE Color @#ffffffff
--- @field GRAY Color @#7f7f7fff
--- @field BLACK Color @#000000ff
--- @field TRANSPARENT Color @#ffffff00
--- @field RED Color @#ff0000ff
--- @field GREEN Color @#00ff00ff
--- @field BLUE Color @#0000ffff
--- @field CYAN Color @#00ffffff
--- @field MAGENTA Color @#ff00ffff
--- @field YELLOW Color @#ffff00ff
--- @field ORANGE Color @#cc4c00ff
--- @field PURPLE Color @#4c0099ff
--- @field BROWN Color @#721400ff
--- @field PINK Color @#ff6666ff
--- @field TAN Color @#e5bf4cff
--- @field RUBY Color @#660101ff
--- @field EMERALD Color @#0c660cff
--- @field SAPPHIRE Color @#02024cff
--- @field SILVER Color @#b2b2b2ff
--- @field SMOKE Color @#191919ff
Color = {}
--- Returns a new color with random RGB values and Alpha of 1.0.
--- @return Color
function Color.Random() end

--- Linearly interpolates between two colors in HSV space by the specified progress amount and returns the resultant Color.
--- @param from Color
--- @param to Color
--- @param progress number
--- @return Color
function Color.Lerp(from, to, progress) end

--- Creates a Color from the given sRGB hexadecimal string. Supported formats include "#RGB", "#RGBA", "#RRGGBB", and "#RRGGBBAA", with or without the leading "#".
--- @param hexString string
--- @return Color
function Color.FromStandardHex(hexString) end

--- Creates a Color from the given linear RGB hexadecimal string. Supported formats include "#RGB", "#RGBA", "#RRGGBB", and "#RRGGBBAA", with or without the leading "#".
--- @param hexString string
--- @return Color
function Color.FromLinearHex(hexString) end

--- Constructs a new Color.
--- @overload fun(rgbaVector: Vector4): Color
--- @overload fun(rgbVector: Vector3): Color
--- @overload fun(red: number,green: number,blue: number,alpha: number): Color
--- @overload fun(red: number,green: number,blue: number): Color
--- @overload fun(): Color
--- @param color Color
--- @return Color
function Color.New(color) end


--- @class CoreFriendCollection @Contains a set of results from [CoreSocial.GetFriends()](coresocial.md). Depending on how many friends a player has, results may be separated into multiple pages. The `.hasMoreResults` property may be checked to determine whether more friends are available. Those results may be retrieved using the `:GetMoreResults()` function.
--- @field hasMoreResults boolean @Returns `true` if there are more friends available to be requested.
--- @field type string
local CoreFriendCollectionInstance = {}
--- Returns the list of friends contained in this set of results. This may return an empty table for players who have no friends.
--- @return table<number, CoreFriendCollectionEntry>
function CoreFriendCollectionInstance:GetResults() end

--- Requests the next set of results for this list of friends and returns a new collection containing those results. Returns `nil` if the `hasMoreResults` property is `false`. This function may yield until a result is available, and may raise an error if an error occurs retrieving the information.
--- @return CoreFriendCollection
function CoreFriendCollectionInstance:GetMoreResults() end

--- @param typeName string
--- @return boolean
function CoreFriendCollectionInstance:IsA(typeName) end

--- @class GlobalCoreFriendCollection @Contains a set of results from [CoreSocial.GetFriends()](coresocial.md). Depending on how many friends a player has, results may be separated into multiple pages. The `.hasMoreResults` property may be checked to determine whether more friends are available. Those results may be retrieved using the `:GetMoreResults()` function.
CoreFriendCollection = {}

--- @class CoreFriendCollectionEntry @Represents a single friend in a [CoreFriendCollection](corefriendcollection.md).
--- @field id string @The ID of the friend.
--- @field name string @The name of the friend.
--- @field type string
local CoreFriendCollectionEntryInstance = {}
--- @param typeName string
--- @return boolean
function CoreFriendCollectionEntryInstance:IsA(typeName) end

--- @class GlobalCoreFriendCollectionEntry @Represents a single friend in a [CoreFriendCollection](corefriendcollection.md).
CoreFriendCollectionEntry = {}

--- @class CoreGameCollectionEntry @Metadata about a published game in a collection on the Core platform. Additional metadata is available via [CorePlatform.GetGameInfo()](coreplatform.md).
--- @field id string @The ID of the game.
--- @field parentGameId string @The ID of this game's parent game if there is one, or else `nil`.
--- @field name string @The name of the game.
--- @field ownerId string @The player ID of the creator who published the game.
--- @field ownerName string @The player name of the creator who published the game.
--- @field isPromoted boolean @Whether or not this game is promoted.
--- @field type string
local CoreGameCollectionEntryInstance = {}
--- @param typeName string
--- @return boolean
function CoreGameCollectionEntryInstance:IsA(typeName) end

--- @class GlobalCoreGameCollectionEntry @Metadata about a published game in a collection on the Core platform. Additional metadata is available via [CorePlatform.GetGameInfo()](coreplatform.md).
CoreGameCollectionEntry = {}

--- @class CoreGameEvent @Metadata about a creator-defined event for a game on the Core platform.
--- @field id string @The ID of the event.
--- @field gameId string @The ID of the game this event belongs to.
--- @field name string @The display name of the event.
--- @field referenceName string @The reference name of the event.
--- @field description string @The description of the event.
--- @field state CoreGameEventState @The current state of the event (active, scheduled, etc).
--- @field registeredPlayerCount number @The number of players currently registered for this event.
--- @field type string
local CoreGameEventInstance = {}
--- Returns a list of the tags selected when this event was published.
--- @return table<number, string>
function CoreGameEventInstance:GetTags() end

--- Returns the start date and time of the event.
--- @return DateTime
function CoreGameEventInstance:GetStartDateTime() end

--- Returns the end date and time of the event.
--- @return DateTime
function CoreGameEventInstance:GetEndDateTime() end

--- @param typeName string
--- @return boolean
function CoreGameEventInstance:IsA(typeName) end

--- @class GlobalCoreGameEvent @Metadata about a creator-defined event for a game on the Core platform.
CoreGameEvent = {}

--- @class CoreGameEventCollection @Contains a set of results from [CorePlatform.GetGameEventCollection()](coreplatform.md) and related functions. Depending on how many events are available, results may be separated into multiple pages. The `.hasMoreResults` property may be checked to determine whether more events are available. Those results may be retrieved using the `:GetMoreResults()` function.
--- @field hasMoreResults boolean @Returns `true` if there are more events available to be requested.
--- @field type string
local CoreGameEventCollectionInstance = {}
--- Returns the list of events contained in this set of results. This may return an empty table.
--- @return table<number, CoreGameEvent>
function CoreGameEventCollectionInstance:GetResults() end

--- Requests the next set of results for this list of events and returns a new collection containing those results. Returns `nil` if the `hasMoreResults` property is `false`. This function may yield until a result is available, and may raise an error if an error occurs retrieving the information.
--- @return CoreGameEventCollection
function CoreGameEventCollectionInstance:GetMoreResults() end

--- @param typeName string
--- @return boolean
function CoreGameEventCollectionInstance:IsA(typeName) end

--- @class GlobalCoreGameEventCollection @Contains a set of results from [CorePlatform.GetGameEventCollection()](coreplatform.md) and related functions. Depending on how many events are available, results may be separated into multiple pages. The `.hasMoreResults` property may be checked to determine whether more events are available. Those results may be retrieved using the `:GetMoreResults()` function.
CoreGameEventCollection = {}

--- @class CoreGameInfo @Metadata about a published game on the Core platform.
--- @field id string @The ID of the game.
--- @field parentGameId string @The ID of this game's parent game if there is one, or else `nil`.
--- @field name string @The name of the game.
--- @field description string @The description of the game.
--- @field ownerId string @The player ID of the creator who published the game.
--- @field ownerName string @The player name of the creator who published the game.
--- @field maxPlayers number @The maximum number of players per game instance.
--- @field isQueueEnabled boolean @`true` if the game was published with queueing enabled.
--- @field screenshotCount number @The number of screenshots published with the game.
--- @field hasWorldCapture boolean @`true` if the game was published with a captured view of the world for use with portals.
--- @field type string
local CoreGameInfoInstance = {}
--- Returns a list of the tags selected when this game was published.
--- @return table<number, string>
function CoreGameInfoInstance:GetTags() end

--- @param typeName string
--- @return boolean
function CoreGameInfoInstance:IsA(typeName) end

--- @class GlobalCoreGameInfo @Metadata about a published game on the Core platform.
CoreGameInfo = {}

--- @class CoreMesh : CoreObject @CoreMesh is a CoreObject representing a mesh that can be placed in the scene. It is the parent type for both AnimatedMesh and StaticMesh.
--- @field meshAssetId string @The ID of the mesh asset used by this mesh.
--- @field team number @Assigns the mesh to a team. Value range from `0` to `4`. `0` is neutral team.
--- @field isTeamColorUsed boolean @If `true`, and the mesh has been assigned to a valid team, players on that team will see a blue mesh, while other players will see red. Requires a material that supports the color property.
--- @field isTeamCollisionEnabled boolean @If `false`, and the mesh has been assigned to a valid team, players on that team will not collide with the mesh.
--- @field isEnemyCollisionEnabled boolean @If `false`, and the mesh has been assigned to a valid team, players on other teams will not collide with the mesh.
--- @field isCameraCollisionEnabled boolean @If `false`, the mesh will not push against the camera. Useful for things like railings or transparent walls. This property is deprecated, use the `cameraCollision` property instead.
--- @field type string
local CoreMeshInstance = {}
--- Returns the color override previously set from script, or `0, 0, 0, 0` if no such color has been set.
--- @return Color
function CoreMeshInstance:GetColor() end

--- Overrides the color of all materials on the mesh, and replicates the new colors.
--- @param color Color
function CoreMeshInstance:SetColor(color) end

--- Turns off the color override, if there is one.
function CoreMeshInstance:ResetColor() end

--- @param typeName string
--- @return boolean
function CoreMeshInstance:IsA(typeName) end

--- @class GlobalCoreMesh : CoreObject @CoreMesh is a CoreObject representing a mesh that can be placed in the scene. It is the parent type for both AnimatedMesh and StaticMesh.
CoreMesh = {}

--- @class CoreObject : Object @CoreObject is an Object placed in the scene hierarchy during edit mode or is part of a template. Usually they'll be a more specific type of CoreObject, but all CoreObjects have these properties and functions:
--- @field childAddedEvent Event @Fired when a child is added to this object.
--- @field childRemovedEvent Event @Fired when a child is removed from this object.
--- @field descendantAddedEvent Event @Fired when a child is added to this object or any of its descendants.
--- @field descendantRemovedEvent Event @Fired when a child is removed from this object or any of its descendants.
--- @field destroyEvent Event @Fired when this object is about to be destroyed.
--- @field customPropertyChangedEvent Event @Fired whenever any of the dynamic custom properties on this object receive an update. The event is fired on the server and the client. Event payload is the owning object and the name of the property that just changed.
--- @field networkedPropertyChangedEvent Event @CoreObject.networkedPropertyChangedEvent is deprecated.  Please use CoreObject.customPropertyChangedEvent instead.
--- @field name string @The object's name as seen in the Hierarchy.
--- @field id string @The object's MUID.
--- @field isVisible boolean
--- @field visibility Visibility @Turn on/off the rendering of an object and its children.
--- @field isCollidable boolean
--- @field collision Collision @Turn on/off the collision of an object and its children.
--- @field cameraCollision Collision @Turn on/off the collision of the camera with an object and its children.
--- @field isEnabled boolean @Turn on/off an object and its children completely.
--- @field lifeSpan number @Duration after which the object is destroyed.
--- @field isStatic boolean @If `true`, dynamic properties may not be written to, and dynamic functions may not be called.
--- @field isNetworked boolean @If `true`, this object replicates from the server to clients.
--- @field isClientOnly boolean @If `true`, this object was spawned on the client and is not replicated from the server.
--- @field isServerOnly boolean @If `true`, this object was spawned on the server and is not replicated to clients.
--- @field parent CoreObject @The object's parent object, may be nil.
--- @field sourceTemplateId string @The ID of the template from which this `CoreObject` was instantiated. `0000000000000000` if this object is not a template. Deinstanced templates also return `0000000000000000`.
--- @field type string
local CoreObjectInstance = {}
--- Returns a CoreObjectReference pointing at this object.
--- @return CoreObjectReference
function CoreObjectInstance:GetReference() end

--- The Transform relative to this object's parent.
--- @return Transform
function CoreObjectInstance:GetTransform() end

--- The Transform relative to this object's parent.
--- @param localTransform Transform
function CoreObjectInstance:SetTransform(localTransform) end

--- The position of this object relative to its parent.
--- @return Vector3
function CoreObjectInstance:GetPosition() end

--- The position of this object relative to its parent.
--- @param localPosition Vector3
function CoreObjectInstance:SetPosition(localPosition) end

--- The rotation relative to its parent.
--- @return Rotation
function CoreObjectInstance:GetRotation() end

--- The rotation relative to its parent.
--- @param localRotation Rotation
function CoreObjectInstance:SetRotation(localRotation) end

--- The scale relative to its parent.
--- @return Vector3
function CoreObjectInstance:GetScale() end

--- The scale relative to its parent.
--- @param localScale Vector3
function CoreObjectInstance:SetScale(localScale) end

--- The absolute Transform of this object.
--- @return Transform
function CoreObjectInstance:GetWorldTransform() end

--- The absolute Transform of this object.
--- @param worldTransform Transform
function CoreObjectInstance:SetWorldTransform(worldTransform) end

--- The absolute position.
--- @return Vector3
function CoreObjectInstance:GetWorldPosition() end

--- The absolute position.
--- @param worldPosition Vector3
function CoreObjectInstance:SetWorldPosition(worldPosition) end

--- The absolute rotation.
--- @return Rotation
function CoreObjectInstance:GetWorldRotation() end

--- The absolute rotation.
--- @param worldRotation Rotation
function CoreObjectInstance:SetWorldRotation(worldRotation) end

--- The absolute scale.
--- @return Vector3
function CoreObjectInstance:GetWorldScale() end

--- The absolute scale.
--- @param worldScale Vector3
function CoreObjectInstance:SetWorldScale(worldScale) end

--- The object's velocity in world space. The velocity vector indicates the direction, with its magnitude expressed in centimeters per second.
--- @return Vector3
function CoreObjectInstance:GetVelocity() end

--- Set the object's velocity in world space. Only works for physics objects. The velocity vector indicates the direction, with its magnitude expressed in centimeters per second.
--- @param velocity Vector3
function CoreObjectInstance:SetVelocity(velocity) end

--- The object's angular velocity in degrees per second.
--- @return Vector3
function CoreObjectInstance:GetAngularVelocity() end

--- Set the object's angular velocity in degrees per second in world space. Only works for physics objects.
--- @param angularVelocity Vector3
function CoreObjectInstance:SetAngularVelocity(angularVelocity) end

--- Set the object's angular velocity in degrees per second in local space. Only works for physics objects.
--- @param localAngularVelocity Vector3
function CoreObjectInstance:SetLocalAngularVelocity(localAngularVelocity) end

--- Returns a table containing the object's children, may be empty. Order is not guaranteed to match what is in the hierarchy.
--- @return table<number, CoreObject>
function CoreObjectInstance:GetChildren() end

--- Attaches a CoreObject to a Player at a specified socket. The CoreObject will be un-parented from its current hierarchy and its `parent` property will be nil. See [Socket Names](../api/animations.md#socket-names) for the list of possible values.
--- @param player Player
--- @param socketName string
function CoreObjectInstance:AttachToPlayer(player, socketName) end

--- Attaches a CoreObject to the local player's camera. Reminder to turn off the object's collision otherwise it will cause camera to jitter.
function CoreObjectInstance:AttachToLocalView() end

--- Detaches a CoreObject from any player it has been attached to, or from its parent object.
function CoreObjectInstance:Detach() end

--- Returns the name of the socket this object is attached to.
--- @return string
function CoreObjectInstance:GetAttachedToSocketName() end

--- Returns true if this object and all of its ancestors are visible.
--- @return boolean
function CoreObjectInstance:IsVisibleInHierarchy() end

--- Returns true if this object and all of its ancestors are collidable.
--- @return boolean
function CoreObjectInstance:IsCollidableInHierarchy() end

--- Returns true if this object and all of its ancestors are collidable with the camera.
--- @return boolean
function CoreObjectInstance:IsCameraCollidableInHierarchy() end

--- Returns true if this object and all of its ancestors are enabled.
--- @return boolean
function CoreObjectInstance:IsEnabledInHierarchy() end

--- Returns the first parent or ancestor whose name matches the provided name. If none match, returns nil.
--- @param name string
--- @return CoreObject
function CoreObjectInstance:FindAncestorByName(name) end

--- Returns the first immediate child whose name matches the provided name. If none match, returns nil.
--- @param name string
--- @return CoreObject
function CoreObjectInstance:FindChildByName(name) end

--- Returns the first child or descendant whose name matches the provided name. If none match, returns nil.
--- @param name string
--- @return CoreObject
function CoreObjectInstance:FindDescendantByName(name) end

--- Returns the descendants whose name matches the provided name. If none match, returns an empty table.
--- @param name string
--- @return table<number, CoreObject>
function CoreObjectInstance:FindDescendantsByName(name) end

--- Returns the first parent or ancestor whose type is or extends the specified type. For example, calling FindAncestorByType('CoreObject') will return the first ancestor that is any type of CoreObject, while FindAncestorByType('StaticMesh') will only return the first mesh. If no ancestors match, returns nil.
--- @param typeName string
--- @return CoreObject
function CoreObjectInstance:FindAncestorByType(typeName) end

--- Returns the first immediate child whose type is or extends the specified type. If none match, returns nil.
--- @param typeName string
--- @return CoreObject
function CoreObjectInstance:FindChildByType(typeName) end

--- Returns the first child or descendant whose type is or extends the specified type. If none match, returns nil.
--- @param typeName string
--- @return CoreObject
function CoreObjectInstance:FindDescendantByType(typeName) end

--- Returns the descendants whose type is or extends the specified type. If none match, returns an empty table.
--- @param typeName string
--- @return table<number, CoreObject>
function CoreObjectInstance:FindDescendantsByType(typeName) end

--- If the object is part of a template, returns the root object of the template (which may be itself). If not part of a template, returns nil.
--- @return CoreObject
function CoreObjectInstance:FindTemplateRoot() end

--- Returns true if this CoreObject is a parent somewhere in the hierarchy above the given parameter object. False otherwise.
--- @param coreObject CoreObject
--- @return boolean
function CoreObjectInstance:IsAncestorOf(coreObject) end

--- Smoothly moves the object to the target location over a given amount of time (seconds). Third parameter specifies if the given destination is in local space (true) or world space (false).
--- @overload fun(self: CoreObject,worldPosition: Vector3,duration: number)
--- @param position Vector3
--- @param duration number
--- @param isLocalPosition boolean
function CoreObjectInstance:MoveTo(position, duration, isLocalPosition) end

--- Smoothly moves the object over time by the given velocity vector. Second parameter specifies if the given velocity is in local space (true) or world space (false). The velocity vector indicates the direction, with its magnitude expressed in centimeters per second.
--- @overload fun(self: CoreObject,worldVelocity: Vector3)
--- @param worldVelocity Vector3
--- @param isLocalVelocity boolean
function CoreObjectInstance:MoveContinuous(worldVelocity, isLocalVelocity) end

--- Follows a CoreObject or Player at a certain speed. If the speed is not supplied it will follow as fast as possible. The third parameter specifies a distance to keep away from the target.
--- @overload fun(self: CoreObject,target: Player,speed: number)
--- @overload fun(self: CoreObject,target: Player)
--- @overload fun(self: CoreObject,target: CoreObject,speed: number,minimumDistance: number)
--- @overload fun(self: CoreObject,target: CoreObject,speed: number)
--- @overload fun(self: CoreObject,target: CoreObject)
--- @param target Player
--- @param speed number
--- @param minimumDistance number
function CoreObjectInstance:Follow(target, speed, minimumDistance) end

--- Interrupts further movement from MoveTo(), MoveContinuous(), or Follow().
function CoreObjectInstance:StopMove() end

--- Smoothly rotates the object to the target orientation over a given amount of time. Third parameter specifies if given rotation is in local space (true) or world space (false).
--- @overload fun(self: CoreObject,worldRotation: Quaternion,duration: number)
--- @overload fun(self: CoreObject,rotation: Rotation,duration: number,isLocalRotation: boolean)
--- @overload fun(self: CoreObject,worldRotation: Rotation,duration: number)
--- @param rotation Quaternion
--- @param duration number
--- @param isLocalRotation boolean
function CoreObjectInstance:RotateTo(rotation, duration, isLocalRotation) end

--- Smoothly rotates the object over time by the given rotation (per second). The second parameter is an optional multiplier, for very fast rotations. Third parameter specifies if the given rotation or quaternion is in local space (true) or world space (false (default)). Angular velocity is expressed in degrees per second.
--- @overload fun(self: CoreObject,angularVelocity: Vector3)
--- @overload fun(self: CoreObject,quaternionSpeed: Quaternion,multiplier: number,isLocalQuaternionSpeed: boolean)
--- @overload fun(self: CoreObject,quaternionSpeed: Quaternion,multiplier: number)
--- @overload fun(self: CoreObject,quaternionSpeed: Quaternion)
--- @overload fun(self: CoreObject,rotationSpeed: Rotation,multiplier: number,isLocalRotationSpeed: boolean)
--- @overload fun(self: CoreObject,rotationSpeed: Rotation,multiplier: number)
--- @overload fun(self: CoreObject,rotationSpeed: Rotation)
--- @param angularVelocity Vector3
--- @param isLocalAngularVelocity boolean
function CoreObjectInstance:RotateContinuous(angularVelocity, isLocalAngularVelocity) end

--- Instantly rotates the object to look at the given position.
--- @param worldPosition Vector3
function CoreObjectInstance:LookAt(worldPosition) end

--- Smoothly rotates a CoreObject to look at another given CoreObject or Player. Second parameter is optional and locks the pitch, default is unlocked. Third parameter is optional and sets how fast it tracks the target (in radians/second). If speed is not supplied it tracks as fast as possible.
--- @overload fun(self: CoreObject,target: Player,speed: number)
--- @overload fun(self: CoreObject,target: Player,isPitchLocked: boolean)
--- @overload fun(self: CoreObject,target: Player)
--- @overload fun(self: CoreObject,target: CoreObject,isPitchLocked: boolean,speed: number)
--- @overload fun(self: CoreObject,target: CoreObject,speed: number)
--- @overload fun(self: CoreObject,target: CoreObject,isPitchLocked: boolean)
--- @overload fun(self: CoreObject,target: CoreObject)
--- @param target Player
--- @param isPitchLocked boolean
--- @param speed number
function CoreObjectInstance:LookAtContinuous(target, isPitchLocked, speed) end

--- Continuously looks at the local camera. The boolean parameter is optional and locks the pitch.
--- @overload fun(self: CoreObject)
--- @param isPitchLocked boolean
function CoreObjectInstance:LookAtLocalView(isPitchLocked) end

--- Interrupts further rotation from RotateTo(), RotateContinuous(), LookAtContinuous(), or LookAtLocalView().
function CoreObjectInstance:StopRotate() end

--- Smoothly scales the object to the target scale over a given amount of time. Third parameter specifies if the given scale is in local space (true) or world space (false).
--- @overload fun(self: CoreObject,worldScale: Vector3,duration: number)
--- @param scale Vector3
--- @param duration number
--- @param isScaleLocal boolean
function CoreObjectInstance:ScaleTo(scale, duration, isScaleLocal) end

--- Smoothly scales the object over time by the given scale vector per second. Second parameter specifies if the given scale rate is in local space (true) or world space (false).
--- @overload fun(self: CoreObject,scaleRate: Vector3)
--- @param scaleRate Vector3
--- @param isLocalScaleRate boolean
function CoreObjectInstance:ScaleContinuous(scaleRate, isLocalScaleRate) end

--- Interrupts further movement from ScaleTo() or ScaleContinuous().
function CoreObjectInstance:StopScale() end

--- Reorders this object before all of its siblings in the hierarchy.
function CoreObjectInstance:ReorderBeforeSiblings() end

--- Reorders this object after all of its siblings in the hierarchy.
function CoreObjectInstance:ReorderAfterSiblings() end

--- Reorders this object just before the specified sibling in the hierarchy.
--- @param sibling CoreObject
function CoreObjectInstance:ReorderBefore(sibling) end

--- Reorders this object just after the specified sibling in the hierarchy.
--- @param sibling CoreObject
function CoreObjectInstance:ReorderAfter(sibling) end

--- Destroys the object and all descendants. You can check whether an object has been destroyed by calling `Object.IsValid(object)`, which will return true if object is still a valid object, or false if it has been destroyed.
function CoreObjectInstance:Destroy() end

--- Returns a table containing the names and values of all custom properties on a CoreObject.
--- @return table
function CoreObjectInstance:GetCustomProperties() end

--- Gets data which has been added to an object using the custom property system. Returns the value, which can be an integer, number, boolean, string, Vector2, Vector3, Vector4, Rotation, Color, CoreObjectReference, a MUID string (for Asset References), NetReference, or nil if not found. Second return value is a boolean, true if found and false if not.
--- @param propertyName string
--- @return any|boolean
function CoreObjectInstance:GetCustomProperty(propertyName) end

--- Sets the named custom property if it is marked as dynamic and the object it belongs to is server-side networked or in a client/server context. The value must match the existing type of the property, with the exception of CoreObjectReference properties (which accept a CoreObjectReference or a CoreObject) and Asset Reference properties (which accept a string MUID). AssetReferences, CoreObjectReferences, and NetReferences also accept `nil` to clear their value, although `GetCustomProperty()` will still return an unassigned CoreObjectReference or NetReference rather than `nil`. (See the `.isAssigned` property on those types.)
--- @param propertyName string
--- @param propertyValue any
--- @return boolean
function CoreObjectInstance:SetCustomProperty(propertyName, propertyValue) end

--- *This function is deprecated. Please use `CoreObject:SetCustomProperty()` instead.* Sets the named custom property if it is marked as replicated and the object it belongs to is server-side networked. The value must match the existing type of the property, with the exception of CoreObjectReference properties (which accept a CoreObjectReference or a CoreObject) and Asset Reference properties (which accept a string MUID). AssetReferences, CoreObjectReferences, and NetReferences also accept `nil` to clear their value, although `GetCustomProperty()` will still return an unassigned CoreObjectReference or NetReference rather than `nil`. (See the `.isAssigned` property on those types.)
--- @param propertyName string
--- @param propertyValue any
--- @return boolean
function CoreObjectInstance:SetNetworkedCustomProperty(propertyName, propertyValue) end

--- Returns `true` if the named custom property exists and is marked as dynamic. Otherwise, returns `false`.
--- @param propertyName string
--- @return boolean
function CoreObjectInstance:IsCustomPropertyDynamic(propertyName) end

--- Returns `true` if the object has replication enabled, else returns `false`.
--- @return boolean
function CoreObjectInstance:IsReplicationEnabled() end

--- Enables/Disables replication for the networked object.
--- @param isReplicationEnabled boolean
function CoreObjectInstance:SetReplicationEnabled(isReplicationEnabled) end

--- If the networked object does not have replication enabled and this call is made, this will force it to replicate its current state.
function CoreObjectInstance:ForceReplication() end

--- @param typeName string
--- @return boolean
function CoreObjectInstance:IsA(typeName) end

--- @class GlobalCoreObject : Object @CoreObject is an Object placed in the scene hierarchy during edit mode or is part of a template. Usually they'll be a more specific type of CoreObject, but all CoreObjects have these properties and functions:
CoreObject = {}

--- @class CoreObjectReference @A reference to a CoreObject which may or may not exist. This type is returned by `CoreObject:GetCustomProperty()` for CoreObjectReference properties, and may be used to find the actual object if it exists.. . In the case of networked objects it's possible to get a CoreObjectReference pointing to a CoreObject that hasn't been received on the client yet.
--- @field id string @The MUID of the referred object.
--- @field isAssigned boolean @Returns true if this reference has been assigned a valid ID. This does not necessarily mean the object currently exists.
--- @field type string
local CoreObjectReferenceInstance = {}
--- Returns the CoreObject with a matching ID, if it exists. Will otherwise return nil.
--- @return CoreObject
function CoreObjectReferenceInstance:GetObject() end

--- Returns the CoreObject with a matching ID, if it exists. If it does not, yields the current task until the object is spawned. Optional timeout parameter will cause the task to resume with a return value of false and an error message if the object has not been spawned within that many seconds.
--- @overload fun(): CoreObject
--- @param timeout number
--- @return CoreObject
function CoreObjectReferenceInstance:WaitForObject(timeout) end

--- @param typeName string
--- @return boolean
function CoreObjectReferenceInstance:IsA(typeName) end

--- @class GlobalCoreObjectReference @A reference to a CoreObject which may or may not exist. This type is returned by `CoreObject:GetCustomProperty()` for CoreObjectReference properties, and may be used to find the actual object if it exists.. . In the case of networked objects it's possible to get a CoreObjectReference pointing to a CoreObject that hasn't been received on the client yet.
CoreObjectReference = {}

--- @class CorePlayerProfile @Public account profile for a player on the Core platform.
--- @field id string @The ID of the player.
--- @field name string @The name of the player. This field does not reflect changes that may have been made to the `name` property of a `Player` currently in the game.
--- @field description string @A description of the player, provided by the player in the About section of their profile.
--- @field type string
local CorePlayerProfileInstance = {}
--- @param typeName string
--- @return boolean
function CorePlayerProfileInstance:IsA(typeName) end

--- @class GlobalCorePlayerProfile @Public account profile for a player on the Core platform.
CorePlayerProfile = {}

--- @class CurveKey @A `CurveKey` represents a key point on a `SimpleCurve`, providing a value for a specific point in time on that curve. Additional properties may be used to control the shape of that curve.
--- @field interpolation CurveInterpolation @The interpolation mode between this curve key and the next.
--- @field time number @The time at this curve key.
--- @field value number @The value at this curve key.
--- @field arriveTangent number @The arriving tangent at this key when using cubic interpolation.
--- @field leaveTangent number @The leaving tangent at this key when using cubic interpolation.
--- @field type string
local CurveKeyInstance = {}
--- @param typeName string
--- @return boolean
function CurveKeyInstance:IsA(typeName) end

--- @class GlobalCurveKey @A `CurveKey` represents a key point on a `SimpleCurve`, providing a value for a specific point in time on that curve. Additional properties may be used to control the shape of that curve.
CurveKey = {}
--- Constructs a new CurveKey.
--- @overload fun(time: number,value: number,optionalParameters: table): CurveKey
--- @overload fun(time: number,value: number): CurveKey
--- @overload fun(): CurveKey
--- @param other CurveKey
--- @return CurveKey
function CurveKey.New(other) end


--- @class CustomMaterial @CustomMaterial objects represent a custom material made in core. They can have their properties changed from script.
--- @field type string
local CustomMaterialInstance = {}
--- Sets the given property of the material.
--- @overload fun(self: CustomMaterial,propertyName: string,value: boolean)
--- @overload fun(self: CustomMaterial,propertyName: string,value: Vector3)
--- @overload fun(self: CustomMaterial,propertyName: string,value: Color)
--- @overload fun(self: CustomMaterial,propertyName: string,value: number)
--- @param propertyName string
--- @param value Vector2
function CustomMaterialInstance:SetProperty(propertyName, value) end

--- Gets the value of a given property.
--- @param propertyName string
--- @return any
function CustomMaterialInstance:GetProperty(propertyName) end

--- Returns an array of all property names on this CustomMaterial.
--- @return table<number, string>
function CustomMaterialInstance:GetPropertyNames() end

--- Returns the asset id of the material this CustomMaterial was based on.
--- @return string
function CustomMaterialInstance:GetBaseMaterialId() end

--- @param typeName string
--- @return boolean
function CustomMaterialInstance:IsA(typeName) end

--- @class GlobalCustomMaterial @CustomMaterial objects represent a custom material made in core. They can have their properties changed from script.
CustomMaterial = {}
--- Returns a CustomMaterial with the given assetId. This function may yield while loading data.
--- @param assetId string
--- @return CustomMaterial
function CustomMaterial.Find(assetId) end


--- @class Damage @To damage a Player, you can simply write for example: `whichPlayer:ApplyDamage(Damage.New(10))`. Alternatively, create a Damage object and populate it with all the following properties to get full use out of the system:
--- @field amount number @The numeric amount of damage to inflict.
--- @field reason DamageReason @What is the context for this Damage? DamageReason.UNKNOWN (default value), DamageReason.COMBAT, DamageReason.FRIENDLY_FIRE, DamageReason.MAP, DamageReason.NPC.
--- @field sourceAbility Ability @Reference to the Ability which caused the Damage. Setting this allows other systems to react to the damage event, for example a kill feed can show what killed a Player.
--- @field sourcePlayer Player @Reference to the Player who caused the Damage. Setting this allows other systems to react to the damage event, for example a kill feed can show who killed a Player.
--- @field type string
local DamageInstance = {}
--- Get the HitResult information if this damage was caused by a Projectile impact.
--- @return HitResult
function DamageInstance:GetHitResult() end

--- Forward the HitResult information if this damage was caused by a Projectile impact.
--- @param hitResult HitResult
function DamageInstance:SetHitResult(hitResult) end

--- @param typeName string
--- @return boolean
function DamageInstance:IsA(typeName) end

--- @class GlobalDamage @To damage a Player, you can simply write for example: `whichPlayer:ApplyDamage(Damage.New(10))`. Alternatively, create a Damage object and populate it with all the following properties to get full use out of the system:
Damage = {}
--- Constructs a damage object with the given number, defaults to 0.
--- @overload fun(): Damage
--- @param amount number
--- @return Damage
function Damage.New(amount) end


--- @class DamageableObject : CoreObject @DamageableObject is a CoreObject which implements the [Damageable](damageable.md) interface.
--- @field damagedEvent Event @Fired when the object takes damage.
--- @field diedEvent Event @Fired when the object dies.
--- @field damageHook Hook @Hook called when applying damage from a call to `ApplyDamage()`. The incoming damage may be modified or prevented by modifying properties on the `damage` parameter.
--- @field hitPoints number @Current amount of hit points.
--- @field maxHitPoints number @Maximum amount of hit points.
--- @field isDead boolean @True if the object is dead, otherwise false. Death occurs when damage is applied which reduces hit points to 0, or when the `Die()` function is called.
--- @field isImmortal boolean @When set to `true`, this object cannot die.
--- @field isInvulnerable boolean @When set to `true`, this object does not take damage.
--- @field destroyOnDeath boolean @When set to `true`, this object will automatically be destroyed when it dies.
--- @field destroyOnDeathDelay number @Delay in seconds after death before this object is destroyed, if `destroyOnDeath` is set to `true`. Defaults to 0.
--- @field destroyOnDeathClientTemplateId string @Optional asset ID of a template to be spawned on clients when this object is automatically destroyed on death.
--- @field destroyOnDeathNetworkedTemplateId string @Optional asset ID of a networked template to be spawned on the server when this object is automatically destroyed on death.
--- @field type string
local DamageableObjectInstance = {}
--- Damages the object, unless it is invulnerable. If its hit points reach 0 and it is not immortal, it dies.
--- @param damage Damage
function DamageableObjectInstance:ApplyDamage(damage) end

--- Kills the object, unless it is immortal. The optional Damage parameter is a way to communicate cause of death.
--- @overload fun(self: DamageableObject)
--- @param damage Damage
function DamageableObjectInstance:Die(damage) end

--- @param typeName string
--- @return boolean
function DamageableObjectInstance:IsA(typeName) end

--- @class GlobalDamageableObject : CoreObject @DamageableObject is a CoreObject which implements the [Damageable](damageable.md) interface.
DamageableObject = {}

--- @class DateTime @An immutable representation of a date and time, which may be either local time or UTC.
--- @field year number @The year component of this DateTime.
--- @field month number @The month component of this DateTime, from 1 to 12.
--- @field day number @The day component of this DateTime, from 1 to 31.
--- @field hour number @The hour component of this DateTime, from 0 to 23.
--- @field minute number @The minute component of this DateTime, from 0 to 59.
--- @field second number @The second component of this DateTime, from 0 to 59.
--- @field millisecond number @The millisecond component of this DateTime, from 0 to 999.
--- @field isLocal boolean @True if this DateTime is in the local time zone, false if it's UTC.
--- @field secondsSinceEpoch number @Returns the number of seconds since midnight, January 1, 1970, UTC. Note that this ignores the millisecond component of this DateTime.
--- @field millisecondsSinceEpoch number @Returns the number of milliseconds since midnight, January 1, 1970, UTC.
--- @field type string
local DateTimeInstance = {}
--- Returns a copy of this DateTime adjusted to local time. If this DateTime is already in local time, simply returns a copy of this DateTime.
--- @return DateTime
function DateTimeInstance:ToLocalTime() end

--- Returns a copy of this DateTime adjusted to UTC. If this DateTime is already in UTC, simply returns a copy of this DateTime.
--- @return DateTime
function DateTimeInstance:ToUtcTime() end

--- Returns this date and time, adjusted to UTC, formatted as an ISO 8601 string (`YYYY-mm-ddTHH:MM:SS.sssZ`)
--- @return string
function DateTimeInstance:ToIsoString() end

--- @param typeName string
--- @return boolean
function DateTimeInstance:IsA(typeName) end

--- @class GlobalDateTime @An immutable representation of a date and time, which may be either local time or UTC.
DateTime = {}
--- Returns the current date and time in UTC. The `optionalParameters` table may contain the following values to change the date and time returned:
--- 
--- `isLocal (boolean)`: If true, the current local time will be returned instead of UTC.
--- @overload fun(): DateTime
--- @param optionalParameters table
--- @return DateTime
function DateTime.CurrentTime(optionalParameters) end

--- Returns the date and time that is `secondsSinceEpoch` seconds since midnight, January 1, 1970, UTC.
--- @param timestampInSeconds number
--- @return DateTime
function DateTime.FromSecondsSinceEpoch(timestampInSeconds) end

--- Returns the date and time that is `millisecondsSinceEpoch` milliseconds since midnight, January 1, 1970, UTC.
--- @param timestampInMs number
--- @return DateTime
function DateTime.FromMillisecondsSinceEpoch(timestampInMs) end

--- Parses the given string as an ISO 8601 formatted date (`YYYY-MM-DD`) or date and time (`YYYY-mm-ddTHH:MM:SS(.sss)(Z/+hh:mm/+hhmm/-hh:mm/-hhmm)`). Returns the parsed UTC DateTime, or `nil` if the string was an invalid format.
--- @param timeString string
--- @return DateTime
function DateTime.FromIsoString(timeString) end

--- Constructs a new DateTime instance, defaulting to midnight on January 1, 1970, UTC. The `parameters` table may contain the following values to specify the date and time:
--- 
--- `year (integer)`: Specifies the year.
--- 
--- `month (integer)`: Specifies the month, from 1 to 12.
--- 
--- `day (integer)`: Specifies the day of the month, from 1 to the last day of the specified month.
--- 
--- `hour (integer)`: Specifies the hour of the day, from 0 to 23.
--- 
--- `minute (integer)`: Specifies the minute, from 0 to 59.
--- 
--- `second (integer)`: Specifies the second, from 0 to 59.
--- 
--- `millisecond (integer)`: Specifies the millisecond, from 0 to 999.
--- 
--- `isLocal (boolean)`: If true, the new DateTime will be in local time. Defaults to false for UTC.
--- 
--- Values outside of the supported range for each field will be clamped, and a warning will be logged.
--- @overload fun(): DateTime
--- @param timeParameterTable table
--- @return DateTime
function DateTime.New(timeParameterTable) end


--- @class Decal : SmartObject @A Decal is a SmartObject representing a decal that is projected onto nearby surfaces.
--- @field type string
local DecalInstance = {}
--- @param typeName string
--- @return boolean
function DecalInstance:IsA(typeName) end

--- @class GlobalDecal : SmartObject @A Decal is a SmartObject representing a decal that is projected onto nearby surfaces.
Decal = {}

--- @class Equipment : CoreObject @Equipment is a CoreObject representing an equippable item for players. They generally have a visual component that attaches to the Player, but a visual component is not a requirement. Any Ability objects added as children of the Equipment are added/removed from the Player automatically as it becomes equipped/unequipped.
--- @field equippedEvent Event @Fired when this equipment is equipped onto a player.
--- @field unequippedEvent Event @Fired when this object is unequipped from a player.
--- @field owner Player @Which Player the Equipment is attached to.
--- @field socket string @Determines which point on the avatar's body this equipment will be attached. See [Socket Names](../api/animations.md#socket-names) for the list of possible values.
--- @field type string
local EquipmentInstance = {}
--- A table of Abilities that are assigned to this Equipment. Players who equip it will get these Abilities.
--- @return table<number, Ability>
function EquipmentInstance:GetAbilities() end

--- Attaches the Equipment to a Player. They gain any abilities assigned to the Equipment. If the Equipment is already attached to another Player it will first unequip from that other Player before equipping unto the new one.
--- @param player Player
function EquipmentInstance:Equip(player) end

--- Detaches the Equipment from any Player it may currently be attached to. The Player loses any abilities granted by the Equipment.
function EquipmentInstance:Unequip() end

--- Adds an Ability to the list of abilities on this Equipment.
--- @param ability Ability
function EquipmentInstance:AddAbility(ability) end

--- @param typeName string
--- @return boolean
function EquipmentInstance:IsA(typeName) end

--- @class GlobalEquipment : CoreObject @Equipment is a CoreObject representing an equippable item for players. They generally have a visual component that attaches to the Player, but a visual component is not a requirement. Any Ability objects added as children of the Equipment are added/removed from the Player automatically as it becomes equipped/unequipped.
Equipment = {}

--- @class Event @Events appear as properties on several objects. The goal is to register a function that will be fired whenever that event happens. For example `playerA.damagedEvent:Connect(OnPlayerDamaged)` chooses the function `OnPlayerDamaged` to be fired whenever `playerA` takes damage.
--- @field type string
local EventInstance = {}
--- Registers the given function which will be called every time the event is fired. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. Accepts any number of additional arguments after the listener function, those arguments will be provided after the event's own parameters.
--- @param listener function
--- @return EventListener
function EventInstance:Connect(listener, ...) end

--- @param typeName string
--- @return boolean
function EventInstance:IsA(typeName) end

--- @class GlobalEvent @Events appear as properties on several objects. The goal is to register a function that will be fired whenever that event happens. For example `playerA.damagedEvent:Connect(OnPlayerDamaged)` chooses the function `OnPlayerDamaged` to be fired whenever `playerA` takes damage.
Event = {}

--- @class EventListener @EventListeners are returned by Events when you connect a listener function to them.
--- @field isConnected boolean @Returns true if this listener is still connected to its event. false if the event owner was destroyed or if Disconnect was called.
--- @field type string
local EventListenerInstance = {}
--- Disconnects this listener from its event, so it will no longer be called when the event is fired.
function EventListenerInstance:Disconnect() end

--- @param typeName string
--- @return boolean
function EventListenerInstance:IsA(typeName) end

--- @class GlobalEventListener @EventListeners are returned by Events when you connect a listener function to them.
EventListener = {}

--- @class Folder : CoreObject @Folder is a [CoreObject](coreobject.md) representing a folder containing other objects.. . They have no properties or functions of their own, but inherit everything from [CoreObject](coreobject.md).
--- @field type string
local FolderInstance = {}
--- @param typeName string
--- @return boolean
function FolderInstance:IsA(typeName) end

--- @class GlobalFolder : CoreObject @Folder is a [CoreObject](coreobject.md) representing a folder containing other objects.. . They have no properties or functions of their own, but inherit everything from [CoreObject](coreobject.md).
Folder = {}

--- @class FourWheeledVehicle : Vehicle @FourWheeledVehicle is a Vehicle with wheels. (Four of them.)
--- @field turnRadius number @The radius, in centimeters, measured by the inner wheels of the vehicle while making a turn.
--- @field type string
local FourWheeledVehicleInstance = {}
--- @param typeName string
--- @return boolean
function FourWheeledVehicleInstance:IsA(typeName) end

--- @class GlobalFourWheeledVehicle : Vehicle @FourWheeledVehicle is a Vehicle with wheels. (Four of them.)
FourWheeledVehicle = {}

--- @class HitResult @Contains data pertaining to an impact or raycast.
--- @field other CoreObject|Player @Reference to a CoreObject or Player impacted.
--- @field socketName string @If the hit was on a Player, `socketName` tells you which spot on the body was hit.
--- @field type string
local HitResultInstance = {}
--- The world position where the impact occurred.
--- @return Vector3
function HitResultInstance:GetImpactPosition() end

--- Normal direction of the surface which was impacted.
--- @return Vector3
function HitResultInstance:GetImpactNormal() end

--- For HitResults returned by box casts and sphere casts, returns the world position of the center of the cast shape when the collision occurred. In the case of HitResults not related to a box cast or sphere cast, returns the world position where the impact occurred.
--- @return Vector3
function HitResultInstance:GetShapePosition() end

--- Returns a Transform composed of the position of the impact in world space, the rotation of the normal, and a uniform scale of 1.
--- @return Transform
function HitResultInstance:GetTransform() end

--- For HitResults involving a `CoreMesh`, returns a MaterialSlot instance indicating which material on the mesh was impacted. For certain types of collisions, including when the impacted object is not a `CoreMesh`, a `MaterialSlot` is not available, and `nil` is returned.
--- @return MaterialSlot
function HitResultInstance:GetMaterialSlot() end

--- @param typeName string
--- @return boolean
function HitResultInstance:IsA(typeName) end

--- @class GlobalHitResult @Contains data pertaining to an impact or raycast.
HitResult = {}

--- @class Hook @Hooks appear as properties on several objects. Similar to Events, functions may be registered that will be called whenever that hook is fired, but Hooks allow those functions to modify the parameters given to them. For example `player.movementHook:Connect(OnPlayerMovement)` calls the function `OnPlayerMovement` each tick, which may modify the direction in which a player will move.
--- @field type string
local HookInstance = {}
--- Registers the given function which will be called every time the hook is fired. Returns a HookListener which can be used to disconnect from the hook or change the listener's priority. Accepts any number of additional arguments after the listener function, those arguments will be provided after the hook's own parameters.
--- @param listener function
--- @return HookListener
function HookInstance:Connect(listener, ...) end

--- @param typeName string
--- @return boolean
function HookInstance:IsA(typeName) end

--- @class GlobalHook @Hooks appear as properties on several objects. Similar to Events, functions may be registered that will be called whenever that hook is fired, but Hooks allow those functions to modify the parameters given to them. For example `player.movementHook:Connect(OnPlayerMovement)` calls the function `OnPlayerMovement` each tick, which may modify the direction in which a player will move.
Hook = {}

--- @class HookListener @HookListeners are returned by Hooks when you connect a listener function to them.
--- @field isConnected boolean @Returns `true` if this listener is still connected to its hook, `false` if the hook owner was destroyed or if `Disconnect` was called.
--- @field priority number @The priority of this listener. When a given hook is fired, listeners with a higher priority are called first. Default value is `100`.
--- @field type string
local HookListenerInstance = {}
--- Disconnects this listener from its hook, so it will no longer be called when the hook is fired.
function HookListenerInstance:Disconnect() end

--- @param typeName string
--- @return boolean
function HookListenerInstance:IsA(typeName) end

--- @class GlobalHookListener @HookListeners are returned by Hooks when you connect a listener function to them.
HookListener = {}

--- @class IKAnchor : CoreObject @IKAnchors are objects that can be used to control player animations. They can be used to specify the position of a specific hand, foot, or the hips of a player, and can be controlled from script to create complex animations.
--- @field activatedEvent Event @Fired when this IKAnchor is activated on a player.
--- @field deactivatedEvent Event @Fired when this IKAnchor is deactivated from a player.
--- @field target Player @Which Player the IKAnchor is activated on.
--- @field anchorType IKAnchorType @Which socket this IKAnchor applies to.
--- @field blendInTime number @The duration over which this IKAnchor is blended when it is activated.
--- @field blendOutTime number @The duration over which this IKAnchor is blended when it is deactivated.
--- @field weight number @The amount this IKAnchor blends with the underlying animation. A value of 0 means the animation is player unchanged, and a value of 1 means the animation is ignored and the IKAnchor is used.
--- @field type string
local IKAnchorInstance = {}
--- Activates the IKAnchor on the given player.
--- @param target Player
function IKAnchorInstance:Activate(target) end

--- Deactivates the IKAnchor from whatever player it is active on.
function IKAnchorInstance:Deactivate() end

--- Returns the aim offset property.
--- @return Vector3
function IKAnchorInstance:GetAimOffset() end

--- Sets the aim offset of this IKAnchor.
--- @param aimOffset Vector3
function IKAnchorInstance:SetAimOffset(aimOffset) end

--- @param typeName string
--- @return boolean
function IKAnchorInstance:IsA(typeName) end

--- @class GlobalIKAnchor : CoreObject @IKAnchors are objects that can be used to control player animations. They can be used to specify the position of a specific hand, foot, or the hips of a player, and can be controlled from script to create complex animations.
IKAnchor = {}

--- @class ImpactData @A data structure containing all information about a specific Weapon interaction, such as collision with a character.
--- @field targetObject CoreObject|Player @Reference to the CoreObject/Player hit by the Weapon.
--- @field projectile Projectile @Reference to a Projectile, if one was produced as part of this interaction.
--- @field sourceAbility Ability @Reference to the Ability which initiated the interaction.
--- @field weapon Weapon @Reference to the Weapon that is interacting.
--- @field weaponOwner Player @Reference to the Player who had the Weapon equipped at the time it was activated, ultimately leading to this interaction.
--- @field isHeadshot boolean @True if the Weapon hit another player in the head.
--- @field travelDistance number @The distance in cm between where the Weapon attack started until it impacted something.
--- @field type string
local ImpactDataInstance = {}
--- Physics information about the impact between the Weapon and the other object.
--- @return HitResult
function ImpactDataInstance:GetHitResult() end

--- Table with multiple HitResults that hit the same object, in the case of Weapons with multi-shot (for example Shotguns). If a single attack hits multiple targets you receive a separate interaction event for each object hit.
--- @return table<number, HitResult>
function ImpactDataInstance:GetHitResults() end

--- @param typeName string
--- @return boolean
function ImpactDataInstance:IsA(typeName) end

--- @class GlobalImpactData @A data structure containing all information about a specific Weapon interaction, such as collision with a character.
ImpactData = {}

--- @class Inventory : CoreObject @Inventory is a CoreObject that represents a container of InventoryItems. Items can be added directly to an inventory, picked up from an ItemObject in the world, or transferred between inventories. An Inventory may be assigned to a Player, and Players may have any number of Inventories.
--- @field ownerChangedEvent Event @Fired when the inventory's owner has changed.
--- @field resizedEvent Event @Fired when the inventory's size has changed.
--- @field changedEvent Event @Fired when the contents of an inventory slot have changed. This includes when the item in that slot is added, given, received, dropped, moved, resized, or removed.
--- @field itemPropertyChangedEvent Event @Fired when an inventory item's dynamic custom property value has changed.
--- @field owner Player @The Player who currently owns the inventory. May be `nil`. Change owners with `Assign()` or `Unassign()`.
--- @field slotCount number @The number of unique inventory item stacks this inventory can hold. Zero or negative numbers indicate no limit.
--- @field emptySlotCount number @The number of slots in the inventory that do not contain an inventory item stack.
--- @field occupiedSlotCount number @The number of slots in the inventory that contain an inventory item stack.
--- @field type string
local InventoryInstance = {}
--- Sets the owner property of the inventory to the specified player. When a networked inventory is assigned to a player, only that player's client will be able to access the inventory contents.
--- @param player Player
function InventoryInstance:Assign(player) end

--- Clears the owner property of the inventory. The given inventory will now be accessible to all clients.
function InventoryInstance:Unassign() end

--- Returns the contents of the specified slot. Returns `nil` if the slot is empty.
--- @param slot number
--- @return InventoryItem
function InventoryInstance:GetItem(slot) end

--- Returns a table mapping integer slot number to the inventory item in that slot. Note that this may leave gaps in the table if the inventory contains empty slots, so use with `ipairs()` is not recommended. Returns an empty table if the inventory is empty.
--- 
--- Supported parameters include:
--- 
--- `itemAssetId (string)`: If specified, filters the results by the specified item asset reference. Useful for getting all inventory items of a specific type.
--- @overload fun(): table
--- @param optionalParameters table
--- @return table
function InventoryInstance:GetItems(optionalParameters) end

--- Removes all items from the inventory.
function InventoryInstance:ClearItems() end

--- Reorganizes inventory items into sequential slots starting with slot 1. Does not perform any consolidation of item stacks of the same type. Use `ConsolidateItems()` first if this behavior is desired.
function InventoryInstance:SortItems() end

--- Combines stacks of inventory items into as few slots as possible based on the `maximumStackCount` of each item. Slots may be emptied by this operation, but are otherwise not sorted or reorganized.
function InventoryInstance:ConsolidateItems() end

--- Checks if there are enough slots for all current contents of the inventory if the inventory were to be resized. Returns `true` if the inventory can be resized to the new size or `false` if it cannot.
--- @param newSize number
--- @return boolean
function InventoryInstance:CanResize(newSize) end

--- Changes the number of slots of the inventory. There must be enough slots to contain all of the items currently in the inventory or the operation will fail. This operation will move items into empty slots if necessary, but it will not consolidate item stacks, even if doing so would create sufficient space for the operation to succeed. Use `ConsolidateItems()` first if this behavior is desired. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed.
--- @param newSize number
--- @return boolean
function InventoryInstance:Resize(newSize) end

--- Checks for room to add the specified item to this inventory. If the item can be added to the inventory, returns `true`. If the inventory is full or the item otherwise cannot be added, returns `false`. Supports the same parameters as `AddItem()`.
--- @overload fun(itemAssetId: string): boolean
--- @param itemAssetId string
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:CanAddItem(itemAssetId, optionalParameters) end

--- Attempts to add the specified item to this inventory. If the item was successfully added to the inventory, returns `true`. If the inventory was full or the item otherwise wasn't added, returns `false`.
--- 
--- Supported parameters include:
--- 
--- `count (integer)`: Specifies the number of items to create and add to the inventory. Defaults to 1.
--- 
--- `slot (integer)`: Attempts to create the item directly into the specified slot. If unspecified, the inventory will either look to stack this item with other items of the same `itemAssetId`, or will look to find the first empty slot.
--- 
--- `customProperties (table)`: Applies initial property values to any dynamic properties on the item. Attempting to specify a property that does not exist will yield a warning. Attempting to specify a property that does exist and is not dynamic will raise an error. Providing a property value of the incorrect type will raise an error.
--- @overload fun(itemAssetId: string): boolean
--- @param itemAssetId string
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:AddItem(itemAssetId, optionalParameters) end

--- Checks for room in an existing stack or free inventory slots to add the given item to the inventory. If the item can be added to the inventory, returns `true`. If the inventory is full or the item otherwise cannot be added, returns `false`. Supports the same parameters as `PickUpItem()`.
--- @overload fun(itemObject: ItemObject): boolean
--- @param itemObject ItemObject
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:CanPickUpItem(itemObject, optionalParameters) end

--- Creates an inventory item from an ItemObject that exists in the world, taking 1 count from the ItemObject. Destroys the ItemObject if the inventory item is successfully created and the ItemObject count has been reduced to zero. Returns `true` if the item was picked up. Returns `false` and logs a warning if the item could not be picked up.
--- 
--- Supported parameters include:
--- 
--- `count (integer)`: Determines the number of items taken from the specified ItemObject. If the ItemObject still has a count greater than zero after this operation, it is not destroyed. Defaults to 1.
--- 
--- `all (boolean)`: If `true`, picks up all of the given item's count instead of just 1. Overrides `count` if both are specified.
--- @overload fun(itemObject: ItemObject): boolean
--- @param itemObject ItemObject
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:PickUpItem(itemObject, optionalParameters) end

--- Checks if an item can be moved from one slot to another. If the item can be moved, returns `true`. Returns `false` if it cannot be moved. Supports the same parameters as `MoveFromSlot()`.
--- @overload fun(fromSlot: number,toSlot: number): boolean
--- @param fromSlot number
--- @param toSlot number
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:CanMoveFromSlot(fromSlot, toSlot, optionalParameters) end

--- Moves an inventory item and its entire count from one slot to another. If the target slot is empty, the stack is moved. If the target slot is occupied by a matching item, the stack will merge as much as it can up to its `maximumStackCount`. If the target slot is occupied by a non-matching item, the stacks will swap. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed.
--- 
--- Supported parameters include:
--- 
--- `count (integer)`: Specifies the number of items to move. When swapping with another stack containing a non-matching item, this operation will fail unless `count` is the entire stack.
--- @overload fun(fromSlot: number,toSlot: number): boolean
--- @param fromSlot number
--- @param toSlot number
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:MoveFromSlot(fromSlot, toSlot, optionalParameters) end

--- Checks if an item can be removed from the inventory. If the item can be removed, returns `true`. Returns `false` if it cannot be removed. Supports the same parameters as `RemoveItem()`.
--- @overload fun(itemAssetId: string): boolean
--- @param itemAssetId string
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:CanRemoveItem(itemAssetId, optionalParameters) end

--- Deletes 1 item of the specified asset from the inventory. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed.
--- 
--- Supported parameters include:
--- 
--- `count (integer)`: Specifies the number of the item to be removed. Defaults to 1.
--- 
--- `all (boolean)`: If `true`, removes all of the specified items instead of just 1. Overrides `count` if both are specified.
--- @overload fun(itemAssetId: string): boolean
--- @param itemAssetId string
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:RemoveItem(itemAssetId, optionalParameters) end

--- Checks if an item can be removed from an inventory slot. If the item can be removed, returns `true`. Returns `false` if it cannot be removed. Supports the same parameters as `RemoveFromSlot()`.
--- @overload fun(slot: number): boolean
--- @param slot number
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:CanRemoveFromSlot(slot, optionalParameters) end

--- Deletes the inventory item and its entire count from the specified inventory slot. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed.
--- 
--- Supported parameters include:
--- 
--- `count (integer)`: Specifies the number of the item to be removed. Defaults to the total count in the specified slot.
--- @overload fun(slot: number): boolean
--- @param slot number
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:RemoveFromSlot(slot, optionalParameters) end

--- Checks if an item can be dropped from the inventory. If the item can be dropped, returns `true`. Returns `false` if it cannot be dropped. Supports the same parameters as `DropItem()`.
--- @overload fun(itemAssetId: string): boolean
--- @param itemAssetId string
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:CanDropItem(itemAssetId, optionalParameters) end

--- Removes 1 item of the specified asset from the inventory and creates an ItemObject with the item's properties. Spawns the ItemObject at the position of the inventory in the world, or at the position of the owner player's feet if the inventory has been assigned to a player. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed.
--- 
--- Supported parameters include:
--- 
--- `count (integer)`: Specifies the number of the item to be dropped. Defaults to 1.
--- 
--- `all (boolean)`: If `true`, drops all of the specified items instead of just 1. Overrides `count` if both are specified.
--- 
--- `dropTo (ItemObject)`: Specifies a pre-existing ItemObject to drop the items onto. Doing this will add to that ItemObject's count. If the ItemObject's maximum stack count would be exceeded by this operation, it will fail, and this function will return false.
--- 
--- `parent (CoreObject)`: Creates the new ItemObject as a child of the specified CoreObject. Can only be used if `dropTo` is not specified.
--- 
--- `position (Vector3)`: Specifies the world position at which the ItemObject is spawned, or the relative position if a parent is specified. Can only be used if `dropTo` is not specified.
--- 
--- `rotation (Rotation or Quaternion)`: Specifies the world rotation at which the ItemObject is spawned, or the relative rotation if a parent is specified. Can only be used if `dropTo` is not specified.
--- 
--- `scale (Vector3)`: Specifies the world scale with which the ItemObject is spawned, or the relative scale if a parent is specified. Can only be used if `dropTo` is not specified.
--- 
--- `transform (Transform)`: Specifies the world transform at which the ItemObject is spawned, or the relative transform if a parent is specified. Can only be used if `dropTo` is not specified, and is mutually exclusive with `position`, `rotation`, and `scale`.
--- 
--- Additional parameters supported by `World.SpawnAsset()` may also be supported here.
--- @overload fun(itemAssetId: string): boolean
--- @param itemAssetId string
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:DropItem(itemAssetId, optionalParameters) end

--- Checks if an item can be dropped from an inventory slot. If the item can be dropped, returns `true`. Returns `false` if it cannot be dropped. Supports the same parameters as `DropFromSlot()`.
--- @overload fun(slot: number): boolean
--- @param slot number
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:CanDropFromSlot(slot, optionalParameters) end

--- Drops the entire contents of a specified slot, creating an ItemObject with the item's properties. Spawns the ItemObject at the position of the inventory in the world, or at the position of the owner player's feet if the inventory has been assigned to a player. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed. If the full item count is successfully dropped, the slot will be left empty.
--- 
--- Supported parameters include:
--- 
--- `count (integer)`: Specifies the number of the item to be dropped. If not specified, the total number of items in this slot will be dropped.
--- 
--- `dropTo (ItemObject)`: Specifies a pre-existing ItemObject to drop the items onto. Doing this will add to that ItemObject's count. If the ItemObject's max stack count would be exceeded by this operation, it will fail, and this function will return false.
--- 
--- `parent (CoreObject)`: Creates the new ItemObject as a child of the specified CoreObject. Can only be used if `dropTo` is not specified.
--- 
--- `position (Vector3)`: Specifies the world position at which the ItemObject is spawned, or the relative position if a parent is specified. Can only be used if `dropTo` is not specified.
--- 
--- `rotation (Rotation or Quaternion)`: Specifies the world rotation at which the ItemObject is spawned, or the relative rotation if a parent is specified. Can only be used if `dropTo` is not specified.
--- 
--- `scale (Vector3)`: Specifies the world scale with which the ItemObject is spawned, or the relative scale if a parent is specified. Can only be used if `dropTo` is not specified.
--- 
--- `transform (Transform)`: Specifies the world transform at which the ItemObject is spawned, or the relative transform if a parent is specified. Can only be used if `dropTo` is not specified, and is mutually exclusive with `position`, `rotation`, and `scale`.
--- 
--- Additional parameters supported by `World.SpawnAsset()` may also be supported here.
--- @overload fun(slot: number): boolean
--- @param slot number
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:DropFromSlot(slot, optionalParameters) end

--- Checks if an item can be transferred to the specified recipient inventory. If the item can be transferred, returns `true`. Returns `false` if it cannot be transferred. Supports the same parameters as `GiveItem()`.
--- @overload fun(itemAssetId: string,recipient: Inventory): boolean
--- @param itemAssetId string
--- @param recipient Inventory
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:CanGiveItem(itemAssetId, recipient, optionalParameters) end

--- Transfers an item, specified by item asset ID, from this inventory to the given recipient inventory. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed.
--- 
--- Supported parameters include:
--- 
--- `count (integer)`: Specifies the number of the item to be transferred. Defaults to 1.
--- 
--- `all (boolean)`: If `true`, transfers all of the specified items instead of just 1. Overrides `count` if both are specified.
--- @overload fun(itemAssetId: string,recipient: Inventory): boolean
--- @param itemAssetId string
--- @param recipient Inventory
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:GiveItem(itemAssetId, recipient, optionalParameters) end

--- Checks if a slot can be transferred to the specified recipient inventory. If the item can be transferred, returns `true`. Returns `false` if it cannot be transferred. Supports the same parameters as `GiveFromSlot()`.
--- @overload fun(slot: number,recipient: Inventory): boolean
--- @param slot number
--- @param recipient Inventory
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:CanGiveFromSlot(slot, recipient, optionalParameters) end

--- Transfers the entire stack of a given slot to the given recipient inventory. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed.
--- 
--- Supported parameters include:
--- 
--- `count (integer)`: Specifies the number of the item to be transferred. If not specified, the total number of items in this slot will be transferred.
--- @overload fun(slot: number,recipient: Inventory): boolean
--- @param slot number
--- @param recipient Inventory
--- @param optionalParameters table
--- @return boolean
function InventoryInstance:GiveFromSlot(slot, recipient, optionalParameters) end

--- @param typeName string
--- @return boolean
function InventoryInstance:IsA(typeName) end

--- @class GlobalInventory : CoreObject @Inventory is a CoreObject that represents a container of InventoryItems. Items can be added directly to an inventory, picked up from an ItemObject in the world, or transferred between inventories. An Inventory may be assigned to a Player, and Players may have any number of Inventories.
Inventory = {}

--- @class InventoryItem : Object @InventoryItem is an Object which implements the [Item](item.md) interface. It represents an Item stored in an Inventory and has no 3D representation in the world.
--- @field name string @The name of this item, inherited from the Item asset.
--- @field itemAssetId string @Asset ID defining this Item's properties.
--- @field itemTemplateId string @Asset reference that is spawned as a child of an ItemObject when spawned in the world. May be `nil`.
--- @field maximumStackCount number @The maximum number of items in one stack of this item. Zero or negative numbers indicate no limit.
--- @field inventory Inventory @The Inventory which owns this item.
--- @field slot number @The slot number to which this item has been assigned within its owning Inventory.
--- @field count number @The number of items this object represents.
--- @field type string
local InventoryItemInstance = {}
--- Sets the value of a custom property. The value must match the existing type of the property. Returns `true` if the property was successfully set. If the property could not be set, returns `false` or raises an error depending on the cause of the failure.
--- @param propertyName string
--- @param propertyValue any
--- @return boolean
function InventoryItemInstance:SetCustomProperty(propertyName, propertyValue) end

--- Returns the value of a specific custom property or `nil` if the Item does not possess the custom property. The second return value is `true` if the property is found or `false` if it is not. Initial values are inherited from the Item asset defining this item.
--- @param propertyName string
--- @return any|boolean
function InventoryItemInstance:GetCustomProperty(propertyName) end

--- Returns a table containing the names and values of all custom properties on this item. Initial values are inherited from the Item asset defining this item.
--- @return table
function InventoryItemInstance:GetCustomProperties() end

--- Returns `true` if the named custom property exists and is marked as dynamic. Otherwise, returns `false`.
--- @param propertyName string
--- @return boolean
function InventoryItemInstance:IsCustomPropertyDynamic(propertyName) end

--- @param typeName string
--- @return boolean
function InventoryItemInstance:IsA(typeName) end

--- @class GlobalInventoryItem : Object @InventoryItem is an Object which implements the [Item](item.md) interface. It represents an Item stored in an Inventory and has no 3D representation in the world.
InventoryItem = {}

--- @class ItemObject : CoreObject @ItemObject is a CoreObject which implements the [Item](item.md) interface. It represents an Item that has been spawned in the world.
--- @field changedEvent Event @Fired when the count or a custom property value of an ItemObject has changed.
--- @field itemAssetId string @Asset ID defining this ItemObject's properties.
--- @field itemTemplateId string @Asset reference that is spawned as a child of the ItemObject when spawned in the world. This is inherited from the item asset's Item Template property. May be `nil`.
--- @field maximumStackCount number @The maximum number of items in one stack of this item. This is inherited from the item asset's Maximum Stack Count property. Zero or negative numbers indicate no limit.
--- @field count number @The number of items this object represents.
--- @field type string
local ItemObjectInstance = {}
--- @param typeName string
--- @return boolean
function ItemObjectInstance:IsA(typeName) end

--- @class GlobalItemObject : CoreObject @ItemObject is a CoreObject which implements the [Item](item.md) interface. It represents an Item that has been spawned in the world.
ItemObject = {}

--- @class LeaderboardEntry @A data structure containing a player's entry on a leaderboard. See the `Leaderboards` API for information on how to retrieve or update a `LeaderboardEntry`.
--- @field id string @The ID of the `Player` whose entry this is.
--- @field name string @The name of the `Player` whose entry this is.
--- @field score number @The Player's score.
--- @field additionalData string @Optional additional data that was submitted along with the Player's score. (See `Leaderboards.SubmitPlayerScore()` for more information.)
--- @field type string
local LeaderboardEntryInstance = {}
--- @param typeName string
--- @return boolean
function LeaderboardEntryInstance:IsA(typeName) end

--- @class GlobalLeaderboardEntry @A data structure containing a player's entry on a leaderboard. See the `Leaderboards` API for information on how to retrieve or update a `LeaderboardEntry`.
LeaderboardEntry = {}

--- @class Light : CoreObject @Light is a light source that is a CoreObject. Generally a Light will be an instance of some subtype, such as PointLight or SpotLight.
--- @field intensity number @The intensity of the light. For PointLights and SpotLights, this has two interpretations, depending on the value of the `hasNaturalFallOff` property. If `true`, the light's Intensity is in units of lumens, where 1700 lumens is a 100W lightbulb. If `false`, the light's Intensity is a brightness scale.
--- @field attenuationRadius number @Bounds the light's visible influence. This clamping of the light's influence is not physically correct but very important for performance, larger lights cost more.
--- @field isShadowCaster boolean @Does this light cast shadows?
--- @field hasTemperature boolean @true: use temperature value as illuminant. false: use white (D65) as illuminant.
--- @field temperature number @Color temperature in Kelvin of the blackbody illuminant. White (D65) is 6500K.
--- @field team number @Assigns the light to a team. Value range from 0 to 4. 0 is a neutral team.
--- @field isTeamColorUsed boolean @If `true`, and the light has been assigned to a valid team, players on that team will see a blue light, while other players will see red.
--- @field type string
local LightInstance = {}
--- The color of the light.
--- @return Color
function LightInstance:GetColor() end

--- The color of the light.
--- @param color Color
function LightInstance:SetColor(color) end

--- @param typeName string
--- @return boolean
function LightInstance:IsA(typeName) end

--- @class GlobalLight : CoreObject @Light is a light source that is a CoreObject. Generally a Light will be an instance of some subtype, such as PointLight or SpotLight.
Light = {}

--- @class MaterialSlot @Contains data about a material slot on a static or animated mesh.
--- @field slotName string @The name of this slot.
--- @field mesh CoreMesh @The mesh this MaterialSlot is on.
--- @field materialAssetName string @The name of the material asset in this slot.
--- @field materialAssetId string @The material asset in this slot.
--- @field isSmartMaterial boolean @True if we are using this as a smart material.
--- @field type string
local MaterialSlotInstance = {}
--- Set the U and V tiling values.
--- @overload fun(self: MaterialSlot,u: number,v: number)
--- @param uv Vector2
function MaterialSlotInstance:SetUVTiling(uv) end

--- Returns a Vector2 of the U and V tiling values.
--- @return Vector2
function MaterialSlotInstance:GetUVTiling() end

--- Set the color for this slot.
--- @param color Color
function MaterialSlotInstance:SetColor(color) end

--- Returns the color of this slot.
--- @return Color
function MaterialSlotInstance:GetColor() end

--- Resets the color of this slot to the original value.
function MaterialSlotInstance:ResetColor() end

--- Resets the U and V tiling to their original values.
function MaterialSlotInstance:ResetUVTiling() end

--- Resets whether or not this is used as a smart material.
function MaterialSlotInstance:ResetIsSmartMaterial() end

--- Resets this to the original material asset.
function MaterialSlotInstance:ResetMaterialAssetId() end

--- Get the custom material in this material slot. This errors if the slot does not have a custom material.
--- @return CustomMaterial
function MaterialSlotInstance:GetCustomMaterial() end

--- @param typeName string
--- @return boolean
function MaterialSlotInstance:IsA(typeName) end

--- @class GlobalMaterialSlot @Contains data about a material slot on a static or animated mesh.
MaterialSlot = {}

--- @class MergedModel : Folder @MergedModel is a special Folder that combines CoreMesh descendants into a single mesh. Note that MergedModel is still a beta feature, and as such could change in the future.
--- @field type string
local MergedModelInstance = {}
--- @param typeName string
--- @return boolean
function MergedModelInstance:IsA(typeName) end

--- @class GlobalMergedModel : Folder @MergedModel is a special Folder that combines CoreMesh descendants into a single mesh. Note that MergedModel is still a beta feature, and as such could change in the future.
MergedModel = {}

--- @class NetReference @A reference to a network resource, such as a player leaderboard. NetReferences are not created directly, but may be returned by `CoreObject:GetCustomProperty()`.
--- @field isAssigned boolean @Returns true if this reference has been assigned a value. This does not necessarily mean the reference is valid, but does mean it is at least not empty.
--- @field referenceType NetReferenceType @Returns one of the following to indicate the type of NetReference: `NetReferenceType.LEADERBOARD`, `NetReferenceType.SHARED_STORAGE`, `NetReferenceType.SHARED_PLAYER_STORAGE`, `NetReferenceType.CONCURRENT_SHARED_PLAYER_STORAGE`, `NetReferenceType.CONCURRENT_CREATOR_STORAGE`, `NetReferenceType.CREATOR_PERK` or `NetReferenceType.UNKNOWN`.
--- @field type string
local NetReferenceInstance = {}
--- @param typeName string
--- @return boolean
function NetReferenceInstance:IsA(typeName) end

--- @class GlobalNetReference @A reference to a network resource, such as a player leaderboard. NetReferences are not created directly, but may be returned by `CoreObject:GetCustomProperty()`.
NetReference = {}

--- @class NetworkContext : CoreObject @NetworkContext is a CoreObject representing a special folder containing client-only, server-only, or static objects.. . They have no properties or functions of their own, but inherit everything from CoreObject.
--- @field type string
local NetworkContextInstance = {}
--- Spawns an instance of an asset into the world as a child of a networked Static Context, also spawning copies of the asset on clients without the overhead of additional networked objects. Any object spawned this way cannot be modified, as with other objects within a Static Context, but they may be destroyed by calling `DestroySharedAsset()` on the same `NetworkContext` instance. Raises an error if called on a non-networked Static Context or a Static Context which is a descendant of a Client Context or Server Context. Optional parameters can specify a transform for the spawned object.
--- 
--- Supported parameters include:
--- 
--- `position (Vector3)`: Position of the spawned object, relative to the parent NetworkContext.
--- 
--- `rotation (Rotation or Quaternion)`: Local rotation of the spawned object.
--- 
--- `scale (Vector3 or number)`: Scale of the spawned object, may be specified as a `Vector3` or as a `number` for uniform scale.
--- 
--- `transform (Transform)`: The full transform of the spawned object. If `transform` is specified, it is an error to also specify `position`, `rotation`, or `scale`.
--- @overload fun(assetId: string): CoreObject
--- @param assetId string
--- @param optionalParameters table
--- @return CoreObject
function NetworkContextInstance:SpawnSharedAsset(assetId, optionalParameters) end

--- Destroys an object that was spawned using `SpawnSharedAsset()`. Raises an error if `coreObject` was not created by this `NetworkContext`.
--- @param coreObject CoreObject
function NetworkContextInstance:DestroySharedAsset(coreObject) end

--- @param typeName string
--- @return boolean
function NetworkContextInstance:IsA(typeName) end

--- @class GlobalNetworkContext : CoreObject @NetworkContext is a CoreObject representing a special folder containing client-only, server-only, or static objects.. . They have no properties or functions of their own, but inherit everything from CoreObject.
NetworkContext = {}

--- @class Object @At a high level, Core Lua types can be divided into two groups: data structures and Objects. Data structures are owned by Lua, while Objects are owned by the engine and could be destroyed while still referenced by Lua. Any such object will inherit from this type. These include CoreObject, Player, and Projectile.
--- @field serverUserData table @Table in which users can store any data they want on the server.
--- @field clientUserData table @Table in which users can store any data they want on the client.
--- @field type string
local ObjectInstance = {}
--- @param typeName string
--- @return boolean
function ObjectInstance:IsA(typeName) end

--- @class GlobalObject @At a high level, Core Lua types can be divided into two groups: data structures and Objects. Data structures are owned by Lua, while Objects are owned by the engine and could be destroyed while still referenced by Lua. Any such object will inherit from this type. These include CoreObject, Player, and Projectile.
Object = {}
--- Returns true if object is still a valid Object, or false if it has been destroyed. Also returns false if passed a nil value or something that's not an Object, such as a Vector3 or a string.
--- @param object any
--- @return boolean
function Object.IsValid(object) end


--- @class PartyInfo @Contains data about a party, returned by Player:GetPartyInfo()
--- @field id string @The party ID.
--- @field name string @The party name.
--- @field partySize number @The current size of the party.
--- @field maxPartySize number @The maximum size of the party.
--- @field partyLeaderId string @The player ID of the party leader.
--- @field isPlayAsParty boolean @When true, calls to `Player:TransferToGame()` made on the party leader will transfer all players in the party.
--- @field isPublic boolean @Returns `true` if this party is public, meaning anyone can join.
--- @field type string
local PartyInfoInstance = {}
--- Returns an array of the party's tags.
--- @return table<number, string>
function PartyInfoInstance:GetTags() end

--- Returns an array of the player IDs of the party's members.
--- @return table<number, string>
function PartyInfoInstance:GetMemberIds() end

--- Returns `true` if the party is at maximum capacity.
--- @return boolean
function PartyInfoInstance:IsFull() end

--- @param typeName string
--- @return boolean
function PartyInfoInstance:IsA(typeName) end

--- @class GlobalPartyInfo @Contains data about a party, returned by Player:GetPartyInfo()
PartyInfo = {}

--- @class PhysicsObject : CoreObject @A CoreObject with simulated physics that can interact with players and other objects. PhysicsObject also implements the [Damageable](damageable.md) interface.
--- @field damagedEvent Event @Fired when the object takes damage.
--- @field diedEvent Event @Fired when the object dies.
--- @field collidedEvent Event @Fired when the object collides with another object. The `HitResult` parameter describes the collision that occurred.
--- @field damageHook Hook @Hook called when applying damage from a call to `ApplyDamage()`. The incoming damage may be modified or prevented by modifying properties on the `damage` parameter.
--- @field team number @Assigns the physics object to a team. Value range from `0` to `4`. `0` is neutral team.
--- @field isTeamCollisionEnabled boolean @If `false`, and the physics object has been assigned to a valid team, players on that team will not collide with the object.
--- @field isEnemyCollisionEnabled boolean @If `false`, and the physics object has been assigned to a valid team, players on other teams will not collide with the object.
--- @field hitPoints number @Current amount of hit points.
--- @field maxHitPoints number @Maximum amount of hit points.
--- @field isDead boolean @True if the object is dead, otherwise false. Death occurs when damage is applied which reduces hit points to 0, or when the `Die()` function is called.
--- @field isImmortal boolean @When set to `true`, this object cannot die.
--- @field isInvulnerable boolean @When set to `true`, this object does not take damage.
--- @field destroyOnDeath boolean @When set to `true`, this object will automatically be destroyed when it dies.
--- @field destroyOnDeathDelay number @Delay in seconds after death before this object is destroyed, if `destroyOnDeath` is set to `true`. Defaults to 0.
--- @field destroyOnDeathClientTemplateId string @Optional asset ID of a template to be spawned on clients when this object is automatically destroyed on death.
--- @field destroyOnDeathNetworkedTemplateId string @Optional asset ID of a networked template to be spawned on the server when this object is automatically destroyed on death.
--- @field type string
local PhysicsObjectInstance = {}
--- Damages the object, unless it is invulnerable. If its hit points reach 0 and it is not immortal, it dies.
--- @param damage Damage
function PhysicsObjectInstance:ApplyDamage(damage) end

--- Kills the object, unless it is immortal. The optional Damage parameter is a way to communicate cause of death.
--- @overload fun(self: PhysicsObject)
--- @param damage Damage
function PhysicsObjectInstance:Die(damage) end

--- @param typeName string
--- @return boolean
function PhysicsObjectInstance:IsA(typeName) end

--- @class GlobalPhysicsObject : CoreObject @A CoreObject with simulated physics that can interact with players and other objects. PhysicsObject also implements the [Damageable](damageable.md) interface.
PhysicsObject = {}

--- @class Player : Object @Player is an object representation of the state of a player connected to the game, as well as their avatar in the world. Player also implements the [Damageable](damageable.md) interface.
--- @field collidedEvent Event @Fired when a player collides with another object. The `HitResult` parameter describes the collision that occurred.
--- @field damagedEvent Event @Fired when the Player takes damage.
--- @field diedEvent Event @Fired when the Player dies.
--- @field spawnedEvent Event @Fired when the Player spawns. Indicates the start point at which they spawned and the spawn key used to select the start point. The start point may be nil if a position was specified when spawning the player.
--- @field respawnedEvent Event @Player.respawnedEvent is deprecated. Please use Player.spawnedEvent instead.
--- @field bindingPressedEvent Event @Player.bindingPressedEvent is deprecated. Please use Input.actionPressedEvent instead, but note that it does not use the same binding names.
--- @field bindingReleasedEvent Event @Player.bindingReleasedEvent is deprecated. Please use Input.actionReleasedEvent instead, but note that it does not use the same binding names.
--- @field resourceChangedEvent Event @Fired when a resource changed, indicating the type of the resource and its new amount.
--- @field movementModeChangedEvent Event @Fired when a Player's movement mode changes. The first parameter is the Player being changed. The second parameter is the "new" movement mode. The third parameter is the "previous" movement mode. Possible values for MovementMode are: MovementMode.NONE, MovementMode.WALKING, MovementMode.FALLING, MovementMode.SWIMMING, MovementMode.FLYING.
--- @field animationEvent Event @Some animations have events specified at important points of the animation (for example the impact point in a punch animation). This event is fired with the Player that triggered it, the name of the event at those points, and the name of the animation itself. Events generated from default stances on the player will return "animation_stance" as the animation name.
--- @field emoteStartedEvent Event @Fired when the Player begins playing an emote.
--- @field emoteStoppedEvent Event @Fired when the Player stops playing an emote or an emote is interrupted.
--- @field perkChangedEvent Event @Fired when a player's list of owned perks has changed, indicating which perk's amount has changed. Do not expect this event to fire for perks that a player already has when they join a game. Use the `HasPerk(NetReference)` or `GetPerkCount(NetReference)` function for any initial logic that needs to be handled when joining. Also, this event may not actively fire when a perk expires, but it may fire for an expired perk as a result of purchasing a different perk.
--- @field interactableFocusedEvent Event @Fired when a player has focused on an interactable Trigger and may interact with it.
--- @field interactableUnfocusedEvent Event @Fired when a player is no longer focused on a previously focused interactable Trigger.
--- @field privateNetworkedDataChangedEvent Event @Fired when the player's private data changes. On the client, only the local player's private data is available.
--- @field movementHook Hook @Hook called when processing a Player's movement. The `parameters` table contains a `Vector3` named "direction", indicating the direction the player will move.
--- @field damageHook Hook @Hook called when applying damage from a call to `ApplyDamage()`. The incoming damage may be modified or prevented by modifying properties on the `damage` parameter.
--- @field id string @The unique id of the Player. Consistent across sessions.
--- @field name string @The Player's name.
--- @field team number @The number of the team to which the Player is assigned. By default, this value is 255 in FFA mode.
--- @field isInParty boolean @Returns whether this player is in a party. This is known regardless of if the party is public or private.
--- @field isPartyLeader boolean @Returns whether this player is the leader of a public party.
--- @field hitPoints number @Current amount of hit points.
--- @field maxHitPoints number @Maximum amount of hit points.
--- @field kills number @The number of times the player has killed another player.
--- @field deaths number @The number of times the player has died.
--- @field isSpawned boolean @True if the player is in a spawned state, false if the player is despawned.
--- @field isDead boolean @True if the Player is dead, otherwise false.
--- @field mass number @Gets the mass of the Player.
--- @field isAccelerating boolean @True if the Player is accelerating, such as from input to move.
--- @field isCrouching boolean @True if the Player is crouching.
--- @field isFlying boolean @True if the Player is flying.
--- @field isGrounded boolean @True if the Player is on the ground with no upward velocity, otherwise false.
--- @field isJumping boolean @True if the Player is jumping.
--- @field isMounted boolean @True if the Player is mounted on another object.
--- @field isSwimming boolean @True if the Player is swimming in water.
--- @field isWalking boolean @True if the Player is in walking mode.
--- @field maxWalkSpeed number @Maximum speed while the player is on the ground. Clients can only read. Default = 640.
--- @field stepHeight number @Maximum height in centimeters the Player can step up. Range is 0-100. Default = 45.
--- @field maxAcceleration number @Max Acceleration (rate of change of velocity). Clients can only read. Default = 1800. Acceleration is expressed in centimeters per second squared.
--- @field brakingDecelerationFalling number @Deceleration when falling and not applying acceleration. Default = 0.
--- @field brakingDecelerationWalking number @Deceleration when walking and movement input has stopped. Default = 1000.
--- @field brakingDecelerationFlying number @Deceleration when flying and movement input has stopped. Default = 600.
--- @field groundFriction number @Friction when walking on ground. Default = 8.0
--- @field brakingFrictionFactor number @Multiplier for friction when braking. Default = 0.6.
--- @field walkableFloorAngle number @Max walkable floor angle, in degrees. Clients can only read. Default = 44.
--- @field lookSensitivity number @Multiplier on the Player look rotation speed relative to cursor movement. This is independent from user's preferences, both will be applied as multipliers together. Default = 1.0.
--- @field animationStance string @Which set of animations to use for this Player. See [Animation Stance Strings](../api/animations.md#animation-stance-strings) for possible values.
--- @field activeEmote string @Returns the id of the emote currently being played by the Player, or `nil` if no emote is playing.
--- @field currentFacingMode FacingMode @Current mode applied to player, including possible overrides. Possible values are FacingMode.FACE_AIM_WHEN_ACTIVE, FacingMode.FACE_AIM_ALWAYS, and FacingMode.FACE_MOVEMENT. See desiredFacingMode for details.
--- @field desiredFacingMode FacingMode @Which controls mode to use for this Player. May be overridden by certain movement modes like MovementMode.SWIMMING or when mounted. Possible values are FacingMode.FACE_AIM_WHEN_ACTIVE, FacingMode.FACE_AIM_ALWAYS, and FacingMode.FACE_MOVEMENT.
--- @field maxJumpCount number @Max number of jumps, to enable multiple jumps. Set to 0 to disable jumping.
--- @field shouldFlipOnMultiJump boolean @Set to `false` to disable flip animation when player performs double-jump, triple-jump, etc. Defaults to `true`, enabling flip animation.
--- @field jumpVelocity number @Vertical speed applied to Player when they jump. Default = 900. Speed is expressed in centimeters per second.
--- @field gravityScale number @Multiplier on gravity applied. Default = 1.9.
--- @field maxSwimSpeed number @Maximum speed while the player is swimming. Default = 420.
--- @field maxFlySpeed number @Maximum speed while the player is flying. Default = 600.
--- @field touchForceFactor number @Force applied to physics objects when contacted with a Player. Default = 1.
--- @field isCrouchEnabled boolean @Turns crouching on/off for a Player.
--- @field buoyancy number @In water, buoyancy 1.0 is neutral (won't sink or float naturally). Less than 1 to sink, greater than 1 to float.
--- @field isVisible boolean @Defaults to `true`. Set to `false` to hide the player and any attached objects which are set to inherit visibility. Note that using this property in conjunction with the deprecated `SetVisibility()` function may cause unpredictable results.
--- @field isVisibleToSelf boolean @Set whether to hide the Player model on Player's own client, for sniper scope, etc.
--- @field spreadModifier number @Modifier added to the Player's targeting spread.
--- @field currentSpread number @Gets the Player's current targeting spread.
--- @field canMount boolean @Returns whether the Player can manually toggle on/off the mount.
--- @field shouldDismountWhenDamaged boolean @If `true`, and the Player is mounted they will dismount if they take damage.
--- @field movementControlMode MovementControlMode @Specify how players control their movement. Clients can only read. Default: MovementControlMode.LOOK_RELATIVE. MovementControlMode.NONE: Directional movement input is ignored. MovementControlMode.LOOK_RELATIVE: Forward movement follows the current player's look direction. MovementControlMode.VIEW_RELATIVE: Forward movement follows the current view's look direction. MovementControlMode.FACING_RELATIVE: Forward movement follows the current player's facing direction. MovementControlMode.FIXED_AXES: Movement axis are fixed.
--- @field lookControlMode LookControlMode @Specify how players control their look direction. Default: LookControlMode.RELATIVE. LookControlMode.NONE: Look input is ignored. LookControlMode.RELATIVE: Look input controls the current look direction. LookControlMode.LOOK_AT_CURSOR: Look input is ignored. The player's look direction is determined by drawing a line from the player to the cursor on the Cursor Plane.
--- @field isMovementEnabled boolean @Defaults to `true`. Set to `false` to disable player movement. Unlike `movementControlMode`, which can disable movement input, setting `isMovementEnabled` to `false` freezes the Player in place, ignoring gravity and reactions to collision or impulses, unless the Player's transform is explicitly changed or the Player is attached to a parent CoreObject that moves.
--- @field isCollidable boolean @Defaults to `true`. Set to `false` to disable collision on the player and any attached objects set to inherit collision.
--- @field parentCoreObject CoreObject @If the Player has been attached to a parent CoreObject, returns that object. Otherwise returns `nil`.
--- @field spawnMode SpawnMode @Specifies how a start point is selected when a player initially spawns or spawns from a despawned state.
--- @field respawnMode RespawnMode @Specifies how a start point is selected when a player respawns.
--- @field respawnDelay number @The delay in seconds from when a player dies until they respawn.
--- @field respawnTimeRemaining number @The number of seconds remaining until the player respawns. Returns 0 if the player is already spawned.
--- @field occupiedVehicle Vehicle @Returns the `Vehicle` that the player currently occupies, or `nil` if the player is not occupying a vehicle.
--- @field currentRotationRate number @Reports the real rotation rate that results from any active mechanics/movement overrides.
--- @field defaultRotationRate number @Determines how quickly the Player turns to match the camera's look. Set to -1 for immediate rotation. Currently only supports rotation around the Z-axis.
--- @field type string
local PlayerInstance = {}
--- The absolute Transform of this player.
--- @return Transform
function PlayerInstance:GetWorldTransform() end

--- The absolute Transform of this player.
--- @param worldTransform Transform
function PlayerInstance:SetWorldTransform(worldTransform) end

--- The absolute position of this player.
--- @return Vector3
function PlayerInstance:GetWorldPosition() end

--- The absolute position of this player.
--- @param worldPosition Vector3
function PlayerInstance:SetWorldPosition(worldPosition) end

--- The absolute rotation of this player.
--- @return Rotation
function PlayerInstance:GetWorldRotation() end

--- The absolute rotation of this player.
--- @param worldRotation Rotation
function PlayerInstance:SetWorldRotation(worldRotation) end

--- The absolute scale of this player.
--- @return Vector3
function PlayerInstance:GetWorldScale() end

--- The absolute scale of this player (must be uniform).
--- @param worldScale Vector3
function PlayerInstance:SetWorldScale(worldScale) end

--- Gets the current velocity of the Player. The velocity vector indicates the direction, with its magnitude expressed in centimeters per second.
--- @return Vector3
function PlayerInstance:GetVelocity() end

--- Array of all Abilities assigned to this Player.
--- @return table<number, Ability>
function PlayerInstance:GetAbilities() end

--- Array of all Equipment assigned to this Player.
--- @return table<number, Equipment>
function PlayerInstance:GetEquipment() end

--- Returns a table containing CoreObjects attached to this player.
--- @return table<number, CoreObject>
function PlayerInstance:GetAttachedObjects() end

--- Returns a list of Inventory objects assigned to the player. If the player has no assigned inventories, this list is empty.
--- @return table<number, Inventory>
function PlayerInstance:GetInventories() end

--- Returns an array of all IKAnchor objects activated on this player.
--- @return table<number, IKAnchor>
function PlayerInstance:GetIKAnchors() end

--- Adds an impulse force to the Player.
--- @param impulse Vector3
function PlayerInstance:AddImpulse(impulse) end

--- Sets the Player's velocity to the given amount. The velocity vector indicates the direction, with its magnitude expressed in centimeters per second.
--- @param velocity Vector3
function PlayerInstance:SetVelocity(velocity) end

--- Resets the Player's velocity to zero.
function PlayerInstance:ResetVelocity() end

--- Damages a Player. If their hit points go below 0 they die.
--- @param damage Damage
function PlayerInstance:ApplyDamage(damage) end

--- Enables ragdoll for the Player, starting on `socketName` weighted by `weight` (between 0.0 and 1.0). This can cause the Player capsule to detach from the mesh. All parameters are optional; `socketName` defaults to the root and `weight` defaults to 1.0. Multiple bones can have ragdoll enabled simultaneously. See [Socket Names](../api/animations.md#socket-names) for the list of possible values.
--- @overload fun(self: Player,socketName: string)
--- @overload fun(self: Player)
--- @param socketName string
--- @param weight number
function PlayerInstance:EnableRagdoll(socketName, weight) end

--- Disables all ragdolls that have been set on the Player.
function PlayerInstance:DisableRagdoll() end

--- *This function is deprecated. Please use the `.isVisible` property instead.* Shows or hides the Player. The second parameter is optional, defaults to true, and determines if attachments to the Player are hidden as well as the Player.
--- @overload fun(self: Player,isVisible: boolean)
--- @param isVisible boolean
--- @param includeAttachments boolean
function PlayerInstance:SetVisibility(isVisible, includeAttachments) end

--- Returns whether or not the Player is hidden.
--- @return boolean
function PlayerInstance:GetVisibility() end

--- Get position of the Player's camera view.
--- @return Vector3
function PlayerInstance:GetViewWorldPosition() end

--- Get rotation of the Player's camera view.
--- @return Rotation
function PlayerInstance:GetViewWorldRotation() end

--- Kills the Player. They will ragdoll and ignore further Damage. The optional Damage parameter is a way to communicate cause of death.
--- @overload fun(self: Player)
--- @param damage Damage
function PlayerInstance:Die(damage) end

--- Resurrects a dead player or spawns a despawned player based on respawn settings in the game (default in-place). An optional table may be provided to override the following parameters:
--- 
--- `position (Vector3)`: Respawn at this position. Defaults to the position of the spawn point selected based on the game's respawn settings, or the player's current position if no spawn point was selected.
--- 
--- `rotation (Rotation)`: Sets the player's rotation after respawning. Defaults to the rotation of the selected spawn point, or the player's current rotation if no spawn point was selected.
--- 
--- `scale (Vector3)`: Sets the player's scale after respawning. Defaults to the Player Scale Multiplier of the selected spawn point, or the player's current scale if no spawn point was selected. Player scale must be uniform. (All three components must be equal.)
--- 
--- `spawnKey (string)`: Only spawn points with the given `spawnKey` will be considered. If omitted, only spawn points with a blank `spawnKey` are used.
--- @overload fun(self: Player)
--- @param optionalParameters table
function PlayerInstance:Spawn(optionalParameters) end

--- *This function is deprecated. Please use `Player:Spawn()` instead.* Resurrects a dead Player based on respawn settings in the game (default in-place). An optional table may be provided to override the following parameters:
--- 
--- `position (Vector3)`: Respawn at this position. Defaults to the position of the spawn point selected based on the game's respawn settings, or the player's current position if no spawn point was selected.
--- 
--- `rotation (Rotation)`: Sets the player's rotation after respawning. Defaults to the rotation of the selected spawn point, or the player's current rotation if no spawn point was selected.
--- 
--- `scale (Vector3)`: Sets the player's scale after respawning. Defaults to the Player Scale Multiplier of the selected spawn point, or the player's current scale if no spawn point was selected. Player scale must be uniform. (All three components must be equal.)
--- 
--- `spawnKey (string)`: Only spawn points with the given `spawnKey` will be considered. If omitted, only spawn points with a blank `spawnKey` are used.
--- @overload fun(self: Player,optionalParameters: table)
--- @overload fun(self: Player)
--- @param position Vector3
--- @param rotation Rotation
function PlayerInstance:Respawn(position, rotation) end

--- Despawns the player. While despawned, the player is invisible, has no collision, and cannot move. Use the `Spawn()` function to respawn the player.
function PlayerInstance:Despawn() end

--- Removes all resources from a player.
function PlayerInstance:ClearResources() end

--- Returns a table containing the names and amounts of the player's resources.
--- @return table
function PlayerInstance:GetResources() end

--- Returns the amount of a resource owned by a player. Returns 0 by default.
--- @param resourceName string
--- @return number
function PlayerInstance:GetResource(resourceName) end

--- Sets a specific amount of a resource on a player.
--- @param resourceName string
--- @param amount number
--- @return number
function PlayerInstance:SetResource(resourceName, amount) end

--- Adds an amount of a resource to a player.
--- @param resourceName string
--- @param amount number
--- @return number
function PlayerInstance:AddResource(resourceName, amount) end

--- Subtracts an amount of a resource from a player. Does not go below 0.
--- @param resourceName string
--- @param amount number
--- @return number
function PlayerInstance:RemoveResource(resourceName, amount) end

--- @return table<number, string>
function PlayerInstance:GetResourceNames() end

--- @param resourceNamePrefix string
--- @return table<number, string>
function PlayerInstance:GetResourceNamesStartingWith(resourceNamePrefix) end

--- Does not work in preview mode or in games played locally. Transfers player to the game specified by the passed-in game ID. Example: The game ID for the URL `https://www.coregames.com/games/577d80/core-royale` is `577d80/core-royale`. This function will raise an error if called from a client script on a player other than the local player.
--- @overload fun(self: Player,gameInfo: CoreGameInfo)
--- @overload fun(self: Player,gameId: string)
--- @param gameCollectionEntry CoreGameCollectionEntry
function PlayerInstance:TransferToGame(gameCollectionEntry) end

--- Does not work in preview mode or in games played locally. Transfers player to the scene specified by the passed-in scene name. The specified scene must be a scene within the same game. This function will raise an error if called from a client script on a player other than the local player.
--- 
--- The following optional parameters are supported:
--- 
--- `spawnKey (string)`: Spawns the player at a spawn point with a matching key. If an invalid key is provided, the player will spawn at the origin, (0, 0, 0).
--- @overload fun(sceneName: string)
--- @param sceneName string
--- @param optionalParams table
function PlayerInstance:TransferToScene(sceneName, optionalParams) end

--- Returns `true` if the player has one or more of the specified perk.
--- @param perkReference NetReference
--- @return boolean
function PlayerInstance:HasPerk(perkReference) end

--- Returns how many of the specified perk the player owns. For non-repeatable perks, returns `1` if the player owns the perk, or `0` if the player does not.
--- @param perkReference NetReference
--- @return number
function PlayerInstance:GetPerkCount(perkReference) end

--- Returns the amount of time remaining (in seconds) until a Limited Time Perk expires. Returns `0` if the player does not own the specified perk, or infinity for a permanent or repeatable perk that the player owns.
--- @param perkReference NetReference
--- @return number
function PlayerInstance:GetPerkTimeRemaining(perkReference) end

--- Adds an amount of Reward Points to a player for completing a certain activity.
--- @param rewardPoints number
--- @param activityName string
function PlayerInstance:GrantRewardPoints(rewardPoints, activityName) end

--- Activates the Player flying mode.
function PlayerInstance:ActivateFlying() end

--- Activate the Player walking mode.
function PlayerInstance:ActivateWalking() end

--- Forces a player in or out of mounted state.
--- @param isMounted boolean
function PlayerInstance:SetMounted(isMounted) end

--- Returns the Ability that is currently active on the player, or `nil` if no ability is currently active. Abilities are considered active if they are in `CAST`, `EXECUTE`, or `RECOVERY` phases. Abilities in `COOLDOWN` or `READY` phase are not considered active.
--- @return Ability
function PlayerInstance:GetActiveAbility() end

--- Returns whichever camera is currently active for the Player.
--- @return Camera
function PlayerInstance:GetActiveCamera() end

--- Returns the default Camera object the Player is currently using.
--- @return Camera
function PlayerInstance:GetDefaultCamera() end

--- Sets the default Camera object for the Player.
--- @overload fun(self: Player,camera: Camera,lerpTime: number)
--- @param camera Camera
function PlayerInstance:SetDefaultCamera(camera) end

--- Returns the override Camera object the Player is currently using.
--- @return Camera
function PlayerInstance:GetOverrideCamera() end

--- Sets the override Camera object for the Player.
--- @overload fun(self: Player,camera: Camera,lerpTime: number)
--- @param camera Camera
function PlayerInstance:SetOverrideCamera(camera) end

--- Clears the override Camera object for the Player (to revert back to the default camera).
--- @overload fun(self: Player,lerpTime: number)
function PlayerInstance:ClearOverrideCamera() end

--- Get the rotation for the direction the Player is facing.
--- @return Rotation
function PlayerInstance:GetLookWorldRotation() end

--- Set the rotation for the direction the Player is facing.
--- @param newLookRotation Rotation
function PlayerInstance:SetLookWorldRotation(newLookRotation) end

--- *This function is deprecated. Please use Input.IsActionHeld() instead, but note that it does not use the same binding names.* Returns `true` if the player is currently pressing the named binding. Possible values of the bindings are listed on the [Ability binding](../api/key_bindings.md) page. Note that when called on a client, this function will only work for the local player.
--- @param bindingName string
--- @return boolean
function PlayerInstance:IsBindingPressed(bindingName) end

--- Attaches the Player to the given CoreObject, treating that object as a parent and disabling player movement.
--- @param object CoreObject
function PlayerInstance:AttachToCoreObject(object) end

--- If the Player is attached to a parent CoreObject, detaches them and re-enables player movement.
function PlayerInstance:Detach() end

--- Returns data indicating how a player joined the game (via browsing, portal, social invite, etc) and the game ID of their previous game if they joined directly from another game. Join data should be available during the player's entire session.
--- @return PlayerTransferData
function PlayerInstance:GetJoinTransferData() end

--- Returns data indicating how a player left the game (via browsing, portal, social invite, etc) and the game ID of their next game if they are directly joining another game. Leave data is not valid until `Game.playerLeftEvent` has fired for the player.
--- @return PlayerTransferData
function PlayerInstance:GetLeaveTransferData() end

--- If the player is in a party, returns a PartyInfo object with data about that party.
--- @return PartyInfo
function PlayerInstance:GetPartyInfo() end

--- Returns whether both players are in the same public party.
--- @param player Player
--- @return boolean
function PlayerInstance:IsInPartyWith(player) end

--- Sets the private networked data for this player associated with the key. Value can be any type that could be sent with a networked event. Each key is replicated independently, and this data is only sent to the owning player.
--- @param key string
--- @param value any
--- @return PrivateNetworkedDataResultCode
function PlayerInstance:SetPrivateNetworkedData(key, value) end

--- Returns the private networked data on this player associated with the given key or nil if no data is found.
--- @param key string
--- @return any
function PlayerInstance:GetPrivateNetworkedData(key) end

--- Returns an array of all keys with private data set.
--- @return table
function PlayerInstance:GetPrivateNetworkedDataKeys() end

--- Returns the number of bytes used by private networked data on this player. Returns 0 if private networked data is not available.
--- @return number
function PlayerInstance:GetPrivateNetworkedDataSize() end

--- If the player is currently focused on an interactable Trigger, returns that Trigger. Returns `nil` if the player is not currently focused on an interactable Trigger.
--- @return Trigger
function PlayerInstance:GetInteractableTarget() end

--- @param typeName string
--- @return boolean
function PlayerInstance:IsA(typeName) end

--- @class GlobalPlayer : Object @Player is an object representation of the state of a player connected to the game, as well as their avatar in the world. Player also implements the [Damageable](damageable.md) interface.
Player = {}

--- @class PlayerSettings : CoreObject @Settings that can be applied to a Player.
--- @field type string
local PlayerSettingsInstance = {}
--- Apply settings from this settings object to Player.
--- @param player Player
function PlayerSettingsInstance:ApplyToPlayer(player) end

--- @param typeName string
--- @return boolean
function PlayerSettingsInstance:IsA(typeName) end

--- @class GlobalPlayerSettings : CoreObject @Settings that can be applied to a Player.
PlayerSettings = {}

--- @class PlayerStart : CoreObject @PlayerStart is a CoreObject representing a spawn point for players.
--- @field team number @Determines which players are eligible to spawn/respawn at this point.
--- @field playerScaleMultiplier number @The scale applied to a player that is spawned at this start point.
--- @field spawnTemplateId string @The asset ID of a template spawned on clients when a player spawns at this start point. May be nil.
--- @field key string @The key associated with this start point.
--- @field shouldDecrowdPlayers boolean @When set to `true`, a collision check will be performed for spawning players to prevent them from overlapping with other players.
--- @field type string
local PlayerStartInstance = {}
--- @param typeName string
--- @return boolean
function PlayerStartInstance:IsA(typeName) end

--- @class GlobalPlayerStart : CoreObject @PlayerStart is a CoreObject representing a spawn point for players.
PlayerStart = {}

--- @class PlayerTransferData @PlayerTransferData contains information indicating how a player joined or left a game, and their next or previous game ID if they're moving directly from one game to another. Players may opt out of sharing this information by selecting "Hide My Gameplay Activity" or "Appear Offline" in the social panel settings.
--- @field reason PlayerTransferReason @Indicates how the player joined or left a game.
--- @field gameId string @The ID of the game the player joined from or left to join. Returns `nil` if the player joined while not already connected to a game or left for a reason other than joining another game. Also returns `nil` if the player has opted out of sharing this information.
--- @field sceneId string @The scene ID that the player joined from or left to join. May return `nil`.
--- @field sceneName string @The scene name that the player joined from or left to join. May return `nil`.
--- @field spawnKey string @The spawn key used when transferring a player to another scene. May return `nil`.
--- @field type string
local PlayerTransferDataInstance = {}
--- @param typeName string
--- @return boolean
function PlayerTransferDataInstance:IsA(typeName) end

--- @class GlobalPlayerTransferData @PlayerTransferData contains information indicating how a player joined or left a game, and their next or previous game ID if they're moving directly from one game to another. Players may opt out of sharing this information by selecting "Hide My Gameplay Activity" or "Appear Offline" in the social panel settings.
PlayerTransferData = {}

--- @class PointLight : Light @PointLight is a placeable light source that is a CoreObject.
--- @field hasNaturalFalloff boolean @The attenuation method of the light. When enabled, `attenuationRadius` is used. When disabled, `falloffExponent` is used. Also changes the interpretation of the intensity property, see intensity for details.
--- @field falloffExponent number @Controls the radial falloff of the light when `hasNaturalFalloff` is false. 2.0 is almost linear and very unrealistic and around 8.0 it looks reasonable. With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents.
--- @field sourceRadius number @Radius of light source shape.
--- @field sourceLength number @Length of light source shape.
--- @field type string
local PointLightInstance = {}
--- @param typeName string
--- @return boolean
function PointLightInstance:IsA(typeName) end

--- @class GlobalPointLight : Light @PointLight is a placeable light source that is a CoreObject.
PointLight = {}

--- @class Projectile : Object @Projectile is a specialized Object which moves through the air in a parabolic shape and impacts other objects. To spawn a Projectile, use `Projectile.Spawn()`.
--- @field impactEvent Event @Fired when the Projectile collides with something. Impacted object parameter will be either of type `CoreObject` or `Player`, but can also be `nil`. The HitResult describes the point of contact between the Projectile and the impacted object.
--- @field lifeSpanEndedEvent Event @Fired when the Projectile reaches the end of its lifespan. Fired before it is destroyed.
--- @field homingFailedEvent Event @Fired when the target is no longer valid, for example the Player disconnected from the game or the object was destroyed somehow.
--- @field sourceAbility Ability @Reference to the Ability from which the Projectile was created.
--- @field shouldBounceOnPlayers boolean @Determines if the Projectile should bounce off players or be destroyed, when bouncesRemaining is used. Default false.
--- @field shouldDieOnImpact boolean @If `true`, the Projectile is automatically destroyed when it hits something, unless it has bounces remaining. Default true.
--- @field owner Player @The Player who fired this Projectile. Setting this property ensures the Projectile does not impact the owner or their allies. This will also change the color of the Projectile if teams are being used in the game.
--- @field speed number @Centimeters per second movement. Default 5000.
--- @field maxSpeed number @Max cm/s. Default 0. Zero means no limit.
--- @field gravityScale number @How much drop. Default 1. 1 means normal gravity. Zero can be used to make a Projectile go in a straight line.
--- @field drag number @Deceleration. Important for homing Projectiles (try a value around 5). Negative drag will cause the Projectile to accelerate. Default 0.
--- @field bouncesRemaining number @Number of bounces remaining before it dies. Default 0.
--- @field bounciness number @Velocity % maintained after a bounce. Default 0.6.
--- @field piercesRemaining number @Number of objects that will be pierced before it dies. A piercing Projectile loses no velocity when going through objects, but still fires the impactEvent event. If combined with bounces, all piercesRemaining are spent before bouncesRemaining are counted. Default 0.
--- @field lifeSpan number @Max seconds the Projectile will exist. Default 10.
--- @field capsuleRadius number @Shape of the Projectile's collision. Default 22.
--- @field capsuleLength number @Shape of the Projectile's collision. A value of zero will make it shaped like a Sphere. Default 44.
--- @field homingTarget CoreObject|Player @The projectile accelerates towards its target. Homing targets are meant to be used with spawned projectiles and will not work with weapons.
--- @field homingAcceleration number @Magnitude of acceleration towards the target. Default 10,000.
--- @field type string
local ProjectileInstance = {}
--- Transform data for the Projectile in world space.
--- @return Transform
function ProjectileInstance:GetWorldTransform() end

--- Position of the Projectile in world space.
--- @return Vector3
function ProjectileInstance:GetWorldPosition() end

--- Position of the Projectile in world space.
--- @param worldPosition Vector3
function ProjectileInstance:SetWorldPosition(worldPosition) end

--- Current direction and speed vector of the Projectile. Speed is expressed in centimeters per second.
--- @return Vector3
function ProjectileInstance:GetVelocity() end

--- Current direction and speed vector of the Projectile. Speed is expressed in centimeters per second.
--- @param velocity Vector3
function ProjectileInstance:SetVelocity(velocity) end

--- Immediately destroys the object.
function ProjectileInstance:Destroy() end

--- @param typeName string
--- @return boolean
function ProjectileInstance:IsA(typeName) end

--- @class GlobalProjectile : Object @Projectile is a specialized Object which moves through the air in a parabolic shape and impacts other objects. To spawn a Projectile, use `Projectile.Spawn()`.
Projectile = {}
--- Spawns a Projectile with a child that is an instance of a template.
--- @param templateId string
--- @param startPosition Vector3
--- @param direction Vector3
--- @return Projectile
function Projectile.Spawn(templateId, startPosition, direction) end


--- @class Quaternion @A quaternion-based representation of a rotation.
--- @field x number @The `x` component of the Quaternion.
--- @field y number @The `y` component of the Quaternion.
--- @field z number @The `z` component of the Quaternion.
--- @field w number @The `w` component of the Quaternion.
--- @field type string
--- @operator add(Quaternion): Quaternion @ Component-wise addition.
--- @operator sub(Quaternion): Quaternion @ Component-wise subtraction.
--- @operator mul(Vector3): Vector3 @ Multiplication operator.
--- @operator mul(number): Quaternion @ Multiplication operator.
--- @operator mul(Quaternion): Quaternion @ Multiplication operator.
--- @operator div(number): Quaternion @ Divides each component of the Quaternion by the right-side number.
--- @operator unm: Quaternion @ Returns the inverse rotation.
local QuaternionInstance = {}
--- Get the Rotation representation of the Quaternion.
--- @return Rotation
function QuaternionInstance:GetRotation() end

--- Forward unit vector rotated by the quaternion.
--- @return Vector3
function QuaternionInstance:GetForwardVector() end

--- Right unit vector rotated by the quaternion.
--- @return Vector3
function QuaternionInstance:GetRightVector() end

--- Up unit vector rotated by the quaternion.
--- @return Vector3
function QuaternionInstance:GetUpVector() end

--- @param typeName string
--- @return boolean
function QuaternionInstance:IsA(typeName) end

--- @class GlobalQuaternion @A quaternion-based representation of a rotation.
--- @field IDENTITY Quaternion @Predefined Quaternion with no rotation.
Quaternion = {}
--- Spherical interpolation between two quaternions by the specified progress amount and returns the resultant, normalized Quaternion.
--- @param from Quaternion
--- @param to Quaternion
--- @param progress number
--- @return Quaternion
function Quaternion.Slerp(from, to, progress) end

--- Constructs a Quaternion with the given values. Defaults to 0, 0, 0, 1.
--- @overload fun(fromDirection: Vector3,toDirection: Vector3): Quaternion
--- @overload fun(axis: Vector3,angle: number): Quaternion
--- @overload fun(rotation: Rotation): Quaternion
--- @overload fun(x: number,y: number,z: number,w: number): Quaternion
--- @overload fun(): Quaternion
--- @param quaternion Quaternion
--- @return Quaternion
function Quaternion.New(quaternion) end


--- @class RandomStream @Seed-based random stream of numbers. Useful for deterministic RNG problems, for instance, inside a Client Context so all players get the same outcome without the need to replicate lots of data from the server. Bad quality in the lower bits (avoid combining with modulus operations).
--- @field seed number @The current seed used for RNG.
--- @field type string
local RandomStreamInstance = {}
--- The seed that was used to initialize this stream.
--- @return number
function RandomStreamInstance:GetInitialSeed() end

--- Function that sets the seed back to the initial seed.
function RandomStreamInstance:Reset() end

--- Moves the seed forward to the next seed.
function RandomStreamInstance:Mutate() end

--- Returns a floating point number between `min` and `max` (inclusive), defaults to `0` and `1` (exclusive).
--- @overload fun(self: RandomStream,min: number,max: number): number
--- @return number
function RandomStreamInstance:GetNumber() end

--- Returns an integer number between `min` and `max` (inclusive).
--- @param min number
--- @param max number
--- @return number
function RandomStreamInstance:GetInteger(min, max) end

--- Returns a random unit vector.
--- @return Vector3
function RandomStreamInstance:GetVector3() end

--- Returns a random unit vector, uniformly distributed, from inside a cone defined by `direction`, `horizontalHalfAngle` and `verticalHalfAngle` (in degrees).
--- @overload fun(self: RandomStream,direction: Vector3,coneHalfAngle: number): Vector3
--- @param direction Vector3
--- @param horizontalHalfAngle number
--- @param verticalHalfAngle number
--- @return Vector3
function RandomStreamInstance:GetVector3FromCone(direction, horizontalHalfAngle, verticalHalfAngle) end

--- @param typeName string
--- @return boolean
function RandomStreamInstance:IsA(typeName) end

--- @class GlobalRandomStream @Seed-based random stream of numbers. Useful for deterministic RNG problems, for instance, inside a Client Context so all players get the same outcome without the need to replicate lots of data from the server. Bad quality in the lower bits (avoid combining with modulus operations).
RandomStream = {}
--- Constructor with specified seed, defaults to a random value.
--- @overload fun(): RandomStream
--- @param seed number
--- @return RandomStream
function RandomStream.New(seed) end


--- @class Rectangle @A rectangle defined by upper-left and lower-right corners. Generally assumed to be used within screen space, so the Y axis points down. This means the bottom of the rectangle is expected to be a higher value than the top.
--- @field left number @The position of the left edge of the rectangle.
--- @field top number @The position of the top edge of the rectangle.
--- @field right number @The position of the right edge of the rectangle.
--- @field bottom number @The position of the bottom edge of the rectangle.
--- @field type string
local RectangleInstance = {}
--- Returns a Vector2 indicating the width and height of the rectangle.
--- @return Vector2
function RectangleInstance:GetSize() end

--- Returns a Vector2 indicating the coordinates of the center of the rectangle.
--- @return Vector2
function RectangleInstance:GetCenter() end

--- @param typeName string
--- @return boolean
function RectangleInstance:IsA(typeName) end

--- @class GlobalRectangle @A rectangle defined by upper-left and lower-right corners. Generally assumed to be used within screen space, so the Y axis points down. This means the bottom of the rectangle is expected to be a higher value than the top.
Rectangle = {}
--- Constructs a Rectangle with the given `left`, `top`, `right`, `bottom` values, defaults to (0, 0, 0, 0).
--- @overload fun(rectangle: Rectangle): Rectangle
--- @overload fun(left: number,top: number,right: number,bottom: number): Rectangle
--- @overload fun(): Rectangle
--- @param vector Vector4
--- @return Rectangle
function Rectangle.New(vector) end


--- @class Rotation @An euler-based rotation around `x`, `y`, and `z` axes.
--- @field x number @The `x` component of the Rotation.
--- @field y number @The `y` component of the Rotation.
--- @field z number @The `z` component of the Rotation.
--- @field type string
--- @operator add(Rotation): Rotation @ Add two Rotations together. Note that this adds the individual components together, and may not provide the same result as if the two Rotations were applied in sequence.
--- @operator sub(Rotation): Rotation @ Subtract a Rotation.
--- @operator mul(Rotation): Rotation @ Multiplication operator.
--- @operator mul(Vector3): Vector3 @ Multiplication operator.
--- @operator mul(number): Rotation @ Multiplication operator.
--- @operator unm: Rotation @ Returns the inverse rotation.
local RotationInstance = {}
--- @param typeName string
--- @return boolean
function RotationInstance:IsA(typeName) end

--- @class GlobalRotation @An euler-based rotation around `x`, `y`, and `z` axes.
--- @field ZERO Rotation @Constant Rotation of (0, 0, 0).
Rotation = {}
--- Construct a rotation with the given values, defaults to (0, 0, 0).
--- @overload fun(rotation: Rotation): Rotation
--- @overload fun(quaternion: Quaternion): Rotation
--- @overload fun(x: number,y: number,z: number): Rotation
--- @overload fun(): Rotation
--- @param forwardVector Vector3
--- @param upVector Vector3
--- @return Rotation
function Rotation.New(forwardVector, upVector) end


--- @class Script : CoreObject @Script is a CoreObject representing a script in the hierarchy. While not technically a property, a script can access itself using the `script` variable.
--- @field context table @Returns the table containing any non-local variables and functions created by the script. This can be used to call (or overwrite!) functions on another script.
--- @field scriptAssetId string @Returns the asset ID of the script this instance is executing.
--- @field type string
local ScriptInstance = {}
--- @param typeName string
--- @return boolean
function ScriptInstance:IsA(typeName) end

--- @class GlobalScript : CoreObject @Script is a CoreObject representing a script in the hierarchy. While not technically a property, a script can access itself using the `script` variable.
Script = {}

--- @class ScriptAsset : Object @ScriptAsset is an Object representing a script asset in Project Content. When a script is executed from a call to `require()`, it can access the script asset using the `script` variable.. . This can be used to read custom properties from the script asset.
--- @field name string @The name of the script in Project Content.
--- @field id string @The script asset's MUID.
--- @field type string
local ScriptAssetInstance = {}
--- Returns a table containing the names and values of all custom properties on the script asset.
--- @return table
function ScriptAssetInstance:GetCustomProperties() end

--- Gets an individual custom property from the script asset. Returns the value, which can be an integer, number, boolean, string, Vector3, Rotator, Color, a MUID string, or nil if not found. Second return value is a boolean, true if found and false if not.
--- @param propertyName string
--- @return any|boolean
function ScriptAssetInstance:GetCustomProperty(propertyName) end

--- @param typeName string
--- @return boolean
function ScriptAssetInstance:IsA(typeName) end

--- @class GlobalScriptAsset : Object @ScriptAsset is an Object representing a script asset in Project Content. When a script is executed from a call to `require()`, it can access the script asset using the `script` variable.. . This can be used to read custom properties from the script asset.
ScriptAsset = {}

--- @class SimpleCurve @A two-dimensional curve made up of some number of `CurveKey` instances specifying the value of the curve at various points in time. Values between those key points are interpolated based on properties of the curve and the curve keys.
--- @field preExtrapolation CurveExtrapolation @The extrapolation mode for values before the first curve key.
--- @field postExtrapolation CurveExtrapolation @The extrapolation mode for values after the last curve key.
--- @field defaultValue number @The default value for this curve if no keys are available.
--- @field minTime number @Returns the smallest time from the curve's key points. Returns 0 if the curve contains no keys.
--- @field maxTime number @Returns the largest time from the curve's key points. Returns 0 if the curve contains no keys.
--- @field minValue number @Returns the smallest value from the curve's key points. Returns 0 if the curve contains no keys.
--- @field maxValue number @Returns the largest value from the curve's key points. Returns 0 if the curve contains no keys.
--- @field type string
local SimpleCurveInstance = {}
--- Returns the value of the curve at the specified time.
--- @param time number
--- @return number
function SimpleCurveInstance:GetValue(time) end

--- Returns the slope (derivative) of the curve at the specified time. This may return nil in certain cases where the curve values are not continuous.
--- @param time number
--- @return number
function SimpleCurveInstance:GetSlope(time) end

--- @param typeName string
--- @return boolean
function SimpleCurveInstance:IsA(typeName) end

--- @class GlobalSimpleCurve @A two-dimensional curve made up of some number of `CurveKey` instances specifying the value of the curve at various points in time. Values between those key points are interpolated based on properties of the curve and the curve keys.
SimpleCurve = {}
--- Constructs a SimpleCurve with a set of curve keys. An optional table may be provided to override the following parameters:
--- 
--- `preExtrapolation (CurveExtrapolation)`: Sets the `preExtrapolation` property of the curve. Defaults to `CurveExtrapolation.CYCLE`.
--- 
--- `postExtrapolation (CurveExtrapolation)`: Sets the `postExtrapolation` property of the curve. Defaults to `CurveExtrapolation.CYCLE`.
--- 
--- `defaultValue (number)`: Sets the `defaultValue` property of the curve. Defaults to 0.
--- @overload fun(keys: table): SimpleCurve
--- @overload fun(other: SimpleCurve): SimpleCurve
--- @param keys table
--- @param optionalParameters table
--- @return SimpleCurve
function SimpleCurve.New(keys, optionalParameters) end


--- @class SmartAudio : SmartObject @SmartAudio objects are SmartObjects that wrap sound files. Similar to Audio objects, they have many of the same properties and functions.
--- @field isSpatializationEnabled boolean @Default true. Set to false to play sound without 3D positioning.
--- @field isAttenuationEnabled boolean @Default true, meaning sounds will fade with distance.
--- @field isOcclusionEnabled boolean @Default true. Changes attenuation if there is geometry between the player and the audio source.
--- @field fadeInTime number @Sets the fade in time for the audio. When the audio is played, it will start at zero volume, and fade in over this many seconds.
--- @field fadeOutTime number @Sets the fadeout time of the audio. When the audio is stopped, it will keep playing for this many seconds, as it fades out.
--- @field startTime number @The start time of the audio track. Default is 0. Setting this to anything else means that the audio will skip ahead that many seconds when played.
--- @field stopTime number @The stop time of the audio track. Default is 0. A positive value means that the audio will stop that many seconds from the start of the track, including any fade out time.
--- @field isAutoPlayEnabled boolean @Default false. If set to true when placed in the editor (or included in a template), the sound will be automatically played when loaded.
--- @field isTransient boolean @Default false. If set to true, the sound will automatically destroy itself after it finishes playing.
--- @field isAutoRepeatEnabled boolean @Loops when playback has finished. Some sounds are designed to automatically loop, this flag will force others that don't. Useful for looping music.
--- @field pitch number @Default 1. Multiplies the playback pitch of a sound. Note that some sounds have clamped pitch ranges (0.2 to 1).
--- @field volume number @Default 1. Multiplies the playback volume of a sound. Note that values above 1 can distort sound, so if you're trying to balance sounds, experiment to see if scaling down works better than scaling up.
--- @field radius number @Default 0. If non-zero, will override default 3D spatial parameters of the sound. Radius is the distance away from the sound position that will be played at 100% volume.
--- @field falloff number @Default 0. If non-zero, will override default 3D spatial parameters of the sound. Falloff is the distance outside the radius over which the sound volume will gradually fall to zero.
--- @field isPlaying boolean @Returns if the sound is currently playing.
--- @field type string
local SmartAudioInstance = {}
--- Begins sound playback.
function SmartAudioInstance:Play() end

--- Stops sound playback.
function SmartAudioInstance:Stop() end

--- Starts playing and fades in the sound over the given time.
--- @param time number
function SmartAudioInstance:FadeIn(time) end

--- Fades the sound out and stops over time seconds.
--- @param time number
function SmartAudioInstance:FadeOut(time) end

--- @param typeName string
--- @return boolean
function SmartAudioInstance:IsA(typeName) end

--- @class GlobalSmartAudio : SmartObject @SmartAudio objects are SmartObjects that wrap sound files. Similar to Audio objects, they have many of the same properties and functions.
SmartAudio = {}

--- @class SmartObject : CoreObject @SmartObject is a top-level container for some complex objects and inherits everything from CoreObject. Note that some properties, such as `collision` or `visibility`, may not be respected by a SmartObject.
--- @field team number @Assigns the SmartObject to a team. Value range from 0 to 4. 0 is neutral team.
--- @field isTeamColorUsed boolean @If `true`, and the SmartObject has been assigned to a valid team, players on that team will see one color, while other players will see another color. Requires a SmartObject that supports team colors.
--- @field type string
local SmartObjectInstance = {}
--- Returns a table containing the names and values of all smart properties on a SmartObject.
--- @return table
function SmartObjectInstance:GetSmartProperties() end

--- Given a property name, returns the current value of that property on a SmartObject. Returns the value, which can be an integer, number, boolean, string, Vector3, Rotator, Color, or nil if not found. Second return value is a boolean, true if the property was found and false if not.
--- @param propertyName string
--- @return any|boolean
function SmartObjectInstance:GetSmartProperty(propertyName) end

--- Sets the value of an exposed property. Value can be of type number, boolean, string, Vector3, Rotation or Color, but must match the type of the property. Returns true if the property was set successfully and false if not.
--- @param propertyName string
--- @param propertyValue any
--- @return boolean
function SmartObjectInstance:SetSmartProperty(propertyName, propertyValue) end

--- @param typeName string
--- @return boolean
function SmartObjectInstance:IsA(typeName) end

--- @class GlobalSmartObject : CoreObject @SmartObject is a top-level container for some complex objects and inherits everything from CoreObject. Note that some properties, such as `collision` or `visibility`, may not be respected by a SmartObject.
SmartObject = {}

--- @class SpotLight : Light @SpotLight is a Light that shines in a specific direction from the location at which it is placed.
--- @field hasNaturalFalloff boolean @The attenuation method of the light. When enabled, `attenuationRadius` is used. When disabled, `falloffExponent` is used. Also changes the interpretation of the intensity property, see intensity for details.
--- @field falloffExponent number @Controls the radial falloff of the light when `hasNaturalFalloff` is false. 2.0 is almost linear and very unrealistic and around 8.0 it looks reasonable. With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents.
--- @field sourceRadius number @Radius of light source shape.
--- @field sourceLength number @Length of light source shape.
--- @field innerConeAngle number @The angle (in degrees) of the cone within which the projected light achieves full brightness.
--- @field outerConeAngle number @The outer angle (in degrees) of the cone of light emitted by this SpotLight.
--- @field type string
local SpotLightInstance = {}
--- @param typeName string
--- @return boolean
function SpotLightInstance:IsA(typeName) end

--- @class GlobalSpotLight : Light @SpotLight is a Light that shines in a specific direction from the location at which it is placed.
SpotLight = {}

--- @class StaticMesh : CoreMesh @StaticMesh is a static CoreMesh. StaticMeshes can be placed in the scene and (if networked or client-only) moved at runtime, but the mesh itself cannot be animated.. . See AnimatedMesh for meshes with animations.
--- @field isSimulatingDebrisPhysics boolean @If `true`, physics will be enabled for the mesh.
--- @field type string
local StaticMeshInstance = {}
--- Set the material in the given slot to the material specified by assetId.
--- @param assetId string
--- @param slotName string
function StaticMeshInstance:SetMaterialForSlot(assetId, slotName) end

--- Get the MaterialSlot object for the given slot. If called on the client on a networked object, the resulting object cannot be modified.
--- @param slotName string
--- @return MaterialSlot
function StaticMeshInstance:GetMaterialSlot(slotName) end

--- Get an array of all MaterialSlots on this mesh. If called on the client on a networked object, the resulting object cannot be modified.
--- @return table<number, MaterialSlot>
function StaticMeshInstance:GetMaterialSlots() end

--- Resets a material slot to its original state.
--- @param slotName string
function StaticMeshInstance:ResetMaterialSlot(slotName) end

--- Returns a `Box` describing the mesh bounds. The `Box` span may exceed the exact extrema of the object. Optional parameters can be provided to control the results:
--- 
--- `inLocalSpace (boolean)`: If true, the box will describe the bounds in the mesh's local coordinate system. Defaults to false.
--- 
--- `onlyCollidable (boolean)`: If true, the box will only describe the bounds of the mesh's collidable geometry. This can be affected by collision settings and network context. Defaults to false.
--- @param optionalParameters table
--- @return Box
function StaticMeshInstance:GetBoundingBox(optionalParameters) end

--- @param typeName string
--- @return boolean
function StaticMeshInstance:IsA(typeName) end

--- @class GlobalStaticMesh : CoreMesh @StaticMesh is a static CoreMesh. StaticMeshes can be placed in the scene and (if networked or client-only) moved at runtime, but the mesh itself cannot be animated.. . See AnimatedMesh for meshes with animations.
StaticMesh = {}

--- @class Task @Task is a representation of a Lua thread. It could be a Script initialization, a repeating `Tick()` function from a Script, an EventListener invocation, or a Task spawned directly by a call to `Task.Spawn()`.
--- @field repeatInterval number @For repeating Tasks, the number of seconds to wait after the Task completes before running it again. If set to 0, the Task will wait until the next frame.
--- @field repeatCount number @If set to a non-negative number, the Task will execute that many times. A negative number indicates the Task should repeat indefinitely (until otherwise canceled). With the default of 0, the Task will execute once. With a value of 1, the script will repeat once, meaning it will execute twice.
--- @field id number @A unique identifier for the task.
--- @field type string
local TaskInstance = {}
--- Cancels the Task immediately. It will no longer be executed, regardless of the state it was in. If called on the currently executing Task, that Task will halt execution.
function TaskInstance:Cancel() end

--- Returns the status of the Task. Possible values include: TaskStatus.UNINITIALIZED, TaskStatus.SCHEDULED, TaskStatus.RUNNING, TaskStatus.COMPLETED, TaskStatus.YIELDED, TaskStatus.FAILED, TaskStatus.CANCELED.
--- @return TaskStatus
function TaskInstance:GetStatus() end

--- @param typeName string
--- @return boolean
function TaskInstance:IsA(typeName) end

--- @class GlobalTask @Task is a representation of a Lua thread. It could be a Script initialization, a repeating `Tick()` function from a Script, an EventListener invocation, or a Task spawned directly by a call to `Task.Spawn()`.
Task = {}
--- Creates a new Task which will call taskFunction without blocking the current task. The optional delay parameter specifies how many seconds before the task scheduler should run the Task. By default, the scheduler will run the Task at the end of the current frame.
--- @overload fun(func: function): Task
--- @param func function
--- @param delay number
--- @return Task
function Task.Spawn(func, delay) end

--- Returns the currently running Task.
--- @return Task
function Task.GetCurrent() end

--- Yields the current Task, resuming in delay seconds, or during the next frame if delay is not specified. Returns the amount of time that was actually waited, as well as how long a wait was requested.
--- @overload fun()
--- @param delay number
function Task.Wait(delay) end


--- @class Terrain : CoreObject @Terrain is a CoreObject representing terrain placed in the world.
--- @field type string
local TerrainInstance = {}
--- @param typeName string
--- @return boolean
function TerrainInstance:IsA(typeName) end

--- @class GlobalTerrain : CoreObject @Terrain is a CoreObject representing terrain placed in the world.
Terrain = {}

--- @class Transform @Transforms represent the position, rotation, and scale of objects in the game. They are immutable, but new Transforms can be created when you want to change an object's Transform.
--- @field type string
--- @operator mul(Quaternion): Transform @ Multiplication operator.
--- @operator mul(Transform): Transform @ Multiplication operator.
local TransformInstance = {}
--- Returns a copy of the Rotation component of the Transform.
--- @return Rotation
function TransformInstance:GetRotation() end

--- Sets the rotation component of the Transform.
--- @param rotation Rotation
function TransformInstance:SetRotation(rotation) end

--- Returns a copy of the position component of the Transform.
--- @return Vector3
function TransformInstance:GetPosition() end

--- Sets the position component of the Transform.
--- @param position Vector3
function TransformInstance:SetPosition(position) end

--- Returns a copy of the scale component of the Transform.
--- @return Vector3
function TransformInstance:GetScale() end

--- Sets the scale component of the Transform.
--- @param scale Vector3
function TransformInstance:SetScale(scale) end

--- Returns a quaternion-based representation of the Rotation.
--- @return Quaternion
function TransformInstance:GetQuaternion() end

--- Sets the quaternion-based representation of the Rotation.
--- @param quaternion Quaternion
function TransformInstance:SetQuaternion(quaternion) end

--- Forward vector of the Transform.
--- @return Vector3
function TransformInstance:GetForwardVector() end

--- Right vector of the Transform.
--- @return Vector3
function TransformInstance:GetRightVector() end

--- Up vector of the Transform.
--- @return Vector3
function TransformInstance:GetUpVector() end

--- Inverse of the Transform.
--- @return Transform
function TransformInstance:GetInverse() end

--- Applies the Transform to the given position in 3D space.
--- @param position Vector3
--- @return Vector3
function TransformInstance:TransformPosition(position) end

--- Applies the Transform to the given directional Vector3. This will rotate and scale the Vector3, but does not apply the Transform's position.
--- @param direction Vector3
--- @return Vector3
function TransformInstance:TransformDirection(direction) end

--- @param typeName string
--- @return boolean
function TransformInstance:IsA(typeName) end

--- @class GlobalTransform @Transforms represent the position, rotation, and scale of objects in the game. They are immutable, but new Transforms can be created when you want to change an object's Transform.
--- @field IDENTITY Transform @Constant identity Transform.
Transform = {}
--- Constructs a new identity Transform.
--- @overload fun(xAxis: Vector3,yAxis: Vector3,zAxis: Vector3,position: Vector3): Transform
--- @overload fun(rotation: Rotation,position: Vector3,scale: Vector3): Transform
--- @overload fun(rotation: Quaternion,position: Vector3,scale: Vector3): Transform
--- @overload fun(): Transform
--- @param transform Transform
--- @return Transform
function Transform.New(transform) end


--- @class TreadedVehicle : Vehicle @TreadedVehicle is a Vehicle with treads, such as a tank or a tonk.
--- @field turnSpeed number @The turn speed in degrees per second.
--- @field type string
local TreadedVehicleInstance = {}
--- @param typeName string
--- @return boolean
function TreadedVehicleInstance:IsA(typeName) end

--- @class GlobalTreadedVehicle : Vehicle @TreadedVehicle is a Vehicle with treads, such as a tank or a tonk.
TreadedVehicle = {}

--- @class Trigger : CoreObject @A trigger is an invisible and non-colliding CoreObject which fires events when it interacts with another object (for example a Player walks into it):
--- @field beginOverlapEvent Event @Fired when an object enters the Trigger volume. The first parameter is the Trigger itself. The second is the object overlapping the Trigger, which may be a CoreObject, a Player, or some other type. Call `other:IsA()` to check the type.
--- @field endOverlapEvent Event @Fired when an object exits the Trigger volume. Parameters the same as `beginOverlapEvent.`
--- @field interactedEvent Event @Fired when a player uses the interaction on a trigger volume (<kbd>F</kbd> key). The first parameter is the Trigger itself and the second parameter is a Player.
--- @field interactableFocusedEvent Event @Fired when a player has focused on an interactable Trigger and may interact with it.
--- @field interactableUnfocusedEvent Event @Fired when a player is no longer focused on a previously focused interactable Trigger.
--- @field isInteractable boolean @Interactable Triggers expect Players to walk up and press the <kbd>F</kbd> key to activate them.
--- @field interactionLabel string @The text players will see in their HUD when they come into range of interacting with this trigger.
--- @field team number @Assigns the trigger to a team. Value range from 0 to 4. 0 is neutral team.
--- @field isTeamCollisionEnabled boolean @If `false`, and the Trigger has been assigned to a valid team, players on that team will not overlap or interact with the Trigger.
--- @field isEnemyCollisionEnabled boolean @If `false`, and the Trigger has been assigned to a valid team, players on enemy teams will not overlap or interact with the Trigger.
--- @field type string
local TriggerInstance = {}
--- Returns true if given player overlaps with the Trigger.
--- @param otherObject Object
--- @return boolean
function TriggerInstance:IsOverlapping(otherObject) end

--- Returns a list of all objects that are currently overlapping with the Trigger.
--- @return table<number, Object>
function TriggerInstance:GetOverlappingObjects() end

--- @param typeName string
--- @return boolean
function TriggerInstance:IsA(typeName) end

--- @class GlobalTrigger : CoreObject @A trigger is an invisible and non-colliding CoreObject which fires events when it interacts with another object (for example a Player walks into it):
Trigger = {}

--- @class UIButton : UIControl @A UIControl for a button, should be inside client context. Inherits from [UIControl](uicontrol.md).
--- @field clickedEvent Event @Fired when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox.
--- @field pressedEvent Event @Fired when button is pressed. (mouse button down)
--- @field releasedEvent Event @Fired when button is released. (mouse button up)
--- @field hoveredEvent Event @Fired when button is hovered.
--- @field unhoveredEvent Event @Fired when button is unhovered.
--- @field pinchStartedEvent Event @Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched.
--- @field pinchStoppedEvent Event @Fired when the player ends a pinching gesture on a touch input device.
--- @field rotateStartedEvent Event @Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated.
--- @field rotateStoppedEvent Event @Fired when the player ends a rotating gesture on a touch input device.
--- @field touchStartedEvent Event @Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device.
--- @field touchStoppedEvent Event @Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device.
--- @field tappedEvent Event @Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed.
--- @field flickedEvent Event @Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc.
--- @field text string @Returns the button's label text.
--- @field fontSize number @Returns the font size of the label text.
--- @field isInteractable boolean @Returns whether the Button can interact with the cursor (click, hover, etc).
--- @field shouldClipToSize boolean @Whether or not the button and its shadow should be clipped when exceeding the bounds of this control.
--- @field shouldScaleToFit boolean @Whether or not the button's label should scale down to fit within the bounds of this control.
--- @field boundAction string @Returns the name of the action binding that is toggled when the button is pressed or released, or `nil` if no binding has been set.
--- @field isHittable boolean @When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it.
--- @field type string
local UIButtonInstance = {}
--- Sets the image to a new MUID. You can get this MUID from an Asset Reference.
--- @param imageId string
function UIButtonInstance:SetImage(imageId) end

--- Gets the button's default color.
--- @return Color
function UIButtonInstance:GetButtonColor() end

--- Sets the button's default color.
--- @param color Color
function UIButtonInstance:SetButtonColor(color) end

--- Gets the button's color when hovered.
--- @return Color
function UIButtonInstance:GetHoveredColor() end

--- Sets the button's color when hovered.
--- @param color Color
function UIButtonInstance:SetHoveredColor(color) end

--- Gets the button's color when pressed.
--- @return Color
function UIButtonInstance:GetPressedColor() end

--- Sets the button's color when pressed.
--- @param color Color
function UIButtonInstance:SetPressedColor(color) end

--- Gets the button's color when it's not interactable.
--- @return Color
function UIButtonInstance:GetDisabledColor() end

--- Sets the button's color when it's not interactable.
--- @param color Color
function UIButtonInstance:SetDisabledColor(color) end

--- Gets the font's color.
--- @return Color
function UIButtonInstance:GetFontColor() end

--- Sets the font's color.
--- @param color Color
function UIButtonInstance:SetFontColor(color) end

--- Sets the button's text to use the specified font asset.
--- @param font string
function UIButtonInstance:SetFont(font) end

--- Returns the color of the button's drop shadow.
--- @return Color
function UIButtonInstance:GetShadowColor() end

--- Sets the color of the button's drop shadow.
--- @param color Color
function UIButtonInstance:SetShadowColor(color) end

--- Returns the offset of the button's drop shadow in UI space.
--- @return Vector2
function UIButtonInstance:GetShadowOffset() end

--- Sets the offset of the button's drop shadow in UI space.
--- @param vector2 Vector2
function UIButtonInstance:SetShadowOffset(vector2) end

--- Returns the touch index currently interacting with this button. Returns `nil` if the button is not currently being interacted with.
--- @return number
function UIButtonInstance:GetCurrentTouchIndex() end

--- @param typeName string
--- @return boolean
function UIButtonInstance:IsA(typeName) end

--- @class GlobalUIButton : UIControl @A UIControl for a button, should be inside client context. Inherits from [UIControl](uicontrol.md).
UIButton = {}

--- @class UIContainer : UIControl @A UIContainer is a type of UIControl. All other UI elements must be a descendant of a UIContainer to be visible. It does not have a position or size. It is always the size of the entire screen. It has no properties or functions of its own, but inherits everything from CoreObject. Inherits from [UIControl](uicontrol.md).
--- @field opacity number @Controls the opacity of the container's contents by multiplying the alpha component of descendants' colors. Note that other UIPanels and UIContainers in the hierarchy may also contribute their own opacity values. A resulting alpha value of 1 or greater is fully opaque, 0 is fully transparent.
--- @field cylinderArcAngle number @When the container is rendered in 3D space, this adjusts the curvature of the canvas in degrees. Changing this value will force a redraw.
--- @field useSafeArea boolean @When `true`, the size and position of the container is inset to avoid overlapping with a device's display elements, such as a mobile phone's notch. When `false`, the container is the same size and shape as the device's display regardless of a device's display features. This property has no effect on containers rendered in 3D space.
--- @field isScreenSpace boolean @When `true`, this container is rendered in screen space. When `false`, it is rendered in 3D world space. Defaults to `true`.
--- @field type string
local UIContainerInstance = {}
--- Returns the size of the canvas when drawn in 3D space.
--- @return Vector2
function UIContainerInstance:GetCanvasSize() end

--- Sets the size of the canvas when drawn in 3D space.
--- @param size Vector2
function UIContainerInstance:SetCanvasSize(size) end

--- Returns `true` if the container has completed initialization, otherwise returns `false`. Calls to get or set the absolute position of controls within a container may not perform correctly before the container has finished initialization.
--- @return boolean
function UIContainerInstance:IsCanvasReady() end

--- @param typeName string
--- @return boolean
function UIContainerInstance:IsA(typeName) end

--- @class GlobalUIContainer : UIControl @A UIContainer is a type of UIControl. All other UI elements must be a descendant of a UIContainer to be visible. It does not have a position or size. It is always the size of the entire screen. It has no properties or functions of its own, but inherits everything from CoreObject. Inherits from [UIControl](uicontrol.md).
UIContainer = {}

--- @class UIControl : CoreObject @UIControl is a CoreObject which serves as a base class for other UI controls.
--- @field x number @Screen-space offset from the anchor.
--- @field y number @Screen-space offset from the anchor.
--- @field width number @Horizontal size of the control.
--- @field height number @Vertical size of the control.
--- @field rotationAngle number @rotation angle of the control.
--- @field anchor UIPivot @The pivot point on this control that attaches to its parent. Can be one of `UIPivot.TOP_LEFT`, `UIPivot.TOP_CENTER`, `UIPivot.TOP_RIGHT`, `UIPivot.MIDDLE_LEFT`, `UIPivot.MIDDLE_CENTER`, `UIPivot.MIDDLE_RIGHT`, `UIPivot.BOTTOM_LEFT`, `UIPivot.BOTTOM_CENTER`, `UIPivot.BOTTOM_RIGHT`, or `UIPivot.CUSTOM`.
--- @field dock UIPivot @The pivot point on this control to which children attach. Can be one of `UIPivot.TOP_LEFT`, `UIPivot.TOP_CENTER`, `UIPivot.TOP_RIGHT`, `UIPivot.MIDDLE_LEFT`, `UIPivot.MIDDLE_CENTER`, `UIPivot.MIDDLE_RIGHT`, `UIPivot.BOTTOM_LEFT`, `UIPivot.BOTTOM_CENTER`, `UIPivot.BOTTOM_RIGHT`, or `UIPivot.CUSTOM`.
--- @field type string
local UIControlInstance = {}
--- Returns the absolute screen position of the pivot for this control.
--- @return Vector2
function UIControlInstance:GetAbsolutePosition() end

--- Sets the absolute screen position of the pivot for this control.
--- @param position Vector2
function UIControlInstance:SetAbsolutePosition(position) end

--- Returns the absolute rotation in degrees (clockwise) for this control.
--- @return number
function UIControlInstance:GetAbsoluteRotation() end

--- Sets the absolute rotation in degrees (clockwise) for this control.
--- @param rotation number
function UIControlInstance:SetAbsoluteRotation(rotation) end

--- @param typeName string
--- @return boolean
function UIControlInstance:IsA(typeName) end

--- @class GlobalUIControl : CoreObject @UIControl is a CoreObject which serves as a base class for other UI controls.
UIControl = {}

--- @class UIEventRSVPButton : UIControl @A UIControl for a button which allows players to register for an event within a game. Similar to `UIButton`, but designed to present a consistent experience for players across all games. Inherits from [UIControl](uicontrol.md).
--- @field clickedEvent Event @Fired when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox.
--- @field pressedEvent Event @Fired when button is pressed. (mouse button down)
--- @field releasedEvent Event @Fired when button is released. (mouse button up)
--- @field hoveredEvent Event @Fired when button is hovered.
--- @field unhoveredEvent Event @Fired when button is unhovered.
--- @field pinchStartedEvent Event @Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched.
--- @field pinchStoppedEvent Event @Fired when the player ends a pinching gesture on a touch input device.
--- @field rotateStartedEvent Event @Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated.
--- @field rotateStoppedEvent Event @Fired when the player ends a rotating gesture on a touch input device.
--- @field touchStartedEvent Event @Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device.
--- @field touchStoppedEvent Event @Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device.
--- @field tappedEvent Event @Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed.
--- @field flickedEvent Event @Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc.
--- @field isInteractable boolean @Returns whether the button can interact with the cursor (click, hover, etc).
--- @field eventId string @Returns the ID of the event for which this button is currently configured. This ID can be found in the creator dashboard or using the `CoreGameEvent.id` property of an event returned from various `CorePlatform` functions.
--- @field isHittable boolean @When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it.
--- @field type string
local UIEventRSVPButtonInstance = {}
--- Returns the touch index currently interacting with this button. Returns `nil` if the button is not currently being interacted with.
--- @return number
function UIEventRSVPButtonInstance:GetCurrentTouchIndex() end

--- @param typeName string
--- @return boolean
function UIEventRSVPButtonInstance:IsA(typeName) end

--- @class GlobalUIEventRSVPButton : UIControl @A UIControl for a button which allows players to register for an event within a game. Similar to `UIButton`, but designed to present a consistent experience for players across all games. Inherits from [UIControl](uicontrol.md).
UIEventRSVPButton = {}

--- @class UIImage : UIControl @A UIControl for displaying an image. Inherits from [UIControl](uicontrol.md).
--- @field pinchStartedEvent Event @Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched.
--- @field pinchStoppedEvent Event @Fired when the player ends a pinching gesture on a touch input device.
--- @field rotateStartedEvent Event @Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated.
--- @field rotateStoppedEvent Event @Fired when the player ends a rotating gesture on a touch input device.
--- @field touchStartedEvent Event @Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device.
--- @field touchStoppedEvent Event @Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device.
--- @field tappedEvent Event @Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed.
--- @field flickedEvent Event @Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc.
--- @field isTeamColorUsed boolean @If `true`, the image will be tinted blue if its team matches the Player, or red if not.
--- @field team number @the team of the image, used for `isTeamColorUsed`.
--- @field shouldClipToSize boolean @Whether or not the image and its shadow should be clipped when exceeding the bounds of this control.
--- @field isFlippedHorizontal boolean @Whether or not the image is flipped horizontally.
--- @field isFlippedVertical boolean @Whether or not the image is flipped vertically.
--- @field isHittable boolean @When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it.
--- @field type string
local UIImageInstance = {}
--- Returns the current color of the UIImage.
--- @return Color
function UIImageInstance:GetColor() end

--- Sets the UIImage to a color.
--- @param color Color
function UIImageInstance:SetColor(color) end

--- Sets the UIImage to a new image asset ID. You can get this ID from an Asset Reference.
--- @overload fun(self: UIImage,imageId: string)
--- @param player Player
function UIImageInstance:SetImage(player) end

--- Downloads and sets a Player's profile picture as the texture for this UIImage control.
--- @overload fun(self: UIImage,playerId: string)
--- @overload fun(self: UIImage,friend: CoreFriendCollectionEntry)
--- @overload fun(self: UIImage,playerProfile: CorePlayerProfile)
--- @param player Player
function UIImageInstance:SetPlayerProfile(player) end

--- Downloads and sets a game screenshot as the texture for this UIImage control. The screenshot may come from a different game.
--- @overload fun(gameId: string)
--- @param gameId string
--- @param screenshotIndex number
function UIImageInstance:SetGameScreenshot(gameId, screenshotIndex) end

--- Downloads and sets a game event image as the texture for this UIImage control.
--- @param gameEvent CoreGameEvent
function UIImageInstance:SetGameEvent(gameEvent) end

--- Returns the `imageId` assigned to this UIImage control. **Note:** As of 1.0.211, this function returns `nil` instead of `"0BADBADBADBADBAD"` when no image asset has been set.
--- @return string
function UIImageInstance:GetImage() end

--- Returns the color of the image's drop shadow.
--- @return Color
function UIImageInstance:GetShadowColor() end

--- Sets the color of the image's drop shadow.
--- @param color Color
function UIImageInstance:SetShadowColor(color) end

--- Returns the offset of the image's drop shadow in UI space.
--- @return Vector2
function UIImageInstance:GetShadowOffset() end

--- Sets the offset of the image's drop shadow in UI space.
--- @param vector2 Vector2
function UIImageInstance:SetShadowOffset(vector2) end

--- Downloads and sets a blockchain token image as the texture for this UIImage control.
--- @param blockchainToken BlockchainToken
function UIImageInstance:SetBlockchainToken(blockchainToken) end

--- Sets the UIImage to display the given camera capture. If the given capture is not valid, it will be ignored. If the capture is released while in use, this UIImage will revert to its default image.
--- @param cameraCapture CameraCapture
function UIImageInstance:SetCameraCapture(cameraCapture) end

--- Returns the touch index currently interacting with this image. Returns `nil` if the image is not currently being interacted with.
--- @return number
function UIImageInstance:GetCurrentTouchIndex() end

--- @param typeName string
--- @return boolean
function UIImageInstance:IsA(typeName) end

--- @class GlobalUIImage : UIControl @A UIControl for displaying an image. Inherits from [UIControl](uicontrol.md).
UIImage = {}

--- @class UIPanel : UIControl @A UIControl which can be used for containing and laying out other UI controls. Inherits from [UIControl](uicontrol.md).
--- @field shouldClipChildren number @If `true`, children of this UIPanel will not draw outside of its bounds.
--- @field opacity number @Controls the opacity of the panel's contents by multiplying the alpha component of descendants' colors. Note that other UIPanels and UIContainers in the hierarchy may also contribute their own opacity values. A resulting alpha value of 1 or greater is fully opaque, 0 is fully transparent.
--- @field type string
local UIPanelInstance = {}
--- @param typeName string
--- @return boolean
function UIPanelInstance:IsA(typeName) end

--- @class GlobalUIPanel : UIControl @A UIControl which can be used for containing and laying out other UI controls. Inherits from [UIControl](uicontrol.md).
UIPanel = {}

--- @class UIPerkPurchaseButton : UIControl @A UIControl for a button which allows players to purchase perks within a game. Similar to `UIButton`, but designed to present a consistent purchasing experience for players across all games. Inherits from [UIControl](uicontrol.md).
--- @field clickedEvent Event @Fired when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox.
--- @field pressedEvent Event @Fired when button is pressed. (mouse button down)
--- @field releasedEvent Event @Fired when button is released. (mouse button up)
--- @field hoveredEvent Event @Fired when button is hovered.
--- @field unhoveredEvent Event @Fired when button is unhovered.
--- @field pinchStartedEvent Event @Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched.
--- @field pinchStoppedEvent Event @Fired when the player ends a pinching gesture on a touch input device.
--- @field rotateStartedEvent Event @Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated.
--- @field rotateStoppedEvent Event @Fired when the player ends a rotating gesture on a touch input device.
--- @field touchStartedEvent Event @Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device.
--- @field touchStoppedEvent Event @Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device.
--- @field tappedEvent Event @Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed.
--- @field flickedEvent Event @Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc.
--- @field isInteractable boolean @Returns whether the button can interact with the cursor (click, hover, etc).
--- @field isHittable boolean @When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it.
--- @field type string
local UIPerkPurchaseButtonInstance = {}
--- Configures this button to use the specified perk.
--- @param perkReference NetReference
function UIPerkPurchaseButtonInstance:SetPerkReference(perkReference) end

--- Returns a reference to the perk for which this button is currently configured. If no perk has been set, returns an unassigned NetReference. (See the `.isAssigned` property on `NetReference`.)
--- @return NetReference
function UIPerkPurchaseButtonInstance:GetPerkReference() end

--- Returns the touch index currently interacting with this button. Returns `nil` if the button is not currently being interacted with.
--- @return number
function UIPerkPurchaseButtonInstance:GetCurrentTouchIndex() end

--- @param typeName string
--- @return boolean
function UIPerkPurchaseButtonInstance:IsA(typeName) end

--- @class GlobalUIPerkPurchaseButton : UIControl @A UIControl for a button which allows players to purchase perks within a game. Similar to `UIButton`, but designed to present a consistent purchasing experience for players across all games. Inherits from [UIControl](uicontrol.md).
UIPerkPurchaseButton = {}

--- @class UIProgressBar : UIControl @A UIControl that displays a filled rectangle which can be used for things such as a health indicator. Inherits from [UIControl](uicontrol.md).
--- @field pinchStartedEvent Event @Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched.
--- @field pinchStoppedEvent Event @Fired when the player ends a pinching gesture on a touch input device.
--- @field rotateStartedEvent Event @Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated.
--- @field rotateStoppedEvent Event @Fired when the player ends a rotating gesture on a touch input device.
--- @field touchStartedEvent Event @Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device.
--- @field touchStoppedEvent Event @Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device.
--- @field tappedEvent Event @Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed.
--- @field flickedEvent Event @Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc.
--- @field progress number @From 0 to 1, how full the bar should be.
--- @field fillType ProgressBarFillType @Controls the direction in which the progress bar fills.
--- @field fillTileType ImageTileType @How the fill texture is tiled.
--- @field backgroundTileType ImageTileType @How the background texture is tiled.
--- @field isHittable boolean @When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it.
--- @field type string
local UIProgressBarInstance = {}
--- Sets the progress bar fill to use the image specified by the given asset ID.
--- @param imageId string
function UIProgressBarInstance:SetFillImage(imageId) end

--- Returns the asset ID of the image used for the progress bar fill.
--- @return string
function UIProgressBarInstance:GetFillImage() end

--- Sets the progress bar background to use the image specified by the given asset ID.
--- @param imageId string
function UIProgressBarInstance:SetBackgroundImage(imageId) end

--- Returns the asset ID of the image used for the progress bar background.
--- @return string
function UIProgressBarInstance:GetBackgroundImage() end

--- Returns the color of the fill.
--- @return Color
function UIProgressBarInstance:GetFillColor() end

--- Sets the color of the fill.
--- @param color Color
function UIProgressBarInstance:SetFillColor(color) end

--- Returns the color of the background.
--- @return Color
function UIProgressBarInstance:GetBackgroundColor() end

--- Sets the color of the background.
--- @param color Color
function UIProgressBarInstance:SetBackgroundColor(color) end

--- Returns the touch index currently interacting with this control. Returns `nil` if the control is not currently being interacted with.
--- @return number
function UIProgressBarInstance:GetCurrentTouchIndex() end

--- @param typeName string
--- @return boolean
function UIProgressBarInstance:IsA(typeName) end

--- @class GlobalUIProgressBar : UIControl @A UIControl that displays a filled rectangle which can be used for things such as a health indicator. Inherits from [UIControl](uicontrol.md).
UIProgressBar = {}

--- @class UIRewardPointsMeter : UIControl @A UIControl that displays the a players progress towards the daily Reward Points cap. Inherits from [UIControl](uicontrol.md).
--- @field pinchStartedEvent Event @Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched.
--- @field pinchStoppedEvent Event @Fired when the player ends a pinching gesture on a touch input device.
--- @field rotateStartedEvent Event @Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated.
--- @field rotateStoppedEvent Event @Fired when the player ends a rotating gesture on a touch input device.
--- @field touchStartedEvent Event @Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device.
--- @field touchStoppedEvent Event @Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device.
--- @field tappedEvent Event @Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed.
--- @field flickedEvent Event @Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc.
--- @field isHittable boolean @When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it.
--- @field type string
local UIRewardPointsMeterInstance = {}
--- Returns the touch index currently interacting with this control. Returns `nil` if the control is not currently being interacted with.
--- @return number
function UIRewardPointsMeterInstance:GetCurrentTouchIndex() end

--- @param typeName string
--- @return boolean
function UIRewardPointsMeterInstance:IsA(typeName) end

--- @class GlobalUIRewardPointsMeter : UIControl @A UIControl that displays the a players progress towards the daily Reward Points cap. Inherits from [UIControl](uicontrol.md).
UIRewardPointsMeter = {}

--- @class UIScrollPanel : UIControl @A UIControl that supports scrolling a child UIControl that is larger than itself. Inherits from [UIControl](uicontrol.md).
--- @field orientation Orientation @Determines whether the panel scrolls horizontally or vertically. Default is `Orientation.VERTICAL`.
--- @field scrollPosition number @The position in UI space of the scroll panel content. Defaults to 0, which is scrolled to the top or left, depending on orientation. Set to the value of `contentLength` to scroll to the end.
--- @field contentLength number @Returns the height or width of the scroll panel content, depending on orientation. This is the maximum value of `scrollPosition`.
--- @field isInteractable boolean @When `true`, panel scrolling is enabled. When `false`, scrolling is disabled. Defaults to `true`.
--- @field type string
local UIScrollPanelInstance = {}
--- @param typeName string
--- @return boolean
function UIScrollPanelInstance:IsA(typeName) end

--- @class GlobalUIScrollPanel : UIControl @A UIControl that supports scrolling a child UIControl that is larger than itself. Inherits from [UIControl](uicontrol.md).
UIScrollPanel = {}

--- @class UIText : UIControl @A UIControl which displays a basic text label. Inherits from [UIControl](uicontrol.md).
--- @field pinchStartedEvent Event @Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched.
--- @field pinchStoppedEvent Event @Fired when the player ends a pinching gesture on a touch input device.
--- @field rotateStartedEvent Event @Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated.
--- @field rotateStoppedEvent Event @Fired when the player ends a rotating gesture on a touch input device.
--- @field touchStartedEvent Event @Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device.
--- @field touchStoppedEvent Event @Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device.
--- @field tappedEvent Event @Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed.
--- @field flickedEvent Event @Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc.
--- @field text string @The actual text string to show.
--- @field fontSize number @The font size of the UIText control.
--- @field outlineSize number @The thickness of the outline around text in this control. A value of 0 means no outline.
--- @field justification TextJustify @Determines the alignment of `text`. Possible values are: TextJustify.LEFT, TextJustify.RIGHT, and TextJustify.CENTER.
--- @field shouldWrapText boolean @Whether or not text should be wrapped within the bounds of this control.
--- @field shouldClipText boolean @Whether or not text should be clipped when exceeding the bounds of this control.
--- @field shouldScaleToFit boolean @Whether or not text should scale down to fit within the bounds of this control.
--- @field isHittable boolean @When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it.
--- @field type string
local UITextInstance = {}
--- Returns the color of the Text.
--- @return Color
function UITextInstance:GetColor() end

--- Sets the color of the Text.
--- @param color Color
function UITextInstance:SetColor(color) end

--- Attempts to determine the size of the rendered block of text. This may return `nil` if the size cannot be determined, for example because the underlying widget has not been fully initialized yet.
--- @return Vector2
function UITextInstance:ComputeApproximateSize() end

--- Sets the text to use the specified font asset.
--- @param font string
function UITextInstance:SetFont(font) end

--- Returns the color of the text's drop shadow.
--- @return Color
function UITextInstance:GetShadowColor() end

--- Sets the color of the text's drop shadow.
--- @param color Color
function UITextInstance:SetShadowColor(color) end

--- Returns the offset of the text's drop shadow in UI space.
--- @return Vector2
function UITextInstance:GetShadowOffset() end

--- Sets the offset of the text's drop shadow in UI space.
--- @param vector2 Vector2
function UITextInstance:SetShadowOffset(vector2) end

--- Returns the color of the text's outline.
--- @return Color
function UITextInstance:GetOutlineColor() end

--- Sets the color of the text's outline.
--- @param color Color
function UITextInstance:SetOutlineColor(color) end

--- Returns the touch index currently interacting with this control. Returns `nil` if the control is not currently being interacted with.
--- @return number
function UITextInstance:GetCurrentTouchIndex() end

--- @param typeName string
--- @return boolean
function UITextInstance:IsA(typeName) end

--- @class GlobalUIText : UIControl @A UIControl which displays a basic text label. Inherits from [UIControl](uicontrol.md).
UIText = {}

--- @class UITextEntry : UIControl @A UIControl which provides an editable text input field. Inherits from [UIControl](uicontrol.md).
--- @field textCommittedEvent Event @Fired when the control loses focus and text in the control is committed.
--- @field textChangedEvent Event @Fired when text in the control is changed.
--- @field pinchStartedEvent Event @Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched.
--- @field pinchStoppedEvent Event @Fired when the player ends a pinching gesture on a touch input device.
--- @field rotateStartedEvent Event @Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated.
--- @field rotateStoppedEvent Event @Fired when the player ends a rotating gesture on a touch input device.
--- @field touchStartedEvent Event @Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device.
--- @field touchStoppedEvent Event @Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device.
--- @field tappedEvent Event @Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed.
--- @field flickedEvent Event @Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc.
--- @field text string @The actual text string to show.
--- @field promptText string @Text to be displayed in the input box when `text` is empty.
--- @field isInteractable boolean @Returns whether the control can interact with the cursor (click, hover, etc).
--- @field fontSize number @The font size of the control.
--- @field isHittable boolean @When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it.
--- @field type string
local UITextEntryInstance = {}
--- Returns the color of the Text.
--- @return Color
function UITextEntryInstance:GetFontColor() end

--- Sets the color of the Text.
--- @param color Color
function UITextEntryInstance:SetFontColor(color) end

--- Returns the color of the text's background image.
--- @return Color
function UITextEntryInstance:GetBackgroundColor() end

--- Sets the color of the text's background image.
--- @param color Color
function UITextEntryInstance:SetBackgroundColor(color) end

--- Returns the color of the text's background image when hovering over it.
--- @return Color
function UITextEntryInstance:GetHoveredColor() end

--- Sets the color of the text's background image when hovering over it.
--- @param color Color
function UITextEntryInstance:SetHoveredColor(color) end

--- Returns the color of the text's background image when the text has focus.
--- @return Color
function UITextEntryInstance:GetFocusedColor() end

--- Sets the color of the text's background image when the text has focus.
--- @param color Color
function UITextEntryInstance:SetFocusedColor(color) end

--- Returns the color of the text's background image when the control is disabled.
--- @return Color
function UITextEntryInstance:GetDisabledColor() end

--- Sets the color of the text's background image when the control is disabled.
--- @param color Color
function UITextEntryInstance:SetDisabledColor(color) end

--- Returns the highlight color used when selecting text in the control.
--- @return Color
function UITextEntryInstance:GetFontSelectionColor() end

--- Sets the highlight color used when selecting text in the control.
--- @param color Color
function UITextEntryInstance:SetFontSelectionColor(color) end

--- Sets the image used as the background for the control.
--- @param imageId string
function UITextEntryInstance:SetImage(imageId) end

--- Sets the text to use the specified font asset.
--- @param font string
function UITextEntryInstance:SetFont(font) end

--- Gives keyboard focus to the control.
function UITextEntryInstance:Focus() end

--- Returns the touch index currently interacting with this control. Returns `nil` if the control is not currently being interacted with.
--- @return number
function UITextEntryInstance:GetCurrentTouchIndex() end

--- @param typeName string
--- @return boolean
function UITextEntryInstance:IsA(typeName) end

--- @class GlobalUITextEntry : UIControl @A UIControl which provides an editable text input field. Inherits from [UIControl](uicontrol.md).
UITextEntry = {}

--- @class Vector2 @A two-component vector that can represent a position or direction.
--- @field x number @The `x` component of the Vector2.
--- @field y number @The `y` component of the Vector2.
--- @field size number @The magnitude of the Vector2.
--- @field sizeSquared number @The squared magnitude of the Vector2.
--- @field type string
--- @operator add(number): Vector2 @ Addition operator.
--- @operator add(Vector2): Vector2 @ Addition operator.
--- @operator sub(number): Vector2 @ Subtraction operator.
--- @operator sub(Vector2): Vector2 @ Subtraction operator.
--- @operator mul(number): Vector2 @ Multiplication operator
--- @operator mul(Vector2): Vector2 @ Multiplication operator
--- @operator div(Vector2): Vector2 @ Division operator.
--- @operator div(number): Vector2 @ Division operator.
--- @operator unm: Vector2 @ Returns the negation of the Vector2.
--- @operator concat(Vector2): number @ Returns the dot product of the Vector2s.
--- @operator pow(Vector2): number @ Returns the cross product of the Vector2s.
local Vector2Instance = {}
--- Returns a new Vector2 with each component the absolute value of the component from this Vector2.
--- @return Vector2
function Vector2Instance:GetAbs() end

--- Returns a new Vector2 with size 1, but still pointing in the same direction. Returns (0, 0) if the vector is too small to be normalized.
--- @return Vector2
function Vector2Instance:GetNormalized() end

--- @param typeName string
--- @return boolean
function Vector2Instance:IsA(typeName) end

--- @class GlobalVector2 @A two-component vector that can represent a position or direction.
--- @field ZERO Vector2 @(0, 0)
--- @field ONE Vector2 @(1, 1)
Vector2 = {}
--- Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector2.
--- @param from Vector2
--- @param to Vector2
--- @param progress number
--- @return Vector2
function Vector2.Lerp(from, to, progress) end

--- Constructs a Vector2 with the given `x`, `y` values, defaults to (0, 0).
--- @overload fun(vector: Vector3): Vector2
--- @overload fun(vector: Vector2): Vector2
--- @overload fun(x: number,y: number): Vector2
--- @overload fun(): Vector2
--- @param xy number
--- @return Vector2
function Vector2.New(xy) end


--- @class Vector3 @A three-component vector that can represent a position or direction.
--- @field x number @The `x` component of the Vector3.
--- @field y number @The `y` component of the Vector3.
--- @field z number @The `z` component of the Vector3.
--- @field size number @The magnitude of the Vector3.
--- @field sizeSquared number @The squared magnitude of the Vector3.
--- @field type string
--- @operator add(number): Vector3 @ Addition operator.
--- @operator add(Vector3): Vector3 @ Addition operator.
--- @operator sub(number): Vector3 @ Subtraction operator.
--- @operator sub(Vector3): Vector3 @ Subtraction operator.
--- @operator mul(number): Vector3 @ Multiplication operator
--- @operator mul(Vector3): Vector3 @ Multiplication operator
--- @operator div(Vector3): Vector3 @ Division operator.
--- @operator div(number): Vector3 @ Division operator.
--- @operator unm: Vector3 @ Returns the negation of the Vector3.
--- @operator concat(Vector3): number @ Returns the dot product of the Vector3s.
--- @operator pow(Vector3): Vector3 @ Returns the cross product of the Vector3s.
local Vector3Instance = {}
--- Returns a new Vector3 with each component the absolute value of the component from this Vector3.
--- @return Vector3
function Vector3Instance:GetAbs() end

--- Returns a new Vector3 with size 1, but still pointing in the same direction. Returns (0, 0, 0) if the vector is too small to be normalized.
--- @return Vector3
function Vector3Instance:GetNormalized() end

--- @param typeName string
--- @return boolean
function Vector3Instance:IsA(typeName) end

--- @class GlobalVector3 @A three-component vector that can represent a position or direction.
--- @field ZERO Vector3 @(0, 0, 0)
--- @field ONE Vector3 @(1, 1, 1)
--- @field FORWARD Vector3 @(1, 0, 0)
--- @field UP Vector3 @(0, 0, 1)
--- @field RIGHT Vector3 @(0, 1, 0)
Vector3 = {}
--- Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector3.
--- @param from Vector3
--- @param to Vector3
--- @param progress number
--- @return Vector3
function Vector3.Lerp(from, to, progress) end

--- Constructs a Vector3 with the given `x`, `y`, `z` values, defaults to (0, 0, 0).
--- @overload fun(vector: Vector4): Vector3
--- @overload fun(vector: Vector3): Vector3
--- @overload fun(xy: Vector2,z: number): Vector3
--- @overload fun(x: number,y: number,z: number): Vector3
--- @overload fun(): Vector3
--- @param xyz number
--- @return Vector3
function Vector3.New(xyz) end


--- @class Vector4 @A four-component vector.
--- @field x number @The `x` component of the Vector4.
--- @field y number @The `y` component of the Vector4.
--- @field z number @The `z` component of the Vector4.
--- @field w number @The `w` component of the Vector4.
--- @field size number @The magnitude of the Vector4.
--- @field sizeSquared number @The squared magnitude of the Vector4.
--- @field type string
--- @operator add(number): Vector4 @ Addition operator.
--- @operator add(Vector4): Vector4 @ Addition operator.
--- @operator sub(number): Vector4 @ Subtraction operator.
--- @operator sub(Vector4): Vector4 @ Subtraction operator.
--- @operator mul(number): Vector4 @ Multiplication operator
--- @operator mul(Vector4): Vector4 @ Multiplication operator
--- @operator div(Vector4): Vector4 @ Division operator.
--- @operator div(number): Vector4 @ Division operator.
--- @operator unm: Vector4 @ Returns the negation of the Vector4.
--- @operator concat(Vector4): number @ Returns the dot product of the Vector4s.
--- @operator pow(Vector4): Vector4 @ Returns the cross product of the Vector4s.
local Vector4Instance = {}
--- Returns a new Vector4 with each component the absolute value of the component from this Vector4.
--- @return Vector4
function Vector4Instance:GetAbs() end

--- Returns a new Vector4 with size 1, but still pointing in the same direction. Returns (0, 0, 0, 0) if the vector is too small to be normalized.
--- @return Vector4
function Vector4Instance:GetNormalized() end

--- @param typeName string
--- @return boolean
function Vector4Instance:IsA(typeName) end

--- @class GlobalVector4 @A four-component vector.
--- @field ZERO Vector4 @(0, 0, 0, 0)
--- @field ONE Vector4 @(1, 1, 1, 1)
Vector4 = {}
--- Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector4.
--- @param from Vector4
--- @param to Vector4
--- @param progress number
--- @return Vector4
function Vector4.Lerp(from, to, progress) end

--- Constructs a Vector4 with the given `x`, `y`, `z`, `w` values, defaults to (0, 0, 0, 0).
--- @overload fun(color: Color): Vector4
--- @overload fun(xyzw: number): Vector4
--- @overload fun(xyz: Vector3,w: number): Vector4
--- @overload fun(vector: Vector4): Vector4
--- @overload fun(x: number,y: number,z: number,w: number): Vector4
--- @overload fun(): Vector4
--- @param xy Vector2
--- @param zw Vector2
--- @return Vector4
function Vector4.New(xy, zw) end


--- @class Vehicle : CoreObject @Vehicle is a CoreObject representing a vehicle that can be occupied and driven by a player. Vehicle also implements the [Damageable](damageable.md) interface.
--- @field driverEnteredEvent Event @Fired when a new driver occupies the vehicle.
--- @field driverExitedEvent Event @Fired when a driver exits the vehicle.
--- @field damagedEvent Event @Fired when the vehicle takes damage.
--- @field diedEvent Event @Fired when the vehicle dies.
--- @field clientMovementHook Hook @Hook called when processing the driver's input. The `parameters` table contains "throttleInput", "steeringInput", and "isHandbrakeEngaged". This is only called on the driver's client. "throttleInput" is a number -1.0, to 1.0, with positive values indicating forward input. "steeringInput" is the same, and positive values indicate turning to the right. "isHandbrakeEngaged" is a boolean.
--- @field serverMovementHook Hook @Hook called when on the server for a vehicle with no driver. This has the same parameters as clientMovementHook.
--- @field damageHook Hook @Hook called when applying damage from a call to `ApplyDamage()`. The incoming damage may be modified or prevented by modifying properties on the `damage` parameter.
--- @field canExit boolean @Returns `true` if the driver of the vehicle is allowed to exit using the Vehicle Exit binding.
--- @field isAccelerating boolean @Returns `true` if the vehicle is currently accelerating.
--- @field driver Player @The Player currently driving the vehicle, or `nil` if there is no driver.
--- @field mass number @Returns the mass of the vehicle in kilograms.
--- @field maxSpeed number @The maximum speed of the vehicle in centimeters per second.
--- @field accelerationRate number @The approximate acceleration rate of the vehicle in centimeters per second squared.
--- @field brakeStrength number @The maximum deceleration of the vehicle when stopping.
--- @field coastBrakeStrength number @The deceleration of the vehicle while coasting (with no forward or backward input).
--- @field tireFriction number @The amount of friction tires or treads have on the ground.
--- @field gravityScale number @How much gravity affects this vehicle.  Default value is 1.9.
--- @field isDriverHidden boolean @Returns `true` if the driver is made invisible while occupying the vehicle.
--- @field isDriverAttached boolean @Returns `true` if the driver is attached to the vehicle while they occupy it.
--- @field isBrakeEngaged boolean @Returns `true` if the driver of the vehicle is currently using the brakes.
--- @field isHandbrakeEngaged boolean @Returns `true` if the driver of the vehicle is currently using the handbrake.
--- @field driverAnimationStance string @Returns the animation stance that will be applied to the driver while they occupy the vehicle.
--- @field enterTrigger Trigger @Returns the Trigger a Player uses to occupy the vehicle.
--- @field camera Camera @Returns the Camera used for the driver while they occupy the vehicle.
--- @field hitPoints number @Current amount of hit points.
--- @field maxHitPoints number @Maximum amount of hit points.
--- @field isDead boolean @True if the object is dead, otherwise false. Death occurs when damage is applied which reduces hit points to 0, or when the `Die()` function is called.
--- @field isImmortal boolean @When set to `true`, this object cannot die.
--- @field isInvulnerable boolean @When set to `true`, this object does not take damage.
--- @field destroyOnDeath boolean @When set to `true`, this object will automatically be destroyed when it dies.
--- @field destroyOnDeathDelay number @Delay in seconds after death before this object is destroyed, if `destroyOnDeath` is set to `true`. Defaults to 0.
--- @field destroyOnDeathClientTemplateId string @Optional asset ID of a template to be spawned on clients when this object is automatically destroyed on death.
--- @field destroyOnDeathNetworkedTemplateId string @Optional asset ID of a networked template to be spawned on the server when this object is automatically destroyed on death.
--- @field type string
local VehicleInstance = {}
--- Returns the positional offset for the body collision of the vehicle.
--- @return Vector3
function VehicleInstance:GetPhysicsBodyOffset() end

--- Returns the scale offset for the body collision of the vehicle.
--- @return Vector3
function VehicleInstance:GetPhysicsBodyScale() end

--- Sets the given player as the new driver of the vehicle. A `nil` value will remove the current driver.
--- @param driver Player
function VehicleInstance:SetDriver(driver) end

--- Removes the current driver from the vehicle.
function VehicleInstance:RemoveDriver() end

--- Adds an impulse force to the vehicle.
--- @param impulse Vector3
function VehicleInstance:AddImpulse(impulse) end

--- Returns the position relative to the vehicle at which the driver is attached while occupying the vehicle.
--- @return Vector3
function VehicleInstance:GetDriverPosition() end

--- Returns the rotation with which the driver is attached while occupying the vehicle.
--- @return Rotation
function VehicleInstance:GetDriverRotation() end

--- Returns the center of mass offset for this vehicle.
--- @return Vector3
function VehicleInstance:GetCenterOfMassOffset() end

--- Sets the center of mass offset for this vehicle. This resets the vehicle state and may not behave nicely if called repeatedly or while in motion.
--- @param offset Vector3
function VehicleInstance:SetCenterOfMassOffset(offset) end

--- Damages the vehicle, unless it is invulnerable. If its hit points reach 0 and it is not immortal, it dies.
--- @param damage Damage
function VehicleInstance:ApplyDamage(damage) end

--- Kills the vehicle, unless it is immortal. The optional Damage parameter is a way to communicate cause of death.
--- @overload fun(self: Vehicle)
--- @param damage Damage
function VehicleInstance:Die(damage) end

--- @param typeName string
--- @return boolean
function VehicleInstance:IsA(typeName) end

--- @class GlobalVehicle : CoreObject @Vehicle is a CoreObject representing a vehicle that can be occupied and driven by a player. Vehicle also implements the [Damageable](damageable.md) interface.
Vehicle = {}

--- @class Vfx : SmartObject @Vfx is a specialized type of SmartObject for visual effects. It inherits everything from SmartObject.
--- @field type string
local VfxInstance = {}
--- Starts playing the effect. The `optionalParameters` table may be provided containing:
--- 
--- `includeDescendants (boolean)`: If `true`, also plays any `Vfx` descendants of this instance.
--- @overload fun()
--- @param optionalParameters table
function VfxInstance:Play(optionalParameters) end

--- Stops playing the effect. The `optionalParameters` table may be provided containing:
--- 
--- `includeDescendants (boolean)`: If `true`, also stops any `Vfx` descendants of this instance.
--- @overload fun()
--- @param optionalParameters table
function VfxInstance:Stop(optionalParameters) end

--- @param typeName string
--- @return boolean
function VfxInstance:IsA(typeName) end

--- @class GlobalVfx : SmartObject @Vfx is a specialized type of SmartObject for visual effects. It inherits everything from SmartObject.
Vfx = {}

--- @class VoiceChatChannel @A VoiceChatChannel represents a channel in voice chat, which may be used to find which players are in the channel and mute or unmute players.
--- @field name string @The name of this channel.
--- @field channelType VoiceChannelType @This channel's type.
--- @field type string
local VoiceChatChannelInstance = {}
--- Returns a list of players in this channel.
--- @return table<number, Player>
function VoiceChatChannelInstance:GetPlayers() end

--- Returns `true` if the given player is in this channel, otherwise returns `false`.
--- @param player Player
--- @return boolean
function VoiceChatChannelInstance:IsPlayerInChannel(player) end

--- Returns `true` if the given player is muted in this channel, otherwise returns `false`.
--- @param player Player
--- @return boolean
function VoiceChatChannelInstance:IsPlayerMuted(player) end

--- Mutes the given player in this channel.
--- @param player Player
function VoiceChatChannelInstance:MutePlayer(player) end

--- Unmutes the given player in this channel.
--- @param player Player
function VoiceChatChannelInstance:UnmutePlayer(player) end

--- @param typeName string
--- @return boolean
function VoiceChatChannelInstance:IsA(typeName) end

--- @class GlobalVoiceChatChannel @A VoiceChatChannel represents a channel in voice chat, which may be used to find which players are in the channel and mute or unmute players.
VoiceChatChannel = {}

--- @class Weapon : Equipment @A Weapon is an Equipment that comes with built-in Abilities and fires Projectiles.
--- @field projectileSpawnedEvent Event @Fired when a Weapon spawns a projectile.
--- @field targetImpactedEvent Event @Fired when a Weapon interacts with something. For example a shot hits a wall. The `ImpactData` parameter contains information such as which object was hit, who owns the Weapon, which ability was involved in the interaction, etc.
--- @field targetInteractionEvent Event @targetInteractionEvent is deprecated. Please use targetImpactedEvent instead.
--- @field attackCooldownDuration number @Interval between separate burst sequences. The value is set by the Shoot ability's Cooldown duration.
--- @field animationStance string @When the Weapon is equipped this animation stance is applied to the Player.
--- @field multiShotCount number @Number of Projectiles/Hitscans that will fire simultaneously inside the spread area each time the Weapon attacks. Does not affect the amount of ammo consumed per attack.
--- @field burstCount number @Number of automatic activations of the Weapon that generally occur in quick succession.
--- @field shotsPerSecond number @Used in conjunction with burstCount to determine the interval between automatic weapon activations.
--- @field shouldBurstStopOnRelease boolean @If `true`, a burst sequence can be interrupted by the Player by releasing the action button. If `false`, the burst continues firing automatically until it completes or the Weapon runs out of ammo.
--- @field isHitscan boolean @If `false`, the Weapon will produce simulated Projectiles. If `true`, it will instead use instantaneous line traces to simulate shots.
--- @field range number @Max travel distance of the Projectile (isHitscan = False) or range of the line trace (isHitscan = True).
--- @field damage number @Damage applied to a Player when the weapon attack hits a player target. If set to zero, no damage is applied.
--- @field directDamage number
--- @field projectileTemplateId string @Asset reference for the visual body of the Projectile, for non-hitscan Weapons.
--- @field muzzleFlashTemplateId string @Asset reference for a Vfx to be attached to the muzzle point each time the Weapon attacks.
--- @field trailTemplateId string @Asset reference for a trail Vfx to follow the trajectory of the shot.
--- @field beamTemplateId string @Asset reference for a beam Vfx to be placed along the trajectory of the shot. Useful for hitscan Weapons or very fast Projectiles.
--- @field impactSurfaceTemplateId string @Asset reference of a Vfx to be attached to the surface of any CoreObjects hit by the attack.
--- @field impactProjectileTemplateId string @Asset reference of a Vfx to be spawned at the interaction point. It will be aligned with the trajectory. If the impacted object is a CoreObject, then the Vfx will attach to it as a child.
--- @field impactPlayerTemplateId string @Asset reference of a Vfx to be spawned at the interaction point, if the impacted object is a player.
--- @field projectileSpeed number @Travel speed (cm/s) of Projectiles spawned by this weapon.
--- @field projectileLifeSpan number @Duration after which Projectiles are destroyed.
--- @field projectileGravity number @Gravity scale applied to spawned Projectiles.
--- @field projectileLength number @Length of the Projectile's capsule collision.
--- @field projectileRadius number @Radius of the Projectile's capsule collision
--- @field projectileDrag number @Drag on the Projectile.
--- @field projectileBounceCount number @Number of times the Projectile will bounce before it's destroyed. Each bounce generates an interaction event.
--- @field projectilePierceCount number @Number of objects that will be pierced by the Projectile before it's destroyed. Each pierce generates an interaction event.
--- @field maxAmmo number @How much ammo the Weapon starts with and its max capacity. If set to -1 then the Weapon has infinite capacity and doesn't need to reload.
--- @field currentAmmo number @Current amount of ammo stored in this Weapon.
--- @field ammoType string @A unique identifier for the ammunition type.
--- @field isAmmoFinite boolean @Determines where the ammo comes from. If `true`, then ammo will be drawn from the Player's Resource inventory and reload will not be possible until the Player acquires more ammo somehow. If `false`, then the Weapon simply reloads to full and inventory Resources are ignored.
--- @field outOfAmmoSoundId string @Asset reference for a sound effect to be played when the Weapon tries to activate, but is out of ammo.
--- @field reloadSoundId string @Asset reference for a sound effect to be played when the Weapon reloads ammo.
--- @field spreadMin number @Smallest size in degrees for the Weapon's cone of probability space to fire Projectiles in.
--- @field spreadMax number @Largest size in degrees for the Weapon's cone of probability space to fire Projectiles in.
--- @field spreadAperture number @The surface size from which shots spawn. An aperture of zero means shots originate from a single point.
--- @field spreadDecreaseSpeed number @Speed at which the spread contracts back from its current value to the minimum cone size.
--- @field spreadIncreasePerShot number @Amount the spread increases each time the Weapon attacks.
--- @field spreadPenaltyPerShot number @Cumulative penalty to the spread size for successive attacks. Penalty cools off based on `spreadDecreaseSpeed`.
--- @field attackSoundTemplateId string @Asset reference for a sound effect to be played each time the Weapon attacks.
--- @field type string
local WeaponInstance = {}
--- Informs whether the Weapon is able to attack or not.
--- @return boolean
function WeaponInstance:HasAmmo() end

--- Triggers the main ability of the Weapon. Optional target parameter can be a Vector3 world position, a Player, or a CoreObject.
--- @overload fun(self: Weapon,targetObject: CoreObject)
--- @overload fun(self: Weapon,targetWorldPosition: Vector3)
--- @overload fun(self: Weapon)
--- @param targetPlayer Player
function WeaponInstance:Attack(targetPlayer) end

--- @param typeName string
--- @return boolean
function WeaponInstance:IsA(typeName) end

--- @class GlobalWeapon : Equipment @A Weapon is an Equipment that comes with built-in Abilities and fires Projectiles.
Weapon = {}

--- @class WorldText : CoreObject @WorldText is an in-world text CoreObject.
--- @field text string @The text being displayed by this object.
--- @field type string
local WorldTextInstance = {}
--- The color of the Text.
--- @return Color
function WorldTextInstance:GetColor() end

--- The color of the Text.
--- @param color Color
function WorldTextInstance:SetColor(color) end

--- Sets the text to use the specified font asset.
--- @param font string
function WorldTextInstance:SetFont(font) end

--- @param typeName string
--- @return boolean
function WorldTextInstance:IsA(typeName) end

--- @class GlobalWorldText : CoreObject @WorldText is an in-world text CoreObject.
WorldText = {}

--- @class Blockchain
local BlockchainInstance = {}
--- @class GlobalBlockchain
Blockchain = {}
--- Looks up a single blockchain token given its contract address and token ID. This function may yield while fetching token data. May return nil if the requested token does not exist, or if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value.
--- @param contractAddress string
--- @param tokenId string
--- @return BlockchainToken|BlockchainTokenResultCode|string
function Blockchain.GetToken(contractAddress, tokenId) end

--- Searches for blockchain tokens owned by the specified player. This function may yield while fetching token data. May return nil if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value.
--- 
--- Optional parameters can be provided to filter the results:
--- 
--- `contractAddress (string)`: Only return tokens with the specified contract address.
--- 
--- `tokenIds (string or Array<string>)`: Only return tokens with the specified token IDs.
--- @overload fun(player: Player): BlockchainTokenCollection|BlockchainTokenResultCode|string
--- @param player Player
--- @param optionalParameters table
--- @return BlockchainTokenCollection|BlockchainTokenResultCode|string
function Blockchain.GetTokensForPlayer(player, optionalParameters) end

--- Searches for blockchain tokens owned by the specified wallet address. This function may yield while fetching token data. May return nil if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value.
--- 
--- Optional parameters can be provided to filter the results:
--- 
--- `contractAddress (string)`: Only return tokens with the specified contract address.
--- 
--- `tokenIds (string or Array<string>)`: Only return tokens with the specified token IDs.
--- @overload fun(ownerAddress: string): BlockchainTokenCollection|BlockchainTokenResultCode|string
--- @param ownerAddress string
--- @param optionalParameters table
--- @return BlockchainTokenCollection|BlockchainTokenResultCode|string
function Blockchain.GetTokensForOwner(ownerAddress, optionalParameters) end

--- Searches for blockchain tokens belonging to the specified contract address. This function may yield while fetching token data. May return nil if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value.
--- 
--- Optional parameters can be provided to filter the results:
--- 
--- `tokenIds (string or Array<string>)`: Only return tokens with the specified token IDs.
--- @overload fun(contractAddress: string): BlockchainTokenCollection|BlockchainTokenResultCode|string
--- @param contractAddress string
--- @param optionalParameters table
--- @return BlockchainTokenCollection|BlockchainTokenResultCode|string
function Blockchain.GetTokens(contractAddress, optionalParameters) end

--- Looks up a blockchain contract given the contract address. This function may yield while fetching the contract data. May return nil if the requested contract does not exist, or if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value.
--- @param contractAddress string
--- @return BlockchainContract|BlockchainTokenResultCode|string
function Blockchain.GetContract(contractAddress) end

--- @class Chat
local ChatInstance = {}
--- @class GlobalChat
--- @field receiveMessageHook Hook @Hook called when receiving a chat message from a Player. The `parameters` table contains a `string` named "message" containing the text of the message received, and a `string` named "speakerName" with the name of the message sender as it will be displayed in the chat window. Replacing "message" with an empty string will cancel receipt of the message.
--- @field sendMessageHook Hook @Hook called when sending a chat message. The `parameters` table contains a `string` named "message" containing the text of the message to be sent. Replacing "message" with an empty string will cancel sending the message.
Chat = {}
--- Sends a chat message to players. Messages sent from the server have a rate limit of 10 messages per second. Maximum message length is 280 characters. Messages exceeding that length will be cropped.
--- 
--- Optional parameters: `players` (Player or Array<Player>): A list of players who should receive the message. Defaults to all players in the game.
--- @overload fun(message: string): BroadcastMessageResultCode|string
--- @param message string
--- @param optionalParams table
--- @return BroadcastMessageResultCode|string
function Chat.BroadcastMessage(message, optionalParams) end

--- Sends a chat message to the local player. Maximum message length is 280 characters. There is no rate limit for local messages.
--- @overload fun(message: string)
--- @param message string
--- @param optionalParams table
function Chat.LocalMessage(message, optionalParams) end

--- @class CoreDebug
local CoreDebugInstance = {}
--- @class GlobalCoreDebug
CoreDebug = {}
--- Draws a debug line. `optionalParameters: duration (number), thickness (number), color (Color)`. 0 or negative duration results in a single frame.
--- @overload fun(startPosition: Vector3,endPosition: Vector3)
--- @param startPosition Vector3
--- @param endPosition Vector3
--- @param parameters table
function CoreDebug.DrawLine(startPosition, endPosition, parameters) end

--- Draws a debug box, with dimension specified as a vector. `optionalParameters` has same options as `DrawLine()`, with addition of: `rotation (Rotation)` - rotation of the box.
--- @overload fun(centerPosition: Vector3,scale: Vector3)
--- @param centerPosition Vector3
--- @param scale Vector3
--- @param parameters table
function CoreDebug.DrawBox(centerPosition, scale, parameters) end

--- Draws a debug sphere. `optionalParameters` has the same options as `DrawLine()`.
--- @overload fun(centerPosition: Vector3,radius: number)
--- @param centerPosition Vector3
--- @param radius number
--- @param parameters table
function CoreDebug.DrawSphere(centerPosition, radius, parameters) end

--- Returns a stack trace listing all actively executing Lua tasks and their method calls. Usually there is only one task actively executing at a time, with others in a yielded state and excluded from this trace. Multiple tasks can be included in the trace if one task triggers an event that has listeners registered, or if a task calls `require()` to load a new script.
--- @return string
function CoreDebug.GetStackTrace() end

--- Returns a stack trace listing the Lua method calls currently in progress by the given Task. Defaults to the current Task if `task` is not specified.
--- @overload fun(task: Task): string
--- @return string
function CoreDebug.GetTaskStackTrace() end

--- Returns a string representation of the given value. By default this will return the same result as Lua's built-in `tostring()` function, but some types may return additional information useful for debugging. The format of strings returned by this function is subject to change and should never be relied upon to return specific information.
--- @param object any
--- @return string
function CoreDebug.ToString(object) end

--- @class CoreMath
local CoreMathInstance = {}
--- @class GlobalCoreMath
CoreMath = {}
--- Rounds value to an integer, or to an optional number of decimal places, and returns the rounded value.
--- @overload fun(x: number): number
--- @param x number
--- @param decimals number
--- @return number
function CoreMath.Round(x, decimals) end

--- Linear interpolation between from and to. t should be a floating point number from 0 to 1, with 0 returning from and 1 returning to.
--- @overload fun(from: number,to: number): number
--- @param from number
--- @param to number
--- @param progress number
--- @return number
function CoreMath.Lerp(from, to, progress) end

--- Clamps value between lower and upper, inclusive. If lower and upper are not specified, defaults to 0 and 1.
--- @overload fun(x: number): number
--- @param x number
--- @param min number
--- @param max number
--- @return number
function CoreMath.Clamp(x, min, max) end

--- @class CorePlatform
local CorePlatformInstance = {}
--- @class GlobalCorePlatform
CorePlatform = {}
--- Requests metadata for a game with the given ID. Accepts full game IDs (for example "67442ee5c0654855b51c4f5fc96ab0fd") as well as the shorter slug version ("67442e/farmers-market"). This function may yield until a result is available, and may raise an error if the game ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls.
--- @param gameId string
--- @return CoreGameInfo
function CorePlatform.GetGameInfo(gameId) end

--- Requests a list of games belonging to a given collection. This function may yield until a result is available, and may raise an error if the collection ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. Supported collection IDs include: "new", "popular", "hot_games", "active", "featured", "highest_rated", "most_played", "most_engaging", "solo_friendly", and "tournament".
--- @param collectionId string
--- @return table<number, CoreGameCollectionEntry>
function CorePlatform.GetGameCollection(collectionId) end

--- Requests the public account profile for the player with the given ID. This function may yield until a result is available, and may raise an error if the player ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. When called in preview mode with a bot's player ID, a placeholder profile will be returned.
--- @param playerId string
--- @return CorePlayerProfile
function CorePlatform.GetPlayerProfile(playerId) end

--- Requests metadata for a creator event with the given event ID. Event IDs for specific events may be found in the Creator Events Dashboard. This function may yield until a result is available, and may raise an error if the event ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls.
--- @param eventId string
--- @return CoreGameEvent
function CorePlatform.GetGameEvent(eventId) end

--- Requests a list of creator events belonging to a given collection. This function may yield until a result is available, and may raise an error if the collection ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. Supported event collection IDs include: "active", "upcoming", "popular", and "suggested".
--- 
--- The following optional parameters are supported:
--- 
--- `state (CoreGameEventState)`: Filters the returned collection to include only events with the specified state. By default, active and upcoming events are returned.
--- @overload fun(collectionId: string): CoreGameEventCollection
--- @param collectionId string
--- @param optionalParameters table
--- @return CoreGameEventCollection
function CorePlatform.GetGameEventCollection(collectionId, optionalParameters) end

--- Requests a list of creator events for the specified game. This function may yield until a result is available, and may raise an error if the game ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls.
--- 
--- The following optional parameters are supported:
--- 
--- `state (CoreGameEventState)`: Filters the returned events to include only events with the specified state. By default, active and upcoming events are returned.
--- 
--- `tag (string)`: Filters the returned events to include only events with the given tag.
--- @overload fun(gameId: string): CoreGameEventCollection
--- @param gameId string
--- @param optionalParameters table
--- @return CoreGameEventCollection
function CorePlatform.GetGameEventsForGame(gameId, optionalParameters) end

--- Returns `true` if the given player is registered for the given event, or `false` if they are not. This function may yield until a result is available, and may raise an error if an error occurs retrieving the information. Results may be cached for later calls, and so may also not be immediately up to date. This function will raise an error if called from a client script with a player other than the local player.
--- @param player Player
--- @param gameEvent CoreGameEvent
--- @return boolean
function CorePlatform.IsPlayerRegisteredForGameEvent(player, gameEvent) end

--- Requests a list of creator events for which the given player is registered. This function may yield until a result is available, and may raise an error if an error occurs retrieving the information. This function will raise an error if called from a client script with a player other than the local player. Results may be cached for later calls.
--- 
--- The following optional parameters are supported:
--- 
--- `state (CoreGameEventState)`: Filters the returned events to include only events with the specified state. By default, active and upcoming events are returned.
--- @overload fun(player: Player): CoreGameEventCollection
--- @param player Player
--- @param optionalParameters table
--- @return CoreGameEventCollection
function CorePlatform.GetRegisteredGameEvents(player, optionalParameters) end

--- @class CoreSocial
local CoreSocialInstance = {}
--- @class GlobalCoreSocial
CoreSocial = {}
--- Returns `true` if the specified player is friends with the local player.
--- @overload fun(player: Player): boolean
--- @param playerId string
--- @return boolean
function CoreSocial.IsFriendsWithLocalPlayer(playerId) end

--- Requests a list of the given Player's friends. This function may yield until a result is available, and may raise an error if an error occurs retrieving the information. Results may be cached for later calls. A partial list of friends may be returned, depending on how many friends the player has. See `CoreFriendCollection` for information on retrieving more results. If a player has no friends, or when called in multiplayer preview mode for a bot player, an empty `CoreFriendCollection` will be returned.
--- @param player Player
--- @return CoreFriendCollection
function CoreSocial.GetFriends(player) end

--- @class CoreString
local CoreStringInstance = {}
--- @class GlobalCoreString
CoreString = {}
--- Splits the string `s` into substrings separated by `delimiter`.
--- 
--- Optional parameters in the `parameters` table include:
--- 
--- `removeEmptyResults (boolean)`: If `true`, empty strings will be removed from the results. Defaults to `false`.
--- 
--- `maxResults (integer)`: Limits the number of strings that will be returned. The last result will be any remaining unsplit portion of `s`.
--- 
--- `delimiters (string or Array<string>)`:Allows splitting on multiple delimiters. If both this and the `delimiter` parameter are specified, the combined list is used. If neither is specified, default is to split on any whitespace characters.
--- 
--- Note that this function does not return a table, it returns multiple strings. For example: `local myHello, myCore = CoreString.Split("Hello Core!")` If a table is desired, wrap the call to `Split()` in curly braces, eg: `local myTable = {CoreString.Split("Hello Core!")}`
--- @overload fun(string: string): any
--- @overload fun(string: string,optionalParameters: table): any
--- @overload fun(string: string,delimiter: string): any
--- @param string string
--- @return any
function CoreString.Split(string) end

--- Concatenates the given values together, separated by `delimiter`. If a given value is not a string, it is converted to one using `tostring()`.
--- @param delimiter string
--- @return string
function CoreString.Join(delimiter, ...) end

--- Trims whitespace from the start and end of `s`, returning the result. An optional list of strings may be provided to trim those strings from `s` instead of the default whitespace. For example, `CoreString.Trim("(==((Hello!))==)", "(==(", ")==)")` returns "(Hello!)".
--- @param string string
--- @return string
function CoreString.Trim(string, ...) end

--- @class Environment
local EnvironmentInstance = {}
--- @class GlobalEnvironment
Environment = {}
--- Returns `true` if the script is running in a client environment. This includes scripts that are in a Client Context, as well as scripts in a Static Context on a multiplayer preview client or a client playing a hosted game. Note that single-player preview and the "Play Locally" option only execute Static Context scripts once, and that is in a server environment.
--- @return boolean
function Environment.IsClient() end

--- Returns `true` if the script is running in a server environment. Note that this can include scripts running in the editor in preview mode (where the editor acts as server for the game) or for the "Play Locally" option in the Main Menu. This will always return `false` for scripts in a Client Context.
--- @return boolean
function Environment.IsServer() end

--- Returns `true` if running in multiplayer preview mode.
--- @return boolean
function Environment.IsMultiplayerPreview() end

--- Returns `true` if running in single-player preview mode.
--- @return boolean
function Environment.IsSinglePlayerPreview() end

--- Returns `true` if running in preview mode.
--- @return boolean
function Environment.IsPreview() end

--- Returns `true` if running in a local game on the player's computer. This includes preview mode, as well as the "Play Locally" option in the Main Menu.
--- @return boolean
function Environment.IsLocalGame() end

--- Returns `true` if running in a published online game, for both clients and servers.
--- @return boolean
function Environment.IsHostedGame() end

--- Returns the type of platform on which Core is currently running.
--- @return PlatformType
function Environment.GetPlatform() end

--- Returns the Detail Level selected by the player in the Settings menu. Useful for determining whether to spawn templates for VFX or other client-only objects, or selecting templates that are optimized for a particular detail level based on the player's settings.
--- @return DetailLevel
function Environment.GetDetailLevel() end

--- @class Events
local EventsInstance = {}
--- @class GlobalEvents
Events = {}
--- Registers the given function to the event name which will be called every time the event is fired using Broadcast. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. Accepts any number of additional arguments after the listener function, those arguments will be provided after the event's own parameters.
--- @param eventName string
--- @param listener function
--- @return EventListener
function Events.Connect(eventName, listener, ...) end

--- Registers the given function to the event name which will be called every time the event is fired using BroadcastToServer. The first parameter the function receives will be the Player that fired the event. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. Accepts any number of additional arguments after the listener function, those arguments will be provided after the event's own parameters.
--- @param eventName string
--- @param listener function
--- @return EventListener
function Events.ConnectForPlayer(eventName, listener, ...) end

--- Broadcasts the given event and fires all listeners attached to the given event name if any exists. Parameters after event name specifies the arguments passed to the listener. Any number of arguments can be passed to the listener function. The events are not networked and can fire events defined in the same context.
--- @param eventName string
function Events.Broadcast(eventName, ...) end

--- Broadcasts the given event to the server over the network and fires all listeners attached to the given event name if any exists on the server. The parameters after event name specify the arguments passed to the listener on the server. The function returns a result code and a message. This is a networked event.
--- @param eventName string
--- @return BroadcastEventResultCode|string
function Events.BroadcastToServer(eventName, ...) end

--- Broadcasts the given event to all clients over the network and fires all listeners attached to the given event name if any exists. Parameters after event name specify the arguments passed to the listener on the client. The function returns a result code and a message. This is a networked event.
--- @param eventName string
--- @return BroadcastEventResultCode|string
function Events.BroadcastToAllPlayers(eventName, ...) end

--- Broadcasts the given event to a specific client over the network and fires all listeners attached to the given event name if any exists on that client. The first parameter specifies the Player to which the event will be sent. The parameters after event name specify the arguments passed to the listener on the client. The function returns a result code and a message. This is a networked event.
--- @param player Player
--- @param eventName string
--- @return BroadcastEventResultCode|string
function Events.BroadcastToPlayer(player, eventName, ...) end

--- @class Game
local GameInstance = {}
--- @class GlobalGame
--- @field playerJoinedEvent Event @Fired when a player has joined the game and their character is ready. When used in client context it will fire off for each player already connected to the server.
--- @field playerLeftEvent Event @Fired when a player has disconnected from the game or their character has been destroyed. This event fires before the player has been removed, so functions such as `Game.GetPlayers()` will still include the player that is about to leave unless using the `ignorePlayers` filter within the parameters.
--- @field abilitySpawnedEvent Event @abilitySpawnedEvent is deprecated.
--- @field roundStartEvent Event @Fired when StartRound is called on game.
--- @field roundEndEvent Event @Fired when EndRound is called on game.
--- @field teamScoreChangedEvent Event @Fired whenever any team's score changes. This is fired once per team who's score changes.
Game = {}
--- Returns the local player.
--- @return Player
function Game.GetLocalPlayer() end

--- Returns the Player with the given player ID, if they're currently in the game. Otherwise returns `nil`.
--- @param playerId string
--- @return Player
function Game.FindPlayer(playerId) end

--- Returns a table containing the players currently in the game. An optional table may be provided containing parameters to filter the list of players returned: ignoreDead(boolean), ignoreLiving(boolean), ignoreSpawned(boolean), ignoreDespawned(boolean), ignoreTeams(integer or table of integer), includeTeams(integer or table of integer), ignorePlayers(Player or table of Player), for example: `Game.GetPlayers({ignoreDead = true, ignorePlayers = Game.GetLocalPlayer()})`.
--- @overload fun(): table<number, Player>
--- @param optionalParams table
--- @return table<number, Player>
function Game.GetPlayers(optionalParams) end

--- Returns a table with all Players that are in the given area. Position's `z` is ignored with the cylindrical area always upright. An optional table may be provided containing parameters to filter the list of players considered. This supports the same list of parameters as GetPlayers().
--- @overload fun(worldPosition: Vector3,radius: number): table<number, Player>
--- @param worldPosition Vector3
--- @param radius number
--- @param optionalParams table
--- @return table<number, Player>
function Game.FindPlayersInCylinder(worldPosition, radius, optionalParams) end

--- Returns a table with all Players that are in the given spherical area. An optional table may be provided containing parameters to filter the list of players considered. This supports the same list of parameters as GetPlayers().
--- @overload fun(worldPosition: Vector3,radius: number): table<number, Player>
--- @param worldPosition Vector3
--- @param radius number
--- @param optionalParams table
--- @return table<number, Player>
function Game.FindPlayersInSphere(worldPosition, radius, optionalParams) end

--- Returns the Player that is nearest to the given position. An optional table may be provided containing parameters to filter the list of players considered. This supports the same list of parameters as GetPlayers().
--- @overload fun(worldPosition: Vector3): Player
--- @param worldPosition Vector3
--- @param optionalParameters table
--- @return Player
function Game.FindNearestPlayer(worldPosition, optionalParameters) end

--- Fire all events attached to roundStartEvent.
function Game.StartRound() end

--- Fire all events attached to roundEndEvent.
function Game.EndRound() end

--- Returns the current score for the specified team. Only teams 0 - 4 are valid.
--- @param team number
--- @return number
function Game.GetTeamScore(team) end

--- Sets one team's score.
--- @param team number
--- @param score number
function Game.SetTeamScore(team, score) end

--- Increases one team's score.
--- @param team number
--- @param scoreChange number
function Game.IncreaseTeamScore(team, scoreChange) end

--- Decreases one team's score.
--- @param team number
--- @param scoreChange number
function Game.DecreaseTeamScore(team, scoreChange) end

--- Sets all teams' scores to 0.
function Game.ResetTeamScores() end

--- Locks the current server instance to stop accepting new players. Note that players already in the process of joining the server will still be accepted, and `Game.playerJoinedEvent` may still fire for a short period of time after a call to this function returns. Other new players will be directed to a different instance of the game.
function Game.StopAcceptingPlayers() end

--- Returns `true` if the current server instance is still accepting new players. Returns `false` if the server has stopped accepting new players due to a call to `Game.StopAcceptingPlayers()`.
--- @return boolean
function Game.IsAcceptingPlayers() end

--- Similar to `Player:TransferToGame()`, transfers all players to the game specified by the passed in game ID. Does not work in preview mode or in games played locally.
--- @overload fun(gameInfo: CoreGameInfo)
--- @overload fun(gameId: string)
--- @param gameCollectionEntry CoreGameCollectionEntry
function Game.TransferAllPlayersToGame(gameCollectionEntry) end

--- Similar to `Player:TransferToGame()`, transfers the specified list of players to the game specified by the passed in game ID. Note that if a party leader is included in the list of players to transfer, the "Play as Party" party setting is ignored, and other party members will only be transferred if also included in the list of players. Does not work in preview mode or in games played locally.
--- @overload fun(gameInfo: CoreGameInfo,players: table<number, Player>)
--- @overload fun(gameId: string,players: table<number, Player>)
--- @param gameCollectionEntry CoreGameCollectionEntry
--- @param players table<number, Player>
function Game.TransferPlayersToGame(gameCollectionEntry, players) end

--- Similar to `Player:TransferToScene()`, transfers all players to the scene specified by the passed in scene name. Does not work in preview mode or in games played locally.
--- 
--- The following optional parameters are supported:
--- 
--- `spawnKey (string)`: Spawns the players at a spawn point with a matching key. If an invalid key is provided, the players will spawn at the origin, (0, 0, 0).
--- @overload fun(sceneName: string)
--- @param sceneName string
--- @param optionalParams table
function Game.TransferAllPlayersToScene(sceneName, optionalParams) end

--- Similar to `Player:TransferToScene()`, transfers the specified list of players to the scene specified by the passed in scene name. Note that if a party leader is included in the list of players to transfer, the "Play as Party" party setting is ignored, and other party members will only be transferred if also included in the list of players. Does not work in preview mode or in games played locally.
--- 
--- The following optional parameters are supported:
--- 
--- `spawnKey (string)`: Spawns the players at a spawn point with a matching key. If an invalid key is provided, the players will spawn at the origin, (0, 0, 0).
--- @overload fun(sceneName: string,players: table<number, Player>)
--- @param sceneName string
--- @param players table<number, Player>
--- @param optionalParams table
function Game.TransferPlayersToScene(sceneName, players, optionalParams) end

--- Returns the name of the current scene.
--- @return string
function Game.GetCurrentSceneName() end

--- Returns the ID of the current game. When called in preview mode, returns `nil` if the game has not been published, otherwise returns the published game ID.
--- @return string
function Game.GetCurrentGameId() end

--- @class Input
local InputInstance = {}
--- @class GlobalInput
--- @field actionPressedEvent Event @Fired when a player starts an input action by pressing a key, button, or other input control. The third parameter, `value`, will be a `Vector2` for direction bindings, or a `number` for axis and basic bindings.
--- @field actionReleasedEvent Event @Fired when a player stops an input action by releasing a key, button, or other input control.
--- @field inputTypeChangedEvent Event @Fired when the active input device has changed to a new type of input.
--- @field pinchStartedEvent Event @Fired when the player begins a pinching gesture on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched.
--- @field pinchStoppedEvent Event @Fired when the player ends a pinching gesture on a touch input device.
--- @field rotateStartedEvent Event @Fired when the player begins a rotating gesture on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated.
--- @field rotateStoppedEvent Event @Fired when the player ends a rotating gesture on a touch input device.
--- @field flickedEvent Event @Fired when the player performs a quick flicking gesture on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc.
--- @field touchStartedEvent Event @Fired when the player starts touching the screen on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device.
--- @field touchStoppedEvent Event @Fired when the player stops touching the screen on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device.
--- @field tappedEvent Event @Fired when the player taps on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed.
--- @field pointerMovedEvent Event @Fired when the pointer (either the mouse or a touch input) has moved. Parameters include the change in position since the last time `pointerMovedEvent` was fired for the given pointer, and an optional touch index indicating which touch input moved. `touchIndex` will be `nil` when the mouse has moved.
--- @field mouseButtonPressedEvent Event @Fired when the user has pressed a mouse button. Parameters indicate the screen position of the cursor when the button was pressed, and an enum value indicating which mouse button was pressed.
--- @field mouseButtonReleasedEvent Event @Fired when the user has released a mouse button. Parameters indicate the screen position of the cursor when the button was released, and an enum value indicating which mouse button was released.
--- @field escapeHook Hook @Hook called when the local player presses the Escape key. The `parameters` table contains a `boolean` named "openPauseMenu", which may be set to `false` to prevent the pause menu from being opened. Players may press `Shift-Esc` to force the pause menu to open without calling this hook.
--- @field actionHook Hook @Hook called each frame with a list of changes in action values since the previous frame. The `actionList` table is an array of tables with the structure {action = "actionName", value = `number` or `Vector2`} for each action whose value has changed since the last frame. If no values have changed, `actionList` will be empty, even if there are actions currently being held. Entries in the table can be added, removed, or changed and will affect whether pressed and released events fire. If a non-zero value is changed to zero then `Input.actionReleasedEvent` will fire for that action. If a zero value changes to non-zero then `Input.actionPressedEvent` will fire.
Input = {}
--- Returns the current input value associated with the specified action. This will return a `Vector2` for direction bindings, a `number` for basic and axis bindings, or `nil` for invalid bindings. `nil` may also be returned when called on the server with a non-networked action name or a networked action which simply hasn't been pressed yet.
--- @param player Player
--- @param action string
--- @return any
function Input.GetActionValue(player, action) end

--- Returns `true` if the specified action is currently being held by the player, otherwise returns `false`.
--- @param player Player
--- @param action string
--- @return boolean
function Input.IsActionHeld(player, action) end

--- Returns the current active input type.
--- @return InputType
function Input.GetCurrentInputType() end

--- Returns `true` if the player has inverted the Y axis in their settings for the given input type, otherwise returns `false`.
--- @param inputType InputType
--- @return boolean
function Input.IsYAxisInverted(inputType) end

--- Returns the description set in the Bindings Manager for the specified action. Returns `nil` if given an invalid action name.
--- @param action string
--- @return string
function Input.GetActionDescription(action) end

--- Returns a string label indicating the key or button assigned to the specified action. Returns `nil` if `actionName` is not a valid action or if an invalid `direction` parameter is specified for axis and direction bindings. Returns "None" for valid actions with no control bound.
--- 
--- Supported parameters include:
--- 
--- `direction (string)`: *Required* for axis and direction bindings, specifying "positive" or "negative" for axis bindings, or "up", "down", "left", or "right" for direction bindings.
--- 
--- `inputType (InputType)`: Specifies whether to return a label for keyboard and mouse or controller. Defaults to the current active input type.
--- 
--- `secondary (boolean)`: When `true` and returning a label for keyboard and mouse, returns a label for the secondary input.
--- @overload fun(action: string): string
--- @param action string
--- @param optionalParams table
--- @return string
function Input.GetActionInputLabel(action, optionalParams) end

--- Returns a Vector2 with the `x`, `y` coordinates of the mouse cursor on the screen. May return `nil` if the cursor position cannot be determined.
--- @return Vector2
function Input.GetCursorPosition() end

--- Returns a Vector2 with the `x`, `y` coordinates of a touch input on the screen. An optional touch index may be provided to specify which touch to return on multitouch devices. If not specified, index 1 is used. Returns `nil` if the requested touch index is not currently active.
--- @overload fun(fingerIndex: number): Vector2
--- @return Vector2
function Input.GetTouchPosition() end

--- When the current input type is `InputType.TOUCH`, returns a Vector2 with the `x`, `y` coordinates of a touch input on the screen. When the current input type is not `InputType.TOUCH`, returns the cursor position. An optional touch index may be provided to specify which touch to return on multitouch devices. If not specified, index 1 is used. Returns `nil` if the requested touch index is not currently active. The touch index is ignored for other input types.
--- @overload fun(fingerIndex: number): Vector2
--- @return Vector2
function Input.GetPointerPosition() end

--- During a pinch gesture with touch input, returns a value indicating the relative progress of the pinch gesture. Pinch gestures start with a pinch value of 1 and approach 0 when pinching together, or increase past 1 when touches move apart from each other. Returns 0 if no pinch is in progress.
--- @return number
function Input.GetPinchValue() end

--- During a rotate gesture with touch input, returns a value indicating the angle of rotation from the start of the gesture. Returns 0 if no rotate is in progress.
--- @return number
function Input.GetRotateValue() end

--- Enables display of virtual controls on devices with touch input, or in preview mode if device emulation is enabled. Virtual controls default to enabled when using touch input.
function Input.EnableVirtualControls() end

--- Disables display of virtual controls on devices with touch input, or in preview mode with device emulation enabled.
function Input.DisableVirtualControls() end

--- Returns `true` when the current device supports the given input type. For example, `Input.IsInputEnabled(InputType.CONTROLLER)` will return `true` if a gamepad is connected.
--- @param inputType InputType
--- @return boolean
function Input.IsInputTypeEnabled(inputType) end

--- Returns a list of the names of each action from currently active binding sets. Actions are included in this list regardless of whether the action is currently held or not.
--- @return table<number, string>
function Input.GetActions() end

--- Enables the specified action, if the action exists.
--- @param action string
function Input.EnableAction(action) end

--- Disables the specified action, if the action exists. If the action is currently held, this will also release the action.
--- @param action string
function Input.DisableAction(action) end

--- Returns `true` if the specified action is enabled. Returns `false` if the action is disabled or does not exist.
--- @param action string
--- @return boolean
function Input.IsActionEnabled(action) end

--- @class Leaderboards
local LeaderboardsInstance = {}
--- @class GlobalLeaderboards
Leaderboards = {}
--- Submits a new score for the given Player on the specified leaderboard. The `NetReference` parameter should be retrieved from a custom property, assigned from the Global Leaderboards tab in the editor. This score may be ignored if the player already has a better score on this leaderboard. The optional `additionalData` parameter may be used to store a very small amount of data with the player's entry. If provided, this string must be 8 characters or fewer. (More specifically, 8 bytes when encoded as UTF-8.)
--- @param leaderboardReference NetReference
--- @param player Player
--- @param score number
--- @param additionalData string
function Leaderboards.SubmitPlayerScore(leaderboardReference, player, score, additionalData) end

--- Returns a table containing a list of entries for the specified leaderboard. The `NetReference` parameter should be retrieved from a custom property, assigned from the Global Leaderboards tab in the editor. This returns a copy of the data that has already been retrieved, so calling this function does not incur any additional network cost. If the requested leaderboard type has not been enabled for this leaderboard, an empty table will be returned. Supported leaderboard types include:
--- 
--- `LeaderboardType.GLOBAL`
--- 
--- `LeaderboardType.DAILY`
--- 
--- `LeaderboardType.WEEKLY`
--- 
--- `LeaderboardType.MONTHLY`
--- @param leaderboardReference NetReference
--- @param leaderboardType LeaderboardType
--- @return table
function Leaderboards.GetLeaderboard(leaderboardReference, leaderboardType) end

--- Returns `true` if any leaderboard data is available. Returns `false` if leaderboards are still being retrieved, or if there is no leaderboard data.
--- @return boolean
function Leaderboards.HasLeaderboards() end

--- @class Storage
local StorageInstance = {}
--- @class GlobalStorage
Storage = {}
--- Computes and returns the size required for the given `data` table when stored as Player data.
--- @param data table
--- @return number
function Storage.SizeOfData(data) end

--- Computes and returns the compressed size required for the given `data` table when stored as Player data.
--- @param data table
--- @return number
function Storage.SizeOfCompressedData(data) end

--- Returns the player data associated with `player`. This returns a copy of the data that has already been retrieved for the player, so calling this function does not incur any additional network cost. Changes to the data in the returned table will not be persisted without calling `Storage.SetPlayerData()`.
--- @param player Player
--- @return table
function Storage.GetPlayerData(player) end

--- Updates the data associated with `player`. Returns a result code and an error message. See below for supported data types.
--- @param player Player
--- @param data table
--- @return StorageResultCode|string
function Storage.SetPlayerData(player, data) end

--- Requests the concurrent player data associated with the specified player. This function may yield until data is available. Returns the data (`nil` if not available), a result code, and an optional error message if an error occurred.
--- @param playerId string
--- @return table|StorageResultCode|string
function Storage.GetConcurrentPlayerData(playerId) end

--- Updates the concurrent player data associated with the specified player. This function retrieves the most recent copy of the player's data, then calls the creator-provided `callback` function with the data table as a parameter. `callback` is expected to return the player's updated data table, which will then be saved. This function yields until the entire process is complete, returning a copy of the player's updated data (`nil` if not available), a result code, and an optional error message if an error occurred.
--- @param playerId string
--- @param callback function
--- @return table|StorageResultCode|string
function Storage.SetConcurrentPlayerData(playerId, callback) end

--- Requests the concurrent player data associated with the specified player and storage key. The storage key must be of type `CONCURRENT_SHARED_PLAYER_STORAGE`. This function may yield until data is available. Returns the data (`nil` if not available), a result code, and an optional error message if an error occurred.
--- @param netReference NetReference
--- @param playerId string
--- @return table|StorageResultCode|string
function Storage.GetConcurrentSharedPlayerData(netReference, playerId) end

--- Updates the concurrent player data associated with the specified player and storage key. The storage key must be of type `CONCURRENT_SHARED_PLAYER_STORAGE`. This function retrieves the most recent copy of the player's data, then calls the creator-provided `callback` function with the data table as a parameter. `callback` is expected to return the player's updated data table, which will then be saved. This function yields until the entire process is complete, returning a copy of the player's updated data (`nil` if not available), a result code, and an optional error message if an error occurred.
--- @param netReference NetReference
--- @param playerId string
--- @param callback function
--- @return table|StorageResultCode|string
function Storage.SetConcurrentSharedPlayerData(netReference, playerId, callback) end

--- Requests the concurrent data associated with the given storage key. The storage key must be of type `CONCURRENT_CREATOR_STORAGE`. This data is player- and game-agnostic. This function may yield until data is available. Returns the data (`nil` if not available), a result code, and an optional error message if an error occurred.
--- @param netReference NetReference
--- @return table|StorageResultCode|string
function Storage.GetConcurrentCreatorData(netReference) end

--- Updates the concurrent data associated with the given storage key. The storage key must be of type `CONCURRENT_CREATOR_STORAGE`. This data is player- and game-agnostic. This function retrieves the most recent copy of the creator data, then calls the creator-provided `callback` function with the data table as a parameter. `callback` is expected to return the updated data table, which will then be saved. This function yields until the entire process is complete, returning a copy of the updated data (`nil` if not available), a result code, and an optional error message if an error occurred.
--- @param netReference NetReference
--- @param callback function
--- @return table|StorageResultCode|string
function Storage.SetConcurrentCreatorData(netReference, callback) end

--- Listens for any changes to the concurrent data associated with `playerId` for this game. Calls to `Storage.SetConcurrentPlayerData()` from this or other game servers will trigger this listener. The listener function parameters should be: `string` player ID, `table` player data. Accepts any number of additional arguments after the listener function, those arguments will be provided, in order, after the `table` argument. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected.
--- @param playerId string
--- @param callback function
--- @return EventListener
function Storage.ConnectToConcurrentPlayerDataChanged(playerId, callback, ...) end

--- Listens for any changes to the concurrent shared data associated with `playerId` and `concurrentSharedStorageKey`. Calls to `Storage.SetConcurrentSharedPlayerData()` from this or other game servers will trigger this listener. The listener function parameters should be: `NetReference` storage key, `string` player ID, `table` shared player data. Accepts any number of additional arguments after the listener function, those arguments will be provided, in order, after the `table` argument. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected.
--- @param netReference NetReference
--- @param playerId string
--- @param callback function
--- @return EventListener
function Storage.ConnectToConcurrentSharedPlayerDataChanged(netReference, playerId, callback, ...) end

--- Listens for any changes to the concurrent data associated with `concurrentCreatorStorageKey`. Calls to `Storage.SetConcurrentCreatorData()` from this or other game servers will trigger this listener. The listener function parameters should be: `NetReference` storage key, `table` creator data. Accepts any number of additional arguments after the listener function, those arguments will be provided, in order, after the `table` argument. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected.
--- @param netReference NetReference
--- @param callback function
--- @return EventListener
function Storage.ConnectToConcurrentCreatorDataChanged(netReference, callback, ...) end

--- Returns `true` if this server has a pending call to `Storage.SetConcurrentPlayerData()` either waiting to be processed or actively running for the specified player ID.
--- @param playerId string
--- @return boolean
function Storage.HasPendingSetConcurrentPlayerData(playerId) end

--- Returns `true` if this server has a pending call to `Storage.SetConcurrentSharedPlayerData()` either waiting to be processed or actively running for the specified player ID and shared storage key.
--- @param netReference NetReference
--- @param playerId string
--- @return boolean
function Storage.HasPendingSetConcurrentSharedPlayerData(netReference, playerId) end

--- Returns `true` if this server has a pending call to `Storage.SetConcurrentCreatorData()` either waiting to be processed or actively running for the specified creator storage key.
--- @param netReference NetReference
--- @return boolean
function Storage.HasPendingSetConcurrentCreatorData(netReference) end

--- Returns the shared player data associated with `player` and `sharedStorageKey`. This returns a copy of the data that has already been retrieved for the player, so calling this function does not incur any additional network cost. Changes to the data in the returned table will not be persisted without calling `Storage.SetSharedPlayerData()`.
--- @param sharedStorageKey NetReference
--- @param player Player
--- @return table
function Storage.GetSharedPlayerData(sharedStorageKey, player) end

--- Updates the shared data associated with `player` and `sharedStorageKey`. Returns a result code and an error message. See below for supported data types.
--- @param sharedStorageKey NetReference
--- @param player Player
--- @param data table
--- @return StorageResultCode|string
function Storage.SetSharedPlayerData(sharedStorageKey, player, data) end

--- Requests the player data associated with the specified player who is not in the current instance of the game. This function may yield until data is available, and may raise an error if the player ID is invalid or if an error occurs retrieving the information. If the player is in the current instance of the game, `Storage.GetPlayerData()` should be used instead.
--- @param playerId string
--- @return table
function Storage.GetOfflinePlayerData(playerId) end

--- Requests the shared player data associated with `sharedStorageKey` and the specified player who is not in the current instance of the game. This function may yield until data is available, and may raise an error if the player ID is invalid or if an error occurs retrieving the information. If the player is in the current instance of the game, `Storage.GetSharedPlayerData()` should be used instead.
--- @param sharedStorageKey NetReference
--- @param playerId string
--- @return table
function Storage.GetSharedOfflinePlayerData(sharedStorageKey, playerId) end

--- @class Teams
local TeamsInstance = {}
--- @class GlobalTeams
Teams = {}
--- Returns true if teams are considered friendly under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns true.
--- @param team1 number
--- @param team2 number
--- @return boolean
function Teams.AreTeamsFriendly(team1, team2) end

--- Returns true if teams are considered enemies under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns false.
--- @param team1 number
--- @param team2 number
--- @return boolean
function Teams.AreTeamsEnemies(team1, team2) end

--- @class UI
local UIInstance = {}
--- @class GlobalUI
--- @field coreModalChangedEvent Event @Fired when the local player pauses the game or opens one of the built-in modal dialogs, such as the emote or mount picker. The modal parameter will be `nil` when the player has closed all built-in modals.
UI = {}
--- Returns the currently active core modal, or nil if none is active.
--- @return CoreModalType
function UI.GetCoreModalType() end

--- Shows a quick text on screen that tracks its position relative to a world position. The last parameter is an optional table containing additional parameters: duration (number) - How long the text should remain on the screen. Default duration is 0.5 seconds; color (Color) - The color of the Text. Default is white; font (string) - Asset ID for the font to use; isBig (boolean) - When true, larger text is used.
--- @overload fun(text: string,worldPosition: Vector3)
--- @param text string
--- @param worldPosition Vector3
--- @param optionalParameters table
function UI.ShowFlyUpText(text, worldPosition, optionalParameters) end

--- Local player sees an arrow pointing towards some damage source. Lasts for 5 seconds.
--- @overload fun(sourcePlayer: Player)
--- @overload fun(sourceWorldPosition: Vector3)
--- @param sourceObject CoreObject
function UI.ShowDamageDirection(sourceObject) end

--- Calculates the location that worldPosition appears on the screen. Returns a Vector2 with the `x`, `y` coordinates, or `nil` if worldPosition is behind the camera.
--- @param worldPosition Vector3
--- @return Vector2
function UI.GetScreenPosition(worldPosition) end

--- Returns a Vector2 with the size of the Player's screen in the `x`, `y` coordinates. May return `nil` if the screen size cannot be determined.
--- @return Vector2
function UI.GetScreenSize() end

--- Returns a rectangle in screen space indicating an area on screen that is not obscured by elements such as the notch on a mobile phone.
--- @return Rectangle
function UI.GetSafeArea() end

--- Draws a message on the corner of the screen. Second optional Color parameter can change the color from the default white.
--- @overload fun(message: string)
--- @param message string
--- @param color Color
function UI.PrintToScreen(message, color) end

--- *This function is deprecated. Please use Input.GetCursorPosition() instead.* Returns a Vector2 with the `x`, `y` coordinates of the mouse cursor on the screen. May return `nil` if the cursor position cannot be determined.
--- @return Vector2
function UI.GetCursorPosition() end

--- *This function is deprecated. Please use UI.GetHitResult() instead.* Return hit result from local client's view in direction of the Projected cursor position. Meant for client-side use only, for Ability cast, please use `ability:GetTargetData():GetHitPosition()`, which would contain cursor hit position at time of cast, when in top-down camera mode.
--- @return HitResult
function UI.GetCursorHitResult() end

--- Return hit result from local client's view from the given screen position cast in the camera direction.
--- @param screenPos Vector2
--- @return HitResult
function UI.GetHitResult(screenPos) end

--- *This function is deprecated. Please use UI.GetPlaneIntersection() instead.* Return intersection from local client's camera direction to given plane, specified by point on plane and optionally its normal. Meant for client-side use only. Example usage: `local hitPos = UI.GetCursorPlaneIntersection(Vector3.New(0, 0, 0))`.
--- @overload fun(pointOnPlane: Vector3): Vector3
--- @param pointOnPlane Vector3
--- @param planeNormal Vector3
--- @return Vector3
function UI.GetCursorPlaneIntersection(pointOnPlane, planeNormal) end

--- Return intersection from local client's view from the given screen position case in the camera direction to the given plane, specified by point on plane and optionally its normal. Example usage: `local hitPos = UI.GetPlaneIntersection(UI.GetScreenSize()/2, Vector3.ZERO)`.
--- @overload fun(screenPos: Vector2,pointOnPlane: Vector3): Vector3
--- @param screenPos Vector2
--- @param pointOnPlane Vector3
--- @param planeNormal Vector3
--- @return Vector3
function UI.GetPlaneIntersection(screenPos, pointOnPlane, planeNormal) end

--- Returns whether the cursor is visible.
--- @return boolean
function UI.IsCursorVisible() end

--- Sets whether the cursor is visible.
--- @param isVisible boolean
function UI.SetCursorVisible(isVisible) end

--- Returns whether to lock cursor in viewport.
--- @return boolean
function UI.IsCursorLockedToViewport() end

--- Sets whether to lock cursor in viewport.
--- @param isLocked boolean
function UI.SetCursorLockedToViewport(isLocked) end

--- Returns whether the cursor can interact with UI elements like buttons.
--- @return boolean
function UI.CanCursorInteractWithUI() end

--- Sets whether the cursor can interact with UI elements like buttons.
--- @param canInteract boolean
function UI.SetCanCursorInteractWithUI(canInteract) end

--- Check if reticle is visible.
--- @return boolean
function UI.IsReticleVisible() end

--- Shows or hides the reticle for the Player.
--- @param isVisible boolean
function UI.SetReticleVisible(isVisible) end

--- Sets whether the rewards dialog is visible, and optionally which tab is active.
--- @overload fun(isVisible: boolean)
--- @param isVisible boolean
--- @param currentTab RewardsDialogTab
function UI.SetRewardsDialogVisible(isVisible, currentTab) end

--- Returns whether the rewards dialog is currently visible.
--- @return boolean
function UI.IsRewardsDialogVisible() end

--- Sets whether the social menu is enabled.
--- @param isEnabled boolean
function UI.SetSocialMenuEnabled(isEnabled) end

--- Returns whether the social menu is enabled.
--- @return boolean
function UI.IsSocialMenuEnabled() end

--- Returns whether the voice chat widget is currently visible. Note that this may return `true` when the voice chat widget is not currently displaying anything on the screen.
--- @return boolean
function UI.IsVoiceChatWidgetVisible() end

--- Sets whether the voice chat widget is currently visible.
--- @param isVisible boolean
function UI.SetVoiceChatWidgetVisible(isVisible) end

--- Looks for a hittable UI control at the given screen position. Returns the top-most control if found. Returns `nil` if no hittable control was found at the specified position.
--- @param position Vector2
--- @return UIControl
function UI.FindControlAtPosition(position) end

--- @class VoiceChat
local VoiceChatInstance = {}
--- @class GlobalVoiceChat
VoiceChat = {}
--- Returns the current voice chat mode.
--- @return VoiceChatMode
function VoiceChat.GetVoiceChatMode() end

--- Enables or disables voice chat in the current game.
--- @param voiceChatMode VoiceChatMode
function VoiceChat.SetVoiceChatMode(voiceChatMode) end

--- Returns the channel with the given name, or `nil` if no such channel exists.
--- @param channelName string
--- @return VoiceChatChannel
function VoiceChat.GetChannel(channelName) end

--- Returns a list of voice chat channels.
--- @return table<number, VoiceChatChannel>
function VoiceChat.GetChannels() end

--- Returns a list of voice chat channels that the given player is in.
--- @param player Player
--- @return table<number, VoiceChatChannel>
function VoiceChat.GetChannelsForPlayer(player) end

--- Returns `true` if the given player is in the specified channel, otherwise returns `false`.
--- @param player Player
--- @param channelName string
--- @return boolean
function VoiceChat.IsPlayerInChannel(player, channelName) end

--- Mutes the given player in the specified channel.
--- @param player Player
--- @param channelName string
function VoiceChat.MutePlayerInChannel(player, channelName) end

--- Unmutes the given player in the specified channel.
--- @param player Player
--- @param channelName string
function VoiceChat.UnmutePlayerInChannel(player, channelName) end

--- Returns `true` if the given player is muted in the specified channel, otherwise returns `false`.
--- @param player Player
--- @param channelName string
--- @return boolean
function VoiceChat.IsPlayerMutedInChannel(player, channelName) end

--- Returns true if the given player is currently speaking in the game channel.
--- @param player Player
--- @return boolean
function VoiceChat.IsPlayerSpeaking(player) end

--- Returns a value from 0.0 to 1.0 to indicate how loudly the given player is speaking.
--- @param player Player
--- @return number
function VoiceChat.GetPlayerSpeakingVolume(player) end

--- Returns `true` if Core has detected a microphone for the given player, otherwise returns `false`.
--- @param player Player
--- @return boolean
function VoiceChat.HasMicrophone(player) end

--- Returns `true` if the given player has enabled voice chat in their settings.
--- @param player Player
--- @return boolean
function VoiceChat.IsVoiceChatEnabled(player) end

--- Returns the method the local player has selected in their settings to activate voice chat.
--- @return VoiceChatMethod
function VoiceChat.GetVoiceChatMethod() end

--- @class World
local WorldInstance = {}
--- @class GlobalWorld
World = {}
--- Returns the root of the CoreObject hierarchy.
--- @return CoreObject
function World.GetRootObject() end

--- Returns the object with a given MUID. Returns nil if no object has this ID.
--- @param id string
--- @return CoreObject
function World.FindObjectById(id) end

--- Returns the first object found with a matching name. In none match, nil is returned.
--- @param name string
--- @return CoreObject
function World.FindObjectByName(name) end

--- Returns a table containing all the objects in the hierarchy with a matching name. If none match, an empty table is returned.
--- @param name string
--- @return table<number, CoreObject>
function World.FindObjectsByName(name) end

--- Returns a table containing all the objects in the hierarchy whose type is or extends the specified type. If none match, an empty table is returned.
--- @param typeName string
--- @return table<number, CoreObject>
function World.FindObjectsByType(typeName) end

--- Spawns an instance of an asset into the world. Optional parameters can specify a parent, transform, or other properties of the spawned object. Note that when spawning a template, most optional parameters apply only to the root object of the spawned template.
--- 
--- Supported parameters include:
--- 
--- `parent (CoreObject)`: If provided, the spawned asset will be a child of this parent, and any Transform parameters are relative to the parent's Transform.
--- 
--- `position (Vector3)`: Position of the spawned object.
--- 
--- `rotation (Rotation or Quaternion)`: Rotation of the spawned object.
--- 
--- `scale (Vector3 or number)`: Scale of the spawned object, may be specified as a `Vector3` or as a `number` for uniform scale.
--- 
--- `transform (Transform)`: The full transform of the spawned object. If `transform` is specified, it is an error to also specify `position`, `rotation`, or `scale`.
--- 
--- `networkContext` ([NetworkContextType](../api/enums#networkcontexttype)): Overrides the network context of the spawned object. This may be used, for example, to spawn networked or static objects from a server only context, or client-only objects from a client script running in a static context, but it cannot spawn client only objects from a server script or networked objects from a client script. If an invalid context is specified, an error will be raised.
--- 
--- `name (string)`: Set the name of the spawned object.
--- 
--- `team (integer)`: Set the team on the spawned object.
--- 
--- `lifeSpan (number)`: Set the life span of the spawned object.
--- 
--- `collision (Collision)`: Set the collision of the spawned object.
--- 
--- `visibility (Visibility)`: Set the visibility of the spawned object.
--- 
--- `cameraCollision (Collision)`: Set the camera collision of the spawned object.
--- 
--- `color (Color)`: Set the color of the spawned object.
--- @overload fun(assetId: string): CoreObject
--- @param assetId string
--- @param optionalParameters table
--- @return CoreObject
function World.SpawnAsset(assetId, optionalParameters) end

--- Traces a ray from `startPosition` to `endPosition`, returning a `HitResult` with data about the impact point and object. Returns `nil` if no intersection is found. Note that if a raycast starts inside an object, that object will not be returned by the raycast.
--- 
--- Optional parameters can be provided to control the results of the Raycast:
--- 
--- `ignoreTeams (integer or Array<integer>)`: Don't return any players belonging to the team or teams listed.
--- 
--- `ignorePlayers (Player, Array<Player>, or boolean)`: Ignore any of the players listed. If `true`, ignore all players.
--- 
--- `checkObjects (Object, Array<Object>)`: Only return results that are contained in this list.
--- 
--- `ignoreObjects (Object, Array<Object>)`: Ignore results that are contained in this list.
--- 
--- `useCameraCollision (boolean)`: If `true`, results are found based on objects' camera collision property rather than their game collision.
--- 
--- `shouldDebugRender (boolean)`: If `true`, enables visualization of the raycast in world space for debugging.
--- 
--- `debugRenderDuration (number)`: Number of seconds for which debug rendering should remain on screen. Defaults to 1 second.
--- 
--- `debugRenderThickness (number)`: The thickness of lines drawn for debug rendering. Defaults to 1.
--- 
--- `debugRenderColor (Color)`: Overrides the color of lines drawn for debug rendering. If not specified, multiple colors may be used to indicate where results were hit.
--- @overload fun(startPosition: Vector3,endPosition: Vector3): HitResult
--- @param startPosition Vector3
--- @param endPosition Vector3
--- @param optionalParameters table
--- @return HitResult
function World.Raycast(startPosition, endPosition, optionalParameters) end

--- Traces a ray from `startPosition` to `endPosition`, returning a list of `HitResult` instances with data about all objects found along the ray. Returns an empty table if no intersection is found. Note that if a raycast starts inside an object, that object will not be returned by the raycast. Optional parameters can be provided to control the results of the raycast using the same parameters supported by `World.Raycast()`.
--- @overload fun(startPosition: Vector3,endPosition: Vector3): table<number, HitResult>
--- @param startPosition Vector3
--- @param endPosition Vector3
--- @param optionalParameters table
--- @return table<number, HitResult>
function World.RaycastAll(startPosition, endPosition, optionalParameters) end

--- Traces a sphere with the specified radius from `startPosition` to `endPosition`, returning a `HitResult` with data about the first object hit along the way. Returns `nil` if no intersection is found. Note that a sphere cast starting entirely inside an object with complex collision may not return that object. Optional parameters can be provided to control the results of the sphere cast using the same parameters supported by `World.Raycast()`.
--- @overload fun(startPosition: Vector3,endPosition: Vector3,radius: number): HitResult
--- @param startPosition Vector3
--- @param endPosition Vector3
--- @param radius number
--- @param optionalParameters table
--- @return HitResult
function World.Spherecast(startPosition, endPosition, radius, optionalParameters) end

--- Traces a sphere with the specified radius from `startPosition` to `endPosition`, returning a list of `HitResult` instances with data about all objects found along the path of the sphere. Returns an empty table if no intersection is found. Note that a sphere cast starting entirely inside an object with complex collision may not return that object. Optional parameters can be provided to control the results of the sphere cast using the same parameters supported by `World.Raycast()`.
--- @overload fun(startPosition: Vector3,endPosition: Vector3,radius: number): table<number, HitResult>
--- @param startPosition Vector3
--- @param endPosition Vector3
--- @param radius number
--- @param optionalParameters table
--- @return table<number, HitResult>
function World.SpherecastAll(startPosition, endPosition, radius, optionalParameters) end

--- Traces a box with the specified size from `startPosition` to `endPosition`, returning a `HitResult` with data about the first object hit along the way. Returns `nil` if no intersection is found. Note that a box cast starting entirely inside an object with complex collision may not return that object. Optional parameters can be provided to control the results of the box cast using the same parameters supported by `World.Raycast()`, as well as the following additional parameters:
--- 
--- `shapeRotation (Rotation)`: Rotation of the box shape being cast. Defaults to (0, 0, 0).
--- 
--- `isWorldShapeRotation (boolean)`: If `true`, the `shapeRotation` parameter specifies a rotation in world space, or if no `shapeRotation` is provided, the box will be axis-aligned. Defaults to `false`, meaning the rotation of the box is relative to the direction in which it is being cast.
--- @overload fun(startPosition: Vector3,endPosition: Vector3,boxSize: Vector3): HitResult
--- @param startPosition Vector3
--- @param endPosition Vector3
--- @param boxSize Vector3
--- @param optionalParameters table
--- @return HitResult
function World.Boxcast(startPosition, endPosition, boxSize, optionalParameters) end

--- Traces a box with the specified size from `startPosition` to `endPosition`, returning a list of `HitResult` instances with data about all objects found along the path of the box. Returns an empty table if no intersection is found. Note that a box cast starting entirely inside an object with complex collision may not return that object. Optional parameters can be provided to control the results of the box cast using the same parameters supported by `World.Raycast()` and `World.Boxcast()`.
--- @overload fun(startPosition: Vector3,endPosition: Vector3,boxSize: Vector3): table<number, HitResult>
--- @param startPosition Vector3
--- @param endPosition Vector3
--- @param boxSize Vector3
--- @param optionalParameters table
--- @return table<number, HitResult>
function World.BoxcastAll(startPosition, endPosition, boxSize, optionalParameters) end

--- Returns all objects found overlapping or within a sphere with the specified position and radius. Optional parameters can be provided to control the results of the search:
--- 
--- `ignoreTeams (integer or Array<integer>)`: Don't return any players belonging to the team or teams listed.
--- 
--- `ignorePlayers (Player, Array<Player>, or boolean)`: Ignore any of the players listed. If `true`, ignore all players.
--- 
--- `checkObjects (Object, Array<Object>)`: Only return results that are contained in this list.
--- 
--- `ignoreObjects (Object, Array<Object>)`: Ignore results that are contained in this list.
--- 
--- `useCameraCollision (boolean)`: If `true`, results are found based on objects' camera collision property rather than their game collision.
--- @overload fun(position: Vector3,radius: number): table<number, Object>
--- @param position Vector3
--- @param radius number
--- @param optionalParameters table
--- @return table<number, Object>
function World.FindObjectsOverlappingSphere(position, radius, optionalParameters) end

--- Returns all objects found overlapping or within a box with the specified position and size. Optional parameters can be provided to control the results of the search using the same parameters as `World.FindObjectsOverlappingSphere()`, as well as the following:
--- 
--- `shapeRotation (Rotation)`: Rotation of the box shape being checked. Defaults to (0, 0, 0).
--- @overload fun(position: Vector3,boxSize: Vector3): table<number, Object>
--- @param position Vector3
--- @param boxSize Vector3
--- @param optionalParameters table
--- @return table<number, Object>
function World.FindObjectsOverlappingBox(position, boxSize, optionalParameters) end

--- Returns a `Box` describing the combined bounds of a list of objects. The `Box` span may exceed the exact extrema of the objects. Optional parameters can be provided to control the results:
--- 
--- `onlyCollidable (boolean)`: If true, the box will only describe the bounds of the mesh's collidable geometry. This can be affected by collision settings and network context. Defaults to false.
--- @param objects table
--- @param optionalParameters table
--- @return Box
function World.GetBoundingBoxFromObjects(objects, optionalParameters) end

--- @class AbilityFacingMode : integer @Used with `AbilityPhaseSettings` to control how and if a player rotates while executing an ability.
AbilityFacingMode = {
    NONE = 0,
    MOVEMENT = 1,
    AIM = 2,
}
--- @class AbilityPhase : integer @Describes a phase of ability execution.
AbilityPhase = {
    READY = 0,
    CAST = 1,
    EXECUTE = 2,
    RECOVERY = 3,
    COOLDOWN = 4,
}
--- @class BlockchainTokenResultCode : integer @Status code returned by functions in the `Blockchain` namespace when retrieving data.
BlockchainTokenResultCode = {
    SUCCESS = 0,
    FAILURE = 1,
}
--- @class BroadcastEventResultCode : integer @Status code returned by functions in the `Events` namespace when broadcasting networked events.
BroadcastEventResultCode = {
    SUCCESS = 0,
    FAILURE = 1,
    EXCEEDED_SIZE_LIMIT = 2,
    EXCEEDED_RATE_WARNING_LIMIT = 3,
    EXCEEDED_RATE_LIMIT = 4,
}
--- @class BroadcastMessageResultCode : integer @Status code returned by functions in the `Chat` namespace when sending chat messages.
BroadcastMessageResultCode = {
    SUCCESS = 0,
    FAILURE = 1,
    EXCEEDED_SIZE_LIMIT = 2,
    EXCEEDED_RATE_WARNING_LIMIT = 3,
    EXCEEDED_RATE_LIMIT = 4,
}
--- @class CameraCaptureResolution : integer @Indicates the resolution of a camera capture render target.
CameraCaptureResolution = {
    VERY_SMALL = 0,
    SMALL = 1,
    MEDIUM = 2,
    LARGE = 3,
    VERY_LARGE = 4,
}
--- @class Collision : integer @Controls collision of a `CoreObject`.
Collision = {
    INHERIT = 0,
    FORCE_ON = 1,
    FORCE_OFF = 2,
}
--- @class CoreGameEventState : integer @Indicates the status of a CoreGameEvent.
CoreGameEventState = {
    SCHEDULED = 0,
    ACTIVE = 1,
    CANCELED = 2,
}
--- @class CoreModalType : integer @Identifies the type of a Core built-in modal dialog.
CoreModalType = {
    PAUSE_MENU = 1,
    CHARACTER_PICKER = 2,
    MOUNT_PICKER = 3,
    EMOTE_PICKER = 4,
    SOCIAL_MENU = 6,
}
--- @class CurveExtrapolation : integer @Specifies how curve values are extrapolated outside the beginning and end of a curve.
CurveExtrapolation = {
    CYCLE = 0,
    CYCLE_WITH_OFFSET = 1,
    OSCILLATE = 2,
    LINEAR = 3,
    CONSTANT = 4,
}
--- @class CurveInterpolation : integer @Specifies how curve values are interpolated between curve keys.
CurveInterpolation = {
    LINEAR = 0,
    CONSTANT = 1,
    CUBIC = 2,
}
--- @class DamageReason : integer @Indicates the reason a player is taking damage.
DamageReason = {
    UNKNOWN = 0,
    COMBAT = 1,
    FRIENDLY_FIRE = 2,
    MAP = 3,
    NPC = 4,
}
--- @class DetailLevel : integer @Indicates the desired detail level selected by the player in the Settings menu.
DetailLevel = {
    LOW = 0,
    MEDIUM = 1,
    HIGH = 2,
    ULTRA = 3,
}
--- @class FacingMode : integer @Describes how the player character determines which direction it should face.
FacingMode = {
    FACE_AIM_WHEN_ACTIVE = 0,
    FACE_AIM_ALWAYS = 1,
    FACE_MOVEMENT = 2,
}
--- @class IKAnchorType : integer @Which bone this IKAnchor applies to.
IKAnchorType = {
    LEFT_HAND = 0,
    RIGHT_HAND = 1,
    PELVIS = 2,
    LEFT_FOOT = 3,
    RIGHT_FOOT = 4,
}
--- @class ImageTileType : integer @How a UI Texture is tiled or stretched.
ImageTileType = {
    NONE = 0,
    HORIZONTAL = 1,
    VERTICAL = 2,
    BOTH = 3,
}
--- @class InputType : integer @Specifies a type or method of user input.
InputType = {
    KEYBOARD_AND_MOUSE = 0,
    CONTROLLER = 1,
    TOUCH = 2,
}
--- @class LeaderboardType : integer @Identifies a specific leaderboard type associated with a leaderboard key.
LeaderboardType = {
    GLOBAL = 0,
    DAILY = 1,
    WEEKLY = 2,
    MONTHLY = 3,
}
--- @class LookControlMode : integer @Defines how player input controls the player's look direction.
LookControlMode = {
    NONE = 0,
    RELATIVE = 1,
    LOOK_AT_CURSOR = 2,
}
--- @class MouseButton : integer @Identifies a mouse button involved in an input event.
MouseButton = {
    LEFT = 1,
    RIGHT = 2,
    MIDDLE = 3,
    THUMB_1 = 4,
    THUMB_2 = 5,
}
--- @class MovementControlMode : integer @Defines how player input controls the player's movement direction.
MovementControlMode = {
    NONE = 0,
    LOOK_RELATIVE = 1,
    VIEW_RELATIVE = 2,
    FACING_RELATIVE = 3,
    FIXED_AXES = 4,
}
--- @class MovementMode : integer @Describes how the player character is currently moving.
MovementMode = {
    NONE = 0,
    WALKING = 1,
    FALLING = 3,
    SWIMMING = 4,
    FLYING = 5,
}
--- @class NetReferenceType : integer @Indicates the specific type of a `NetReference`.
NetReferenceType = {
    UNKNOWN = 0,
    LEADERBOARD = 1,
    SHARED_PLAYER_STORAGE = 2,
    SHARED_STORAGE = 2,
    CREATOR_PERK = 3,
    CONCURRENT_SHARED_PLAYER_STORAGE = 4,
    CONCURRENT_CREATOR_STORAGE = 5,
}
--- @class NetworkContextType : integer @Indicates the network context to use when spawning an object.
NetworkContextType = {
    NETWORKED = 2,
    CLIENT_CONTEXT = 3,
    SERVER_CONTEXT = 4,
    STATIC_CONTEXT = 5,
    LOCAL_CONTEXT = 6,
}
--- @class Orientation : integer @Determines the orientation of a `UIScrollPanel`.
Orientation = {
    HORIZONTAL = 0,
    VERTICAL = 1,
}
--- @class PlatformType : integer @The type of platform that Core is running on.
PlatformType = {
    UNKNOWN = 0,
    WINDOWS = 1,
    IOS = 2,
    LINUX = 3,
}
--- @class PlayerTransferReason : integer @Indicates how a player joined or left a game.
PlayerTransferReason = {
    UNKNOWN = 0,
    CHARACTER = 1,
    CREATE = 2,
    SHOP = 3,
    BROWSE = 4,
    SOCIAL = 5,
    PORTAL = 6,
    AFK = 7,
    EXIT = 8,
    PORTAL_SCENE = 9,
}
--- @class PrivateNetworkedDataResultCode : integer @Status code returned when setting private player data.
PrivateNetworkedDataResultCode = {
    SUCCESS = 0,
    FAILURE = 1,
    EXCEEDED_SIZE_LIMIT = 2,
}
--- @class ProgressBarFillType : integer @Controls the direction in which the progress bar fills.
ProgressBarFillType = {
    LEFT_TO_RIGHT = 0,
    RIGHT_TO_LEFT = 1,
    FROM_CENTER = 2,
    TOP_TO_BOTTOM = 3,
    BOTTOM_TO_TOP = 4,
}
--- @class RespawnMode : integer @Specifies whether a player respawns automatically, and how a start point is selected when they spawn.
RespawnMode = {
    NONE = 0,
    IN_PLACE = 1,
    ROUND_ROBIN = 2,
    AT_CLOSEST_SPAWN_POINT = 3,
    FARTHEST_FROM_OTHER_PLAYERS = 4,
    FARTHEST_FROM_ENEMY = 5,
    RANDOM = 6,
}
--- @class RewardsDialogTab : integer @Specifies a tab on the rewards dialog window.
RewardsDialogTab = {
    QUESTS = 1,
    GAMES = 2,
}
--- @class RotationMode : integer @Camera rotation mode.
RotationMode = {
    CAMERA = 0,
    NONE = 1,
    LOOK_ANGLE = 2,
}
--- @class SpawnMode : integer @Specifies how a start point is selected when a player spawns.
SpawnMode = {
    RANDOM = 0,
    ROUND_ROBIN = 1,
    FARTHEST_FROM_OTHER_PLAYERS = 2,
    FARTHEST_FROM_ENEMY = 3,
}
--- @class StorageResultCode : integer @Status code returned by calls to update a player's storage data.
StorageResultCode = {
    SUCCESS = 0,
    STORAGE_DISABLED = 1,
    FAILURE = 2,
    EXCEEDED_SIZE_LIMIT = 3,
    REQUEST_ALREADY_QUEUED = 4,
}
--- @class TaskStatus : integer @Indicates the status of a script `Task`.
TaskStatus = {
    UNINITIALIZED = 0,
    SCHEDULED = 1,
    RUNNING = 2,
    COMPLETED = 3,
    YIELDED = 4,
    FAILED = 5,
    CANCELED = 6,
    BLOCKED = 7,
}
--- @class TextJustify : integer @Indicates horizontal alignment of a `UIText` element.
TextJustify = {
    LEFT = 0,
    CENTER = 1,
    RIGHT = 2,
}
--- @class UIPivot : integer @Specifies the pivot point of a `UIControl`.
UIPivot = {
    TOP_LEFT = 0,
    TOP_CENTER = 1,
    TOP_RIGHT = 2,
    MIDDLE_LEFT = 3,
    MIDDLE_CENTER = 4,
    MIDDLE_RIGHT = 5,
    BOTTOM_LEFT = 6,
    BOTTOM_CENTER = 7,
    BOTTOM_RIGHT = 8,
    CUSTOM = 9,
}
--- @class Visibility : integer @Controls visibility of a `CoreObject`.
Visibility = {
    INHERIT = 0,
    FORCE_ON = 1,
    FORCE_OFF = 2,
}
--- @class VoiceChannelType : integer @Indicates the type of a voice chat channel.
VoiceChannelType = {
    NORMAL = 0,
    POSITIONAL = 1,
}
--- @class VoiceChatMethod : integer @Indicates the setting a player uses to activate voice chat.
VoiceChatMethod = {
    PUSH_TO_TALK = 0,
    DETECT_SPEAKING = 2,
}
--- @class VoiceChatMode : integer @Controls whether voice chat is enabled in the game.
VoiceChatMode = {
    NONE = 0,
    TEAM = 1,
    ALL = 2,
}
--- @type CoreObject
script = nil

--- Returns the time in seconds (floating point) since the game started on the server.
--- @return number
function time() end

--- The Tick event is used for things you need to check continuously (e.g. main game loop), but be careful of putting too much logic here or you will cause performance issues. DeltaTime is the time difference (in seconds) between this and the last tick.
--- @param deltaTime number
--- @return number
function Tick(deltaTime) end

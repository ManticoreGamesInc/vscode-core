--- @class AIActivity
--- @field name string
--- @field owner AIActivityHandler
--- @field priority number
--- @field isDebugModeEnabled boolean
--- @field isHighestPriority boolean
--- @field elapsedTime number
--- @field type string
local AIActivityInstance = {}
--- @param typeName string
--- @return boolean
function AIActivityInstance:IsA(typeName) end

--- @class GlobalAIActivity
AIActivity = {}

--- @class AIActivityHandler : CoreObject
--- @field isSelectedInDebugger boolean
--- @field type string
local AIActivityHandlerInstance = {}
--- @overload fun(name: string): AIActivity
--- @param name string
--- @param functions table
--- @return AIActivity
function AIActivityHandlerInstance:AddActivity(name, functions) end

--- @param name string
function AIActivityHandlerInstance:RemoveActivity(name) end

function AIActivityHandlerInstance:ClearActivities() end

--- @return table<number, AIActivity>
function AIActivityHandlerInstance:GetActivities() end

--- @param name string
--- @return AIActivity
function AIActivityHandlerInstance:FindActivity(name) end

--- @param typeName string
--- @return boolean
function AIActivityHandlerInstance:IsA(typeName) end

--- @class GlobalAIActivityHandler : CoreObject
AIActivityHandler = {}

--- @class Ability : CoreObject
--- @field readyEvent Event
--- @field castEvent Event
--- @field executeEvent Event
--- @field recoveryEvent Event
--- @field cooldownEvent Event
--- @field interruptedEvent Event
--- @field tickEvent Event
--- @field actionBinding string
--- @field canActivateWhileDead boolean
--- @field animation string
--- @field canBePrevented boolean
--- @field castPhaseSettings AbilityPhaseSettings
--- @field executePhaseSettings AbilityPhaseSettings
--- @field recoveryPhaseSettings AbilityPhaseSettings
--- @field cooldownPhaseSettings AbilityPhaseSettings
--- @field isEnabled boolean
--- @field owner Object
--- @field type string
local AbilityInstance = {}
--- @return AbilityTarget
function AbilityInstance:GetTargetData() end

--- @param target AbilityTarget
function AbilityInstance:SetTargetData(target) end

--- @return AbilityPhase
function AbilityInstance:GetCurrentPhase() end

--- @return number
function AbilityInstance:GetPhaseTimeRemaining() end

function AbilityInstance:Interrupt() end

function AbilityInstance:Activate() end

function AbilityInstance:AdvancePhase() end

--- @param typeName string
--- @return boolean
function AbilityInstance:IsA(typeName) end

--- @class GlobalAbility : CoreObject
Ability = {}

--- @class AbilityPhaseSettings
--- @field duration number
--- @field canMove boolean
--- @field canJump boolean
--- @field canRotate boolean
--- @field preventsOtherAbilities boolean
--- @field isTargetDataUpdated boolean
--- @field facingMode AbilityFacingMode
--- @field type string
local AbilityPhaseSettingsInstance = {}
--- @param typeName string
--- @return boolean
function AbilityPhaseSettingsInstance:IsA(typeName) end

--- @class GlobalAbilityPhaseSettings
AbilityPhaseSettings = {}

--- @class AbilityTarget
--- @field hitPlayer Player
--- @field hitObject Object
--- @field spreadHalfAngle number
--- @field spreadRandomSeed number
--- @field type string
local AbilityTargetInstance = {}
--- @return Rotation
function AbilityTargetInstance:GetOwnerMovementRotation() end

--- @param rotation Rotation
function AbilityTargetInstance:SetOwnerMovementRotation(rotation) end

--- @return Vector3
function AbilityTargetInstance:GetAimPosition() end

--- @param worldPosition Vector3
function AbilityTargetInstance:SetAimPosition(worldPosition) end

--- @return Vector3
function AbilityTargetInstance:GetAimDirection() end

--- @param direction Vector3
function AbilityTargetInstance:SetAimDirection(direction) end

--- @return Vector3
function AbilityTargetInstance:GetHitPosition() end

--- @param worldPosition Vector3
function AbilityTargetInstance:SetHitPosition(worldPosition) end

--- @return HitResult
function AbilityTargetInstance:GetHitResult() end

--- @param hitResult HitResult
function AbilityTargetInstance:SetHitResult(hitResult) end

--- @param typeName string
--- @return boolean
function AbilityTargetInstance:IsA(typeName) end

--- @class GlobalAbilityTarget
AbilityTarget = {}
--- @return AbilityTarget
function AbilityTarget.New() end


--- @class AnimatedMesh : CoreMesh
--- @field animationEvent Event
--- @field animationStance string
--- @field animationStancePlaybackRate number
--- @field animationStanceShouldLoop boolean
--- @field playbackRateMultiplier number
--- @field type string
local AnimatedMeshInstance = {}
--- @return table<number, string>
function AnimatedMeshInstance:GetAnimationNames() end

--- @return table<number, string>
function AnimatedMeshInstance:GetAnimationStanceNames() end

--- @return table<number, string>
function AnimatedMeshInstance:GetSocketNames() end

--- @param animationName string
--- @return table<number, string>
function AnimatedMeshInstance:GetAnimationEventNames(animationName) end

--- @param objectToAttach CoreObject
--- @param socket string
function AnimatedMeshInstance:AttachCoreObject(objectToAttach, socket) end

--- @overload fun(animationName: string)
--- @param animationName string
--- @param optionalParameters table
function AnimatedMeshInstance:PlayAnimation(animationName, optionalParameters) end

function AnimatedMeshInstance:StopAnimations() end

--- @param animationName string
--- @return number
function AnimatedMeshInstance:GetAnimationDuration(animationName) end

--- @param slotIndex number
--- @param assetId string
function AnimatedMeshInstance:SetMeshForSlot(slotIndex, assetId) end

--- @param slotIndex number
--- @return string
function AnimatedMeshInstance:GetMeshForSlot(slotIndex) end

--- @param assetId string
--- @param slotName string
function AnimatedMeshInstance:SetMaterialForSlot(assetId, slotName) end

--- @param slotName string
--- @return MaterialSlot
function AnimatedMeshInstance:GetMaterialSlot(slotName) end

--- @return table<number, MaterialSlot>
function AnimatedMeshInstance:GetMaterialSlots() end

--- @param typeName string
--- @return boolean
function AnimatedMeshInstance:IsA(typeName) end

--- @class GlobalAnimatedMesh : CoreMesh
AnimatedMesh = {}

--- @class AreaLight : Light
--- @field sourceWidth number
--- @field sourceHeight number
--- @field barnDoorAngle number
--- @field barnDoorLength number
--- @field type string
local AreaLightInstance = {}
--- @param typeName string
--- @return boolean
function AreaLightInstance:IsA(typeName) end

--- @class GlobalAreaLight : Light
AreaLight = {}

--- @class Audio : CoreObject
--- @field isSpatializationEnabled boolean
--- @field isAttenuationEnabled boolean
--- @field isOcclusionEnabled boolean
--- @field isAutoPlayEnabled boolean
--- @field isTransient boolean
--- @field isAutoRepeatEnabled boolean
--- @field pitch number
--- @field volume number
--- @field radius number
--- @field falloff number
--- @field isPlaying boolean
--- @field length number
--- @field currentPlaybackTime number
--- @field fadeInTime number
--- @field fadeOutTime number
--- @field startTime number
--- @field stopTime number
--- @field type string
local AudioInstance = {}
function AudioInstance:Play() end

function AudioInstance:Stop() end

--- @param time number
function AudioInstance:FadeIn(time) end

--- @param time number
function AudioInstance:FadeOut(time) end

--- @param typeName string
--- @return boolean
function AudioInstance:IsA(typeName) end

--- @class GlobalAudio : CoreObject
Audio = {}

--- @class Camera : CoreObject
--- @field followPlayer Player
--- @field isOrthographic boolean
--- @field fieldOfView number
--- @field viewWidth number
--- @field useCameraSocket boolean
--- @field currentDistance number
--- @field isDistanceAdjustable boolean
--- @field minDistance number
--- @field maxDistance number
--- @field rotationMode RotationMode
--- @field hasFreeControl boolean
--- @field currentPitch number
--- @field minPitch number
--- @field maxPitch number
--- @field isYawLimited boolean
--- @field currentYaw number
--- @field minYaw number
--- @field maxYaw number
--- @field lerpTime number
--- @field isUsingCameraRotation boolean
--- @field type string
local CameraInstance = {}
--- @return Vector3
function CameraInstance:GetPositionOffset() end

--- @param positionOffset Vector3
function CameraInstance:SetPositionOffset(positionOffset) end

--- @return Rotation
function CameraInstance:GetRotationOffset() end

--- @param rotationOffset Rotation
function CameraInstance:SetRotationOffset(rotationOffset) end

--- @param typeName string
--- @return boolean
function CameraInstance:IsA(typeName) end

--- @class GlobalCamera : CoreObject
Camera = {}

--- @class Color
--- @field r number
--- @field g number
--- @field b number
--- @field a number
--- @field type string
local ColorInstance = {}
--- @param desaturation number
--- @return Color
function ColorInstance:GetDesaturated(desaturation) end

--- @return string
function ColorInstance:ToStandardHex() end

--- @return string
function ColorInstance:ToLinearHex() end

--- @param typeName string
--- @return boolean
function ColorInstance:IsA(typeName) end

--- @class GlobalColor
Color = {}
--- @return Color
function Color.Random() end

--- @param from Color
--- @param to Color
--- @param progress number
--- @return Color
function Color.Lerp(from, to, progress) end

--- @param hexString string
--- @return Color
function Color.FromStandardHex(hexString) end

--- @param hexString string
--- @return Color
function Color.FromLinearHex(hexString) end

--- @overload fun(rgbaVector: Vector4): Color
--- @overload fun(rgbVector: Vector3): Color
--- @overload fun(red: number,green: number,blue: number,alpha: number): Color
--- @overload fun(red: number,green: number,blue: number): Color
--- @overload fun(): Color
--- @param color Color
--- @return Color
function Color.New(color) end


--- @class CoreFriendCollection
--- @field hasMoreResults boolean
--- @field type string
local CoreFriendCollectionInstance = {}
--- @return table<number, CoreFriendCollectionEntry>
function CoreFriendCollectionInstance:GetResults() end

--- @return CoreFriendCollection
function CoreFriendCollectionInstance:GetMoreResults() end

--- @param typeName string
--- @return boolean
function CoreFriendCollectionInstance:IsA(typeName) end

--- @class GlobalCoreFriendCollection
CoreFriendCollection = {}

--- @class CoreFriendCollectionEntry
--- @field id string
--- @field name string
--- @field type string
local CoreFriendCollectionEntryInstance = {}
--- @param typeName string
--- @return boolean
function CoreFriendCollectionEntryInstance:IsA(typeName) end

--- @class GlobalCoreFriendCollectionEntry
CoreFriendCollectionEntry = {}

--- @class CoreGameCollectionEntry
--- @field id string
--- @field parentGameId string
--- @field name string
--- @field ownerId string
--- @field ownerName string
--- @field isPromoted boolean
--- @field type string
local CoreGameCollectionEntryInstance = {}
--- @param typeName string
--- @return boolean
function CoreGameCollectionEntryInstance:IsA(typeName) end

--- @class GlobalCoreGameCollectionEntry
CoreGameCollectionEntry = {}

--- @class CoreGameInfo
--- @field id string
--- @field parentGameId string
--- @field name string
--- @field description string
--- @field ownerId string
--- @field ownerName string
--- @field maxPlayers number
--- @field isQueueEnabled boolean
--- @field screenshotCount number
--- @field hasWorldCapture boolean
--- @field type string
local CoreGameInfoInstance = {}
--- @return table<number, string>
function CoreGameInfoInstance:GetTags() end

--- @param typeName string
--- @return boolean
function CoreGameInfoInstance:IsA(typeName) end

--- @class GlobalCoreGameInfo
CoreGameInfo = {}

--- @class CoreMesh : CoreObject
--- @field meshAssetId string
--- @field team number
--- @field isTeamColorUsed boolean
--- @field isTeamCollisionEnabled boolean
--- @field isEnemyCollisionEnabled boolean
--- @field isCameraCollisionEnabled boolean
--- @field type string
local CoreMeshInstance = {}
--- @return Color
function CoreMeshInstance:GetColor() end

--- @param color Color
function CoreMeshInstance:SetColor(color) end

function CoreMeshInstance:ResetColor() end

--- @param typeName string
--- @return boolean
function CoreMeshInstance:IsA(typeName) end

--- @class GlobalCoreMesh : CoreObject
CoreMesh = {}

--- @class CoreObject
--- @field childAddedEvent Event
--- @field childRemovedEvent Event
--- @field descendantAddedEvent Event
--- @field descendantRemovedEvent Event
--- @field destroyEvent Event
--- @field networkedPropertyChangedEvent Event
--- @field name string
--- @field id string
--- @field isVisible boolean
--- @field visibility Visibility
--- @field isCollidable boolean
--- @field collision Collision
--- @field cameraCollision Collision
--- @field isEnabled boolean
--- @field lifeSpan number
--- @field isStatic boolean
--- @field isNetworked boolean
--- @field isClientOnly boolean
--- @field isServerOnly boolean
--- @field parent CoreObject
--- @field sourceTemplateId string
--- @field type string
local CoreObjectInstance = {}
--- @return CoreObjectReference
function CoreObjectInstance:GetReference() end

--- @return Transform
function CoreObjectInstance:GetTransform() end

--- @param localTransform Transform
function CoreObjectInstance:SetTransform(localTransform) end

--- @return Vector3
function CoreObjectInstance:GetPosition() end

--- @param localPosition Vector3
function CoreObjectInstance:SetPosition(localPosition) end

--- @return Rotation
function CoreObjectInstance:GetRotation() end

--- @param localRotation Rotation
function CoreObjectInstance:SetRotation(localRotation) end

--- @return Vector3
function CoreObjectInstance:GetScale() end

--- @param localScale Vector3
function CoreObjectInstance:SetScale(localScale) end

--- @return Transform
function CoreObjectInstance:GetWorldTransform() end

--- @param worldTransform Transform
function CoreObjectInstance:SetWorldTransform(worldTransform) end

--- @return Vector3
function CoreObjectInstance:GetWorldPosition() end

--- @param worldPosition Vector3
function CoreObjectInstance:SetWorldPosition(worldPosition) end

--- @return Rotation
function CoreObjectInstance:GetWorldRotation() end

--- @param worldRotation Rotation
function CoreObjectInstance:SetWorldRotation(worldRotation) end

--- @return Vector3
function CoreObjectInstance:GetWorldScale() end

--- @param worldScale Vector3
function CoreObjectInstance:SetWorldScale(worldScale) end

--- @return Vector3
function CoreObjectInstance:GetVelocity() end

--- @param velocity Vector3
function CoreObjectInstance:SetVelocity(velocity) end

--- @return Vector3
function CoreObjectInstance:GetAngularVelocity() end

--- @param angularVelocity Vector3
function CoreObjectInstance:SetAngularVelocity(angularVelocity) end

--- @param localAngularVelocity Vector3
function CoreObjectInstance:SetLocalAngularVelocity(localAngularVelocity) end

--- @return table<number, CoreObject>
function CoreObjectInstance:GetChildren() end

--- @param player Player
--- @param socketName string
function CoreObjectInstance:AttachToPlayer(player, socketName) end

function CoreObjectInstance:AttachToLocalView() end

function CoreObjectInstance:Detach() end

--- @return string
function CoreObjectInstance:GetAttachedToSocketName() end

--- @return boolean
function CoreObjectInstance:IsVisibleInHierarchy() end

--- @return boolean
function CoreObjectInstance:IsCollidableInHierarchy() end

--- @return boolean
function CoreObjectInstance:IsCameraCollidableInHierarchy() end

--- @return boolean
function CoreObjectInstance:IsEnabledInHierarchy() end

--- @param name string
--- @return CoreObject
function CoreObjectInstance:FindAncestorByName(name) end

--- @param name string
--- @return CoreObject
function CoreObjectInstance:FindChildByName(name) end

--- @param name string
--- @return CoreObject
function CoreObjectInstance:FindDescendantByName(name) end

--- @param name string
--- @return table<number, CoreObject>
function CoreObjectInstance:FindDescendantsByName(name) end

--- @param typeName string
--- @return CoreObject
function CoreObjectInstance:FindAncestorByType(typeName) end

--- @param typeName string
--- @return CoreObject
function CoreObjectInstance:FindChildByType(typeName) end

--- @param typeName string
--- @return CoreObject
function CoreObjectInstance:FindDescendantByType(typeName) end

--- @param typeName string
--- @return table<number, CoreObject>
function CoreObjectInstance:FindDescendantsByType(typeName) end

--- @return CoreObject
function CoreObjectInstance:FindTemplateRoot() end

--- @param coreObject CoreObject
--- @return boolean
function CoreObjectInstance:IsAncestorOf(coreObject) end

--- @overload fun(worldPosition: Vector3,duration: number)
--- @param position Vector3
--- @param duration number
--- @param isLocalPosition boolean
function CoreObjectInstance:MoveTo(position, duration, isLocalPosition) end

--- @overload fun(worldVelocity: Vector3)
--- @param worldVelocity Vector3
--- @param isLocalVelocity boolean
function CoreObjectInstance:MoveContinuous(worldVelocity, isLocalVelocity) end

--- @overload fun(target: Player,speed: number)
--- @overload fun(target: Player)
--- @overload fun(target: CoreObject,speed: number,minimumDistance: number)
--- @overload fun(target: CoreObject,speed: number)
--- @overload fun(target: CoreObject)
--- @param target Player
--- @param speed number
--- @param minimumDistance number
function CoreObjectInstance:Follow(target, speed, minimumDistance) end

function CoreObjectInstance:StopMove() end

--- @overload fun(worldRotation: Quaternion,duration: number)
--- @overload fun(rotation: Rotation,duration: number,isLocalRotation: boolean)
--- @overload fun(worldRotation: Rotation,duration: number)
--- @param rotation Quaternion
--- @param duration number
--- @param isLocalRotation boolean
function CoreObjectInstance:RotateTo(rotation, duration, isLocalRotation) end

--- @overload fun(angularVelocity: Vector3)
--- @overload fun(quaternionSpeed: Quaternion,multiplier: number,isLocalQuaternionSpeed: boolean)
--- @overload fun(quaternionSpeed: Quaternion,multiplier: number)
--- @overload fun(quaternionSpeed: Quaternion)
--- @overload fun(rotationSpeed: Rotation,multiplier: number,isLocalRotationSpeed: boolean)
--- @overload fun(rotationSpeed: Rotation,multiplier: number)
--- @overload fun(rotationSpeed: Rotation)
--- @param angularVelocity Vector3
--- @param isLocalAngularVelocity boolean
function CoreObjectInstance:RotateContinuous(angularVelocity, isLocalAngularVelocity) end

--- @param worldPosition Vector3
function CoreObjectInstance:LookAt(worldPosition) end

--- @overload fun(target: Player,speed: number)
--- @overload fun(target: Player,isPitchLocked: boolean)
--- @overload fun(target: Player)
--- @overload fun(target: CoreObject,isPitchLocked: boolean,speed: number)
--- @overload fun(target: CoreObject,speed: number)
--- @overload fun(target: CoreObject,isPitchLocked: boolean)
--- @overload fun(target: CoreObject)
--- @param target Player
--- @param isPitchLocked boolean
--- @param speed number
function CoreObjectInstance:LookAtContinuous(target, isPitchLocked, speed) end

--- @overload fun()
--- @param isPitchLocked boolean
function CoreObjectInstance:LookAtLocalView(isPitchLocked) end

function CoreObjectInstance:StopRotate() end

--- @overload fun(worldScale: Vector3,duration: number)
--- @param scale Vector3
--- @param duration number
--- @param isScaleLocal boolean
function CoreObjectInstance:ScaleTo(scale, duration, isScaleLocal) end

--- @overload fun(scaleRate: Vector3)
--- @param scaleRate Vector3
--- @param isLocalScaleRate boolean
function CoreObjectInstance:ScaleContinuous(scaleRate, isLocalScaleRate) end

function CoreObjectInstance:StopScale() end

function CoreObjectInstance:ReorderBeforeSiblings() end

function CoreObjectInstance:ReorderAfterSiblings() end

--- @param sibling CoreObject
function CoreObjectInstance:ReorderBefore(sibling) end

--- @param sibling CoreObject
function CoreObjectInstance:ReorderAfter(sibling) end

function CoreObjectInstance:Destroy() end

--- @return table
function CoreObjectInstance:GetCustomProperties() end

--- @param propertyName string
--- @return any|boolean
function CoreObjectInstance:GetCustomProperty(propertyName) end

--- @param propertyName string
--- @param propertyValue any
--- @return boolean
function CoreObjectInstance:SetNetworkedCustomProperty(propertyName, propertyValue) end

--- @param typeName string
--- @return boolean
function CoreObjectInstance:IsA(typeName) end

--- @class GlobalCoreObject
CoreObject = {}

--- @class CoreObjectReference
--- @field id string
--- @field isAssigned boolean
--- @field type string
local CoreObjectReferenceInstance = {}
--- @return CoreObject
function CoreObjectReferenceInstance:GetObject() end

--- @overload fun(): CoreObject
--- @param timeout number
--- @return CoreObject
function CoreObjectReferenceInstance:WaitForObject(timeout) end

--- @param typeName string
--- @return boolean
function CoreObjectReferenceInstance:IsA(typeName) end

--- @class GlobalCoreObjectReference
CoreObjectReference = {}

--- @class CorePlayerProfile
--- @field id string
--- @field name string
--- @field description string
--- @field type string
local CorePlayerProfileInstance = {}
--- @param typeName string
--- @return boolean
function CorePlayerProfileInstance:IsA(typeName) end

--- @class GlobalCorePlayerProfile
CorePlayerProfile = {}

--- @class CurveKey
--- @field interpolation CurveInterpolation
--- @field time number
--- @field value number
--- @field arriveTangent number
--- @field leaveTangent number
--- @field type string
local CurveKeyInstance = {}
--- @param typeName string
--- @return boolean
function CurveKeyInstance:IsA(typeName) end

--- @class GlobalCurveKey
CurveKey = {}
--- @overload fun(time: number,value: number,optionalParameters: table): CurveKey
--- @overload fun(time: number,value: number): CurveKey
--- @overload fun(): CurveKey
--- @param other CurveKey
--- @return CurveKey
function CurveKey.New(other) end


--- @class Damage
--- @field amount number
--- @field reason DamageReason
--- @field sourceAbility Ability
--- @field sourcePlayer Player
--- @field type string
local DamageInstance = {}
--- @return HitResult
function DamageInstance:GetHitResult() end

--- @param hitResult HitResult
function DamageInstance:SetHitResult(hitResult) end

--- @param typeName string
--- @return boolean
function DamageInstance:IsA(typeName) end

--- @class GlobalDamage
Damage = {}
--- @overload fun(): Damage
--- @param amount number
--- @return Damage
function Damage.New(amount) end


--- @class Decal : SmartObject
--- @field type string
local DecalInstance = {}
--- @param typeName string
--- @return boolean
function DecalInstance:IsA(typeName) end

--- @class GlobalDecal : SmartObject
Decal = {}

--- @class Equipment : CoreObject
--- @field equippedEvent Event
--- @field unequippedEvent Event
--- @field owner Player
--- @field socket string
--- @field type string
local EquipmentInstance = {}
--- @return table<number, Ability>
function EquipmentInstance:GetAbilities() end

--- @param player Player
function EquipmentInstance:Equip(player) end

function EquipmentInstance:Unequip() end

--- @param ability Ability
function EquipmentInstance:AddAbility(ability) end

--- @param typeName string
--- @return boolean
function EquipmentInstance:IsA(typeName) end

--- @class GlobalEquipment : CoreObject
Equipment = {}

--- @class Event
--- @field type string
local EventInstance = {}
--- @overload fun(listener: function): EventListener
--- @param listener function
--- @param additionalParameters any
--- @return EventListener
function EventInstance:Connect(listener, additionalParameters) end

--- @param typeName string
--- @return boolean
function EventInstance:IsA(typeName) end

--- @class GlobalEvent
Event = {}

--- @class EventListener
--- @field isConnected boolean
--- @field type string
local EventListenerInstance = {}
function EventListenerInstance:Disconnect() end

--- @param typeName string
--- @return boolean
function EventListenerInstance:IsA(typeName) end

--- @class GlobalEventListener
EventListener = {}

--- @class Folder : CoreObject
--- @field type string
local FolderInstance = {}
--- @param typeName string
--- @return boolean
function FolderInstance:IsA(typeName) end

--- @class GlobalFolder : CoreObject
Folder = {}

--- @class FourWheeledVehicle : Vehicle
--- @field turnRadius number
--- @field type string
local FourWheeledVehicleInstance = {}
--- @param typeName string
--- @return boolean
function FourWheeledVehicleInstance:IsA(typeName) end

--- @class GlobalFourWheeledVehicle : Vehicle
FourWheeledVehicle = {}

--- @class HitResult
--- @field other Object
--- @field socketName string
--- @field type string
local HitResultInstance = {}
--- @return Vector3
function HitResultInstance:GetImpactPosition() end

--- @return Vector3
function HitResultInstance:GetImpactNormal() end

--- @return Transform
function HitResultInstance:GetTransform() end

--- @param typeName string
--- @return boolean
function HitResultInstance:IsA(typeName) end

--- @class GlobalHitResult
HitResult = {}

--- @class Hook
--- @field type string
local HookInstance = {}
--- @overload fun(listener: function): HookListener
--- @param listener function
--- @param additionalParameters any
--- @return HookListener
function HookInstance:Connect(listener, additionalParameters) end

--- @param typeName string
--- @return boolean
function HookInstance:IsA(typeName) end

--- @class GlobalHook
Hook = {}

--- @class HookListener
--- @field isConnected boolean
--- @field priority number
--- @field type string
local HookListenerInstance = {}
function HookListenerInstance:Disconnect() end

--- @param typeName string
--- @return boolean
function HookListenerInstance:IsA(typeName) end

--- @class GlobalHookListener
HookListener = {}

--- @class ImpactData
--- @field targetObject Object
--- @field projectile Projectile
--- @field sourceAbility Ability
--- @field weapon Weapon
--- @field weaponOwner Player
--- @field isHeadshot boolean
--- @field travelDistance number
--- @field type string
local ImpactDataInstance = {}
--- @return HitResult
function ImpactDataInstance:GetHitResult() end

--- @return table<number, HitResult>
function ImpactDataInstance:GetHitResults() end

--- @param typeName string
--- @return boolean
function ImpactDataInstance:IsA(typeName) end

--- @class GlobalImpactData
ImpactData = {}

--- @class LeaderboardEntry
--- @field id string
--- @field name string
--- @field score number
--- @field additionalData string
--- @field type string
local LeaderboardEntryInstance = {}
--- @param typeName string
--- @return boolean
function LeaderboardEntryInstance:IsA(typeName) end

--- @class GlobalLeaderboardEntry
LeaderboardEntry = {}

--- @class Light : CoreObject
--- @field intensity number
--- @field attenuationRadius number
--- @field isShadowCaster boolean
--- @field hasTemperature boolean
--- @field temperature number
--- @field team number
--- @field isTeamColorUsed boolean
--- @field type string
local LightInstance = {}
--- @return Color
function LightInstance:GetColor() end

--- @param color Color
function LightInstance:SetColor(color) end

--- @param typeName string
--- @return boolean
function LightInstance:IsA(typeName) end

--- @class GlobalLight : CoreObject
Light = {}

--- @class MaterialSlot
--- @field slotName string
--- @field mesh CoreMesh
--- @field materialAssetId string
--- @field isSmartMaterial boolean
--- @field type string
local MaterialSlotInstance = {}
--- @overload fun(u: number,v: number)
--- @param uv Vector2
function MaterialSlotInstance:SetUVTiling(uv) end

--- @return Vector2
function MaterialSlotInstance:GetUVTiling() end

--- @param color Color
function MaterialSlotInstance:SetColor(color) end

--- @return Color
function MaterialSlotInstance:GetColor() end

function MaterialSlotInstance:ResetColor() end

function MaterialSlotInstance:ResetUVTiling() end

function MaterialSlotInstance:ResetIsSmartMaterial() end

function MaterialSlotInstance:ResetMaterialAssetId() end

--- @param typeName string
--- @return boolean
function MaterialSlotInstance:IsA(typeName) end

--- @class GlobalMaterialSlot
MaterialSlot = {}

--- @class MergedModel : Folder
--- @field type string
local MergedModelInstance = {}
--- @param typeName string
--- @return boolean
function MergedModelInstance:IsA(typeName) end

--- @class GlobalMergedModel : Folder
MergedModel = {}

--- @class NetReference
--- @field isAssigned boolean
--- @field referenceType NetReferenceType
--- @field type string
local NetReferenceInstance = {}
--- @param typeName string
--- @return boolean
function NetReferenceInstance:IsA(typeName) end

--- @class GlobalNetReference
NetReference = {}

--- @class NetworkContext : CoreObject
--- @field type string
local NetworkContextInstance = {}
--- @param typeName string
--- @return boolean
function NetworkContextInstance:IsA(typeName) end

--- @class GlobalNetworkContext : CoreObject
NetworkContext = {}

--- @class Object
--- @field serverUserData table
--- @field clientUserData table
--- @field type string
local ObjectInstance = {}
--- @param typeName string
--- @return boolean
function ObjectInstance:IsA(typeName) end

--- @class GlobalObject
Object = {}
--- @param object any
--- @return boolean
function Object.IsValid(object) end


--- @class Player
--- @field damagedEvent Event
--- @field diedEvent Event
--- @field spawnedEvent Event
--- @field respawnedEvent Event
--- @field bindingPressedEvent Event
--- @field bindingReleasedEvent Event
--- @field resourceChangedEvent Event
--- @field movementModeChangedEvent Event
--- @field animationEvent Event
--- @field emoteStartedEvent Event
--- @field emoteStoppedEvent Event
--- @field perkChangedEvent Event
--- @field privateNetworkedDataChangedEvent Event
--- @field id string
--- @field name string
--- @field team number
--- @field hitPoints number
--- @field maxHitPoints number
--- @field kills number
--- @field deaths number
--- @field isSpawned boolean
--- @field isDead boolean
--- @field mass number
--- @field isAccelerating boolean
--- @field isCrouching boolean
--- @field isFlying boolean
--- @field isGrounded boolean
--- @field isJumping boolean
--- @field isMounted boolean
--- @field isSwimming boolean
--- @field isWalking boolean
--- @field isSliding boolean
--- @field maxWalkSpeed number
--- @field stepHeight number
--- @field maxAcceleration number
--- @field brakingDecelerationFalling number
--- @field brakingDecelerationWalking number
--- @field groundFriction number
--- @field brakingFrictionFactor number
--- @field walkableFloorAngle number
--- @field lookSensitivity number
--- @field animationStance string
--- @field activeEmote string
--- @field currentFacingMode FacingMode
--- @field desiredFacingMode FacingMode
--- @field maxJumpCount number
--- @field flipOnMultiJump boolean
--- @field shouldFlipOnMultiJump boolean
--- @field jumpVelocity number
--- @field gravityScale number
--- @field maxSwimSpeed number
--- @field touchForceFactor number
--- @field isCrouchEnabled boolean
--- @field buoyancy number
--- @field isVisible boolean
--- @field isVisibleToSelf boolean
--- @field spreadModifier number
--- @field currentSpread number
--- @field canMount boolean
--- @field shouldDismountWhenDamaged boolean
--- @field movementControlMode MovementControlMode
--- @field lookControlMode LookControlMode
--- @field isMovementEnabled boolean
--- @field isCollidable boolean
--- @field parentCoreObject CoreObject
--- @field spawnMode SpawnMode
--- @field respawnMode RespawnMode
--- @field respawnDelay number
--- @field respawnTimeRemaining number
--- @field occupiedVehicle Vehicle
--- @field currentRotationRate number
--- @field defaultRotationRate number
--- @field type string
local PlayerInstance = {}
--- @return Transform
function PlayerInstance:GetWorldTransform() end

--- @param worldTransform Transform
function PlayerInstance:SetWorldTransform(worldTransform) end

--- @return Vector3
function PlayerInstance:GetWorldPosition() end

--- @param worldPosition Vector3
function PlayerInstance:SetWorldPosition(worldPosition) end

--- @return Rotation
function PlayerInstance:GetWorldRotation() end

--- @param worldRotation Rotation
function PlayerInstance:SetWorldRotation(worldRotation) end

--- @return Vector3
function PlayerInstance:GetWorldScale() end

--- @param worldScale Vector3
function PlayerInstance:SetWorldScale(worldScale) end

--- @return Vector3
function PlayerInstance:GetVelocity() end

--- @return table<number, Ability>
function PlayerInstance:GetAbilities() end

--- @return table<number, Equipment>
function PlayerInstance:GetEquipment() end

--- @return table<number, CoreObject>
function PlayerInstance:GetAttachedObjects() end

--- @param impulse Vector3
function PlayerInstance:AddImpulse(impulse) end

--- @param velocity Vector3
function PlayerInstance:SetVelocity(velocity) end

function PlayerInstance:ResetVelocity() end

--- @param damage Damage
function PlayerInstance:ApplyDamage(damage) end

--- @overload fun(socketName: string)
--- @overload fun()
--- @param socketName string
--- @param weight number
function PlayerInstance:EnableRagdoll(socketName, weight) end

function PlayerInstance:DisableRagdoll() end

--- @overload fun(isVisible: boolean)
--- @param isVisible boolean
--- @param includeAttachments boolean
function PlayerInstance:SetVisibility(isVisible, includeAttachments) end

--- @return boolean
function PlayerInstance:GetVisibility() end

--- @return Vector3
function PlayerInstance:GetViewWorldPosition() end

--- @return Rotation
function PlayerInstance:GetViewWorldRotation() end

--- @overload fun()
--- @param damage Damage
function PlayerInstance:Die(damage) end

--- @overload fun()
--- @param optionalParameters table
function PlayerInstance:Spawn(optionalParameters) end

--- @overload fun(optionalParameters: table)
--- @overload fun()
--- @param position Vector3
--- @param rotation Rotation
function PlayerInstance:Respawn(position, rotation) end

function PlayerInstance:Despawn() end

function PlayerInstance:ClearResources() end

--- @return table
function PlayerInstance:GetResources() end

--- @param resourceName string
--- @return number
function PlayerInstance:GetResource(resourceName) end

--- @param resourceName string
--- @param amount number
--- @return number
function PlayerInstance:SetResource(resourceName, amount) end

--- @param resourceName string
--- @param amount number
--- @return number
function PlayerInstance:AddResource(resourceName, amount) end

--- @param resourceName string
--- @param amount number
--- @return number
function PlayerInstance:RemoveResource(resourceName, amount) end

--- @return table<number, string>
function PlayerInstance:GetResourceNames() end

--- @param resourceNamePrefix string
--- @return table<number, string>
function PlayerInstance:GetResourceNamesStartingWith(resourceNamePrefix) end

--- @overload fun(gameInfo: CoreGameInfo)
--- @overload fun(gameId: string)
--- @param gameCollectionEntry CoreGameCollectionEntry
function PlayerInstance:TransferToGame(gameCollectionEntry) end

--- @param perkReference NetReference
--- @return boolean
function PlayerInstance:HasPerk(perkReference) end

--- @param perkReference NetReference
--- @return number
function PlayerInstance:GetPerkCount(perkReference) end

--- @param perkReference NetReference
--- @return number
function PlayerInstance:GetPerkTimeRemaining(perkReference) end

--- @param rewardPoints number
--- @param activityName string
function PlayerInstance:GrantRewardPoints(rewardPoints, activityName) end

function PlayerInstance:ActivateFlying() end

function PlayerInstance:ActivateWalking() end

--- @param isMounted boolean
function PlayerInstance:SetMounted(isMounted) end

--- @return Camera
function PlayerInstance:GetActiveCamera() end

--- @return Camera
function PlayerInstance:GetDefaultCamera() end

--- @overload fun(camera: Camera,lerpTime: number)
--- @param camera Camera
function PlayerInstance:SetDefaultCamera(camera) end

--- @return Camera
function PlayerInstance:GetOverrideCamera() end

--- @overload fun(camera: Camera,lerpTime: number)
--- @param camera Camera
function PlayerInstance:SetOverrideCamera(camera) end

--- @overload fun(lerpTime: number)
function PlayerInstance:ClearOverrideCamera() end

--- @return Rotation
function PlayerInstance:GetLookWorldRotation() end

--- @param newLookRotation Rotation
function PlayerInstance:SetLookWorldRotation(newLookRotation) end

--- @param bindingName string
--- @return boolean
function PlayerInstance:IsBindingPressed(bindingName) end

--- @param object CoreObject
function PlayerInstance:AttachToCoreObject(object) end

function PlayerInstance:Detach() end

--- @return PlayerTransferData
function PlayerInstance:GetJoinTransferData() end

--- @return PlayerTransferData
function PlayerInstance:GetLeaveTransferData() end

--- @param key string
--- @param value any
--- @return PrivateNetworkedDataResultCode
function PlayerInstance:SetPrivateNetworkedData(key, value) end

--- @param key string
--- @return any
function PlayerInstance:GetPrivateNetworkedData(key) end

--- @return table
function PlayerInstance:GetPrivateNetworkedDataKeys() end

--- @param typeName string
--- @return boolean
function PlayerInstance:IsA(typeName) end

--- @class GlobalPlayer
Player = {}

--- @class PlayerSettings : CoreObject
--- @field type string
local PlayerSettingsInstance = {}
--- @param player Player
function PlayerSettingsInstance:ApplyToPlayer(player) end

--- @param typeName string
--- @return boolean
function PlayerSettingsInstance:IsA(typeName) end

--- @class GlobalPlayerSettings : CoreObject
PlayerSettings = {}

--- @class PlayerStart : CoreObject
--- @field team number
--- @field playerScaleMultiplier number
--- @field spawnTemplateId string
--- @field key string
--- @field type string
local PlayerStartInstance = {}
--- @param typeName string
--- @return boolean
function PlayerStartInstance:IsA(typeName) end

--- @class GlobalPlayerStart : CoreObject
PlayerStart = {}

--- @class PlayerTransferData
--- @field reason PlayerTransferReason
--- @field gameId string
--- @field type string
local PlayerTransferDataInstance = {}
--- @param typeName string
--- @return boolean
function PlayerTransferDataInstance:IsA(typeName) end

--- @class GlobalPlayerTransferData
PlayerTransferData = {}

--- @class PointLight : Light
--- @field hasNaturalFalloff boolean
--- @field falloffExponent number
--- @field sourceRadius number
--- @field sourceLength number
--- @field type string
local PointLightInstance = {}
--- @param typeName string
--- @return boolean
function PointLightInstance:IsA(typeName) end

--- @class GlobalPointLight : Light
PointLight = {}

--- @class Projectile
--- @field impactEvent Event
--- @field lifeSpanEndedEvent Event
--- @field homingFailedEvent Event
--- @field sourceAbility Ability
--- @field shouldBounceOnPlayers boolean
--- @field shouldDieOnImpact boolean
--- @field owner Player
--- @field speed number
--- @field maxSpeed number
--- @field gravityScale number
--- @field drag number
--- @field bouncesRemaining number
--- @field bounciness number
--- @field piercesRemaining number
--- @field lifeSpan number
--- @field capsuleRadius number
--- @field capsuleLength number
--- @field homingTarget Object
--- @field homingAcceleration number
--- @field type string
local ProjectileInstance = {}
--- @return Transform
function ProjectileInstance:GetWorldTransform() end

--- @return Vector3
function ProjectileInstance:GetWorldPosition() end

--- @param worldPosition Vector3
function ProjectileInstance:SetWorldPosition(worldPosition) end

--- @return Vector3
function ProjectileInstance:GetVelocity() end

--- @param velocity Vector3
function ProjectileInstance:SetVelocity(velocity) end

function ProjectileInstance:Destroy() end

--- @param typeName string
--- @return boolean
function ProjectileInstance:IsA(typeName) end

--- @class GlobalProjectile
Projectile = {}
--- @param templateId string
--- @param startPosition Vector3
--- @param direction Vector3
--- @return Projectile
function Projectile.Spawn(templateId, startPosition, direction) end


--- @class Quaternion
--- @field x number
--- @field y number
--- @field z number
--- @field w number
--- @field type string
local QuaternionInstance = {}
--- @return Rotation
function QuaternionInstance:GetRotation() end

--- @return Vector3
function QuaternionInstance:GetForwardVector() end

--- @return Vector3
function QuaternionInstance:GetRightVector() end

--- @return Vector3
function QuaternionInstance:GetUpVector() end

--- @param typeName string
--- @return boolean
function QuaternionInstance:IsA(typeName) end

--- @class GlobalQuaternion
Quaternion = {}
--- @param from Quaternion
--- @param to Quaternion
--- @param progress number
--- @return Quaternion
function Quaternion.Slerp(from, to, progress) end

--- @overload fun(fromDirection: Vector3,toDirection: Vector3): Quaternion
--- @overload fun(axis: Vector3,angle: number): Quaternion
--- @overload fun(rotation: Rotation): Quaternion
--- @overload fun(x: number,y: number,z: number,w: number): Quaternion
--- @overload fun(): Quaternion
--- @param quaternion Quaternion
--- @return Quaternion
function Quaternion.New(quaternion) end


--- @class RandomStream
--- @field seed number
--- @field type string
local RandomStreamInstance = {}
--- @return number
function RandomStreamInstance:GetInitialSeed() end

function RandomStreamInstance:Reset() end

function RandomStreamInstance:Mutate() end

--- @overload fun(min: number,max: number): number
--- @return number
function RandomStreamInstance:GetNumber() end

--- @param min number
--- @param max number
--- @return number
function RandomStreamInstance:GetInteger(min, max) end

--- @return Vector3
function RandomStreamInstance:GetVector3() end

--- @overload fun(direction: Vector3,coneHalfAngle: number): Vector3
--- @param direction Vector3
--- @param horizontalHalfAngle number
--- @param verticalHalfAngle number
--- @return Vector3
function RandomStreamInstance:GetVector3FromCone(direction, horizontalHalfAngle, verticalHalfAngle) end

--- @param typeName string
--- @return boolean
function RandomStreamInstance:IsA(typeName) end

--- @class GlobalRandomStream
RandomStream = {}
--- @overload fun(): RandomStream
--- @param seed number
--- @return RandomStream
function RandomStream.New(seed) end


--- @class Rotation
--- @field x number
--- @field y number
--- @field z number
--- @field type string
local RotationInstance = {}
--- @param typeName string
--- @return boolean
function RotationInstance:IsA(typeName) end

--- @class GlobalRotation
Rotation = {}
--- @overload fun(rotation: Rotation): Rotation
--- @overload fun(quaternion: Quaternion): Rotation
--- @overload fun(x: number,y: number,z: number): Rotation
--- @overload fun(): Rotation
--- @param forwardVector Vector3
--- @param upVector Vector3
--- @return Rotation
function Rotation.New(forwardVector, upVector) end


--- @class Script : CoreObject
--- @field context table
--- @field type string
local ScriptInstance = {}
--- @param typeName string
--- @return boolean
function ScriptInstance:IsA(typeName) end

--- @class GlobalScript : CoreObject
Script = {}

--- @class ScriptAsset
--- @field name string
--- @field id string
--- @field type string
local ScriptAssetInstance = {}
--- @return table
function ScriptAssetInstance:GetCustomProperties() end

--- @param propertyName string
--- @return any|boolean
function ScriptAssetInstance:GetCustomProperty(propertyName) end

--- @param typeName string
--- @return boolean
function ScriptAssetInstance:IsA(typeName) end

--- @class GlobalScriptAsset
ScriptAsset = {}

--- @class SimpleCurve
--- @field preExtrapolation CurveExtrapolation
--- @field postExtrapolation CurveExtrapolation
--- @field defaultValue number
--- @field minTime number
--- @field maxTime number
--- @field minValue number
--- @field maxValue number
--- @field type string
local SimpleCurveInstance = {}
--- @param time number
--- @return number
function SimpleCurveInstance:GetValue(time) end

--- @param time number
--- @return number
function SimpleCurveInstance:GetSlope(time) end

--- @param typeName string
--- @return boolean
function SimpleCurveInstance:IsA(typeName) end

--- @class GlobalSimpleCurve
SimpleCurve = {}
--- @overload fun(keys: table): SimpleCurve
--- @overload fun(other: SimpleCurve): SimpleCurve
--- @param keys table
--- @param optionalParameters table
--- @return SimpleCurve
function SimpleCurve.New(keys, optionalParameters) end


--- @class SmartAudio : SmartObject
--- @field isSpatializationEnabled boolean
--- @field isAttenuationEnabled boolean
--- @field isOcclusionEnabled boolean
--- @field fadeInTime number
--- @field fadeOutTime number
--- @field startTime number
--- @field stopTime number
--- @field isAutoPlayEnabled boolean
--- @field isTransient boolean
--- @field isAutoRepeatEnabled boolean
--- @field pitch number
--- @field volume number
--- @field radius number
--- @field falloff number
--- @field isPlaying boolean
--- @field type string
local SmartAudioInstance = {}
function SmartAudioInstance:Play() end

function SmartAudioInstance:Stop() end

--- @param time number
function SmartAudioInstance:FadeIn(time) end

--- @param time number
function SmartAudioInstance:FadeOut(time) end

--- @param typeName string
--- @return boolean
function SmartAudioInstance:IsA(typeName) end

--- @class GlobalSmartAudio : SmartObject
SmartAudio = {}

--- @class SmartObject : CoreObject
--- @field team number
--- @field isTeamColorUsed boolean
--- @field type string
local SmartObjectInstance = {}
--- @return table
function SmartObjectInstance:GetSmartProperties() end

--- @param propertyName string
--- @return any|boolean
function SmartObjectInstance:GetSmartProperty(propertyName) end

--- @param propertyName string
--- @param propertyValue any
--- @return boolean
function SmartObjectInstance:SetSmartProperty(propertyName, propertyValue) end

--- @param typeName string
--- @return boolean
function SmartObjectInstance:IsA(typeName) end

--- @class GlobalSmartObject : CoreObject
SmartObject = {}

--- @class SpotLight : Light
--- @field hasNaturalFalloff boolean
--- @field falloffExponent number
--- @field sourceRadius number
--- @field sourceLength number
--- @field innerConeAngle number
--- @field outerConeAngle number
--- @field type string
local SpotLightInstance = {}
--- @param typeName string
--- @return boolean
function SpotLightInstance:IsA(typeName) end

--- @class GlobalSpotLight : Light
SpotLight = {}

--- @class StaticMesh : CoreMesh
--- @field isSimulatingDebrisPhysics boolean
--- @field type string
local StaticMeshInstance = {}
--- @param assetId string
--- @param slotName string
function StaticMeshInstance:SetMaterialForSlot(assetId, slotName) end

--- @param slotName string
--- @return MaterialSlot
function StaticMeshInstance:GetMaterialSlot(slotName) end

--- @return table<number, MaterialSlot>
function StaticMeshInstance:GetMaterialSlots() end

--- @param typeName string
--- @return boolean
function StaticMeshInstance:IsA(typeName) end

--- @class GlobalStaticMesh : CoreMesh
StaticMesh = {}

--- @class Task
--- @field repeatInterval number
--- @field repeatCount number
--- @field id number
--- @field type string
local TaskInstance = {}
function TaskInstance:Cancel() end

--- @return TaskStatus
function TaskInstance:GetStatus() end

--- @param typeName string
--- @return boolean
function TaskInstance:IsA(typeName) end

--- @class GlobalTask
Task = {}
--- @overload fun(func: function): Task
--- @param func function
--- @param delay number
--- @return Task
function Task.Spawn(func, delay) end

--- @return Task
function Task.GetCurrent() end

--- @overload fun()
--- @param delay number
function Task.Wait(delay) end


--- @class Terrain : CoreObject
--- @field type string
local TerrainInstance = {}
--- @param typeName string
--- @return boolean
function TerrainInstance:IsA(typeName) end

--- @class GlobalTerrain : CoreObject
Terrain = {}

--- @class Transform
--- @field type string
local TransformInstance = {}
--- @return Rotation
function TransformInstance:GetRotation() end

--- @param rotation Rotation
function TransformInstance:SetRotation(rotation) end

--- @return Vector3
function TransformInstance:GetPosition() end

--- @param position Vector3
function TransformInstance:SetPosition(position) end

--- @return Vector3
function TransformInstance:GetScale() end

--- @param scale Vector3
function TransformInstance:SetScale(scale) end

--- @return Quaternion
function TransformInstance:GetQuaternion() end

--- @param quaternion Quaternion
function TransformInstance:SetQuaternion(quaternion) end

--- @return Vector3
function TransformInstance:GetForwardVector() end

--- @return Vector3
function TransformInstance:GetRightVector() end

--- @return Vector3
function TransformInstance:GetUpVector() end

--- @return Transform
function TransformInstance:GetInverse() end

--- @param position Vector3
--- @return Vector3
function TransformInstance:TransformPosition(position) end

--- @param direction Vector3
--- @return Vector3
function TransformInstance:TransformDirection(direction) end

--- @param typeName string
--- @return boolean
function TransformInstance:IsA(typeName) end

--- @class GlobalTransform
Transform = {}
--- @overload fun(xAxis: Vector3,yAxis: Vector3,zAxis: Vector3,position: Vector3): Transform
--- @overload fun(rotation: Rotation,position: Vector3,scale: Vector3): Transform
--- @overload fun(rotation: Quaternion,position: Vector3,scale: Vector3): Transform
--- @overload fun(): Transform
--- @param transform Transform
--- @return Transform
function Transform.New(transform) end


--- @class TreadedVehicle : Vehicle
--- @field turnSpeed number
--- @field type string
local TreadedVehicleInstance = {}
--- @param typeName string
--- @return boolean
function TreadedVehicleInstance:IsA(typeName) end

--- @class GlobalTreadedVehicle : Vehicle
TreadedVehicle = {}

--- @class Trigger : CoreObject
--- @field beginOverlapEvent Event
--- @field endOverlapEvent Event
--- @field interactedEvent Event
--- @field isInteractable boolean
--- @field interactionLabel string
--- @field team number
--- @field isTeamCollisionEnabled boolean
--- @field isEnemyCollisionEnabled boolean
--- @field type string
local TriggerInstance = {}
--- @param OtherObject Object
--- @return boolean
function TriggerInstance:IsOverlapping(OtherObject) end

--- @return table<number, Object>
function TriggerInstance:GetOverlappingObjects() end

--- @param typeName string
--- @return boolean
function TriggerInstance:IsA(typeName) end

--- @class GlobalTrigger : CoreObject
Trigger = {}

--- @class UIButton : UIControl
--- @field clickedEvent Event
--- @field pressedEvent Event
--- @field releasedEvent Event
--- @field hoveredEvent Event
--- @field unhoveredEvent Event
--- @field text string
--- @field fontSize number
--- @field isInteractable boolean
--- @field shouldClipToSize boolean
--- @field shouldScaleToFit boolean
--- @field type string
local UIButtonInstance = {}
--- @param imageId string
function UIButtonInstance:SetImage(imageId) end

--- @return Color
function UIButtonInstance:GetButtonColor() end

--- @param color Color
function UIButtonInstance:SetButtonColor(color) end

--- @return Color
function UIButtonInstance:GetHoveredColor() end

--- @param color Color
function UIButtonInstance:SetHoveredColor(color) end

--- @return Color
function UIButtonInstance:GetPressedColor() end

--- @param color Color
function UIButtonInstance:SetPressedColor(color) end

--- @return Color
function UIButtonInstance:GetDisabledColor() end

--- @param color Color
function UIButtonInstance:SetDisabledColor(color) end

--- @return Color
function UIButtonInstance:GetFontColor() end

--- @param color Color
function UIButtonInstance:SetFontColor(color) end

--- @param font string
function UIButtonInstance:SetFont(font) end

--- @return Color
function UIButtonInstance:GetShadowColor() end

--- @param color Color
function UIButtonInstance:SetShadowColor(color) end

--- @return Vector2
function UIButtonInstance:GetShadowOffset() end

--- @param vector2 Vector2
function UIButtonInstance:SetShadowOffset(vector2) end

--- @param typeName string
--- @return boolean
function UIButtonInstance:IsA(typeName) end

--- @class GlobalUIButton : UIControl
UIButton = {}

--- @class UIContainer : UIControl
--- @field opacity number
--- @field type string
local UIContainerInstance = {}
--- @param typeName string
--- @return boolean
function UIContainerInstance:IsA(typeName) end

--- @class GlobalUIContainer : UIControl
UIContainer = {}

--- @class UIControl : CoreObject
--- @field x number
--- @field y number
--- @field width number
--- @field height number
--- @field rotationAngle number
--- @field anchor UIPivot
--- @field dock UIPivot
--- @field type string
local UIControlInstance = {}
--- @param typeName string
--- @return boolean
function UIControlInstance:IsA(typeName) end

--- @class GlobalUIControl : CoreObject
UIControl = {}

--- @class UIImage : UIControl
--- @field isTeamColorUsed boolean
--- @field team number
--- @field shouldClipToSize boolean
--- @field isFlippedHorizontal boolean
--- @field isFlippedVertical boolean
--- @field type string
local UIImageInstance = {}
--- @return Color
function UIImageInstance:GetColor() end

--- @param color Color
function UIImageInstance:SetColor(color) end

--- @overload fun(imageId: string)
--- @param player Player
function UIImageInstance:SetImage(player) end

--- @overload fun(playerId: string)
--- @overload fun(friend: CoreFriendCollectionEntry)
--- @overload fun(playerProfile: CorePlayerProfile)
--- @param player Player
function UIImageInstance:SetPlayerProfile(player) end

--- @overload fun(gameId: string)
--- @param gameId string
--- @param screenshotIndex number
function UIImageInstance:SetGameScreenshot(gameId, screenshotIndex) end

--- @return string
function UIImageInstance:GetImage() end

--- @return Color
function UIImageInstance:GetShadowColor() end

--- @param color Color
function UIImageInstance:SetShadowColor(color) end

--- @return Vector2
function UIImageInstance:GetShadowOffset() end

--- @param vector2 Vector2
function UIImageInstance:SetShadowOffset(vector2) end

--- @param typeName string
--- @return boolean
function UIImageInstance:IsA(typeName) end

--- @class GlobalUIImage : UIControl
UIImage = {}

--- @class UIPanel : UIControl
--- @field shouldClipChildren number
--- @field opacity number
--- @field type string
local UIPanelInstance = {}
--- @param typeName string
--- @return boolean
function UIPanelInstance:IsA(typeName) end

--- @class GlobalUIPanel : UIControl
UIPanel = {}

--- @class UIPerkPurchaseButton : UIControl
--- @field clickedEvent Event
--- @field pressedEvent Event
--- @field releasedEvent Event
--- @field hoveredEvent Event
--- @field unhoveredEvent Event
--- @field isInteractable boolean
--- @field type string
local UIPerkPurchaseButtonInstance = {}
--- @param perkReference NetReference
function UIPerkPurchaseButtonInstance:SetPerkReference(perkReference) end

--- @return NetReference
function UIPerkPurchaseButtonInstance:GetPerkReference() end

--- @param typeName string
--- @return boolean
function UIPerkPurchaseButtonInstance:IsA(typeName) end

--- @class GlobalUIPerkPurchaseButton : UIControl
UIPerkPurchaseButton = {}

--- @class UIProgressBar : UIControl
--- @field progress number
--- @field fillType ProgressBarFillType
--- @field fillTileType ImageTileType
--- @field backgroundTileType ImageTileType
--- @field type string
local UIProgressBarInstance = {}
--- @param imageId string
function UIProgressBarInstance:SetFillImage(imageId) end

--- @return string
function UIProgressBarInstance:GetFillImage() end

--- @param imageId string
function UIProgressBarInstance:SetBackgroundImage(imageId) end

--- @return string
function UIProgressBarInstance:GetBackgroundImage() end

--- @return Color
function UIProgressBarInstance:GetFillColor() end

--- @param color Color
function UIProgressBarInstance:SetFillColor(color) end

--- @return Color
function UIProgressBarInstance:GetBackgroundColor() end

--- @param color Color
function UIProgressBarInstance:SetBackgroundColor(color) end

--- @param typeName string
--- @return boolean
function UIProgressBarInstance:IsA(typeName) end

--- @class GlobalUIProgressBar : UIControl
UIProgressBar = {}

--- @class UIScrollPanel : UIControl
--- @field orientation Orientation
--- @field scrollPosition number
--- @field contentLength number
--- @field type string
local UIScrollPanelInstance = {}
--- @param typeName string
--- @return boolean
function UIScrollPanelInstance:IsA(typeName) end

--- @class GlobalUIScrollPanel : UIControl
UIScrollPanel = {}

--- @class UIText : UIControl
--- @field text string
--- @field fontSize number
--- @field outlineSize number
--- @field justification TextJustify
--- @field shouldWrapText boolean
--- @field shouldClipText boolean
--- @field shouldScaleToFit boolean
--- @field type string
local UITextInstance = {}
--- @return Color
function UITextInstance:GetColor() end

--- @param color Color
function UITextInstance:SetColor(color) end

--- @return Vector2
function UITextInstance:ComputeApproximateSize() end

--- @param font string
function UITextInstance:SetFont(font) end

--- @return Color
function UITextInstance:GetShadowColor() end

--- @param color Color
function UITextInstance:SetShadowColor(color) end

--- @return Vector2
function UITextInstance:GetShadowOffset() end

--- @param vector2 Vector2
function UITextInstance:SetShadowOffset(vector2) end

--- @return Color
function UITextInstance:GetOutlineColor() end

--- @param color Color
function UITextInstance:SetOutlineColor(color) end

--- @param typeName string
--- @return boolean
function UITextInstance:IsA(typeName) end

--- @class GlobalUIText : UIControl
UIText = {}

--- @class Vector2
--- @field x number
--- @field y number
--- @field size number
--- @field sizeSquared number
--- @field type string
local Vector2Instance = {}
--- @return Vector2
function Vector2Instance:GetNormalized() end

--- @param typeName string
--- @return boolean
function Vector2Instance:IsA(typeName) end

--- @class GlobalVector2
Vector2 = {}
--- @param from Vector2
--- @param to Vector2
--- @param progress number
--- @return Vector2
function Vector2.Lerp(from, to, progress) end

--- @overload fun(vector: Vector3): Vector2
--- @overload fun(vector: Vector2): Vector2
--- @overload fun(x: number,y: number): Vector2
--- @overload fun(): Vector2
--- @param xy number
--- @return Vector2
function Vector2.New(xy) end


--- @class Vector3
--- @field x number
--- @field y number
--- @field z number
--- @field size number
--- @field sizeSquared number
--- @field type string
local Vector3Instance = {}
--- @return Vector3
function Vector3Instance:GetNormalized() end

--- @param typeName string
--- @return boolean
function Vector3Instance:IsA(typeName) end

--- @class GlobalVector3
Vector3 = {}
--- @param from Vector3
--- @param to Vector3
--- @param progress number
--- @return Vector3
function Vector3.Lerp(from, to, progress) end

--- @overload fun(vector: Vector4): Vector3
--- @overload fun(vector: Vector3): Vector3
--- @overload fun(xy: Vector2,z: number): Vector3
--- @overload fun(x: number,y: number,z: number): Vector3
--- @overload fun(): Vector3
--- @param xyz number
--- @return Vector3
function Vector3.New(xyz) end


--- @class Vector4
--- @field x number
--- @field y number
--- @field z number
--- @field w number
--- @field size number
--- @field sizeSquared number
--- @field type string
local Vector4Instance = {}
--- @return Vector4
function Vector4Instance:GetNormalized() end

--- @param typeName string
--- @return boolean
function Vector4Instance:IsA(typeName) end

--- @class GlobalVector4
Vector4 = {}
--- @param from Vector4
--- @param to Vector4
--- @param progress number
--- @return Vector4
function Vector4.Lerp(from, to, progress) end

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


--- @class Vehicle : CoreObject
--- @field driverEnteredEvent Event
--- @field driverExitedEvent Event
--- @field isAccelerating boolean
--- @field driver Player
--- @field mass number
--- @field maxSpeed number
--- @field accelerationRate number
--- @field brakeStrength number
--- @field coastBrakeStrength number
--- @field tireFriction number
--- @field gravityScale number
--- @field isDriverHidden boolean
--- @field isDriverAttached boolean
--- @field isBrakeEngaged boolean
--- @field isHandbrakeEngaged boolean
--- @field driverAnimationStance string
--- @field enterTrigger Trigger
--- @field camera Camera
--- @field type string
local VehicleInstance = {}
--- @return Vector3
function VehicleInstance:GetPhysicsBodyOffset() end

--- @return Vector3
function VehicleInstance:GetPhysicsBodyScale() end

--- @param driver Player
function VehicleInstance:SetDriver(driver) end

function VehicleInstance:RemoveDriver() end

--- @param impulse Vector3
function VehicleInstance:AddImpulse(impulse) end

--- @return Vector3
function VehicleInstance:GetDriverPosition() end

--- @return Rotation
function VehicleInstance:GetDriverRotation() end

--- @param typeName string
--- @return boolean
function VehicleInstance:IsA(typeName) end

--- @class GlobalVehicle : CoreObject
Vehicle = {}

--- @class Vfx : SmartObject
--- @field type string
local VfxInstance = {}
--- @overload fun()
--- @param optionalParameters table
function VfxInstance:Play(optionalParameters) end

--- @overload fun()
--- @param optionalParameters table
function VfxInstance:Stop(optionalParameters) end

--- @param typeName string
--- @return boolean
function VfxInstance:IsA(typeName) end

--- @class GlobalVfx : SmartObject
Vfx = {}

--- @class Weapon : Equipment
--- @field projectileSpawnedEvent Event
--- @field targetImpactedEvent Event
--- @field targetInteractionEvent Event
--- @field attackCooldownDuration number
--- @field animationStance string
--- @field multiShotCount number
--- @field burstCount number
--- @field shotsPerSecond number
--- @field shouldBurstStopOnRelease boolean
--- @field isHitscan boolean
--- @field range number
--- @field damage number
--- @field directDamage number
--- @field projectileTemplateId string
--- @field muzzleFlashTemplateId string
--- @field trailTemplateId string
--- @field beamTemplateId string
--- @field impactSurfaceTemplateId string
--- @field impactProjectileTemplateId string
--- @field impactPlayerTemplateId string
--- @field projectileSpeed number
--- @field projectileLifeSpan number
--- @field projectileGravity number
--- @field projectileLength number
--- @field projectileRadius number
--- @field projectileDrag number
--- @field projectileBounceCount number
--- @field projectilePierceCount number
--- @field maxAmmo number
--- @field currentAmmo number
--- @field ammoType string
--- @field isAmmoFinite boolean
--- @field outOfAmmoSoundId string
--- @field reloadSoundId string
--- @field spreadMin number
--- @field spreadMax number
--- @field spreadAperture number
--- @field spreadDecreaseSpeed number
--- @field spreadIncreasePerShot number
--- @field spreadPenaltyPerShot number
--- @field type string
local WeaponInstance = {}
--- @return boolean
function WeaponInstance:HasAmmo() end

--- @overload fun(targetObject: CoreObject)
--- @overload fun(targetWorldPosition: Vector3)
--- @overload fun()
--- @param targetPlayer Player
function WeaponInstance:Attack(targetPlayer) end

--- @param typeName string
--- @return boolean
function WeaponInstance:IsA(typeName) end

--- @class GlobalWeapon : Equipment
Weapon = {}

--- @class WorldText : CoreObject
--- @field text string
--- @field type string
local WorldTextInstance = {}
--- @return Color
function WorldTextInstance:GetColor() end

--- @param color Color
function WorldTextInstance:SetColor(color) end

--- @param font string
function WorldTextInstance:SetFont(font) end

--- @param typeName string
--- @return boolean
function WorldTextInstance:IsA(typeName) end

--- @class GlobalWorldText : CoreObject
WorldText = {}






--- @class Chat
local ChatInstance = {}
--- @class GlobalChat
Chat = {}
--- @overload fun(message: string): BroadcastMessageResultCode|string
--- @param message string
--- @param optionalParams table
--- @return BroadcastMessageResultCode|string
function Chat.BroadcastMessage(message, optionalParams) end

--- @overload fun(message: string)
--- @param message string
--- @param optionalParams table
function Chat.LocalMessage(message, optionalParams) end


--- @class CoreDebug
local CoreDebugInstance = {}
--- @class GlobalCoreDebug
CoreDebug = {}
--- @overload fun(startPosition: Vector3,endPosition: Vector3)
--- @param startPosition Vector3
--- @param endPosition Vector3
--- @param parameters table
function CoreDebug.DrawLine(startPosition, endPosition, parameters) end

--- @overload fun(centerPosition: Vector3,scale: Vector3)
--- @param centerPosition Vector3
--- @param scale Vector3
--- @param parameters table
function CoreDebug.DrawBox(centerPosition, scale, parameters) end

--- @overload fun(centerPosition: Vector3,radius: number)
--- @param centerPosition Vector3
--- @param radius number
--- @param parameters table
function CoreDebug.DrawSphere(centerPosition, radius, parameters) end

--- @return string
function CoreDebug.GetStackTrace() end

--- @overload fun(task: Task): string
--- @return string
function CoreDebug.GetTaskStackTrace() end


--- @class CoreMath
local CoreMathInstance = {}
--- @class GlobalCoreMath
CoreMath = {}
--- @overload fun(x: number): number
--- @param x number
--- @param decimals number
--- @return number
function CoreMath.Round(x, decimals) end

--- @overload fun(from: number,to: number): number
--- @param from number
--- @param to number
--- @param progress number
--- @return number
function CoreMath.Lerp(from, to, progress) end

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
--- @param gameId string
--- @return CoreGameInfo
function CorePlatform.GetGameInfo(gameId) end

--- @param collectionId string
--- @return table<number, CoreGameCollectionEntry>
function CorePlatform.GetGameCollection(collectionId) end

--- @param playerId string
--- @return CorePlayerProfile
function CorePlatform.GetPlayerProfile(playerId) end


--- @class CoreSocial
local CoreSocialInstance = {}
--- @class GlobalCoreSocial
CoreSocial = {}
--- @overload fun(player: Player): boolean
--- @param playerId string
--- @return boolean
function CoreSocial.IsFriendsWithLocalPlayer(playerId) end

--- @param player Player
--- @return CoreFriendCollection
function CoreSocial.GetFriends(player) end


--- @class CoreString
local CoreStringInstance = {}
--- @class GlobalCoreString
CoreString = {}
--- @overload fun(string: string): any
--- @overload fun(string: string,optionalParameters: table): any
--- @overload fun(string: string,delimiter: string): any
--- @param string string
--- @return any
function CoreString.Split(string) end

--- @overload fun(delimiter: string): string
--- @param delimiter string
--- @param strings any
--- @return string
function CoreString.Join(delimiter, strings) end

--- @overload fun(string: string): string
--- @param string string
--- @param trimmedStrings any
--- @return string
function CoreString.Trim(string, trimmedStrings) end


--- @class Environment
local EnvironmentInstance = {}
--- @class GlobalEnvironment
Environment = {}
--- @return boolean
function Environment.IsClient() end

--- @return boolean
function Environment.IsServer() end

--- @return boolean
function Environment.IsMultiplayerPreview() end

--- @return boolean
function Environment.IsSinglePlayerPreview() end

--- @return boolean
function Environment.IsPreview() end

--- @return boolean
function Environment.IsLocalGame() end

--- @return boolean
function Environment.IsHostedGame() end


--- @class Events
local EventsInstance = {}
--- @class GlobalEvents
Events = {}
--- @overload fun(eventName: string,listener: function): EventListener
--- @param eventName string
--- @param listener function
--- @param additionalParameters any
--- @return EventListener
function Events.Connect(eventName, listener, additionalParameters) end

--- @overload fun(eventName: string,listener: function): EventListener
--- @param eventName string
--- @param listener function
--- @param additionalParameters any
--- @return EventListener
function Events.ConnectForPlayer(eventName, listener, additionalParameters) end

--- @overload fun(eventName: string)
--- @param eventName string
--- @param argumentList any
function Events.Broadcast(eventName, argumentList) end

--- @overload fun(eventName: string): BroadcastEventResultCode|string
--- @param eventName string
--- @param argumentList any
--- @return BroadcastEventResultCode|string
function Events.BroadcastToServer(eventName, argumentList) end

--- @overload fun(eventName: string): BroadcastEventResultCode|string
--- @param eventName string
--- @param argumentList any
--- @return BroadcastEventResultCode|string
function Events.BroadcastToAllPlayers(eventName, argumentList) end

--- @overload fun(player: Player,eventName: string): BroadcastEventResultCode|string
--- @param player Player
--- @param eventName string
--- @param argumentList any
--- @return BroadcastEventResultCode|string
function Events.BroadcastToPlayer(player, eventName, argumentList) end


--- @class Game
local GameInstance = {}
--- @class GlobalGame
--- @field playerJoinedEvent Event
--- @field playerLeftEvent Event
--- @field abilitySpawnedEvent Event
--- @field roundStartEvent Event
--- @field roundEndEvent Event
--- @field teamScoreChangedEvent Event
Game = {}
--- @return Player
function Game.GetLocalPlayer() end

--- @param playerId string
--- @return Player
function Game.FindPlayer(playerId) end

--- @overload fun(): table<number, Player>
--- @param optionalParams table
--- @return table<number, Player>
function Game.GetPlayers(optionalParams) end

--- @overload fun(worldPosition: Vector3,radius: number): table<number, Player>
--- @param worldPosition Vector3
--- @param radius number
--- @param optionalParams table
--- @return table<number, Player>
function Game.FindPlayersInCylinder(worldPosition, radius, optionalParams) end

--- @overload fun(worldPosition: Vector3,radius: number): table<number, Player>
--- @param worldPosition Vector3
--- @param radius number
--- @param optionalParams table
--- @return table<number, Player>
function Game.FindPlayersInSphere(worldPosition, radius, optionalParams) end

--- @overload fun(worldPosition: Vector3): Player
--- @param worldPosition Vector3
--- @param optionalParameters table
--- @return Player
function Game.FindNearestPlayer(worldPosition, optionalParameters) end

function Game.StartRound() end

function Game.EndRound() end

--- @param team number
--- @return number
function Game.GetTeamScore(team) end

--- @param team number
--- @param score number
function Game.SetTeamScore(team, score) end

--- @param team number
--- @param scoreChange number
function Game.IncreaseTeamScore(team, scoreChange) end

--- @param team number
--- @param scoreChange number
function Game.DecreaseTeamScore(team, scoreChange) end

function Game.ResetTeamScores() end

function Game.StopAcceptingPlayers() end

--- @return boolean
function Game.IsAcceptingPlayers() end

--- @overload fun(gameInfo: CoreGameInfo)
--- @overload fun(gameId: string)
--- @param gameCollectionEntry CoreGameCollectionEntry
function Game.TransferAllPlayersToGame(gameCollectionEntry) end


--- @class Leaderboards
local LeaderboardsInstance = {}
--- @class GlobalLeaderboards
Leaderboards = {}
--- @param leaderboardReference NetReference
--- @param player Player
--- @param score number
--- @param additionalData string
function Leaderboards.SubmitPlayerScore(leaderboardReference, player, score, additionalData) end

--- @param leaderboardReference NetReference
--- @param leaderboardType LeaderboardType
--- @return table
function Leaderboards.GetLeaderboard(leaderboardReference, leaderboardType) end

--- @return boolean
function Leaderboards.HasLeaderboards() end


--- @class Storage
local StorageInstance = {}
--- @class GlobalStorage
Storage = {}
--- @param data table
--- @return number
function Storage.SizeOfData(data) end

--- @param player Player
--- @return table
function Storage.GetPlayerData(player) end

--- @param player Player
--- @param data table
--- @return StorageResultCode|string
function Storage.SetPlayerData(player, data) end

--- @param sharedStorageKey NetReference
--- @param player Player
--- @return table
function Storage.GetSharedPlayerData(sharedStorageKey, player) end

--- @param sharedStorageKey NetReference
--- @param player Player
--- @param data table
--- @return StorageResultCode|string
function Storage.SetSharedPlayerData(sharedStorageKey, player, data) end

--- @param playerId string
--- @return table
function Storage.GetOfflinePlayerData(playerId) end

--- @param sharedStorageKey NetReference
--- @param playerId string
--- @return table
function Storage.GetSharedOfflinePlayerData(sharedStorageKey, playerId) end


--- @class Teams
local TeamsInstance = {}
--- @class GlobalTeams
Teams = {}
--- @param team1 number
--- @param team2 number
--- @return boolean
function Teams.AreTeamsFriendly(team1, team2) end

--- @param team1 number
--- @param team2 number
--- @return boolean
function Teams.AreTeamsEnemies(team1, team2) end


--- @class UI
local UIInstance = {}
--- @class GlobalUI
--- @field coreModalChangedEvent Event
UI = {}
--- @overload fun(text: string,worldPosition: Vector3)
--- @param text string
--- @param worldPosition Vector3
--- @param optionalParameters table
function UI.ShowFlyUpText(text, worldPosition, optionalParameters) end

--- @overload fun(sourcePlayer: Player)
--- @overload fun(sourceWorldPosition: Vector3)
--- @param sourceObject CoreObject
function UI.ShowDamageDirection(sourceObject) end

--- @param worldPosition Vector3
--- @return Vector2
function UI.GetScreenPosition(worldPosition) end

--- @return Vector2
function UI.GetScreenSize() end

--- @overload fun(message: string)
--- @param message string
--- @param color Color
function UI.PrintToScreen(message, color) end

--- @return Vector2
function UI.GetCursorPosition() end

--- @return HitResult
function UI.GetCursorHitResult() end

--- @overload fun(pointOnPlane: Vector3): Vector3
--- @param pointOnPlane Vector3
--- @param planeNormal Vector3
--- @return Vector3
function UI.GetCursorPlaneIntersection(pointOnPlane, planeNormal) end

--- @return boolean
function UI.IsCursorVisible() end

--- @param isVisible boolean
function UI.SetCursorVisible(isVisible) end

--- @return boolean
function UI.IsCursorLockedToViewport() end

--- @param isLocked boolean
function UI.SetCursorLockedToViewport(isLocked) end

--- @return boolean
function UI.CanCursorInteractWithUI() end

--- @param canInteract boolean
function UI.SetCanCursorInteractWithUI(canInteract) end

--- @return boolean
function UI.IsReticleVisible() end

--- @param isVisible boolean
function UI.SetReticleVisible(isVisible) end

--- @overload fun(isVisible: boolean)
--- @param isVisible boolean
--- @param currentTab RewardsDialogTab
function UI.SetRewardsDialogVisible(isVisible, currentTab) end

--- @return boolean
function UI.IsRewardsDialogVisible() end


--- @class World
local WorldInstance = {}
--- @class GlobalWorld
World = {}
--- @return CoreObject
function World.GetRootObject() end

--- @param id string
--- @return CoreObject
function World.FindObjectById(id) end

--- @param name string
--- @return CoreObject
function World.FindObjectByName(name) end

--- @param name string
--- @return table<number, CoreObject>
function World.FindObjectsByName(name) end

--- @param typeName string
--- @return table<number, CoreObject>
function World.FindObjectsByType(typeName) end

--- @overload fun(assetId: string): CoreObject
--- @param assetId string
--- @param optionalParameters table
--- @return CoreObject
function World.SpawnAsset(assetId, optionalParameters) end

--- @overload fun(startPosition: Vector3,endPosition: Vector3): HitResult
--- @param startPosition Vector3
--- @param endPosition Vector3
--- @param optionalParameters table
--- @return HitResult
function World.Raycast(startPosition, endPosition, optionalParameters) end







--- @alias AbilityFacingMode 0 | 1 | 2
AbilityFacingMode = {
    NONE = 0,
    MOVEMENT = 1,
    AIM = 2,
}
--- @alias AbilityPhase 0 | 1 | 2 | 3 | 4
AbilityPhase = {
    READY = 0,
    CAST = 1,
    EXECUTE = 2,
    RECOVERY = 3,
    COOLDOWN = 4,
}
--- @alias BroadcastEventResultCode 0 | 1 | 2 | 3 | 4
BroadcastEventResultCode = {
    SUCCESS = 0,
    FAILURE = 1,
    EXCEEDED_SIZE_LIMIT = 2,
    EXCEEDED_RATE_WARNING_LIMIT = 3,
    EXCEEDED_RATE_LIMIT = 4,
}
--- @alias BroadcastMessageResultCode 0 | 1 | 2 | 3 | 4
BroadcastMessageResultCode = {
    SUCCESS = 0,
    FAILURE = 1,
    EXCEEDED_SIZE_LIMIT = 2,
    EXCEEDED_RATE_WARNING_LIMIT = 3,
    EXCEEDED_RATE_LIMIT = 4,
}
--- @alias Collision 0 | 1 | 2
Collision = {
    INHERIT = 0,
    FORCE_ON = 1,
    FORCE_OFF = 2,
}
--- @alias CoreModalType 1 | 2 | 3 | 4 | 6
CoreModalType = {
    PAUSE_MENU = 1,
    CHARACTER_PICKER = 2,
    MOUNT_PICKER = 3,
    EMOTE_PICKER = 4,
    SOCIAL_MENU = 6,
}
--- @alias CurveExtrapolation 0 | 1 | 2 | 3 | 4
CurveExtrapolation = {
    CYCLE = 0,
    CYCLE_WITH_OFFSET = 1,
    OSCILLATE = 2,
    LINEAR = 3,
    CONSTANT = 4,
}
--- @alias CurveInterpolation 0 | 1 | 2
CurveInterpolation = {
    LINEAR = 0,
    CONSTANT = 1,
    CUBIC = 2,
}
--- @alias DamageReason 0 | 1 | 2 | 3 | 4
DamageReason = {
    UNKNOWN = 0,
    COMBAT = 1,
    FRIENDLY_FIRE = 2,
    MAP = 3,
    NPC = 4,
}
--- @alias FacingMode 0 | 1 | 2
FacingMode = {
    FACE_AIM_WHEN_ACTIVE = 0,
    FACE_AIM_ALWAYS = 1,
    FACE_MOVEMENT = 2,
}
--- @alias ImageTileType 0 | 1 | 2 | 3
ImageTileType = {
    NONE = 0,
    HORIZONTAL = 1,
    VERTICAL = 2,
    BOTH = 3,
}
--- @alias LeaderboardType 0 | 1 | 2 | 3
LeaderboardType = {
    GLOBAL = 0,
    DAILY = 1,
    WEEKLY = 2,
    MONTHLY = 3,
}
--- @alias LookControlMode 0 | 1 | 2
LookControlMode = {
    NONE = 0,
    RELATIVE = 1,
    LOOK_AT_CURSOR = 2,
}
--- @alias MovementControlMode 0 | 1 | 2 | 3 | 4
MovementControlMode = {
    NONE = 0,
    LOOK_RELATIVE = 1,
    VIEW_RELATIVE = 2,
    FACING_RELATIVE = 3,
    FIXED_AXES = 4,
}
--- @alias MovementMode 0 | 1 | 3 | 4 | 5 | 6
MovementMode = {
    NONE = 0,
    WALKING = 1,
    FALLING = 3,
    SWIMMING = 4,
    FLYING = 5,
    SLIDING = 6,
}
--- @alias NetReferenceType 1 | 2 | 3 | 0
NetReferenceType = {
    LEADERBOARD = 1,
    SHARED_STORAGE = 2,
    CREATOR_PERK = 3,
    UNKNOWN = 0,
}
--- @alias Orientation 0 | 1
Orientation = {
    HORIZONTAL = 0,
    VERTICAL = 1,
}
--- @alias PlayerTransferReason 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8
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
}
--- @alias PrivateNetworkedDataResultCode 0 | 1 | 2
PrivateNetworkedDataResultCode = {
    SUCCESS = 0,
    FAILURE = 1,
    EXCEEDED_SIZE_LIMIT = 2,
}
--- @alias ProgressBarFillType 0 | 1 | 3 | 4 | 2
ProgressBarFillType = {
    LEFT_TO_RIGHT = 0,
    RIGHT_TO_LEFT = 1,
    TOP_TO_BOTTOM = 3,
    BOTTOM_TO_TOP = 4,
    FROM_CENTER = 2,
}
--- @alias RespawnMode 0 | 1 | 2 | 3 | 4 | 5 | 6
RespawnMode = {
    NONE = 0,
    IN_PLACE = 1,
    ROUND_ROBIN = 2,
    AT_CLOSEST_SPAWN_POINT = 3,
    FARTHEST_FROM_OTHER_PLAYERS = 4,
    FARTHEST_FROM_ENEMY = 5,
    RANDOM = 6,
}
--- @alias RewardsDialogTab 1 | 2
RewardsDialogTab = {
    QUESTS = 1,
    GAMES = 2,
}
--- @alias RotationMode 0 | 1 | 2
RotationMode = {
    CAMERA = 0,
    NONE = 1,
    LOOK_ANGLE = 2,
}
--- @alias SpawnMode 0 | 1 | 2 | 3
SpawnMode = {
    RANDOM = 0,
    ROUND_ROBIN = 1,
    FARTHEST_FROM_OTHER_PLAYERS = 2,
    FARTHEST_FROM_ENEMY = 3,
}
--- @alias StorageResultCode 0 | 2 | 1 | 3
StorageResultCode = {
    SUCCESS = 0,
    FAILURE = 2,
    STORAGE_DISABLED = 1,
    EXCEEDED_SIZE_LIMIT = 3,
}
--- @alias TaskStatus 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7
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
--- @alias TextJustify 0 | 1 | 2
TextJustify = {
    LEFT = 0,
    CENTER = 1,
    RIGHT = 2,
}
--- @alias UIPivot 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
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
--- @alias Visibility 0 | 1 | 2
Visibility = {
    INHERIT = 0,
    FORCE_ON = 1,
    FORCE_OFF = 2,
}
--- @type CoreObject
script = nil

--- @return number
function time() end

--- @param deltaTime number
function Tick(deltaTime) end

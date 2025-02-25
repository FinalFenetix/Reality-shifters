extends CharacterBody2D

var timerWait = 1
var canRegen = 0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var AbilityCount = 3
@onready var timer: Timer = $JumpCooldown
@onready var JumpUI: AnimatedSprite2D = $jumpUI
@onready var StaminaBar: TextureProgressBar = $TextureProgressBar
@onready var progress_bar_cooldown: Timer = $progressBarCooldown
@onready var increase_progress_bar: Timer = $increaseProgressBar
var StaminaCanRegen = 0
var StaminaTimerWait = 1

func _ready() -> void:
	StaminaBar.value = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		canRegen = 0
		StaminaCanRegen = 0
	
	else:
		if AbilityCount == 0:
			AbilityCount += 1
			
		if timerWait == 1 and AbilityCount < 3:
			timerStart()
		canRegen = 1
		
		if StaminaTimerWait == 1 and StaminaBar.value < 100:
			StaminaTimerStart()
		StaminaCanRegen = 1

	# Handle jump.
	if Input.is_action_just_pressed("up") and AbilityCount > 0:
		AbilityCount -= 1
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction and Input.is_action_just_pressed("dash") and StaminaBar.value > 33:
		StaminaBar.value -= 30
		velocity.x = direction * SPEED * 20
	
	move_and_slide()
	
	if AbilityCount == 3:
		JumpUI.play("fullWhite")
	
	if AbilityCount == 2:
		JumpUI.play("2leftWhite")
	
	if AbilityCount == 1:
		JumpUI.play("1leftWhite")
		
	if AbilityCount == 0:
		JumpUI.play("emptyWhite")

func timerStart():
	timerWait = 0
	if is_on_floor():
		timer.start()
		await timer.timeout
	timerWait = 1

func StaminaTimerStart():
	StaminaTimerWait = 0
	if is_on_floor():
		progress_bar_cooldown.start()
		await timer.timeout
	StaminaTimerWait = 1

func _on_timer_timeout() -> void:
	if canRegen == 1:
		AbilityCount += 1


func _on_progress_bar_cooldown_timeout() -> void: #ProgressBarCooldown
	if StaminaCanRegen == 1:
		while not StaminaBar.value > 99:
			increase_progress_bar.start()
			await increase_progress_bar.timeout




func _on_increase_progress_bar_timeout() -> void:
	StaminaBar.value += 5

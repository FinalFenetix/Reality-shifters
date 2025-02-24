extends CharacterBody2D

var timerWait = 1
var canRegen = 0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var AbilityCount = 3
@onready var timer: Timer = $Timer
@onready var JumpUI: AnimatedSprite2D = $jumpUI


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		canRegen = 0
	
	else:
		if AbilityCount == 0:
			AbilityCount += 1
			
		if timerWait == 1 and AbilityCount < 3:
			timerStart()
		canRegen = 1

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


func _on_timer_timeout() -> void:
	if canRegen == 1:
		AbilityCount += 1

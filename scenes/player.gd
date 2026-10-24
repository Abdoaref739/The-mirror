extends CharacterBody2D
@onready var label: Label = $"../text show area/click to read"
@onready var clue_text: Label = $"../text show area/clue text"

const SPEED = 190.0
const JUMP_VELOCITY = -250.0

func _ready() -> void:
	label.hide()
	clue_text.hide()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = false # Face right
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = true # Face left
	move_and_slide()


func _on_text_show_area_body_entered(body: Node2D) -> void:
	label.show()


func _on_text_show_area_body_exited(body: Node2D) -> void:
	label.hide()
	
	if  Input.is_action_pressed("ui_accept"):
		clue_text.show()
		label.hide()
	else:
		clue_text.hide()

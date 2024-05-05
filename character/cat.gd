extends CharacterBody2D

@export var speed = 200
@export var state: String = "null"
@onready var state_machine = $AnimationTree.get("parameters/playback")

var dialogue_state : String = "null"

func _physics_process(_delta):
	move_and_slide()
	
func _ready():
	$AnimationTree.active = true
	$AnimationTree.set("parameters/Idle/blend_position", Vector2.UP)
	dialogue_state = get_node("/root/Main/Area2D/dialogue_box").state

func _process(delta=0.1):
	dialogue_state = get_node("/root/Main/Area2D/dialogue_box").state
	if(dialogue_state == "can_move"):
		var inputV2 = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("ui_right"):
			inputV2.x += 1
		if Input.is_action_pressed("ui_left"):
			inputV2.x -= 1
		if Input.is_action_pressed("ui_down"):
			inputV2.y += 1
		if Input.is_action_pressed("ui_up"):
			inputV2.y -= 1
		inputV2 = inputV2.normalized()
		if inputV2.length() > 0:
			position += inputV2 * delta * speed
			$AnimationTree.set("parameters/Idle/blend_position", inputV2)
			$AnimationTree.set("parameters/Walk/blend_position", inputV2)
			state_machine.travel("Walk")
		else:
			state_machine.travel("Idle")
	else:
		state_machine.travel("Idle")

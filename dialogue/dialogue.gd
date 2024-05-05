extends Control

@export var activate: bool = false
@export var current: int = 0
@export var state: String = "can_move"
var content = ["第一句", "第二句", "第三句"]
var dialogue_box_position = Vector2(0, 0)

func _ready():
	visible = false

func show_dialogue(txt):
	state = "dialogue_start"
	dialogue_box_position = relative_position(get_cat_position())
	$RichTextLabel.text = txt
	$RichTextLabel.position = dialogue_box_position
	$ColorRect.position = dialogue_box_position

func _unhandled_input(event):
	if(activate):
		if event.is_action_pressed("ui_accept"):
			if(current < content.size()):
				visible = true
				show_dialogue(content[current])
				current = current + 1
			else:
				visible = false
				state = "can_move"
			get_viewport().set_input_as_handled()
			
func get_cat_position():
	var player_vars = get_node("/root/Main/cat")
	var position = player_vars.position
	return position
	
func relative_position(position: Vector2):
	position[0] = position[0] - 175
	position[1] = position[1] + 100
	return position
	

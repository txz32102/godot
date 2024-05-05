extends Area2D

var activate = false
var dialogue_node = null

func _ready():
	dialogue_node = get_node("dialogue_box")

func _process(delta):
	if activate == true:
		$dialogue_box.visible = activate
	pass
	
func _on_area_entered(area):
	$dialogue_box.activate = true
	$indicator.visible = false

func _on_area_exited(area):
	print("exited")
	activate = false
	$dialogue_box.visible = activate
	$indicator.visible = true
	$dialogue_box.current = 0

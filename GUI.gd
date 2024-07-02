extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	$HPLabel.text = str("HP:" + str($"Player/HP".HP) + "\n" + "Shield:" + str($"Player/HP".SHIELD))
	$AMMOLabel.text = str(str($"Player/TwistPivot/PitchPivot/Gun Component".num_bullets) + "/" + str($"Player/TwistPivot/PitchPivot/Gun Component".additional_bullets))

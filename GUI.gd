extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$HPLabel.text = str("HP:" + str($"HP".HP) + "\n" + "Shield:" + str($"HP".SHIELD))

@rpc("any_peer")
func update_health():
	$HPLabel.text = str("HP:" + str($"HP".HP) + "\n" + "Shield:" + str($"HP".SHIELD))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_health.rpc()
		
	#$AMMOLabel.text = str(str($"TwistPivot/PitchPivot/Gun Component".num_bullets) + "/" + str($"TwistPivot/PitchPivot/Gun Component".additional_bullets))
	$IPLabel.text = str("Your IP: " + str(IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),1)))

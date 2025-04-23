extends Panel

var ability_list

func set_ability_list():
	for each_branch in get_children():
		var branch = []
		for upgrade in each_branch.get_children():
			branch.append(upgrade.enabled)
		ability_list.append(branch)
 
	SaveData.ability_list = ability_list
	SaveData.set_and_save()

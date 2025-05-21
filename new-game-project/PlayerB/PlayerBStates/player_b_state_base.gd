class_name PlayerBStateBase extends StateBase

var playerb : PlayerB :
	set (value):
		controlled_node = value
	get:
		return controlled_node

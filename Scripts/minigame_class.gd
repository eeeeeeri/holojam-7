class_name Minigame extends Node2D

var scene_file: String
var title: String
var description: String
var won: bool
var played: bool

static func minigame(scene_file: String, title: String, description: String) -> Minigame:
	var new_minigame := Minigame.new()
	new_minigame.scene_file = scene_file
	new_minigame.title = title
	new_minigame.description = description
	return new_minigame

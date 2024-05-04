extends Node2D

var lives = 3
var score = 0

var game_over_scene = preload("res://scenes/game_over_screen.tscn")

#this is creating a reference to the player
@onready var player = $Player
@onready var hud = $UI/HUD
@onready var ui = $UI
@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_hit_sound = $PlayerHitSound

func _ready():
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_death_zone_area_entered(area):
	area.queue_free()


func _on_player_took_damage():
	lives -= 1
	hud.set_lives(lives)
	player_hit_sound.play()
	if lives == 0:
		print("Game over!")
		player.die()
		
		await get_tree().create_timer(1).timeout
		
		var game_over_instance = game_over_scene.instantiate()
		game_over_instance.set_score(score)
		ui.add_child(game_over_instance)


func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	
	add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()

func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)

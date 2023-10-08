extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimatedSprite2D")
var player
var direction
var attacking = false
var directionx = 0
const SPEED = 200
var charge = 0
const CHARGE_MAX = 100
const JUMP_VELOCITY = -300
var animation = "Idle"
var alive = true

func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_slide()
	if alive:
		animation = "Idle"
		if attacking:
			animation = "PreJump"
			charge += 1
		if charge >= CHARGE_MAX:
			velocity.y = JUMP_VELOCITY * abs((player.position.x - position.x) * 0.01)
			charge = 0
		if !is_on_floor():
			velocity.x = SPEED * directionx
		else:
			velocity.x = 0
			
		if velocity.y < 0:
			animation = "Jump"
		if alive:
			anim.play(animation)

func _ready():
	anim.play("Idle")
	player = get_node("../../player")

func _on_player_detector_body_entered(body):
	if body.name == "player":
		attacking = true
		direction = (player.position - position).normalized()
		if direction.x > 0:
			directionx = 1
		elif direction.x < 0:
			directionx = -1


func _on_player_detector_body_exited(body):
	if body.name == "player":
		attacking = false


func _on_hit_detector_body_entered(body):
	if body.name == "player":
		kill()


func _on_player_killer_body_entered(body):
	if body.name == "player":
		get_node("../../player").damage(3)
		kill()
		
func kill():
	alive = false
	anim.play("Death")
	Game.playerGold += 5
	gravity = 0
	velocity.x = 0
	get_node("player killer/CollisionShape2D").scale.x = 0
	await anim.animation_finished
	queue_free()

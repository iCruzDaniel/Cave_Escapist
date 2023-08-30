extends KinematicBody2D

var velocity = Vector2(0,0)
var SPEED = 200 ##175
const GRAVITY = 10
const JUMPFORCE = -350

var v0 = (velocity.y)

# Ejecuta como un bucle todo lo que tenga dentro del nodo
func _physics_process(delta):
	
	if is_on_floor():
		#SPEED = 175

		if Input.is_action_pressed("walk_left") or Input.is_action_pressed("walk_right"):
			if Input.is_action_pressed("walk_left"):
				velocity.x = -SPEED
				$AnimatedSprite.play("Walk") 
				# Para doblar el Sprite nos vamos a la propiedad "flip_"
				$AnimatedSprite.flip_h = true
					
			if Input.is_action_pressed("walk_right"):
				velocity.x = SPEED
				$AnimatedSprite.play("Walk")
				# Para doblar el Sprite nos vamos a la propiedad "flip_"
				$AnimatedSprite.flip_h = false	
						
		else:
			if Input.is_action_just_pressed("attack"):
				$AnimatedSprite.stop()
				$AnimatedSprite.play("Attack")
				#if animation_finishe() in get_signal_list():
				#	$AnimatedSprite.play("Iddle")

			else: 
				$AnimatedSprite.play("Iddle")

		if Input.is_action_just_pressed("jump") and is_on_floor():
			#trasladamos en Y
			velocity.y = JUMPFORCE 
			
	else:
		#SPEED = 250
		print(velocity)
		print(v0)
		
		if abs(v0) > abs(velocity.y):
			$AnimatedSprite.play("Jump")
		else:
			$AnimatedSprite.play("Fall")
		
		if Input.is_action_pressed("walk_left"):
			velocity.x = -SPEED
			$AnimatedSprite.flip_h = true
			
		if Input.is_action_pressed("walk_right"):
			velocity.x = SPEED
			$AnimatedSprite.flip_h = false

	v0 = (velocity.y)
	velocity.y += GRAVITY
	
	# El vector.UP le da como referencia en que parte se encunetra el suelo
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.18)

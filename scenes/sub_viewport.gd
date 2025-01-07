extends SubViewport


func _ready():
	# Create a SubViewport to capture layer 9
	var viewport = SubViewport.new()
	viewport.transparent_bg = true
	viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
	
	# Create the shader material
	var material = ShaderMaterial.new()
	material.shader = preload("res://shader/shadow.gdshader")
	
	# Pass the viewport texture to the shader
	material.set_shader_parameter("viewport_texture", viewport.get_texture())
	
	# Apply material to your sprite/node
	$blocks.material = material

extends Node

onready  var fallback_font = load("res://fonts/sarasa-mono-slab-cl-regular.ttf")
onready  var fallback_japanese = load("res://fonts/NotoSansJP-Regular.otf")
onready  var fallback_simplified_chinese = load("res://fonts/NotoSansSC-Regular.otf")
onready  var fallback_traditional_chinese = load("res://fonts/NotoSansTC-Regular.otf")

func pos_to_vec(pos):
	return Vector2(pos[0] * 20, pos[1] * 20)

func set_fallback_fonts(node):
	
	
	
	for child in node.get_children():
		set_fallback_fonts(child)
		if child is Button:
			var font = child.get_font("font")
			if font is DynamicFont:
				while font.get_fallback_count() > 0:
					font.remove_fallback(0)
				font.add_fallback(fallback_font)
		
		elif child is LineEdit:
			var font = child.get_font("font")
			if font is DynamicFont:
				while font.get_fallback_count() > 0:
					font.remove_fallback(0)
				font.add_fallback(fallback_font)

		elif child is Label:
			var font = child.get_font("font")
			if font is DynamicFont:
				while font.get_fallback_count() > 0:
					font.remove_fallback(0)
				font.add_fallback(fallback_font)
		
		elif child is RichTextLabel:
			var font = child.get_font("normal_font")
			if font is DynamicFont:
				while font.get_fallback_count() > 0:
					font.remove_fallback(0)
				font.add_fallback(fallback_font)
			font = child.get_font("bold_font")
			if font is DynamicFont:
				while font.get_fallback_count() > 0:
					font.remove_fallback(0)
				font.add_fallback(fallback_font)
			font = child.get_font("italics_font")
			if font is DynamicFont:
				while font.get_fallback_count() > 0:
					font.remove_fallback(0)
				font.add_fallback(fallback_font)
			font = child.get_font("mono_font")
			if font is DynamicFont:
				while font.get_fallback_count() > 0:
					font.remove_fallback(0)
				font.add_fallback(fallback_font)

func _ready():
	if g.language_file != "":
		if g.language_file == "translations/Japanese.txt":
			fallback_font = fallback_japanese
		elif g.language_file == "translations/Chinese (Simplified).txt":
			fallback_font = fallback_simplified_chinese
		elif g.language_file == "translations/Chinese (Traditional).txt":
			fallback_font = fallback_traditional_chinese

		
		set_fallback_fonts(get_node("/root"))
	
	
	for c in get_node("/root/level/component_panels").get_children():
		if c.name != "hide_panel":
			c.visible = false

	for c in get_node("/root/level/levels").get_children():
		c.visible = false

	get_node("/root/level/title_screen/background").visible = true
	
	if g.SHOW_MOUSE_POS:
		get_node("/root/level/camera/mouse_pos").visible = true
	
	g.rpg = get_node("/root/level/dialogue/program_edit/ide/rpg_screen/viewport/rpg")
	
	for sound in get_node("/root/level/sounds").get_children():
		g.sounds[sound.name] = sound
	for note in get_node("/root/level/musical_notes").get_children():
		g.musical_notes[int(note.name)] = note
			
	g.pin_textures["in_off_1"] = load("res://atlas/pin_in_off_1.png")
	g.pin_textures["in_off_8"] = load("res://atlas/pin_in_off_8.png")
	g.pin_textures["in_off_16"] = load("res://atlas/pin_in_off_16.png")
	g.pin_textures["in_off_32"] = load("res://atlas/pin_in_off_32.png")
	g.pin_textures["in_off_64"] = load("res://atlas/pin_in_off_64.png")
	g.pin_textures["out_off_1"] = load("res://atlas/pin_out_off_1.png")
	g.pin_textures["out_off_8"] = load("res://atlas/pin_out_off_8.png")
	g.pin_textures["out_off_16"] = load("res://atlas/pin_out_off_16.png")
	g.pin_textures["out_off_32"] = load("res://atlas/pin_out_off_32.png")
	g.pin_textures["out_off_64"] = load("res://atlas/pin_out_off_64.png")
	g.pin_textures["out_z_1"] = load("res://atlas/pin_out_z_1.png")
	g.pin_textures["out_z_8"] = load("res://atlas/pin_out_z_8.png")
	g.pin_textures["out_z_16"] = load("res://atlas/pin_out_z_16.png")
	g.pin_textures["out_z_32"] = load("res://atlas/pin_out_z_32.png")
	g.pin_textures["out_z_64"] = load("res://atlas/pin_out_z_64.png")
	g.pin_textures["on_1"] = load("res://atlas/pin_on_1.png")
	g.pin_textures["on_8"] = load("res://atlas/pin_on_8.png")
	g.pin_textures["on_16"] = load("res://atlas/pin_on_16.png")
	g.pin_textures["on_32"] = load("res://atlas/pin_on_32.png")
	g.pin_textures["on_64"] = load("res://atlas/pin_on_64.png")
	g.pin_textures["late_1"] = load("res://atlas/pin_late_1.png")
	g.pin_textures["late_8"] = load("res://atlas/pin_late_8.png")
	g.pin_textures["late_16"] = load("res://atlas/pin_late_16.png")
	g.pin_textures["late_32"] = load("res://atlas/pin_late_32.png")
	g.pin_textures["late_64"] = load("res://atlas/pin_late_64.png")
	g.pin_textures["bi_1"] = load("res://atlas/pin_bi_1.png")
	g.pin_textures["bi_8"] = load("res://atlas/pin_bi_8.png")
	g.pin_textures["bi_16"] = load("res://atlas/pin_bi_16.png")
	g.pin_textures["bi_32"] = load("res://atlas/pin_bi_32.png")
	g.pin_textures["bi_64"] = load("res://atlas/pin_bi_64.png")

	g.pin_textures[g.BIT] = []
	g.pin_textures[g.BYTE] = []
	g.pin_textures[g.WORD] = []
	g.pin_textures[g.DWORD] = []
	g.pin_textures[g.QWORD] = []

	g.pin_textures[g.BIT].append(load("res://atlas/head_1_0.png"))
	g.pin_textures[g.BYTE].append(load("res://atlas/head_byte.png"))
	g.pin_textures[g.WORD].append(load("res://atlas/head_word.png"))
	g.pin_textures[g.DWORD].append(load("res://atlas/head_dword.png"))
	g.pin_textures[g.QWORD].append(load("res://atlas/head_qword.png"))

	for i in range(1, 12):
		g.pin_textures[g.BIT].append(load("res://atlas/head_1_" + str(i) + ".png"))
		g.pin_textures[g.BYTE].append(load("res://atlas/head_" + str(i) + ".png"))
		g.pin_textures[g.WORD].append(load("res://atlas/head_" + str(i) + ".png"))
		g.pin_textures[g.DWORD].append(load("res://atlas/head_" + str(i) + ".png"))
		g.pin_textures[g.QWORD].append(load("res://atlas/head_" + str(i) + ".png"))

	g.pin_textures["error_head"] = load("res://atlas/error_head.png")
	g.pin_textures["background"] = load("res://atlas/wire_head_bg.png")

	for level in get_node("/root/level/levels").get_children():
		g.levels[level.name] = level
		
		g.levels[level.name] = level
		g.levels[level.name].size = backend.get_level_size(level.name)
	
	
	
	if not backend.get_progress_bool("window_mode"):
		var timer = Timer.new()
		add_child(timer)
		timer.connect("timeout", self, "full_screen_delay")
		timer.set_wait_time(0.5)
		timer.set_one_shot(true)
		timer.start()
	
	var volume = backend.get_progress_int("setting_effects_volume")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sound_effects"), volume - 50)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("sound_effects"), volume == 0)
	g.wire_animation_speed = backend.get_progress_int("setting_wire_animation_speed") / 50.0
	
	get_node("/root/level/dialogue/program_edit/ide/editor/editor").get("custom_fonts/font").set_size(g.settings_editor_code_size)
	get_node("/root/level/dialogue/program_edit/ide/editor/line_number").get("custom_fonts/font").set_size(g.settings_editor_code_size)
		
	var level_data = backend.get_level_data()
	for level_id in level_data:
		for unclocked_component in level_data[level_id].unlocks_components:
			assert (get_node("/root/level/prototypes/" + unclocked_component + "/delay") != null, "Missing delay label for component " + unclocked_component)
	
	var prototype_data = backend.get_prototype_data()
	for prototype_name in prototype_data:
		get_node("/root/level/prototypes/" + prototype_name).area = prototype_data[prototype_name].area
		get_node("/root/level/prototypes/" + prototype_name).input_pins = prototype_data[prototype_name].input_pins
		get_node("/root/level/prototypes/" + prototype_name).output_pins = prototype_data[prototype_name].output_pins
		get_node("/root/level/prototypes/" + prototype_name).immutable = prototype_data[prototype_name].immutable
		
		var prototype = get_node("/root/level/prototypes/" + prototype_name)
		
		prototype.category = prototype_data[prototype_name].category
		
		if prototype.get_node_or_null("bit_width") != null:
			prototype.get_node("bit_width").visible = backend.is_complete("test_lab")
		
		var pin_container = Node2D.new()
		pin_container.name = "pins"
		pin_container.show_behind_parent = true
		
		g.prototypes[prototype_name] = prototype

		for pin in prototype.input_pins:
			var pin_sprite = Sprite.new()

			var kind
			
			if pin.late:
				kind = "late_"
			else :
					kind = "in_off_"
				
			kind = kind + ["1", "8", "16", "32", "64"][pin["kind"]]

			pin_sprite.texture = g.pin_textures[kind]

			pin_sprite.position = pos_to_vec(pin["position"])
			pin_sprite.z_index = - 1
			pin_container.add_child(pin_sprite)
	
		for pin in prototype.output_pins:
			var pin_sprite = Sprite.new()

			var kind = "out_off_"
			
			if pin.z_state:
				kind = "out_z_"
			
			kind = kind + ["1", "8", "16", "32", "64"][pin["kind"]]

			pin_sprite.texture = g.pin_textures[kind]

			pin_sprite.position = pos_to_vec(pin["position"])
			pin_sprite.z_index = - 1
			pin_container.add_child(pin_sprite)

		prototype.add_child(pin_container)
		prototype.move_child(pin_container, 0)
	
	var prototypes = len(get_node("/root/level/prototypes").get_children())
	for i in range(0, prototypes):
		var prototype = get_node("/root/level/prototypes").get_child(prototypes - i - 1)
		if prototype.category == "":continue

		var paths = [prototype.category]
		if prototype.category.find("/") != - 1:
			var parts = prototype.category.split("/")
			paths.append(parts[0])
			
		for path in paths:
			
			if get_node_or_null("/root/level/component_panels/" + prototype.name + "/schematic") != null:
				var comp_copy = prototype.duplicate()
				comp_copy.visible = true
				comp_copy.position += Vector2(128, 23)
				get_node("/root/level/component_panels/" + prototype.name + "/schematic").add_child(comp_copy)

	for prototype in get_node("/root/level/prototypes").get_children():
		prototype.visible = false

	var name_node = get_node("/root/level/component_panels/name")
	var hide_node = get_node("/root/level/camera/ui/background/bottom_bar/position/box/hide")
	for panel in get_node("/root/level/component_panels").get_children():
		if not panel.name in g.prototypes:continue
		var new_name = name_node.duplicate()
		new_name.visible = true
		new_name.set_bbcode("[center]" + g.prototypes[panel.name].label + "[/center]")
		panel.add_child(new_name)
		var new_hide = hide_node.duplicate()
		new_hide.visible = true
		panel.add_child(new_hide)

	for comp_name in backend.get_custom_components():
		f.reload_custom_component(comp_name)
		
	
	g.clock_speed = backend.get_progress_int("clock_speed")
	f.update_herts_button()

	if backend.needs_savescan():
		backend.save_update()
		for comp_name in backend.get_custom_components():
			f.reload_custom_component(comp_name)

	var modloader_success = ProjectSettings.load_resource_pack("res://TCModLoader.pck")

	if modloader_success:
		var loaderMain = load("res://TCModLoader/Main.gdc")
		var loaderNode = Node.new()
		loaderNode.set_script(loaderMain)
		get_tree().get_root().call_deferred("add_child", loaderNode)
	else:
		push_warning("TCModloader failed to load")
	
func full_screen_delay():
	OS.window_fullscreen = true
	get_node("/root/level/main").resize()




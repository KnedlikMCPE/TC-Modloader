extends Node

onready var fallback_font = load("res://fonts/sarasa-mono-slab-cl-regular.ttf")
onready var fallback_japanese = load("res://fonts/NotoSansJP-Regular.otf")
onready var fallback_simplified_chinese = load("res://fonts/NotoSansSC-Regular.otf")
onready var fallback_traditional_chinese = load("res://fonts/NotoSansTC-Regular.otf")
onready var translations = get_node("/root/level/translations")

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
				if g.language_file == "Japanese":
						g.translation_wide_font = true
						translations.number_format = translations.NUMBERS_JAPANESE
						fallback_font = fallback_japanese

				elif g.language_file == "Chinese (Simplified)":
						g.translation_wide_font = true
						translations.number_format = translations.NUMBERS_CHINESE_SIMPLIFIED
						fallback_font = fallback_simplified_chinese

				elif g.language_file == "Chinese (Traditional)":
						g.translation_wide_font = true
						translations.number_format = translations.NUMBERS_CHINESE_TRADITIONAL
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
		
		g.rpg = get_node("/root/level/dialogue/assembler/ide/rpg_screen/viewport/rpg")
		
		for sound in get_node("/root/level/sounds").get_children():
				g.sounds[sound.name] = sound
		for note in get_node("/root/level/musical_notes").get_children():
				g.musical_notes[int(note.name)] = note
						
		g.pin_textures["in_off_1"] = load("res://atlas/pin_in_off_1.png")
		g.pin_textures["in_off_8"] = load("res://atlas/pin_in_off_8.png")
		g.pin_textures["out_off_1"] = load("res://atlas/pin_out_off_1.png")
		g.pin_textures["out_off_8"] = load("res://atlas/pin_out_off_8.png")
		g.pin_textures["out_z_1"] = load("res://atlas/pin_out_z_1.png")
		g.pin_textures["out_z_8"] = load("res://atlas/pin_out_z_8.png")
		g.pin_textures["on_1"] = load("res://atlas/pin_on_1.png")
		g.pin_textures["on_8"] = load("res://atlas/pin_on_8.png")

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
				if not backend.level_exists(level.name):continue
				g.levels[level.name] = level
				g.levels[level.name].size = backend.get_level_size(level.name)
		
		

		if not backend.get_progress_bool("setting_window_mode"):
				var timer = Timer.new()
				add_child(timer)
				timer.connect("timeout", self, "full_screen_delay")
				timer.set_wait_time(0.5)
				timer.set_one_shot(true)
				timer.start()

		if backend.get_progress_bool("setting_color_blind"):
				f.set_colorblind(true)

		f.set_ui_scale(backend.get_progress_int("setting_ui_scaling"))

		var volume = backend.get_progress_int("setting_effects_volume")

		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sound_effects"), volume - 50)
		AudioServer.set_bus_mute(AudioServer.get_bus_index("sound_effects"), volume == 0)
		
		get_node("/root/level/camera/ui/side_buttons/info/container/speed").visible = backend.get_progress_bool("setting_speed")
		
		var prototype_data = backend.get_prototype_data()
		for prototype_name in prototype_data:
				var prototype = get_node("/root/level/prototypes/" + prototype_name)
				prototype.input_pins = prototype_data[prototype_name].input_pins
				prototype.output_pins = prototype_data[prototype_name].output_pins
				
				
						
						
						
						
				
				backend.register_prototype_node(prototype_name, prototype)
				
				prototype.category = prototype_data[prototype_name].category
				
				if prototype.get_node_or_null("word_size") != null:
						prototype.get_node("word_size").visible = backend.is_complete("test_lab")
				
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
						
						if pin["word_size"] > 1:
								kind += "8"
						else :
								kind += "1"

						pin_sprite.texture = g.pin_textures[kind]

						pin_sprite.position = pos_to_vec(pin["position"])
						pin_sprite.z_index = - 1
						pin_container.add_child(pin_sprite)
		
				for pin in prototype.output_pins:
						var pin_sprite = Sprite.new()

						var kind = "out_off_"
														
						if pin["word_size"] > 1:
								kind += "8"
						else :
								kind += "1"

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





										
						
				if get_node_or_null("/root/level/component_panels/" + prototype.name + "/schematic") != null:
						var comp_copy = prototype.duplicate()
						comp_copy.visible = true
						comp_copy.position += Vector2(128, 23)
						get_node("/root/level/component_panels/" + prototype.name + "/schematic").add_child(comp_copy)

		var name_node = get_node("/root/level/component_panels/name")
		var hide_node = get_node("/root/level/camera/ui/background/bottom_bar/position/box/hide")
		for panel in get_node("/root/level/component_panels").get_children():
				if not panel.name in g.prototypes:
						continue
				var new_name = name_node.duplicate()
				new_name.visible = true
				new_name.set_bbcode("[center]" + 
				backend.get_prototype_name(panel.name) + "[/center]")
				panel.add_child(new_name)
				var new_hide = hide_node.duplicate()
				new_hide.visible = true
				panel.add_child(new_hide)

		for val in backend.get_custom_prototypes():
				f.reload_custom_prototype(val[1])
		
		f.update_herts_button(backend.get_clock_speed())

		if backend.needs_savescan():
				backend.save_update()
				for val in backend.get_custom_prototypes():
						f.reload_custom_prototype(val[1])
						
		backend.register_nodes(
				get_node("/root/level/camera/ui/background/top_bar"), 
				get_node("/root/level/map/meshes/wire").multimesh, 
				get_node("/root/level/map/meshes/wire_head").multimesh, 
				get_node("/root/level/map/meshes/wire_head_bg").multimesh, 
				get_node("/root/level/map/meshes/alt_wire").multimesh, 
				get_node("/root/level/map/meshes/alt_wire_head").multimesh, 
				get_node("/root/level/map/meshes/alt_wire_head_bg").multimesh, 
				get_node("/root/level/map/meshes/pin").multimesh, 
				get_node("/root/level/map/meshes/bit_signal").multimesh, 
				get_node("/root/level/map/meshes/number_signal").multimesh, 
				get_node("/root/level/map/meshes/select").multimesh, 
				get_node("/root/level/map/meshes/watch_signal").multimesh, 
				get_node("/root/level/camera/ui/side_buttons/info/container/tick/tick"), 
				get_node("/root/level/camera/ui/side_buttons/info/container/speed/speed"), 
				get_node("/root/level/camera/ui/side_buttons/info/container/tick/tick/early"), 
				get_node("/root/level/camera/ui/side_buttons/info/container/tick/tick/late"), 
				get_node("/root/level/camera/ui/background/bottom_bar/position/box/error"), 
				get_node("/root/level/dialogue/assembler/ide/error"), 
				get_node("/root/level/dialogue/assembler/ide/container/linked_components/grid"), 
				get_node("/root/level/camera/ui/side_buttons/next"), 
				get_node("/root/level/dialogue/assembler/ide/controls/next"), 
				get_node("/root/level/camera/ui/side_buttons/run"), 
				get_node("/root/level/dialogue/assembler/ide/controls/run"), 
				get_node("/root/level/camera/ui/side_buttons/reset"), 
				get_node("/root/level/dialogue/assembler/ide/controls/reset"), 
				get_node("/root/level/misc/wire_comment"), 
				get_node("/root/level/misc/short_circuit_1"), 
				get_node("/root/level/misc/short_circuit_2"), 
				get_node("/root/level/misc/custom_component/27"), 
				get_node("/root/level/misc/custom_component/28"), 
				get_node("/root/level/misc/word_size"), 
				get_node("/root/level/map/delay")
		)
		
		var modloader_success = ProjectSettings.load_resource_pack("res://TCModLoader.pck")
		
		if modloader_success:
			var loaderMain = load("res://TCModLoader/Main.gdc")
			var loaderNode = Node.new()
			loaderNode.set_script(loaderMain)
			get_tree().get_root().call_deferred("add_child", loaderNode)
			print("TCModloader loaded!")
		else:
			push_warning("TCModloader failed to load")
		
func full_screen_delay():
		OS.window_fullscreen = true
		get_node("/root/level/main").resize()

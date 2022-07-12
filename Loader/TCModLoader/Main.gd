extends Node

func _ready():
	print("Starting modloader")
	
	var files = listDir("user://mods/")

	for file in files:
		if not ProjectSettings.load_resource_pack("user://mods/" + file):
			print("Failed loading resource pack: " + file)
			files.remove(files.find(file))
		print("Loaded resource pack: " + file)
	
	for file in files:
		var modMain = load("res://" + file.split(".")[0] + "/Main.gd")
		var modNode = Node.new()
		modNode.set_script(modMain)
		get_tree().get_root().call_deferred("add_child", modNode)

	print("Loaded!")

func listDir(tgtDir: String):
	var files = []
	var dir = Directory.new()
	dir.open(tgtDir)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		if file.ends_with(".pck"):
			files.append(file)
			
	dir.list_dir_end()
	return files

extends Tree

const MODULE_1_TITLE : String = "Module 1: Definitions, Degrees, Isomorphisms"
const MODULE_2_TITLE : String = "Module 2"
const MODULE_3_TITLE : String = "Module 3"
 
func _ready():
	initialize_module_tree()


func initialize_module_tree() -> void:
	var module_tree = $"."
	var root = module_tree.create_item()
	root.set_text(0, "Graph Theory Modules")
	module_tree.set_hide_root(true)
	
	var module_1 = module_tree.create_item(root)
	var module_2 = module_tree.create_item(root)
	var module_3 = module_tree.create_item(root)
	
	module_1.set_text(0, MODULE_1_TITLE)
	module_2.set_text(0, MODULE_2_TITLE)
	module_3.set_text(0, MODULE_3_TITLE)
	
	var chapter_1 = module_tree.create_item(module_1)
	chapter_1.set_text(0, "What is a graph?")

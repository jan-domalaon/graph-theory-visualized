extends Tree

const MODULE_1_TITLE : String = "Module 1: Definitions, Degrees, Isomorphisms"
const MODULE_2_TITLE : String = "Module 2: Trees, Connectivity, Traversability"
const MODULE_3_TITLE : String = "Module 3: Planarity, Graph Embedding, Coloring"
const TREE_ROOT : String = "root"
const TREE_CHILDREN_KEY : String = "children"
const MODULE_CHAPTER_KEY : String = "module_chapters"
const MODULE_DESC_KEY : String = "module_desc"
const CHAPTER_KEY : String = "chapter_title"
const CHAPTER_DESC_KEY : String = "chapter_desc"
const CHAPTER_DATA_KEY : String = "chapter_data_name"
const NO_CHAPTER_DESC : String = "This module/chapter has no description."
const MODULE_SUFFIX : String = "Module"

export var tree_json_path : String = "res://menu/module_tree.json"
onready var tree_node : Tree = $"." 

signal signal_update_tree_item_desc(tree_item_desc)
signal signal_selected_chapter
signal signal_selected_module

func _ready():
	#initialize_module_tree()
	var module_tree_dict = get_module_json()
	initialize_module_tree(module_tree_dict)


func initialize_module_tree(_tree_dict : Dictionary) -> void:
	var root = tree_node.create_item()
	root.set_text(0, _tree_dict[TREE_ROOT])
	tree_node.set_hide_root(true)
	
	var num_modules = _tree_dict[TREE_CHILDREN_KEY].size()
	
	# Modules start on 1
	for num_ind in range(1, num_modules+1):
		var module = tree_node.create_item(root)
		var module_key = "module_" + String(num_ind)
		var module_pair_dict = _tree_dict[TREE_CHILDREN_KEY][num_ind-1]
		var module_name = _tree_dict[TREE_CHILDREN_KEY][num_ind-1][module_key]
		var module_desc = _tree_dict[TREE_CHILDREN_KEY][num_ind-1][MODULE_DESC_KEY]
		module.set_text(0, module_name)
		module.set_metadata(0, module_desc)
		module.set_suffix(0, MODULE_SUFFIX)
		module.set_collapsed(true)
		add_module_children(module, module_pair_dict, MODULE_CHAPTER_KEY)


func add_module_children(_curr_tree_item : TreeItem, _module_pair_dict : Dictionary, _chapters_key : String) -> void:
	# Create TreeItems for each chapter under module
	# TreeItem Metadata contains a dictionary of chapter name, chapter desc, chapter data
	for chapter_dict in _module_pair_dict[_chapters_key]:
		var chapter_tree_item = tree_node.create_item(_curr_tree_item)
		chapter_tree_item.set_text(0, chapter_dict[CHAPTER_KEY])
		chapter_tree_item.set_metadata(0, chapter_dict)


func get_module_json() -> Dictionary:
	var module_json_file = File.new()
	if module_json_file.file_exists(tree_json_path):
		module_json_file.open(tree_json_path, File.READ)
		var data = parse_json(module_json_file.get_as_text())
		return data
	else:
		return {}
	module_json_file.close()


func _on_ModuleTree_item_selected():
	var selected_tree_item = get_selected()
	var selected_tree_item_metadata = get_selected().get_metadata(0)
	var selected_tree_item_desc = ""
	
	# Differentiate between module and chapter selection. Module metadata is a string and
	# chapter is a string
	if typeof(selected_tree_item_metadata) == TYPE_DICTIONARY:
		selected_tree_item_desc = selected_tree_item_metadata[CHAPTER_DESC_KEY]
	else:
		selected_tree_item_desc = selected_tree_item_metadata
	
	# Send a signal to update chapter description box (see ModuleSelection screen)
	# Send chapter dictionary to ModuleSelection screen
	emit_update_tree_item_desc(selected_tree_item_desc)
	
	# Also send a signal to trigger play button visibility
	emit_selected_tree_item(selected_tree_item)


func emit_update_tree_item_desc(_chapter_desc : String) -> void:
	if _chapter_desc != null:
		emit_signal("signal_update_tree_item_desc", _chapter_desc)
	else:
		emit_signal("signal_update_tree_item_desc", NO_CHAPTER_DESC)


func emit_selected_tree_item(_tree_item : TreeItem) -> void:
	# Only emit if the selected tree item is a chapter
	if _tree_item.get_suffix(0) != MODULE_SUFFIX:
		emit_signal("signal_selected_chapter")
	else:
		emit_signal("signal_selected_module")

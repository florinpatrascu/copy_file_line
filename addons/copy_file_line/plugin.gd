@tool
extends EditorPlugin

const SETTINGS_BASE := "copy_file_line/"
const SETTING_SHORTCUT_RES := SETTINGS_BASE + "shortcut_res_path"
const SETTING_SHORTCUT_FS := SETTINGS_BASE + "shortcut_filesystem_path"

const MENU_ITEM_RES := "Copy File:Line (res://)"
const MENU_ITEM_FS := "Copy File:Line (filesystem)"

var _script_editor: ScriptEditor
var _shortcut_res: Shortcut
var _shortcut_fs: Shortcut

func _enter_tree() -> void:
    _script_editor = EditorInterface.get_script_editor()
    _setup_shortcuts()
    _setup_menu_items()

func _exit_tree() -> void:
    _cleanup_menu_items()
    _cleanup_settings()

func _setup_menu_items() -> void:
    add_tool_menu_item(MENU_ITEM_RES, _on_menu_copy_res)
    add_tool_menu_item(MENU_ITEM_FS, _on_menu_copy_fs)

func _cleanup_menu_items() -> void:
    remove_tool_menu_item(MENU_ITEM_RES)
    remove_tool_menu_item(MENU_ITEM_FS)

func _on_menu_copy_res() -> void:
    _copy_file_line_to_clipboard(false)

func _on_menu_copy_fs() -> void:
    _copy_file_line_to_clipboard(true)

func _setup_shortcuts() -> void:
    var editor_settings := EditorInterface.get_editor_settings()

    # Create default shortcut for res:// path (Ctrl+Shift+C)
    var default_shortcut_res := Shortcut.new()
    var event_res := InputEventKey.new()
    event_res.keycode = KEY_C
    event_res.ctrl_pressed = true
    event_res.shift_pressed = true
    default_shortcut_res.events = [event_res]

    # Create default shortcut for filesystem path (Ctrl+Shift+Alt+C)
    var default_shortcut_fs := Shortcut.new()
    var event_fs := InputEventKey.new()
    event_fs.keycode = KEY_C
    event_fs.ctrl_pressed = true
    event_fs.shift_pressed = true
    event_fs.alt_pressed = true
    default_shortcut_fs.events = [event_fs]

    # Register settings with proper UI hints
    if not editor_settings.has_setting(SETTING_SHORTCUT_RES):
        editor_settings.set_setting(SETTING_SHORTCUT_RES, default_shortcut_res)
    editor_settings.set_initial_value(SETTING_SHORTCUT_RES, default_shortcut_res, false)
    editor_settings.add_property_info({
        "name": SETTING_SHORTCUT_RES,
        "type": TYPE_OBJECT,
        "hint": PROPERTY_HINT_RESOURCE_TYPE,
        "hint_string": "Shortcut"
    })

    if not editor_settings.has_setting(SETTING_SHORTCUT_FS):
        editor_settings.set_setting(SETTING_SHORTCUT_FS, default_shortcut_fs)
    editor_settings.set_initial_value(SETTING_SHORTCUT_FS, default_shortcut_fs, false)
    editor_settings.add_property_info({
        "name": SETTING_SHORTCUT_FS,
        "type": TYPE_OBJECT,
        "hint": PROPERTY_HINT_RESOURCE_TYPE,
        "hint_string": "Shortcut"
    })

    # Load current values
    _shortcut_res = editor_settings.get_setting(SETTING_SHORTCUT_RES)
    _shortcut_fs = editor_settings.get_setting(SETTING_SHORTCUT_FS)

func _cleanup_settings() -> void:
    # Keep settings so user customizations persist
    pass

func _input(event: InputEvent) -> void:
    if not event is InputEventKey or not event.pressed:
        return

    if _shortcut_res and _shortcut_res.matches_event(event):
        _copy_file_line_to_clipboard(false)
        get_tree().root.set_input_as_handled()
    elif _shortcut_fs and _shortcut_fs.matches_event(event):
        _copy_file_line_to_clipboard(true)
        get_tree().root.set_input_as_handled()

func _copy_file_line_to_clipboard(use_filesystem_path: bool = false) -> void:
    if not _script_editor:
        return

    var script = _script_editor.get_current_script()
    if not script or not (script is Script):
        return

    var path = script.resource_path
    if path.is_empty():
        return

    var editor = _script_editor.get_current_editor()
    if not editor:
        return

    var code_edit = editor.get_base_editor()
    if not code_edit or not (code_edit is CodeEdit):
        return

    var line = code_edit.get_caret_line() + 1
    var final_path = ProjectSettings.globalize_path(path) if use_filesystem_path else path
    var result = "%s:%d" % [final_path, line]
    DisplayServer.clipboard_set(result)

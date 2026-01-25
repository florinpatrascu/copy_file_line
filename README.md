# CopyFileLine

![CopyFileLine Icon](addons/copy_file_line/cfl.icon.128.png)

`CopyFileLine` is a lightweight Godot 4.5.1+ editor plugin designed to make sharing code, reporting bugs, and documenting workflows faster and easier.

No more manual entry of file paths and line numbers. With one click or keystroke, instantly copy references like `res://path/to/file.gd:42` or `/absolute/path/to/file.gd:42`. Perfect for sharing snippets, reporting issues, or linking specific lines in conversations and documentation.

## Features

- **Resource Path Mode** – Copy Godot resource paths like `res://path/to/file.gd:42`
- **Filesystem Path Mode** – Copy absolute filesystem paths like `/Users/you/project/file.gd:42`
- **Keyboard Shortcuts** – **Ctrl+Shift+C** for resource paths, **Ctrl+Shift+Alt+C** for filesystem paths
- **Customizable Shortcuts** – Configure keybindings in Editor Settings
- **Tools Menu Access** – Available via **Project > Tools** menu
- **Zero Friction** – Works seamlessly with Godot's script editor

## Installation

1. Clone or download this repository
2. Copy the `addons/copy_file_line` folder to your project's `addons/` directory
3. Go to **Project Settings > Plugins**
4. Find "CopyFileLine" and toggle it **Enabled**
5. Done! Start using it immediately

## Usage

1. Open any script in the editor
2. Position your cursor at the target line
3. Use one of the following methods:

### Keyboard Shortcuts

- **Ctrl+Shift+C** – Copy resource path (e.g., `res://scenes/player.gd:42`)
- **Ctrl+Shift+Alt+C** – Copy filesystem path (e.g., `/Users/you/project/scenes/player.gd:42`)

### Tools Menu

- **Project > Tools > Copy File:Line (res://)** – Copy resource path
- **Project > Tools > Copy File:Line (filesystem)** – Copy filesystem path

The reference is instantly copied to your clipboard.

### Customizing Shortcuts

To change the default keyboard shortcuts:

1. Go to **Editor > Editor Settings**
2. Select the **General** tab
3. Search for `copy_file_line`
4. Click on the shortcut you want to modify and set your preferred keybinding

Your customization persist across Godot restarts.

## Requirements

- Godot 4.5.1+
- Editor-only plugin (`@tool` script)

## Use Cases

- **Bug Reports** – Share exact line references in issues
  - Resource path: `res://scenes/player.gd:156`
  - Filesystem path: `/Users/dev/project/scenes/player.gd:156`
- **Code Reviews** – Link to specific lines in PR discussions
- **Documentation** – Reference code snippets with line numbers
- **Team Collaboration** – Quickly communicate code locations
- **External Tools** – Copy filesystem paths for IDEs, terminals, or build systems: `/home/user/game/scripts/player.gd:42`
- **IDE Integration** – Share absolute paths for opening in external editors
- **Debugging** – Include full filesystem paths in error reports for easier navigation

## License

MIT License - ©2026 ッFlorin

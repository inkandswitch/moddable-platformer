# Build the Rust plugin
cargo build --target aarch64-apple-darwin || exit 1
cargo build --target x86_64-apple-darwin || exit 1
cargo build --target x86_64-pc-windows-gnu || exit 1
cargo build --target x86_64-unknown-linux-gnu || exit 1


# Rust godot needs GODOT4_BIN
GODOT4_BIN=/Applications/Godot.app/Contents/MacOS/Godot 

# Launch project
${GODOT4_BIN} ./project.godot
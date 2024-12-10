#!/bin/bash
cargo build --target x86_64-pc-windows-gnu || exit 1
cargo build --target aarch64-apple-darwin || exit 1

# Create export directory
export_dir="/tmp/godot-export"
rm -rf "$export_dir"
mkdir -p "$export_dir"

# Copy current directory contents, excluding certain paths
rsync -av --exclude='target' \
         --exclude='*.zip' \
         --exclude='.git' \
         --exclude='.gitignore' \
         ./ "$export_dir/"

# Create target directory structure
mkdir -p "$export_dir/target/x86_64-pc-windows-gnu/debug"

# Copy only top-level Windows debug files
find ./target/x86_64-pc-windows-gnu/debug -maxdepth 1 -type f -exec cp {} "$export_dir/target/x86_64-pc-windows-gnu/debug/" \;

# Copy only top-level debug files
mkdir -p "$export_dir/target/debug"
find ./target/debug -maxdepth 1 -type f -exec cp {} "$export_dir/target/debug/" \;


# zip up project in tmp folder
cd "$export_dir"
zip -r "patchwork.zip" ./*

# Return to original directory
cd -

# Copy zip from export directory to current directory
cp "$export_dir/patchwork.zip" .

# Clean up export directory
rm -rf "$export_dir"


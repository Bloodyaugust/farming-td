#!/bin/sh

# set -e

which butler

cat ~/.local/share/godot/templates/3.1.1.stable/version.txt
godot --version
butler -V

mkdir build/
mkdir build/osx/
mkdir build/win/

godot --export "Mac OSX" build/osx/farming-td.dmg -v
godot --export "Windows Desktop" build/win/farming-td.exe -v

ls -al
ls -al build/
ls -al build/osx/
ls -al build/win/

butler login

butler push build/osx/ synsugarstudio/farming-td:osx-alpha
butler push build/win/ synsugarstudio/farming-td:win-alpha

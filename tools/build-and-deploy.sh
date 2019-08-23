#!/bin/sh

# set -e

which butler

godot --version
butler -V

mkdir build/
mkdir build/win/

godot --export "Windows Desktop" build/win/farming-td.exe -v

ls -al
ls -al build/
ls -al build/win/

butler login

butler push build/win/ synsugarstudio/farming-td:win-alpha

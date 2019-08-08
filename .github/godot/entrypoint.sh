#!/bin/sh

# set -e

which butler

godot --version
butler -V

mkdir build/win/

godot --export "Windows Desktop" build/win/farming-td.exe

ls -al

butler login

butler push build/win/ synsugarstudio/farming-td:win-alpha

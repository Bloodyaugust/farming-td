#!/bin/sh

set -e

godot --version

godot --export "Windows Desktop" ./build/win/farming-td.exe

godot ls -al ./build/win

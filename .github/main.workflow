workflow "Build and Deploy to Itch" {
  on = "push"
  resolves = ["godot.build"]
}

action "godot.build" {
  uses = "./.github/godot"
}

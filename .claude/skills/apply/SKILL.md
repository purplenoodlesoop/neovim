---
name: apply
description: Apply the neovim Nix config to the system. Use after making any changes to files in this project.
user-invocable: false
---

Run the following command in /Users/yakov/.config/nix-darwin:

```bash
cd /Users/yakov/.config/nix-darwin && nix flake update && nswitch
```

Report the output and whether the switch succeeded.


# Common Utilities (utils)

Installs a set of common command line utilities, Oh My Zsh!, and sets up a non-root user.

## Example Usage

```json
"features": {
    "ghcr.io/MolCrafts/features/utils:2": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| installZsh | Install ZSH? | boolean | true |
| configureZshAsDefaultShell | Change default shell to ZSH? | boolean | true |
| installOhMyZsh | Install Oh My Zsh!? | boolean | true |
| installOhMyZshConfig | Allow installing the default dev container .zshrc templates? | boolean | true |
| upgradePackages | Upgrade OS packages? | boolean | true |
| installVim | Install Vim? | boolean | false |
| installBuildEssential | Install build-essential? | boolean | false |
| username | Enter name of a non-root user to configure or none to skip | string | automatic |
| userUid | Enter UID for non-root user | string | automatic |
| userGid | Enter GID for non-root user | string | automatic |
| nonFreePackages | Add packages from non-free Debian repository? (Debian only) | boolean | false |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/MolCrafts/features/blob/main/src/utils/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._

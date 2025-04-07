# Code App settings

> [!NOTE]  
> The VSCode settings are sync with spooky063 Github account

## Prerequisite

You have to install `code` and `jq`

## Get all plugins

```bash
code --list-extensions
```

## Remove all plugins

```bash
code --list-extensions | xargs -L 1 code --uninstall-extension
```

## Add plugin in settings.json

If the key `extension-manager.extensions` does not exist, you need to create it and put all the plugins you want to install in it.

```bash
jq '."extension-manager.extensions"[]' settings.json | xargs -L 1 code --install-extension
```

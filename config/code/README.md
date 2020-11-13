# Code App settings

## Prerequisite

You have to install `code` and `jq`

## Remove all plugins

```bash
code --list-extensions | xargs -L 1 code --uninstall-extension
```

## Add plugin in settings.json

```bash
jq '."extension-manager.extensions"[]' settings.json | xargs -L 1 code --install-extension
```

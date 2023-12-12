# NmsAction

This action builds NMS and adds artifacts to `$WORKSPACE/nms-build`.

# Usage

```yaml
- uses: PeyaPeyaPeyang/nmsaction@v1
  with:
    rev: 1.19.4 # This fork supports versions 1.17 or later
- name: Install nms into m2
    run: mkdir -p $HOME/.m2/repository && cp -a nms-build/.m2/repository/. $HOME/.m2/repository
```

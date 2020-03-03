# NmsAction

This action builds NMS and installs artifacts to $GITHUB_HOME/.m2.


# Usage

```yaml
- uses: derongan/nmsaction@v1
  with:
    rev: 1.15.2
- name: Install nms into m2
  	run: mkdir -p $HOME/.m2/repository && cp -a nms-build/.m2/repository/. $HOME/.m2/repository
```

# hidori/node-chrome-ja

This container image contains the following components:

* Node.js: <https://hub.docker.com/_/node>
* Google Chrome: google-chrome-stable
* Japanese Fonts: <https://fonts.google.com/noto/specimen/Noto+Sans+JP>

## USAGE

```bash
docker pull hidori/node-chrome-ja
```

## EXAMPLE

```bash
docker run -it --rm --privileged \
    -u `id -u`:`id -g` \
    -v $PWD/tmp:/workdir \
    hidori/node-chrome-ja \
    google-chrome --no-sandbox --headless --screenshot=/workdir/screenshot.png --window-size=1024,768 https://www.google.co.jp
```

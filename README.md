###What is this
This provides a container you can build your Homebrew apps against the open source toolchain "OpenOrbis" (https://github.com/OpenOrbis/OpenOrbis-PS4-Toolchain)


###Build

>docker build -t ps4sdk-docker .

###Run

1) Put ps4sdk-docker.sh into $PATH (optional)
2) Call ps4sdk-docker.sh from your folder you want to build
3) You will be in your folder (its mounted into the container) and you can call the `make` script.

###Save the image
>docker save ps4sdk-docker | bzip2 > ps4sdk-docker.tar.bz2

###Load the image
>docker load < bzip2 -dc ps4sdk-docker.tar.bz2


###Note
Be careful with dynamic paths, such as this https://github.com/OpenOrbis/OpenOrbis-PS4-Toolchain/blob/c466432d3bc4b8724135687e38ae81e6130d03b3/samples/hello_world/hello_world/main.cpp#L5

Because this path won't be resolved because its probably not mounted.
If you have dynamic paths, you probably want to mount them aswell.

The `ps4sdk-docker.sh` script only mounts the current folder. Anything `outside` is excluded. (Anything within, like subdirectories, is included) 

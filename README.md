# Yet Another Platform As A Service

Easily deploy applications (or allow other to) on your own internet-connected
machines.

## Quick start

Install the yapaas client using `gem install yapaas`.

You can install yapaas nodes on pretty much any machine that's connected to
the internet. Ideally you'd have some IaaS provider with a supported API
that provides a convenient interface, but you can use any machine onto which
you can SSH. It's easier if the machines run docker, but it's not a hard
requirement.

A couple of alternatives are outlined here.

### docker-machine

The easiest route is if you already have [docker-machine][] available on your
local machine - you can turn a docker-machine into a yapaas host really
easily:

```sh
yapaas add -d docker-machine -m default mypaas
```

This command used yapaas to tell docker-machine to run yapaas on your 

# php
Obviously, NEVER USE THIS IMAGE as is on FRONT

This Dockerfile self-generate is own SSL certicicate and is embedded in the image.

Anyone can download the image to get the private key and use it against this image.


The purpose of this image is to be used behind a reverse-proxy (as squid or apache or nginx,...) which will use its own certificate on the public interface.

Never publish this image on a public interface.

Even so, it's unsafe to use it in a network too wide.

Even if the network is not too wide, it's still against the best security practice.

Use it at your own risks


# Different shadow map filters

Deferred shading + some shadow map filter experiments: pcf, poisson, pcss

This branch is for perspective light projection.
I couldn't make it work in view-space, so I moved computations to world space (restoring pixel position from depth).
Probably because perspective projection doesn't work well with linear depth.

![pcss](https://github.com/abadonna/defold-pcss/blob/main/demo.png)

## Credits

* PCSS (https://developer.download.nvidia.com/shaderlibrary/docs/shadow_PCSS.pdf)

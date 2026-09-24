&copy; Kirk Rader 2026

# plug-in-favicon

[GIMP] plugin-in for creating a web browser compatible, multi-resolution .ico
file.

## Installation

1. Copy [plug-in-favicon.scm](./plug-in-favicon.scm) to a `scripts` directory
   specified in [GIMP]'s preferences dialog.
2. Restart [GIMP]

## Usage

1. Open a RGB image in [GIMP].
2. Flatten image, if necessary, so that there is only one layer.
3. Invoke the _Image > Parasuarolophus > Favicon_ menu item.
4. Export the newly created image to `.ico` format.

The output of this plug-in will be an image with three layers. Each layer will
be the contents of the original image's single layer scaled to 16x16, 32x32, and
48x48 pixels, respectively.

[GIMP]: https://www.gimp.org
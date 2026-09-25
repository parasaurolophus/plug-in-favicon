#!/usr/bin/env gimp-script-fu-interpreter-3.0

;;; Copyright (c) Kirk Rader 2026

;;; Create a copy of the image currently open in GIMP as a multi-resolution
;;; image compatible with web page .ico files.

;;; Installation: Copy this file to one of the scripts directories configured in
;;; GIMP's preferences, then restart GIMP.

;;; Usage:
;;;    1. Open any image file.
;;;    2. Select the Image > Parasaurolophus > Favicon menu item.

;;; Result:
;;;    1. Create a copy of the currently open image.
;;;    2. Remove invisible layers from the copy.
;;;    3. Merge visible layers in the copy into a single layer.
;;;    4. Replace merged layer with three scaled copies; one each at 16x16,
;;;       32x32, and 48x48 resolution.

(define (plug-in-favicon image)

    (script-fu-use-v3)

    (let ((favicon (gimp-image-duplicate image)))

        (gimp-image-undo-disable favicon)

        (let ((layers (gimp-image-get-layers favicon)))
            (let loop ((index 0))
                (if (< index (vector-length layers))
                    (let ((layer (vector-ref layers index)))
                        (if (not (gimp-item-get-visible layer))
                            (gimp-image-remove-layer favicon layer))
                        (loop (+ index 1))))))

        (let ((base-layer (gimp-image-merge-visible-layers favicon CLIP-TO-IMAGE)))

            (let loop ((size 48))
                (if (>= size 16)
                    (let ((new-layer (gimp-layer-copy base-layer)))
                        (gimp-image-insert-layer favicon new-layer 0 0)
                        (gimp-layer-scale new-layer size size #f)
                        (loop (- size 16)))))

            (gimp-image-remove-layer favicon base-layer)
            (gimp-image-resize favicon 48 48)
            (gimp-display-new favicon))))

(script-fu-register-filter
    "plug-in-favicon"
    "Favicon"
    "Exports a copy of the current image as a multi-size favicon."
    "Kirk Rader"
    "copyright 2026, Kirk Rader"
    "September 24, 2026"
    "*"
    SF-IMAGE
)

(script-fu-menu-register "plug-in-favicon" "<Image>/Image/Parasaurolophus")
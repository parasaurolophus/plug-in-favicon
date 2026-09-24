#!/usr/bin/env gimp-script-fu-interpreter-3.0

;;; Copyright (c) Kirk Rader 2026

;;; Create a copy of the image currently open in GIMP as a multi-resolution
;;; image compatible with web page .ico files.

;;; Copy this file to one of the scripts directories configured in GIMP's
;;; preferences, then restart GIMP.

;;; The plug-in can be invoked using the File > Parasaurolophus > Favicon menu
;;; item.

(define (plug-in-favicon image)

    (script-fu-use-v3)

    (let ((favicon (gimp-image-duplicate image)))
        (gimp-image-undo-disable favicon)
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
    "sRGB"
    SF-IMAGE
)

(script-fu-menu-register "plug-in-favicon" "<Image>/Image/Parasaurolophus")
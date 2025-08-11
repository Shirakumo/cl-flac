## About cl-flac
This is a bindings library to [libflac](https://shirakumo.org/project/libflac), a simple library for decoding FLAC files.

## How To
Precompiled versions of the underlying library are included in this. If you want to build it manually however, refer to the [libflac](https://shirakumo.org/project/libflac) page.

Load the system through ASDF or Quicklisp:

    (ql:quickload :cl-flac)

Create a new `file` object:

    (defvar *file* (cl-flac:make-file #p"~/my-cool-music.flac"))

You can query the file information with `samplerate`, `channels`, `sample-count`, `frame-count`, and `bits-per-sample`.

Reading samples from the file happens with `read-directly`, `read-into-vector`, or `read-to-vector`. A basic playback loop could look like this:

    (loop with buffer = (make-array 512 :element-type 'single-float)
          for samples = (cl-flac:read-into-vector *file* buffer)
          until (= 0 samples)
          do (process-buffer-somehow buffer))

When you're done with the file, you can either just let it be GCd or close it explicitly with `close-file`.

A complete test that allows you to play back a flac file is included in [test.lisp](test.lisp)

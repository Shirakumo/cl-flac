(in-package #:org.shirakumo.fraf.flac)

(docs:define-docs
  (type flac-error
    "This condition is signalled when an error in the underlying library is detected.

See CODE")
  
  (function code
    "Returns the error code encapsulated in the condition.

See FLAC-ERROR")
  
  (function with-error
    "Checks the returned code for error-ness and signals a condition if applicable.

See FLAC-ERROR")
  
  (type file
    "Container for the FLAC file.

Note that you do not need to explicitly close the file.
It will automatically clean up when this instance is
garbage collected.

See MAKE-FILE
See CLOSE-FILE
See HANDLE
See PATH
See CHANNELS
See SAMPLERATE
See BITS-PER-SAMPLE
See SAMPLE-COUNT
See FRAME-COUNT
See READ-DIRECTLY
See READ-INTO-VECTOR
See READ-TO-VECTOR
See SEEK")
  
  (function handle
    "Accessor to the handle for the underlying C data of the FLAC file.

See FILE")

  (function path
    "Returns the path namestring that was used to read the file.

See FILE")
  
  (function make-file
    "Create a new FLAC file from the given path.

If the path is not accessible, or the file is malformatted,
an error is signalled.

See FILE")

  (function close-file
    "Explicitly close the file.

Note that this will render the instance useless.

See FILE")
  
  (function define-cfun-wrapper
    "Defines a wrapper function that just returns what the inner C function returns.")
  
  (function channels
    "Returns the number of channels that the file encodes.

See FILE")
  
  (function samplerate
    "Returns the samplerate of the file in Hertz.

See FILE")
  
  (function bits-per-sample
    "Returns the number of bits per sample as encoded in the file.

See FILE")
  
  (function sample-count
    "Returns the total number of samples stored in the file.

See FRAME-COUNT
See FILE")
  
  (function frame-count
    "Returns the number of frames stored in the file.

This is the number of samples divided by the number
of channels, this giving the number of frames.

See SAMPLE-COUNT
See FILE")
  
  (function read-directly
    "Directly decode samples from the file into the buffer.

BUFFER-SIZE is in number of bytes, but must be aligned
with the sample size. The buffer is filled with 32-bit
float samples.

Returns the number of bytes successfully read. If this
number is lower than the requested amount, the file has
reached its end.

See FILE")
  
  (function read-into-vector
    "Decode samples into the vector.

The vector must have an element-type of either
SINGLE-FLOAT, (SIGNED-BYTE 16), or (SIGNED-BYTE 32).

Returned is the number of samples that were actually
decoded, as that might be lower than the requested
amount if the file does not contain enough samples
anymore.

See FILE")
  
  (function read-to-vector
    "Reads the given number of samples into a single-float vector.

Returns the vector and the number of samples that were
actually decoded.

See READ-INTO-VECTOR
See FILE")
  
  (function seek
    "Seek to the requested frame.

Returns the file on success, signals a condition on
failure.

See FILE"))

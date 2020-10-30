# Out of memory killer

> Pre-requisites, the project created in *[Exercise 1](/exercises/A01/index.html)*

In this exercise we will trigger the Out of Memory (OOM) killer.

* From the `Add to Project > Deploy Image`, create a deployment that runs the image called `lvarin/oom-killer`. That image contains a python code, listed in `app/app.py` file, that reserves 10MB every second.

* Make sure that the container gets killed when it reserves over 50MB of memory. What is the status of the Pod?

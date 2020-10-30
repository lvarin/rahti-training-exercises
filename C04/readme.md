# Liveness and Readiness probes

> Pre-requisites, the project created in *[Exercise 1](/exercises/A01/index.html)*

In this exercise we want to setup a Readiness (when the aplication has finished starting) and a Liveness (when the application is still alive and well) probe.

* Create the following Pod:

*probe.yaml*
<pre><code>kind: Pod
apiVersion: v1
metadata:
  name: probe-tests
spec:
  containers:
  - name: probe-test-container
    image: centos:7
    command:
    - sh
    - -c
    - >
      while true; do
        echo "Waiting for 30 seconds to go live"
        for i in {1..30}; do echo "."; sleep 1; done
        touch /tmp/alive
        echo "Now waiting for 30 seconds to go to sleep"
        for i in {1..30}; do echo "."; sleep 1; done
        rm /tmp/alive
        echo "Going to sleep"
      done
</code></pre>

Upon startup, the pod waits for 30 seconds, then creates inside the container a file called `/tmp/alive`, then waits again for 30 seconds and proceeds to delete the file. Afterwards it starts again, and keeps doing so in an infinite loop.

* Edit the specification so that the container is "ready" and "live" only if
  the file `/tmp/alive` exists.
* Wait for 30 seconds before starting to check if the container is live.
* Try what happens if the liveness probing starts immediately when the container is started?

*Tip #1*: Go to Monitoring page on the Application Console to see the status of
your pod.

*Tip #2*: You can monitor the pod with `watch oc describe pod probe-tests` or
`watch oc get pod probe-tests`

*Tip #3*: The GNU coreutils tool *`cat <filename>`* returns 0 if the
`<filename>` exists and everything went fine.

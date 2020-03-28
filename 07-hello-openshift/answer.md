# 7. Hello world web server with DeploymentConfig

Pre-requisites: *Exercise 1*

In this exercise, write (or copy-paste from slides) all the API objects in YAML
plaintext and submit them with `oc create -f ...`.

## DeploymentConfig

* Create a `DeploymentConfig` that will spawn a pod running image `openshift/hello-openshift`. Name it `hello-openshift` and label it `app: hello-openshift`. Apply the same label `app: hello-openshift` to the pods to be spawned as well.

*`dc.yaml`*
```yaml
apiVersion: apps.openshift.io/v1
kind: DeploymentConfig
metadata:
  labels:
    app: hello-openshift
  name: hello-openshift
spec:
  replicas: 1
  selector:
    app: hello-openshift
    deploymentconfig: hello-openshift
  template:
    metadata:
      labels:
        app: hello-openshift
        deploymentconfig: hello-openshift
    spec:
      containers:
      - image: openshift/hello-openshift:latest
        name: hello-openshift
```

  * What is the name of the pod that appeared?

    ```bash
    $ oc get pod -l app=hello-openshift
    NAME                           READY     STATUS      RESTARTS   AGE
    hello-openshift-1-mh4pl        1/1       Running     0          29s
    ```

  * Delete the pod.

    ```bash
    $ oc delete pod hello-openshift-1-mh4pl
    ```

  * What is the name of the pod that appeared?

    ```bash
    $ oc get pod -l app=hello-openshift
    NAME                           READY     STATUS      RESTARTS   AGE
    hello-openshift-1-gtt59        1/1       Running     0          38s
    ```

* List all objects that have metadata label `app: hello-openshift`. What
  *Kinds* of objects are listed?

    ```bash
    $ oc get all -l app=hello-openshift
    NAME                          READY     STATUS    RESTARTS   AGE
pod/hello-openshift-1-gtt59   1/1       Running   0          21m
    ```
    ```
    NAME                                      DESIRED   CURRENT   READY     AGE
    replicationcontroller/hello-openshift-1   1         1         1         11m
    ```
    ```
    NAME                                                 REVISION   DESIRED   CURRENT   TRIGGERED BY
    deploymentconfig.apps.openshift.io/hello-openshift   1          1         1         config
    ```


## Service

* Create a Service object that will redirect traffic internally to the pod.

  *`service.yaml`*
  ```yaml
  apiVersion: v1
  kind: Service
  metadata:
    labels:
      app: hello-openshift
    name: hello-openshift
  spec:
    ports:
    - name: 8080-tcp
      port: 8080
      protocol: TCP
      targetPort: 8080
    - name: 8888-tcp
      port: 8888
      protocol: TCP
      targetPort: 8888
    selector:
      app: hello-openshift
      deploymentconfig: hello-openshift


## Route

* Expose the Service to internet at 'hello-rahti-##.rahtiapp.fi', where ## is
  the number of the training account you are holding.
  * Secure the route with TLS edge termination policy and redirect
    insecure traffic to the secure one.

  *`route.yaml`*
  ```yaml
  apiVersion: route.openshift.io/v1
  kind: Route
  metadata:
    labels:
      app: hello-openshift
    name: hello-openshift
  spec:
    host: hello-rahti-answer.rahtiapp.fi
    port:
      targetPort: 8080-tcp
    tls:
      termination: edge
      insecureEdgeTerminationPolicy: Redirect
    to:
      kind: Service
      name: hello-openshift
  ```

## Cleanup
### DeploymentConfig

* If you remove DeploymentConfig, what will happen to the corresponding ReplicationController and Pods?

   ```bash
   $ oc delete dc hello-openshift
   ```

* Remove DeploymentConfigs. Did you guess correctly?
* *Bonus*: Why did it happen?

   The Replication controler and the pod get deleted as well as they are dependen objects.

### The rest

* Remove the Route and the Service objects.

   ```bash
   $ oc delete service hello-openshift
   ```
   ```bash
   $ oc delete route hello-openshift
   ```


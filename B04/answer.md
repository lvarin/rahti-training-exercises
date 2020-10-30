# 3. Navigate Rahti Console

Pre-requisites: *Exercise 1, 2*

## Terminal session

Open terminal session to your sleeping pod using the Rahti GUI console.

   ```bash
   $ oc rsh sleeping-pod
   ```

* What is the user id? (`id -u`)

```bash
/ $ id -u
1004430000
```

This value should be a random value calculated at the moment of starting the pod

* What is the group id? (`id -g`)

```bash
/ $ id -g
0
```

This is always zero.

* Try creating file `/hello` containing string `hello`. Did it work? (`echo hello > /hello`)
   * Try that with `/tmp/hello`

```bash
/ $ echo hello > /hello
/bin/sh: can't create /hello: Permission denied
/ $ echo hello > /tmp/hello
```

The user has no permissions to createa a file in `/`, but it does in `/tmp`.

* Kill the process that sleeps. Did the pod disappear?

```bash
/ $ kill 1
```

No, the pod did not die. We do not have permissions to kill a process created by `root`. Otherwise, if we had had permissions. Yes, the pod would have died.


## Cleanup

* Remove the pod `sleeping-pod` using console GUI

(Here we do it using the CLI)

```bash
$ oc delete pod sleeping-pod
pod "sleeping-pod" deleted
```



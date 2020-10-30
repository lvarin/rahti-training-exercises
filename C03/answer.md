# 6. OOM killer

Create pod yaml-spec that runs the image `docker-registry.default.svc:5000/rahti-course-2019/oom-killer:1`. That image contains a python code, listed in `app/app.py` file, that reserves 10MB more memory every second.

Make sure that the container gets killed when it reserves over 50MB of memory.

*`answer.yaml`*
```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: oom-killer
  name: oom-killer
spec:
  containers:
  - image: docker-registry.default.svc:5000/rahti-course-2019/oom-killer:1
    name: oom-killer
    resources:
      limits:
        memory: 50M
```


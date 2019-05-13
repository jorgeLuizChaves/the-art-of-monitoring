### Other container monitoring tools

- cAdvisor — A Google-developed tool that analyzes the resource usage and performance characteristics of running containers. Can run as a container on a Docker server.
- Heapster — If you're using Kubernetes, Heapster does resource analysis and monitoring of container clusters. It also has a native Riemann output.
- collectd cgroups — Docker uses cgroups or control groups to help allocate resources like CPU. You can use the collectd cgroups plugin to gather this information.
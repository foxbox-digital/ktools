# ktools

# Installation

# Usage

## `swap` tool

### Listing Kubernetes clusters/connections
```bash
$ kt swap
```

### Swapping K8s clusters/connections
```bash
$ kt swap connection-name
```

## `spy` tool

### Deleting a Docker registry K8s `secret`
```bash
$ kt spy drop registry appslug
```

### Creating a Docker registry K8s `secret`
```bash
$ kt spy create registry appslug environment
```

### Deleting a K8s application `configMap`
```bash
$ kt spy drop config appslug
```

### Updating/Creating a K8s applicaton `configMap`
```bash
$ kt spy apply config appslug environment
```

### Deleting a K8s application `ingress`
```bash
$ kt spy drop ingress appslug
```

### Updating/Creating a K8s applicaton `ingress`
```bash
$ kt spy apply ingress appslug environment
```

### Deleting a entire K8s application
```bash
$ kt spy drop all appslug
```

## `deliver` tool

### Forcing deployment of a application
```bash
$ kt deliver force deploy
```

### Entering a running application pod's Bash
```bash
$ kt deliver get bash appslug
```

### Downloading running application logs
```bash
$ kt deliver get logs appslug
```

### Watching the log-stream of running application
```bash
$ kt deliver get logs appslug --tail
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

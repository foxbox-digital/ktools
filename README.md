# ktools

A.k.a. `kt` or 'kate'.

It's a CLI program that helps interacting with Kubernetes clusters from a developer perspective.

Originally it was a group of separated Bash scripts, but due to the increasing complexity and Shell incompatibility issues, I've decided to rewrite everything as a single Ruby program.

It features:
- Support for Staging and Production environments.
- Management of different cluster credential connections.
- Management of K8s application Docker image registry secrets.
- Management of K8s application `configMaps`.
- Management of K8s application NGINX `ingresses`.
- Removing (pruning) an entire application.
- Application force deployment.
- Application Bash login.
- Application logs reading/live-streaming.
- Impress your dog.
- Impress your cat.

# Requirements

Before going any forward, you need to have:

- [`kubectl` installed](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Ruby. (I'm using `v2.5.1`. But I guess any `>= 2.0` will work*)

\* *Only tested with Ruby `v2.5.1`. I recommend using [`asdf`](https://github.com/asdf-vm/asdf) to install it.*

**Important Note A:** You will also need to place your `.yaml` DO K8s credential files into your `~/.kube` path. (Create this directory if don't exist). If you don't have them, ask your cluster admin for one. It shall be one for Staging and other for Production (It also contains your token for accessing the K8s dashboard).

**Important Note B:** A updated `secrets` repository is also needed. If you don't have one, check the folder `secrets-sample` in this repository, it's a sample on how to setup one for your company. If you are a Foxbox developer, ask the cluster admin how to get access to it. If you already have access, just clone it to your machine.

**Important Note C:** In this document, whenever you see the word `appslug`, it means you must replace it by the application slug you are operating in. Like `my-awesome-project`. And whenever you see the word `environment`, you must replace by the cluster environment you are operating in. Like `staging` or `production`.

# Installation

```bash
$ gem install k-tools
```

This will add the `$ kt` (kate) executable to your system.

# Usage

## `$ kt` Setup/Init
After installing, start the init by:
```bash
$ kt
```

It will ask for your `secrets` repository path.

Enter it and then you're done.

**Note:** If you want to re-run the init and reconfigure your `secrets` repository path, just run:
```bash
$ kt setup
```

## `swap` tool

This command enables you to list and to connect to different K8s clusters. In our case we will use it for switching between Staging and Production connections, but you can use it to manage how many credentials you want.

You can use it from any path in your terminal.

### Listing Kubernetes clusters/connections
```bash
$ kt swap
- foxbox-production-admin
- fs-orc
- st-orc
-> foxbox-staging-devops
- foxbox-staging-admin
- orc-admin
- foxbox-production-devops
```

Check the `->` pointing to the current connected cluster account. In my case I have a bunch of accounts/clusters. To edit their names just change the name of the `.yaml` files at your `~/.kube/` path.

You may have one `foxbox-staging.yaml` and other `foxbox-production.yaml` file, so in this case, `$ kt swap` will show:
```bash
$ kt swap
- foxbox-production
- foxbox-staging
```

It's pointing to none. That means you haven't connected yet. To do so, simply:
```bash
$ kt swap foxbox-staging
Swapped to foxbox-staging.
```

And now your `kubectl` is connected to the Staging cluster/account.

You can check with:
```bash
$ kt swap
- foxbox-production
-> foxbox-staging
```

*In terminals with such support, the connected cluster/account will be displayed with a yellowish color.*

**Important Note:** That's what dictates on what environment your commands will take place. Be aware! Kate will ask you confirmation for some commands, but your attention is crucial, especially if you have access to Production environments.

## `spy` tool

That's the tool which interacts with your `secrets` repository copy. It will help you managing `configMap`, `ingress`, registry `secrets` and removing entire applications from a cluster.

You can run those commands from anywhere in your system.

### Deleting a Docker registry K8s `secret`

Just:
```bash
$ kt spy drop registry appslug
```

### Creating a Docker registry K8s `secret`

Remember that it will use the state described inside the files of your `secrets` repository copy. Check [this section](https://gitlab.com/foxboxhq/devops/management/wikis/Basic/08-Managing-application-registry-access) if you are confused. (Foxbox developers only)

Find them at: `environment/appslug/registry.json`. (Of your `secrets` repository)

Once you edited the changes, just:
```bash
$ kt spy create registry appslug environment
```

**Warning:** Note you are not updating, you are creating!

### Deleting a K8s application `configMap`

Just:
```bash
$ kt spy drop config appslug
```

### Updating/Creating a K8s application `configMap`

The same principle of the Docker registry files applies to the `configMaps` at your `secrets` repository.

Find them at: `environment/appslug/config_map.yml`.

And to update/create, just:
```bash
$ kt spy apply config appslug environment
```

### Deleting a K8s application `ingress`

Just:
```bash
$ kt spy drop ingress appslug
```

### Updating/Creating a K8s application `ingress`

Same principle here too.

Find them at: `environment/appslug/ingress.yml`.

To update/create, just:
```bash
$ kt spy apply ingress appslug environment
```

### Deleting a entire K8s application

**WARNING:** This will destroy everything related to the given app at the current connected cluster.

Just:
```bash
$ kt spy drop all appslug
```

## `deliver` tool

This tool helps with debugging a running application.

**`deliver` commands must be executed inside the application's path.**

**Important Note:** This tool requires your application to have a copy of the `kdeliver` executable at its root path. You can find it here at this repo too. (Make sure to set permissions to run)

#### Forcing deployment of a application

```bash
$ kt deliver force deploy
```

#### Entering a running application pod's Bash
```bash
$ kt deliver get bash appslug
```

#### Downloading running application logs
```bash
$ kt deliver get logs appslug
```

#### Watching the log-stream of running application
```bash
$ kt deliver get logs appslug --tail
```

## Reporting Bugs

Just open a issue.

If you know how to fix and works at Foxbox, please open a PR.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

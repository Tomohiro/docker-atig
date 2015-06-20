CoreOS cluster
================================================================================


Requirements
--------------------------------------------------------------------------------

- Ruby 2.2
- Direnv
- Terraform

### Provider tokens

- Atlas
- Digital Ocean


Getting Started
--------------------------------------------------------------------------------

### Create the `.envrc` to export environment variables

```sh
$ cp .envrc.example .envirc
$ vi .envrc
$ direnv allow
```

### Install dependency tools

Install the Digtal Ocean command-line tool:

```sh
$ bundle install --path vendor/bundle
```

### Configuration

Create a `user-data.yml`:

```sh
$ cp user-data.yml.example user-data.yml
```

### Development

Launch development machine:

```sh
$ vagrant up
```


Deploy CoreOS cluster to Digital Ocean
--------------------------------------------------------------------------------

Create cluster:

```sh
$ terraform plan   # Check your plan
$ terraform apply
```

Login to a CoreOS server:

```sh
$ bundle exec tugboat core-X -u core -p 2222  # SSH port is 2222 in this example
```


Configuration CoreOS
--------------------------------------------------------------------------------

### Configure `user-data.yml` or `cluster.tf`

Edit the `user-data.yml`:

```sh
$ vi user-data.yml
```

Edit the `cluster.tf`:

```sh
$ vi cluster.tf
```


### Apply to the development

Upload `user-data.yml` to instances:

```sh
$ vagrant provision
```

Apply changes:

```sh
$ vagrant ssh
core@core-X ~$ sudo coreos-cloudinit --from-file /var/lib/coreos-vagrant/vagrantfile-user-data
```


### Apply to the production

```sh
$ terraform remote config -backend-config "name=tomohiro/cluster"
$ terraform remote pull
$ terraform plan
$ terraform apply
$ terraform remote push
```

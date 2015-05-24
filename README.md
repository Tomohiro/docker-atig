Dockerfiles
================================================================================

Getting Started
--------------------------------------------------------------------------------

### Configuration

Create a `cloud-config.yml`:

```sh
$ cp cloud-config.yml.example cloud-config.yml
```

### Development

Launch development machine:

```sh
$ vagrant up
```

### Production

```sh
$ terraform apply
```


Configuration CoreOS
--------------------------------------------------------------------------------

### Development

Edit the `cloud-config.yml`:

```sh
$ vi cloud-config.yml
```

Upload `cloud-config.yml` to instances:

```sh
$ vagrant provision
```

Apply changes:

```sh
$ vagrant ssh
core@core-X ~$ sudo coreos-cloudinit --from-file /var/lib/coreos-vagrant/vagrantfile-user-data
```

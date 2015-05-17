Dockerfiles
================================================================================

Configuration CoreOS
--------------------------------------------------------------------------------

### Development

Edit `cloud-config.yml`:

```sh
$ cp cloud-config.yml.example cloud-config.yml
```

Upload `cloud-config.yml` to instances:

```sh
$ vagrant provision
```

Apply changes:

```sh
$ vagrant ssh
core@core-0X ~$ sudo coreos-cloudinit --from-file /var/lib/coreos-vagrant/vagrantfile-user-data
```


### Production

TODO

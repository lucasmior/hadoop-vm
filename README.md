# hadoop-vm
Virtual Machine with Hadoop environment setup and ready to run map-reduce applications

## Start up environment
```bash
$ vagrant up
```

## Testing hadoop environment
```bash
$ vagrant ssh -c jpc
```

## Access the UI
```
# HDFS Namenode Web UI
localhost:50070
# YARN Resource Manager Web UI
localhost:8088
```

## SSH the VM
```bash
$ vagrant ssh
```

## Poweroff the VM
```bash
$ vagrant halt
```
# Networking File System

## Installation

```sh
sudo apt install nfs-kernel-server
```

## Configuration

editor **/etc/export**
```sh
/home/user/xxx *(ro,sync,no_root_squash)
```

'*' can be replaced with hostname or ip, for example:
```sh
/home/user/xxx 111.111.111.111(ro,sync,no_root_squash)
/home/user/xxx hanning(ro,sync,no_root_squash)
```

after configuration, restart the service:
```sh
sudo service nfs-kernel-server restart
```

## Client

mount remote directory to local directory:

```sh
mount hanning:/home/user/xxx /local/directory
```

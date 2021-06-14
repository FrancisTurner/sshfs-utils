# sshfs-utils
A couple of utility scripts for creating SSHFS mounts etc.

## Installation

```
git clone FrancisTurner/sshfs-utils.git
sudo sshfs/setupsshfs.sh
```

## Usage
```
mk2f mountpoint sshpath
```
Create new mount point in /mnt/ssh/mountpoint and the config information in ~/.config/sshfs/mountpoint then mount it to make sure it works

e.g. 
```
mk2f local pi@192.168.1.123:/home/pi
mk2f remote pi@remotepi.example.com:/home/pi
mk2f remotewww pi@remotepi.example.com:/var/wwww
```

2f mp [ mp2 ...]
```
Mount existing defined (from mk2f) mountpoint mp (and mp2 etc. if specified) in /mnt/ssh

```
2f -u [ mountpoint]
```
Unmount the defined mountpont (or all sshfs mountpoints if no parameter given)
```
2f -U [ mountpoint] 
```
Force unmount the defined mountpont (or all sshfs mountpoints if no parameter given). This is useful when there's been some kind of
connection error and sshfs is not happy

```
2f -l 
```
lists all active sshfs mount points 

```
rm2f mountpoint [mp2...]
```
Delete mount point(s) specified in /mnt/ssh/ and the associted config information in ~/.config/sshfs/

```
2ssh mountpoint
```
ssh to the server defined in ~/.config/sshfs/mountpoint

e.g (using the examples in mk2f above) 2ssh local will do ssh pi@192.168.1.123 and both 2ssh remote and 2ssh remotewww
will do ssh pi@remotepi.example.com

```
2ssh -l
```
list all defined mountpoints whether active or not

# sshfs-utils
A couple of utility scripts for creating SSHFS mounts etc.

## Installation

```
git clone https://github.com/FrancisTurner/sshfs-utils.git
sudo sshfs/setupsshfs.sh
```

## Usage
```
mk2f mountpoint sshpath
```
Create new mount point in /mnt/ssh/mountpoint and the config information in ~/.config/sshfs/mountpoint then mount it to make sure it works.
Strongly recommend that you have sshed to it first to confirm that things exist as you think they do. Also ssh-copy-id is probably a good idea

e.g. 
```
mk2f local pi@192.168.1.123:/home/pi
mk2f remote pi@remotepi.example.com:/home/pi
mk2f remwww pi@remotepi.example.com:/var/wwww
```
Then
```
2f mp [ mp2 ...]
```
Mount existing defined (from mk2f) mountpoint mp (and mp2 etc. if specified) in /mnt/ssh
e.g. ```2f local``` or ```2f remote remwww```

Then ```ls /mnt/ssh/local``` shows the contents of pi@192.168.1.123:/home/pi etc.

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

e.g (using the examples above) ```2ssh local``` will do ssh pi@192.168.1.123 and both ```2ssh remote``` and ```2ssh remwww```
will do ssh pi@remotepi.example.com

```
2ssh -l
```
list all defined mountpoints whether active or not

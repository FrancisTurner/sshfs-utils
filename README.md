# sshfs-utils
A couple of utility scripts for creating SSHFS mounts etc.

## Installation

```
git clone https://github.com/FrancisTurner/sshfs-utils.git
sudo sshfs/setupsshfs.sh
```

### Updates
If there are updates do a ```git pull``` 
and either rerun setupsshfs.sh
or just ```sudo cp *2f 2ssh /usr/local/bin```

## Usage
```
mk2f mountpoint [options] sshpath
```
Create new mount point in /mnt/ssh/mountpoint and the config information in ~/.config/sshfs/mountpoint then mount it to make sure it works.
Strongly recommend that you have sshed to it first to confirm that things exist as you think they do. Also ssh-copy-id is probably a good idea

e.g. 
```
mk2f local pi@192.168.1.123:/home/pi
mk2f remote pi@remotepi.example.com:/home/pi
mk2f remwww pi@remotepi.example.com:/var/wwww
mk2f pi2222 -p 2222 pi@pi2222.example.com:/var/wwww
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
2f tmp [user@]host:/path/ 
```
mounts host:/path/ to the /mnt/ssh/tmp mount point. If you have already got something mounted on /mnt/ssh/tmp it will give an error. 
In that case you'll want to ```2f -u tmp``` and retry

Similar to 2ssh (below) @XX and @XX.YY will be expanded appropriately so
```2f tmp server@1.114:/home/server/``` mounts server@192.168.1.114:/home/server/ on /mnt/ssh/tmp

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
2ssh [username]@XX
2ssh [username]@XX.YY
```
ssh to the server XX on same subnet or server XX.YY on adjacent subnet

e.g if on subnet 192.168.1.0, ```ssh pi@55``` will do ```ssh pi@192.168.1.55``` and ```ssh @0.53``` will do ```ssh $USER@192.168.0.53```


```
2ssh -l
```
list all defined mountpoints whether active or not

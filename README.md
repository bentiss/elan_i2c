# elan_i2c
WIP for Elantech over I2C/SMBus

- This code should be compatible kernel v4.6 and after.
- Kernel v4.6 and v4.7 need the i2c-smbus and i2c-i801 changes, 
- kernel v4.8+ don't.

Use at your own risk

## Usage

```bash
make && sudo make install
sudo cp 71-pointingstick-local.hwdb /etc/udev/hwdb.d && sudo udevadm hwdb --update
```

Then reboot.

Right now, on the Thinkpad series 13 the driver is not automatically bounded to the SMBus device. You need to:

- find the correct path of the SMBus adapter (/sys/bus/i2c/devices/i2c-N, "N" being "5" in the serie 13)
```bash
grep SMBus /sys/bus/i2c/devices/i2c-*/name
```
- then run at each boot (replace N with the appropriate bus number, so ```/sys/bus/i2c/devices/i2c-5/new_device``` for the Thinkpad Series 13):
```bash
sudo su -c "echo elan_i2c 0x15 > /sys/bus/i2c/devices/i2c-N/new_device"
```

## After suspend/resume

Well, the driver doesn't support too well suspend/resume (still a WIP, remember?), so you need to rmmod, modprobe it at each resume:

```bash
sudo rmmod elan_i2c ; sudo modprobe elan_i2c
```

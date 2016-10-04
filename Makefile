MODULE_NAME := elan_i2c

LINUXINCLUDE := -I$(SUBDIRS)/include $(LINUXINCLUDE)

obj-m			+= $(MODULE_NAME).o
obj-m			+= i2c-i801.o

elan_i2c-objs := elan_i2c_core.o
elan_i2c-y	+= elan_i2c_i2c.o
elan_i2c-y	+= elan_i2c_smbus.o

KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)
default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

install: $(MODULE_NAME).ko $(MODULE_NAME).mod.c
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules_install

clean:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean

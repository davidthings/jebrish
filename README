
# JEBRISH 

![](readme_images/rg353m_glamour.webp)

This is a fork of the buildroot project with some settings / config for RK3566-based handheld gaming devices.

It uses the U-Boot and Kernel Config developed for JELOS.

The purpose of this fork is to provide a dead simple way to build a minimal Linux system for the RK3566 expressly for the purpose of working with new devices that use this chip which might want to work with JELOS eventually.

# Branches

**master** - this is the source BuildRoot branch.  It doesn't boot on the target devices.

**minimal** - this branch is a minimal configuration - just enough to boot and log in.  However since this is a minimal configuration, you'll need some extra hardware to make it useful.  Either you'll need to solder in a USB-UART in the case of UART console, or you'll need a USB keyboard in the case of Display/HDMI console.

# Building

On a machine set up to build BuildRoot, run the following commands:

```
make anbernic_rk3566_defconfig
make
```

Compilation on a reasonable machine with a reasonable internet connection should take about 30 minutes.

At the end of the process you should have a file `output/images/sdcard.img` which you can write to an SD card and boot on your device.

```
sudo dd if=output/images/sdcard.img of=/dev/sdc bs=4MB ; sync
```

# Running

With the sd card in the first slot, power on.

After a short period, the kernel will run a console.

Depending on your kernel arguments (in the boot partion `/extlinux/extlinux.conf`), console appears over the UART (at 1,500,00 bps!) or on the LCD display / HDMI.  Whichever appears last on the line is the one the console runs on.  Obviously if you select the main display, you'll need a USB keyboard or similar.  Many work, and a small wireless keyboard is quite nice.

This is the default: console runs on the display.

```
LABEL default
  KERNEL /%LINUXIMAGE%
  FDTDIR /
  append root=PARTUUID=%PARTUUID% rootwait console=ttyS2,1500000 console=tty0 rootfstype=ext4 panic=10 loglevel=8 panic=20
```

The alternative is that the console runs over the UART.  For this option you'll need to solder wires to connect a USB-UART.  Then you'll need to connect at 1,500,000 baud.

Log in with username `root` and password `1234`

# Contents

The configuration will make a minimal system including:

- uboot-spl (2024)
- uboot (2024)
- kernel (6.6)
- busybox
- shell

# Further Work

No doubt there are many things that could be done to improve this work.  Perhaps there are errors, or perhaps the system could be more efficient.

Possible future new branches:

**min-display** - minimal configuration with Weston-based display

**min-wireless** - minimal configuration with wireless networking

**min-fs** - minimal configuration with a large sd-based filesystem

# Boot Log

This is a sample boot log.

```
DDR V1.18 f366f69a7d typ 23/07/17-15:48:58
ln
LP4/4x derate en, other dram:1x trefi
ddrconfig:0
LPDDR4X, 324MHz
BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
tdqss: cs0 dqs0: -24ps, dqs1: -120ps, dqs2: -96ps, dqs3: -192ps, 

change to: 324MHz
clk skew:0x64

change to: 528MHz
clk skew:0x58

change to: 780MHz
clk skew:0x58

change to: 1056MHz(final freq)
PHY drv:clk:36,ca:36,DQ:29,odt:60
vrefinner:16%, vrefout:22%
dram drv:40,odt:80
vref_ca:00000071
clk skew:0x49
cs 0:
the read training result:
DQS0:0x3b, DQS1:0x39, DQS2:0x42, DQS3:0x3c, 
min  : 0xd  0xf 0x11  0xd  0x1  0x4  0x5  0x2 , 0x7  0x6  0x2  0x1  0x7  0x5  0xa  0x4 ,
      0x11  0xf  0xf  0xd  0x5  0x1  0x5  0x7 , 0xf  0x7  0xa  0x2  0xf  0xd  0xf  0xe ,
mid  :0x29 0x2b 0x2c 0x29 0x1e 0x20 0x22 0x20 ,0x24 0x25 0x1f 0x1f 0x25 0x23 0x27 0x22 ,
      0x30 0x2f 0x2d 0x2a 0x24 0x20 0x24 0x25 ,0x2d 0x28 0x28 0x22 0x2c 0x2c 0x2d 0x2c ,
max  :0x46 0x47 0x48 0x46 0x3c 0x3d 0x40 0x3e ,0x42 0x44 0x3d 0x3d 0x43 0x41 0x44 0x41 ,
      0x4f 0x4f 0x4c 0x48 0x43 0x3f 0x43 0x43 ,0x4c 0x49 0x47 0x42 0x4a 0x4c 0x4b 0x4b ,
range:0x39 0x38 0x37 0x39 0x3b 0x39 0x3b 0x3c ,0x3b 0x3e 0x3b 0x3c 0x3c 0x3c 0x3a 0x3d ,
      0x3e 0x40 0x3d 0x3b 0x3e 0x3e 0x3e 0x3c ,0x3d 0x42 0x3d 0x40 0x3b 0x3f 0x3c 0x3d ,
the write training result:
DQS0:0x46, DQS1:0x39, DQS2:0x3d, DQS3:0x30, 
min  :0x61 0x63 0x66 0x63 0x57 0x57 0x5b 0x5c 0x5a ,0x52 0x51 0x4e 0x4d 0x54 0x54 0x55 0x56 0x50 ,
      0x5a 0x5a 0x56 0x55 0x4f 0x4b 0x4d 0x54 0x52 ,0x4d 0x4b 0x4a 0x48 0x51 0x50 0x4d 0x51 0x4a ,
mid  :0x7d 0x7e 0x81 0x7e 0x72 0x73 0x77 0x77 0x75 ,0x6d 0x6c 0x69 0x68 0x6f 0x6d 0x6f 0x6f 0x6a ,
      0x76 0x76 0x71 0x71 0x6a 0x64 0x68 0x6d 0x6c ,0x69 0x67 0x65 0x62 0x6c 0x6c 0x68 0x6d 0x65 ,
max  :0x99 0x9a 0x9d 0x9a 0x8e 0x8f 0x93 0x92 0x91 ,0x89 0x88 0x84 0x83 0x8b 0x87 0x89 0x88 0x84 ,
      0x93 0x92 0x8d 0x8d 0x86 0x7d 0x83 0x86 0x87 ,0x86 0x83 0x81 0x7d 0x88 0x88 0x83 0x8a 0x81 ,
range:0x38 0x37 0x37 0x37 0x37 0x38 0x38 0x36 0x37 ,0x37 0x37 0x36 0x36 0x37 0x33 0x34 0x32 0x34 ,
      0x39 0x38 0x37 0x38 0x37 0x32 0x36 0x32 0x35 ,0x39 0x38 0x37 0x35 0x37 0x38 0x36 0x39 0x37 ,
CA Training result:
cs:0 min  :0x47 0x45 0x40 0x3a 0x41 0x3a 0x40 ,0x47 0x41 0x40 0x39 0x41 0x3a 0x44 ,
cs:0 mid  :0x84 0x86 0x7c 0x7b 0x7c 0x7b 0x6e ,0x83 0x83 0x7d 0x7b 0x7c 0x7b 0x70 ,
cs:0 max  :0xc2 0xc8 0xb9 0xbd 0xb8 0xbd 0x9c ,0xbf 0xc5 0xba 0xbe 0xb8 0xbd 0x9c ,
cs:0 range:0x7b 0x83 0x79 0x83 0x77 0x83 0x5c ,0x78 0x84 0x7a 0x85 0x77 0x83 0x58 ,
out

U-Boot SPL 2024.01-rc1 (Nov 12 2023 - 18:19:46 -0800)
Trying to boot from MMC1
INFO:    Preloader serial: 2
NOTICE:  BL31: v2.3():v2.3-607-gbf602aff1:cl
NOTICE:  BL31: Built : 10:16:03, Jun  5 2023
INFO:    GICv3 without legacy support detected.
INFO:    ARM GICv3 driver initialized in EL3
INFO:    pmu v1 is valid 220114
INFO:    dfs DDR fsp_param[0].freq_mhz= 1056MHz
INFO:    dfs DDR fsp_param[1].freq_mhz= 324MHz
INFO:    dfs DDR fsp_param[2].freq_mhz= 528MHz
INFO:    dfs DDR fsp_param[3].freq_mhz= 780MHz
INFO:    Using opteed sec cpu_context!
INFO:    boot cpu mask: 0
INFO:    BL31: Initializing runtime services
WARNING: No OPTEE provided by BL2 boot loader, Booting device without OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
ERROR:   Error initializing runtime service opteed_fast
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0xa00000
INFO:    SPSR = 0x3c9


U-Boot 2024.01-rc1 (Nov 12 2023 - 18:19:46 -0800)

Model: RGXX3
DRAM:  2 GiB
PMIC:  RK8170 (on=0x80, off=0x00)
Core:  595 devices, 29 uclasses, devicetree: separate
MMC:   mmc@fe000000: 2, mmc@fe2b0000: 1, mmc@fe2c0000: 3, mmc@fe310000: 0
Loading Environment from nowhere... OK
In:    serial@fe660000
Out:   serial@fe660000
Err:   serial@fe660000
Model: RGXX3
Hit any key to stop autoboot:  0 
** Booting bootflow 'mmc@fe2b0000.bootdev.part_1' with extlinux
1:      default
Retrieving file: /Image
append: root=PARTUUID=07184602-8d8c-4363-9d36-4d35b80b57bb rootwait console=ttyS2,1500000 rootfstype=ext4 panic=10 loglevel=8 panic=20
Retrieving file: /rockchip/rk3566-anbernic-rg353p.dtb
Moving Image from 0x2080000 to 0x2200000, end=43a0000
## Flattened Device Tree blob at 0a100000
   Booting using the fdt blob at 0xa100000
Working FDT set to a100000
   Loading Device Tree to 000000007def0000, end 000000007df0fbef ... OK
Working FDT set to 7def0000

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x412fd050]
[    0.000000] Linux version 6.6.0 (david@DW-ASUS) (aarch64-buildroot-linux-gnu-gcc.br_real (Buildroot -gbce3276f04) 12.3.0, GNU ld (GNU Binutils) 2.40) #2 SMP PREEMPT Sun Nov 12 18:33:40 PST 2023
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: RG353M
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000200000-0x000000007fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000200000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x000000007fffffff]
[    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 20 pages/cpu s41784 r8192 d31944 u81920
[    0.000000] pcpu-alloc: s41784 r8192 d31944 u81920 alloc=20*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: Qualcomm erratum 1009, or ARM erratum 1286807, 2441009
[    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 1530923
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: root=PARTUUID=07184602-8d8c-4363-9d36-4d35b80b57bb rootwait console=ttyS2,1500000 rootfstype=ext4 panic=10 loglevel=8 panic=20
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 515592
[    0.000000] mem auto-init: stack:off, heap alloc:on, heap free:on
[    0.000000] mem auto-init: clearing system memory may take some time...
[    0.000000] software IO TLB: area num 4.
[    0.000000] software IO TLB: mapped [mem 0x0000000077e00000-0x000000007be00000] (64MB)
[    0.000000] Memory: 1953372K/2095104K available (12480K kernel code, 2024K rwdata, 5504K rodata, 13504K init, 733K bss, 141732K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 320 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: MBI range [296:319]
[    0.000000] GICv3: Using MBI frame 0x00000000fd410000
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000fd460000
[    0.000000] ITS: No ITS available, not enabling LPIs
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000001] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.001559] Console: colour dummy device 80x25
[    0.001621] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.001640] pid_max: default: 32768 minimum: 301
[    0.001776] LSM: initializing lsm=capability,integrity
[    0.001937] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.001957] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.003435] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.005279] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
[    0.005451] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
[    0.005877] rcu: Hierarchical SRCU implementation.
[    0.005887] rcu:     Max phase no-delay instances is 1000.
[    0.008627] smp: Bringing up secondary CPUs ...
[    0.009716] Detected VIPT I-cache on CPU1
[    0.009819] GICv3: CPU1: found redistributor 100 region 0:0x00000000fd480000
[    0.009886] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[    0.011100] Detected VIPT I-cache on CPU2
[    0.011186] GICv3: CPU2: found redistributor 200 region 0:0x00000000fd4a0000
[    0.011234] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[    0.012490] Detected VIPT I-cache on CPU3
[    0.012574] GICv3: CPU3: found redistributor 300 region 0:0x00000000fd4c0000
[    0.012623] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[    0.012796] smp: Brought up 1 node, 4 CPUs
[    0.012813] SMP: Total of 4 processors activated.
[    0.012821] CPU features: detected: 32-bit EL0 Support
[    0.012828] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
[    0.012834] CPU features: detected: Common not Private translations
[    0.012840] CPU features: detected: CRC32 instructions
[    0.012845] CPU features: detected: Data cache clean to Point of Persistence
[    0.012855] CPU features: detected: RCpc load-acquire (LDAPR)
[    0.012860] CPU features: detected: LSE atomic instructions
[    0.012866] CPU features: detected: Privileged Access Never
[    0.012870] CPU features: detected: RAS Extension Support
[    0.012879] CPU features: detected: Speculative Store Bypassing Safe (SSBS)
[    0.013001] CPU: All CPU(s) started at EL2
[    0.013008] alternatives: applying system-wide alternatives
[    0.016874] devtmpfs: initialized
[    0.046203] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.046243] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.046581] pinctrl core: initialized pinctrl subsystem
[    0.047449] regulator-dummy: no parameters, enabled
[    0.048479] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.049517] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.049598] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.049668] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.051106] thermal_sys: Registered thermal governor 'fair_share'
[    0.051119] thermal_sys: Registered thermal governor 'step_wise'
[    0.051126] thermal_sys: Registered thermal governor 'power_allocator'
[    0.051231] cpuidle: using governor ladder
[    0.051277] cpuidle: using governor menu
[    0.051589] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.051805] ASID allocator initialised with 65536 entries
[    0.052090] Serial: AMBA PL011 UART driver
[    0.070432] platform fe060000.dsi: Fixed dependency cycle(s) with /dsi@fe060000/panel@0/port/endpoint
[    0.070492] platform fe060000.dsi: Fixed dependency cycle(s) with /vop@fe040000/ports/port@1/endpoint@4
[    0.071267] platform fe0a0000.hdmi: Fixed dependency cycle(s) with /vop@fe040000/ports/port@0/endpoint@2
[    0.106901] gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.107482] rockchip-gpio fdd60000.gpio: probed /pinctrl/gpio@fdd60000
[    0.108085] gpio gpiochip1: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.108515] rockchip-gpio fe740000.gpio: probed /pinctrl/gpio@fe740000
[    0.109167] gpio gpiochip2: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.109587] rockchip-gpio fe750000.gpio: probed /pinctrl/gpio@fe750000
[    0.110144] gpio gpiochip3: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.110711] rockchip-gpio fe760000.gpio: probed /pinctrl/gpio@fe760000
[    0.111546] gpio gpiochip4: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.111965] rockchip-gpio fe770000.gpio: probed /pinctrl/gpio@fe770000
[    0.118312] platform hdmi-con: Fixed dependency cycle(s) with /hdmi@fe0a0000/ports/port@1/endpoint
[    0.123939] Modules: 24160 pages in range for non-PLT usage
[    0.123955] Modules: 515680 pages in range for PLT usage
[    0.125929] cryptd: max_cpu_qlen set to 1000
[    0.194685] raid6: neonx8   gen()  1454 MB/s
[    0.262925] raid6: neonx4   gen()  1414 MB/s
[    0.331151] raid6: neonx2   gen()  1290 MB/s
[    0.399398] raid6: neonx1   gen()  1053 MB/s
[    0.467596] raid6: int64x8  gen()   447 MB/s
[    0.535815] raid6: int64x4  gen()   723 MB/s
[    0.604056] raid6: int64x2  gen()   910 MB/s
[    0.672324] raid6: int64x1  gen()   640 MB/s
[    0.672336] raid6: using algorithm neonx8 gen() 1454 MB/s
[    0.740435] raid6: .... xor() 1089 MB/s, rmw enabled
[    0.740445] raid6: using neon recovery algorithm
[    0.741537] vcc_sys: 3800 mV, enabled
[    0.741794] reg-fixed-voltage regulator-vcc-sys: vcc_sys supplying 3800000uV
[    0.742087] vcc_wifi: 3300 mV, enabled
[    0.742159] iommu: Default domain type: Translated
[    0.742171] iommu: DMA domain TLB invalidation policy: strict mode
[    0.742340] reg-fixed-voltage regulator-vcc-wifi: vcc_wifi supplying 3300000uV
[    0.742780] SCSI subsystem initialized
[    0.743100] libata version 3.00 loaded.
[    0.743409] usbcore: registered new interface driver usbfs
[    0.743470] usbcore: registered new interface driver hub
[    0.743546] usbcore: registered new device driver usb
[    0.744630] mc: Linux media interface: v0.10
[    0.744729] videodev: Linux video capture interface: v2.00
[    0.744933] pps_core: LinuxPPS API ver. 1 registered
[    0.744944] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.744974] PTP clock support registered
[    0.746132] ARM FF-A: FFA_VERSION returned not supported
[    0.746241] scmi_core: SCMI protocol bus registered
[    0.746754] Advanced Linux Sound Architecture Driver Initialized.
[    0.747919] vgaarb: loaded
[    0.748646] clocksource: Switched to clocksource arch_sys_counter
[    0.749300] FS-Cache: Loaded
[    0.766763] NET: Registered PF_INET protocol family
[    0.766971] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.770121] tcp_listen_portaddr_hash hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.770180] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.770307] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.770464] TCP bind hash table entries: 16384 (order: 8, 1048576 bytes, linear)
[    0.771441] TCP: Hash tables configured (established 16384 bind 16384)
[    0.771611] UDP hash table entries: 1024 (order: 4, 98304 bytes, linear)
[    0.771751] UDP-Lite hash table entries: 1024 (order: 4, 98304 bytes, linear)
[    0.772120] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.772195] PCI: CLS 0 bytes, default 64
[    0.778809] Initialise system trusted keyrings
[    0.779145] workingset: timestamp_bits=46 max_order=19 bucket_order=0
[    0.779663] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.780070] fuse: init (API version 7.39)
[    0.780720] SGI XFS with security attributes, no debug enabled
[    0.818831] jitterentropy: Initialization failed with host not compliant with requirements: 9
[    0.818866] NET: Registered PF_ALG protocol family
[    0.818905] xor: measuring software checksum speed
[    0.825074]    8regs           :  1610 MB/sec
[    0.830064]    32regs          :  1987 MB/sec
[    0.836410]    arm64_neon      :  1593 MB/sec
[    0.836433] xor: using function: 32regs (1987 MB/sec)
[    0.836459] async_tx: api initialized (async)
[    0.836486] Key type asymmetric registered
[    0.836496] Asymmetric key parser 'x509' registered
[    0.836692] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
[    0.836709] io scheduler mq-deadline registered
[    0.839757] phy phy-fe850000.mipi-dphy.0: Looking up phy-supply from device tree
[    0.839782] phy phy-fe850000.mipi-dphy.0: Looking up phy-supply property in node /mipi-dphy@fe850000 failed
[    0.842345] phy phy-fe8a0000.usb2phy.1: Looking up phy-supply from device tree
[    0.842373] phy phy-fe8a0000.usb2phy.1: Looking up phy-supply property in node /usb2phy@fe8a0000/otg-port failed
[    0.844523] phy phy-fe8b0000.usb2phy.2: Looking up phy-supply from device tree
[    0.844551] phy phy-fe8b0000.usb2phy.2: Looking up phy-supply property in node /usb2phy@fe8b0000/host-port failed
[    0.846717] phy phy-fe830000.phy.3: Looking up phy-supply from device tree
[    0.846745] phy phy-fe830000.phy.3: Looking up phy-supply property in node /phy@fe830000 failed
[    0.853080] pwm-backlight backlight: Looking up power-supply from device tree
[    0.860131] dma-pl330 fe530000.dma-controller: Loaded driver for PL330 DMAC-241330
[    0.860159] dma-pl330 fe530000.dma-controller:       DBUFF-128x8bytes Num_Chans-8 Num_Peri-32 Num_Events-16
[    0.864066] dma-pl330 fe550000.dma-controller: Loaded driver for PL330 DMAC-241330
[    0.864091] dma-pl330 fe550000.dma-controller:       DBUFF-128x8bytes Num_Chans-8 Num_Peri-32 Num_Events-16
[    0.867207] Serial: 8250/16550 driver, 5 ports, IRQ sharing enabled
[    0.873301] fe650000.serial: ttyS1 at MMIO 0xfe650000 (irq = 25, base_baud = 1500000) is a 16550A
[    0.873693] serial serial0: tty port ttyS1 registered
[    0.875606] fe660000.serial: ttyS2 at MMIO 0xfe660000 (irq = 26, base_baud = 1500000) is a 16550A
[    0.875844] printk: console [ttyS2] enabled
[    0.992056] rockchip-vop2 fe040000.vop: Adding to iommu group 2
[    0.995665] phy phy-fe060000.dsi.4: Looking up phy-supply from device tree
[    0.996325] phy phy-fe060000.dsi.4: Looking up phy-supply property in node /dsi@fe060000 failed
[    0.997780] mipi-dsi fe060000.dsi.0: Fixed dependency cycle(s) with /dsi@fe060000/ports/port@1/endpoint
[    1.010619] brd: module loaded
[    1.020681] loop: module loaded
[    1.021774] zram: Added device: zram0
[    1.025537] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
[    1.026252] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
[    1.028069] CAN device driver interface
[    1.028491] sja1000 CAN netdevice driver
[    1.028899] e100: Intel(R) PRO/100 Network Driver
[    1.029324] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.029868] e1000: Intel(R) PRO/1000 Network Driver
[    1.030306] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.030868] e1000e: Intel(R) PRO/1000 Network Driver
[    1.031314] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.031886] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.032369] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.032947] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[    1.033493] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    1.036152] usbcore: registered new interface driver rtl8150
[    1.036772] usbcore: registered new device driver r8152-cfgselector
[    1.037395] usbcore: registered new interface driver r8152
[    1.037938] usbcore: registered new interface driver asix
[    1.038479] usbcore: registered new interface driver ax88179_178a
[    1.039081] usbcore: registered new interface driver cdc_ether
[    1.039654] usbcore: registered new interface driver rndis_host
[    1.040256] usbcore: registered new interface driver cdc_ncm
[    1.040849] usbcore: registered new interface driver qmi_wwan
[    1.041424] usbcore: registered new interface driver cdc_mbim
[    1.041992] usbcore: registered new interface driver r8153_ecm
[    1.114991] ehci-platform fd880000.usb: EHCI Host Controller
[    1.115655] ohci-platform fd8c0000.usb: Generic Platform OHCI controller
[    1.115717] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    1.116724] ohci-platform fd8c0000.usb: new USB bus registered, assigned bus number 2
[    1.116735] ehci-platform fd880000.usb: new USB bus registered, assigned bus number 1
[    1.116948] ehci-platform fd880000.usb: irq 32, io mem 0xfd880000
[    1.117104] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 3
[    1.117295] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220fe64 hci version 0x110 quirks 0x0000000002000010
[    1.117367] xhci-hcd xhci-hcd.0.auto: irq 31, io mem 0xfd000000
[    1.117581] ohci-platform fd8c0000.usb: irq 33, io mem 0xfd8c0000
[    1.117637] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    1.117933] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 4
[    1.117959] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
[    1.118403] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
[    1.123689] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.124336] usb usb3: Product: xHCI Host Controller
[    1.124809] usb usb3: Manufacturer: Linux 6.6.0 xhci-hcd
[    1.125290] usb usb3: SerialNumber: xhci-hcd.0.auto
[    1.126743] hub 3-0:1.0: USB hub found
[    1.127160] hub 3-0:1.0: 1 port detected
[    1.128239] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.129264] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.06
[    1.130007] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.130651] usb usb4: Product: xHCI Host Controller
[    1.131089] usb usb4: Manufacturer: Linux 6.6.0 xhci-hcd
[    1.131564] usb usb4: SerialNumber: xhci-hcd.0.auto
[    1.132702] ehci-platform fd880000.usb: USB 2.0 started, EHCI 1.00
[    1.132990] hub 4-0:1.0: USB hub found
[    1.133668] hub 4-0:1.0: 1 port detected
[    1.134852] usbcore: registered new interface driver cdc_acm
[    1.135218] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
[    1.135364] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    1.136090] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.136901] usbcore: registered new interface driver cdc_wdm
[    1.137462] usb usb1: Product: EHCI Host Controller
[    1.138368] usbcore: registered new interface driver uas
[    1.138388] usb usb1: Manufacturer: Linux 6.6.0 ehci_hcd
[    1.138955] usbcore: registered new interface driver usb-storage
[    1.139324] usb usb1: SerialNumber: fd880000.usb
[    1.139900] usbcore: registered new interface driver ums-alauda
[    1.140879] usbcore: registered new interface driver ums-cypress
[    1.141260] hub 1-0:1.0: USB hub found
[    1.141473] usbcore: registered new interface driver ums-datafab
[    1.141824] hub 1-0:1.0: 1 port detected
[    1.142329] usbcore: registered new interface driver ums_eneub6250
[    1.143227] usbcore: registered new interface driver ums-freecom
[    1.143813] usbcore: registered new interface driver ums-isd200
[    1.144392] usbcore: registered new interface driver ums-jumpshot
[    1.145040] usbcore: registered new interface driver ums-karma
[    1.145618] usbcore: registered new interface driver ums-onetouch
[    1.146224] usbcore: registered new interface driver ums-realtek
[    1.146811] usbcore: registered new interface driver ums-sddr09
[    1.147389] usbcore: registered new interface driver ums-sddr55
[    1.147966] usbcore: registered new interface driver ums-usbat
[    1.148664] usbcore: registered new interface driver usbserial_generic
[    1.149311] usbserial: USB Serial support registered for generic
[    1.149908] usbcore: registered new interface driver ch341
[    1.150444] usbserial: USB Serial support registered for ch341-uart
[    1.151061] usbcore: registered new interface driver cp210x
[    1.151604] usbserial: USB Serial support registered for cp210x
[    1.152209] usbcore: registered new interface driver ftdi_sio
[    1.152801] usbserial: USB Serial support registered for FTDI USB Serial Device
[    1.153619] usbcore: registered new interface driver keyspan
[    1.154176] usbserial: USB Serial support registered for Keyspan - (without firmware)
[    1.154922] usbserial: USB Serial support registered for Keyspan 1 port adapter
[    1.155617] usbserial: USB Serial support registered for Keyspan 2 port adapter
[    1.156307] usbserial: USB Serial support registered for Keyspan 4 port adapter
[    1.157057] usbcore: registered new interface driver option
[    1.157615] usbserial: USB Serial support registered for GSM modem (1-port)
[    1.158436] usbcore: registered new interface driver oti6858
[    1.158989] usbserial: USB Serial support registered for oti6858
[    1.159582] usbcore: registered new interface driver pl2303
[    1.160125] usbserial: USB Serial support registered for pl2303
[    1.160774] usbcore: registered new interface driver qcserial
[    1.161341] usbserial: USB Serial support registered for Qualcomm USB modem
[    1.162032] usbcore: registered new interface driver sierra
[    1.162576] usbserial: USB Serial support registered for Sierra USB modem
[    1.165599] usbcore: registered new interface driver usbtouchscreen
[    1.166518] pwm-vibrator pwm-vibrator: Looking up vcc-supply from device tree
[    1.167165] pwm-vibrator pwm-vibrator: Looking up vcc-supply property in node /pwm-vibrator failed
[    1.167988] pwm-vibrator pwm-vibrator: supply vcc not found, using dummy regulator
[    1.169301] input: pwm-vibrator as /devices/platform/pwm-vibrator/input/input0
[    1.171403] i2c_dev: i2c /dev entries driver
[    1.173556] i2c 0-0020: Fixed dependency cycle(s) with /i2c@fdd40000/pmic@20/regulators/BOOST
[    1.181279] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.06
[    1.182042] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.182687] usb usb2: Product: Generic Platform OHCI controller
[    1.183217] usb usb2: Manufacturer: Linux 6.6.0 ohci_hcd
[    1.183692] usb usb2: SerialNumber: fd8c0000.usb
[    1.185222] hub 2-0:1.0: USB hub found
[    1.185743] hub 2-0:1.0: 1 port detected
[    1.257633] rk808-regulator rk808-regulator: there is no dvs0 gpio
[    1.258239] rk808-regulator rk808-regulator: there is no dvs1 gpio
[    1.258884] rk808-regulator rk808-regulator: Looking up vcc1-supply from device tree
[    1.259592] vdd_logic: supplied by vcc_sys
[    1.259970] vcc_sys: could not add device link regulator.3: -2
[    1.264934] vdd_logic: 500 <--> 1350 mV at 900 mV, enabled
[    1.266351] rk808-regulator rk808-regulator: Looking up vcc2-supply from device tree
[    1.267066] vdd_gpu: supplied by vcc_sys
[    1.267428] vcc_sys: could not add device link regulator.4: -2
[    1.271781] vdd_gpu: 500 <--> 1350 mV at 900 mV, enabled
[    1.273149] rk808-regulator rk808-regulator: Looking up vcc3-supply from device tree
[    1.273866] vcc_ddr: supplied by vcc_sys
[    1.274230] vcc_sys: could not add device link regulator.5: -2
[    1.277658] vcc_ddr: at 500 mV, enabled
[    1.278895] rk808-regulator rk808-regulator: Looking up vcc4-supply from device tree
[    1.279610] vcc_3v3: supplied by vcc_sys
[    1.279973] vcc_sys: could not add device link regulator.6: -2
[    1.283847] vcc_3v3: 3300 mV, enabled
[    1.285088] rk808-regulator rk808-regulator: Looking up vcc5-supply from device tree
[    1.285803] vcca1v8_pmu: supplied by vcc_sys
[    1.286196] vcc_sys: could not add device link regulator.7: -2
[    1.290102] vcca1v8_pmu: 1800 mV, enabled
[    1.291358] rk808-regulator rk808-regulator: Looking up vcc5-supply from device tree
[    1.292070] vdda_0v9: supplied by vcc_sys
[    1.292438] vcc_sys: could not add device link regulator.8: -2
[    1.295919] vdda_0v9: 900 mV, enabled
[    1.297143] rk808-regulator rk808-regulator: Looking up vcc5-supply from device tree
[    1.297858] vdda0v9_pmu: supplied by vcc_sys
[    1.298251] vcc_sys: could not add device link regulator.9: -2
[    1.302172] vdda0v9_pmu: 900 mV, enabled
[    1.303443] rk808-regulator rk808-regulator: Looking up vcc6-supply from device tree
[    1.304158] vccio_acodec: supplied by vcc_sys
[    1.304559] vcc_sys: could not add device link regulator.10: -2
[    1.308067] vccio_acodec: 3300 mV, enabled
[    1.309331] rk808-regulator rk808-regulator: Looking up vcc6-supply from device tree
[    1.310046] vccio_sd: supplied by vcc_sys
[    1.310416] vcc_sys: could not add device link regulator.11: -2
[    1.314368] vccio_sd: 1800 <--> 3300 mV at 3300 mV, enabled
[    1.315767] rk808-regulator rk808-regulator: Looking up vcc6-supply from device tree
[    1.316481] vcc3v3_pmu: supplied by vcc_sys
[    1.316916] vcc_sys: could not add device link regulator.12: -2
[    1.320875] vcc3v3_pmu: 3300 mV, enabled
[    1.322133] rk808-regulator rk808-regulator: Looking up vcc7-supply from device tree
[    1.322849] vcc_1v8: supplied by vcc_sys
[    1.323212] vcc_sys: could not add device link regulator.13: -2
[    1.326672] vcc_1v8: 1800 mV, enabled
[    1.327902] rk808-regulator rk808-regulator: Looking up vcc7-supply from device tree
[    1.328618] vcc1v8_dvp: supplied by vcc_sys
[    1.329059] vcc_sys: could not add device link regulator.14: -2
[    1.330149] vcc1v8_dvp: Bringing 600000uV into 1800000-1800000uV
[    1.335890] vcc1v8_dvp: 1800 <--> 3300 mV at 1800 mV, enabled
[    1.337359] rk808-regulator rk808-regulator: Looking up vcc7-supply from device tree
[    1.338080] vcc2v8_dvp: supplied by vcc_sys
[    1.338466] vcc_sys: could not add device link regulator.15: -2
[    1.341926] vcc2v8_dvp: 2800 mV, enabled
[    1.343208] rk808-regulator rk808-regulator: Looking up vcc8-supply from device tree
[    1.343924] boost: supplied by vcc_sys
[    1.344272] vcc_sys: could not add device link regulator.16: -2
[    1.348255] boost: 4700 <--> 5400 mV at 4700 mV, enabled
[    1.350647] otg_switch: no parameters, disabled
[    1.351331] rk808-regulator rk808-regulator: Looking up vcc9-supply from device tree
[    1.352083] otg_switch: supplied by boost
[    1.359580] input: rk805 pwrkey as /devices/platform/fdd40000.i2c/i2c-0/0-0020/rk805-pwrkey/input/input1
[    1.373239] rk808-rtc rk808-rtc: registered as rtc0
[    1.376485] rk808-rtc rk808-rtc: setting system clock to 2017-08-05T09:00:22 UTC (1501923622)
[    1.381206] fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
[    1.381876] fan53555-regulator 0-0040: Looking up vin-supply from device tree
[    1.382538] vdd_cpu: supplied by vcc_sys
[    1.382904] vcc_sys: could not add device link regulator.18: -2
[    1.384016] vdd_cpu: override min_uV, 712500 -> 720000
[    1.384180] IR JVC protocol handler initialized
[    1.384496] vdd_cpu: override max_uV, 1390000 -> 1230000
[    1.384942] IR MCE Keyboard/mouse protocol handler initialized
[    1.384952] IR NEC protocol handler initialized
[    1.384958] IR RC5(x/sz) protocol handler initialized
[    1.386815] IR RC6 protocol handler initialized
[    1.387231] IR SANYO protocol handler initialized
[    1.387673] IR Sharp protocol handler initialized
[    1.388105] IR Sony protocol handler initialized
[    1.388526] IR XMP protocol handler initialized
[    1.390169] rockchip-rga fdeb0000.rga: HW Version: 0x03.02
[    1.391255] vdd_cpu: 720 <--> 1230 mV at 900 mV, enabled
[    1.391258] rockchip-rga fdeb0000.rga: Registered rockchip-rga as /dev/video0
[    1.392260] hantro-vpu fdea0000.video-codec: Adding to iommu group 0
[    1.393989] hantro-vpu fdea0000.video-codec: registered rockchip,rk3568-vpu-dec as /dev/video1
[    1.395510] hantro-vpu fdee0000.video-codec: Adding to iommu group 1
[    1.397285] hantro-vpu fdee0000.video-codec: registered rockchip,rk3568-vepu-enc as /dev/video2
[    1.399268] usbcore: registered new interface driver uvcvideo
[    1.430006] thermal thermal_zone0: power_allocator: sustainable_power will be estimated
[    1.431109] thermal thermal_zone1: power_allocator: sustainable_power will be estimated
[    1.435298] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    1.436292] cpu cpu0: Looking up cpu-supply from device tree
[    1.440301] sdhci: Secure Digital Host Controller Interface driver
[    1.441003] sdhci: Copyright(c) Pierre Ossman
[    1.441517] Synopsys Designware Multimedia Card Interface Driver
[    1.443274] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.444465] dwmmc_rockchip fe000000.mmc: IDMAC supports 32-bit address mode.
[    1.445200] dwmmc_rockchip fe000000.mmc: Using internal DMA controller.
[    1.445807] dwmmc_rockchip fe000000.mmc: Version ID is 270a
[    1.446387] dwmmc_rockchip fe000000.mmc: DW MMC controller at irq 68,32 bit host data width,256 deep fifo
[    1.446868] dwmmc_rockchip fe2b0000.mmc: IDMAC supports 32-bit address mode.
[    1.446879] dwmmc_rockchip fe2c0000.mmc: IDMAC supports 32-bit address mode.
[    1.446927] dwmmc_rockchip fe2c0000.mmc: Using internal DMA controller.
[    1.446942] dwmmc_rockchip fe2c0000.mmc: Version ID is 270a
[    1.447014] dwmmc_rockchip fe2c0000.mmc: DW MMC controller at irq 70,32 bit host data width,256 deep fifo
[    1.447187] dwmmc_rockchip fe2c0000.mmc: Looking up vmmc-supply from device tree
[    1.447388] dwmmc_rockchip fe000000.mmc: Looking up vmmc-supply from device tree
[    1.447896] dwmmc_rockchip fe2b0000.mmc: Using internal DMA controller.
[    1.448075] dwmmc_rockchip fe2c0000.mmc: Looking up vqmmc-supply from device tree
[    1.449229] dwmmc_rockchip fe000000.mmc: Looking up vqmmc-supply from device tree
[    1.449307] dwmmc_rockchip fe2c0000.mmc: Got CD GPIO
[    1.449636] dwmmc_rockchip fe2b0000.mmc: Version ID is 270a
[    1.451956] dwmmc_rockchip fe000000.mmc: allocated mmc-pwrseq
[    1.452419] dwmmc_rockchip fe2b0000.mmc: DW MMC controller at irq 69,32 bit host data width,256 deep fifo
[    1.453088] mmc_host mmc3: card is non-removable.
[    1.453771] ledtrig-cpu: registered to indicate activity on CPUs
[    1.453887] dwmmc_rockchip fe2b0000.mmc: Looking up vmmc-supply from device tree
[    1.455593] dwmmc_rockchip fe2b0000.mmc: Looking up vqmmc-supply from device tree
[    1.457201] scmi_protocol scmi_dev.1: Enabled polling mode TX channel - prot_id:16
[    1.459269] dwmmc_rockchip fe2b0000.mmc: Got CD GPIO
[    1.459491] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    1.460375] arm-scmi firmware:scmi: SCMI Protocol v2.0 'rockchip:' Firmware version 0x0
[    1.463520] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
[    1.464764] hid: raw HID events driver (C) Jiri Kosina
[    1.468735] mmc_host mmc2: Bus speed (slot 0) = 375000Hz (slot req 400000Hz, actual 375000HZ div = 0)
[    1.472331] usbcore: registered new interface driver usbhid
[    1.472855] mmc_host mmc1: Bus speed (slot 0) = 375000Hz (slot req 400000Hz, actual 375000HZ div = 0)
[    1.473697] usbhid: USB HID core driver
[    1.476543] rockchip-saradc fe720000.saradc: Looking up vref-supply from device tree
[    1.482794] hw perfevents: enabled with armv8_cortex_a55 PMU driver, 7 counters available
[    1.485993] gpio-mux mux-controller: 4-way mux-controller registered
[    1.488002] usbcore: registered new interface driver snd-usb-audio
[    1.499039] u32 classifier
[    1.499308]     input device check on
[    1.499946] Initializing XFRM netlink socket
[    1.500372] NET: Registered PF_PACKET protocol family
[    1.500881] NET: Registered PF_KEY protocol family
[    1.501522] Bridge firewalling registered
[    1.501977] can: controller area network core
[    1.502440] NET: Registered PF_CAN protocol family
[    1.502877] can: raw protocol
[    1.503154] can: broadcast manager protocol
[    1.503540] can: netlink gateway - max_hops=1
[    1.503954] 8021q: 802.1Q VLAN Support v1.8
[    1.504406] Key type dns_resolver registered
[    1.523554] Loading compiled-in X.509 certificates
[    1.569449] mmc_host mmc1: Bus speed (slot 0) = 150000000Hz (slot req 150000000Hz, actual 150000000HZ div = 0)
[    1.571866] dwmmc_rockchip fe2b0000.mmc: All phases bad!
[    1.572363] mmc1: tuning execution failed: -5
[    1.572813] mmc1: error -5 whilst initialising SD card
[    1.589755] rockchip-iodomain fdc20000.syscon:io-domains: Looking up pmuio1-supply from device tree
[    1.590089] reg-fixed-voltage regulator-vcc3v3-lcd0: Looking up vin-supply from device tree
[    1.591337] vcc3v3_lcd0_n: supplied by vcc_3v3
[    1.591745] vcc_3v3: could not add device link regulator.19: -2
[    1.591869] rockchip-iodomain fdc20000.syscon:io-domains: Looking up pmuio2-supply from device tree
[    1.592447] mmc_host mmc1: Bus speed (slot 0) = 375000Hz (slot req 375000Hz, actual 375000HZ div = 0)
[    1.592871] vcc3v3_lcd0_n: 3300 mV, enabled
[    1.593158] reg-fixed-voltage regulator-vcc3v3-lcd0: vcc3v3_lcd0_n supplying 3300000uV
[    1.594205] rockchip-iodomain fdc20000.syscon:io-domains: Looking up vccio1-supply from device tree
[    1.596966] input: Hynitron cst3xx Touchscreen as /devices/platform/fe5b0000.i2c/i2c-2/2-001a/input/input2
[    1.597017] rockchip-iodomain fdc20000.syscon:io-domains: Looking up vccio2-supply from device tree
[    1.598636] rockchip-iodomain fdc20000.syscon:io-domains: Looking up vccio2-supply property in node /syscon@fdc20000/io-domains failed
[    1.599771] rockchip-iodomain fdc20000.syscon:io-domains: Looking up vccio3-supply from device tree
[    1.601871] rockchip-iodomain fdc20000.syscon:io-domains: Looking up vccio4-supply from device tree
[    1.603879] rockchip-iodomain fdc20000.syscon:io-domains: Looking up vccio5-supply from device tree
[    1.605949] rockchip-iodomain fdc20000.syscon:io-domains: Looking up vccio6-supply from device tree
[    1.607949] rockchip-iodomain fdc20000.syscon:io-domains: Looking up vccio7-supply from device tree
[    1.610450] panel-sitronix-st7703 fe060000.dsi.0: Looking up vcc-supply from device tree
[    1.611196] panel-sitronix-st7703 fe060000.dsi.0: Looking up vcc-supply property in node /dsi@fe060000/panel@0 failed
[    1.612199] panel-sitronix-st7703 fe060000.dsi.0: supply vcc not found, using dummy regulator
[    1.613199] panel-sitronix-st7703 fe060000.dsi.0: Looking up iovcc-supply from device tree
[    1.613971] panel-sitronix-st7703 fe060000.dsi.0: Looking up iovcc-supply property in node /dsi@fe060000/panel@0 failed
[    1.614980] panel-sitronix-st7703 fe060000.dsi.0: supply iovcc not found, using dummy regulator
[    1.617104] rockchip-drm display-subsystem: bound fe040000.vop (ops vop2_component_ops)
[    1.618212] dwhdmi-rockchip fe0a0000.hdmi: Looking up avdd-0v9-supply from device tree
[    1.618978] dwhdmi-rockchip fe0a0000.hdmi: Looking up avdd-0v9-supply property in node /hdmi@fe0a0000 failed
[    1.619883] dwhdmi-rockchip fe0a0000.hdmi: supply avdd-0v9 not found, using dummy regulator
[    1.620884] dwhdmi-rockchip fe0a0000.hdmi: Looking up avdd-1v8-supply from device tree
[    1.621605] dwhdmi-rockchip fe0a0000.hdmi: Looking up avdd-1v8-supply property in node /hdmi@fe0a0000 failed
[    1.622503] dwhdmi-rockchip fe0a0000.hdmi: supply avdd-1v8 not found, using dummy regulator
[    1.623581] dwhdmi-rockchip fe0a0000.hdmi: Detected HDMI TX controller v2.11a with HDCP (DWC HDMI 2.0 TX PHY)
[    1.626362] Registered IR keymap rc-cec
[    1.626911] rc rc0: dw_hdmi as /devices/platform/fe0a0000.hdmi/rc/rc0
[    1.627742] input: dw_hdmi as /devices/platform/fe0a0000.hdmi/rc/rc0/input3
[    1.629079] rockchip-drm display-subsystem: bound fe0a0000.hdmi (ops dw_hdmi_rockchip_ops)
[    1.630505] rockchip-drm display-subsystem: bound fe060000.dsi (ops dw_mipi_dsi_rockchip_ops)
[    1.632743] [drm] Initialized rockchip 1.0.0 20140818 for display-subsystem on minor 0
[    1.676727] mmc_host mmc3: Bus speed (slot 0) = 375000Hz (slot req 400000Hz, actual 375000HZ div = 0)
[    1.694087] mmc_host mmc1: Bus speed (slot 0) = 150000000Hz (slot req 150000000Hz, actual 150000000HZ div = 0)
[    1.696810] dwmmc_rockchip fe000000.mmc: card claims to support voltages below defined range
[    1.708218] mmc_host mmc3: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000HZ div = 0)
[    1.709758] mmc3: new high speed SDIO card at address 0001
[    1.844831] dwmmc_rockchip fe2b0000.mmc: Successfully tuned phase to 318
[    1.844868] mmc1: new ultra high speed SDR104 SDHC card at address aaaa
[    1.846078] mmcblk1: mmc1:aaaa SC32G 29.7 GiB
[    1.854076] GPT:Primary header thinks Alt. header is not at the end of the disk.
[    1.854091] GPT:1171495 != 62333951
[    1.854100] GPT:Alternate GPT header not at the end of the disk.
[    1.854104] GPT:1171495 != 62333951
[    1.854110] GPT: Use GNU Parted to correct GPT errors.
[    1.854161]  mmcblk1: p1 p2
[    1.953482] Console: switching to colour frame buffer device 80x30
[    1.995853] rockchip-drm display-subsystem: [drm] fb0: rockchipdrmfb frame buffer device
[    1.997513] panel-sitronix-st7703 fe060000.dsi.0: 640x480@60 24bpp dsi 4dl - ready
[    1.998927] display-connector hdmi-con: Looking up hdmi-pwr-supply from device tree
[    1.999747] display-connector hdmi-con: Looking up hdmi-pwr-supply property in node /hdmi-con failed
[    2.001560] panfrost fde60000.gpu: clock rate = 594000000
[    2.002087] panfrost fde60000.gpu: bus_clock rate = 500000000
[    2.002679] panfrost fde60000.gpu: Looking up mali-supply from device tree
[    2.009111] panfrost fde60000.gpu: mali-g52 id 0x7402 major 0x1 minor 0x0 status 0x0
[    2.009819] panfrost fde60000.gpu: features: 00000000,00000cf7, issues: 00000000,00000400
[    2.010546] panfrost fde60000.gpu: Features: L2:0x07110206 Shader:0x00000002 Tiler:0x00000209 Mem:0x1 MMU:0x00002823 AS:0xff JS:0x7
[    2.011592] panfrost fde60000.gpu: shader_present=0x1 l2_present=0x1
[    2.014681] [drm] Initialized panfrost 1.2.0 20180908 for fde60000.gpu on minor 1
[    2.016146] input: adc-keys as /devices/platform/adc-keys/input/input4
[    2.019066] cpu cpu0: Looking up cpu-supply from device tree
[    2.030811] simple-amplifier audio-amplifier: Looking up VCC-supply from device tree
[    2.031511] simple-amplifier audio-amplifier: Looking up VCC-supply property in node /audio-amplifier failed
[    2.032400] simple-amplifier audio-amplifier: supply VCC not found, using dummy regulator
[    2.059673] input: rk817_ext Headphones as /devices/platform/sound/sound/card0/input5
[    2.061547] input: adc-joystick as /devices/platform/adc-joystick/input/input6
[    2.066671] input: gpio-keys-control as /devices/platform/gpio-keys-control/input/input7
[    2.068364] input: gpio-keys-vol as /devices/platform/gpio-keys-vol/input/input8
[    2.069595] clk: Disabling unused clocks
[    2.070417] ALSA device list:
[    2.070683]   #0: rk817_ext
[    2.071115] dw-apb-uart fe660000.serial: forbid DMA for kernel console
[    2.081265] Freeing unused kernel memory: 13504K
[    2.088838] Run /init as init process
[    2.089179]   with arguments:
[    2.089452]     /init
[    2.089661]   with environment:
[    2.089946]     HOME=/
[    2.090162]     TERM=linux
Saving 256 bits of non-creditable seed for next boot
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Starting network: OK

ANB_RG353
ANB_RG353 login: root
Password: 
# ls /
bin      init     linuxrc  opt      run      tmp
dev      lib      media    proc     sbin     usr
etc      lib64    mnt      root     sys      var
# 
```


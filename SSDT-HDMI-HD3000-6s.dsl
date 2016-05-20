/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20131218-64 [Jan  8 2014]
 * Copyright (c) 2000 - 2013 Intel Corporation
 * 
 * Disassembly of iASLCdfKwM.aml, Sat May 21 00:18:12 2016
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000129 (297)
 *     Revision         0x01
 *     Checksum         0x3E
 *     OEM ID           "syscl"
 *     OEM Table ID     "H67hack"
 *     OEM Revision     0x00003000 (12288)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20130725 (538117925)
 */
DefinitionBlock ("iASLCdfKwM.aml", "SSDT", 1, "syscl", "H67hack", 0x00003000)
{
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.B0D3._ADR)
    External (_SB_.PCI0.GFX0._ADR)

    Method (XOSI, 1, NotSerialized)
    {
        Return (LEqual (Arg0, "Windows 2009"))
    }

    Scope (\_SB.PCI0)
    {
        Device (HDAU)
        {
            Name (_ADR, 0x00030000)  // _ADR: Address
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                Store (Zero, \_SB.PCI0.B0D3._ADR)
            }

            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If (LEqual (Arg2, Zero))
                {
                    Return (Buffer (One)
                    {
                         0x03
                    })
                }

                Return (Package (0x04)
                {
                    "hda-gfx", 
                    Buffer (0x0A)
                    {
                        "onboard-1"
                    }, 

                    "layout-id", 
                    Buffer (0x04)
                    {
                         0x03, 0x00, 0x00, 0x00
                    }
                })
            }
        }
                
        Name (GFX0._STA, Zero)  // _STA: Status
        Device (IGPU)
        {
            Name (_ADR, 0x00020000)  // _ADR: Address
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                Store (Zero, \_SB.PCI0.GFX0._ADR)
            }
            Method (_DSM, 4, NotSerialized)
            {
                If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
                Return (Package()
                {
                    "AAPL,snb-platform-id", Buffer() { 0x00, 0x00, 0x01, 0x00 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "AAPL00,DualLink", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                })
            }

            
        }
    }
    
    Scope (_SB)
    {
        Device (PCI0)
        {
            Device (MCHC)
            {
                Name (_ADR, Zero)
            }
            Device (IMEI)
            {
                Name (_ADR, 0x00160000)
            }
        }
    }

    Scope (_SB.PCI0)
    {
        Device (SBUS)
        {
            Device (BUS0)
            {
                Name (_CID, "smbus")
                Name (_ADR, Zero)
                Device (DVL0)
                {
                    Name (_ADR, 0x57)
                    Name (_CID, "diagsvault")
                    Method (_DSM, 4, NotSerialized)
                    {
                        If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
                        Return (Package() { "address", 0x57 })
                    }
                }
            }
            
        }
    }
        
    Store ("SSDT-HDMI-HD3000-6s.aml github.com/syscl/ASUS-H67-series", Debug)
}


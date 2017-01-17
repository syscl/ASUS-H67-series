// HDMI inject properties for Asus H67 Series
// Note HD4000 on 6 series
DefinitionBlock ("", "SSDT", 1, "APPLE ", "H67hack", 0x00003000)
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
        
    Store ("SSDT-HDMI-HD4000-6s.aml github.com/syscl/ASUS-H67-series", Debug)
}


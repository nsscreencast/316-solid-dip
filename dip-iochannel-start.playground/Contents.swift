import Foundation

class IOChannel {
    static let THERMOMETER: UInt8 = 0x86
    static let FURNACE: UInt8 = 0x87
    static let CMD_ENGAGE: UInt8 = 1
    static let CMD_DISENGAGE: UInt8 = 0
    
    func read(_ val: UInt8) -> Float {
        // ......
        return 74.0
    }
    
    func out(_ address: UInt8, _ val: UInt8) {
        // ......
    }
}

class Regulator {
    private let channel = IOChannel()
    var stop = false
    
    func regulate(minTemp: Float, maxTemp: Float) {
        while !stop {
            while (channel.read(IOChannel.THERMOMETER) > minTemp) {
                sleep(1)
            }
            channel.out(IOChannel.FURNACE, IOChannel.CMD_ENGAGE)
            while (channel.read(IOChannel.THERMOMETER) < maxTemp) {
                sleep(1)
            }
            channel.out(IOChannel.FURNACE, IOChannel.CMD_DISENGAGE)
        }
    }
}



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

protocol Thermometer {
    func temperature() -> Float
}

protocol Heater {
    func engage()
    func disengage()
}

class IOChannelThermometer : Thermometer {
    private let channel: IOChannel
    
    init(channel: IOChannel) {
        self.channel = channel
    }
    
    func temperature() -> Float {
        return channel.read(IOChannel.THERMOMETER)
    }
}

class IOChannelFurnace : Heater {
    private let channel: IOChannel
    
    init(channel: IOChannel) {
        self.channel = channel
    }
    
    func engage() {
        channel.out(IOChannel.FURNACE, IOChannel.CMD_ENGAGE)
    }
    
    func disengage() {
        channel.out(IOChannel.FURNACE, IOChannel.CMD_DISENGAGE)
    }
}

class Regulator {
    private let thermometer: Thermometer
    private let heater: Heater
    var stop = false
    
    init(thermometer: Thermometer, heater: Heater) {
        self.thermometer = thermometer
        self.heater = heater
    }
    
    func regulate(minTemp: Float, maxTemp: Float) {
        while !stop {
            while (thermometer.temperature() > minTemp) {
                sleep(1)
            }
            heater.engage()
            while (thermometer.temperature() < maxTemp) {
                sleep(1)
            }
            heater.disengage()
        }
    }
}

let channel = IOChannel()
let thermometer = IOChannelThermometer(channel: channel)
let heater = IOChannelFurnace(channel: channel)
let regulator = Regulator(thermometer: thermometer, heater: heater)


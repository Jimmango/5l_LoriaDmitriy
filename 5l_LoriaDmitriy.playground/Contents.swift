import UIKit

enum windows: String {
    case open = "открыты"
    case close = "закрыты"
}
enum engine: String {
    case run = "заведен"
    case stop = "заглушен"
}
/* 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия. */

protocol Car {
    var brand: String { get }
    var year: Int { get }
    var status: Bool { get }
    var windows: windows { get set }
    var engine: engine { get set }
    
    func action(num:Int)
}
/* 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей). */

extension Car {
    func windowStatus(status: windows){
        switch status {
        case .open:
            print("Окна открыты")
        case .close:
            print("Окна закрыты")
        }
    }
    
    func engineStatus(status: engine){
        switch status {
        case .run:
            print("Двигатель заведен")
        case .stop:
            print("Двигатель заглушен")
        }
    }
}

/* 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны. */

class TrunkCar: Car {
    var windows: windows
    var engine: engine
    var status: Bool
    var year: Int
    var brand: String
    private var loadWeight: Int
    var trunkVolume: Int
    
    init(status: Bool, year: Int, brand: String, windows: windows, engine: engine, trunkVolume: Int) {
        self.status = status
        self.year = year
        self.brand = brand
        self.loadWeight = 0
        self.trunkVolume = trunkVolume
        self.engine = engine
        self.windows = windows
    }
    
    func action(num: Int) {
        loadWeight = num
        if trunkSpareSpace > loadWeight {
            print("Богажник заполнен! Больше ничего не помещается!")
        } else {
            trunkSpareSpace - loadWeight
            print(" Осталось \(trunkSpareSpace) литров богажного отделения")
        }
    }
}

class SportCar: Car {
    var windows: windows
    var engine: engine
    var status: Bool
    var year: Int
    var brand: String
    var speed: Int
    var maxSpeed: Int

    init(status: Bool, year: Int, brand: String, speed: Int, maxSpeed: Int, windows: windows, engine: engine) {
        self.status = status
        self.year = year
        self.brand = brand
        self.windows = windows
        self.engine = engine
        self.speed = speed
        self.maxSpeed = maxSpeed
    }
    
    func action(num: Int) {
        speed = num
        if maxSpeed < speed {
            print("Нельзя разогнаться до скорости в \(speed)км/ч.")
        } else {
            print("Можно разогнаться до скорости \(speed)км/ч, так как максимальная скорость \(maxSpeed)км/ч")
        }
    }
}

/* 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible. */

extension TrunkCar: CustomStringConvertible {
    var trunkSpareSpace: Int {
        get {
            return trunkVolume - loadWeight
        }
    }
    var description: String {
        return "Грузовой автомобиль \(brand)\n" +
        "год выпуска \(year)\n" +
        "двигататель \(engine.rawValue)\n" +
        "окна \(windows.rawValue)\n" +
        "объем богажника составляет \(trunkVolume) литров\n" +
        "богажник заполнен на \(trunkVolume - trunkSpareSpace) литров"
    }
}

extension SportCar: CustomStringConvertible {
    var maxSpeedCoverage: Int {
        get {
            return maxSpeed - speed
        }
    }
    var description: String {
        return "Спортивный автомобиль \(brand)\n" +
        "год выпуска \(year)\n" +
        "двигататель \(engine.rawValue)\n" +
        "окна \(windows.rawValue)\n" +
        "Максимальная скорость автомобиля \(maxSpeed)км/ч\n" +
        "Текущая скорость \(speed) км/ч"
    }
}

/* 5. Создать несколько объектов каждого класса. Применить к ним различные действия. */

var trunkCar = TrunkCar(status: true, year: 2020, brand: "Ford", windows: .close, engine: .stop, trunkVolume: 1000)

var sportCar = SportCar(status: true, year: 2021, brand: "Audi", speed: 100, maxSpeed: 280, windows: .close, engine: .run)

trunkCar.action(num:900)
//print(trunkCar.description)
//trunkCar.windowStatus(status: .open)
//
sportCar.action(num: 200)

sportCar.windowStatus(status: .open)
print(sportCar.description)

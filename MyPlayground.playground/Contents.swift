//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"
var x : String? = nil
if var y = x{
    print("This garbage is nil")
}
print(1...100)
for var v in 1...100{
    print(v)
}
 class Robot
{
     var x: String? = ""
    var y: String? = ""
    let z: String? = ""
    static var someStatic = "Some static"
    static let stat: Int = 190
    
}
class Terminator : Robot{
    override var x : String? {
        get{return "Some text"}
        set{}
    }
    
}
struct Transformer
{
    var head: Robot
    let x = ""
    static let x = 100
    static var y = 100
    var body: Robot
}
var robot = Robot()
robot.x = "My Y"
robot.y = "My X"
Robot.someStatic = "Onother text"
let rob = robot
let t = Transformer(head:robot, body:rob)
if "abc" == "bcd"
{
    print("This is weird")
}
if robot === rob{
    print("Some staff")
}
if robot === rob{
    print("They are the same")
}


protocol protocolX
{
    var y:String {get set}
    var x: String{set get}
    static var z: String{set get}
    func f(g: (Int, Int, Int) -> (String, String, String)) -> Int
    
    
}
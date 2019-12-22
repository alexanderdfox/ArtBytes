import Cocoa

func art2binary(file: URL) {
    let image = NSImage(contentsOf: file)
    let img = NSBitmapImageRep(data: image!.tiffRepresentation!);
    let white = NSColor(calibratedRed: 1, green: 1, blue: 1, alpha: 1)  // bit 0
    let black = NSColor(calibratedRed: 0, green: 0, blue: 0, alpha: 1) // bit 1
    let red = NSColor(calibratedRed: 1, green: 0, blue: 0, alpha: 1) // bit 2
    let green = NSColor(calibratedRed: 0, green: 1, blue: 0, alpha: 1) // bit 3
    let blue = NSColor(calibratedRed: 0, green: 0, blue: 1, alpha: 1) // bit 4
    let purple = NSColor(calibratedRed: 1, green: 0, blue: 1, alpha: 1)  // bit 5
    let yellow = NSColor(calibratedRed: 1, green: 1, blue: 0, alpha: 1)  // bit 6
    let teal = NSColor(calibratedRed: 0, green: 1, blue: 1, alpha: 1)  // bit 7
    let gray = NSColor(calibratedRed: 0.5, green: 0.5, blue: 0.5, alpha: 1)  // noBit
    
    let height = Int(image!.size.height)
    let width = Int(image!.size.width)
    
    var i = 0
    for x in 0..<height {
        for y in 0..<width {
            image!.lockFocus()
            let color = img!.colorAt(x: x, y: y)
            image!.unlockFocus()
            if color == white {
                print("0")
            }
            else if color == black {
                print("1")
            }
            else if color == red {
                print("2")
            }
            else if color == green {
                print("3")
            }
            else if color == blue {
                print("4")
            }
            else if color == purple {
                print("5")
            }
            else if color == yellow {
                print("6")
            }
            else if color == teal {
                print("7")
            }
            else if color == gray {
                print("")
            }
            else {
                print(color)
                print(white)
            }
            i += 1
        }
    }
}

let input = CommandLine.arguments[1]
//let output = CommandLine.arguments[2]

let inputFile = URL(fileURLWithPath: input)
//let outputFile = URL(fileURLWithPath: output)

art2binary(file: inputFile)

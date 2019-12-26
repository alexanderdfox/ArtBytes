import Cocoa

func art2binary(file: URL) {
    let image = NSImage(contentsOf: file)
    let img = NSBitmapImageRep(data: image!.tiffRepresentation!);
    let height = Int(img!.size.height)
    let width = Int(img!.size.width)
    var i = 0
    for y in (0..<height).reversed() {
        for x in 0..<width {
            print("x:\(x) y:\(y)")
            let color = img!.colorAt(x: (x * 2), y: (y * 2) )
            if color == NSColor.white {
                print("0")
            }
            else if color == NSColor.black {
                print("1")
            }
            else if color == NSColor.red {
                print("2")
            }
            else if color == NSColor.green {
                print("3")
            }
            else if color == NSColor.blue {
                print("4")
            }
            else if color == NSColor.magenta {
                print("5")
            }
            else if color == NSColor.yellow {
                print("6")
            }
            else if color == NSColor.cyan {
                print("7")
            }
            else if color == NSColor.gray {
                print(" ")
            }
            else {
                if CGFloat(color!.redComponent) > 0.9 && CGFloat(color!.greenComponent) > 0.9 && CGFloat(color!.blueComponent) > 0.9 {
                    print("0")
                }
                else if CGFloat(color!.redComponent) < 0.1 && CGFloat(color!.greenComponent) < 0.1 && CGFloat(color!.blueComponent) < 0.1 {
                    print("1")
                }
                else if CGFloat(color!.redComponent) > 0.9 && CGFloat(color!.greenComponent) < 0.2 && CGFloat(color!.blueComponent) < 0.2 {
                    print("2")
                }
                else if CGFloat(color!.redComponent) < 0.5 && CGFloat(color!.greenComponent) > 0.9 && CGFloat(color!.blueComponent) < 0.3 {
                    print("3")
                }
                else if CGFloat(color!.redComponent) < 0.1 && CGFloat(color!.greenComponent) < 0.2 && CGFloat(color!.blueComponent) > 0.9 {
                    print("4")
                }
                else if CGFloat(color!.redComponent) > 0.9 && CGFloat(color!.greenComponent) < 0.3 && CGFloat(color!.blueComponent) > 0.9 {
                    print("5")
                }
                else if CGFloat(color!.redComponent) > 0.9 && CGFloat(color!.greenComponent) > 0.9 && CGFloat(color!.blueComponent) < 0.4 {
                    print("6")
                }
                else if CGFloat(color!.redComponent) < 0.6 && CGFloat(color!.greenComponent) > 0.9 && CGFloat(color!.blueComponent) > 0.9 && CGFloat(color!.redComponent) > 0.4 {
                    print("7")
                }
                else if CGFloat(color!.redComponent) < 0.6 && CGFloat(color!.greenComponent) < 0.6 && CGFloat(color!.blueComponent) < 0.6 && CGFloat(color!.redComponent) > 0.4 && CGFloat(color!.greenComponent) > 0.4 && CGFloat(color!.blueComponent) > 0.4 {
                    print(" ")
                }
                else {
                    print("Red: \(color!.redComponent)")
                    print("Green: \(color!.greenComponent)")
                    print("Blue: \(color!.blueComponent)")
                }
            }
            i += 1
        }
    }
//    print("\(width) by \(height)")
}

let input = CommandLine.arguments[1]
//let output = CommandLine.arguments[2]

let inputFile = URL(fileURLWithPath: input)
//let outputFile = URL(fileURLWithPath: output)

art2binary(file: inputFile)

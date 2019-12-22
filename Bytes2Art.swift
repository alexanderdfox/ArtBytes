import Cocoa

func code2art(width: Int, height: Int, data: Data) -> NSImage {
    let white = NSColor(calibratedRed: 1, green: 1, blue: 1, alpha: 1)  // bit 0
    let black = NSColor(calibratedRed: 0, green: 0, blue: 0, alpha: 1) // bit 1
    let red = NSColor(calibratedRed: 1, green: 0, blue: 0, alpha: 1) // bit 2
    let green = NSColor(calibratedRed: 0, green: 1, blue: 0, alpha: 1) // bit 3
    let blue = NSColor(calibratedRed: 0, green: 0, blue: 1, alpha: 1) // bit 4
    let purple = NSColor(calibratedRed: 1, green: 0, blue: 1, alpha: 1)  //bit 5
    let yellow = NSColor(calibratedRed: 1, green: 1, blue: 0, alpha: 1)  //bit 6
    let teal = NSColor(calibratedRed: 0, green: 1, blue: 1, alpha: 1)  //bit 7
    let clear = NSColor(calibratedRed: 0.5, green: 0.5, blue: 0.5, alpha: 1)  // noData
    
    let rectSize = NSSize(width: width, height: height) // size of code page
    
    let bit = NSImage(size: rectSize) // bit
    var color: NSColor = white
    var x = 0
    var y = 0
    bit.lockFocus()
    clear.drawSwatch(in: NSMakeRect(CGFloat(x),CGFloat(y),CGFloat(width),CGFloat(height)))
    bit.unlockFocus()

    for s in data {
        let byte = String(s, radix: 8)
        for b in byte {
            print(b)
            if b == "0" {
                color = white
            }
            else if b == "1" {
                color = black
            }
            else if b == "2" {
                color = red
            }
            else if b == "3" {
                color = green
            }
            else if b == "4" {
                color = blue
            }
            else if b == "5" {
                color = purple
            }
            else if b == "6" {
                color = yellow
            }
            else if b == "7" {
                color = teal
            }

            print(b)
            bit.lockFocus()
            color.drawSwatch(in: NSMakeRect(CGFloat(x),CGFloat(y),1,1))
            bit.unlockFocus()
            x += 1
            if x >= width {
                x = 0
                y += 1
            }
        }
        x += 1
        if x >= width {
            x = 0
            y += 1
        }
    }
    
    return bit
}

extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }

    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }

    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }

    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}

extension NSImage {
    var pngData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        return bitmapImage.representation(using: .png, properties: [:])
    }
    func pngWrite(to url: URL ) -> Bool {
        do {
            try pngData?.write(to: url)
            return true
        } catch {
            print(error)
            return false
        }
    }
}


func run() {
    let input = CommandLine.arguments[1]
    let output = CommandLine.arguments[2]

    let file = URL(fileURLWithPath: input)
    let data = NSData(contentsOf: file)
    let w = Int(sqrt(Float(file.fileSize)) * sqrt(5))
    let h = Int(sqrt(Float(file.fileSize)) * sqrt(5))

    let image = code2art(width: w, height: h, data: data! as Data)

    let destinationURL = URL(fileURLWithPath: output)
    if image.pngWrite(to: destinationURL) {
        print("File saved")
    }
}

run()

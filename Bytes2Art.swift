import Cocoa

func code2art(width: Int, height: Int, data: Data) -> NSImage {
    let rectSize = NSSize(width: width, height: height) // size of code page
    
    let bit = NSImage(size: rectSize) // bit
    var color: NSColor = NSColor.gray
    var x = 0
    var y = 0
    bit.lockFocus()
    color.drawSwatch(in: NSMakeRect(CGFloat(x),CGFloat(y),CGFloat(width),CGFloat(height)))
    bit.unlockFocus()

    for s in data {
        let byte = String(s, radix: 8)
        for b in byte {
            if b == "0" {
                color = NSColor.white
            }
            else if b == "1" {
                color = NSColor.black
            }
            else if b == "2" {
                color = NSColor.red
            }
            else if b == "3" {
                color = NSColor.green
            }
            else if b == "4" {
                color = NSColor.blue
            }
            else if b == "5" {
                color = NSColor.magenta
            }
            else if b == "6" {
                color = NSColor.yellow
            }
            else if b == "7" {
                color = NSColor.cyan
            }
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

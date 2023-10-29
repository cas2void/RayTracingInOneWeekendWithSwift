//
//  Film.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/10/19.
//

import Foundation
import ImageIO
import UniformTypeIdentifiers

struct Film {
    private var buffer: [[Color]]
    
    init(width: Int, height: Int) {
        assert(width > 0 && height > 0)
        
        self.buffer = Array(repeating: Array(repeating: Color(), count: width), count: height)
    }
    
    var width: Int {
        buffer[0].count
    }
    
    var height: Int {
        buffer.count
    }
    
    mutating func sense(x: Int, y: Int, color: Color) {
        buffer[y][x] = color;
    }
    
    func savePNG(name: String) {
        let numChannel = 4
        let bitsPerChannel = UInt8.bitWidth
        let maxChannelValue = powf(2, Float(bitsPerChannel)) - 1
        let capacity = width * height * numChannel
        
        let rawBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: capacity)
        for x in 0..<width {
            for y in 0..<height {
                let index = (y * width + x) * numChannel
                let saturatedColor = buffer[y][x].saturated()
                rawBuffer[index] = UInt8(saturatedColor.r * maxChannelValue)
                rawBuffer[index + 1] = UInt8(saturatedColor.g * maxChannelValue)
                rawBuffer[index + 2] = UInt8(saturatedColor.b * maxChannelValue)
                rawBuffer[index + 3] = UInt8(saturatedColor.a * maxChannelValue)
            }
        }
        
        let data = CFDataCreate(nil, rawBuffer, capacity)
        rawBuffer.deallocate()
        
        guard let data = data,
              let dataProvider = CGDataProvider(data: data) else {
            print("Data provider creation failed")
            return
        }
        
        guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
            print("Color space creation faield")
            return
        }
        
        guard let image =
                CGImage(
                    width: width,
                    height: height,
                    bitsPerComponent: bitsPerChannel,
                    bitsPerPixel: bitsPerChannel * numChannel,
                    bytesPerRow: width * numChannel * bitsPerChannel / 8,
                    space: colorSpace,
                    bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipLast.rawValue),
                    provider: dataProvider,
                    decode: nil,
                    shouldInterpolate: false,
                    intent: CGColorRenderingIntent.defaultIntent) else {
            print("Image creation failed")
            return
        }
        
        let url = URL(fileURLWithPath: name + ".png")
        guard let destination =
                CGImageDestinationCreateWithURL(
                    url as CFURL,
                    UTType.png.identifier as CFString,
                    1,
                    nil) else {
            print("Image destination creation failed")
            return
        }
        CGImageDestinationAddImage(destination, image, nil)
        CGImageDestinationFinalize(destination)
        
        print("Image saved: \(url.absoluteString)")
    }
}

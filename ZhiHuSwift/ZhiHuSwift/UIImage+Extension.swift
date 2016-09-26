//
//  UIImage+Extension.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/18.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import Foundation
import Accelerate

extension UIImage {
    /// 高斯模糊
    func gaussianBlur(var blurAmount:CGFloat) -> UIImage {
        //高斯模糊参数(0-1)之间，超出范围强行转成0.5
        if (blurAmount < 0.0 || blurAmount > 1.0) {
            blurAmount = 0.5
        }
        
        var boxSize = Int(blurAmount * 40)
        boxSize = boxSize - (boxSize % 2) + 1
        
        let img = self.CGImage
    
        var inBuffer:vImage_Buffer = vImage_Buffer()
        var outBuffer:vImage_Buffer = vImage_Buffer()
        
        let inProvider =  CGImageGetDataProvider(img)
        let inBitmapData =  CGDataProviderCopyData(inProvider)
        
        inBuffer.width = vImagePixelCount(CGImageGetWidth(img))
        inBuffer.height = vImagePixelCount(CGImageGetHeight(img))
        inBuffer.rowBytes = CGImageGetBytesPerRow(img)
        inBuffer.data = UnsafeMutablePointer<Void>(CFDataGetBytePtr(inBitmapData))
        
        //手动申请内存
        let pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img))
        
        outBuffer.width = vImagePixelCount(CGImageGetWidth(img))
        outBuffer.height = vImagePixelCount(CGImageGetHeight(img))
        outBuffer.rowBytes = CGImageGetBytesPerRow(img)
        outBuffer.data = pixelBuffer
        
        var error = vImageBoxConvolve_ARGB8888(&inBuffer,
            &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
            UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        if (kvImageNoError != error)
        {
            error = vImageBoxConvolve_ARGB8888(&inBuffer,
                &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
            if (kvImageNoError != error)
            {
                error = vImageBoxConvolve_ARGB8888(&inBuffer,
                    &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                    UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
            }
        }
        
        let colorSpace =  CGColorSpaceCreateDeviceRGB()
        let ctx = CGBitmapContextCreate(outBuffer.data,
            Int(outBuffer.width),
            Int(outBuffer.height),
            8,
            outBuffer.rowBytes,
            colorSpace,
            CGImageAlphaInfo.PremultipliedLast.rawValue)
        
        let imageRef = CGBitmapContextCreateImage(ctx)
        
        //手动申请内存
        free(pixelBuffer)
        return UIImage(CGImage: imageRef!)
    }
}

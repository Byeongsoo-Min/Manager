//
//  BasicOCR.swift
//  Manager
//
//  Created by MBSoo on 11/12/24.
//

import Foundation

struct BasicOCR: Codable {
    let version: String
    let requestId: String
    let timestamp: Int
    let images: [Image]
        
    struct Image: Codable {
        let uid: String
        let name: String
        let inferResult: String
        let message: String
        let validationResult: ValidationResult
        let convertedImageInfo: ConvertedImageInfo
        let fields: [Field]
        
        struct ValidationResult: Codable {
            let result: String
        }
        
        struct ConvertedImageInfo: Codable {
            let width: Int
            let height: Int
            let pageIndex: Int
            let longImage: Bool
        }
        
        struct Field: Codable {
            let valueType: String
            let inferText: String
            let inferConfidence: Double
            let type: String
            let lineBreak: Bool
            let boundingPoly: BoundingPoly
            
            struct BoundingPoly: Codable {
                let vertices: [Vertex]
                
                struct Vertex: Codable {
                    let x: Double
                    let y: Double
                }
            }
        }
    }
}

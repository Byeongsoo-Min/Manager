//
//  TemplateOCR.swift
//  Manager
//
//  Created by MBSoo on 11/12/24.
//

import Foundation

struct TemplateOCR: Decodable {
    let version: String?
    let requestId: String?
    let timestamp: Int?
    let images: [Image]?
    
    struct Image: Decodable {
        let uid: String
        let name: String
        let inferResult: String
        let message: String
        let validationResult: ValidationResult
        let nameCard: NameCard?
        
        struct ValidationResult: Decodable {
            let result: String
        }
        
        struct NameCard: Decodable {
            let meta: Meta
            let result: Result
            
            struct Meta: Decodable {
                let estimatedLanguage: String
            }
            
            struct Result: Decodable {
                let name: [TextInfo]
                let company: [TextInfo]
                let address: [TextInfo]
                let position: [TextInfo]
                let mobile: [TextInfo]
                let tel: [TextInfo]
                let fax: [TextInfo]
                let email: [TextInfo]
                
                struct TextInfo: Decodable {
                    let text: String
                    let keyText: String
                    let confidenceScore: Double
                    let boundingPolys: [BoundingPoly]
                    let maskingPolys: [MaskingPoly]?
                    
                    struct BoundingPoly: Decodable {
                        let vertices: [Vertex]
                        
                        struct Vertex: Decodable {
                            let x: Double
                            let y: Double
                        }
                    }
                    
                    struct MaskingPoly: Decodable {
                        let vertices: [Vertex]
                        
                        struct Vertex: Decodable {
                            let x: Double
                            let y: Double
                        }
                    }
                }
            }
        }
    }
}



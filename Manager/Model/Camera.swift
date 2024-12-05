//
//  Camera.swift
//  Manager
//
//  Created by MBSoo on 11/12/24.
//

import Foundation
import AVFoundation
import Alamofire
import UIKit


class Camera: NSObject, ObservableObject {
    var session = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    let output = AVCapturePhotoOutput()
    var photoData = Data(count: 0)
    var isSilentModeOn = false
    var isReturn:Bool
    var flashMode: AVCaptureDevice.FlashMode = .off
    
    let templateOCRAPIKEY = Storage().OCRTEMPLATEAPIKEY
    let basicOCRAPIKEY = Storage().OCRBASICAPIKEY
    
    // Template OCR 주소
    let templateOCRUrl = "https://awikwsm4xg.apigw.ntruss.com/custom/v1/35752/218024e307346066a6314dbb5eaff689b7b58258d9f52729e655e15203a204e6/document/name-card"
    // Template 없는 Basic OCR 주소
    let basicOCRUrl = "https://i26csbba65.apigw.ntruss.com/custom/v1/35255/8b2085f74dfa9c78a23b7d573c23d27d6d0b0e50c82a9b13138b193325be3814/general"
    
    @Published var isCameraBusy = false
    @Published var recentImage: UIImage?
    @Published var uploadTemplateResponse: TemplateOCR?
    @Published var uploadBasicResponse: BasicOCR?
    
    init(isReturn: Bool) {
        self.isReturn = isReturn
    }
    // 카메라 셋업 과정을 담당하는 함수, positio
    func setUpCamera() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                for: .video, position: .back) {
            do { // 카메라가 사용 가능하면 세션에 input과 output을 연결
                videoDeviceInput = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(videoDeviceInput) {
                    session.addInput(videoDeviceInput)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                    output.isHighResolutionCaptureEnabled = true
                    output.maxPhotoQualityPrioritization = .quality
                }
                session.startRunning() // 세션 시작
            } catch {
                print(error) // 에러 프린트
            }
        }
    }
    
    func requestAndCheckPermissions() {
        // 카메라 권한 상태 확인
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // 권한 요청
            AVCaptureDevice.requestAccess(for: .video) { [weak self] authStatus in
                if authStatus {
                    DispatchQueue.main.async {
                        self?.setUpCamera()
                    }
                }
            }
        case .restricted:
            break
        case .authorized:
            // 이미 권한 받은 경우 셋업
            setUpCamera()
        default:
            // 거절했을 경우
            print("Permession declined")
        }
    }
    func capturePhoto() {
        // 사진 옵션 세팅
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = self.flashMode
        
        self.output.capturePhoto(with: photoSettings, delegate: self)
        print("[Camera]: Photo's taken")
    }
    func savePhoto(_ imageData: Data) {
        guard let image = UIImage(data: imageData) else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        // 사진 저장하기
        print("[Camera]: Photo's saved")
    }
    
    /*명함 OCR 템플릿 이용해서 응답 받기*/
    func uploadTemplatePhoto(imageData: Data) {
//        let token = UserDefaultsManager.shared.getTokens()
        let requestID = UUID().uuidString
        let timestamp = Int(Date().timeIntervalSince1970 * 1000)
        let imageName = timestamp.description + "image"
        let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "X-OCR-SECRET": templateOCRAPIKEY
            ]
        let encodedImage = imageData.base64EncodedString()
        let parameters: [String: Any] = [
            "version": "V2",
            "requestId": requestID,
            "timestamp": timestamp,
            "images": [
                [
                    "format": "jpg",
                    "name": imageName,
                    "data": encodedImage
                ]
            ]
        ]
        AF.request(templateOCRUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: TemplateOCR.self, completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        let companyName = data.images?[0].nameCard?.result.name[0].text
                        let companyNumber = data.images?[0].nameCard?.result.mobile[0].text
                        
                        self.uploadTemplateResponse = data
                        UserDefaultsManager.shared.saveCardInfos(companyName: companyName ?? "경희대학교", companyNumber: companyNumber ?? "010-1111-1111")
                        self.uploadPhotoToSpring(imageData: imageData, templateResponse: data)
                    case .failure(let error):
                        print(error.responseCode)
                        print(error)
                    }
                })
//        AF.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(imageData, withName: "file", fileName: imageName, mimeType: "image/jpeg")
//            for (key, value) in parameters {
//                        if let valueData = "\(value)".data(using: .utf8) {
//                            multipartFormData.append(valueData, withName: key)
//                        }
//                    }
//        },to: URL(string: templateOCRUrl)!, method: .post, headers: headers)
//        .responseDecodable(of: TemplateOCR.self, completionHandler: { response in
//            switch response.result {
//            case .success(let response):
//                self.uploadTemplateResponse = response
//            case .failure(let error):
//                print(error.responseCode)
//                print(error)
//            }
//        })
    }
    
    //Member ID 저장해두고 가져다 써야함
    func uploadPhotoToSpring(imageData: Data, templateResponse: TemplateOCR) {
        let url = URL(string: "http://localhost:8080/api/v1/card/uploads")
        let timestamp = Int(Date().timeIntervalSince1970 * 1000)
        let imageName = timestamp.description + "image"
        guard let companyName = templateResponse.images?[0].nameCard?.result.company[0].text, let companyNumber = templateResponse.images?[0].nameCard?.result.mobile[0].text else {
            return
        }
        let parameters: [String: Any] = [
            "memberId" : 11,
            "companyName": companyName,
            "companyNumber": companyNumber,
            "companyImageUrl": "www.naver.com"
        ]
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: imageName, mimeType: "image/jpeg")
            for (key, value) in parameters {
                if let valueData = "\(value)".data(using: .utf8) {
                    multipartFormData.append(valueData, withName: key)
                }
            }
        },to: url!, method: .post)
        .responseDecodable(of: CardResponse.self, completionHandler: { response in
            switch response.result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.responseCode)
                print(error)
            }
        })
    }
    
    /*서버에서 사진 돌려받기*/
//    func returnPhoto(imageData: Data){
//        let url = URL(string: "http://www.rentalbox.store/items/return")
//        print("return Photo", url)
//        let token = UserDefaultsManager.shared.getTokens()
//        AF.upload(multipartFormData: { MultipartFormData in
//            MultipartFormData.append(imageData, withName: "picture", fileName: "picture", mimeType: "image/jpeg")
//        },to: url!, method: .post, headers: [ "x-access-token": token.accessToken, "Content-Type": "multipart/form-data"])
//        .response { response in
//            switch response.result {
//            case .success(let data):
//                print(data)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
}

extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        self.isCameraBusy = true
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        if isSilentModeOn {
            print("[Camera]: Silent sound activated")
            AudioServicesDisposeSystemSoundID(1108)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        if isSilentModeOn {
            AudioServicesDisposeSystemSoundID(1108)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        UserDefaultsManager.shared.saveCardImages(imageData: imageData)
        self.recentImage = UIImage(data: imageData)
        print("uploadPhoto")
        self.uploadTemplatePhoto(imageData: imageData)
        self.savePhoto(imageData)
        
        print("[CameraModel]: Capture routine's done")
//        print(self.uploadTemplateResponse?.images)
        self.isCameraBusy = false
    }
}


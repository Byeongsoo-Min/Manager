//
//  CameraViewModel.swift
//  Manager
//
//  Created by MBSoo on 11/12/24.
//

import Foundation
import AVFoundation
import SwiftUI
import Combine
import Alamofire

class CameraViewModel: ObservableObject {
    private let model: Camera
    private let session: AVCaptureSession
    let cameraPreview: AnyView
    let hapticImpact = UIImpactFeedbackGenerator()
    
    private var isCameraBusy = false
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var shutterEffect = false
    @Published var recentImage: UIImage?
    @Published var isFlashOn = false
    @Published var isSilentModeOn = false
    @Published var isReturn: Bool?
    func configure() {
        model.requestAndCheckPermissions()
        model.isReturn = self.isReturn ?? false
    }
    
    func switchFlash() {
        isFlashOn.toggle()
        model.flashMode = isFlashOn == true ? .on : .off
    }
    
    func switchSilent() {
        isSilentModeOn.toggle()
        model.isSilentModeOn = isSilentModeOn
    }
    
    func capturePhoto() {
        if isCameraBusy == false {
            hapticImpact.impactOccurred()
                        withAnimation(.easeInOut(duration: 0.1)) {
                            shutterEffect = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                self.shutterEffect = false
                            }
                        }
            model.capturePhoto()
            
            print("[CameraViewModel]: Photo captured!")
        } else {
            print("[CameraViewModel]: Camera's busy.")
        }
    }
    
    func changeCamera() {
        print("[CameraViewModel]: Camera changed!")
    }
    
    init(isReturn: Bool) {
        self.isReturn = isReturn
        model = Camera(isReturn: isReturn)
        session = model.session
        cameraPreview = AnyView(CameraPreviewView(session: session))
        
        model.$recentImage.sink { [weak self] (photo) in
            guard let pic = photo else { return }
            self?.recentImage = pic
        }
        .store(in: &self.subscriptions)
        
        model.$isCameraBusy.sink { [weak self] (result) in
            self?.isCameraBusy = result
        }
        .store(in: &self.subscriptions)
    }
}

//
//  ProfileViewController.swift
//  LiveShow
//
//  Created by 彭根勇 on 2016/12/12.
//  Copyright © 2016年 彭根勇. All rights reserved.
//

import UIKit
import LFLiveKit

class ProfileViewController: UIViewController {
    
    lazy var session: LFLiveSession = {
        let audioConfig = LFLiveAudioConfiguration.default()
        let videoConfig = LFLiveVideoConfiguration.defaultConfiguration(for: .low2, outputImageOrientation: .portrait)
        let session = LFLiveSession(audioConfiguration: audioConfig, videoConfiguration: videoConfig)
        session?.delegate = self
        session?.preView = self.view
        return session!
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let startButton = UIButton(type: .system)
        startButton.setTitle("start", for: .normal)
        startButton.frame = CGRect(x: 80, y: 80, width: 100, height: 40)
        view.addSubview(startButton)
        
        startButton.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
    }
    
    @objc fileprivate func startButtonClick() {
        
        let stream = LFLiveStreamInfo()
//        stream.url = "rtmp://60.205.190.199:1935/live/demo"
        stream.url = "rtmp://60.205.190.199:1935/hls/demo"
        session.startLive(stream)
        session.running = true
    }

}

extension ProfileViewController: LFLiveSessionDelegate {
    
    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        print("debugInfo: \(debugInfo)")
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        print("errorCode: \(errorCode)")
    }
    
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        
        
        switch state {
        case .pending:
            print("pending")
        case .ready:
            print("ready")
        case .refresh:
            print("refresh")
        case .error:
            print("error")
        case .start:
            print("start")
        case .stop:
            print("stop")
        }
        
//        print("stateChanged: \(state)")
    }
    
}

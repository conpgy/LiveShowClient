//
//  DiscoverViewController.swift
//  LiveShow
//
//  Created by 彭根勇 on 2016/12/12.
//  Copyright © 2016年 彭根勇. All rights reserved.
//

import UIKit
import AVFoundation

class DiscoverViewController: UIViewController {
    
    fileprivate lazy var session = AVCaptureSession()
    fileprivate var videoOutput: AVCaptureVideoDataOutput!
    fileprivate var movieFileoutput: AVCaptureMovieFileOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initUI()
        
        setupVideoInputOutput()
        setupAudioInputOutput()
        setupPreviewLayer()
//        setupMovieOutput() 
    }
    
}

extension DiscoverViewController {
    
    fileprivate func initUI() {
        
        let startButton = UIButton(type: .system)
        startButton.setTitle("开始", for: .normal)
        startButton.frame = CGRect(x: 30, y: 80, width: 120, height: 40)
        startButton.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
        view.addSubview(startButton)
        
        let stopButton = UIButton(type: .system)
        stopButton.frame = CGRect(x: startButton.frame.maxX + 30, y: 80, width: 120, height: 40)
        stopButton.addTarget(self, action: #selector(stopButtonClick), for: .touchUpInside)
        stopButton.setTitle("停止", for: .normal)
        view.addSubview(stopButton)
    }
}

extension DiscoverViewController {
    
    @objc fileprivate func startButtonClick() {
        // 开始采集
        print("开始采集")
        session.startRunning()
        movieFileoutput.startRecording(toOutputFileURL: URL(string: "http://192.168.31.147:8092"), recordingDelegate: self)
    }
    
    @objc fileprivate func stopButtonClick() {
        print("停止采集")
        session.stopRunning()
        movieFileoutput.stopRecording()
    }
    
}

extension DiscoverViewController {
    
    fileprivate func setupVideoInputOutput() {
        
        // 视频输入
        let device = AVCaptureDevice.defaultDevice(
            withDeviceType: AVCaptureDeviceType.builtInWideAngleCamera,
            mediaType: AVMediaTypeVideo,
            position: .front
        )
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        
        // 视频输出
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue.global())
        videoOutput = output
        
        addInputOutputToSession(input, output)

    }
    
    fileprivate func setupAudioInputOutput() {
        // 音频输入
        let device = AVCaptureDevice.defaultDevice(
            withDeviceType: AVCaptureDeviceType.builtInWideAngleCamera,
            mediaType: AVMediaTypeAudio,
            position: .front
        )
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        
        // 音频输出
        let output = AVCaptureAudioDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue.global())
        
        addInputOutputToSession(input, output)
    }
    
    fileprivate func addInputOutputToSession(_ input: AVCaptureInput, _ output: AVCaptureOutput) {
        
        session.beginConfiguration()
        if session.canAddInput(input) {
            session.addInput(input)
        }
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        session.commitConfiguration()
    }
    
    fileprivate func setupPreviewLayer() {
        
        guard let previewLayer = AVCaptureVideoPreviewLayer(session: session) else {return}
        previewLayer.frame = CGRect(x: 0, y: 150, width: Const.screenWidth, height: 500)
        previewLayer.backgroundColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(previewLayer)
    }
    
    fileprivate func setupMovieOutput() {
        
        movieFileoutput = AVCaptureMovieFileOutput()
        session.addOutput(movieFileoutput)
        let connection = movieFileoutput.connection(withMediaType: AVMediaTypeVideo)
        connection?.preferredVideoStabilizationMode = .auto
    }
    
}

extension DiscoverViewController: AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        if videoOutput.connection(withMediaType: AVMediaTypeVideo) == connection {
            print("采集视频数据")
        } else {
            print("采集音频数据")
        }
    }
}

extension DiscoverViewController: AVCaptureFileOutputRecordingDelegate {
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        print("开始录制")
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        print("停止录制")
    }
}

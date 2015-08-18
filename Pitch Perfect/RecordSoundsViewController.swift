//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Octavio Cedeno on 8/12/15.
//  Copyright © 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet var background: UIView!
    
    let recordColorRed: UIColor = UIColor(red: 0.992, green: 0, blue: 0, alpha: 1)
    let originalColorBlue: UIColor = UIColor(red: 0.0, green: 0.451, blue: 0.698, alpha: 1)
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        stopButton.hidden = true
        recordButton.enabled = true
        recordingLabel.text = "Tap to Record"
        background.backgroundColor = originalColorBlue
        
    }

    @IBAction func recordAudio(sender: UIButton) {
        
        recordingLabel.text = "Recording in Progress"
        background.backgroundColor = recordColorRed
        stopButton.hidden = false
        recordButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let recordingName = "my_aduio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        let session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)

        audioRecorder = AVAudioRecorder(URL: filePath!, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if(flag){
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent)
        
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            print("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "stopRecording") {
            let data = sender as! RecordedAudio
            let audioEffectsClass = AudioEffect()
            audioEffectsClass.receivedAudio = data
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            playSoundsVC.audioEffect = audioEffectsClass
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}


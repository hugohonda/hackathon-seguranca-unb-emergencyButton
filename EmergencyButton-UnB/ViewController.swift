import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var headphonePluggedInStateImageView: UIImageView!
    let deviceRequiredImage = "device_required"
    let headphonePluggedInMessage = "headphone_plugged_in"
    let headphonePulledOutMessage = "headphone_pulled_out"
    
    @IBOutlet weak var isConnectedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        
        if currentRoute.outputs.count != 0 {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSessionPortHeadphones {
                    isConnectedLabel.text = "plugado!"
                    print("headphone plugged in")
                } else {
                    isConnectedLabel.text = "desplugado!"
                    print("headphone pulled out")
                }
            }
        } else {
            isConnectedLabel.text = "requer conexão"
            print("requires connection to device")
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.audioRouteChangeListener(_:)),
            name: NSNotification.Name.AVAudioSessionRouteChange,
            object: nil)
    }
    
    dynamic fileprivate func audioRouteChangeListener(_ notification:Notification) {
        let audioRouteChangeReason = (notification as NSNotification).userInfo![AVAudioSessionRouteChangeReasonKey] as! UInt
        
        switch audioRouteChangeReason {
        case AVAudioSessionRouteChangeReason.newDeviceAvailable.rawValue:
            isConnectedLabel.text = "plugado!"
            print("headphone plugged in")
        case AVAudioSessionRouteChangeReason.oldDeviceUnavailable.rawValue:
            isConnectedLabel.text = "desplugado!"
            print("headphone pulled out")
        default:
            break
        }
    }
    
    
}


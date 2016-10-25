import UIKit
import AVFoundation
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var headphonePluggedInStateImageView: UIImageView!
    let deviceRequiredMessage = "device required"
    let headphonePluggedInMessage = "headphone in"
    let headphonePulledOutMessage = "headphone out"
    let requestMadeMessage = "requested made"
    @IBOutlet weak var isConnectedLabel: UILabel!
    
    let myURL = "https://hackathonseguranca.herokuapp.com/panicbutton"
    let myString = "swift funfou"
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        
        if currentRoute.outputs.count != 0 {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSessionPortHeadphones {
                    isConnectedLabel.text = "plugado!"
                    print(headphonePluggedInMessage)
                } else {
                    isConnectedLabel.text = "desplugado!"
                    print(headphonePulledOutMessage)
                    makeRequest()
                    print(requestMadeMessage)
                }
            }
        } else {
            isConnectedLabel.text = "requer conexão"
            print(deviceRequiredMessage)
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.audioRouteChangeListener(_:)),
            name: NSNotification.Name.AVAudioSessionRouteChange,
            object: nil)
    }
    
    func makeRequest() {
        var request = URLRequest(url: URL(string: myURL)!)
        request.httpMethod = "GET"
        request.httpBody = myString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request)
        task.resume()
    }
    
    dynamic fileprivate func audioRouteChangeListener(_ notification:Notification) {
        let audioRouteChangeReason = (notification as NSNotification).userInfo![AVAudioSessionRouteChangeReasonKey] as! UInt
        switch audioRouteChangeReason {
            case AVAudioSessionRouteChangeReason.newDeviceAvailable.rawValue:
                isConnectedLabel.text = "plugado!"
                print(headphonePluggedInMessage)
            case AVAudioSessionRouteChangeReason.oldDeviceUnavailable.rawValue:
                isConnectedLabel.text = "desplugado!"
                print(headphonePulledOutMessage)
            default:
                break
        }
    }
    
    
}


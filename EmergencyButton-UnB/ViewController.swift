import UIKit
import AVFoundation
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var headphonePluggedInStateImageView: UIImageView!
    @IBOutlet weak var isConnectedLabel: UILabel!
    
    @IBOutlet weak var stopTimerButton: UIButton!
    @IBOutlet var displayTimeLabel: UILabel!
    var startTime = TimeInterval()
    var timer:Timer = Timer()
    
    var flagSentMessage = false
    var canceledFlag = false
    var secondMarker = 0
    
    let deviceRequiredMessage = "device required"
    let headphonePluggedInMessage = "headphone in"
    let headphonePulledOutMessage = "headphone out"
    let requestMadeMessage = "requested made"
    let headphonePluggedInImage = UIImage(named: "01-allright")
    let headphonePulledOutImage = UIImage(named: "02-panic")
    
    let myURL = "https://hackathonseguranca.herokuapp.com/panicbutton"
    let myString = "swift funfou"
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayTimeLabel.isHidden = true;
        stopTimerButton.isHidden = true;
        
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        
        if currentRoute.outputs.count != 0 {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSessionPortHeadphones {
                    isConnectedLabel.text = "Fone conectado"
                    headphonePluggedInStateImageView.image = headphonePluggedInImage
                    print(headphonePluggedInMessage)
                } else {
                    isConnectedLabel.text = "Conecte um fone!"
                    headphonePluggedInStateImageView.image = headphonePulledOutImage
                    print(headphonePulledOutMessage)
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
                isConnectedLabel.text = "Plugado!"
                headphonePluggedInStateImageView.image = headphonePluggedInImage
                print(headphonePluggedInMessage)
            case AVAudioSessionRouteChangeReason.oldDeviceUnavailable.rawValue:
                isConnectedLabel.text = "Desplugado!"
                headphonePluggedInStateImageView.image = headphonePulledOutImage
                print(headphonePulledOutMessage)
                startStopWatch()
            default:
                break
        }
    }
    
    func startStopWatch(){
        displayTimeLabel.isHidden = false;
        stopTimerButton.isHidden = false;
        startTimer()
    }
    
    func startTimer() {
        if (!timer.isValid) {
            let aSelector : Selector = #selector(ViewController.updateTime)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
        }
    }
    
    @IBAction func stopTimer(_ sender: AnyObject) {
        if(canceledFlag){
            timer.invalidate()
            canceledFlag = false
            displayTimeLabel.text = "00:00:00"
            displayTimeLabel.isHidden = true
            stopTimerButton.setTitle("Desativar", for: UIControlState.normal )
            stopTimerButton.isHidden = true
            return
        }
        if(!flagSentMessage){
            timer.invalidate()
            displayTimeLabel.text = "CANCELADO!"
            canceledFlag = true
            stopTimerButton.isHidden = false
            stopTimerButton.setTitle("Retomar", for: UIControlState.normal )
        }
    }
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        var elapsedTime: TimeInterval = currentTime - startTime
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        let fraction = UInt8(elapsedTime * 100)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
        
        secondMarker = Int(seconds)
        
        if(secondMarker < 5){
            flagSentMessage = false
        }else{
            flagSentMessage = true
            displayTimeLabel.text = "PÂNICO!"
            stopTimerButton.isHidden = true
            timer.invalidate()
            makeRequest()
            print(requestMadeMessage)
        }
    }
    
    
}


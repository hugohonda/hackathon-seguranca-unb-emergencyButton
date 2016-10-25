import UIKit
import AVFoundation
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var headphonePluggedInStateImageView: UIImageView!
    @IBOutlet weak var isConnectedLabel: UILabel!
    
    @IBOutlet weak var stopWatchTimeLabel: UILabel!
    @IBOutlet weak var stopTimerButton: UIButton!
    
    
    let deviceRequiredMessage = "device required"
    let headphonePluggedInMessage = "headphone in"
    let headphonePulledOutMessage = "headphone out"
    let headphonePluggedInImage = UIImage(named: "01-allright")
    let headphonePulledOutImage = UIImage(named: "02-panic")
    let requestMadeMessage = "requested made"
    
    let myURL = "https://hackathonseguranca.herokuapp.com/panicbutton"
    let myString = "swift funfou"
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopWatchTimeLabel.isHidden = true;
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
    
    func startStopWatch(){
        stopWatchTimeLabel.isHidden = false;
        stopTimerButton.isHidden = false;
        startTimer()
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
                makeRequest()
                print(requestMadeMessage)
            default:
                break
        }
    }
    
    @IBOutlet var displayTimeLabel: UILabel!
    
    var startTime = TimeInterval()
    
    var timer:Timer = Timer()
    
    func startTimer() {
        if (!timer.isValid) {
            let aSelector : Selector = #selector(ViewController.updateTime)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
        }
    }
    
    @IBAction func stopTimer(_ sender: AnyObject) {
        timer.invalidate()
    }
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        
        //Find the difference between current time and start time.
        var elapsedTime: TimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
    }
    
    
}


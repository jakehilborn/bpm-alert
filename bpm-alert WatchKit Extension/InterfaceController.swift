import WatchKit
import Foundation
import HealthKit

class InterfaceController: WKInterfaceController, HKWorkoutSessionDelegate {
    let healthStore = HKHealthStore()
    var isRunning = false
    
    @IBOutlet var startStopButton: WKInterfaceButton!
    @IBAction func startStopButtonAction() {
        print("button action")
        if (self.isRunning) {
            print("stopping service")
            self.isRunning = false
            self.startStopButton.setTitle("start")
        } else {
            print("starting service")
            self.isRunning = true
            self.startStopButton.setTitle("stop")
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        switch toState {
        case .running:
            print("case running")
        case .ended:
            print("case ended")
        default:
            print("Unexpected state \(toState)")
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print("Workout error")
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        let types = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])

        healthStore.requestAuthorization(toShare: types, read: types) { (success, error) in //change toShare to nil?
            if !success {
                print("hk auth failure")
            } else {
                print("hk auth success")
            }
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}

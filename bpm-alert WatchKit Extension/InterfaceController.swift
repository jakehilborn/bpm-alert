import WatchKit
import Foundation
import HealthKit

class InterfaceController: WKInterfaceController {
    let healthStore = HKHealthStore()

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

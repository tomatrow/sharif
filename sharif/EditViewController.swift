//
//  EditViewController.swift
//  sharif
//
//  Created by AJ Caldwell on 5/29/18.
//  Copyright © 2018 optional(default). All rights reserved.
//

import Eureka
import UIKit

class EditViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        func singleDayInitializer(_ title: String) -> ((TimeInlineRow) -> Void) {
            return { (row: TimeInlineRow) -> Void in
                // see https://stackoverflow.com/a/26191260
                // more so see https://stackoverflow.com/a/20158940
                let date = Date()
                let cal = Calendar(identifier: .gregorian)
                let start = cal.startOfDay(for: date)
                var components = DateComponents()
                components.day = 1
                components.second = -1
                let end = cal.date(byAdding: components, to: start)

                // $0.dateFormatter =
                row.minimumDate = start
                row.maximumDate = end
                row.minuteInterval = 1
                row.noValueDisplayText = ""
                row.title = title
            }
        }

        form +++ Section("Shift")
            <<< TimeInlineRow("Start", singleDayInitializer("Start"))
            <<< TimeInlineRow("End", singleDayInitializer("End"))
            +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                                   header: "Break",
                                   footer: "A series of breaks lengths") {
                $0.addButtonProvider = { _ in
                    ButtonRow {
                        $0.title = "Add New Break"
                    }
                }
                $0.multivaluedRowToInsertAt = { _ in
                    IntRow {
                        $0.placeholder = "0"
                    }
                }
            }
            +++ Section("Task")
            <<< SwitchRow {
                $0.title = "quarter"
            }
            <<< SwitchRow {
                $0.title = "half"
            }
            <<< SwitchRow {
                $0.title = "full"
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

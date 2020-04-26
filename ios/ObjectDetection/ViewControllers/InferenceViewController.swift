// Copyright 2019 The TensorFlow Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

// MARK: InferenceViewControllerDelegate Method Declarations
protocol InferenceViewControllerDelegate {

  /**
   This method is called when the user changes the stepper value to update number of threads used for inference.
   */
  func didChangeThreadCount(to count: Int)
}

struct TableData {
    var name = String()
    var price = String()
    var cost = String()
    var total = String()
}

class InferenceViewController: UIViewController {

  // MARK: Sections and Information to display
  private enum InferenceSections: Int, CaseIterable {
    case InferenceInfo
  }

  private enum InferenceInfo: Int, CaseIterable {
    case Resolution
    case Crop
    case InferenceTime

    func displayString() -> String {

      var toReturn = ""

      switch self {
      case .Resolution:
        toReturn = "Resolution"
      case .Crop:
        toReturn = "Crop"
      case .InferenceTime:
        toReturn = "Inference Time"

      }
      return toReturn
    }
  }

  // MARK: Storyboard Outlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var threadStepper: UIStepper!
  @IBOutlet weak var stepperValueLabel: UILabel!

  // MARK: Constants
  private let normalCellHeight: CGFloat = 27.0
  private let separatorCellHeight: CGFloat = 42.0
  private let bottomSpacing: CGFloat = 21.0
  private let minThreadCount = 1
  private let bottomSheetButtonDisplayHeight: CGFloat = 60.0
  private let infoTextColor = UIColor.black
  private let lightTextInfoColor = UIColor(displayP3Red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0)
  private let infoFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
  private let highlightedFont = UIFont.systemFont(ofSize: 14.0, weight: .medium)

  // MARK: Instance Variables
  var inferenceTime: Double = 0
  var wantedInputWidth: Int = 0
  var wantedInputHeight: Int = 0
  var resolution: CGSize = CGSize.zero
  var threadCountLimit: Int = 0
  var currentThreadCount: Int = 0
    
    var data:[TableData] = []

  // MARK: Delegate
  var delegate: InferenceViewControllerDelegate?

  // MARK: Computed properties
  var collapsedHeight: CGFloat {
    return bottomSheetButtonDisplayHeight

  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Set up steppe

  }

  // MARK: Button Actions
  /**
   Delegate the change of number of threads to View Controller and change the stepper display.
   */

}

// MARK: UITableView Data Source
extension InferenceViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {

    return InferenceSections.allCases.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    var rowCount = data.count
//    guard let inferenceSection = InferenceSections(rawValue: section) else {
//      return 0
//    }
//
//    switch inferenceSection {
//    case .InferenceInfo:
//      rowCount = InferenceInfo.allCases.count
//    }
    return rowCount
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    var height: CGFloat = 30.0

//    guard let inferenceSection = InferenceSections(rawValue: indexPath.section) else {
//      return height
//    }

//    switch inferenceSection {
//    case .InferenceInfo:
//      if indexPath.row == InferenceInfo.allCases.count - 1 {
//        height = separatorCellHeight + bottomSpacing
//      }
//      else {
//        height = normalCellHeight
//      }
//    }
    return height
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "INFO_CELL") as! InfoCell

//    guard let inferenceSection = InferenceSections(rawValue: indexPath.section) else {
//      return cell
//    }
//
//    var fieldName = ""
//    var info = ""
//
//    switch inferenceSection {
//    case .InferenceInfo:
//      let tuple = displayStringsForInferenceInfo(atRow: indexPath.row)
//      fieldName = tuple.0
//      info = tuple.1
//
//    }
    let currData = data[indexPath.row]
    let info = "\(currData.price) + \(currData.cost) = $\(currData.total)"
    
    let range = (info as NSString).range(of: "\(currData.cost)")
    
    let attrTxt = NSMutableAttributedString.init(string: info)
    attrTxt.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)

    
    cell.fieldNameLabel.font = infoFont
    cell.fieldNameLabel.textColor = infoTextColor
    cell.fieldNameLabel.text = currData.name.uppercased()
    cell.infoLabel.attributedText = attrTxt
//    cell.accessoryType = .disclosureIndicator
    return cell
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableContains(msg: TableData) -> Bool {
        var i = 0
        for d in data {
            
            if (i == 4) {
                return false
            }
            
            i+=1
            
            if (d.name == msg.name) {
                return true
            }
        }
        return false
    }
    
    func addCell(msg: TableData) {
        if (tableContains(msg: msg)) {
            return
        }
        self.data.insert(msg, at: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }

  // MARK: Format Display of information in the bottom sheet
  /**
   This method formats the display of additional information relating to the inferences.
   */
  func displayStringsForInferenceInfo(atRow row: Int) -> (String, String) {

    var fieldName: String = ""
    var info: String = ""

    guard let inferenceInfo = InferenceInfo(rawValue: row) else {
      return (fieldName, info)
    }

    fieldName = inferenceInfo.displayString()

    switch inferenceInfo {
    case .Resolution:
      info = "\(Int(resolution.width))x\(Int(resolution.height))"
    case .Crop:
      info = "\(wantedInputWidth)x\(wantedInputHeight)"
    case .InferenceTime:

      info = String(format: "%.2fms", inferenceTime)
    }

    return(fieldName, info)
  }
}

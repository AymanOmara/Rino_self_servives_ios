//
//  ClearanceCollectionViewCell.swift
//  Rino
//
//  Created by Ayman Omara on 23/09/2021.
//

import UIKit

class ClearanceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var clearanceOrderDate: UILabel!
    @IBOutlet weak var clearanceNumber: UILabel!
    @IBOutlet weak var employeeNumber: UILabel!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var office: UILabel!
    @IBOutlet weak var orderKind: UILabel!
    @IBOutlet weak var procedure: UILabel!
    @IBOutlet weak var procedureContainer: UIView!
    @IBOutlet weak var forwardToHeaderClearance: UILabel!
    @IBOutlet weak var forwardContainer: UIView!
    @IBOutlet weak var forwardToContentClearance: UILabel!

    @IBOutlet weak var vacationView: UIView!
    
    @IBOutlet weak var startVacation: UILabel!
    @IBOutlet weak var endVacation: UILabel!
    @IBOutlet weak var plainLine: UIView!
}

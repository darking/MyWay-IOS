//
//  CLLocationSpeedExtension.swift
//  SwiftSideMenu
//
//  Created by trn22 on 10/1/15.
//
//

import Foundation
import CoreLocation

// Extension to CLLOcationSpeed to handle units
extension CLLocationSpeed
{
    var kph     : CDouble { return (self * 3.6) }
    var knots   : CDouble { return (self * 1.943_844) }
    var fts     : CDouble { return (self * 3.280_840) }
    var mph     : CDouble { return (self * 2.236_936) }
};
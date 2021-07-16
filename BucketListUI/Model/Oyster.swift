//
//  File.swift
//  BucketListUI
//
//  Created by Максим Нуждин on 13.07.2021.
//

import SwiftUI
import MapKit

struct Oyster {
    
    let title: String
    let subtitle: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, description: String, coordinates: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = description
        self.coordinate = coordinates
    }
    
    func make() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = coordinate
        return annotation
    }
}

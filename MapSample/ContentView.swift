//
//  ContentView.swift
//  MapSample
//
//  Created by 阿部紘明 on 2023/11/08.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
  static let parking = CLLocationCoordinate2D(latitude: 43.09476428626934, longitude: 141.27504567435153)
}

struct ContentView: View {
  var body: some View {
    MapReader { proxy in
      Map(interactionModes: .rotate) {
        Marker("Parking", coordinate: .parking)
//        Annotation("test", coordinate: .parking) {
//          Text("Parking")
//        }
      }
      .onTapGesture { screenPoint in
        guard let location = proxy.convert(screenPoint, from: .local) else {
          return
        }
        print("Tapped at \(location)")
      }
      .gesture(DragGesture().onChanged({ value in
        print("Draggd to \(value.location)")
      }))
    }
  }
}

#Preview {
  ContentView()
}

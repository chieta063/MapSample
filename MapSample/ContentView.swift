//
//  ContentView.swift
//  MapSample
//
//  Created by 阿部紘明 on 2023/11/08.
//

import MapKit
import SwiftUI

extension CLLocationCoordinate2D {
  static let parking = CLLocationCoordinate2D(latitude: 43.09476428626934, longitude: 141.27504567435153)
}

enum MapMode {
  case normal
  case drag
}

struct ContentView: View {
  @State var currentMode: MapMode = .normal
  @State var location: CLLocationCoordinate2D = .parking
  
  var body: some View {
    MapReader { proxy in
      Map(interactionModes: currentMode == .normal ? .all : .pitch) {
        Annotation(coordinate: location) {
          Image(systemName: "mappin")
            .foregroundStyle(currentMode == .normal ? .red : .green)
            .onLongPressGesture {
              print("Long Tap")
              switch currentMode {
              case .normal:
                currentMode = .drag
              case .drag:
                currentMode = .normal
              }
            }
            .gesture(DragGesture().onChanged({ value in
              guard let location = proxy.convert(value.location, from: .global) else {
                return
              }
              print(location)
              self.location = location
            }))
        } label: {
          
        }
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
      .gesture(DragGesture().onChanged { value in
//        print("Draggd to \(value.location)")
        guard let location = proxy.convert(value.location, from: .local) else {
          return
        }
        self.location = location
      })
    }
  }
}

#Preview {
  ContentView()
}

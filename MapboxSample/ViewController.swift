//
//  ViewController.swift
//  MapboxSample
//
//  Created by Phanith Ny on 1/9/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {

    var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupMapView()
        setupLocationButton()
    }
    

    fileprivate func setupMapView(){
        let mapViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let mapViewStyleURL = URL(string: "mapbox://styles/mapbox/streets-v10")
        mapView = MGLMapView(frame: mapViewFrame, styleURL: mapViewStyleURL)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.showsUserLocation = true
        let center = CLLocationCoordinate2D(latitude: 11.568563, longitude: 104.888302)
        mapView.setCenter(center, zoomLevel: 7, direction: 0, animated: false)
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    fileprivate func setupLocationButton(){
        let button = UIButton(type: .system)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc func handleTap(){
        if let location = mapView.userLocation?.coordinate {
            let camera = MGLMapCamera(lookingAtCenter: location, fromDistance: 1000, pitch: 0, heading: 0)
            mapView.setCamera(camera, withDuration: 1, animationTimingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        }
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        
        if let location = mapView.userLocation?.coordinate {
            let camera = MGLMapCamera(lookingAtCenter: location, fromDistance: 4500, pitch: 10, heading: 0)
            mapView.setCamera(camera, withDuration: 1, animationTimingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
        }
    }
}


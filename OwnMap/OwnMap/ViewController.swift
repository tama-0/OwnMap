//
//  ViewController.swift
//  OwnMap
//
//  Created by 玉川悠真 on 2021/05/18.
//  Copyright © 2021年 玉川悠真. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputText.delegate = self
        
        /*// マップビュー張り付け
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            ])*/
        
        mapView.delegate = self
        // 緯度・軽度を設定
        let location:CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(35.68154,139.752498)
        
        mapView.setCenter(location,animated:true)
        
        // 縮尺を設定
        var scale:MKCoordinateRegion = mapView.region
        scale.center = location
        scale.span.latitudeDelta = 0.02
        scale.span.longitudeDelta = 0.02
        
        mapView.setRegion(region,animated:true)
        
        // 表示タイプを航空写真と地図のハイブリッドに設定
        mapView.mapType = MKMapType.hybrid
        //mapView.mapType = MKMapType.standard
        
        // ピンを生成
        let pin = MKPointAnnotation()
        // ピンのタイトル・サブタイトルをセット
        pin.title = "タイトル"
        pin.subtitle = "サブタイトル"
        // ピンに一番上で作った位置情報をセット
        pin.coordinate = location
        // mapにピンを表示する
        mapView.addAnnotation(pin)
        
    
    
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // タップされたピンの位置情報
        print(view.annotation?.coordinate)
        // タップされたピンのタイトルとサブタイトル
        print(view.annotation?.title)
        print(view.annotation?.subtitle)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let searchKey = textField.text {
            
            print(searchKey)
            
            
        }
        return true
    }
    
    
    
    let coordinate = CLLocationCoordinate2DMake(35.6598051, 139.7036661) // 渋谷ヒカリエ
    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000.0, longitudinalMeters: 1000.0) // 1km * 1km
    
    Map.search(query: "コンビニ", region: region) { (result) in
    switch result {
    case .success(let mapItems):
    for map in mapItems {
    print("name: \(map.name ?? "no name")")
    print("coordinate: \(map.placemark.coordinate.latitude) \(map.placemark.coordinate.latitude)")
    print("address \(map.placemark.address)")
    }
    case .failure(let error):
    print("error \(error.localizedDescription)")
    }
    }


}

extension MKPlacemark {
    var address: String {
        let components = [self.administrativeArea, self.locality, self.thoroughfare, self.subThoroughfare]
        return components.compactMap { $0 }.joined(separator: "")
    }
}

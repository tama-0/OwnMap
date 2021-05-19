//
//  ViewController.swift
//  OwnMap
//
//  Created by 玉川悠真 on 2021/05/18.
//  Copyright © 2021年 玉川悠真. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    @IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // マップビュー張り付け
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            ])
        
        mapView.delegate = self
        // 緯度・軽度を設定
        let location:CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(35.68154,139.752498)
        
        mapView.setCenter(location,animated:true)
        
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        
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
        
        mapView.delegate = self
    
    
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // タップされたピンの位置情報
        print(view.annotation?.coordinate)
        // タップされたピンのタイトルとサブタイトル
        print(view.annotation?.title)
        print(view.annotation?.subtitle)
    }
}

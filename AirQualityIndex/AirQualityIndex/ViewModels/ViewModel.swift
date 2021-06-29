//
//  ViewModel.swift
//  AirQualityIndex
//
//  Created by Mollick, Tapash on 19/06/21.
//

import ObjectMapper
import Starscream

class ViewModel {
    
    var netWorkd = Network()
    private(set) public var dataSource: [String: City] = [ : ] {
        didSet {
            self.bindDataToController()
        }
    }
    
    var bindDataToController: (() -> ()) = {}
    
    func numberOfSection() -> Int {
        guard dataSource.count != 0 else {
            return 0
        }
        return dataSource.count
    }
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    func item(for section: Int) -> City? {
        let index = dataSource.index(dataSource.startIndex, offsetBy: section)
        
        guard dataSource.count != 0, let key = dataSource.keys[index] as? String else {
            return nil
        }
        return dataSource[key]
    }
    
    func loadData(completion: () -> Void) {
        self.prepareModel()
        netWorkd.load { (result) in
            switch result {
                case .success( _) :
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
            }
        }
    }
    
    func prepareModel(){
        netWorkd.bindDataToViewModel = {
            guard self.dataSource.count != 0 else {
                self.dataSource = $0.toDictionary { ($0.city!) }
                return
            }
            let dict = $0.toDictionary { $0.city! }
            self.dataSource.merge(dict) {(_, new) in new}
            debugPrint("self.dataSource: \(self.dataSource)")
        }
    }
        
    func latestData(cities: [City]) -> City? {
        var mostRecent = cities.reduce(cities[0], { $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970 ? $0 : $1 } )
        return mostRecent
    }

}


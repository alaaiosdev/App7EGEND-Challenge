//
//  TripsViewModel.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 30/10/2021.
//

import Foundation

struct TripsViewModel {
    
    //MARK: - Vars
    private let trips: TripsModel? = {
        do {
            return try MockLoader.loadMockFile(named: "trips.json", bundle: .main)
        }catch let e as MockLoaderError {
            debugPrint(e.description)
        }catch{
            debugPrint("could not read Mock json file :(")
        }
        return nil
    }()
    
    internal func getTrips() -> TripsModel? {
        return trips
    }
    
    internal func numberOfRowsInSection(_ section:Int) -> Int {
        if let count = trips?.count {
            return count
        }
        return 0
    }
    
    internal func cellForRowAt(indexPath:IndexPath) -> TripItemModel? {
        return trips?.trips?[indexPath.row]
    }
}

//
//  TripDetailsViewModel.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 07/11/2021.
//

import Foundation

struct TripDetailsViewModel {
    
    //MARK: - Vars
    internal var tripDescription: TripDescriptionModel?
    internal var backgroundImage: String?
        
    internal func numberOfRowsInSection(_ section:Int) -> Int {
        return 1
    }
}

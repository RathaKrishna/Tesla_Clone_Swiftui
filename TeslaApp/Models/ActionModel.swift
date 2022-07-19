//
//  ActionModel.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 16/07/22.
//

import Foundation

struct ActionModel: Hashable {
    var icon: String
    var text: String
}

let quickShortcuts: [ActionModel] = [
    ActionModel(icon: "bolt.fill", text: "Charging"),
    ActionModel(icon: "fanblades.fill", text: "Fan On"),
    ActionModel(icon: "music.note.list", text: "Media Controls"),
    ActionModel(icon: "bolt.car", text: "Close Charge Port")
]

let recentItems: [ActionModel] = [
    ActionModel(icon: "arrow.up.square", text: "Open Trunk"),
    ActionModel(icon: "fanblades", text: "Fan Off"),
    ActionModel(icon: "person.fill.viewfinder", text: "Summon")
]

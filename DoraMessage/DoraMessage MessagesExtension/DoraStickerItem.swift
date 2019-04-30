//
//  DoraStickerItem.swift
//  DoraMessage MessagesExtension
//
//  Created by Song Zixin on 2019/5/1.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit
import Messages

extension MSSticker {
    convenience init(item: String) throws {
        try self.init(
            contentsOfFileURL:
            Bundle.main.url(forResource: item,
                            withExtension: "png")!,
            localizedDescription: "")
    }
}

//
//  Layout.swift
//  NapMonitor
//
//  Created by Arwin Krishnan on 07/04/2020.
//  Copyright © 2020 Arwin Krishnan. All rights reserved.
//

import SwiftUI

struct Layout: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

   var body: some View {
    if horizontalSizeClass == .compact {
        return Text("Compact")
    } else {
        return Text("Regular")
    }
    }
}

struct Layout_Previews: PreviewProvider {
    static var previews: some View {
        Layout()
    }
}

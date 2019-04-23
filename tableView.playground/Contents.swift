import UIKit

class ListCell {
    func draw() {
        print("I'm a list cell.")
        
    }
    
}

class CustomListCell: ListCell {
    override func draw() {
        print("I'm a custom list cell")
    }
}



class ListTable {
    
    weak var dataSource: ListTableDataSource?
    weak var delegate: ListTableDelegate?
    
    func draw() {
        if dataSource != nil {
            for r in 1...self.dataSource!.numberOfRows(self) {
                let listCell = dataSource!.cellForRowAtIndex(self, index: r)
                listCell.draw()
            }
        }
    }
    
    func triggerCellSelection(at index: Int) {
        if delegate != nil {
            delegate?.didSelectRowAtIndex(self, index: index)
        }
    }
    
}

//提供ListTable属性" 这件事外包给了 protocol
protocol ListTableDataSource: AnyObject {
    func numberOfRows(_ listTable: ListTable) -> Int
    func cellForRowAtIndex(_ listTable: ListTable, index: Int) -> ListCell
    
}

protocol ListTableDelegate: AnyObject {
    func didSelectRowAtIndex(_ listTable: ListTable, index: Int)
    
}


class ListTableController: ListTableDataSource, ListTableDelegate {
    var listTable: ListTable!
    
    init() {
        listTable = ListTable()
    }
    
    func listWillDisplay() {
        listTable.dataSource = self
        listTable.delegate = self
    }
    
    func numberOfRows(_ listTable: ListTable) -> Int {
        return 10
    }
    
    func cellForRowAtIndex(_ listTable: ListTable, index: Int) -> ListCell {
        if index % 2 == 0 {
            return CustomListCell()
        } else {
            return ListCell()
        }
    }
    
    func didSelectRowAtIndex(_ listTable: ListTable, index: Int) {
        let cell = self.cellForRowAtIndex(listTable, index: index)
        print("\(type(of: cell)) \(index) is selected.")
    }
}


var listTableController = ListTableController()
listTableController.listWillDisplay()

listTableController.listTable.draw()
listTableController.listTable.triggerCellSelection(at: 2)



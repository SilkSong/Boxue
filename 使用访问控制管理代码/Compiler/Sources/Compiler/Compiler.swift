open class Compiler {
    
    private class Log {
        static func into() { }
    }
    fileprivate var sourceFiles: [String]
    
    public init(_ sourceFiles: [String]) {
        self.sourceFiles = sourceFiles
        print("Compiler initiated")
    }
    
    public func build() {
        sourceFiles.forEach {
            //Phase 1
            Compiler(filePath: $0)
            Log.info("\($0) compile finished")
            
            //Phase 2
            assembile(filePath: $0)
            Log.info("\($0) assemble finished")
        }
        
        //Phase 3
        link()
        Log.info("Link finished")
    }
    
    open func compile(filePath: String) { }
    open func assembile(filePath: String) { }
    
    open func link() { }
}

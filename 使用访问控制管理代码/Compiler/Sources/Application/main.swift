import Compiler

class MyCompiler: Compiler {
    public override init(_ sourceFiles: [String]) {
        super.init(sourceFiles)
        print("MyCompiler initiated")
    }
}

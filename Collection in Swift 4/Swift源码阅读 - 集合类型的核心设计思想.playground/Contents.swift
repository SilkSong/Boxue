import UIKit

var array = [0, 1, 2, 3, 4]
var sum = array.reduce(0, +)

func reduce1<U,V>(of sequence: U, _ partial: (V,V) -> V) -> V?
    where U: Sequence, V == U.Element {
        var iter = sequence.makeIterator()
        guard var accumulated = iter.next() else {
            return nil
        }
        while let element = iter.next() {
            accumulated = partial(accumulated,element)
        }
        return accumulated
}

var sum1 = reduce1(of: array, +)
print(sum1)
